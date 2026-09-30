// nacita startup.sql, zobrazi ho a z INSERT-ov spravi karticky inzeratov

const stlpce = ['id', 'pozicia', 'firma', 'mesto', 'seniorita', 'plat_od', 'plat_do',
                'technologie', 'datum_zverejnenia', 'remote'];

let inzeraty = [];

// rozdeli "(1, N'text', 1400, '2026-09-02', 0)" na hodnoty
function rozdelHodnoty(riadok) {
  const hodnoty = [];
  let i = 0;
  while (i < riadok.length) {
    const c = riadok[i];
    if (c === ' ' || c === ',' || c === '\n' || c === '\r' || c === '\t') { i++; continue; }
    if (c === 'N' && riadok[i + 1] === "'") { i++; continue; }
    if (c === "'") {
      let text = '';
      i++;
      while (i < riadok.length) {
        if (riadok[i] === "'" && riadok[i + 1] === "'") { text += "'"; i += 2; continue; }
        if (riadok[i] === "'") { i++; break; }
        text += riadok[i++];
      }
      hodnoty.push(text);
    } else {
      let slovo = '';
      while (i < riadok.length && riadok[i] !== ',') slovo += riadok[i++];
      slovo = slovo.trim();
      hodnoty.push(slovo.toUpperCase() === 'NULL' ? null : Number(slovo));
    }
  }
  return hodnoty;
}

function nacitajInzeraty(sql) {
  // odstranenie komentarov
  const bezKomentarov = sql.replace(/--.*$/gm, '');
  const vysledok = [];
  const bloky = bezKomentarov.match(/INSERT\s+INTO\s+inzerat\s+VALUES([\s\S]*?);/gi) || [];
  for (const blok of bloky) {
    const riadky = blok.match(/\((?:[^()']|'(?:[^']|'')*')*\)/g) || [];
    for (const r of riadky) {
      const h = rozdelHodnoty(r.slice(1, -1));
      if (h.length !== stlpce.length) continue;
      const o = {};
      stlpce.forEach((s, idx) => o[s] = h[idx]);
      vysledok.push(o);
    }
  }
  return vysledok;
}

function formatEur(n) {
  if (n === null || n === undefined || isNaN(n)) return '?';
  return n.toLocaleString('sk-SK') + ' €';
}

function formatDatum(d) {
  if (!d) return '';
  const [r, m, den] = d.split('-');
  return `${Number(den)}. ${Number(m)}. ${r}`;
}

function vykresli() {
  const hladaj = document.getElementById('f-hladaj').value.trim().toLowerCase();
  const mesto = document.getElementById('f-mesto').value;
  const seniorita = document.getElementById('f-seniorita').value;
  const lenRemote = document.getElementById('f-remote').checked;

  const filtrovane = inzeraty.filter(i =>
    (!hladaj || (i.pozicia + ' ' + i.technologie + ' ' + i.firma).toLowerCase().includes(hladaj)) &&
    (!mesto || i.mesto === mesto) &&
    (!seniorita || i.seniorita === seniorita) &&
    (!lenRemote || i.remote === 1)
  );

  const zoznam = document.getElementById('zoznam');
  zoznam.innerHTML = '';
  for (const i of filtrovane) {
    const karta = document.createElement('article');
    karta.className = 'card';
    const tagy = (i.technologie || '').split(',').map(t => t.trim()).filter(Boolean)
      .map(t => `<span class="tag">${t}</span>`).join('');
    karta.innerHTML = `
      <div class="card-head">
        <h3>${i.pozicia}</h3>
        <span class="badge">${i.seniorita || ''}</span>
      </div>
      <p class="firma">${i.firma} · ${i.mesto}${i.remote === 1 ? ' · <span class="remote">remote</span>' : ''}</p>
      <p class="plat">${formatEur(i.plat_od)} – ${formatEur(i.plat_do)}</p>
      <div class="tags">${tagy}</div>
      <p class="datum">zverejnené ${formatDatum(i.datum_zverejnenia)}</p>
    `;
    zoznam.appendChild(karta);
  }
  document.getElementById('prazdne').hidden = filtrovane.length > 0;
}

function naplnSelect(id, hodnoty) {
  const sel = document.getElementById(id);
  [...new Set(hodnoty.filter(Boolean))].sort().forEach(v => {
    const o = document.createElement('option');
    o.value = v;
    o.textContent = v;
    sel.appendChild(o);
  });
}

function statistiky() {
  document.getElementById('stat-pocet').textContent = inzeraty.length;
  const platy = inzeraty.map(i => i.plat_od).filter(p => typeof p === 'number' && !isNaN(p));
  const priemer = platy.length ? Math.round(platy.reduce((a, b) => a + b, 0) / platy.length) : null;
  document.getElementById('stat-plat').textContent = priemer ? formatEur(priemer) : '–';
  document.getElementById('stat-remote').textContent = inzeraty.filter(i => i.remote === 1).length;
}

fetch('startup.sql')
  .then(r => r.text())
  .then(sql => {
    document.getElementById('sql').textContent = sql;
    inzeraty = nacitajInzeraty(sql);
    naplnSelect('f-mesto', inzeraty.map(i => i.mesto));
    naplnSelect('f-seniorita', inzeraty.map(i => i.seniorita));
    statistiky();
    vykresli();
  })
  .catch(() => {
    document.getElementById('sql').textContent = 'Skript sa nepodarilo načítať.';
    document.getElementById('prazdne').hidden = false;
  });

['f-hladaj', 'f-mesto', 'f-seniorita', 'f-remote'].forEach(id =>
  document.getElementById(id).addEventListener('input', vykresli));

(()=>{
  const style=document.createElement('style');
  style.textContent=`
body[data-theme="pro-midnight"]{--bg:#0b1020;--p:#11192d;--p2:#17223a;--txt:#f5f7fb;--mut:#91a0b8;--a:#8b7cf6;--a2:#5bc0eb;--ok:#45d49c;--warn:#f2c14e;--bd:#263552}
body[data-theme="slate"]{--bg:#11151b;--p:#191f27;--p2:#232b35;--txt:#f5f7fb;--mut:#9cacbe;--a:#69a7ff;--a2:#7bdff2;--ok:#5dd39e;--warn:#f3ca62;--bd:#34404e}
body[data-theme="forest"]{--bg:#0c1512;--p:#12211b;--p2:#1a3027;--txt:#effbf6;--mut:#95b5a8;--a:#53d18f;--a2:#8be8bb;--ok:#5dd39e;--warn:#f3ca62;--bd:#294a3c}
body[data-theme="pro-midnight"]{background:radial-gradient(circle at 30% -10%,color-mix(in srgb,var(--a) 22%,transparent),transparent 34%),linear-gradient(180deg,var(--p2),var(--bg) 23%)}
#quickTheme{min-width:92px}.repairRow,.evidenceRow{display:flex;gap:8px;align-items:flex-start;padding:9px 0;border-bottom:1px solid var(--bd)}.repairRow:last-child,.evidenceRow:last-child{border-bottom:0}.vaultForm{display:grid;grid-template-columns:1fr 1fr;gap:8px}.vaultForm .wide{grid-column:1/-1}.strength{width:145px}@media(max-width:560px){#quickTheme{flex:1}.vaultForm{grid-template-columns:1fr}.vaultForm .wide{grid-column:auto}}
`;
  document.head.appendChild(style);

  const sel=document.getElementById('theme');
  const options=[['pro-midnight','Pro Midnight'],['slate','Slate'],['forest','Forest']];
  if(sel) options.forEach(([v,t])=>{if(![...sel.options].some(o=>o.value===v)){const o=document.createElement('option');o.value=v;o.textContent=t;sel.appendChild(o)}});
  const themes=['pro-midnight','slate','forest','warm','focus','dark'];
  const names={'pro-midnight':'Pro Midnight',slate:'Slate',forest:'Forest',warm:'Warm',focus:'Focus Green',dark:'Dark'};
  const host=document.querySelector('.top .row');
  let btn=document.getElementById('quickTheme');
  if(host&&!btn){btn=document.createElement('button');btn.className='btn';btn.id='quickTheme';host.insertBefore(btn,host.firstChild)}
  function label(){if(btn){const t=(typeof D!=='undefined'&&D.theme)||document.body.dataset.theme||'dark';btn.textContent=`Theme: ${names[t]||t}`}}
  btn?.addEventListener('click',()=>{const cur=D.theme||'dark',next=themes[(themes.indexOf(cur)+1)%themes.length];D.theme=next;save();render();if(sel)sel.value=next;label()});
  document.getElementById('settings')?.addEventListener('click',()=>{if(sel)sel.value=D.theme||'dark'});
  document.getElementById('saveSettings')?.addEventListener('click',()=>setTimeout(label,0));

  function ensureExtras(){if(!Array.isArray(D.errors))D.errors=[];if(!Array.isArray(D.evidence))D.evidence=[]}
  ensureExtras();

  const main=document.querySelector('main');
  const notesCard=document.getElementById('notes')?.closest('.card');
  const repairCard=document.createElement('section');repairCard.className='card';repairCard.innerHTML=`
    <div class="row space"><div><div class="kick">Error & repair center</div><h2>Weakness → repair → fresh retest</h2></div><span class="pill" id="osOpenErrors">0 open</span></div>
    <div class="vaultForm">
      <input id="osErrSkill" placeholder="Lesson / skill (example SQL JOIN)">
      <input id="osErrIssue" placeholder="What went wrong?">
      <input class="wide" id="osErrRepair" placeholder="Repair plan (default: targeted relearn → fresh task)">
      <button class="btn primary" id="osAddError">+ Add weakness</button>
    </div><div id="osErrors"></div>`;
  if(main&&notesCard)main.insertBefore(repairCard,notesCard);

  const aside=document.querySelector('aside');
  const dataSafety=[...document.querySelectorAll('aside .card')].find(x=>x.textContent.includes('Data safety'));
  const evidenceCard=document.createElement('section');evidenceCard.className='card';evidenceCard.innerHTML=`
    <div class="row space"><div><div class="kick">Career evidence vault</div><h2>Save proof, not private data</h2></div><span class="pill" id="osEvidenceCount">0 saved</span></div>
    <div class="call warn">Use only sanitized evidence. Never store employer/customer names, credentials, confidential datasets, proprietary code or internal documents.</div>
    <div class="vaultForm" style="margin-top:9px">
      <input id="osEvSkill" placeholder="Skill / competency">
      <select id="osEvStrength" class="strength"><option value="1">1 — Course evidence</option><option value="2">2 — Independent project</option><option value="3">3 — Sanitized workplace evidence</option><option value="4">4 — Repeated ownership</option></select>
      <textarea class="wide" id="osEvAction" placeholder="Sanitized situation + what you did + result / learning"></textarea>
      <button class="btn primary" id="osAddEvidence">Save evidence</button><button class="btn" id="osEvidenceCsv">Export evidence CSV</button>
    </div><div id="osEvidence"></div>`;
  if(aside&&dataSafety)aside.insertBefore(evidenceCard,dataSafety);

  function renderErrors(){ensureExtras();const box=document.getElementById('osErrors');if(!box)return;document.getElementById('osOpenErrors').textContent=`${D.errors.filter(e=>!e.done).length} open`;box.innerHTML=D.errors.length?D.errors.map((e,i)=>`<div class="repairRow ${e.done?'done':''}"><div class="grow"><b>${esc(e.skill)}</b><div class="small">${esc(e.issue)}</div><div class="small">Repair: ${esc(e.repair||'Targeted relearn → fresh task')}</div></div><button class="btn" data-osfix="${i}">${e.done?'Reopen':'Mastered'}</button><button class="btn ghost" data-osdelerr="${i}">×</button></div>`).join(''):'<div class="small" style="margin-top:9px">No recorded weaknesses. Add one when practice or a Gate exposes a recurring mistake.</div>';document.querySelectorAll('[data-osfix]').forEach(b=>b.onclick=()=>{D.errors[+b.dataset.osfix].done=!D.errors[+b.dataset.osfix].done;save();renderErrors()});document.querySelectorAll('[data-osdelerr]').forEach(b=>b.onclick=()=>{D.errors.splice(+b.dataset.osdelerr,1);save();renderErrors()})}
  function renderEvidence(){ensureExtras();const box=document.getElementById('osEvidence');if(!box)return;document.getElementById('osEvidenceCount').textContent=`${D.evidence.length} saved`;box.innerHTML=D.evidence.length?D.evidence.slice().reverse().map((e,ri)=>{const i=D.evidence.length-1-ri;return `<div class="evidenceRow"><div class="grow"><b>${esc(e.skill)}</b><div class="small">${esc(e.action)}</div><span class="pill">Strength ${e.strength}/4</span> <span class="pill">${esc(e.date||'')}</span></div><button class="btn ghost" data-osdelev="${i}">×</button></div>`}).join(''):'<div class="small" style="margin-top:9px">No career evidence saved yet. Course projects count when labeled honestly.</div>';document.querySelectorAll('[data-osdelev]').forEach(b=>b.onclick=()=>{D.evidence.splice(+b.dataset.osdelev,1);save();renderEvidence()})}

  document.getElementById('osAddError')?.addEventListener('click',()=>{const skill=document.getElementById('osErrSkill').value.trim(),issue=document.getElementById('osErrIssue').value.trim();if(!skill||!issue)return alert('Add the skill and what went wrong.');D.errors.push({skill,issue,repair:document.getElementById('osErrRepair').value.trim()||'Targeted relearn → fresh task',done:false,date:today()});document.getElementById('osErrSkill').value='';document.getElementById('osErrIssue').value='';document.getElementById('osErrRepair').value='';save();renderErrors()});
  document.getElementById('osAddEvidence')?.addEventListener('click',()=>{const skill=document.getElementById('osEvSkill').value.trim(),action=document.getElementById('osEvAction').value.trim();if(!skill||!action)return alert('Add a skill and sanitized evidence.');D.evidence.push({skill,action,strength:+document.getElementById('osEvStrength').value||1,date:today()});document.getElementById('osEvSkill').value='';document.getElementById('osEvAction').value='';save();renderEvidence()});
  document.getElementById('osEvidenceCsv')?.addEventListener('click',()=>{const q=x=>`"${String(x??'').replace(/"/g,'""')}"`,rows=[['Date','Skill','Strength','Sanitized evidence'],...D.evidence.map(e=>[e.date,e.skill,e.strength,e.action])],text=rows.map(r=>r.map(q).join(',')).join('\n');download(`da-mentor-os-evidence-${today()}.csv`,text,'text/csv')});

  const baseRender=render;
  render=function(){baseRender();ensureExtras();renderErrors();renderEvidence();label()};
  const footer=document.querySelector('.footer');if(footer)footer.textContent='DA Mentor OS v4.2 • repair center + evidence vault + visible themes • final master curriculum • offline-first • local progress + backup/restore • reports + mentor guidance';
  render();
})();
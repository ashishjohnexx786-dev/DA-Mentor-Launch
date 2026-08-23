document.addEventListener('DOMContentLoaded',()=>{
  const style=document.createElement('style');
  style.textContent=`
body[data-theme="amoled"]{--bg:#000;--p:#050505;--p2:#0b0b0b;--txt:#f3f4f6;--mut:#969ca5;--a:#c57b72;--a2:#aab3bd;--ok:#78a58d;--warn:#b89a63;--bd:#202226;--shadow:0 8px 24px rgba(0,0,0,.32)}
body[data-theme="midnight"]{--bg:#080a10;--p:#0f121a;--p2:#151925;--txt:#f1f3f7;--mut:#979eaa;--a:#8d86bd;--a2:#8fa5bc;--ok:#75a68d;--warn:#b8a06c;--bd:#252a35;--shadow:0 8px 24px rgba(0,0,0,.28)}
body[data-theme="slate"]{--bg:#0c0f13;--p:#13171c;--p2:#1a2027;--txt:#f0f2f5;--mut:#98a2ad;--a:#8099b2;--a2:#9aa8b6;--ok:#789f89;--warn:#b19a6d;--bd:#2a3139;--shadow:0 8px 24px rgba(0,0,0,.26)}
body[data-theme="forest"]{--bg:#080d0b;--p:#0e1512;--p2:#151e1a;--txt:#eff4f1;--mut:#91a098;--a:#709a82;--a2:#8ca99a;--ok:#7eaa91;--warn:#ad9a6a;--bd:#25332c;--shadow:0 8px 24px rgba(0,0,0,.28)}
body[data-theme="ocean"]{--bg:#070c10;--p:#0d1419;--p2:#141d24;--txt:#eff3f5;--mut:#91a0aa;--a:#6f95a4;--a2:#8ba8b3;--ok:#789e8d;--warn:#aa996f;--bd:#25323a;--shadow:0 8px 24px rgba(0,0,0,.28)}
body[data-theme="ember"]{--bg:#0d0907;--p:#15100d;--p2:#1e1713;--txt:#f4f0ed;--mut:#a09289;--a:#a97967;--a2:#b59686;--ok:#7e9f88;--warn:#b39a69;--bd:#342921;--shadow:0 8px 24px rgba(0,0,0,.28)}
body[data-theme="graphite"]{--bg:#090a0c;--p:#111316;--p2:#191c20;--txt:#f1f2f3;--mut:#999da4;--a:#8f969f;--a2:#a8adb4;--ok:#7d9888;--warn:#a99876;--bd:#2b2e33;--shadow:0 8px 24px rgba(0,0,0,.28)}
body[data-theme="dark"]{--bg:#080a10;--p:#0f121a;--p2:#151925;--txt:#f1f3f7;--mut:#979eaa;--a:#8d86bd;--a2:#8fa5bc;--ok:#75a68d;--warn:#b8a06c;--bd:#252a35;--shadow:0 8px 24px rgba(0,0,0,.28)}
body[data-theme="pro-midnight"]{--bg:#080a10;--p:#0f121a;--p2:#151925;--txt:#f1f3f7;--mut:#979eaa;--a:#8d86bd;--a2:#8fa5bc;--ok:#75a68d;--warn:#b8a06c;--bd:#252a35;--shadow:0 8px 24px rgba(0,0,0,.28)}
body[data-theme="warm"]{--bg:#0d0907;--p:#15100d;--p2:#1e1713;--txt:#f4f0ed;--mut:#a09289;--a:#a97967;--a2:#b59686;--ok:#7e9f88;--warn:#b39a69;--bd:#342921;--shadow:0 8px 24px rgba(0,0,0,.28)}
body[data-theme="focus"]{--bg:#080d0b;--p:#0e1512;--p2:#151e1a;--txt:#eff4f1;--mut:#91a098;--a:#709a82;--a2:#8ca99a;--ok:#7eaa91;--warn:#ad9a6a;--bd:#25332c;--shadow:0 8px 24px rgba(0,0,0,.28)}
body.mentor-modern{background:var(--bg)!important}
.mentor-modern .card{background:var(--p);box-shadow:0 8px 24px rgba(0,0,0,.22),inset 0 1px 0 rgba(255,255,255,.025);transform:translateZ(0);transition:transform .18s ease,box-shadow .18s ease,border-color .18s ease}
.mentor-modern .hero{background:color-mix(in srgb,var(--p) 92%,var(--a) 8%)}
.mentor-modern .logo{background:var(--a);box-shadow:0 5px 14px rgba(0,0,0,.24);color:#fff}
.mentor-modern .btn{box-shadow:inset 0 1px 0 rgba(255,255,255,.025);transition:transform .15s ease,border-color .15s ease,background .15s ease}
.mentor-modern .btn.primary{background:var(--a);border-color:color-mix(in srgb,var(--a) 82%,#000);color:#fff}
.mentor-modern .progress i,.mentor-modern .bar i{background:var(--a)}
.mentor-modern .mentor{background:color-mix(in srgb,var(--a) 6%,var(--p));border-left-width:3px}
.mentor-modern .stat{background:color-mix(in srgb,var(--p2) 84%,transparent)}
.mentor-modern .themePopover{backdrop-filter:none;background:var(--p);box-shadow:0 12px 34px rgba(0,0,0,.3)}
@media(hover:hover) and (pointer:fine){.mentor-modern .card:hover{transform:translateY(-2px);box-shadow:0 12px 30px rgba(0,0,0,.25),inset 0 1px 0 rgba(255,255,255,.03)}.mentor-modern .btn:hover{transform:translateY(-1px);border-color:color-mix(in srgb,var(--bd) 70%,var(--a) 30%)}}
.repairRow,.evidenceRow{display:flex;gap:8px;align-items:flex-start;padding:9px 0;border-bottom:1px solid var(--bd)}.repairRow:last-child,.evidenceRow:last-child{border-bottom:0}.vaultForm{display:grid;grid-template-columns:1fr 1fr;gap:8px}.vaultForm .wide{grid-column:1/-1}.strength{width:145px}@media(max-width:560px){.vaultForm{grid-template-columns:1fr}.vaultForm .wide{grid-column:auto}}
`;
  document.head.appendChild(style);
  document.body.classList.add('mentor-modern');

  const aliases={dark:'midnight','pro-midnight':'midnight',warm:'ember',focus:'forest'};
  if(typeof D!=='undefined'&&D&&aliases[D.theme]){D.theme=aliases[D.theme];if(typeof save==='function')save()}

  document.title='DA Mentor Launch — Course 1';
  const logo=document.querySelector('.brand .logo');if(logo)logo.textContent='↗';
  const brandText=document.querySelector('.brand>div:nth-child(2)');if(brandText)brandText.innerHTML='DA Mentor Launch <span class="small">Course 1 • Data Analyst</span>';
  const labels={install:'📲 Install',reportsBtn:'📊 Reports',csv:'📤 CSV',backup:'💾 Backup',restore:'📥 Restore',settings:'⚙️ Settings'};
  Object.entries(labels).forEach(([id,text])=>{const el=document.getElementById(id);if(el)el.textContent=text});

  function ensureExtras(){if(!Array.isArray(D.errors))D.errors=[];if(!Array.isArray(D.evidence))D.evidence=[]}
  ensureExtras();

  const main=document.querySelector('main');
  const notesCard=document.getElementById('notes')?.closest('.card');
  let repairCard=document.getElementById('launchRepairCard');
  if(!repairCard){repairCard=document.createElement('section');repairCard.id='launchRepairCard';repairCard.className='card';repairCard.innerHTML=`<div class="row space"><div><div class="kick">🛠️ Error & repair center</div><h2>Weakness → repair → fresh retest</h2></div><span class="pill" id="launchOpenErrors">0 open</span></div><div class="vaultForm"><input id="launchErrSkill" placeholder="Lesson / skill (example SF4 JOIN)"><input id="launchErrIssue" placeholder="What went wrong?"><input class="wide" id="launchErrRepair" placeholder="Repair plan (default: targeted relearn → fresh task)"><button class="btn primary" id="launchAddError">+ Add weakness</button></div><div id="launchErrors"></div>`;if(main&&notesCard)main.insertBefore(repairCard,notesCard)}

  const aside=document.querySelector('aside');
  const dataSafety=[...document.querySelectorAll('aside .card')].find(x=>x.textContent.includes('Data safety'));
  let evidenceCard=document.getElementById('launchEvidenceCard');
  if(!evidenceCard){evidenceCard=document.createElement('section');evidenceCard.id='launchEvidenceCard';evidenceCard.className='card';evidenceCard.innerHTML=`<div class="row space"><div><div class="kick">🗂️ Evidence vault</div><h2>Save proof, not private data</h2></div><span class="pill" id="launchEvidenceCount">0 saved</span></div><div class="call warn">Use sanitized evidence only. Never store employer/customer names, credentials, private datasets, proprietary code or confidential documents.</div><div class="vaultForm" style="margin-top:9px"><input id="launchEvSkill" placeholder="Skill / competency"><select id="launchEvStrength" class="strength"><option value="1">1 — Guided course evidence</option><option value="2">2 — Independent project</option><option value="3">3 — Job-ready independent proof</option><option value="4">4 — Repeated ownership</option></select><textarea class="wide" id="launchEvAction" placeholder="Sanitized situation + what you did + validation / result"></textarea><button class="btn primary" id="launchAddEvidence">Save evidence</button><button class="btn" id="launchEvidenceCsv">Export evidence CSV</button></div><div id="launchEvidence"></div>`;if(aside&&dataSafety)aside.insertBefore(evidenceCard,dataSafety)}

  function renderErrors(){ensureExtras();const box=document.getElementById('launchErrors');if(!box)return;document.getElementById('launchOpenErrors').textContent=`${D.errors.filter(e=>!e.done).length} open`;box.innerHTML=D.errors.length?D.errors.map((e,i)=>`<div class="repairRow ${e.done?'done':''}"><div class="grow"><b>${esc(e.skill)}</b><div class="small">${esc(e.issue)}</div><div class="small">Repair: ${esc(e.repair||'Targeted relearn → fresh task')}</div></div><button class="btn" data-launchfix="${i}">${e.done?'Reopen':'Mastered'}</button><button class="btn ghost" data-launchdelerr="${i}">×</button></div>`).join(''):'<div class="small" style="margin-top:9px">No recorded weaknesses yet. Add one only when practice or a Gate exposes a real recurring mistake.</div>';document.querySelectorAll('[data-launchfix]').forEach(b=>b.onclick=()=>{D.errors[+b.dataset.launchfix].done=!D.errors[+b.dataset.launchfix].done;save();renderErrors()});document.querySelectorAll('[data-launchdelerr]').forEach(b=>b.onclick=()=>{D.errors.splice(+b.dataset.launchdelerr,1);save();renderErrors()})}
  function renderEvidence(){ensureExtras();const box=document.getElementById('launchEvidence');if(!box)return;document.getElementById('launchEvidenceCount').textContent=`${D.evidence.length} saved`;box.innerHTML=D.evidence.length?D.evidence.slice().reverse().map((e,ri)=>{const i=D.evidence.length-1-ri;return `<div class="evidenceRow"><div class="grow"><b>${esc(e.skill)}</b><div class="small">${esc(e.action)}</div><span class="pill">Strength ${e.strength}/4</span> <span class="pill">${esc(e.date||'')}</span></div><button class="btn ghost" data-launchdelev="${i}">×</button></div>`}).join(''):'<div class="small" style="margin-top:9px">No evidence saved yet. Your course projects count when you label the evidence honestly.</div>';document.querySelectorAll('[data-launchdelev]').forEach(b=>b.onclick=()=>{D.evidence.splice(+b.dataset.launchdelev,1);save();renderEvidence()})}

  document.getElementById('launchAddError')?.addEventListener('click',()=>{const skill=document.getElementById('launchErrSkill').value.trim(),issue=document.getElementById('launchErrIssue').value.trim();if(!skill||!issue)return alert('Add the skill and what went wrong.');D.errors.push({skill,issue,repair:document.getElementById('launchErrRepair').value.trim()||'Targeted relearn → fresh task',done:false,date:today()});document.getElementById('launchErrSkill').value='';document.getElementById('launchErrIssue').value='';document.getElementById('launchErrRepair').value='';save();renderErrors()});
  document.getElementById('launchAddEvidence')?.addEventListener('click',()=>{const skill=document.getElementById('launchEvSkill').value.trim(),action=document.getElementById('launchEvAction').value.trim();if(!skill||!action)return alert('Add a skill and sanitized evidence.');D.evidence.push({skill,action,strength:+document.getElementById('launchEvStrength').value||1,date:today()});document.getElementById('launchEvSkill').value='';document.getElementById('launchEvAction').value='';save();renderEvidence()});
  document.getElementById('launchEvidenceCsv')?.addEventListener('click',()=>{const q=x=>`"${String(x??'').replace(/"/g,'""')}"`,rows=[['Date','Skill','Strength','Sanitized evidence'],...D.evidence.map(e=>[e.date,e.skill,e.strength,e.action])],text=rows.map(r=>r.map(q).join(',')).join('\n');download(`DA_Mentor_Launch_Evidence_${today()}.csv`,text,'text/csv')});

  const baseRender=render;
  render=function(){baseRender();ensureExtras();renderErrors();renderEvidence()};
  const footer=document.querySelector('.footer');if(footer)footer.textContent='DA Mentor Launch v5.0 • Course 1 • self-study mentor • restrained depth UI • offline-first';
  render();
});
(()=>{
  const style=document.createElement('style');
  style.textContent=`
body[data-theme="pro-midnight"]{--bg:#0b1020;--p:#11192d;--p2:#17223a;--txt:#f5f7fb;--mut:#91a0b8;--a:#8b7cf6;--a2:#5bc0eb;--ok:#45d49c;--warn:#f2c14e;--bd:#263552}
body[data-theme="slate"]{--bg:#11151b;--p:#191f27;--p2:#232b35;--txt:#f5f7fb;--mut:#9cacbe;--a:#69a7ff;--a2:#7bdff2;--ok:#5dd39e;--warn:#f3ca62;--bd:#34404e}
body[data-theme="forest"]{--bg:#0c1512;--p:#12211b;--p2:#1a3027;--txt:#effbf6;--mut:#95b5a8;--a:#53d18f;--a2:#8be8bb;--ok:#5dd39e;--warn:#f3ca62;--bd:#294a3c}
body[data-theme="pro-midnight"]{background:radial-gradient(circle at 30% -10%,color-mix(in srgb,var(--a) 22%,transparent),transparent 34%),linear-gradient(180deg,var(--p2),var(--bg) 23%)}
#quickTheme{min-width:92px}@media(max-width:560px){#quickTheme{flex:1}}
.repairRow{display:flex;gap:9px;align-items:flex-start;padding:9px 0;border-bottom:1px solid var(--bd)}.repairRow:last-child{border-bottom:0}.repairRow .grow{flex:1}.repairRow.done{opacity:.58}.repairMeta{margin-top:4px}.repairActions{display:flex;gap:6px;flex-wrap:wrap}@media(max-width:560px){.repairRow{flex-direction:column}.repairActions{width:100%}.repairActions .btn{flex:1}}
`;
  document.head.appendChild(style);

  // Visible theme selector and Pro-style visual themes.
  const sel=document.getElementById('theme');
  const options=[['pro-midnight','Pro Midnight'],['slate','Slate'],['forest','Forest']];
  if(sel) options.forEach(([v,t])=>{if(![...sel.options].some(o=>o.value===v)){const o=document.createElement('option');o.value=v;o.textContent=t;sel.appendChild(o)}});
  const themes=['pro-midnight','slate','forest','warm','focus','dark'];
  const names={'pro-midnight':'Pro Midnight',slate:'Slate',forest:'Forest',warm:'Warm',focus:'Focus Green',dark:'Dark'};
  const host=document.querySelector('.top .row');
  let btn=document.getElementById('quickTheme');
  if(host&&!btn){btn=document.createElement('button');btn.className='btn';btn.id='quickTheme';host.insertBefore(btn,host.firstChild)}
  function label(){if(btn){const t=(typeof D!=='undefined'&&D.theme)||document.body.dataset.theme||'dark';btn.textContent=`Theme: ${names[t]||t}`}}
  btn?.addEventListener('click',()=>{
    const curTheme=(typeof D!=='undefined'&&D.theme)||document.body.dataset.theme||'dark';
    const next=themes[(themes.indexOf(curTheme)+1)%themes.length];
    if(typeof D!=='undefined'){D.theme=next;if(typeof save==='function')save();if(typeof render==='function')render();}
    else document.body.dataset.theme=next;
    if(sel)sel.value=next;label();
  });
  document.getElementById('settings')?.addEventListener('click',()=>{if(sel&&typeof D!=='undefined')sel.value=D.theme||'dark'});
  document.getElementById('saveSettings')?.addEventListener('click',()=>setTimeout(label,0));
  label();

  // Persistent Mistake & Repair Center. Stored inside D, so normal v4 backup/restore includes it automatically.
  if(typeof D!=='undefined'&&!Array.isArray(D.errors))D.errors=[];
  const main=document.querySelector('main');
  let card=document.getElementById('repairCenterCard');
  if(main&&!card){
    card=document.createElement('section');card.className='card';card.id='repairCenterCard';
    card.innerHTML=`<div class="row space"><div><div class="kick">Mistake & repair center</div><h2>Weakness → targeted repair → fresh retry</h2></div><button class="btn" id="addRepair">+ Add weakness</button></div><div class="small">Record repeated mistakes here instead of repeatedly re-reading whole lessons. A weakness is closed only after you can solve a fresh task independently.</div><div id="repairList"></div>`;
    main.appendChild(card);
  }
  const safe=s=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
  function renderRepairs(){
    const box=document.getElementById('repairList');if(!box||typeof D==='undefined')return;
    const errors=Array.isArray(D.errors)?D.errors:[];
    box.innerHTML=errors.length?errors.map((e,i)=>`<div class="repairRow ${e.done?'done':''}"><div class="grow"><b>${safe(e.skill)}</b><div class="small">${safe(e.issue)}</div><div class="small repairMeta"><b>Repair:</b> ${safe(e.repair||'Re-study exact weak point → fresh practice → verify independently')}</div></div><div class="repairActions"><button class="btn" data-repairdone="${i}">${e.done?'Reopen':'Mastered'}</button><button class="btn ghost" data-repairdel="${i}">×</button></div></div>`).join(''):'<div class="small" style="margin-top:9px">No recorded weaknesses yet. Add one when practice, review or a Gate exposes a repeating error.</div>';
    document.querySelectorAll('[data-repairdone]').forEach(b=>b.onclick=()=>{D.errors[+b.dataset.repairdone].done=!D.errors[+b.dataset.repairdone].done;save();renderRepairs()});
    document.querySelectorAll('[data-repairdel]').forEach(b=>b.onclick=()=>{D.errors.splice(+b.dataset.repairdel,1);save();renderRepairs()});
  }
  document.getElementById('addRepair')?.addEventListener('click',()=>{
    const s=cur?.();const skill=prompt('Skill / lesson ID (example SQL joins):',s?.name||'');if(!skill)return;
    const issue=prompt('What went wrong?')||'Needs targeted repair';
    const repair=prompt('Repair plan (optional):')||'Re-study exact weak point → fresh practice → verify independently';
    if(!Array.isArray(D.errors))D.errors=[];D.errors.push({skill,issue,repair,done:false,date:typeof today==='function'?today():''});save();renderRepairs();
  });
  renderRepairs();

  const footer=document.querySelector('.footer');if(footer)footer.textContent='DA Mentor OS v4.2 • themes + mistake/repair center • final master curriculum • offline-first • backup/restore • reports + mentor guidance';
})();

(()=>{
  const style=document.createElement('style');
  style.textContent=`
body[data-theme="pro-midnight"]{--bg:#0b1020;--p:#11192d;--p2:#17223a;--txt:#f5f7fb;--mut:#91a0b8;--a:#8b7cf6;--a2:#5bc0eb;--ok:#45d49c;--warn:#f2c14e;--bd:#263552}
body[data-theme="slate"]{--bg:#11151b;--p:#191f27;--p2:#232b35;--txt:#f5f7fb;--mut:#9cacbe;--a:#69a7ff;--a2:#7bdff2;--ok:#5dd39e;--warn:#f3ca62;--bd:#34404e}
body[data-theme="forest"]{--bg:#0c1512;--p:#12211b;--p2:#1a3027;--txt:#effbf6;--mut:#95b5a8;--a:#53d18f;--a2:#8be8bb;--ok:#5dd39e;--warn:#f3ca62;--bd:#294a3c}
body[data-theme="pro-midnight"]{background:radial-gradient(circle at 30% -10%,color-mix(in srgb,var(--a) 22%,transparent),transparent 34%),linear-gradient(180deg,var(--p2),var(--bg) 23%)}
#quickTheme{min-width:92px}@media(max-width:560px){#quickTheme{flex:1}}
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
  btn?.addEventListener('click',()=>{
    const cur=(typeof D!=='undefined'&&D.theme)||document.body.dataset.theme||'dark';
    const next=themes[(themes.indexOf(cur)+1)%themes.length];
    if(typeof D!=='undefined'){D.theme=next;if(typeof save==='function')save();if(typeof render==='function')render();}
    else document.body.dataset.theme=next;
    if(sel)sel.value=next;label();
  });
  document.getElementById('settings')?.addEventListener('click',()=>{if(sel&&typeof D!=='undefined')sel.value=D.theme||'dark'});
  document.getElementById('saveSettings')?.addEventListener('click',()=>setTimeout(label,0));
  label();
})();

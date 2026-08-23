(()=>{
 const trigger=document.getElementById('themeMenuBtn'),pop=document.getElementById('themePopover'),label=document.getElementById('themeCurrent'),settingsTheme=document.getElementById('theme');
 const names={dark:'Dark','pro-midnight':'Pro Midnight',slate:'Slate',forest:'Forest',warm:'Warm',focus:'Focus Green'};
 if(!trigger||!pop)return;
 [['pro-midnight','Pro Midnight'],['slate','Slate'],['forest','Forest']].forEach(([v,t])=>{if(settingsTheme&&![...settingsTheme.options].some(o=>o.value===v)){const o=document.createElement('option');o.value=v;o.textContent=t;settingsTheme.appendChild(o)}});
 function current(){return (typeof D!=='undefined'&&D.theme)||document.body.dataset.theme||'dark'}
 function sync(){const t=current();label.textContent=names[t]||t;if(settingsTheme)settingsTheme.value=t;pop.querySelectorAll('[data-theme-choice]').forEach(b=>b.classList.toggle('active',b.dataset.themeChoice===t))}
 trigger.addEventListener('click',e=>{e.stopPropagation();pop.classList.toggle('show');sync()});
 pop.addEventListener('click',e=>{const b=e.target.closest('[data-theme-choice]');if(!b||typeof D==='undefined')return;D.theme=b.dataset.themeChoice;if(settingsTheme)settingsTheme.value=D.theme;if(typeof save==='function')save();if(typeof render==='function')render();sync();pop.classList.remove('show')});
 document.addEventListener('click',e=>{if(!pop.contains(e.target)&&e.target!==trigger)pop.classList.remove('show')});
 document.getElementById('settings')?.addEventListener('click',()=>setTimeout(sync,0));document.getElementById('saveSettings')?.addEventListener('click',()=>setTimeout(sync,0));sync();
})();
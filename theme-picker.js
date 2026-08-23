document.addEventListener('DOMContentLoaded',()=>{
  const names={amoled:'AMOLED Black',midnight:'Midnight',slate:'Slate',forest:'Forest',ocean:'Ocean',ember:'Ember',graphite:'Graphite'};
  const desc={amoled:'Pure black, lowest glow',midnight:'Deep neutral violet',slate:'Cool professional',forest:'Muted green',ocean:'Muted blue',ember:'Warm restrained',graphite:'Minimal monochrome'};
  const swatches={amoled:'linear-gradient(135deg,#000,#202226)',midnight:'linear-gradient(135deg,#080a10,#252a35)',slate:'linear-gradient(135deg,#0c0f13,#2a3139)',forest:'linear-gradient(135deg,#080d0b,#25332c)',ocean:'linear-gradient(135deg,#070c10,#25323a)',ember:'linear-gradient(135deg,#0d0907,#342921)',graphite:'linear-gradient(135deg,#090a0c,#2b2e33)'};
  const aliases={dark:'midnight','pro-midnight':'midnight',warm:'ember',focus:'forest'};
  if(typeof D!=='undefined'&&D&&aliases[D.theme]){D.theme=aliases[D.theme];if(typeof save==='function')save()}

  const settings=document.getElementById('theme');
  if(settings){settings.innerHTML=Object.entries(names).map(([v,t])=>`<option value="${v}">${t}</option>`).join('')}

  const trigger=document.getElementById('themeMenuBtn');
  const pop=document.getElementById('themePopover');
  const grid=pop?.querySelector('.themeGrid');
  const currentLabel=document.getElementById('themeCurrent');
  if(grid)grid.innerHTML=Object.keys(names).map(k=>`<button type="button" data-launch-theme="${k}"><i class="swatch" style="background:${swatches[k]}"></i><span>${names[k]}<small>${desc[k]}</small></span></button>`).join('');

  const style=document.createElement('style');style.textContent=`.settingsThemeGallery{grid-column:1/-1;margin-top:2px}.settingsThemeGallery>span{display:block;margin-bottom:8px}.settingsThemeGrid{display:grid;grid-template-columns:repeat(2,1fr);gap:8px}.settingsThemeCard{display:flex;gap:9px;align-items:center;text-align:left;border:1px solid var(--bd);background:var(--p2);color:var(--txt);border-radius:12px;padding:9px;cursor:pointer}.settingsThemeCard.active,.themeGrid button.active{outline:1px solid var(--a);border-color:var(--a)}.settingsThemeCard i{width:34px;height:34px;border-radius:10px;flex:0 0 34px;border:1px solid var(--bd)}.settingsThemeCard b,.settingsThemeCard small{display:block}.settingsThemeCard small{color:var(--mut);margin-top:2px}@media(max-width:560px){.settingsThemeGrid{grid-template-columns:1fr}}`;
  document.head.appendChild(style);

  const form=document.querySelector('#settingsModal .form');
  let gallery=document.getElementById('launchSettingsThemeGallery');
  if(form&&!gallery){gallery=document.createElement('div');gallery.id='launchSettingsThemeGallery';gallery.className='settingsThemeGallery';gallery.innerHTML=`<span class="small">Appearance</span><div class="settingsThemeGrid">${Object.keys(names).map(k=>`<button type="button" class="settingsThemeCard" data-launch-settings-theme="${k}"><i style="background:${swatches[k]}"></i><span><b>${names[k]}</b><small>${desc[k]}</small></span></button>`).join('')}</div>`;const label=settings?.closest('label');if(label)label.style.display='none';form.appendChild(gallery)}

  function selected(){return (typeof D!=='undefined'&&D&&D.theme)||document.body.dataset.theme||'midnight'}
  function apply(t){if(typeof D==='undefined'||!D)return;D.theme=t;if(settings)settings.value=t;if(typeof save==='function')save();if(typeof render==='function')render();sync()}
  function sync(){const t=selected();document.body.dataset.theme=t;if(currentLabel)currentLabel.textContent=names[t]||t;if(settings)settings.value=t;document.querySelectorAll('[data-launch-theme]').forEach(b=>b.classList.toggle('active',b.dataset.launchTheme===t));document.querySelectorAll('[data-launch-settings-theme]').forEach(b=>b.classList.toggle('active',b.dataset.launchSettingsTheme===t))}

  trigger?.addEventListener('click',e=>{e.stopPropagation();pop?.classList.toggle('show');sync()});
  grid?.addEventListener('click',e=>{const b=e.target.closest('[data-launch-theme]');if(!b)return;apply(b.dataset.launchTheme);pop?.classList.remove('show')});
  gallery?.addEventListener('click',e=>{const b=e.target.closest('[data-launch-settings-theme]');if(!b)return;apply(b.dataset.launchSettingsTheme)});
  document.addEventListener('click',e=>{if(pop?.classList.contains('show')&&!pop.contains(e.target)&&e.target!==trigger)pop.classList.remove('show')});
  document.getElementById('settings')?.addEventListener('click',()=>setTimeout(sync,0));
  document.getElementById('saveSettings')?.addEventListener('click',()=>setTimeout(sync,0));
  sync();
});
(()=>{
  const picker=document.getElementById('quickThemeSelect');
  const settingsTheme=document.getElementById('theme');
  if(!picker)return;
  const sync=()=>{const current=(typeof D!=='undefined'&&D.theme)||document.body.dataset.theme||'dark';picker.value=current;if(settingsTheme)settingsTheme.value=current;};
  picker.addEventListener('change',()=>{
    if(typeof D==='undefined')return;
    D.theme=picker.value;
    if(settingsTheme)settingsTheme.value=D.theme;
    if(typeof save==='function')save();
    if(typeof render==='function')render();
    sync();
  });
  document.getElementById('settings')?.addEventListener('click',()=>setTimeout(sync,0));
  document.getElementById('saveSettings')?.addEventListener('click',()=>setTimeout(sync,0));
  sync();
})();

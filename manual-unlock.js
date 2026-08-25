(()=>{
  function ensureManualUnlock(){if(!Array.isArray(D.manualUnlockedStages))D.manualUnlockedStages=[]}
  function normalStageUnlocked(i){if(i<=0)return true;return C.slice(0,i).every(x=>!!D.gates[x.id])}
  function renderUnlockUI(){
    ensureManualUnlock();let host=document.getElementById('launchManualUnlock');
    if(!host){const map=document.getElementById('map')?.closest('.card');if(!map)return;host=document.createElement('div');host.id='launchManualUnlock';host.className='call';host.style.marginBottom='10px';map.insertBefore(host,document.getElementById('map'))}
    const manual=!normalStageUnlocked(D.currentStage);
    host.innerHTML=`<div class="row space"><div><b>${manual?'🔓 Manually unlocked phase':'Phase navigation'}</b><div class="small">Jumping does not mark skipped lessons, evidence, or Gates complete.</div></div><div class="row"><select id="launchJumpSelect">${C.map((x,i)=>`<option value="${i}" ${i===D.currentStage?'selected':''}>${i+1}. ${esc(x.name)}</option>`).join('')}</select><button class="btn" id="launchJumpBtn">Unlock anyway</button></div></div>`;
    document.getElementById('launchJumpBtn').onclick=()=>{const i=+document.getElementById('launchJumpSelect').value;if(i===D.currentStage)return;if(normalStageUnlocked(i)){D.currentStage=i;save();render();return}if(!confirm(`Unlock ${C[i].name} anyway? Earlier unfinished phases will stay incomplete and must be returned to later.`))return;if(!D.manualUnlockedStages.includes(C[i].id))D.manualUnlockedStages.push(C[i].id);D.currentStage=i;save();render()};
  }
  function init(){const baseRender=render;render=function(){baseRender();renderUnlockUI()};renderUnlockUI()}
  if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',init);else init();
})();

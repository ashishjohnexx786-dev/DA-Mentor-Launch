(()=>{
  const TIMER_KEY='daMentorLaunch.timer.v2';
  const clamp=(n,a,b)=>Math.max(a,Math.min(b,n));
  const modeDuration=m=>m==='focus'?Math.max(10,+D.focusMin||25):m==='short'?Math.max(1,+D.shortMin||5):Math.max(5,+D.longMin||15);
  const now=()=>Date.now();
  const makeIdle=(m=typeof mode==='string'?mode:'focus')=>({v:2,status:'idle',mode:m,durationMin:modeDuration(m),remainingSec:modeDuration(m)*60,running:false,startedAt:0,endAt:0,stage:'',sessionId:'',completedAt:0});
  const loadTimer=()=>{try{const x=JSON.parse(localStorage.getItem(TIMER_KEY)||'null');return x&&x.v===2?Object.assign(makeIdle(x.mode||'focus'),x):makeIdle()}catch(e){return makeIdle()}};
  let T=loadTimer();
  const store=()=>localStorage.setItem(TIMER_KEY,JSON.stringify(T));
  const rem=()=>T.status==='running'?Math.max(0,Math.ceil((T.endAt-now())/1000)):Math.max(0,+T.remainingSec||0);
  const fmt=s=>`${String(Math.floor(s/60)).padStart(2,'0')}:${String(Math.floor(s%60)).padStart(2,'0')}`;
  const sessionLogged=id=>Array.isArray(D.focusLog)&&D.focusLog.some(x=>x&&x.sessionId===id);
  const notify=async(title,body)=>{
    if(D.alarm!=='on')return;
    try{if(navigator.vibrate)navigator.vibrate([180,80,180,80,260])}catch(e){}
    try{beep()}catch(e){}
    try{
      if('Notification' in window&&Notification.permission==='granted'){
        if('serviceWorker' in navigator){const reg=await navigator.serviceWorker.ready;await reg.showNotification(title,{body,tag:'mentor-focus-complete',renotify:true});}
        else new Notification(title,{body});
      }
    }catch(e){}
  };
  const askNotification=()=>{try{if('Notification'in window&&Notification.permission==='default')Notification.requestPermission().catch(()=>{})}catch(e){}};
  const draw=()=>{
    const clock=document.getElementById('timer'),start=document.getElementById('timerStart'),hint=document.getElementById('timerHint');if(!clock||!start)return;
    if(T.status==='complete')clock.textContent='00:00';else clock.textContent=fmt(rem());
    start.textContent=T.status==='running'?'PAUSE':T.status==='complete'?'DONE':'START';
    document.querySelectorAll('.mode').forEach(b=>b.classList.toggle('active',b.dataset.mode===T.mode));
    if(hint)hint.textContent=T.status==='complete'?`✅ ${T.mode==='focus'?`${T.durationMin}m focus saved to Reports`:'Break complete'} — tap DONE`:`${D.focusMin}m focus • ${D.shortMin}m short • ${D.longMin}m long${T.status==='running'?' • running by clock time':''}`;
  };
  const reset=(m=T.mode)=>{T=makeIdle(m);mode=m;running=false;clearInterval(timerInt);timerInt=null;sec=T.remainingSec;store();draw()};
  const complete=async()=>{
    if(T.status==='complete')return;
    const id=T.sessionId||`launch-${T.startedAt||now()}`;const wasFocus=T.mode==='focus',minutes=+T.durationMin||modeDuration(T.mode),stage=T.stage||cur().id;
    T.status='complete';T.running=false;T.remainingSec=0;T.endAt=0;T.completedAt=now();T.sessionId=id;store();
    running=false;clearInterval(timerInt);timerInt=null;sec=0;
    if(wasFocus&&!sessionLogged(id)){
      if(!Array.isArray(D.focusLog))D.focusLog=[];
      D.focusLog.push({date:today(),minutes,stage,sessionId:id,startedAt:T.startedAt||0,completedAt:T.completedAt});
      updateStreak();save();render();
    }
    draw();await notify(wasFocus?'Focus session complete':'Break complete',wasFocus?`${minutes} minutes saved to DA Mentor Launch reports.`:'Your break is finished.');
  };
  const reconcile=()=>{if(T.status==='running'){if(rem()<=0)complete();else draw()}else draw()};
  const toggle=()=>{
    if(T.status==='complete'){reset(T.mode);return}
    if(T.status==='running'){
      T.remainingSec=rem();T.status='paused';T.running=false;T.endAt=0;store();running=false;clearInterval(timerInt);timerInt=null;sec=T.remainingSec;draw();return;
    }
    const wasPaused=T.status==='paused';
    const seconds=wasPaused&&T.remainingSec>0?T.remainingSec:modeDuration(T.mode)*60;
    T.status='running';T.running=true;T.durationMin=wasPaused?(+T.durationMin||modeDuration(T.mode)):modeDuration(T.mode);T.remainingSec=seconds;T.startedAt=T.startedAt||now();T.endAt=now()+seconds*1000;T.stage=T.stage||cur().id;T.sessionId=T.sessionId||`launch-${T.startedAt}-${Math.random().toString(36).slice(2,8)}`;store();
    mode=T.mode;running=false;clearInterval(timerInt);timerInt=null;askNotification();draw();
  };
  function setMode(m){if(!['focus','short','long'].includes(m))return;T=makeIdle(m);mode=m;running=false;clearInterval(timerInt);timerInt=null;sec=T.remainingSec;store();draw()}

  function ensureManualUnlock(){if(!Array.isArray(D.manualUnlockedStages))D.manualUnlockedStages=[]}
  function normalStageUnlocked(i){if(i<=0)return true;return C.slice(0,i).every(x=>!!D.gates[x.id])}
  function renderUnlockUI(){
    ensureManualUnlock();let host=document.getElementById('launchManualUnlock');
    if(!host){const map=document.getElementById('map')?.closest('.card');if(!map)return;host=document.createElement('div');host.id='launchManualUnlock';host.className='call';host.style.marginBottom='10px';map.insertBefore(host,document.getElementById('map'))}
    const manual=!normalStageUnlocked(D.currentStage);
    host.innerHTML=`<div class="row space"><div><b>${manual?'🔓 Manually unlocked phase':'Phase navigation'}</b><div class="small">Jumping does not mark skipped lessons, evidence, or Gates complete.</div></div><div class="row"><select id="launchJumpSelect">${C.map((x,i)=>`<option value="${i}" ${i===D.currentStage?'selected':''}>${i+1}. ${esc(x.name)}</option>`).join('')}</select><button class="btn" id="launchJumpBtn">Unlock anyway</button></div></div>`;
    document.getElementById('launchJumpBtn').onclick=()=>{const i=+document.getElementById('launchJumpSelect').value;if(i===D.currentStage)return;if(normalStageUnlocked(i)){D.currentStage=i;save();render();return}if(!confirm(`Unlock ${C[i].name} anyway? Earlier unfinished phases will stay incomplete and must be returned to later.`))return;if(!D.manualUnlockedStages.includes(C[i].id))D.manualUnlockedStages.push(C[i].id);D.currentStage=i;save();render()};
  }

  function install(){
    clearInterval(timerInt);timerInt=null;running=false;
    mode=T.mode;sec=rem();
    document.querySelectorAll('.mode').forEach(b=>b.onclick=()=>setMode(b.dataset.mode));
    const start=document.getElementById('timerStart'),resetBtn=document.getElementById('timerReset');if(start)start.onclick=toggle;if(resetBtn)resetBtn.onclick=()=>reset(T.mode);
    drawTimer=draw;resetTimer=()=>reset(T.mode);toggleTimer=toggle;finishTimer=complete;
    ['visibilitychange','pageshow','focus'].forEach(ev=>window.addEventListener(ev,reconcile));document.addEventListener('visibilitychange',reconcile);
    const baseRender=render;render=function(){baseRender();renderUnlockUI();draw()};
    setInterval(reconcile,1000);renderUnlockUI();reconcile();
  }
  if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',install);else install();
})();

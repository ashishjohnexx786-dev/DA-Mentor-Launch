(()=>{
  const KEY='daMentorLaunch.studySession.v1';
  const load=()=>{try{return Object.assign({active:false,startedAt:0,stage:'',sessionId:''},JSON.parse(localStorage.getItem(KEY)||'{}'))}catch(e){return {active:false,startedAt:0,stage:'',sessionId:''}}};
  let S=load();
  const persistSession=()=>localStorage.setItem(KEY,JSON.stringify(S));
  const elapsedMs=()=>S.active&&S.startedAt?Math.max(0,Date.now()-S.startedAt):0;
  const fmtElapsed=ms=>{const total=Math.floor(ms/1000),h=Math.floor(total/3600),m=Math.floor((total%3600)/60),s=total%60;return h?`${String(h).padStart(2,'0')}:${String(m).padStart(2,'0')}:${String(s).padStart(2,'0')}`:`${String(m).padStart(2,'0')}:${String(s).padStart(2,'0')}`};
  const startLabel=()=>S.startedAt?new Date(S.startedAt).toLocaleTimeString([],{hour:'2-digit',minute:'2-digit'}):'';
  function hostPersist(){save();render()}
  function installUI(){
    const card=[...document.querySelectorAll('aside .card')].find(x=>x.textContent.includes('Focus timer'));
    if(!card)return;
    const kick=card.querySelector('.kick');if(kick)kick.textContent='Study session';
    const shell=card.querySelector('.timer');if(!shell)return;
    shell.innerHTML=`<div class="small" style="text-align:center;margin-bottom:8px">Use your phone Clock for 25-minute alarms. Mentor only records when you manually start and end studying.</div><div class="time" id="studySessionClock">00:00</div><div class="row" style="justify-content:center;margin-top:10px"><button class="btn primary" id="studySessionToggle">START STUDY</button><button class="btn" id="studySessionCancel">Cancel</button></div><div class="small" id="studySessionHint" style="margin-top:8px;text-align:center"></div>`;
    document.getElementById('studySessionToggle').onclick=toggle;
    document.getElementById('studySessionCancel').onclick=cancel;
    draw();
  }
  function draw(){
    const clock=document.getElementById('studySessionClock'),btn=document.getElementById('studySessionToggle'),cancelBtn=document.getElementById('studySessionCancel'),hint=document.getElementById('studySessionHint');if(!clock||!btn)return;
    clock.textContent=fmtElapsed(elapsedMs());
    btn.textContent=S.active?'END STUDY':'START STUDY';
    if(cancelBtn)cancelBtn.disabled=!S.active;
    if(hint)hint.textContent=S.active?`Started ${startLabel()} • opening/closing Mentor will not end this session.`:'Session ends only when you press END STUDY.';
  }
  function start(){S={active:true,startedAt:Date.now(),stage:cur().id,sessionId:`launch-study-${Date.now()}-${Math.random().toString(36).slice(2,8)}`};persistSession();draw()}
  function end(){
    if(!S.active)return;
    const endedAt=Date.now(),minutes=Math.max(1,Math.round((endedAt-S.startedAt)/60000)),id=S.sessionId,stage=S.stage||cur().id;
    if(!Array.isArray(D.focusLog))D.focusLog=[];
    if(!D.focusLog.some(x=>x&&x.sessionId===id))D.focusLog.push({date:today(),minutes,stage,sessionId:id,startedAt:S.startedAt,completedAt:endedAt,source:'manual-study-session'});
    updateStreak();S={active:false,startedAt:0,stage:'',sessionId:''};persistSession();hostPersist();draw();alert(`Study session saved: ${fmtM(minutes)}.`)
  }
  function toggle(){S.active?end():start()}
  function cancel(){if(!S.active)return;if(!confirm('Cancel this active study session without saving it?'))return;S={active:false,startedAt:0,stage:'',sessionId:''};persistSession();draw()}
  function reconcile(){S=load();draw()}
  function init(){installUI();window.addEventListener('focus',reconcile);window.addEventListener('pageshow',reconcile);document.addEventListener('visibilitychange',reconcile);setInterval(draw,1000)}
  if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',init);else init();
})();

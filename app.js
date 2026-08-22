const TOTAL=112, STORE='daMentorOSv3';
const DEF={version:3,name:'',startDate:new Date().toISOString().slice(0,10),dailyTarget:4,backupEvery:7,focusMin:25,shortMin:5,longMin:15,theme:'dark',alarm:'on',currentStage:0,dayProgress:{},projectProgress:{},gates:{},tasks:[],notes:{},focusLog:[],streak:{lastDate:'',count:0},lastBackup:'',customProjects:[]};
let D;
function clone(x){return JSON.parse(JSON.stringify(x))}
try{D=JSON.parse(localStorage.getItem(STORE))}catch(e){}
if(!D){
  D=clone(DEF);
  try{
    const old=JSON.parse(localStorage.getItem('daMentorOSv2')||'null');
    if(old){D.name=old.name||'';D.startDate=old.startDate||D.startDate;D.dailyTarget=old.dailyTarget||4;D.backupEvery=old.backupEvery||7;D.currentStage=old.currentStage||0;D.tasks=old.tasks||[];D.streak=old.streak||D.streak;D.lastBackup=old.lastBackup||'';if(old.focus?.minutes)D.focusLog.push({date:new Date().toISOString().slice(0,10),minutes:old.focus.minutes,stage:C[D.currentStage].id});if(old.projectProgress)D.projectProgress=old.projectProgress;if(old.gates)D.gates=old.gates}
  }catch(e){}
}
for(const k in DEF)if(D[k]===undefined)D[k]=clone(DEF[k]);
function save(){localStorage.setItem(STORE,JSON.stringify(D))}
function today(){return new Date().toISOString().slice(0,10)}
function esc(s){return String(s).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]))}
function cur(){return C[D.currentStage]}
function dp(s){if(!D.dayProgress[s.id])D.dayProgress[s.id]=Array(s.days).fill(false);while(D.dayProgress[s.id].length<s.days)D.dayProgress[s.id].push(false);return D.dayProgress[s.id]}
function pp(s){if(!D.projectProgress[s.id])D.projectProgress[s.id]=Array(s.steps.length).fill(false);while(D.projectProgress[s.id].length<s.steps.length)D.projectProgress[s.id].push(false);return D.projectProgress[s.id]}
function minsOn(date){return D.focusLog.filter(x=>x.date===date).reduce((a,x)=>a+(+x.minutes||0),0)}
function minsRange(days){let sum=0;for(let i=0;i<days;i++){let d=new Date();d.setDate(d.getDate()-i);sum+=minsOn(d.toISOString().slice(0,10))}return sum}
function monthMins(){const m=today().slice(0,7);return D.focusLog.filter(x=>x.date.startsWith(m)).reduce((a,x)=>a+(+x.minutes||0),0)}
function fmtM(m){m=Math.round(m);return m>=60?`${Math.floor(m/60)}h ${m%60}m`:`${m}m`}
function calendarDay(){return Math.max(1,Math.floor((new Date(today()+'T00:00:00')-new Date(D.startDate+'T00:00:00'))/86400000)+1)}
function daysDone(){return C.reduce((a,s)=>a+dp(s).filter(Boolean).length,0)}
function projDone(){return C.reduce((a,s)=>a+pp(s).filter(Boolean).length,0)}
function totalProj(){return C.reduce((a,s)=>a+s.steps.length,0)}
function overallPct(){const gates=Object.values(D.gates).filter(Boolean).length;return Math.round((daysDone()+projDone()+gates)/(TOTAL+totalProj()+C.length)*100)}
function stagePct(s){return Math.round((dp(s).filter(Boolean).length+pp(s).filter(Boolean).length+(D.gates[s.id]?1:0))/(s.days+s.steps.length+1)*100)}
function projectPct(s){return Math.round(pp(s).filter(Boolean).length/s.steps.length*100)}
function prerequisitesDone(s){return dp(s).every(Boolean)&&pp(s).every(Boolean)}
function mentor(msg){document.getElementById('mentor').innerHTML=msg}
function nextAction(){
 const s=cur(),a=dp(s),p=pp(s);let i=a.findIndex(x=>!x);
 if(i>=0)return `<b>Next:</b> ${s.name} Day ${i+1}/${s.days} — ${esc(s.plan[i].label)}. Do one focus block, practice it, then mark the day complete only when you actually did the work.`;
 let j=p.findIndex(x=>!x);if(j>=0)return `<b>Learning days are complete.</b> Next required project step: <b>${esc(s.steps[j])}</b>. Work on this before starting another course topic.`;
 if(!D.gates[s.id])return `<b>Stage work is complete.</b> Attempt the exit gate without a tutorial: ${esc(s.gate)}`;
 if(D.currentStage<C.length-1)return `<b>${s.name} is complete.</b> Tap “Complete stage & move on” to open ${C[D.currentStage+1].name}.`;
 return `<b>Training build is complete.</b> Keep applications, interview drills and project-defense practice active until you receive an offer.`;
}
function rebuildTasks(){
 const s=cur(),a=dp(s),p=pp(s);let out=[];let i=a.findIndex(x=>!x),j=p.findIndex(x=>!x);
 if(i>=0)out.push({id:Date.now()+1,text:`${s.name} Day ${i+1}: ${s.plan[i].label}`,stage:s.id,pom:Math.max(2,Math.ceil(D.dailyTarget*60/D.focusMin*.55)),done:false,auto:true});
 if(j>=0)out.push({id:Date.now()+2,text:`Project: ${s.steps[j]}`,stage:s.id,pom:2,done:false,auto:true});
 out.push({id:Date.now()+3,text:'No-tutorial recall: explain today’s learning aloud',stage:s.id,pom:1,done:false,auto:true});
 D.tasks=D.tasks.filter(t=>!t.auto).concat(out);save();renderTasks()
}
function updateStreak(){
 const t=today();if(D.streak.lastDate===t)return;let y=new Date();y.setDate(y.getDate()-1);const yk=y.toISOString().slice(0,10);
 D.streak.count=D.streak.lastDate===yk?(D.streak.count||0)+1:1;D.streak.lastDate=t
}
function applyTheme(){document.body.dataset.theme=D.theme||'dark'}
function render(){
 applyTheme();const s=cur(),a=dp(s),p=pp(s),od=overallPct(),cal=calendarDay(),td=minsOn(today());
 document.getElementById('hello').textContent=(D.name?`Hi ${D.name}. `:'')+'You do not need to remember the plan.';
 document.getElementById('line').textContent=`Calendar Day ${cal} • current stage: ${s.name} • planned runway: 112 days`;
 document.getElementById('pct').textContent=od+'%';document.getElementById('bar').style.width=od+'%';document.getElementById('dayDone').textContent=`${daysDone()}/112`;document.getElementById('focus').textContent=fmtM(td);document.getElementById('streak').textContent=(D.streak.count||0)+' 🔥';
 document.getElementById('stageTitle').textContent=`${s.name} — ${s.days} planned days`;document.getElementById('stageNo').textContent=`Stage ${D.currentStage+1}/${C.length}`;document.getElementById('stageDaysDone').textContent=`${a.filter(Boolean).length}/${s.days} days done`;document.getElementById('stageBar').style.width=stagePct(s)+'%';document.getElementById('goal').textContent=s.goal;
 document.getElementById('schedule').innerHTML=s.plan.map((x,i)=>`<label class="item ${a[i]?'done':''}"><input type="checkbox" data-day="${i}" ${a[i]?'checked':''}><div><b>Day ${i+1}</b><div class="small">${esc(x.label)}</div></div></label>`).join('');
 document.querySelectorAll('[data-day]').forEach(el=>el.onchange=e=>{a[+e.target.dataset.day]=e.target.checked;save();render()});
 document.getElementById('project').textContent=s.project;document.getElementById('projectPct').textContent=projectPct(s)+'% complete';document.getElementById('milestones').innerHTML=s.steps.map((x,i)=>`<label class="item ${p[i]?'done':''}"><input type="checkbox" data-proj="${i}" ${p[i]?'checked':''}><span>${esc(x)}</span></label>`).join('');
 document.querySelectorAll('[data-proj]').forEach(el=>el.onchange=e=>{p[+e.target.dataset.proj]=e.target.checked;save();render()});
 const ready=prerequisitesDone(s);document.getElementById('gateText').textContent=s.gate;document.getElementById('gate').disabled=!ready;document.getElementById('gate').checked=!!D.gates[s.id];document.getElementById('gateBox').classList.toggle('pass',!!D.gates[s.id]);document.getElementById('gateLock').textContent=ready?'Ready to attempt. Do it independently.':`Locked until all ${s.days} study days and all project milestones are complete.`;document.getElementById('next').hidden=!(D.gates[s.id]&&D.currentStage<C.length-1);
 renderTasks();renderMap();renderPortfolio();renderFocusTarget();renderBackup();renderNotes();mentor(nextAction())
}
function renderTasks(){
 const box=document.getElementById('tasks');if(!D.tasks.length){box.innerHTML='<div class="small">Tap “Rebuild tasks” and the mentor will choose work from your current stage.</div>';return}
 box.innerHTML=D.tasks.map(t=>`<div class="item ${t.done?'done':''}"><input type="checkbox" data-task="${t.id}" ${t.done?'checked':''}><div class="grow">${esc(t.text)}<div class="small">${esc(C.find(s=>s.id===t.stage)?.name||'General')} • est. ${t.pom||1} Pomodoro${(t.pom||1)>1?'s':''} ${t.auto?'• mentor':''}</div></div><button class="btn ghost" data-del="${t.id}">×</button></div>`).join('');
 document.querySelectorAll('[data-task]').forEach(el=>el.onchange=e=>{let t=D.tasks.find(x=>x.id==e.target.dataset.task);if(t)t.done=e.target.checked;save();renderTasks()});
 document.querySelectorAll('[data-del]').forEach(el=>el.onclick=e=>{D.tasks=D.tasks.filter(x=>x.id!=e.target.dataset.del);save();renderTasks()})
}
function renderMap(){document.getElementById('map').innerHTML=C.map((s,i)=>`<details ${i===D.currentStage?'open':''}><summary>${D.gates[s.id]?'✓':i===D.currentStage?'→':'○'} ${esc(s.name)} — ${dp(s).filter(Boolean).length}/${s.days} days <span class="pill">${stagePct(s)}%</span></summary><div class="small" style="margin-top:7px"><b>Goal:</b> ${esc(s.goal)}<br><b>Required project:</b> ${esc(s.project)}<br><b>Exit gate:</b> ${esc(s.gate)}</div></details>`).join('')}
function renderPortfolio(){document.getElementById('portfolio').innerHTML=C.map(s=>`<div class="row space" style="padding:5px 0"><span class="small">${esc(s.project)}</span><span class="pill">${projectPct(s)}%</span></div>`).join('');document.getElementById('customList').innerHTML=(D.customProjects||[]).map(x=>`<div class="item"><div class="grow"><b>${esc(x.name)}</b><div class="small">${esc(x.goal)}</div></div><button class="btn ghost" data-cdel="${x.id}">×</button></div>`).join('');document.querySelectorAll('[data-cdel]').forEach(b=>b.onclick=e=>{D.customProjects=D.customProjects.filter(x=>x.id!=e.target.dataset.cdel);save();renderPortfolio()})}
function renderFocusTarget(){const m=minsOn(today()),target=D.dailyTarget*60,pct=Math.min(100,Math.round(m/target*100));document.getElementById('targetText').textContent=`${fmtM(m)} / ${D.dailyTarget}h`;document.getElementById('targetBar').style.width=pct+'%';document.getElementById('focusSummary').textContent=`${pct}% of today’s focus target. Quality work matters more than keeping the timer running.`}
function renderBackup(){if(!D.lastBackup){document.getElementById('backupInfo').textContent='No backup exported yet. Make one after your first real study session.';return}const d=Math.max(0,Math.floor((new Date(today())-new Date(D.lastBackup))/86400000));document.getElementById('backupInfo').textContent=d>=D.backupEvery?`Backup due — last backup ${d} day(s) ago.`:`Last backup: ${D.lastBackup}.`}
function renderNotes(){document.getElementById('notes').value=D.notes[today()]||''}
function renderReports(){
 const t=minsOn(today()),w=minsRange(7),m=monthMins();document.getElementById('rToday').textContent=fmtM(t);document.getElementById('rWeek').textContent=fmtM(w);document.getElementById('rMonth').textContent=fmtM(m);
 let days=[];let max=1;for(let i=6;i>=0;i--){let d=new Date();d.setDate(d.getDate()-i);let k=d.toISOString().slice(0,10),v=minsOn(k);max=Math.max(max,v);days.push({k,v,label:d.toLocaleDateString(undefined,{weekday:'short'})})}
 document.getElementById('dailyBars').innerHTML=days.map(x=>`<div class="barrow"><span class="small">${x.label}</span><div class="bar"><i style="width:${Math.round(x.v/max*100)}%"></i></div><span class="small">${fmtM(x.v)}</span></div>`).join('');
 const totals={};D.focusLog.forEach(x=>totals[x.stage]=(totals[x.stage]||0)+(+x.minutes||0));let sm=Math.max(1,...Object.values(totals));document.getElementById('skillBars').innerHTML=C.map(s=>`<div class="barrow"><span class="small">${esc(s.name)}</span><div class="bar"><i style="width:${Math.round((totals[s.id]||0)/sm*100)}%"></i></div><span class="small">${fmtM(totals[s.id]||0)}</span></div>`).join('')
}
document.getElementById('gate').onchange=e=>{if(!prerequisitesDone(cur())){e.target.checked=false;return}D.gates[cur().id]=e.target.checked;save();render()};
document.getElementById('next').onclick=()=>{if(D.gates[cur().id]&&D.currentStage<C.length-1){D.currentStage++;rebuildTasks();save();render()}};
document.getElementById('rebuild').onclick=rebuildTasks;
document.getElementById('what').onclick=()=>mentor(nextAction());
document.getElementById('stuck').onclick=()=>mentor(`<b>Stuck protocol:</b> 1) make the problem tiny, 2) try alone for 10 minutes, 3) compare expected vs actual output, 4) write the exact error/question, 5) look up only that gap. Do not restart the whole course and do not collect another playlist.`);
document.getElementById('finish').onclick=()=>mentor(`<b>Close today:</b> update only the day/project checkboxes you genuinely completed, write 2–3 lines in Daily Notes, and leave the first task for tomorrow visible. ${minsOn(today())?`You logged ${fmtM(minsOn(today()))} of real focus today.`:'No completed focus block is logged yet — that is okay if today was setup.'}`);
document.getElementById('add').onclick=()=>{let v=document.getElementById('taskText').value.trim();if(!v)return;D.tasks.push({id:Date.now(),text:v,stage:document.getElementById('taskStage').value,pom:Math.max(1,+document.getElementById('taskPom').value||1),done:false,auto:false});document.getElementById('taskText').value='';save();renderTasks()};
document.getElementById('customAdd').onclick=()=>{let n=document.getElementById('customName').value.trim(),g=document.getElementById('customGoal').value.trim();if(!n)return;D.customProjects.push({id:Date.now(),name:n,goal:g||'Optional personal project'});document.getElementById('customName').value='';document.getElementById('customGoal').value='';save();renderPortfolio()};
document.getElementById('notes').oninput=e=>{D.notes[today()]=e.target.value;save();document.getElementById('noteSaved').textContent='saved';clearTimeout(window.noteT);window.noteT=setTimeout(()=>document.getElementById('noteSaved').textContent='',900)};

let mode='focus',sec=0,running=false,timerInt=null;
function modeMinutes(){return mode==='focus'?D.focusMin:mode==='short'?D.shortMin:D.longMin}
function drawTimer(){document.getElementById('timer').textContent=`${String(Math.floor(sec/60)).padStart(2,'0')}:${String(sec%60).padStart(2,'0')}`;document.getElementById('timerHint').textContent=`${D.focusMin}m focus • ${D.shortMin}m short • ${D.longMin}m long`}
function setMode(m){mode=m;running=false;clearInterval(timerInt);sec=modeMinutes()*60;document.querySelectorAll('.mode').forEach(b=>b.classList.toggle('active',b.dataset.mode===m));document.getElementById('timerStart').textContent='START';drawTimer()}
function alarm(){if(D.alarm!=='on')return;try{const ctx=new (window.AudioContext||window.webkitAudioContext)(),o=ctx.createOscillator(),g=ctx.createGain();o.connect(g);g.connect(ctx.destination);o.frequency.value=880;g.gain.value=.12;o.start();setTimeout(()=>{o.stop();ctx.close()},500)}catch(e){}if(navigator.vibrate)navigator.vibrate([180,90,180])}
function finishTimer(){clearInterval(timerInt);running=false;alarm();if(mode==='focus'){D.focusLog.push({date:today(),minutes:D.focusMin,stage:cur().id,ts:Date.now()});updateStreak();save();render();mentor(`<b>Focus block complete.</b> You just added ${D.focusMin} minutes to ${cur().name}. Write one sentence about what you produced or understood, then take a short break.`);setMode('short')}else{mentor('<b>Break finished.</b> Return to the first unfinished mentor task.');setMode('focus')}}
document.querySelectorAll('.mode').forEach(b=>b.onclick=()=>setMode(b.dataset.mode));
document.getElementById('timerStart').onclick=()=>{if(running){running=false;clearInterval(timerInt);document.getElementById('timerStart').textContent='RESUME';return}running=true;document.getElementById('timerStart').textContent='PAUSE';timerInt=setInterval(()=>{sec--;drawTimer();if(sec<=0)finishTimer()},1000)};
document.getElementById('timerReset').onclick=()=>setMode(mode);

const settingsModal=document.getElementById('settingsModal'),reportsModal=document.getElementById('reportsModal');
document.getElementById('settings').onclick=()=>{name.value=D.name;startDate.value=D.startDate;target.value=D.dailyTarget;backupEvery.value=D.backupEvery;focusMin.value=D.focusMin;shortMin.value=D.shortMin;longMin.value=D.longMin;theme.value=D.theme;alarm.value=D.alarm;settingsModal.classList.add('show')};
document.getElementById('reportsBtn').onclick=()=>{renderReports();reportsModal.classList.add('show')};
document.querySelectorAll('[data-close]').forEach(b=>b.onclick=()=>document.getElementById(b.dataset.close).classList.remove('show'));
document.getElementById('saveSettings').onclick=()=>{D.name=name.value.trim();D.startDate=startDate.value||today();D.dailyTarget=+target.value;D.backupEvery=+backupEvery.value;D.focusMin=Math.max(10,+focusMin.value||25);D.shortMin=Math.max(1,+shortMin.value||5);D.longMin=Math.max(5,+longMin.value||15);D.theme=theme.value;D.alarm=alarm.value;save();settingsModal.classList.remove('show');setMode(mode);render()};
document.getElementById('resetAll').onclick=()=>{if(confirm('Export a backup first if you may need this progress. Reset everything?')&&confirm('Final confirmation: erase all local tracker progress?')){D=clone(DEF);save();settingsModal.classList.remove('show');setMode('focus');render()}};

document.getElementById('backup').onclick=()=>{D.lastBackup=today();save();let blob=new Blob([JSON.stringify({app:'DA Mentor OS',version:3,exportedAt:new Date().toISOString(),data:D},null,2)],{type:'application/json'}),a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download=`DA_Mentor_Backup_${today()}.json`;a.click();setTimeout(()=>URL.revokeObjectURL(a.href),1000);renderBackup()};
document.getElementById('restore').onclick=()=>document.getElementById('restoreFile').click();
document.getElementById('restoreFile').onchange=e=>{let f=e.target.files[0];if(!f)return;let r=new FileReader();r.onload=()=>{try{let o=JSON.parse(r.result),x=o.data||o;if(!x.version)throw 0;if(confirm('Restore this backup? Current local progress will be replaced.')){D=x;for(const k in DEF)if(D[k]===undefined)D[k]=clone(DEF[k]);save();applyTheme();setMode('focus');render();alert('Backup restored.')}}catch(err){alert('This is not a valid DA Mentor backup.')}};r.readAsText(f)};
document.getElementById('csv').onclick=()=>{let rows=[['date','minutes','stage','stage_name']];D.focusLog.forEach(x=>rows.push([x.date,x.minutes,x.stage,C.find(s=>s.id===x.stage)?.name||'']));let csv=rows.map(r=>r.map(v=>`"${String(v??'').replaceAll('"','""')}"`).join(',')).join('\n'),blob=new Blob([csv],{type:'text/csv'}),a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download=`DA_Mentor_Focus_${today()}.csv`;a.click();setTimeout(()=>URL.revokeObjectURL(a.href),1000)};

let deferredInstall=null;window.addEventListener('beforeinstallprompt',e=>{e.preventDefault();deferredInstall=e;document.getElementById('install').hidden=false});
document.getElementById('install').onclick=async()=>{if(!deferredInstall)return;deferredInstall.prompt();await deferredInstall.userChoice;deferredInstall=null;document.getElementById('install').hidden=true};
if('serviceWorker'in navigator)window.addEventListener('load',()=>navigator.serviceWorker.register('./service-worker.js').catch(()=>{}));

document.getElementById('taskStage').innerHTML=C.map(s=>`<option value="${s.id}">${s.name}</option>`).join('');document.getElementById('taskStage').value=cur().id;
if(!D.tasks.length)rebuildTasks();applyTheme();setMode('focus');render();save();
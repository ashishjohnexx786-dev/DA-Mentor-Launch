(()=>{
  const RECOMMENDED=new Set(["EF1","EF2","EF5","EF6","EF7","EF8","EF9","EFA1","EFA2","EFA3","EFA5","EFA7","EFA8","EFA9","EFA10","SF0","SF2","SF3","SF4","SF6","SF7","SF8","SA1","SA3","SA5","SA6","SA9","PBM0","PBM1","PBM2","PBM3","PBM4","PBM7","PBD5","PBD6","PBD7","PBD10","PY0","PY1","PY2","PY3","PY4","PY5","PY6","PY7","PY8","STAT1","STAT2","STAT3","STAT4","STAT5","STAT6","STAT8","IBA4","IBA6","IBA9","AIA8","PCH4","PCH7","PCH11","PCH12","PCH13"]);
  const status=id=>RECOMMENDED.has(id)?"☑ Recommended visual":"☐ Not required";
  function applyData(){if(typeof C!=="undefined")C.forEach(p=>p.plan.forEach(u=>{u.videoStatus=status(u.id);u.videoUrl="";}));}
  function decorate(){
    const p=typeof cur==="function"?cur():null;if(!p)return;
    document.querySelectorAll("#schedule .item").forEach((row,i)=>{
      row.querySelector(".courseVideoStatus")?.remove();const u=p.plan[i];if(!u)return;
      const el=document.createElement("div");el.className="small courseVideoStatus";el.textContent=`Video: ${u.videoStatus||status(u.id)}`;
      row.querySelector(".grow")?.appendChild(el);
    });
  }
  function loadOptionalVideos(){
    if(!document.querySelector('link[data-optional-videos]')){const l=document.createElement('link');l.rel='stylesheet';l.href='./optional-videos.css';l.dataset.optionalVideos='1';document.head.appendChild(l);}
    if(window.OPTIONAL_VIDEO_MAP){if(!document.querySelector('script[data-optional-video-ui]')){const u=document.createElement('script');u.src='./optional-videos-ui.js';u.dataset.optionalVideoUi='1';document.body.appendChild(u);}return;}
    if(!document.querySelector('script[data-optional-video-map]')){const m=document.createElement('script');m.src='./optional-videos.js';m.dataset.optionalVideoMap='1';m.onload=()=>{if(!document.querySelector('script[data-optional-video-ui]')){const u=document.createElement('script');u.src='./optional-videos-ui.js';u.dataset.optionalVideoUi='1';document.body.appendChild(u);}};document.body.appendChild(m);}
  }
  function install(){
    applyData();
    const style=document.createElement("style");style.textContent=".courseVideoStatus{margin-top:4px;font-weight:650;opacity:.9}";document.head.appendChild(style);
    if(typeof render==="function"){const base=render;render=function(){base();decorate()};render();}
    const backupBtn=document.getElementById("backup");
    if(backupBtn&&typeof download==="function")backupBtn.onclick=()=>{D.lastBackup=today();save();download(`DA_Mentor_Launch_Backup_${today()}.json`,JSON.stringify({product:"DA Mentor Launch",version:4,exportedAt:new Date().toISOString(),data:D},null,2));renderBackup()};
    const restore=document.getElementById("restoreFile");
    if(restore)restore.onchange=e=>{const file=e.target.files?.[0];if(!file)return;const r=new FileReader();r.onload=()=>{try{const raw=JSON.parse(r.result),data=raw.data||raw;if(+data.version===4){D=Object.assign(clone(DEF),data);save();render();alert("DA Mentor Launch backup restored.")}else if(+data.version===3){if(!confirm("This is a legacy Course 1 backup. Only settings, notes and focus history will be migrated; old curriculum completion will not be marked complete. Continue?"))return;const n=clone(DEF);["name","startDate","dailyTarget","backupEvery","focusMin","shortMin","longMin","theme","alarm","notes","focusLog","streak","lastBackup","customProjects"].forEach(k=>{if(data[k]!==undefined)n[k]=clone(data[k])});n.legacyNotice=true;D=n;save();render();alert("Legacy settings/history migrated into DA Mentor Launch.")}else throw new Error("Unsupported backup version")}catch(err){alert("Could not restore this backup: "+err.message)}finally{e.target.value=""}};r.readAsText(file)};
    loadOptionalVideos();
  }
  if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",install);else install();
})();

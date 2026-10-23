module.exports=async function handler(req,res){
res.setHeader('Access-Control-Allow-Origin','*');res.setHeader('Cache-Control','s-maxage=86400, stale-while-revalidate=604800');
if(req.method!=='GET')return res.status(405).json({error:'Méthode non autorisée'});
const q=String(req.query.q||'').trim().slice(0,100);if(q.length<2)return res.status(400).json({error:'Zone invalide'});
try{const u=`https://nominatim.openstreetmap.org/search?format=jsonv2&limit=5&countrycodes=tn&accept-language=fr&q=${encodeURIComponent(q+', Tunisie')}`;const r=await fetch(u,{headers:{'User-Agent':'PharmaSearchTN/1.0 (Vercel application)'}});if(!r.ok)throw Error(`Géocodage HTTP ${r.status}`);const data=await r.json();return res.status(200).json({results:data.map(x=>({lat:+x.lat,lon:+x.lon,label:x.display_name,type:x.type}))})}catch(e){return res.status(502).json({error:e.message})}}

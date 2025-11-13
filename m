Return-Path: <linux-wireless+bounces-28938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE36C5A8E5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 00:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33597348EF1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 23:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F9329398;
	Thu, 13 Nov 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp9gY1Uo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C722328B50
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076593; cv=none; b=UI+A+VK22w4jmjf926Kq2Fie5mCuKhDijseGZ8aiRCKKIUadcBBoUUu+e/nccPhi1gsA3cj0JiUxPWM0zRBZ0V5h+IJo8FyMsd9PtQAdoQc+BAj9ts8I1ju85TnVj8LgVACMuHBk9mvm/i4W7RqSBcfGVOPyZr/pGx/PbkeeoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076593; c=relaxed/simple;
	bh=NRKqCqQ12HO15XFU5FcunMpsiy+wGlVUDa3DgtZvipE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6WczEHx4HZO2UvzMmCvnXI11lDpKrsVfOESowpiZAH8I3cnLHN8erDoGtbqstSmGN8e7A0G8hNgGwjb0aGWvaNNIJEV02++5QLTPWdqEXRATMybC2ra4veyDxJB4Js69PEBFrhWhSOJmJx8XSvfA0ys2s7dWhVb0TfyUeLPRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp9gY1Uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D12FC4AF09;
	Thu, 13 Nov 2025 23:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763076592;
	bh=NRKqCqQ12HO15XFU5FcunMpsiy+wGlVUDa3DgtZvipE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lp9gY1Uo7OuvVXw0LBJyWmJMNIpp+5m/Ylr1OWDeZ5+JK7RFLiLLQj126dgDAFImx
	 oQ0svmrGEx6pCwlK8mNhh+pkdYfLFlKqs1zbOl0J+e/1vAUEMqmKE0hQ0r2RvRN0P0
	 NLeDJBEfCDwAl16ugo6lGBCbn/M7ezEpuDWkIwPBcF8Oqybvuf9o1jJGPZy17zy2OB
	 9Lg16+2XKublYS65jA8jSDz5W/9zRnpVuVW8onuXtWg1Jt2XWOna2ukC3OepcXgNMc
	 ch3YjjoNpCDm6vi1nHWKSFwbqc9UM7wZq1F5qThqPvO3vxASvazLiZ+IOxFbT+3phH
	 Kr2qj2bS8Lm0w==
Date: Fri, 14 Nov 2025 00:29:49 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
	Felix Fietkau <nbd@nbd.name>
Subject: Re: mtk7996 lockdep & rcu splat in upstream kernel.
Message-ID: <aRZp7RYn0p34CVWA@lore-desk>
References: <b0218060-3987-ed7d-55f3-43d1978579ea@candelatech.com>
 <aRWdqZAfVPgb-KxY@lore-desk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6qhngtC6fjNYlK9r"
Content-Disposition: inline
In-Reply-To: <aRWdqZAfVPgb-KxY@lore-desk>


--6qhngtC6fjNYlK9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 13, Lorenzo Bianconi wrote:
> > Hello Lorenzo & Felix,
>=20
> Hi Ben,
>=20
> >=20
> > With the hack to fix the crash I just posted, the kernel can get far en=
ough to
> > show this lockdep splat.  I cannot find any code that grabs the wiphy m=
tx
> > in this path, and yet if I try to add an explicit mutex_lock lock in th=
e scan code, then
> > I get kernel deadlocks.  Maybe I'm just putting the lock in the wrong p=
lace.
> >=20
> > Any idea how this is supposed to work with regards to wiphy locking?
> >=20
> > And in addition, there is RCU splat immediately after the key.c related
> > splat.
> >=20
> >    315 Nov 12 10:40:51 ct523c-a0af kernel: ------------[ cut here ]----=
--------
> >    316 Nov 12 10:40:51 ct523c-a0af kernel: WARNING: CPU: 1 PID: 115 at =
net/mac80211/key.c:1029 ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
> >    317 Nov 12 10:40:51 ct523c-a0af kernel: Modules linked in: vrf
> > nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ip=
v4
> > 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_co=
re
> > qrtr bnep snd_hda_codec_intelhdmi intel_rapl_msr snd_hda_codec_hdmi
> > iTCO_wdt coretemp ee1004 intel_pmc_bxt iTCO_vendor_support intel_rapl_c=
ommon
> > snd_hda_codec_alc662 intel_uncore_frequency snd_hda_codec_realtek_lib
> > intel_uncore_frequency_common snd_hda_codec_generic iwlmld mt7996e
> > intel_tcc_cooling snd_hda_intel mt76_connac_lib         mt76
> > x86_pkg_temp_thermal snd_intel_dspcfg snd_hda_codec intel_powerclamp pc=
spkr
> > snd_hda_core mac80211 intel_wmi_thunderbolt iwlwifi
> > snd_hwdep btusb snd_seq btbcm snd_seq_device btmtk btrtl btintel joydev
> > bluetooth snd_pcm cfg80211 i2c_i801 snd_timer i2c_smbus bfq snd
> > i2c_mux soundcore intel_pmc_core mei_pxp mei_hdcp intel_pch_thermal
> > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry
> > intel_vsec acpi_pad nfsd auth_rpcgss nfs_acl lockd grace nfs_localio
> > sch_fq_codel sunrpc fuse zram raid1 dm_raid
> >    318 Nov 12 10:40:51 ct523c-a0af kernel:  raid456 async_raid6_recov
> > async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy
> > intel_gtt drm_client_lib drm_display_helper drm_kms_helper cec rc_core =
igb
> > ttm intel_oc_wdt agpgart i2c_algo_bit ixgbe mdio libie_fwlog dca drm hw=
mon
> > mei_wdt i2c_core video wmi [last unloaded: nfnetlink]
> >    319 Nov 12 10:40:51 ct523c-a0af kernel: CPU: 1 UID: 0 PID: 115 Comm:=
 kworker/u32:4 Tainted: G S                  6.18.0-rc5+ #25 PREEMPT(full)
> >    320 Nov 12 10:40:51 ct523c-a0af kernel: Tainted: [S]=3DCPU_OUT_OF_SP=
EC
> >    321 Nov 12 10:40:51 ct523c-a0af kernel: Hardware name: Default strin=
g Default string/SKYBAY, BIOS 5.12 02/15/2023
> >    322 Nov 12 10:40:51 ct523c-a0af kernel: Workqueue: phy2 mt76_scan_wo=
rk [mt76]
> >    323 Nov 12 10:40:51 ct523c-a0af kernel: RIP: 0010:ieee80211_iter_key=
s+0xe4/0x1a0 [mac80211]
> >    324 Nov 12 10:40:51 ct523c-a0af kernel: Code: 4c 48 83 c4 10 5b 5d 4=
1 5c
> > 41 5d 41 5e 41 5f c3 48 8b 47 48 be ff ff ff ff 48 8d 78 68 e8 04 ec fe
> > e0 85 c0 0f 85 49 ff ff ff <0f> 0b 4d 85 ed 0f 85 47 ff ff ff 4c 8b ab =
90 1a
> > 00 00 48 8d 83 90
> >    325 Nov 12 10:40:51 ct523c-a0af kernel: RSP: 0018:ffffc90000f1fcb0 E=
FLAGS: 00010246
> >    326 Nov 12 10:40:51 ct523c-a0af kernel: RAX: 0000000000000000 RBX: f=
fff888132710ee0 RCX: 0000000000000000
> >    327 Nov 12 10:40:51 ct523c-a0af kernel: RDX: 0000000000000000 RSI: f=
fff888132710788 RDI: ffff8881158435c8
> >    328 Nov 12 10:40:51 ct523c-a0af kernel: RBP: ffffffffa0de5400 R08: 0=
000000000000001 R09: 00000000f9936176
> >    329 Nov 12 10:40:51 ct523c-a0af kernel: R10: 0000000000000001 R11: f=
fff8881158435a0 R12: ffffc90000f1fd00
> >    330 Nov 12 10:40:51 ct523c-a0af kernel: R13: ffff88811642aa80 R14: f=
fff88813271afc8 R15: 000000000000043f
> >    331 Nov 12 10:40:51 ct523c-a0af kernel: FS:  0000000000000000(0000) =
GS:ffff8884da4c6000(0000) knlGS:0000000000000000
> >    332 Nov 12 10:40:51 ct523c-a0af kernel: CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
> >    333 Nov 12 10:40:51 ct523c-a0af kernel: CR2: 0000000000422bcc CR3: 0=
000000002c52004 CR4: 00000000003706f0
> >    334 Nov 12 10:40:51 ct523c-a0af kernel: Call Trace:
> >    335 Nov 12 10:40:51 ct523c-a0af kernel:  <TASK>
> >    336 Nov 12 10:40:51 ct523c-a0af kernel:  ? lock_acquire+0xc2/0x2c0
> >    337 Nov 12 10:40:51 ct523c-a0af kernel:  mt7996_vif_link_remove+0x66=
/0x290 [mt7996e]
> >    338 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_put_vif_phy_link+0x41/=
0x50 [mt76]
> >    339 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_complete+0x77/0x1=
00 [mt76]
> >    340 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_work+0x30a/0x440 =
[mt76]
> >    341 Nov 12 10:40:51 ct523c-a0af kernel:  ? process_one_work+0x1e5/0x=
6d0
> >    342 Nov 12 10:40:51 ct523c-a0af kernel:  process_one_work+0x221/0x6d0
> >    343 Nov 12 10:40:51 ct523c-a0af kernel:  worker_thread+0x19a/0x340
> >    344 Nov 12 10:40:51 ct523c-a0af kernel:  ? rescuer_thread+0x450/0x450
> >    345 Nov 12 10:40:51 ct523c-a0af kernel:  kthread+0x108/0x220
> >    346 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110=
/0x110
> >    347 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork+0x1c6/0x220
> >    348 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110=
/0x110
> >    349 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork_asm+0x11/0x20
> >    350 Nov 12 10:40:51 ct523c-a0af kernel:  </TASK>
> >    351 Nov 12 10:40:51 ct523c-a0af kernel: irq event stamp: 27647
> >    352 Nov 12 10:40:51 ct523c-a0af kernel: hardirqs last  enabled at (2=
7653): [<ffffffff813d447e>] __up_console_sem+0x5e/0x70
> >    353 Nov 12 10:40:51 ct523c-a0af kernel: hardirqs last disabled at (2=
7658): [<ffffffff813d4463>] __up_console_sem+0x43/0x70
> >    354 Nov 12 10:40:51 ct523c-a0af kernel: softirqs last  enabled at (2=
6676): [<ffffffff81f2ad9c>] napi_pp_put_page+0xac/0xd0
> > 355 Nov 12 10:40:51 ct523c-a0af kernel: softirqs last disabled at (2667=
4): [<ffffffff81fa3230>] page_pool_put_unrefed_netmem+0x290/0x3d0
> >    356 Nov 12 10:40:51 ct523c-a0af kernel: ---[ end trace 0000000000000=
000 ]---
> >    357 Nov 12 10:40:51 ct523c-a0af kernel:
> >    358 Nov 12 10:40:51 ct523c-a0af kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    359 Nov 12 10:40:51 ct523c-a0af kernel: WARNING: suspicious RCU usage
> >    360 Nov 12 10:40:51 ct523c-a0af kernel: 6.18.0-rc5+ #25 Tainted: G S=
      W
> >    361 Nov 12 10:40:51 ct523c-a0af kernel: -----------------------------
> >    362 Nov 12 10:40:51 ct523c-a0af kernel: drivers/net/wireless/mediate=
k/mt76/mt7996/main.c:415 suspicious rcu_dereference_check() usage!
> >    363 Nov 12 10:40:51 ct523c-a0af kernel:
> >    364                                     other info that might help u=
s debug this:
> >    365 Nov 12 10:40:51 ct523c-a0af kernel:
> >    366                                     rcu_scheduler_active =3D 2, =
debug_locks =3D 1
> >    367 Nov 12 10:40:51 ct523c-a0af kernel: 2 locks held by kworker/u32:=
4/115:
> >    368 Nov 12 10:40:51 ct523c-a0af kernel:  #0: ffff888118ebdd48 ((wq_c=
ompletion)phy2){+.+.}-{0:0}, at: process_one_work+0x41c/0x6d0
> >    369 Nov 12 10:40:51 ct523c-a0af kernel:  #1: ffffc90000f1fe38
> > ((work_completion)(&(&dev->scan_work)->work)){+.+.}-{0:0}, at:
> > process_one_work+ 0x1e5/0x6d0
> >    370 Nov 12 10:40:51 ct523c-a0af kernel:
> >    371                                     stack backtrace:
> >    372 Nov 12 10:40:51 ct523c-a0af kernel: CPU: 1 UID: 0 PID: 115 Comm:=
 kworker/u32:4 Tainted: G S      W           6.18.0-rc5+ #25 PREEMPT(full)
> >    373 Nov 12 10:40:51 ct523c-a0af kernel: Tainted: [S]=3DCPU_OUT_OF_SP=
EC, [W]=3DWARN
> >    374 Nov 12 10:40:51 ct523c-a0af kernel: Hardware name: Default strin=
g Default string/SKYBAY, BIOS 5.12 02/15/2023
> >    375 Nov 12 10:40:51 ct523c-a0af kernel: Workqueue: phy2 mt76_scan_wo=
rk [mt76]
> >    376 Nov 12 10:40:51 ct523c-a0af kernel: Call Trace:
> >    377 Nov 12 10:40:51 ct523c-a0af kernel:  <TASK>
> >    378 Nov 12 10:40:51 ct523c-a0af kernel:  dump_stack_lvl+0x8d/0xa0
> >    379 Nov 12 10:40:51 ct523c-a0af kernel:  lockdep_rcu_suspicious+0x14=
6/0x1a0
> >    380 Nov 12 10:40:51 ct523c-a0af kernel:  mt7996_vif_link_remove+0x27=
9/0x290 [mt7996e]
> >    381 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_put_vif_phy_link+0x41/=
0x50 [mt76]
> >    382 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_complete+0x77/0x1=
00 [mt76]
> >    383 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_work+0x30a/0x440 =
[mt76]
> >    384 Nov 12 10:40:51 ct523c-a0af kernel:  ? process_one_work+0x1e5/0x=
6d0
> >    385 Nov 12 10:40:51 ct523c-a0af kernel:  process_one_work+0x221/0x6d0
> >    386 Nov 12 10:40:51 ct523c-a0af kernel:  worker_thread+0x19a/0x340
> >    387 Nov 12 10:40:51 ct523c-a0af kernel:  ? rescuer_thread+0x450/0x450
> >    388 Nov 12 10:40:51 ct523c-a0af kernel:  kthread+0x108/0x220
> >    389 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110=
/0x110
> >    390 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork+0x1c6/0x220
> >    391 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110=
/0x110
> >    392 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork_asm+0x11/0x20
> >    393 Nov 12 10:40:51 ct523c-a0af kernel:  </TASK>
> >    394 Nov 12 10:40:54 ct523c-a0af kernel: ixgbe 0000:01:00.0 eth2: NIC=
 Link is Up 10 Gbps, Flow Control: RX/TX
> >    395 Nov 12 10:40:54 ct523c-a0af kernel: ------------[ cut here ]----=
--------
> >=20
> > Thanks,
> > Ben
>=20
> I think the problem here is mt76_put_vif_phy_link() runs without grabbing
> wiphy mutex in mt76_scan_complete() so we cant' run for_each_vif_active_l=
ink().
> I will work on a fix.
>=20
> Regards,
> Lorenzo

Hi Ben,

Can you please try the following patch?

Regards,
Lorenzo

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net=
/wireless/mediatek/mt76/mt7996/main.c
index d30fcedf121f..f63053068e54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -370,7 +370,8 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct i=
eee80211_vif *vif,
=20
 	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &it);
=20
-	if (mvif->mt76.deflink_id =3D=3D IEEE80211_LINK_UNSPECIFIED)
+	if (mvif->mt76.deflink_id =3D=3D IEEE80211_LINK_UNSPECIFIED &&
+	    !mlink->offchannel)
 		mvif->mt76.deflink_id =3D link_conf->link_id;
=20
 	return 0;
@@ -401,7 +402,8 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, stru=
ct ieee80211_vif *vif,
=20
 	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
=20
-	if (mvif->mt76.deflink_id =3D=3D link_conf->link_id) {
+	if (mvif->mt76.deflink_id =3D=3D link_conf->link_id &&
+	    !mlink->offchannel) {
 		struct ieee80211_bss_conf *iter;
 		unsigned int link_id;
=20

>=20
> >=20
> > --=20
> > Ben Greear <greearb@candelatech.com>
> > Candela Technologies Inc  http://www.candelatech.com
> >=20



--6qhngtC6fjNYlK9r
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaRZp7QAKCRA6cBh0uS2t
rMwRAQCpY2OqJNooUaf8svc3bKezx8GX5Y56vVEDTgDQ0L+dWgEA4JrxyUDTa0Hq
XxuU3qmkvttyVXj1+7qq5lL1R7KCTg8=
=Fv28
-----END PGP SIGNATURE-----

--6qhngtC6fjNYlK9r--


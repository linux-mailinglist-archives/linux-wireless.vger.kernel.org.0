Return-Path: <linux-wireless+bounces-28899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA624C56846
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 10:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 506304F30BA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24304331A7D;
	Thu, 13 Nov 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI1RO3bG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F031E331A4A
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024301; cv=none; b=uCc9877LbHh6NDIF3K5OjJS9qjdwNY+1FkZHZXY5PO8yWe7t0+7vSg2FaWKh+MISedR1H5olJ4RqQzxQZIcd+n0pJ0iaswqAREke8SGbrC4zzBhrJULEq1WpLrrmkiqGXumNvWPMc5MAFK0ehnFBRghAPzunVFEFyEQ930YrL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024301; c=relaxed/simple;
	bh=n1wv4U5CIlFwYDtw3iSCvQGN4haRgRcLhhixB96nJr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gD1RAdWJiIWpiM1/iRhSOz3T/9EZyJqOhD1Y3HwUTD7RSEx42vylBBJJUWEwq9WbuOj4kaU0Sp7c09m4GjZ9N0eXUCZ6jJ6Co7CxakLERIqBFlZxuEh6Exuc4R/FFX149B82WpAywd4bEeoB5IjZ8q2+DSesEIOloBn09zZnMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI1RO3bG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03A2C19421;
	Thu, 13 Nov 2025 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763024300;
	bh=n1wv4U5CIlFwYDtw3iSCvQGN4haRgRcLhhixB96nJr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QI1RO3bGoFjN30oA/jzt38xKqujecPp+Ag3XgjSKrrWe5vMj6Cya6ELdUS81+HZYW
	 pCxLAJ8XT9u6slj10M8uavDucikIsA7Jt0PBg2m0FluRTeBRFuY6KYu4NqpWOR/z6E
	 PbVR1svIDYAVfvu1MpsvyJGhV7UuZIRRER8H9BZ/NdyAZaLqRzubVUzAndYPIWq6aa
	 gpQ0ThDykSfE5iUNJhl2yLoxbVhEKC13abRIWHJHNLuuAukNN+cYDWYrxr9IqRyzjw
	 hQE5Tz54f93JyMl5HFFB/OHSMWfGk8tuk4rouLsaDJFvVTEkCXHTpGU6jTYBo6rZVp
	 0eb7MQs6b4lwQ==
Date: Thu, 13 Nov 2025 09:58:17 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
	Felix Fietkau <nbd@nbd.name>
Subject: Re: mtk7996 lockdep & rcu splat in upstream kernel.
Message-ID: <aRWdqZAfVPgb-KxY@lore-desk>
References: <b0218060-3987-ed7d-55f3-43d1978579ea@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dlI/xuWW8vuT2WiG"
Content-Disposition: inline
In-Reply-To: <b0218060-3987-ed7d-55f3-43d1978579ea@candelatech.com>


--dlI/xuWW8vuT2WiG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo & Felix,

Hi Ben,

>=20
> With the hack to fix the crash I just posted, the kernel can get far enou=
gh to
> show this lockdep splat.  I cannot find any code that grabs the wiphy mtx
> in this path, and yet if I try to add an explicit mutex_lock lock in the =
scan code, then
> I get kernel deadlocks.  Maybe I'm just putting the lock in the wrong pla=
ce.
>=20
> Any idea how this is supposed to work with regards to wiphy locking?
>=20
> And in addition, there is RCU splat immediately after the key.c related
> splat.
>=20
>    315 Nov 12 10:40:51 ct523c-a0af kernel: ------------[ cut here ]------=
------
>    316 Nov 12 10:40:51 ct523c-a0af kernel: WARNING: CPU: 1 PID: 115 at ne=
t/mac80211/key.c:1029 ieee80211_iter_keys+0xe4/0x1a0 [mac80211]
>    317 Nov 12 10:40:51 ct523c-a0af kernel: Modules linked in: vrf
> nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4
> 8021q garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core
> qrtr bnep snd_hda_codec_intelhdmi intel_rapl_msr snd_hda_codec_hdmi
> iTCO_wdt coretemp ee1004 intel_pmc_bxt iTCO_vendor_support intel_rapl_com=
mon
> snd_hda_codec_alc662 intel_uncore_frequency snd_hda_codec_realtek_lib
> intel_uncore_frequency_common snd_hda_codec_generic iwlmld mt7996e
> intel_tcc_cooling snd_hda_intel mt76_connac_lib         mt76
> x86_pkg_temp_thermal snd_intel_dspcfg snd_hda_codec intel_powerclamp pcsp=
kr
> snd_hda_core mac80211 intel_wmi_thunderbolt iwlwifi
> snd_hwdep btusb snd_seq btbcm snd_seq_device btmtk btrtl btintel joydev
> bluetooth snd_pcm cfg80211 i2c_i801 snd_timer i2c_smbus bfq snd
> i2c_mux soundcore intel_pmc_core mei_pxp mei_hdcp intel_pch_thermal
> pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry
> intel_vsec acpi_pad nfsd auth_rpcgss nfs_acl lockd grace nfs_localio
> sch_fq_codel sunrpc fuse zram raid1 dm_raid
>    318 Nov 12 10:40:51 ct523c-a0af kernel:  raid456 async_raid6_recov
> async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy
> intel_gtt drm_client_lib drm_display_helper drm_kms_helper cec rc_core igb
> ttm intel_oc_wdt agpgart i2c_algo_bit ixgbe mdio libie_fwlog dca drm hwmon
> mei_wdt i2c_core video wmi [last unloaded: nfnetlink]
>    319 Nov 12 10:40:51 ct523c-a0af kernel: CPU: 1 UID: 0 PID: 115 Comm: k=
worker/u32:4 Tainted: G S                  6.18.0-rc5+ #25 PREEMPT(full)
>    320 Nov 12 10:40:51 ct523c-a0af kernel: Tainted: [S]=3DCPU_OUT_OF_SPEC
>    321 Nov 12 10:40:51 ct523c-a0af kernel: Hardware name: Default string =
Default string/SKYBAY, BIOS 5.12 02/15/2023
>    322 Nov 12 10:40:51 ct523c-a0af kernel: Workqueue: phy2 mt76_scan_work=
 [mt76]
>    323 Nov 12 10:40:51 ct523c-a0af kernel: RIP: 0010:ieee80211_iter_keys+=
0xe4/0x1a0 [mac80211]
>    324 Nov 12 10:40:51 ct523c-a0af kernel: Code: 4c 48 83 c4 10 5b 5d 41 =
5c
> 41 5d 41 5e 41 5f c3 48 8b 47 48 be ff ff ff ff 48 8d 78 68 e8 04 ec fe
> e0 85 c0 0f 85 49 ff ff ff <0f> 0b 4d 85 ed 0f 85 47 ff ff ff 4c 8b ab 90=
 1a
> 00 00 48 8d 83 90
>    325 Nov 12 10:40:51 ct523c-a0af kernel: RSP: 0018:ffffc90000f1fcb0 EFL=
AGS: 00010246
>    326 Nov 12 10:40:51 ct523c-a0af kernel: RAX: 0000000000000000 RBX: fff=
f888132710ee0 RCX: 0000000000000000
>    327 Nov 12 10:40:51 ct523c-a0af kernel: RDX: 0000000000000000 RSI: fff=
f888132710788 RDI: ffff8881158435c8
>    328 Nov 12 10:40:51 ct523c-a0af kernel: RBP: ffffffffa0de5400 R08: 000=
0000000000001 R09: 00000000f9936176
>    329 Nov 12 10:40:51 ct523c-a0af kernel: R10: 0000000000000001 R11: fff=
f8881158435a0 R12: ffffc90000f1fd00
>    330 Nov 12 10:40:51 ct523c-a0af kernel: R13: ffff88811642aa80 R14: fff=
f88813271afc8 R15: 000000000000043f
>    331 Nov 12 10:40:51 ct523c-a0af kernel: FS:  0000000000000000(0000) GS=
:ffff8884da4c6000(0000) knlGS:0000000000000000
>    332 Nov 12 10:40:51 ct523c-a0af kernel: CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
>    333 Nov 12 10:40:51 ct523c-a0af kernel: CR2: 0000000000422bcc CR3: 000=
0000002c52004 CR4: 00000000003706f0
>    334 Nov 12 10:40:51 ct523c-a0af kernel: Call Trace:
>    335 Nov 12 10:40:51 ct523c-a0af kernel:  <TASK>
>    336 Nov 12 10:40:51 ct523c-a0af kernel:  ? lock_acquire+0xc2/0x2c0
>    337 Nov 12 10:40:51 ct523c-a0af kernel:  mt7996_vif_link_remove+0x66/0=
x290 [mt7996e]
>    338 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_put_vif_phy_link+0x41/0x=
50 [mt76]
>    339 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_complete+0x77/0x100=
 [mt76]
>    340 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_work+0x30a/0x440 [m=
t76]
>    341 Nov 12 10:40:51 ct523c-a0af kernel:  ? process_one_work+0x1e5/0x6d0
>    342 Nov 12 10:40:51 ct523c-a0af kernel:  process_one_work+0x221/0x6d0
>    343 Nov 12 10:40:51 ct523c-a0af kernel:  worker_thread+0x19a/0x340
>    344 Nov 12 10:40:51 ct523c-a0af kernel:  ? rescuer_thread+0x450/0x450
>    345 Nov 12 10:40:51 ct523c-a0af kernel:  kthread+0x108/0x220
>    346 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0=
x110
>    347 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork+0x1c6/0x220
>    348 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0=
x110
>    349 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork_asm+0x11/0x20
>    350 Nov 12 10:40:51 ct523c-a0af kernel:  </TASK>
>    351 Nov 12 10:40:51 ct523c-a0af kernel: irq event stamp: 27647
>    352 Nov 12 10:40:51 ct523c-a0af kernel: hardirqs last  enabled at (276=
53): [<ffffffff813d447e>] __up_console_sem+0x5e/0x70
>    353 Nov 12 10:40:51 ct523c-a0af kernel: hardirqs last disabled at (276=
58): [<ffffffff813d4463>] __up_console_sem+0x43/0x70
>    354 Nov 12 10:40:51 ct523c-a0af kernel: softirqs last  enabled at (266=
76): [<ffffffff81f2ad9c>] napi_pp_put_page+0xac/0xd0
> 355 Nov 12 10:40:51 ct523c-a0af kernel: softirqs last disabled at (26674)=
: [<ffffffff81fa3230>] page_pool_put_unrefed_netmem+0x290/0x3d0
>    356 Nov 12 10:40:51 ct523c-a0af kernel: ---[ end trace 000000000000000=
0 ]---
>    357 Nov 12 10:40:51 ct523c-a0af kernel:
>    358 Nov 12 10:40:51 ct523c-a0af kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    359 Nov 12 10:40:51 ct523c-a0af kernel: WARNING: suspicious RCU usage
>    360 Nov 12 10:40:51 ct523c-a0af kernel: 6.18.0-rc5+ #25 Tainted: G S  =
    W
>    361 Nov 12 10:40:51 ct523c-a0af kernel: -----------------------------
>    362 Nov 12 10:40:51 ct523c-a0af kernel: drivers/net/wireless/mediatek/=
mt76/mt7996/main.c:415 suspicious rcu_dereference_check() usage!
>    363 Nov 12 10:40:51 ct523c-a0af kernel:
>    364                                     other info that might help us =
debug this:
>    365 Nov 12 10:40:51 ct523c-a0af kernel:
>    366                                     rcu_scheduler_active =3D 2, de=
bug_locks =3D 1
>    367 Nov 12 10:40:51 ct523c-a0af kernel: 2 locks held by kworker/u32:4/=
115:
>    368 Nov 12 10:40:51 ct523c-a0af kernel:  #0: ffff888118ebdd48 ((wq_com=
pletion)phy2){+.+.}-{0:0}, at: process_one_work+0x41c/0x6d0
>    369 Nov 12 10:40:51 ct523c-a0af kernel:  #1: ffffc90000f1fe38
> ((work_completion)(&(&dev->scan_work)->work)){+.+.}-{0:0}, at:
> process_one_work+ 0x1e5/0x6d0
>    370 Nov 12 10:40:51 ct523c-a0af kernel:
>    371                                     stack backtrace:
>    372 Nov 12 10:40:51 ct523c-a0af kernel: CPU: 1 UID: 0 PID: 115 Comm: k=
worker/u32:4 Tainted: G S      W           6.18.0-rc5+ #25 PREEMPT(full)
>    373 Nov 12 10:40:51 ct523c-a0af kernel: Tainted: [S]=3DCPU_OUT_OF_SPEC=
, [W]=3DWARN
>    374 Nov 12 10:40:51 ct523c-a0af kernel: Hardware name: Default string =
Default string/SKYBAY, BIOS 5.12 02/15/2023
>    375 Nov 12 10:40:51 ct523c-a0af kernel: Workqueue: phy2 mt76_scan_work=
 [mt76]
>    376 Nov 12 10:40:51 ct523c-a0af kernel: Call Trace:
>    377 Nov 12 10:40:51 ct523c-a0af kernel:  <TASK>
>    378 Nov 12 10:40:51 ct523c-a0af kernel:  dump_stack_lvl+0x8d/0xa0
>    379 Nov 12 10:40:51 ct523c-a0af kernel:  lockdep_rcu_suspicious+0x146/=
0x1a0
>    380 Nov 12 10:40:51 ct523c-a0af kernel:  mt7996_vif_link_remove+0x279/=
0x290 [mt7996e]
>    381 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_put_vif_phy_link+0x41/0x=
50 [mt76]
>    382 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_complete+0x77/0x100=
 [mt76]
>    383 Nov 12 10:40:51 ct523c-a0af kernel:  mt76_scan_work+0x30a/0x440 [m=
t76]
>    384 Nov 12 10:40:51 ct523c-a0af kernel:  ? process_one_work+0x1e5/0x6d0
>    385 Nov 12 10:40:51 ct523c-a0af kernel:  process_one_work+0x221/0x6d0
>    386 Nov 12 10:40:51 ct523c-a0af kernel:  worker_thread+0x19a/0x340
>    387 Nov 12 10:40:51 ct523c-a0af kernel:  ? rescuer_thread+0x450/0x450
>    388 Nov 12 10:40:51 ct523c-a0af kernel:  kthread+0x108/0x220
>    389 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0=
x110
>    390 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork+0x1c6/0x220
>    391 Nov 12 10:40:51 ct523c-a0af kernel:  ? kthreads_online_cpu+0x110/0=
x110
>    392 Nov 12 10:40:51 ct523c-a0af kernel:  ret_from_fork_asm+0x11/0x20
>    393 Nov 12 10:40:51 ct523c-a0af kernel:  </TASK>
>    394 Nov 12 10:40:54 ct523c-a0af kernel: ixgbe 0000:01:00.0 eth2: NIC L=
ink is Up 10 Gbps, Flow Control: RX/TX
>    395 Nov 12 10:40:54 ct523c-a0af kernel: ------------[ cut here ]------=
------
>=20
> Thanks,
> Ben

I think the problem here is mt76_put_vif_phy_link() runs without grabbing
wiphy mutex in mt76_scan_complete() so we cant' run for_each_vif_active_lin=
k().
I will work on a fix.

Regards,
Lorenzo

>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>=20

--dlI/xuWW8vuT2WiG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaRWdqQAKCRA6cBh0uS2t
rEC4AQDJnHC2LhgVo1/V3DY/BhSBlacU9vO9pKuULGWlwkPxpwD+PvKG81HFk/i7
xXaEBx+EC5g4BV7+AdZk8YUYmlWdvws=
=x9tE
-----END PGP SIGNATURE-----

--dlI/xuWW8vuT2WiG--


Return-Path: <linux-wireless+bounces-12855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE4E9788FC
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 21:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235391C21A94
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 19:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74984145B38;
	Fri, 13 Sep 2024 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cxDNjDLf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419DB13AD03
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255957; cv=none; b=hGgSbqaTVSj5pcQNWUVfWnlhwOll3hTg2PgMClc/fzkugKHiEiq7+M6gBX2vmwnaV5DSBT0uPRS0TGzdzjDdIu2WqtZ1/0hUw2BYzXHopB5YVG4c2r03Q2p2gpxey3wrHiTPBdEqJagJb+LAhMdzedhfzsCKJIjyzhIfanBfQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255957; c=relaxed/simple;
	bh=G9E6X8LQZtqoWN8zWYpl8zfPbSWa0DSKnEP+BJMYv1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqWTzA8uFuu7dtkdQg2dmzQOpJsqMVz4IVTtSSA3ZHUDlWeIXZJZyw/P1zYvX3Uh9gtsB5xkExn9EiTOWADzjO3w/OjwOH/9aRf8UeUyllnruvn8xc8863myP+IjdexaWgxGSUjL9MeaZLlEvHG/iZRQc0kJ0PX1iaf2kdN1+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cxDNjDLf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726255953;
	bh=G9E6X8LQZtqoWN8zWYpl8zfPbSWa0DSKnEP+BJMYv1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxDNjDLf2ww/A8Ssp1sk1Tn0Tfq/QR+gWDRQ0p3FXvtxjpe7q9ChIOHTVIa2A5KLk
	 U9aR4WqvjZlokRbKBbEeMgD0eOJT7o5gQxQbKwrHCd55Pm1jCB2psJlQtCWOptGZY7
	 FVWL5L/I9tFLdkm/yM2+xIdojBirrAVpJMMbg6PudChBBFUEipTUozY6tKiKFkXpO3
	 AdOnZAZsg3v3FiMzYSSinfU2pZe+JhE8GugBfk5KtGgL3Ink7zp00fQEba1dKeEQzG
	 Ep4n2UoPFfdaQJo+qxPtxUix51xn3jSsQ6sD8k1Tp2T5ScaGHOm59sJEs9EdlUQAit
	 6vXt2i76dW2tw==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9833117E3617;
	Fri, 13 Sep 2024 21:32:32 +0200 (CEST)
Date: Fri, 13 Sep 2024 15:32:30 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
	kernelci@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH v2 14/24] wifi: mt76: mt7915: retry mcu messages
Message-ID: <d907b13a-f8be-4cb8-a0bb-560a21278041@notapiano>
References: <20240827093011.18621-1-nbd@nbd.name>
 <20240827093011.18621-14-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240827093011.18621-14-nbd@nbd.name>

On Tue, Aug 27, 2024 at 11:30:01AM +0200, Felix Fietkau wrote:
> In some cases MCU messages can get lost. Instead of failing completely,
> attempt to recover by re-sending them.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Hi,

KernelCI has identified a regression originating from this patch. I've veri=
fied
that reverting it fixes the issue.

Regression's impact: Unable to boot

Affected platforms:
* mt8186-corsola-steelix-sku131072

Relevant kernel logs:

  [    3.457006] ------------[ cut here ]------------
  [    3.466050] kernel BUG at net/core/skbuff.c:2255!
  [    3.466055] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT =
SMP
  [    3.466059] Modules linked in: mt7921s mtk_vcodec_dbgfs mt76_sdio mtk_=
jpeg mtk_vcodec_common mt7921_common mtk_jpeg_enc_hw
  [    3.484734]  mt792x_lib mt76_connac_lib mtk_vpu mtk_jpeg_dec_hw v4l2_m=
em2mem
  [    3.496464]  mt76 videobuf2_dma_contig btmtksdio cros_ec_rpmsg btmtk v=
ideobuf2_memops cbmem mac80211 libarc4 bluetooth videobuf2_v4l2 videodev
  [    3.510198]  ecdh_generic cros_ec_sensors cros_ec_lid_angle cfg80211 e=
cc
  [    3.522273]  videobuf2_common mediatek_drm cros_ec_sensors_core crct10=
dif_ce industrialio_triggered_buffer
  [    3.534348]  kfifo_buf leds_cros_ec cros_ec_typec cros_ec_chardev mc
  [    3.545814]  sbs_battery elan_i2c phy_mtk_mipi_dsi_drv mtk_mmsys mtk_s=
vs
  [    3.562574]  drm_dma_helper rfkill snd_sof_mt8186 mtk_adsp_common
  [    3.574821]  snd_sof_xtensa_dsp snd_sof_of snd_sof mtk_scp
  [    3.594963]  mtk_mutex mtk_rpmsg hid_multitouch mtk_scp_ipi lvts_therm=
al mt6577_auxadc
  [    3.610771]  snd_sof_utils mtk_wdt coreboot_table
  [    3.626141]  ramoops reed_solomon pwm_bl backlight
  [    3.637694]=20
  [    3.637698] CPU: 4 UID: 0 PID: 235 Comm: mt76-sdio-txrx  Not tainted 6=
=2E11.0-rc7-next-20240913 #1
  [    3.651764] Hardware name: Google Steelix board (DT)
  [    3.651767] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
  [    3.664875] pc : pskb_expand_head+0x2cc/0x3c4
  [    3.729971] usb 1-1: new high-speed USB device number 2 using xhci-mtk
  [    3.733209] lr : mt76s_tx_run_queue+0x27c/0x410 [mt76_sdio]
  [    3.744152] sp : ffff8000810d3c30
  [    3.756220] x29: ffff8000810d3c30 x28: 0000000000000000
  [    3.765341]  x27: ffff6a16c81a7780
  [    3.778973] x26: 0000000000000000 x25: ffff6a16cc2576b0 x24: 000000000=
0000140
  [    3.790005] x23: ffff6a16cb910080
  [    3.799991]  x22: 0000000000000028
  [    3.816224]  x21: ffff6a16cc252000
  [    3.821005] x20: 0000000000000000 x19: ffff6a16c81a4300 x18: 000000000=
0000000
  [    3.858429] x17: ffffc9f99aab0000 x16: ffffa01e5a692f5c x15: 000000000=
0000000
  [    3.865556] x14: 0000000000000352 x13: 0000000000000352 x12: 000000000=
0000001
  [    3.872682] x11: 0000000000000057 x10: ffff6a16c8aeeb88 x9 : ffff6a16c=
81a4300
  [    3.879808] x8 : ffff6a16c8aeeb98 x7 : ffff6a17f6d91428 x6 : 000000000=
0000001
  [    3.886935] x5 : 0000000000000000 x4 : ffff6a16c827b3c0 x3 : 000000000=
0000820
  [    3.894060] x2 : 0000000000000200 x1 : 0000000000000002 x0 : ffff6a16c=
81a4300
  [    3.901186] Call trace:
  [    3.903621]  pskb_expand_head+0x2cc/0x3c4
  [    3.907622]  mt76s_tx_run_queue+0x27c/0x410 [mt76_sdio]
  [    3.912839]  mt76s_txrx_worker+0xc8/0xde4 [mt76_sdio]
  [    3.917881]  mt7921s_txrx_worker+0x5c/0xec [mt7921s]
  [    3.922839]  __mt76_worker_fn+0x80/0x120 [mt76]
  [    3.927380]  kthread+0x114/0x118
  [    3.930601]  ret_from_fork+0x10/0x20
  [    3.934171] Code: 17ffffb5 f9002bfb d4210000 f9002bfb (d4210000)=20
  [    3.940252] ---[ end trace 0000000000000000 ]---
  [    3.948178] note: mt76-sdio-txrx [235] exited with irqs disabled
  [    3.954227] note: mt76-sdio-txrx [235] exited with preempt_count 1
  [    3.960491] ------------[ cut here ]------------
 =20
  [   11.486135] ------------[ cut here ]------------
  [   11.490749] WARNING: CPU: 7 PID: 54 at kernel/kthread.c:657 kthread_pa=
rk+0xa4/0xd0
  [   11.498319] Modules linked in: ip_tables x_tables ipv6 ax88796b asix o=
nboard_usb_dev panel_edp uvcvideo uvc videobuf2_vmalloc mtk_vcodec_dec_hw m=
tk_vcodec_dec v4l2_vp9 mtk_vcodec_enc v4l2_h264 mt7921s mtk_jpeg mtk_vcodec=
_dbgfs btmtksdio mtk_vcodec_common mt76_sdio mtk_jpeg_enc_hw mtk_vpu mtk_jp=
eg_dec_hw btmtk mt7921_common mt792x_lib v4l2_mem2mem cros_ec_rpmsg videobu=
f2_dma_contig cbmem mt76_connac_lib videobuf2_memops videobuf2_v4l2 mt76 ma=
c80211 bluetooth crct10dif_ce videodev ecdh_generic cros_ec_lid_angle video=
buf2_common cros_ec_sensors ecc libarc4 mc mediatek_drm leds_cros_ec cros_e=
c_sensors_core cfg80211 mtk_mutex phy_mtk_mipi_dsi_drv mtk_mmsys drm_dma_he=
lper industrialio_triggered_buffer sbs_battery rfkill cros_ec_chardev kfifo=
_buf snd_sof_mt8186 hid_multitouch mtk_adsp_common cros_ec_typec elan_i2c s=
nd_sof_xtensa_dsp snd_sof_of snd_sof mtk_wdt mtk_scp snd_sof_utils lvts_the=
rmal mtk_svs mt6577_auxadc pwm_bl backlight mtk_rpmsg mtk_scp_ipi ramoops r=
eed_solomon coreboot_table
  [   11.585320] CPU: 7 UID: 0 PID: 54 Comm: kworker/7:0 Tainted: G      D =
W          6.11.0-rc7-next-20240913 #1
  [   11.585329] Tainted: [D]=3DDIE, [W]=3DWARN
  [   11.585331] Hardware name: Google Steelix board (DT)
  [   11.585334] Workqueue: events mt7921_init_work [mt7921_common]
  [   11.585349] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
  [   11.616606] pc : kthread_park+0xa4/0xd0
  [   11.620431] lr : mt7921s_init_reset+0x80/0x24c [mt7921s]
  [   11.625731] sp : ffff800080473cd0
  [   11.629032] x29: ffff800080473cd0 x28: 0000000000000000 x27: 000000000=
0000000
  [   11.636153] x26: ffff559736df45a8 x25: ffff559606502148 x24: ffff55960=
650a148
  [   11.643274] x23: 000000000041f23c x22: ffff559606502000 x21: ffff55960=
6507738
  [   11.650394] x20: 0000000000000000 x19: ffff5596086e9140 x18: 000000000=
0000001
  [   11.657515] x17: 000000040044ffff x16: ffffb34762ec4fbc x15: 000000000=
0000000
  [   11.664636] x14: 00000000000001cc x13: 0000000000000000 x12: 000000000=
0000000
  [   11.671757] x11: 0000000000000001 x10: 0000000000000a90 x9 : ffff80008=
0473bb0
  [   11.678878] x8 : ffff559736debcc0 x7 : ffff559736df4c40 x6 : 000000000=
00249f0
  [   11.685998] x5 : ffff559606502068 x4 : ffff559606502060 x3 : ffff55960=
6507740
  [   11.693119] x2 : ffff559606507740 x1 : 0000000000005800 x0 : 000000000=
020804c
  [   11.700240] Call trace:
  [   11.702673]  kthread_park+0xa4/0xd0
  [   11.706150]  mt7921s_init_reset+0x80/0x24c [mt7921s]
  [   11.711100]  mt7921_init_work+0x190/0x240 [mt7921_common]
  [   11.716486]  process_one_work+0x14c/0x28c
  [   11.720483]  worker_thread+0x2d0/0x3d8
  [   11.724219]  kthread+0x114/0x118
  [   11.727435]  ret_from_fork+0x10/0x20
  [   11.731000] ---[ end trace 0000000000000000 ]---
  [   11.848160] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000000
  [   11.856958] Mem abort info:
  [   11.859747]   ESR =3D 0x0000000096000004
  [   11.863490]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
  [   11.868795]   SET =3D 0, FnV =3D 0
  [   11.871842]   EA =3D 0, S1PTW =3D 0
  [   11.874976]   FSC =3D 0x04: level 0 translation fault
  [   11.879847] Data abort info:
  [   11.882721]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
  [   11.888199]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
  [   11.893247]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
  [   11.898555] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000010815f000
  [   11.904993] [0000000000000000] pgd=3D0000000000000000, p4d=3D000000000=
0000000
  [   11.918032] Modules linked in: ip_tables x_tables ipv6 ax88796b asix o=
nboard_usb_dev panel_edp uvcvideo uvc videobuf2_vmalloc mtk_vcodec_dec_hw m=
tk_vcodec_dec v4l2_vp9 mtk_vcodec_enc v4l2_h264 mt7921s mtk_jpeg mtk_vcodec=
_dbgfs btmtksdio mtk_vcodec_common mt76_sdio mtk_jpeg_enc_hw mtk_vpu mtk_jp=
eg_dec_hw btmtk mt7921_common mt792x_lib v4l2_mem2mem cros_ec_rpmsg videobu=
f2_dma_contig cbmem mt76_connac_lib videobuf2_memops videobuf2_v4l2 mt76 ma=
c80211 bluetooth crct10dif_ce videodev ecdh_generic cros_ec_lid_angle video=
buf2_common cros_ec_sensors ecc libarc4 mc mediatek_drm leds_cros_ec cros_e=
c_sensors_core cfg80211 mtk_mutex phy_mtk_mipi_dsi_drv mtk_mmsys drm_dma_he=
lper industrialio_triggered_buffer sbs_battery rfkill cros_ec_chardev kfifo=
_buf snd_sof_mt8186 hid_multitouch mtk_adsp_common cros_ec_typec elan_i2c s=
nd_sof_xtensa_dsp snd_sof_of snd_sof mtk_wdt mtk_scp snd_sof_utils lvts_the=
rmal mtk_svs mt6577_auxadc pwm_bl backlight mtk_rpmsg mtk_scp_ipi ramoops r=
eed_solomon coreboot_table
  [   12.005017] CPU: 7 UID: 0 PID: 54 Comm: kworker/7:0 Tainted: G      D =
W          6.11.0-rc7-next-20240913 #1
  [   12.014835] Tainted: [D]=3DDIE, [W]=3DWARN
  [   12.018572] Hardware name: Google Steelix board (DT)
  [   12.023523] Workqueue: events mt7921_init_work [mt7921_common]
  [   12.029355] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
  [   12.036305] pc : kthread_unpark+0x1c/0xb4
  [   12.040311] lr : mt7921s_init_reset+0xc0/0x24c [mt7921s]
  [   12.045614] sp : ffff800080473cc0
  [   12.048915] x29: ffff800080473cc0 x28: 0000000000000000 x27: 000000000=
0000000
  [   12.056040] x26: ffff559736df45a8 x25: ffff559606502148 x24: ffff55960=
650a148
  [   12.063163] x23: 000000000041f23c x22: ffff559606502000 x21: ffff55960=
65076b0
  [   12.070288] x20: ffff559606507800 x19: 0000000000000000 x18: ffff55973=
eea827c
  [   12.077411] x17: 00000000000a9818 x16: ffffb34762ec4a30 x15: 000000000=
0000000
  [   12.084535] x14: ffff559600304580 x13: 0000000000000050 x12: 000000000=
0000001
  [   12.091659] x11: 0000000000000001 x10: 0000000000000a90 x9 : ffff80008=
0473850
  [   12.098783] x8 : 0000000000000100 x7 : ffff559736078000 x6 : 000000000=
0000018
  [   12.105907] x5 : 00000000ffff8f00 x4 : 00ffffffffffffff x3 : 000000000=
0001099
  [   12.113031] x2 : 00000000fffee699 x1 : 000000000020804c x0 : ffff55960=
86e9140
  [   12.120155] Call trace:
  [   12.122590]  kthread_unpark+0x1c/0xb4
  [   12.126244]  mt7921s_init_reset+0xc0/0x24c [mt7921s]
  [   12.131197]  mt7921_init_work+0x190/0x240 [mt7921_common]
  [   12.136587]  process_one_work+0x14c/0x28c
  [   12.140585]  worker_thread+0x2d0/0x3d8
  [   12.144323]  kthread+0x114/0x118
  [   12.147542]  ret_from_fork+0x10/0x20
  [   12.151111] Code: f9000bf3 b9402c01 36a804c1 f942cc13 (f9400261)
  [   12.157190] ---[ end trace 0000000000000000 ]---

(Full logs available here: http://0x0.st/XxI-.txt)

Happy to provide any other details necessary.

Please add
Reported-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
when fixing this.

#regzbot introduced: next-20240909..next-20240910
#regzbot title: Boot regression on mt8186-corsola-steelix-sku131072 due to =
bug in mcu message sending logic in mt76

Thanks,
N=EDcolas


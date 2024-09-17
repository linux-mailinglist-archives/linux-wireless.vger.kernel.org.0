Return-Path: <linux-wireless+bounces-12913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B297AEA7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 12:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630211C21E7B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669115C13E;
	Tue, 17 Sep 2024 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu+YfvZ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0B13CFB6;
	Tue, 17 Sep 2024 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568553; cv=none; b=sG3aJeORlLAXENR+PmSEFAt8h6VIhH2tMTIGysI1cdgZO89IHRM1REUFDYYq0objYkSzskTn6gtwfOv7E7dmmJtYgN33gNPoS1k/KqVVW5r67TVx5ttx0+/b5zMLNXyjXfWaBWluyJJJ62YzwYhlzPX5UqQpzS1LekGjf6ZLTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568553; c=relaxed/simple;
	bh=weBl1fqrLDPgNSMlVnt4udvXEXiNJCY/eXFCHuhDNZw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=shyWnH0fQZ85w7FspLvtl1zMbY7qYSMXv+apSvqY9McAFjibA9Z16U6G4+ATVuzrB6fHvQpxCgCfBy9weK8Rt8mrg0bRj927DE57hi/FTSFfUO+Mdj8h/2sBW6qsTYY4lOR/kaISWr+Unx1MwwLbgfAeudIE4auYUPDGn5CiL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu+YfvZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9294BC4CEC5;
	Tue, 17 Sep 2024 10:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726568552;
	bh=weBl1fqrLDPgNSMlVnt4udvXEXiNJCY/eXFCHuhDNZw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eu+YfvZ/pU9UJcvIZ7d/R1NmkYtvdnAersdWKsCfw8hxK9ZX/EVahbeaRFhpi75fn
	 cgAcZGmDhrRzKl+GJ2TPiSplEqIEtBLpVIR7Izlebjay4Chyk8uhZdU+QUTzey09Lx
	 wH99DX+rD21yUxqSUK5k0gnvYpzQrP/Q8X0p0h0g9abYlpfgUXo/Ae0C8XasYAomXj
	 euTdxb48+VJK+36oCrQ4gfPj419pCpyQlDxzvXsVsjBDT9V9IkxhH0DWb+NA2XEnbe
	 qA6KCltqL4gRNXBRsRdmEiMOOrDJIITmXgAi0IP7J4liGYmIfxOV2PYod05L3UPwiK
	 +23Igj3NgQS+A==
From: Kalle Valo <kvalo@kernel.org>
To: =?utf-8?Q?N=C3=ADcolas?= F. R. A. Prado <nfraprado@collabora.com>
Cc: Felix Fietkau <nbd@nbd.name>,  linux-wireless@vger.kernel.org,
  regressions@lists.linux.dev,  kernelci@lists.linux.dev,
  kernel@collabora.com
Subject: Re: [PATCH v2 14/24] wifi: mt76: mt7915: retry mcu messages
References: <20240827093011.18621-1-nbd@nbd.name>
	<20240827093011.18621-14-nbd@nbd.name>
	<d907b13a-f8be-4cb8-a0bb-560a21278041@notapiano>
Date: Tue, 17 Sep 2024 13:22:29 +0300
In-Reply-To: <d907b13a-f8be-4cb8-a0bb-560a21278041@notapiano>
 (=?utf-8?Q?=22N=C3=ADcolas?= F. R.
	A. Prado"'s message of "Fri, 13 Sep 2024 15:32:30 -0400")
Message-ID: <8734lybmvu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> writes:

> On Tue, Aug 27, 2024 at 11:30:01AM +0200, Felix Fietkau wrote:
>> In some cases MCU messages can get lost. Instead of failing completely,
>> attempt to recover by re-sending them.
>>=20
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>
> Hi,
>
> KernelCI has identified a regression originating from this patch. I've ve=
rified
> that reverting it fixes the issue.
>
> Regression's impact: Unable to boot
>
> Affected platforms:
> * mt8186-corsola-steelix-sku131072
>
> Relevant kernel logs:
>
>   [    3.457006] ------------[ cut here ]------------
>   [    3.466050] kernel BUG at net/core/skbuff.c:2255!
>   [    3.466055] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMP=
T SMP
>   [ 3.466059] Modules linked in: mt7921s mtk_vcodec_dbgfs mt76_sdio
> mtk_jpeg mtk_vcodec_common mt7921_common mtk_jpeg_enc_hw
>   [    3.484734]  mt792x_lib mt76_connac_lib mtk_vpu mtk_jpeg_dec_hw v4l2=
_mem2mem
>   [ 3.496464] mt76 videobuf2_dma_contig btmtksdio cros_ec_rpmsg btmtk
> videobuf2_memops cbmem mac80211 libarc4 bluetooth videobuf2_v4l2
> videodev
>   [    3.510198]  ecdh_generic cros_ec_sensors cros_ec_lid_angle cfg80211=
 ecc
>   [ 3.522273] videobuf2_common mediatek_drm cros_ec_sensors_core
> crct10dif_ce industrialio_triggered_buffer
>   [    3.534348]  kfifo_buf leds_cros_ec cros_ec_typec cros_ec_chardev mc
>   [    3.545814]  sbs_battery elan_i2c phy_mtk_mipi_dsi_drv mtk_mmsys mtk=
_svs
>   [    3.562574]  drm_dma_helper rfkill snd_sof_mt8186 mtk_adsp_common
>   [    3.574821]  snd_sof_xtensa_dsp snd_sof_of snd_sof mtk_scp
>   [    3.594963]  mtk_mutex mtk_rpmsg hid_multitouch mtk_scp_ipi lvts_the=
rmal mt6577_auxadc
>   [    3.610771]  snd_sof_utils mtk_wdt coreboot_table
>   [    3.626141]  ramoops reed_solomon pwm_bl backlight
>   [    3.637694]=20
>   [    3.637698] CPU: 4 UID: 0 PID: 235 Comm: mt76-sdio-txrx  Not tainted=
 6.11.0-rc7-next-20240913 #1
>   [    3.651764] Hardware name: Google Steelix board (DT)
>   [    3.651767] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
>   [    3.664875] pc : pskb_expand_head+0x2cc/0x3c4
>   [    3.729971] usb 1-1: new high-speed USB device number 2 using xhci-m=
tk
>   [    3.733209] lr : mt76s_tx_run_queue+0x27c/0x410 [mt76_sdio]
>   [    3.744152] sp : ffff8000810d3c30
>   [    3.756220] x29: ffff8000810d3c30 x28: 0000000000000000
>   [    3.765341]  x27: ffff6a16c81a7780
>   [    3.778973] x26: 0000000000000000 x25: ffff6a16cc2576b0 x24: 0000000=
000000140
>   [    3.790005] x23: ffff6a16cb910080
>   [    3.799991]  x22: 0000000000000028
>   [    3.816224]  x21: ffff6a16cc252000
>   [    3.821005] x20: 0000000000000000 x19: ffff6a16c81a4300 x18: 0000000=
000000000
>   [    3.858429] x17: ffffc9f99aab0000 x16: ffffa01e5a692f5c x15: 0000000=
000000000
>   [    3.865556] x14: 0000000000000352 x13: 0000000000000352 x12: 0000000=
000000001
>   [    3.872682] x11: 0000000000000057 x10: ffff6a16c8aeeb88 x9 : ffff6a1=
6c81a4300
>   [    3.879808] x8 : ffff6a16c8aeeb98 x7 : ffff6a17f6d91428 x6 : 0000000=
000000001
>   [    3.886935] x5 : 0000000000000000 x4 : ffff6a16c827b3c0 x3 : 0000000=
000000820
>   [    3.894060] x2 : 0000000000000200 x1 : 0000000000000002 x0 : ffff6a1=
6c81a4300
>   [    3.901186] Call trace:
>   [    3.903621]  pskb_expand_head+0x2cc/0x3c4
>   [    3.907622]  mt76s_tx_run_queue+0x27c/0x410 [mt76_sdio]
>   [    3.912839]  mt76s_txrx_worker+0xc8/0xde4 [mt76_sdio]
>   [    3.917881]  mt7921s_txrx_worker+0x5c/0xec [mt7921s]
>   [    3.922839]  __mt76_worker_fn+0x80/0x120 [mt76]
>   [    3.927380]  kthread+0x114/0x118
>   [    3.930601]  ret_from_fork+0x10/0x20
>   [    3.934171] Code: 17ffffb5 f9002bfb d4210000 f9002bfb (d4210000)=20
>   [    3.940252] ---[ end trace 0000000000000000 ]---
>   [    3.948178] note: mt76-sdio-txrx [235] exited with irqs disabled
>   [    3.954227] note: mt76-sdio-txrx [235] exited with preempt_count 1
>   [    3.960491] ------------[ cut here ]------------
>=20=20=20
>   [   11.486135] ------------[ cut here ]------------
>   [   11.490749] WARNING: CPU: 7 PID: 54 at kernel/kthread.c:657 kthread_=
park+0xa4/0xd0
>   [ 11.498319] Modules linked in: ip_tables x_tables ipv6 ax88796b
> asix onboard_usb_dev panel_edp uvcvideo uvc videobuf2_vmalloc
> mtk_vcodec_dec_hw mtk_vcodec_dec v4l2_vp9 mtk_vcodec_enc v4l2_h264
> mt7921s mtk_jpeg mtk_vcodec_dbgfs btmtksdio mtk_vcodec_common
> mt76_sdio mtk_jpeg_enc_hw mtk_vpu mtk_jpeg_dec_hw btmtk mt7921_common
> mt792x_lib v4l2_mem2mem cros_ec_rpmsg videobuf2_dma_contig cbmem
> mt76_connac_lib videobuf2_memops videobuf2_v4l2 mt76 mac80211
> bluetooth crct10dif_ce videodev ecdh_generic cros_ec_lid_angle
> videobuf2_common cros_ec_sensors ecc libarc4 mc mediatek_drm
> leds_cros_ec cros_ec_sensors_core cfg80211 mtk_mutex
> phy_mtk_mipi_dsi_drv mtk_mmsys drm_dma_helper
> industrialio_triggered_buffer sbs_battery rfkill cros_ec_chardev
> kfifo_buf snd_sof_mt8186 hid_multitouch mtk_adsp_common cros_ec_typec
> elan_i2c snd_sof_xtensa_dsp snd_sof_of snd_sof mtk_wdt mtk_scp
> snd_sof_utils lvts_thermal mtk_svs mt6577_auxadc pwm_bl backlight
> mtk_rpmsg mtk_scp_ipi ramoops reed_solomon coreboot_table
>   [ 11.585320] CPU: 7 UID: 0 PID: 54 Comm: kworker/7:0 Tainted: G D W
> 6.11.0-rc7-next-20240913 #1
>   [   11.585329] Tainted: [D]=3DDIE, [W]=3DWARN
>   [   11.585331] Hardware name: Google Steelix board (DT)
>   [   11.585334] Workqueue: events mt7921_init_work [mt7921_common]
>   [   11.585349] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
>   [   11.616606] pc : kthread_park+0xa4/0xd0
>   [   11.620431] lr : mt7921s_init_reset+0x80/0x24c [mt7921s]
>   [   11.625731] sp : ffff800080473cd0
>   [   11.629032] x29: ffff800080473cd0 x28: 0000000000000000 x27: 0000000=
000000000
>   [   11.636153] x26: ffff559736df45a8 x25: ffff559606502148 x24: ffff559=
60650a148
>   [   11.643274] x23: 000000000041f23c x22: ffff559606502000 x21: ffff559=
606507738
>   [   11.650394] x20: 0000000000000000 x19: ffff5596086e9140 x18: 0000000=
000000001
>   [   11.657515] x17: 000000040044ffff x16: ffffb34762ec4fbc x15: 0000000=
000000000
>   [   11.664636] x14: 00000000000001cc x13: 0000000000000000 x12: 0000000=
000000000
>   [   11.671757] x11: 0000000000000001 x10: 0000000000000a90 x9 : ffff800=
080473bb0
>   [   11.678878] x8 : ffff559736debcc0 x7 : ffff559736df4c40 x6 : 0000000=
0000249f0
>   [   11.685998] x5 : ffff559606502068 x4 : ffff559606502060 x3 : ffff559=
606507740
>   [   11.693119] x2 : ffff559606507740 x1 : 0000000000005800 x0 : 0000000=
00020804c
>   [   11.700240] Call trace:
>   [   11.702673]  kthread_park+0xa4/0xd0
>   [   11.706150]  mt7921s_init_reset+0x80/0x24c [mt7921s]
>   [   11.711100]  mt7921_init_work+0x190/0x240 [mt7921_common]
>   [   11.716486]  process_one_work+0x14c/0x28c
>   [   11.720483]  worker_thread+0x2d0/0x3d8
>   [   11.724219]  kthread+0x114/0x118
>   [   11.727435]  ret_from_fork+0x10/0x20
>   [   11.731000] ---[ end trace 0000000000000000 ]---
>   [   11.848160] Unable to handle kernel NULL pointer dereference at virt=
ual address 0000000000000000
>   [   11.856958] Mem abort info:
>   [   11.859747]   ESR =3D 0x0000000096000004
>   [   11.863490]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   [   11.868795]   SET =3D 0, FnV =3D 0
>   [   11.871842]   EA =3D 0, S1PTW =3D 0
>   [   11.874976]   FSC =3D 0x04: level 0 translation fault
>   [   11.879847] Data abort info:
>   [   11.882721]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
>   [   11.888199]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>   [   11.893247]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>   [   11.898555] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000010815f=
000
>   [   11.904993] [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000=
000000000
>   [ 11.918032] Modules linked in: ip_tables x_tables ipv6 ax88796b
> asix onboard_usb_dev panel_edp uvcvideo uvc videobuf2_vmalloc
> mtk_vcodec_dec_hw mtk_vcodec_dec v4l2_vp9 mtk_vcodec_enc v4l2_h264
> mt7921s mtk_jpeg mtk_vcodec_dbgfs btmtksdio mtk_vcodec_common
> mt76_sdio mtk_jpeg_enc_hw mtk_vpu mtk_jpeg_dec_hw btmtk mt7921_common
> mt792x_lib v4l2_mem2mem cros_ec_rpmsg videobuf2_dma_contig cbmem
> mt76_connac_lib videobuf2_memops videobuf2_v4l2 mt76 mac80211
> bluetooth crct10dif_ce videodev ecdh_generic cros_ec_lid_angle
> videobuf2_common cros_ec_sensors ecc libarc4 mc mediatek_drm
> leds_cros_ec cros_ec_sensors_core cfg80211 mtk_mutex
> phy_mtk_mipi_dsi_drv mtk_mmsys drm_dma_helper
> industrialio_triggered_buffer sbs_battery rfkill cros_ec_chardev
> kfifo_buf snd_sof_mt8186 hid_multitouch mtk_adsp_common cros_ec_typec
> elan_i2c snd_sof_xtensa_dsp snd_sof_of snd_sof mtk_wdt mtk_scp
> snd_sof_utils lvts_thermal mtk_svs mt6577_auxadc pwm_bl backlight
> mtk_rpmsg mtk_scp_ipi ramoops reed_solomon coreboot_table
>   [ 12.005017] CPU: 7 UID: 0 PID: 54 Comm: kworker/7:0 Tainted: G D W
> 6.11.0-rc7-next-20240913 #1
>   [   12.014835] Tainted: [D]=3DDIE, [W]=3DWARN
>   [   12.018572] Hardware name: Google Steelix board (DT)
>   [   12.023523] Workqueue: events mt7921_init_work [mt7921_common]
>   [   12.029355] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
>   [   12.036305] pc : kthread_unpark+0x1c/0xb4
>   [   12.040311] lr : mt7921s_init_reset+0xc0/0x24c [mt7921s]
>   [   12.045614] sp : ffff800080473cc0
>   [   12.048915] x29: ffff800080473cc0 x28: 0000000000000000 x27: 0000000=
000000000
>   [   12.056040] x26: ffff559736df45a8 x25: ffff559606502148 x24: ffff559=
60650a148
>   [   12.063163] x23: 000000000041f23c x22: ffff559606502000 x21: ffff559=
6065076b0
>   [   12.070288] x20: ffff559606507800 x19: 0000000000000000 x18: ffff559=
73eea827c
>   [   12.077411] x17: 00000000000a9818 x16: ffffb34762ec4a30 x15: 0000000=
000000000
>   [   12.084535] x14: ffff559600304580 x13: 0000000000000050 x12: 0000000=
000000001
>   [   12.091659] x11: 0000000000000001 x10: 0000000000000a90 x9 : ffff800=
080473850
>   [   12.098783] x8 : 0000000000000100 x7 : ffff559736078000 x6 : 0000000=
000000018
>   [   12.105907] x5 : 00000000ffff8f00 x4 : 00ffffffffffffff x3 : 0000000=
000001099
>   [   12.113031] x2 : 00000000fffee699 x1 : 000000000020804c x0 : ffff559=
6086e9140
>   [   12.120155] Call trace:
>   [   12.122590]  kthread_unpark+0x1c/0xb4
>   [   12.126244]  mt7921s_init_reset+0xc0/0x24c [mt7921s]
>   [   12.131197]  mt7921_init_work+0x190/0x240 [mt7921_common]
>   [   12.136587]  process_one_work+0x14c/0x28c
>   [   12.140585]  worker_thread+0x2d0/0x3d8
>   [   12.144323]  kthread+0x114/0x118
>   [   12.147542]  ret_from_fork+0x10/0x20
>   [   12.151111] Code: f9000bf3 b9402c01 36a804c1 f942cc13 (f9400261)
>   [   12.157190] ---[ end trace 0000000000000000 ]---
>
> (Full logs available here: http://0x0.st/XxI-.txt)
>
> Happy to provide any other details necessary.
>
> Please add
> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> #Kerne=
lCI
> when fixing this.
>
> #regzbot introduced: next-20240909..next-20240910
> #regzbot title: Boot regression on mt8186-corsola-steelix-sku131072
> due to bug in mcu message sending logic in mt76

I don't see this in regzbot so let's try again:

#regzbot introduced: 3688c18b65ae ^

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes


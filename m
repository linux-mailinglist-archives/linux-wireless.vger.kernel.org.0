Return-Path: <linux-wireless+bounces-23474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0850AC6C39
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE6FA2315B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790851BC9F4;
	Wed, 28 May 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="zYGrFIHp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C9F8F5E
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443692; cv=none; b=mcNHZhu35+JA3cFIZXN7FJMKUpQQ+Fi0V0JxjddvesvVW3AI9vQ1PfZQySFL+PolFtgp0d/jy2R8WWSa1Ma3GVHJcuGGay8vGjapGwnBbvZQb2Sh4XMkqw2R9f2XqpMH7lpTNtREGlJplCBMvNHJkMu4zlW4ICLzVLQdtUV2z2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443692; c=relaxed/simple;
	bh=V9PA1BYGzEJZzViWR513RLT+hTXNjde//7abt4wwvvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VIvM6SKCkb7S/YZTYpNDBrtCRHPJ2mw8B6GNi/H4or2o3lkF4P0IBVieKYQLVR5HtyvtPpxQrdCyI4Fs+6C+/E1TU3eZL8tWwouxvAihMfXV71Fh6VWvfGTuSyqtTWyt+PiEqbE9vNdfMiL6wgTNh84AykokXfFT8Ryhi/rhFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=zYGrFIHp; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D93CB14C2D3;
	Wed, 28 May 2025 16:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1748443267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MdMRfbiaUVtsstASdK2A2yX4jiHKfixjhvC02ee4kmM=;
	b=zYGrFIHp/XrnA/LiF26DyH6yHfHiZrvySVuz064EpI0V+JfAMpKn0XtZWsVn3BZ4TZq0zH
	gw+gjwzwm16OFt+oZLe9iCIjWrY77TbNVDAFa61NSLE36pOrMRw4UG+ZU6VZsF3WjXjtsB
	RUNovUYxvpFx9MxOl5oZd8hhgMqHtpN5UHt0klWLsAmm4TMqZ/7MSD5zYobNtuSKUhyjI2
	97QAiaRwW5kehoqlJKYakvgwH5wz5DcIWcSW3jVLiGhmXOMVf/hAiAqcJYVe0Q1a+VyrfR
	qVrQhu/1IHnEdI2l9a9OtUiBiBq/SkVu92XreV74ymg4qCX76eu8JWL6Vux8Yw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 48d64b0e;
	Wed, 28 May 2025 14:41:05 +0000 (UTC)
Date: Wed, 28 May 2025 23:40:50 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Subject: rtw89: array-index-out-of-bounds in rtw89_pci_release_rpp()
Message-ID: <aDcgcjNp3fRT9PZf@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cM/Eq+FUe+VnaN9D"
Content-Disposition: inline


--cM/Eq+FUe+VnaN9D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

On my machine I sometimes get a kernel panic when the wireless driver
crashes (fw dump)

This is a standard fedora kernel so I can grab debuginfo and symbolize
the stack trace if you'd like, but I think this message might be enough
in itself without extra lines (longer excerpt attached)
---
UBSAN: array-index-out-of-bounds in drivers/net/wireless/realtek/rtw89/pci.c:593:24
       index 32767 is out of range for type 'rtw89_pci_tx_wd [512]'
CPU: 11 UID: 0 PID: 2179 Comm: irq/153-rtw89_p Not tainted 6.14.6-300.fc42.x86_64 #1
Call Trace:
 <IRQ>
 dump_stack_lvl+0x5d/0x80
 ubsan_epilogue+0x5/0x30
 __ubsan_handle_out_of_bounds.cold+0x54/0x59
 rtw89_pci_release_tx_skbs.isra.0+0x291/0x2d0 [rtw89_pci]
 rtw89_pci_release_tx+0x1c/0x50 [rtw89_pci]
 rtw89_pci_napi_poll+0x99/0x170 [rtw89_pci]
 __napi_poll+0x2e/0x1b0
 ? nohz_balance_exit_idle+0x88/0x100
 net_rx_action+0x333/0x420
 handle_softirqs+0xed/0x340
 ? __pfx_irq_thread_fn+0x10/0x10
 do_softirq.part.0+0x3b/0x60
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x60/0x70
 rtw89_pci_interrupt_threadfn+0xf7/0x260 [rtw89_pci]
 ? __pfx_irq_thread+0x10/0x10
 ? __pfx_irq_thread_fn+0x10/0x10
 irq_thread_fn+0x22/0x60
 irq_thread+0xea/0x1c0
---

The line in question would be this line:
>        txwd = &wd_ring->pages[seq];
(which matches as pages is an array of 512 rtw89_pci_tx_wd structs)


Checking seq < RTW89_PCI_TXWD_NUM_MAX is trivial and I could send a
patch, but if that data is really bogus I assume any local check could
be fooled e.g. the data could be < 512 and still incorrect.


I'm afraid I don't have a reproducer, this machine is weird in that I
have (had) ethernet and wlan both up in the same subnet so packets such
as broadcast would be received on both ends and things might be weird; I
also suspend/resume. I setup netconsole after the 3rd crash in ~2 weeks,
so it's rare enough.
It's a new machine so I don't know if it's a regression.


That 'FW status' message comes from rtw89_mac_get_err_status()
-> rtw89_fw_st_dbg_dump() so another error obviously came in first --
perhaps in that case just give up and don't process incoming packets?


I've just turned off radio as I don't actually use it, so leaving what
to do of this up to you; if you want me to test something I can rebuild
a kernel and test but not sure how long it'd take to actually hit the
bug.

Thanks,
-- 
Dominique

--cM/Eq+FUe+VnaN9D
Content-Type: text/plain; charset=utf-8
Content-Description: netconsole.rtw89_crash
Content-Disposition: attachment; filename="netconsole.rtw89_crash"
Content-Transfer-Encoding: quoted-printable

6,35169,662928960804,-;rtw89_8852bte 0000:03:00.0: FW status =3D 0x55001100
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35170,662928960915,-;rtw89_8852bte 0000:03:00.0: FW BADADDR =3D 0x2222
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35171,662928960924,-;rtw89_8852bte 0000:03:00.0: FW EPC/RA =3D 0x0
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35172,662928960933,-;rtw89_8852bte 0000:03:00.0: FW MISC =3D 0xb8900635
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35173,662928960941,-;rtw89_8852bte 0000:03:00.0: R_AX_HALT_C2H =3D 0x1000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35174,662928960949,-;rtw89_8852bte 0000:03:00.0: R_AX_SER_DBG_INFO =3D 0x=
1000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35175,662928960962,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb8988161
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35176,662928961080,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815f
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35177,662928961097,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815f
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35178,662928961115,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880ff
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35179,662928961233,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815f
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35180,662928961278,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35181,662928961323,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35182,662928961373,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb8988161
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35183,662928961423,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89881ef
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35184,662928961468,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f1
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35185,662928961512,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f1
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35186,662928961529,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35187,662928961546,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880ef
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35188,662928961564,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb8988161
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35189,662928961614,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35190,662928961630,-;rtw89_8852bte 0000:03:00.0: --->\x0aerr=3D0x1000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35191,662928961718,-;rtw89_8852bte 0000:03:00.0: R_AX_SER_DBG_INFO =3D0x0=
1000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35192,662928961727,-;rtw89_8852bte 0000:03:00.0: R_AX_SER_DBG_INFO =3D0x0=
1000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35193,662928961734,-;rtw89_8852bte 0000:03:00.0: DBG Counter 1 (R_AX_DRV_=
FW_HSK_4)=3D0xdeadbeef
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35194,662928961743,-;rtw89_8852bte 0000:03:00.0: DBG Counter 2 (R_AX_DRV_=
FW_HSK_5)=3D0xdeadbeef
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35195,662928961752,-;rtw89_8852bte 0000:03:00.0: R_AX_DMAC_ERR_ISR=3D0x00=
000040
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35196,662928961760,-;rtw89_8852bte 0000:03:00.0: R_AX_DMAC_ERR_IMR=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35197,662928961775,-;rtw89_8852bte 0000:03:00.0: R_AX_WDE_ERR_FLAG_CFG=3D=
0x00000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35198,662928961784,-;rtw89_8852bte 0000:03:00.0: R_AX_PLE_ERR_FLAG_CFG=3D=
0x82190000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35199,662928961791,-;rtw89_8852bte 0000:03:00.0: R_AX_WDE_ERR_IMR=3D0xbff=
fffff
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35200,662928961799,-;rtw89_8852bte 0000:03:00.0: R_AX_WDE_ERR_ISR=3D0x000=
00000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35201,662928961806,-;rtw89_8852bte 0000:03:00.0: R_AX_PLE_ERR_IMR=3D0xfff=
fffdf
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35202,662928961813,-;rtw89_8852bte 0000:03:00.0: R_AX_PLE_ERR_FLAG_ISR=3D=
0x02000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35203,662928961820,-;rtw89_8852bte 0000:03:00.0: R_AX_WD_CPUQ_OP_0=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35204,662928961827,-;rtw89_8852bte 0000:03:00.0: R_AX_WD_CPUQ_OP_1=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35205,662928961835,-;rtw89_8852bte 0000:03:00.0: R_AX_WD_CPUQ_OP_2=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35206,662928961842,-;rtw89_8852bte 0000:03:00.0: R_AX_PL_CPUQ_OP_0=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35207,662928961850,-;rtw89_8852bte 0000:03:00.0: R_AX_PL_CPUQ_OP_1=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35208,662928961856,-;rtw89_8852bte 0000:03:00.0: R_AX_PL_CPUQ_OP_2=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35209,662928961864,-;rtw89_8852bte 0000:03:00.0: R_AX_WD_CPUQ_OP_STATUS=
=3D0x00000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35210,662928961871,-;rtw89_8852bte 0000:03:00.0: R_AX_PL_CPUQ_OP_STATUS=
=3D0x00000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35211,662928961879,-;rtw89_8852bte 0000:03:00.0: R_AX_RXDMA_PKT_INFO_0=3D=
0x800088cc
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35212,662928961887,-;rtw89_8852bte 0000:03:00.0: R_AX_RXDMA_PKT_INFO_1=3D=
0x80008000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35213,662928961894,-;rtw89_8852bte 0000:03:00.0: R_AX_RXDMA_PKT_INFO_2=3D=
0x81a38069
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35214,662928961906,-;rtw89_8852bte 0000:03:00.0: R_AX_CMAC_ERR_ISR [0]=3D=
0x00000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35215,662928961914,-;rtw89_8852bte 0000:03:00.0: R_AX_CMAC_FUNC_EN [0]=3D=
0xf000803f
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35216,662928961921,-;rtw89_8852bte 0000:03:00.0: R_AX_CK_EN [0]=3D0xfffff=
fff
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35217,662928961930,-;rtw89_8852bte 0000:03:00.0: R_AX_CMAC_ERR_IMR [0]=3D=
0x00000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35218,662928961937,-;rtw89_8852bte 0000:03:00.0: [CMAC] : CMAC1 not enabl=
ed
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35219,662928961944,-;rtw89_8852bte 0000:03:00.0: R_AX_RPQ_RXBD_IDX =3D0x0=
0220022
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35220,662928961952,-;rtw89_8852bte 0000:03:00.0: R_AX_DBG_ERR_FLAG=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35221,662928961959,-;rtw89_8852bte 0000:03:00.0: R_AX_LBC_WATCHDOG=3D0x00=
000081
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35222,662928961964,-;rtw89_8852bte 0000:03:00.0: <---
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35223,662928961969,-;rtw89_8852bte 0000:03:00.0: SER catches error: 0x1000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35224,662928962636,-;rtw89_8852bte 0000:03:00.0: FW status =3D 0x55001100
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35225,662928962742,-;rtw89_8852bte 0000:03:00.0: FW BADADDR =3D 0x2222
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35226,662928962751,-;rtw89_8852bte 0000:03:00.0: FW EPC/RA =3D 0x0
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35227,662928962759,-;rtw89_8852bte 0000:03:00.0: FW MISC =3D 0xb8900635
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35228,662928962766,-;rtw89_8852bte 0000:03:00.0: R_AX_HALT_C2H =3D 0x1001
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35229,662928962773,-;rtw89_8852bte 0000:03:00.0: R_AX_SER_DBG_INFO =3D 0x=
1000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35230,662928962785,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815f
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35231,662928962836,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f1
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35232,662928962880,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35233,662928962925,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f3
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35234,662928962970,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35235,662928963014,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35236,662928963031,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815b
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35237,662928963048,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815b
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35238,662928963065,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35239,662928963082,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89881ef
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35240,662928963099,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35241,662928963116,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815f
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35242,662928963234,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35243,662928963251,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35244,662928963268,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f3
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35245,662928963283,-;rtw89_8852bte 0000:03:00.0: SER catches error: 0x1001
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35246,662928963623,-;rtw89_8852bte 0000:03:00.0: FW status =3D 0x55008100
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35247,662928963729,-;rtw89_8852bte 0000:03:00.0: FW BADADDR =3D 0x2222
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35248,662928963738,-;rtw89_8852bte 0000:03:00.0: FW EPC/RA =3D 0x0
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35249,662928963745,-;rtw89_8852bte 0000:03:00.0: FW MISC =3D 0xb8986657
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35250,662928963752,-;rtw89_8852bte 0000:03:00.0: R_AX_HALT_C2H =3D 0x1002
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35251,662928963759,-;rtw89_8852bte 0000:03:00.0: R_AX_SER_DBG_INFO =3D 0x=
f1000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35252,662928963770,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89286b7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35253,662928963787,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89a80e1
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35254,662928963804,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89a80e3
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35255,662928963822,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89a34c5
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35256,662928963839,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89aa85d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35257,662928963855,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89a34e1
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35258,662928963872,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89aa5e3
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35259,662928963889,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89a34e1
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35260,662928963906,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89aa665
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35261,662928963923,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89aa5e7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35262,662928963941,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89a827d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35263,662928963958,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb891e64f
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35264,662928963975,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb890a011
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35265,662928963992,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb8918be9
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35266,662928964009,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb8909fcb
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35267,662928964024,-;rtw89_8852bte 0000:03:00.0: SER catches error: 0x1002
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35268,662929004827,-;rtw89_8852bte 0000:03:00.0: MAC c2h class 1 func 3 n=
ot support
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35269,663129303741,-;rtw89_8852bte 0000:03:00.0: FW status =3D 0x88001100
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35270,663129303853,-;rtw89_8852bte 0000:03:00.0: FW BADADDR =3D 0x2222
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35271,663129303865,-;rtw89_8852bte 0000:03:00.0: FW EPC/RA =3D 0x0
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35272,663129303875,-;rtw89_8852bte 0000:03:00.0: FW MISC =3D 0xb8986657
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35273,663129303885,-;rtw89_8852bte 0000:03:00.0: R_AX_HALT_C2H =3D 0x1000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35274,663129303893,-;rtw89_8852bte 0000:03:00.0: R_AX_SER_DBG_INFO =3D 0x=
f2000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35275,663129303908,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f1
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35276,663129304025,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35277,663129304146,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f3
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35278,663129304268,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898817d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35279,663129304285,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815f
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35280,663129304302,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89881ef
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35281,663129304319,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f3
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35282,663129304336,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35283,663129304353,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f5
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35284,663129304370,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f1
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35285,663129304387,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35286,663129304404,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35287,663129304420,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35288,663129304438,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb898815d
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
3,35289,663129304455,-;rtw89_8852bte 0000:03:00.0: [ERR]fw PC =3D 0xb89880f7
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35290,663129304470,-;rtw89_8852bte 0000:03:00.0: --->\x0aerr=3D0x1000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35291,663129304590,-;rtw89_8852bte 0000:03:00.0: R_AX_SER_DBG_INFO =3D0xf=
2000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35292,663129304686,-;rtw89_8852bte 0000:03:00.0: R_AX_SER_DBG_INFO =3D0xf=
2000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35293,663129304695,-;rtw89_8852bte 0000:03:00.0: DBG Counter 1 (R_AX_DRV_=
FW_HSK_4)=3D0xdeadbeef
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35294,663129304705,-;rtw89_8852bte 0000:03:00.0: DBG Counter 2 (R_AX_DRV_=
FW_HSK_5)=3D0xdeadbeef
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35295,663129304718,-;rtw89_8852bte 0000:03:00.0: R_AX_DMAC_ERR_ISR=3D0x00=
000040
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35296,663129304727,-;rtw89_8852bte 0000:03:00.0: R_AX_DMAC_ERR_IMR=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35297,663129304736,-;rtw89_8852bte 0000:03:00.0: R_AX_WDE_ERR_FLAG_CFG=3D=
0x00000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35298,663129304745,-;rtw89_8852bte 0000:03:00.0: R_AX_PLE_ERR_FLAG_CFG=3D=
0x82190000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35299,663129304753,-;rtw89_8852bte 0000:03:00.0: R_AX_WDE_ERR_IMR=3D0xbff=
fffff
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35300,663129304762,-;rtw89_8852bte 0000:03:00.0: R_AX_WDE_ERR_ISR=3D0x000=
00000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35301,663129304771,-;rtw89_8852bte 0000:03:00.0: R_AX_PLE_ERR_IMR=3D0xfff=
fffdf
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35302,663129304780,-;rtw89_8852bte 0000:03:00.0: R_AX_PLE_ERR_FLAG_ISR=3D=
0x02000080
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35303,663129304790,-;rtw89_8852bte 0000:03:00.0: R_AX_WD_CPUQ_OP_0=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35304,663129304798,-;rtw89_8852bte 0000:03:00.0: R_AX_WD_CPUQ_OP_1=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35305,663129304808,-;rtw89_8852bte 0000:03:00.0: R_AX_WD_CPUQ_OP_2=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35306,663129304819,-;rtw89_8852bte 0000:03:00.0: R_AX_PL_CPUQ_OP_0=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35307,663129304829,-;rtw89_8852bte 0000:03:00.0: R_AX_PL_CPUQ_OP_1=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35308,663129304839,-;rtw89_8852bte 0000:03:00.0: R_AX_PL_CPUQ_OP_2=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35309,663129304849,-;rtw89_8852bte 0000:03:00.0: R_AX_WD_CPUQ_OP_STATUS=
=3D0x00000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35310,663129304859,-;rtw89_8852bte 0000:03:00.0: R_AX_PL_CPUQ_OP_STATUS=
=3D0x00000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35311,663129304869,-;rtw89_8852bte 0000:03:00.0: R_AX_RXDMA_PKT_INFO_0=3D=
0x80008868
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35312,663129304879,-;rtw89_8852bte 0000:03:00.0: R_AX_RXDMA_PKT_INFO_1=3D=
0x80008000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35313,663129304888,-;rtw89_8852bte 0000:03:00.0: R_AX_RXDMA_PKT_INFO_2=3D=
0x806688b6
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35314,663129304902,-;rtw89_8852bte 0000:03:00.0: R_AX_CMAC_ERR_ISR [0]=3D=
0x00000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35315,663129304913,-;rtw89_8852bte 0000:03:00.0: R_AX_CMAC_FUNC_EN [0]=3D=
0xf000803f
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35316,663129304923,-;rtw89_8852bte 0000:03:00.0: R_AX_CK_EN [0]=3D0xfffff=
fff
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35317,663129304934,-;rtw89_8852bte 0000:03:00.0: R_AX_CMAC_ERR_IMR [0]=3D=
0x00000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35318,663129304945,-;rtw89_8852bte 0000:03:00.0: [CMAC] : CMAC1 not enabl=
ed
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35319,663129304956,-;rtw89_8852bte 0000:03:00.0: R_AX_RPQ_RXBD_IDX =3D0x0=
0610060
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35320,663129304967,-;rtw89_8852bte 0000:03:00.0: R_AX_DBG_ERR_FLAG=3D0x00=
000000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35321,663129304976,-;rtw89_8852bte 0000:03:00.0: R_AX_LBC_WATCHDOG=3D0x00=
000081
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35322,663129304983,-;rtw89_8852bte 0000:03:00.0: <---
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
6,35323,663129304990,-;rtw89_8852bte 0000:03:00.0: SER catches error: 0x1000
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35324,663129305091,-;rtw89_8852bte 0000:03:00.0: queue 0 txwd 0 is not id=
le
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35325,663129305101,-;rtw89_8852bte 0000:03:00.0: No busy txwd pages avail=
able
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35326,663129305107,-;rtw89_8852bte 0000:03:00.0: queue 0 txwd 0 is not id=
le
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35327,663129305117,-;rtw89_8852bte 0000:03:00.0: queue 0 txwd 0 is not id=
le
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35328,663129305125,-;rtw89_8852bte 0000:03:00.0: queue 0 txwd 0 is not id=
le
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35329,663129305134,-;rtw89_8852bte 0000:03:00.0: queue 0 txwd 0 is not id=
le
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35330,663129305143,-;rtw89_8852bte 0000:03:00.0: queue 0 txwd 0 is not id=
le
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35331,663129305151,-;rtw89_8852bte 0000:03:00.0: queue 0 txwd 100 is not =
idle
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35332,663129305159,-;rtw89_8852bte 0000:03:00.0: Cannot map qsel to dma: =
31
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35333,663129305167,-;------------[ cut here ]------------
3,35334,663129305174,-;UBSAN: array-index-out-of-bounds in drivers/net/wire=
less/realtek/rtw89/pci.c:593:24
3,35335,663129305183,-;index 32767 is out of range for type 'rtw89_pci_tx_w=
d [512]'
4,35336,663129305192,-;CPU: 11 UID: 0 PID: 2179 Comm: irq/153-rtw89_p Not t=
ainted 6.14.6-300.fc42.x86_64 #1
4,35337,663129305198,-;Hardware name: HP HP OmniDesk Desktop M02-0xxx/8D37,=
 BIOS F.01 12/05/2024
4,35338,663129305201,-;Call Trace:
4,35339,663129305206,-; <IRQ>
4,35340,663129305217,-; dump_stack_lvl+0x5d/0x80
4,35341,663129305230,-; ubsan_epilogue+0x5/0x30
4,35342,663129305238,-; __ubsan_handle_out_of_bounds.cold+0x54/0x59
4,35343,663129305247,-; rtw89_pci_release_tx_skbs.isra.0+0x291/0x2d0 [rtw89=
_pci]
4,35344,663129305268,-; rtw89_pci_release_tx+0x1c/0x50 [rtw89_pci]
4,35345,663129305282,-; rtw89_pci_napi_poll+0x99/0x170 [rtw89_pci]
4,35346,663129305295,-; __napi_poll+0x2e/0x1b0
4,35347,663129305303,-; ? nohz_balance_exit_idle+0x88/0x100
4,35348,663129305311,-; net_rx_action+0x333/0x420
4,35349,663129305319,-; handle_softirqs+0xed/0x340
4,35350,663129305326,-; ? __pfx_irq_thread_fn+0x10/0x10
4,35351,663129305331,-; do_softirq.part.0+0x3b/0x60
4,35352,663129305335,-; </IRQ>
4,35353,663129305337,-; <TASK>
4,35354,663129305338,-; __local_bh_enable_ip+0x60/0x70
4,35355,663129305342,-; rtw89_pci_interrupt_threadfn+0xf7/0x260 [rtw89_pci]
4,35356,663129305353,-; ? __pfx_irq_thread+0x10/0x10
4,35357,663129305357,-; ? __pfx_irq_thread_fn+0x10/0x10
4,35358,663129305360,-; irq_thread_fn+0x22/0x60
4,35359,663129305366,-; irq_thread+0xea/0x1c0
4,35360,663129305370,-; ? __pfx_irq_thread_dtor+0x10/0x10
4,35361,663129305376,-; ? __pfx_irq_thread+0x10/0x10
4,35362,663129305380,-; kthread+0xec/0x230
4,35363,663129305385,-; ? __pfx_kthread+0x10/0x10
4,35364,663129305389,-; ret_from_fork+0x31/0x50
4,35365,663129305394,-; ? __pfx_kthread+0x10/0x10
4,35366,663129305398,-; ret_from_fork_asm+0x1a/0x30
4,35367,663129305404,-; </TASK>
4,35368,663129305405,-;---[ end trace ]---
4,35369,663129305631,-;rtw89_8852bte 0000:03:00.0: queue 0 txwd 32767 is no=
t idle
 SUBSYSTEM=3Dpci
 DEVICE=3D+pci:0000:03:00.0
4,35370,663129305651,-;Oops: general protection fault, probably for non-can=
onical address 0xd04db7a0fff2da77: 0000 [#1] PREEMPT SMP NOPTI
4,35371,663129305660,-;CPU: 11 UID: 0 PID: 2179 Comm: irq/153-rtw89_p Not t=
ainted 6.14.6-300.fc42.x86_64 #1
4,35372,663129305669,-;Hardware name: HP HP OmniDesk Desktop M02-0xxx/8D37,=
 BIOS F.01 12/05/2024
4,35373,663129305675,-;RIP: 0010:rtw89_pci_release_txwd_skb+0x64/0x230 [rtw=
89_pci]
4,35374,663129305691,-;Code: 41 80 bd 81 a9 00 00 00 0f 84 72 01 00 00 48 8=
b 04 24 4c 8b 78 10 4c 8d 70 10 4d 39 f7 0f 84 3e 01 00 00 45 84 e4 41 0f b=
6 c4 <49> 8b 1f 89 44 24 0c 0f 94 44 24 0b eb 4a 41 81 4f 28 00 02 00 00
4,35375,663129305700,-;RSP: 0018:ffff9f63c07e4d38 EFLAGS: 00010202
4,35376,663129305711,-;RAX: 0000000000000007 RBX: 0000000000007fff RCX: 000=
0000000000000
4,35377,663129305720,-;RDX: 0000000000000000 RSI: ffff9453df3a1940 RDI: fff=
f9453df3a1940
4,35378,663129305728,-;RBP: ffff944cd450c988 R08: 0000000000000000 R09: fff=
f9f63c07e4af0
4,35379,663129305735,-;R10: ffffffff9b8be730 R11: 0000000100004a2a R12: 000=
0000000000007
4,35380,663129305743,-;R13: ffff944cd4502000 R14: ffff944cd470c968 R15: d04=
db7a0fff2da77
4,35381,663129305751,-;FS:  0000000000000000(0000) GS:ffff9453df380000(0000=
) knlGS:0000000000000000
4,35382,663129305759,-;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
4,35383,663129305767,-;CR2: 00007f7c4ee89f60 CR3: 000000085382c006 CR4: 000=
0000000f72ef0
4,35384,663129305776,-;PKRU: 55555554
4,35385,663129305783,-;Call Trace:
4,35386,663129305791,-; <IRQ>
4,35387,663129305799,-; rtw89_pci_release_tx_skbs.isra.0+0x137/0x2d0 [rtw89=
_pci]
4,35388,663129305818,-; rtw89_pci_release_tx+0x1c/0x50 [rtw89_pci]
4,35389,663129305833,-; rtw89_pci_napi_poll+0x99/0x170 [rtw89_pci]
4,35390,663129305849,-; __napi_poll+0x2e/0x1b0
4,35391,663129305861,-; ? nohz_balance_exit_idle+0x88/0x100
4,35392,663129305871,-; net_rx_action+0x333/0x420
4,35393,663129305885,-; handle_softirqs+0xed/0x340
4,35394,663129305897,-; ? __pfx_irq_thread_fn+0x10/0x10
4,35395,663129305908,-; do_softirq.part.0+0x3b/0x60
4,35396,663129305917,-; </IRQ>
4,35397,663129305924,-; <TASK>
4,35398,663129305931,-; __local_bh_enable_ip+0x60/0x70
4,35399,663129305941,-; rtw89_pci_interrupt_threadfn+0xf7/0x260 [rtw89_pci]
4,35400,663129305961,-; ? __pfx_irq_thread+0x10/0x10
4,35401,663129305970,-; ? __pfx_irq_thread_fn+0x10/0x10
4,35402,663129305980,-; irq_thread_fn+0x22/0x60
4,35403,663129305990,-; irq_thread+0xea/0x1c0
4,35404,663129306001,-; ? __pfx_irq_thread_dtor+0x10/0x10
4,35405,663129306012,-; ? __pfx_irq_thread+0x10/0x10
4,35406,663129306022,-; kthread+0xec/0x230
4,35407,663129306033,-; ? __pfx_kthread+0x10/0x10
4,35408,663129306044,-; ret_from_fork+0x31/0x50
4,35409,663129306053,-; ? __pfx_kthread+0x10/0x10
4,35410,663129306063,-; ret_from_fork_asm+0x1a/0x30
4,35411,663129306075,-; </TASK>
4,35412,663129306081,-,ncfrag=3D0/1021;Modules linked in: isofs udf crc_itu=
_t uas usb_storage rpcsec_gss_krb5 nfsv4 dns_resolver nfs netfs netconsole =
hid_logitech_hidpp uhid rfcomm snd_seq_dummy snd_hrtimer dummy rpcrdma rdma=
_cm iw_cm ib_cm ib_core xfrm_interface xfrm6_tunnel tunnel4 tunnel6 nf_nat_=
tftp nf_conntrack_tftp nf_conntrack_netbios_ns nf_conntrack_broadcast wireg=
uard curve25519_x86_64 libcurve25519_generic ip6_udp_tunnel udp_tunnel brid=
ge stp llc nft_masq nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reje=
ct_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_log_syslog nft_log nft_=
ct nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_securit=
y iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_man=
gle iptable_raw iptable_security nf_tables ip_set ip6table_filter ip6_table=
s iptable_filter ip_tables bnep binfmt_misc btusb btrtl btintel btbcm btmtk=
 bluetooth joydev nfsd auth_rpcgss nfs_acl lockd grace nfs_localio sunrpc s=
nd_sof_pci_intel_tgl snd_so4,35412,663129306081,-,ncfrag=3D963/1021;f_pci_i=
ntel_cnl snd_sof_intel_hda_generic soundwire_intel
4,35413,663129306248,c,ncfrag=3D0/1018; soundwire_cadence snd_sof_intel_hda=
_common snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_sof_=
pci snd_sof_xtensa_dsp snd_sof snd_hda_codec_hdmi snd_sof_utils snd_soc_acp=
i_intel_match rtw89_8852bte snd_soc_acpi_intel_sdca_quirks soundwire_generi=
c_allocation snd_soc_acpi rtw89_8852bt soundwire_bus snd_soc_sdca rtw89_885=
2b_common snd_soc_avs rtw89_pci snd_hda_codec_realtek snd_soc_hda_codec snd=
_hda_codec_generic intel_uncore_frequency snd_hda_ext_core intel_uncore_fre=
quency_common rtw89_core snd_hda_scodec_component snd_soc_core x86_pkg_temp=
_thermal snd_compress intel_powerclamp ac97_bus snd_pcm_dmaengine coretemp =
snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi mac80211 kvm_intel snd_hd=
a_codec snd_hda_core kvm snd_hwdep snd_seq processor_thermal_device_pci lib=
arc4 snd_seq_device processor_thermal_device processor_thermal_wt_hint proc=
essor_thermal_rfim iTCO_wdt snd_pcm spi_nor irqbypass intel_pmc_bxt intel_r=
apl_msr processor_thermal_r4,35413,663129306248,c,ncfrag=3D963/1018;apl mtd=
 rapl cfg80211 spd5118 intel_rapl_common hp_wmi
4,35414,663129306386,c; snd_timer iTCO_vendor_support intel_cstate mei_hdcp=
 mei_pxp snd intel_pmc_core sparse_keymap processor_thermal_wt_req i2c_i801=
 platform_profile spi_intel_pci processor_thermal_power_floor intel_uncore =
wmi_bmof rfkill pcspkr soundcore int3403_thermal i2c_smbus spi_intel pmt_te=
lemetry processor_thermal_mbox int3400_thermal pmt_class int340x_thermal_zo=
ne acpi_pad acpi_tad acpi_thermal_rel mei_me mei loop dm_multipath nfnetlin=
k zstd zram lz4hc_compress lz4_compress dm_crypt xe vfat fat drm_ttm_helper=
 gpu_sched drm_suballoc_helper drm_gpuvm drm_exec i915 target_core_mod i2c_=
algo_bit drm_buddy ttm nvme drm_display_helper polyval_clmulni polyval_gene=
ric ghash_clmulni_intel nvme_core r8169 sha512_ssse3 sha256_ssse3 sha1_ssse=
3 cec realtek nvme_auth intel_vsec video wmi scsi_dh_rdac scsi_dh_emc scsi_=
dh_alua pkcs8_key_parser tls fuse [last unloaded: netconsole]
4,35415,663129306556,-;---[ end trace 0000000000000000 ]---
4,35416,663129306564,-;RIP: 0010:rtw89_pci_release_txwd_skb+0x64/0x230 [rtw=
89_pci]
4,35417,663129306583,-;Code: 41 80 bd 81 a9 00 00 00 0f 84 72 01 00 00 48 8=
b 04 24 4c 8b 78 10 4c 8d 70 10 4d 39 f7 0f 84 3e 01 00 00 45 84 e4 41 0f b=
6 c4 <49> 8b 1f 89 44 24 0c 0f 94 44 24 0b eb 4a 41 81 4f 28 00 02 00 00
4,35418,663129306595,-;RSP: 0018:ffff9f63c07e4d38 EFLAGS: 00010202
4,35419,663129306607,-;RAX: 0000000000000007 RBX: 0000000000007fff RCX: 000=
0000000000000
4,35420,663129306616,-;RDX: 0000000000000000 RSI: ffff9453df3a1940 RDI: fff=
f9453df3a1940
4,35421,663129306626,-;RBP: ffff944cd450c988 R08: 0000000000000000 R09: fff=
f9f63c07e4af0
4,35422,663129306634,-;R10: ffffffff9b8be730 R11: 0000000100004a2a R12: 000=
0000000000007
4,35423,663129306643,-;R13: ffff944cd4502000 R14: ffff944cd470c968 R15: d04=
db7a0fff2da77
4,35424,663129306651,-;FS:  0000000000000000(0000) GS:ffff9453df380000(0000=
) knlGS:0000000000000000
4,35425,663129306661,-;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
4,35426,663129306670,-;CR2: 00007f7c4ee89f60 CR3: 000000085382c006 CR4: 000=
0000000f72ef0
4,35427,663129306681,-;PKRU: 55555554
0,35428,663129306689,-;Kernel panic - not syncing: Fatal exception in inter=
rupt
0,35429,663129306823,-;Kernel Offset: 0x18000000 from 0xffffffff81000000 (r=
elocation range: 0xffffffff80000000-0xffffffffbfffffff)
0,35430,663129306833,-;Rebooting in 1 seconds..

--cM/Eq+FUe+VnaN9D--


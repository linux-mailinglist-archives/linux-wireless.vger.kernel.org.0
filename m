Return-Path: <linux-wireless+bounces-24806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C217EAF85E8
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 05:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4FC567435
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 03:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E64B5AE;
	Fri,  4 Jul 2025 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="h6+Pylnx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9900381C4
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751598503; cv=none; b=pk0Uh25/txjcsNBblxmOAbbnPMkBqcWLyYrs9299JHNPkb/i7wy/+wk+X4neUJ7LukwHmMbwaFwz20FYtaP3YLl3Ap6cC9Dt59ecIVPXtmfma50hvgMMj/fg6CWs2HSsSbxcrv6zSI/NyMmR9VYCDMumC/TSwaysAQx/L1uxkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751598503; c=relaxed/simple;
	bh=vIYtokiwcjeYGMmNlXzaIgo9UM71RRQS1c6gIBeVcws=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=H4r24nz/n2yQbYcKTwhS7EpuQ+DARgm3hdDn/8nUenzcE6Z6xOJMX25EfHVEYvrzEd6vlj1pZreHBV4z6ON7ElYRQFAeQj+VLU9CPltPHYWpKasl5Z1cmIj+dEUKcDkSWwyuuGuzb0FeMc2iv9DpZoxtwNduyWfrTZlUXKXCse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=h6+Pylnx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56438G4U03636294, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751598496; bh=to8FbYNvs/IgSPaj5hc4i0PpfHceGsZ3IlzohMUhpKI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=h6+Pylnx+pfT/0RtXukSThPbqNylIFfFogf9xLU0WARVfefOXn0p6oESH6KL3zO1G
	 xq83o3tSIkXL1K4oIDIxlylU5n3cIJmCkg/BROBemfSNFVPNHBXykHDa1ja0+Qsn79
	 hfEJuWuZz4EwCgXKibkybnMHy5pEJI0Qt3aUTrFcTcGcHWY+h0wQhnudvvjpf/oWM2
	 iPVsDaxyYwUxXMPwAHuGoMaQmWbwcuS+7mM0scK+57IlT+VWvonwZ07axclR310Suc
	 3dqXqDlXxD3htJPcIjM3oaoGt3Qc7Y10G/OP75gQmJtPDpskOVrphhvIdWYRiT5Kgd
	 0qExWavyR+ZRw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56438G4U03636294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 11:08:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Jul 2025 11:08:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 4 Jul
 2025 11:08:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v4 01/14] wifi: rtw89: 8851b: Accept USB devices and load their MAC address
In-Reply-To: <6b2a1382-3be4-4038-8005-cf96922e4332@gmail.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com> <6b2a1382-3be4-4038-8005-cf96922e4332@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <69ad0a30-b5f6-4312-b4f4-317d715d5a25@RTEXMBS04.realtek.com.tw>
Date: Fri, 4 Jul 2025 11:08:40 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Make rtw8851b_read_efuse() accept USB devices and load the MAC address
> from the correct offset.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

14 patch(es) applied to rtw-next branch of rtw.git, thanks.

4b6ea5a38197 wifi: rtw89: 8851b: Accept USB devices and load their MAC address
ee47816f24a1 wifi: rtw89: Make dle_mem in rtw89_chip_info an array
82870ba25f32 wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
3c63450c8723 wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
02a44c263031 wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
a3b871a0f7c0 wifi: rtw89: Disable deep power saving for USB/SDIO
ec542d5e4bf6 wifi: rtw89: Add extra TX headroom for USB
0740c6beefae wifi: rtw89: Hide some errors when the device is unplugged
e906a11753c9 wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for USB
e2b71603333a wifi: rtw89: Fix rtw89_mac_power_switch() for USB
ed88640ea1ac wifi: rtw89: Add some definitions for USB
bd569751baff wifi: rtw89: Add usb.{c,h}
fd1484e36768 wifi: rtw89: Add rtw8851bu.c
5b500ada7173 wifi: rtw89: Enable the new USB modules

---
https://github.com/pkshih/rtw.git



Return-Path: <linux-wireless+bounces-29751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D487CBD089
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 09:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E2CD3014A22
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4EA3321C7;
	Mon, 15 Dec 2025 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Td8dbneu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC73321C8
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788601; cv=none; b=Vu6va0maiVMbbktEvpSNXQDirWM0MCIXHHkHq1NZAEZDYkM1nkS+XI1iZD2cfBIGGO8ogpjnmX0NE5ruGPprUqN9S00rTdcVlznw/xWJmEieqfPb2uoenIwyC7DUlgqhoQdPWbUncQibVb9hm0e59HudLZafjtDOzM3t4+kRj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788601; c=relaxed/simple;
	bh=F1UsMQXYzqk+QkzaGnqvb/L9JUlwbdY7q7HxXTbiJ+w=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=sYbWcC2IimqCvehexkO8FvCP/137+36gjIs/ce2/vCnHWAaBdGHH4aUov/PbPBh3tE5C9fnYllxbrlJ/4yjDVTZhCjYYKWg+4QeHRKpfvi2Vu8zvnc1ZqTLwo223V7Eqj2eY44OzvrkY5hco05g5s031CNW47xfldPz60tKB1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Td8dbneu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BF8nqVY31499874, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765788592; bh=W+XrelAYTIQ08+zsv8mFD/Y9qzo2PCeut5Z+0DBnhfI=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Td8dbneueui7OfdgCHryWjiAYVUJTuja8RpD3CpQM+58M0Ub2QJKLPnkjeyGnKdB3
	 s1WmSRhfd1O54/IJumMuDKYfGV3WbdOAQePaKszhAiHBTP4MNo8qTqrJw1kjREQxbs
	 fRxyMsHbVI+4ET2Og9Hk3BbgnDMcJuASeEKMDtOhMSrPYkLYLS/RMgOrwOmH59+4pt
	 UG2hJR4bzqmIAodgMwGWhsUdqc2p6CMF40GVBc1ZD+r1adAWhRlRs2AeOmvGhgSy+N
	 xMmDHg5eOpACInP8M8RUwIkfZVnlMHGGTScES39kYffRyxR1wdl4Q/tJKE0/+juZoV
	 RQerej14nwS/Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BF8nqVY31499874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 16:49:52 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 15 Dec 2025 16:49:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 15 Dec 2025 16:49:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>,
        Marco Crivellari
	<marco.crivellari@suse.com>
Subject: Re: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users"
In-Reply-To: <d57efe48-b8ff-4bf1-942c-7e808535eda6@gmail.com>
References: <d57efe48-b8ff-4bf1-942c-7e808535eda6@gmail.com>
Message-ID: <891fbe8f-43a5-4d45-92ee-96d2a920c92f@RTKEXHMBS03.realtek.com.tw>
Date: Mon, 15 Dec 2025 16:49:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> This reverts commit 9c194fe4625db18f93d5abcfb7f7997557a0b29d.
> 
> This commit breaks all USB wifi adapters supported by rtw88:
> 
> usb 1-2: new high-speed USB device number 6 using xhci_hcd
> usb 1-2: New USB device found, idVendor=2357, idProduct=0138, bcdDevice= 2.10
> usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 1-2: Product: 802.11ac NIC
> usb 1-2: Manufacturer: Realtek
> usb 1-2: SerialNumber: 123456
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 152 at kernel/workqueue.c:5667 alloc_workqueue_noprof+0x676/0x770
> 
> [...]
> 
> Call Trace:
>  <TASK>
>  ? rtw_usb_probe+0x30e/0xa5c [rtw88_usb 4af3cb64eedafeecbfb08f80c1e9e2893e2ee7a6]
>  rtw_usb_probe+0x3eb/0xa5c [rtw88_usb 4af3cb64eedafeecbfb08f80c1e9e2893e2ee7a6]
>  usb_probe_interface+0xdd/0x2c0
>  really_probe+0xdb/0x340
>  ? pm_runtime_barrier+0x55/0x90
>  ? __pfx___device_attach_driver+0x10/0x10
>  __driver_probe_device+0x78/0x140
>  driver_probe_device+0x1f/0xa0
>  __device_attach_driver+0x89/0x110
>  bus_for_each_drv+0x8f/0xe0
>  __device_attach+0xb0/0x1c0
>  bus_probe_device+0x90/0xa0
>  device_add+0x663/0x880
>  usb_set_configuration+0x5a5/0x870
>  usb_generic_driver_probe+0x4a/0x70
>  usb_probe_device+0x3d/0x140
>  ? driver_sysfs_add+0x59/0xd0
>  really_probe+0xdb/0x340
>  ? pm_runtime_barrier+0x55/0x90
>  ? __pfx___device_attach_driver+0x10/0x10
>  __driver_probe_device+0x78/0x140
>  driver_probe_device+0x1f/0xa0
>  __device_attach_driver+0x89/0x110
>  bus_for_each_drv+0x8f/0xe0
>  __device_attach+0xb0/0x1c0
>  bus_probe_device+0x90/0xa0
>  device_add+0x663/0x880
>  usb_new_device.cold+0x141/0x3b5
>  hub_event+0x1132/0x1900
>  ? page_counter_uncharge+0x4a/0x90
>  process_one_work+0x190/0x350
>  worker_thread+0x2d7/0x410
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xf9/0x240
>  ? __pfx_kthread+0x10/0x10
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x1c1/0x1f0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> rtw88_8822bu 1-2:1.0: failed to create RX work queue
> rtw88_8822bu 1-2:1.0: failed to init USB RX
> rtw88_8822bu 1-2:1.0: Firmware version 27.2.0, H2C version 13
> rtw88_8822bu 1-2:1.0: probe with driver rtw88_8822bu failed with error -12
> 
> WQ_UNBOUND is not compatible with WQ_BH. Comment in enum wq_flags in
> workqueue.h says:
> 
> 	/* BH wq only allows the following flags */
> 	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI | WQ_PERCPU,
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw branch of rtw.git, thanks.

0ff5e81e1518 Revert "wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users"

---
https://github.com/pkshih/rtw.git



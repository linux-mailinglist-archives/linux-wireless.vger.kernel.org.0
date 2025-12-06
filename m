Return-Path: <linux-wireless+bounces-29562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E371CAAC2F
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 19:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A12330012FE
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAF526FA5A;
	Sat,  6 Dec 2025 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVJOsP7N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5426B955
	for <linux-wireless@vger.kernel.org>; Sat,  6 Dec 2025 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765045970; cv=none; b=sH+WuGNskbCBrEbn0IYyawRydMALZwBmwJ3OLZvUyxiq10CycVif7bpsVyZjtWCwC30Zmuevk0nn88y0eSIURp91ATBtUqvbzK2L6Pw4E0gXBGVuDsThjdrTe57WLOpNs2M3tU0/liYou5ytFhhijK12vn8IC2Eos0SO7IMxBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765045970; c=relaxed/simple;
	bh=KXh8127xU4uIroPaeVLsiG1G7B4ktbjXj11Uk5yHnD8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=M1rLgqJ/n4arK/jdy8OUm7uqiLeH35UgfNuY+6PvOlAcgNq9IxR7Zg3+cKmfffR5lhUKOoLkr0k4tbKHspxuLB7GOQrJk28y/IizWTNirgh2WbAVd9+Ed766jkUClOi8O0HQda7ydYOAh4XGM1AndHBALtv0GqmOsEHn1aOdVCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVJOsP7N; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47789cd2083so19299585e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 06 Dec 2025 10:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765045967; x=1765650767; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSP9KVWH0//JKTY0ijYP32kJeIaZiGhIjsIfLDD9Mss=;
        b=PVJOsP7Nne7TaWrVoLpOUbsE61Gvh3O6XtIKV4ZaPqXre4PcyqV0r1JxlQtgkZ5pLo
         ZseOLpG0brwpgH1SG0rMTikO541Kfa0wTpv1klFJLAkwYFFRAZkzmGSp+l0EaXYgAjeB
         g0bjdovek0pvF9JRGmg0iDJ6xJpX2zaFFEgBXRP5PZyDYIJkOaZTg9t2py+WI447NNgk
         z6mtqxTjcuVzqEWPshaxt0N2FkZY8H3wHp2ouJhu4UDCkK5Ekn/88qHcjCO0dPHE0yxd
         4Q8qBHpngFpxB/8XjI9h6HkUT9ids6Cm2ablSKudi/rXGgTuNLa5Q1g7JtijOVVgVG6v
         Rp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765045967; x=1765650767;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JSP9KVWH0//JKTY0ijYP32kJeIaZiGhIjsIfLDD9Mss=;
        b=IsrRSjWF5JNvTqHj/oL9K69ghbLC5SCwVlsYS6w80axpQk2j3nmhk/Rry5dK2gROdr
         rTipVC2HKgn8hfCL396LSPe0mt++0e0bfzRPa+h4y/ko5hukUxokqXKo0g0Pyvaa5Lun
         U+dEdD64YFbbwlYU2KlMwHL1y6jZrKXV1jLORqHQqmBrpigM0YQFlHzNUIff+MvraEqK
         ShcSjPhg6HCa+ngqUFs2EoDxdNc23LqeLX31+lee1ZfCiSdG0cWUbj8YBlm9Ir5vfJd1
         UvqS680XKD7cd+e5hT8WxQyBE46DZcXKqwg+3YaaSCB6Aozsaxgei1pPHkU3xe6xwrUv
         DB9g==
X-Gm-Message-State: AOJu0Yx+sdafoWRjZx2NEw7xkO8D0T7t6MT+KpziJZUBQPM3+JjvvScj
	QarxieqfC5XQ6R39Ufy3GNtnd8IYApFhC9WyPrdUfLqD1FDwYQ1ZGEgZPIYKJg==
X-Gm-Gg: ASbGncuhyj6eLkixPrI+y+zk3INCI4NPHJHwXj1Nry9atNhAL4ywONjEnDs8gDsdB23
	G8iK2QEnybFGaNefm4V7UM4m1RXnGirYZwSX/WD22C0Haxph1GK02Oq58By2Qi07VgSmfHLkNBp
	CVsrnePZ0SA4ZFF9IB0w1u/kKbCWCIKgh+C2Jt26KfBObRUU8ZYBtDLsB6cONlnzSUws9Y/sdMc
	mQiXriVpi5nCMDw7bxVKS8EhNMIvKTvjqeL8LBLlNlhGre6F8wCGn6TdJ8aSFpRroZ1Kv7DqRWS
	kBD2Z2uiuZ89mv0hBVM8hnDfDO8hHOrVNvG8CzYLxmeeY5w5hNJ5/oLw1Ubqw2j7h7gCEgVIraX
	WFls7t3OfoJ0I9mYsIzyQ37zfHG0C5Mbql6gjlLaJLWoSg507oGhX5WDJnjevvvlcuhN3oX6V0i
	qvVY8rXp8Z9JgcQtxUZXk+
X-Google-Smtp-Source: AGHT+IH0CfPnc8v1DkvYghVk+dDRDlqDDerc9kZvrWhlzzvpd97wZdrDTMY3WiHFMsCQc8A2xpZstA==
X-Received: by 2002:a05:600c:6989:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47939c913d3mr35998995e9.0.1765045966944;
        Sat, 06 Dec 2025 10:32:46 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310b8e70sm150489855e9.5.2025.12.06.10.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Dec 2025 10:32:46 -0800 (PST)
Message-ID: <d57efe48-b8ff-4bf1-942c-7e808535eda6@gmail.com>
Date: Sat, 6 Dec 2025 20:32:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Marco Crivellari <marco.crivellari@suse.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This reverts commit 9c194fe4625db18f93d5abcfb7f7997557a0b29d.

This commit breaks all USB wifi adapters supported by rtw88:

usb 1-2: new high-speed USB device number 6 using xhci_hcd
usb 1-2: New USB device found, idVendor=2357, idProduct=0138, bcdDevice= 2.10
usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-2: Product: 802.11ac NIC
usb 1-2: Manufacturer: Realtek
usb 1-2: SerialNumber: 123456
------------[ cut here ]------------
WARNING: CPU: 3 PID: 152 at kernel/workqueue.c:5667 alloc_workqueue_noprof+0x676/0x770

[...]

Call Trace:
 <TASK>
 ? rtw_usb_probe+0x30e/0xa5c [rtw88_usb 4af3cb64eedafeecbfb08f80c1e9e2893e2ee7a6]
 rtw_usb_probe+0x3eb/0xa5c [rtw88_usb 4af3cb64eedafeecbfb08f80c1e9e2893e2ee7a6]
 usb_probe_interface+0xdd/0x2c0
 really_probe+0xdb/0x340
 ? pm_runtime_barrier+0x55/0x90
 ? __pfx___device_attach_driver+0x10/0x10
 __driver_probe_device+0x78/0x140
 driver_probe_device+0x1f/0xa0
 __device_attach_driver+0x89/0x110
 bus_for_each_drv+0x8f/0xe0
 __device_attach+0xb0/0x1c0
 bus_probe_device+0x90/0xa0
 device_add+0x663/0x880
 usb_set_configuration+0x5a5/0x870
 usb_generic_driver_probe+0x4a/0x70
 usb_probe_device+0x3d/0x140
 ? driver_sysfs_add+0x59/0xd0
 really_probe+0xdb/0x340
 ? pm_runtime_barrier+0x55/0x90
 ? __pfx___device_attach_driver+0x10/0x10
 __driver_probe_device+0x78/0x140
 driver_probe_device+0x1f/0xa0
 __device_attach_driver+0x89/0x110
 bus_for_each_drv+0x8f/0xe0
 __device_attach+0xb0/0x1c0
 bus_probe_device+0x90/0xa0
 device_add+0x663/0x880
 usb_new_device.cold+0x141/0x3b5
 hub_event+0x1132/0x1900
 ? page_counter_uncharge+0x4a/0x90
 process_one_work+0x190/0x350
 worker_thread+0x2d7/0x410
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xf9/0x240
 ? __pfx_kthread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1c1/0x1f0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
---[ end trace 0000000000000000 ]---
rtw88_8822bu 1-2:1.0: failed to create RX work queue
rtw88_8822bu 1-2:1.0: failed to init USB RX
rtw88_8822bu 1-2:1.0: Firmware version 27.2.0, H2C version 13
rtw88_8822bu 1-2:1.0: probe with driver rtw88_8822bu failed with error -12

WQ_UNBOUND is not compatible with WQ_BH. Comment in enum wq_flags in
workqueue.h says:

	/* BH wq only allows the following flags */
	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI | WQ_PERCPU,

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
Fortunately this commit is not in any released kernel yet.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 22b9cbf2268a..bf6bedf7cb5f 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -972,8 +972,7 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 	struct sk_buff *rx_skb;
 	int i;
 
-	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH | WQ_UNBOUND,
-				       0);
+	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_BH, 0);
 	if (!rtwusb->rxwq) {
 		rtw_err(rtwdev, "failed to create RX work queue\n");
 		return -ENOMEM;
-- 
2.51.1



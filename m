Return-Path: <linux-wireless+bounces-30324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2D5CF17AC
	for <lists+linux-wireless@lfdr.de>; Mon, 05 Jan 2026 01:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 235E83007DB0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jan 2026 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B2D1494A8;
	Mon,  5 Jan 2026 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZdAMv82"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067363B2AA
	for <linux-wireless@vger.kernel.org>; Mon,  5 Jan 2026 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767572814; cv=none; b=kb6+MkgTqhUE0y7rWqUbLR35GikRh3LejNJBi2PFtXRiuy/qLWxTEPGZue+Ugg0JhVMQZoMyz3t81xiT3Af/Xuyek2WAjshwQGXhCUtZBG3lGXVqBBUsHMIenei0SQdVZ3JdDYLSr7wiZuH/fWhCALAdibGtPfIzOTPg2x49pZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767572814; c=relaxed/simple;
	bh=QsR5/OKd7dRBwCFTqGC5Zw+i/++FftRL2ti6sVT5Ug4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbqQpq4LiDXEYyOQf+4tjooqoh75JFx9xFHkJjLaIElDIjR3x4awxWtdhiNSg52jb7lsl30ksOdhrhbXuR2kDKQfBsl8DjTihRn+3kUAORW4tg1gmZcXGCp/wHc0psvfrjYWU44Kz9kwhKFUEJTQrMdwmKn3R0r5ZlIWiGHa/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZdAMv82; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso14568934a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jan 2026 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767572812; x=1768177612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAgVTP0BzLqwfWTeezG65MLKR0/RKkukMTGhqy2j9so=;
        b=IZdAMv82tfl08bSCZUB3niKU/tbTIZqnIffZeJkpLUQqP3goaB3XQLH+/YZXV597sx
         Trs977YuGQXm6AeGJ6nKc3Yq3XC6iQYnUHcSZwJEXr5pKB40mteWTbtcBjnF1LLPWe8A
         xV2yk1Cxmcg4CSludJ4uj8VYl+u7hVcYXIFgK3WGj4zvfoa4HMx4L+gt5fy7GTro6EyQ
         SzmVwNCGf+uzjbStrWvBtZrg/li4JYN7ybuQQGV2YBM7pgr4Cmr/cbxG/ApumnHTurhw
         VV+8N6OorKl5eWfY4dklhSVkngYS5ELtGOt0OmiZunwEU4BOY/HKVtNW5pRNtnFmUCG6
         /8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767572812; x=1768177612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xAgVTP0BzLqwfWTeezG65MLKR0/RKkukMTGhqy2j9so=;
        b=xEuFMdQKbThRi3NSkrHQNEZCL8ud8X8erXAGGq2BE8R2BChainCp3GFVeP7NogbeVR
         GrnH78+AlQZbyMQgb4OglqBqyp3e4iMtugj1usvwF/xhj1qgvs2KZwqArz1LFE/Ge4ya
         We/SbH/8olKJmnR1H1fFz+p5heDmJ16GHApJT+gYH3RxDQ2dfKEIiUEEJHbHqI5m3Vkx
         P9jNPxpApaUrENZ7doplgw6eblmSLVG8baBYheef6ev2bFA9YJYBUtvTzowZRopxiY5S
         dLnN2fhtLcakT7Wp3srROVfEnpP0TJsAzV2UyQ1lHt78o07YrOHvdbzj6w5qnzJGuzKP
         7tcA==
X-Forwarded-Encrypted: i=1; AJvYcCWyUfgX8550BfWf905Bv59qFP3THKdDfjU6l3QpRz+nAxHm+9DojDvhz/ixVIRY1V8ri9OPcxpTgXQpm7INWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQiFvd9bgx4Pxc35sWN41pubS2nle4lN4R3rEiyL3KqUfRns8
	I4G8rh2Eoku/KQ8Z8EU1D71RFKnESNQsNTgm8BhqZSJ51rf7n+8JfCDnnk0+5DSP
X-Gm-Gg: AY/fxX6473u8EQVg/qs2dCdu6jlooLIt0XHQ+gRBBBu6gu167vO1z00J6V82mBgNh3B
	RL3VMA9t0Dx3pkM6iIvGt10Oei7mYCa1YfJzmYjfAWYgyN5KQojsQByTCRrV/YPXarxQfon2S+8
	nKaVkoJqaSU+LfEE1un8N3Z12eoK5Z5YSpM7XhUSISae3JsGw6mc7kZ3CSvIIe0VaV6/Sc/k+4y
	1oGIoj5xBc9Q6YH3YqS5bJRmpsf2mxQYTvfffhSdETb8Sg/xBC0K48hwIh/MSg4POEP/WqSb7Ae
	bZc6zx+285Xc0Sa6VEbWSozeLbD2ufQ6ii16HtJkvGF44Dzr1+cGcQRmZ+7O8YDY/ei7IUYP3j8
	hwjk+zfWP8Zv5748tnRB7hVYKb/RMbrXO8wJ++yXpIPR5vSXRqOCKwRE7z5sdt0ib6H2t8v7uWu
	Lj3kiusXNIiZv5j6y6X20s0cjQfgqsWL19nXJcudHeg8lPv7CLMBKtwMzyMYgOHNY=
X-Google-Smtp-Source: AGHT+IFKYGpXpbeOzNKq3w85a9004NHjGaMx7/DnJGknvJa/Jb0muU+WLPE3Jt6/U31pHd5HhFvK7A==
X-Received: by 2002:a05:7022:f902:20b0:11c:b3ad:1fe1 with SMTP id a92af1059eb24-121722b1a7bmr41061173c88.11.1767572812230;
        Sun, 04 Jan 2026 16:26:52 -0800 (PST)
Received: from zubuntu.bengal-mercat.ts.net ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm133378109c88.8.2026.01.04.16.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:26:51 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: zbowling@gmail.com
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com
Subject: [PATCH 02/17] wifi: mt76: mt7925: fix missing mutex protection in reset and ROC abort
Date: Sun,  4 Jan 2026 16:26:23 -0800
Message-ID: <20260105002638.668723-3-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
References: <20260102200524.290779-1-zbowling@gmail.com>
 <20260105002638.668723-1-zbowling@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During firmware recovery and ROC (Remain On Channel) abort operations,
the driver iterates over active interfaces and calls MCU functions that
require the device mutex to be held, but the mutex was not acquired.

This causes system-wide deadlocks where the system becomes completely
unresponsive. From logs on affected systems:

  INFO: task kworker/u128:0:48737 blocked for more than 122 seconds.
  Workqueue: mt76 mt7925_mac_reset_work [mt7925_common]
  Call Trace:
   __schedule+0x426/0x12c0
   schedule+0x27/0xf0
   schedule_preempt_disabled+0x15/0x30
   __mutex_lock.constprop.0+0x3d0/0x6d0
   mt7925_mac_reset_work+0x85/0x170 [mt7925_common]

The deadlock manifests approximately every 5 minutes when the adapter
tries to hop to a better BSSID, triggering firmware reset. Network
commands (ip, ifconfig, etc.) hang indefinitely, processes get stuck
in uninterruptible sleep (D state), and reboot hangs as well.

Add mutex protection around interface iteration in:
- mt7925_mac_reset_work(): Called during firmware recovery after MCU
  timeouts to reconnect all interfaces
- mt7925_roc_abort_sync() in suspend path: Called during suspend to
  clean up Remain On Channel operations

This matches the pattern used in mt7615 and other MediaTek drivers where
interface iteration callbacks invoke MCU functions with mutex held:

  // mt7615/main.c - roc_work has mutex protection
  mt7615_mutex_acquire(phy->dev);
  ieee80211_iterate_active_interfaces(...);
  mt7615_mutex_release(phy->dev);

Note: Sean Wang from MediaTek has submitted an alternative fix for the
ROC path using cancel_delayed_work() instead of cancel_delayed_work_sync().
Both approaches address the deadlock; this one adds explicit mutex
protection which may be superseded by the upstream fix.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Link: https://community.frame.work/t/kernel-panic-from-wifi-mediatek-mt7925-nullptr-dereference/79301
Reported-by: Zac Bowling <zac@zacbowling.com>
Tested-by: Zac Bowling <zac@zacbowling.com>
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 184efe8afa10..06420ac6ed55 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1331,9 +1331,11 @@ void mt7925_mac_reset_work(struct work_struct *work)
 	dev->hw_full_reset = false;
 	pm->suspended = false;
 	ieee80211_wake_queues(hw);
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_vif_connect_iter, NULL);
+	mt792x_mutex_release(dev);
 	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
 
 	mt7925_regd_change(&dev->phy, "00");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c01d..e9d62c6aee91 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -455,7 +455,9 @@ static int mt7925_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt792x_mutex_acquire(dev);
 	mt7925_roc_abort_sync(dev);
+	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
-- 
2.51.0



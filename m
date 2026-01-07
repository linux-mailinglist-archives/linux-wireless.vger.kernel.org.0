Return-Path: <linux-wireless+bounces-30513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3FD006E5
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 01:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFFA0301A70E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 23:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E82B2FA0C6;
	Wed,  7 Jan 2026 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duk7FAkE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F122571B0
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767830361; cv=none; b=RbklARx2vII01Y+8rfE3MV4K3ngLo1Ad39j4/me5jWPtLj4JKjMuG3Lk/YuWw/uoGi+sUDnN1Pnh+8QCQjLYAKK7WTV/KEFoBsMjF1k7svhokLQuMhIsGca6yK5vwK7rAPuMJXhLH0iiH13lpcNRT+d3Hf3LYUb6qgCmzkcOh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767830361; c=relaxed/simple;
	bh=JtRtlMFx3muoeCPIMjbQDuCpXGItr+dhDW4r7pZq3W0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFtav1NvkDZfn5lIeKulgSLtAFrZIQJ1be2uvszWjf1b8HOkwPKVUAU25hBTX2xh2pmDJF8vzdg/Z6XdobCIbPq4pTTPFxFuVNhDg3oaL1BRjGEvrO6xD6MqJrsyM3tf59A2wm2eunoD1QEQZH7Ojhb6RQwM9oSqzHymJON4bQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duk7FAkE; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso2281012eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 15:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767830359; x=1768435159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ow/N1ZmXxzwSWBbQdkni8/opm9FVLYZuNitVYYOiRVw=;
        b=duk7FAkEEgsEEynYv8iczGpHsTMo9LYdqoe2AKfOjnSZG492lWTnMq0qhgw31VQRd6
         4AJHqlJOF11ItNn+cUq57rnXGEBAlwrkuaesrYdPTguHhbxYF6sKuCJ/KbbFuQqtelsP
         N7zeQeSgb1uBRRxApfTxBGTNNUWlsK9EVy3uQ7JhrY2XAzdidmas4uUDB9JIinV3wOXt
         n8sVaHJGMH9T/kLhPrrFTXbHePfG3O3vF70eHRbxiX22/95eulvu/WiyXHPq0CxSbxwJ
         bmjfXDG8GhU2g7J4dbnWW9nlr0ro2TEWyqYkBE/0lKpt1rb2gYvB34yGtsHaJTRqowcQ
         6q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767830359; x=1768435159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow/N1ZmXxzwSWBbQdkni8/opm9FVLYZuNitVYYOiRVw=;
        b=WlTUq68wwcpD3UCLVLdsVZUU0zJOXahF6FxGIyzP2nAwYB35BQcaKzfWY/STVn7etE
         r3dwSx/bOjC0AJsd4eSnHlyW3ji8588tWlIb9ThZfS1kjWOpSmEyKNGgmijf0FKNBLs/
         bze6yE3M7M69xRwIZMmdgevI3QNw/7ec1vKIkP4xaDr+lWWNX8vvKl/KCtvNQmdWwXpt
         QEvNZqh83C/b+lpD0Gc1WS/zXgu7pr9nTH05Am0NP/dBxs1jy0GE5Ai9dA7UaV9d29Rq
         fWtQNTfyhQs47OcaCbLGRBMXqFgaboC7hJF5Z4cB5dedqPFnnf+jebq5EEETk/IakCUh
         7FXg==
X-Forwarded-Encrypted: i=1; AJvYcCVdKV2IoVCUdSiuOX1qoABxw1vNO6NDRTlC+iVTqCOC5Bm5fadTLk62aOvKmDEHVTJv5or8BW89wiv9QndEXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRbC0qYXwUC5Ygr/8u7ugITFWkDeAn/U5FLmVdrHYY/xDn/O38
	SS1xVzzbf4tvZw/ZFBIWP9upr94TmuGfBUfRqXyYQbJOKcO1aNdpewsO
X-Gm-Gg: AY/fxX7DgUXkPvuj9GYQtLPGJmzvKdj5bFSBaark4iENW7aAfX+MruXc5gOMEpgiBnT
	fsohRwF9kXjTgTvHso6RdnobUCGp1bqfosnepU/2L2gx3Xk2tTCFgh0ArUhYSvjvwpU4TrpGZL0
	dPuDz8tUBZk9OCjI3miKXHUAh++JHcfrASebOuWAOAvArggHR3b/7YDi65gKsSGITfNAvd+DVL4
	MGCv/1tiZGay+lFVOMzPb5bRTRNNMIaiWfuT8noZtyBX9s/qEQRtCF0h97kwvyjzN2z3AfWdz+5
	QVHC1aJT1mjHVf4GFCXzRvFt4afDfjrmpvRXulHLg5LgEYvvLE9+cdrp4/tWh5cBrVQ0a4ZL84h
	a0v63R6UvJto94uJwJgWjikCPTu2XFRP6Ta5eqFsOsJ2FL4HqXfDT7G9aWDxG5Cg6xoWeBknTdH
	/8JOiOXac4q3jzLX+EHf7zpyxZXp3SD/Fibd/ehh/5Ul9P2F3y+pk2os05upZqNw==
X-Google-Smtp-Source: AGHT+IGfrkkE0hYmjK0ILmh3K/kZejxlXODxyO34FTc9ytt1XAcCPbGCLVKjTQvst9SPM2SDCxwEXQ==
X-Received: by 2002:a05:7301:22a6:b0:2a4:630b:c789 with SMTP id 5a478bee46e88-2b17d32138emr2505418eec.37.1767830359322;
        Wed, 07 Jan 2026 15:59:19 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d60b1sm7959708eec.31.2026.01.07.15.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 15:59:18 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	zbowling@gmail.com
Subject: Hi Sean,
Date: Wed,  7 Jan 2026 15:56:30 -0800
Message-ID: <20260107235912.105028-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a backport of the mutex protection fixes from the MT7925 driver to the
older MT7921 chipset. The MT7921 driver has the same mutex protection bugs
because MT7925 was forked from MT7921 and inherited these issues.

I don't have this chipset yet but I ordered it but someone else tested
this patch and solves a crash they had.

This patch addresses the same root cause as patches 2, 3, and 16 in my MT7925
patch series (v3 00/17) - missing mutex protection around interface iteration
when callbacks invoke MCU functions.

The key fix here is moving the mutex protection inside `mt7921_roc_abort_sync()`
rather than at call sites, to avoid nested mutex acquisition deadlocks in
suspend paths. This matches the corrected approach used in the MT7925 patches.

I hope you can find time to review the other 17 patches for the newer MT7925
chipset.

Thanks,
Zac

From 98175b0fa30d17f3afa3ca393cf6422e8587e033 Mon Sep 17 00:00:00 2001
From: Zac Bowling <zbowling@gmail.com>
Date: Wed, 31 Dec 2025 21:29:32 -0800
Subject: [PATCH] wifi: mt76: mt7921: fix missing mutex protection in
 multiple paths

The MT7921 driver has the same mutex protection bugs as MT7925 - they were
inherited when MT7925 was forked from MT7921. Several code paths iterate
over active interfaces and call MCU functions without proper mutex protection.

Add mutex protection in the following locations:

1. mt7921_set_runtime_pm() in main.c:
   Called when runtime PM settings change. The callback
   mt7921_pm_interface_iter() calls MCU functions that require
   the device mutex to be held.

2. mt7921_regd_set_6ghz_power_type() in main.c:
   Called during VIF add/remove for 6GHz power type determination.
   Uses ieee80211_iterate_active_interfaces() without mutex.

3. mt7921_mac_reset_work() in mac.c:
   After firmware recovery, iterates interfaces to reconnect them.
   The mt7921_vif_connect_iter() callback calls MCU functions.

4. mt7921_roc_abort_sync() in main.c:
   The function iterates interfaces and calls MCU functions via
   mt7921_roc_iter() callback. The mutex must be held during
   the iteration, not at call sites, to avoid nested mutex
   acquisition deadlocks in suspend paths.

These bugs can cause system hangs during:
- Power management state transitions
- WiFi reset/recovery
- Suspend/resume cycles
- 6GHz regulatory power type changes

The fix follows the same pattern used in the MT7925 patches, with
the mutex protection moved inside mt7921_roc_abort_sync() to avoid
deadlocks when called from suspend paths that already hold the mutex.

Note: Suspend paths (pci.c, sdio.c) that currently wrap mt7921_roc_abort_sync()
with mutex should be updated to remove the outer mutex to avoid deadlock,
since mt7921_roc_abort_sync() now handles mutex internally.

Signed-off-by: Zac Bowling <zbowling@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 6 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 03b4960db73f..f5c882e45bbe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -693,9 +693,11 @@ void mt7921_mac_reset_work(struct work_struct *work)
 	clear_bit(MT76_RESET, &dev->mphy.state);
 	pm->suspended = false;
 	ieee80211_wake_queues(hw);
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_vif_connect_iter, NULL);
+	mt792x_mutex_release(dev);
 	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 5fae9a6e273c..05793a786644 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -619,9 +619,11 @@ void mt7921_set_runtime_pm(struct mt792x_dev *dev)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	pm->enable = pm->enable_user && !monitor;
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_pm_interface_iter, dev);
+	mt792x_mutex_release(dev);
 	pm->ds_enable = pm->ds_enable_user && !monitor;
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 }
@@ -765,9 +767,11 @@ mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif, bool is_add)
 	struct mt792x_dev *dev = phy->dev;
 	u32 valid_vif_num = 0;
 
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_calc_vif_num, &valid_vif_num);
+	mt792x_mutex_release(dev);
 
 	if (valid_vif_num > 1) {
 		phy->power_type = MT_AP_DEFAULT;
@@ -370,9 +370,11 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
 	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
-	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state)) {
+		mt792x_mutex_acquire(dev);
 		ieee80211_iterate_interfaces(mt76_hw(dev),
 					     IEEE80211_IFACE_ITER_RESUME_ALL,
 					     mt7921_roc_iter, (void *)phy);
+		mt792x_mutex_release(dev);
+	}
 }
 EXPORT_SYMBOL_GPL(mt7921_roc_abort_sync);
 
-- 
2.51.0



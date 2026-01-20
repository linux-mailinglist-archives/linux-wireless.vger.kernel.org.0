Return-Path: <linux-wireless+bounces-30996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD4D3BF4C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F29A4F5FDF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270937B3F3;
	Tue, 20 Jan 2026 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQQWr79p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9A36D518
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890544; cv=none; b=Z/n+XkGzgfSwyy8nxSZJaiMqI5mgPRJoPl3r9AZ6URYPbLC1hxp7BlUT6Q1ocS5flsTZgGUn9GeppS9VAvet6SfmtUpF8jabZNG5UDdX+DLAnwevT3TJqCeEZ3thch0a2AapTmr8Yt5z3Zl0wRNMk30eU75D+vpw0l+bZI8d6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890544; c=relaxed/simple;
	bh=opbV4IdcTAjTugROH0USOiae0jYpBQAjBUnIclDTNyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSPyoX4XDqICvVDDOVZWkbNb1bp2VADwgy5ngu6Ueiqz82i77778YoQc70mz47FGzlI8n0lr6BGTdL3X4Rb82KKGOn8t9R2dLtjnE7SOyE0Y8DHD5CDSnbVoPU7PNaGROuezF78px2PF1NDijJLC2sh1rmRGpSmZVgpPxfbLT8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQQWr79p; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5157009eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890542; x=1769495342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLLa5fZdpzWHQDj1zzbC4zgrpjcPTG+wEA6kFtMuqxE=;
        b=PQQWr79pBmxcy1Qz6W84HEYSMmMT0+IUwcyFKyjmqUdbsCer+DedcO5Je/CPUlyuGV
         9PwWpL++JYXHFsevjlYWMC7QK5xjwlXdnIhOiLqk0yie4bC/BthBnBVe3kR3DvW54FTP
         aDyGgL2sJgo/mdcJ9/uuGTJA0ruccCQyWyDDQK8sGlXoPKYdzL9Egk2by2PlOEMLnpwd
         dnsQUOqW5RS2J0Mo3rwa9DhdbBTMDROmyUFgtRKxcf0BzLrFjtoC4e3HUy+cDLpBV09c
         BtdpCDe0ekzCdWlsMpDVv6dBdMLeP9bxmoPX6YPxepgPk9pVch5JOiiYPUdiywR4JSC7
         OlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890542; x=1769495342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLLa5fZdpzWHQDj1zzbC4zgrpjcPTG+wEA6kFtMuqxE=;
        b=OIqLmA+Jt7dIHiPdiMf05iJmz1SCnlfNWuZ8SNJaIFVFPIAiW7RMt0XlE9FLuDo/YB
         7BuJByMkzC7haqL9AvHiSGIzBqadF0oaOfjuW2YCqKgeML0RHd6zddlfCGxvCJW3LswQ
         2lKRSGn8wBsE4dscvjBP2KquhR150kpxDSA4od4q/ibHOwq19GPDE3IwePh5FYZVNklg
         kbRSjQEQ6Sj2Ivm5FdoDTv5qI15wt5CDKchP17tzSPcIxlCl8St51saG7uCqxaNVzW7j
         LSUG7pD6OC3dfLUkdOEo4yq4uIVqi/Qer8ZiuWdU54J4jE8AGFPIav3Q7bJB5EW4VUPX
         lQOw==
X-Forwarded-Encrypted: i=1; AJvYcCUDsLsQaQcqBhFdGUHxzbMZFAeHLm5hoOOsFFrGo8hQWBd4KIQZHeys1hA5Y/uBl3G2arviAGFDdpmOgNXscg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRssUBNbzMQ8HRcZKVLtJAR68uNMXNtpXRetdw44QYJsodfJmY
	VmvbgGByGQO/Phgtw3e0iHAzjm9QDJbvDCvZHI30pLwl4sGHHEUhsgL5
X-Gm-Gg: AZuq6aIHr6XzJUNJb3XeHTcu0XPQe52lAR6iSwDLWL5Qv625hP+cO2fOpdSIwnq/T7/
	JDsgaaDn16FyZuo7hPC7jCjWYau36av6kv2cUR2yrGstrJsMvvLjnbWYlXZn612teeN9Qu0vmft
	oKih3on3U97Ku+3sKoc/Iu3NQj3sq6gutrIW+Up1Xd7y0Kj5/Nt5SHA4DDfe8DB9/RCOuUgLtVR
	z6rPia7wgjEe9y+nlTWwZnQIpC/6EFZ0Uv/fvbbG38X7xgIcufshxGJ8gsYgLA1hN57npTJpxqG
	8mE38+J7wReJdjk2W1KEMHuA6087uZ56tdThhoFwHAghr3azVl+vs22dXIA59lf6y+amu/S59oa
	v4wPStKJk9eF25215WKg7vtKaY+KnGy1syF4aW4OJ2mLXOwQP92Lo7QhXzUh8xQuH/wUw4d1EA1
	9Oqvk6yVYc+NS+t0C7tEcEWPdkOftI1uGUMa2TWDavcPKzib2j15FtARlfhNSk
X-Received: by 2002:a05:7301:5f85:b0:2ae:5af4:7d65 with SMTP id 5a478bee46e88-2b6b410b608mr10898547eec.31.1768890542196;
        Mon, 19 Jan 2026 22:29:02 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:01 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
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
	stable@vger.kernel.org,
	linux@frame.work,
	zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH 04/11] wifi: mt76: mt7921: fix deadlock in sta removal and suspend ROC abort
Date: Mon, 19 Jan 2026 22:28:47 -0800
Message-ID: <20260120062854.126501-5-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120062854.126501-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Fix deadlock scenarios in mt7921 ROC (Remain On Channel) abort paths:

1. Suspend path deadlock (pci.c, sdio.c):
   - Previous fix (b74d48c46f) added mutex around mt7921_roc_abort_sync
   - But roc_work acquires mutex, so cancel_work_sync can deadlock
   - Fix: Remove mutex wrappers since mt7921_roc_abort_sync doesn't
     actually need them (it only calls timer_delete_sync, cancel_work_sync,
     and ieee80211_iterate_interfaces which handles its own locking)

2. sta_remove path deadlock:
   - mt7921_mac_sta_remove is called from mt76_sta_remove which holds mutex
   - Calling mt7921_roc_abort_sync → cancel_work_sync can deadlock if
     roc_work is waiting for the mutex
   - Fix: Add mt7921_roc_abort_async (matching mt7925 pattern) that sets
     abort flag and schedules work instead of blocking
   - Add abort flag checking in mt7921_roc_work to handle async abort

The fix mirrors the mt7925 implementation which already handles these
scenarios correctly.

Fixes: b74d48c46f ("wifi: mt76: mt7921: fix mutex handling in multiple paths")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 29 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 --
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  2 --
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 9315dbdf8880..07d1d0d497f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -367,17 +367,24 @@ static void mt7921_roc_iter(void *priv, u8 *mac,
 	mt7921_mcu_abort_roc(phy, mvif, phy->roc_token_id);
 }
 
+/* Async ROC abort - safe to call while holding mutex.
+ * Sets abort flag and schedules roc_work for cleanup.
+ */
+static void mt7921_roc_abort_async(struct mt792x_dev *dev)
+{
+	struct mt792x_phy *phy = &dev->phy;
+
+	set_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
+	timer_delete(&phy->roc_timer);
+	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
+}
+
 void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 {
 	struct mt792x_phy *phy = &dev->phy;
 
 	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
-	/* Note: caller must hold mutex if ieee80211_iterate_interfaces is
-	 * needed for ROC cleanup. Some call sites (like mt7921_mac_sta_remove)
-	 * already hold the mutex via mt76_sta_remove(). For suspend paths,
-	 * the mutex should be acquired before calling this function.
-	 */
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		ieee80211_iterate_interfaces(mt76_hw(dev),
 					     IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -392,6 +399,15 @@ void mt7921_roc_work(struct work_struct *work)
 	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						roc_work);
 
+	/* Check abort flag before acquiring mutex to prevent deadlock.
+	 * Only send expired callback if ROC was actually active.
+	 */
+	if (test_and_clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state)) {
+		if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
+			ieee80211_remain_on_channel_expired(phy->mt76->hw);
+		return;
+	}
+
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return;
 
@@ -887,7 +903,8 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
-	mt7921_roc_abort_sync(dev);
+	/* Async abort - caller already holds mutex */
+	mt7921_roc_abort_async(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 9f76b334b93d..ec9686183251 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -426,9 +426,7 @@ static int mt7921_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
-	mt792x_mutex_acquire(dev);
 	mt7921_roc_abort_sync(dev);
-	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 92ea2811816f..3421e53dc948 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -219,9 +219,7 @@ static int mt7921s_suspend(struct device *__dev)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
-	mt792x_mutex_acquire(dev);
 	mt7921_roc_abort_sync(dev);
-	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
-- 
2.52.0



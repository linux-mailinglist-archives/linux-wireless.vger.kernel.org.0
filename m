Return-Path: <linux-wireless+bounces-30263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F19FCECDA3
	for <lists+linux-wireless@lfdr.de>; Thu, 01 Jan 2026 07:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74C33047676
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jan 2026 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C20222584;
	Thu,  1 Jan 2026 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtxOvd6p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98021FF2A
	for <linux-wireless@vger.kernel.org>; Thu,  1 Jan 2026 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767248739; cv=none; b=NIHddcU+Z49BjtIS1PRFFBhF7yyIa/5gxBGtN5PVBkZkCtMgZzNZS7P6JSf54vDuDP63okOI9QOlZv1aSmK8jm3GYhH7EoXofNNfcLLTmZRLI9GNYHd7+nYJi2JhhHB7q8AS+1/C2jvEP6o9Fb9SDQyGbaS/l+hkNZhC4c+H7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767248739; c=relaxed/simple;
	bh=tv3bK65QWcl41s5TVoukR//z4Y8ewL18OId+NapDtKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6alLAqoWA5S0klZ6gwzNUITusHdLkMldydcxFlwbGhpslv/x7vm55OO74g9OwrxYJEiVDEJj/imoqULotJRo3HrP9hjTUIBkvdoYZ/HAqU4Fhzgwfy9e9Stv5CQD1HxTKCoEjot7kVzFCmRJ8pEBW01g5OyzH2qzPL9HTgAFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtxOvd6p; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc0d7255434so6683258a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 22:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767248737; x=1767853537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyMHOUL6PX8gGCpJKqxA4osFrTSq3zeh+kkY++bT1Ho=;
        b=PtxOvd6pMd8TCfglB0ApGtYAEzmf1YUj9tz6ky3KQG9d3mFyG9YZC18qFHbcURfKZR
         txF+LItYFIsuKhJnDJ5u2fWlAo2g/3LrqsOsqD6a/G5tbwzy82vJ3ATctQkfnytqOrK+
         lvbNQ3MhG9sso3Fkxekbzc/fpB4J4BagCc+mIqSUvC/uD9ZE99FXOgbHlxlZHfhDjz3L
         GtGFvkgrfh1jmNraJ0iQ7s8tTVY88AL4+1+/vYY8qVMAdAgwIioY5SBWaFSrL5UEQRR7
         T84BYumfywSLSfCr/DsSGc6GeMM5waGSyT6eimn+gGjklGUtY/aXvo2tBjAcbT9GOikm
         Wdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767248737; x=1767853537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KyMHOUL6PX8gGCpJKqxA4osFrTSq3zeh+kkY++bT1Ho=;
        b=pZpw7Ykj7W3LXZ0XESyWNYJ2WjWFbdfsbaVp6sBs1/J9wm9ftfAieFM3rlPmmv+ix9
         CCmoCK/tkcrO89R+PdGLwqeWiihS+K8TavzZZHfhu4b8BL4z+TQcVjJkVb73b2YcCGFn
         RqWUYa7qgblWfMhsGDnO6K72qIcjwxp8upH1m+ot4RndUf4FNK5JGgz+BhFYlF2RQgvN
         gH8zSoJis96Z7ois6hfulrASPNtzDFZGan9xF3zxD9MyEDe42XZkQl4uJRgIBFv+/qaU
         cf0y9z/yu+lVoD+tZRSqyI6iTHXSwoYlZlPl6wheInku7BWf1JJTGQ00AhgET63pYpLU
         SQSg==
X-Gm-Message-State: AOJu0YwHu5sQBjU8wqUQQrIoSGzG1XGWTON3ZYgfz31REGO0tcBf4yV+
	wTnJDxVAcFiF6gFHpRxnLa2+wuTPSIFi97W8YtV5Cj74Hdwfn5il3HWNH5N4VB7V
X-Gm-Gg: AY/fxX7i3csekdaPo45VNHysKl62K36qya8M5RP9yqw0OGg1Z+9EFW8ySbcyFHizTsG
	cxpXkkB9oNsRNlPwwNOiAOtLpcudrk53wUrxTK3FNXUz49ROJYuESxTwQjy2AqsnPBkC9CdLcJ1
	5CoSRaWFwxPR2WWqBN6bAS6DCQhRNNsi2ar0p55ICaokQ0Ji0yRKlgVk4NrbmPCGt4csUJybThL
	XwNholEj0GthY5js3R2oANr5b9G+RFh2Oatkd9bGIbVIhHVTHebrPG/OpmvCIAHnh4ar9X6bhMD
	nNODwGU2tyx9Zz9NMXxqlvnVCML9NYXNYYf+giy9v+SF61UGvkZcxdu9p99wjuEFLx19CMcIehh
	CtuWFSananPxiyE5Y8/7/+Ixa9y1u8/cOVWZiLVa22tljc++70nZ6Bk9Lmq2Roxkt3/T1qCi+76
	QSEYzYBbE0AozHEShClp1nyuaiiTEFNyTNCKQaBY7Nst2j9wTYu6TYfXLEMqiIIA==
X-Google-Smtp-Source: AGHT+IFruK2Ksd+NMZVj9cqCTMex7QiD3OzwH2E6Y1/xPBTS9H6EF+Ig7Y/w2ekYn4a7Be44BpO66Q==
X-Received: by 2002:a05:7300:3e95:b0:2a4:3593:4668 with SMTP id 5a478bee46e88-2b05ebdd53bmr24110747eec.4.1767248737183;
        Wed, 31 Dec 2025 22:25:37 -0800 (PST)
Received: from zubuntu.home.zacbowling.com ([2001:5a8:60d:bc9:9ebf:dff:fe00:f8f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fcfc1b7sm85698912eec.0.2025.12.31.22.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 22:25:36 -0800 (PST)
From: Zac Bowling <zbowling@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvalo@kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	ryder.lee@mediatek.com
Subject: [PATCH] wifi: mt76: mt7921: fix missing mutex protection in multiple paths
Date: Wed, 31 Dec 2025 22:25:35 -0800
Message-ID: <20260101062535.186356-1-zbowling@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
References: <CAOFcj8Sad3pLohFfRdj5jzK3Zs3FAjFVBuzH=80i_m1YqSbpfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

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

4. PCI/SDIO suspend paths (pci.c, sdio.c):
   The mt7921_roc_abort_sync() call iterates interfaces without
   mutex protection.

These bugs can cause system hangs during:
- Power management state transitions
- WiFi reset/recovery
- Suspend/resume cycles
- 6GHz regulatory power type changes

The fix follows the same pattern used in the MT7925 patches.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 2 ++
 4 files changed, 10 insertions(+)

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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ec9686183251..9f76b334b93d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -426,7 +426,9 @@ static int mt7921_pci_suspend(struct device *device)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt792x_mutex_acquire(dev);
 	mt7921_roc_abort_sync(dev);
+	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 3421e53dc948..92ea2811816f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -219,7 +219,9 @@ static int mt7921s_suspend(struct device *__dev)
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 
+	mt792x_mutex_acquire(dev);
 	mt7921_roc_abort_sync(dev);
+	mt792x_mutex_release(dev);
 
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
-- 
2.51.0



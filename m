Return-Path: <linux-wireless+bounces-30877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D751CD29898
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBAB23093053
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F03176E1;
	Fri, 16 Jan 2026 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnBZHSan"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308B3254BA
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525556; cv=none; b=rrcAc9z4FGqmls9VIbBkqWD/DWoXpCCqFzKHYWsAOdfTQTC3D/2NOLnBB00xVbkG1Ym47k9fkgwnDzQfKKXIVmaNgdNi0fnECoUEkLUO/8a7IcATKVxpM73BW9jIdXscVa+ipz73Lc7pvD5h/3rXuc5+37WSZXON7o2eeEvNrO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525556; c=relaxed/simple;
	bh=xQRro3eUc7+kAN+ySF7Y8lq417EJb125DwuP6Y/XROE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uc0X90qaqsjuOhSpMTNy6KY3JbAZtB9aRieBK2CoKOeek5DJzWDVHfDE4bYO9cB3CKYSZ1X1iZXCXJxIfTDuEKAqoSyNT2oCpT2oUzGVnqrlcxna66Mf+j3p54+dRxC7rxg0oPxiQE6wzs7SLs+KN48ZambyO9NjMOT0MWo2MTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnBZHSan; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b04a410f42so1852885eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525551; x=1769130351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPmr/YvMhh6PyVTDX5uGjbBQK9qU8oKB4kDMk8rc0co=;
        b=NnBZHSanZ+A4AEA98UD7U2186AoVx78VFx7jl/fs7poER/HTLIhwX/AloQzUYXs0/H
         Ra90f4e3xN0R+6VAXEYlTGBdVSzpiOsx8yxWDlXthSjM8Mz96c1RQqlVxX5QvvhYG+57
         95sSSuKKRqTYWGc2xbU5oISHShmQ9ZL1wH1fiW5KQ1dKtC/xQGwLPt1o0HNLjAxXuxsV
         vebOgAptrds6aPB7HZwClH2UOMKW3LRyazBkGa4KZgUdf8txLn/N31seeQZEkMFBO3JL
         AzOwh3Ej9iEDYQCzXSmhcMYRkk/UEDVJ5Atk5df4mvaeRBfmCRpAeszdqN4RMFB/sUh3
         vgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525551; x=1769130351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPmr/YvMhh6PyVTDX5uGjbBQK9qU8oKB4kDMk8rc0co=;
        b=c19kMjf/2VD1RL79yN5QF3qg12tZ0wpmNp/AlcHTQl3T5V0AZHXbXW2hBNLw0yWV1m
         tDorxAU1Ze0LzL+RD1zG94C5t45qORcgEy7PyrEimrnyeuzzRctQp3C/LAVP4M3n6iGr
         FhIt5F4bwBbMaxe6qXbOvceT/P9Vx4m5zsMg83fof487cS2lrq5afVq9kYEwN3aBi1oV
         VDz0MGC1r8fqID8IawqasQy9vmS+DMjBTN51ja4TAFZF1Wav1sb1Fnup8yQtiu3sBrh2
         BgKIJ1U25k1N9JsrAtgIC0dnifE7SgqA8M2T3p3GeLIdaev2rHLlKkmEvor+jzw+29dF
         EOsA==
X-Forwarded-Encrypted: i=1; AJvYcCX4kGGEKD0A2aUrtGMI6qksdiN7DYmm1ltfbQ07P7uCSrcPY8+gn4IDBEILp6pcmAyyD6yMAEEx9wDX8HRWtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKoQ7j9FUdZZ5iRPeUIH+8RBgYAsXVAl8nBHe713wrY1a8QIBA
	X8eJi8+49ePuXi4v5688EL3v7z79dKyl2OmZapBTW1y2Hd5TZa0WeU03
X-Gm-Gg: AY/fxX4BrvSTLZ7Yf/UD9VBkMc/f+FVHvrQkzn8fOhqE1ecnclMMWr1syjfyGsciGxE
	FCylT/ABLtsMOjBNBQNYj4jbs6DWNDxI8n4108e7XbiAnWJ6gdWPV2EqxjpMnkX4UwTOjJNe2nt
	VsP9jvWhy8oN/twnuERf7F3oFK4sqCZutzEK/PdlNS84LKLi6zxpobr7Lf+Fz8ZDaG7/B7gNzAK
	E9IpoFxn3ynKukx6RgV+7HlM0a5oOThTc95NFoiyL/FjrDz+duae3oxQtCWnyWB5+sK3KbeHd8S
	XSSJc4SFtkS31Ld4+puOecpZl/aSZ9PAwmY2688nGQ324TQaOFH9JPnaBzlovTAGNLSUSv9BMAw
	WvqRD9vVyiWyIZVaj3Sqp5+HAFf7xWRAjIbqAxstsiTxsdpWpPxriXb1ccfj1HBQShUTHU5sQk2
	V8fAq/URJ9Iams97qgUJZSA3Z7m/ki83eaXYEKVB94e/a0GaqogHpWehsGukBM/A==
X-Received: by 2002:a05:7301:7c0b:b0:2ae:56d7:b02 with SMTP id 5a478bee46e88-2b6b46c6449mr1393747eec.9.1768525551316;
        Thu, 15 Jan 2026 17:05:51 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:50 -0800 (PST)
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
	linux@frame.work,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	Zac <zac@zacbowling.com>
Subject: [PATCH v4 19/21] wifi: mt76: mt7921: fix mutex deadlocks in multiple paths
Date: Thu, 15 Jan 2026 17:05:17 -0800
Message-ID: <20260116010519.37001-20-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116010519.37001-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260116010519.37001-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix mutex handling to prevent deadlocks:

- mt7921_roc_abort_sync(): Remove internal mutex acquire/release since
  this function is called from contexts that already hold the mutex
  (mt7921_mac_sta_remove via mt76_sta_remove). Add mutex at caller sites
  that don't hold it (pci.c and sdio.c suspend paths).

- mt7921_set_runtime_pm(): Remove internal mutex acquire/release since
  the only caller (debugfs) already holds the mutex.

The previous patches incorrectly added mutex acquire inside functions
that can be called from contexts where the mutex is already held,
causing deadlocks.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 13 +++++++------
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c |  2 ++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 8fc3770d1b..9315dbdf88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -373,13 +373,15 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 
 	timer_delete_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
-	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state)) {
-		mt792x_mutex_acquire(dev);
+	/* Note: caller must hold mutex if ieee80211_iterate_interfaces is
+	 * needed for ROC cleanup. Some call sites (like mt7921_mac_sta_remove)
+	 * already hold the mutex via mt76_sta_remove(). For suspend paths,
+	 * the mutex should be acquired before calling this function.
+	 */
+	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		ieee80211_iterate_interfaces(mt76_hw(dev),
 					     IEEE80211_IFACE_ITER_RESUME_ALL,
 					     mt7921_roc_iter, (void *)phy);
-		mt792x_mutex_release(dev);
-	}
 }
 EXPORT_SYMBOL_GPL(mt7921_roc_abort_sync);
 
@@ -622,11 +624,10 @@ void mt7921_set_runtime_pm(struct mt792x_dev *dev)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	pm->enable = pm->enable_user && !monitor;
-	mt792x_mutex_acquire(dev);
+	/* Note: caller (debugfs) must hold mutex before calling this function */
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_pm_interface_iter, dev);
-	mt792x_mutex_release(dev);
 	pm->ds_enable = pm->ds_enable_user && !monitor;
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ec96861832..9f76b334b9 100644
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
index 3421e53dc9..92ea281181 100644
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
2.52.0



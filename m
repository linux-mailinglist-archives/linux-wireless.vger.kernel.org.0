Return-Path: <linux-wireless+bounces-30998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E880DD3BF3C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 102013866D0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C71387596;
	Tue, 20 Jan 2026 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef7RKXMl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CCF3806C4
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890549; cv=none; b=iw4TI2L1S1j1oPUBQxZfRjl4CWnfAi0BQ1l3HQ+d6iR1HWK13kcRhxyDeziWaT6F3wZR2nmnT7kl/0SubWJA4bE455Y5O5OnWUD+NRN2Cuu6dpHoXAE67WDQKiKpU59OTrbaGVkFIoFcbgGoUUY45LlAmciGEFfoyufd3ES6d+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890549; c=relaxed/simple;
	bh=IkGS2pbb9DGLGXEWPJhYUmq0EJShmdW9s055oJTD1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pL8AbD3WN2d+kp3hcorl9zrKU3sM2vdD7AqS0usTQ7prlZ2aTdBPGeT05DfDv4r/2wffO8ApyiM2cPdTnU29SafMsUW68xjsL2qC0ya5W+W5Xb3NtZkZ5bNYxPx7V+XC9kAYe+8GZF0xHm27Wx5aAO5lhODG8hIihaRR1eGOaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef7RKXMl; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ae38f81be1so5614216eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890545; x=1769495345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gq8BwtBE3udkhb8xxJaDge5ayHDcllBWREYlF8lWPK8=;
        b=Ef7RKXMlRU6Wl/SKant8GmP849OnO+ckbTBrRC/vbhy+QBuGwkcVg2KqHc1OlGIvKb
         43KGyqAxELOBcjPrlPHLoZwBjI1t8wDXj1zTHVf8w0CcngZ2sVTKCe5OheDXFZ4O0d/G
         Dj2nMdtQLIzStvO1cGLqxmZCGBfMWl2tcOop/OHmDj4DhvqnWsVXQt6eeP0nSkHu9Hwu
         3kuJVbLdqCyKG9sdPeu0NrIxn4XO37qXIqZr/v/yx3CTw5+V0QxCMpUQb4ecLC14b4WE
         B+Ev7W4quQ/TC8dLEprOi/No1f7icosDUtaFP3gR4j9EDpsjFUybAer8i8dD+5H9nd2l
         Bobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890545; x=1769495345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gq8BwtBE3udkhb8xxJaDge5ayHDcllBWREYlF8lWPK8=;
        b=atZp7GV5KMvK2y/KSEPKHX8OfUsYYiyAYbpGFZpxib/oalPVy+Qvoc3dAxTyrme/cW
         hGK6HJXDJCLlFjNXKf2+fyYw9gdgIG8oZ1zReFS//KNF4MqEYDQzWzJc2UnaYscLk8mS
         g+uLP02+LD0LyfS65dow7ws09kjKumgyykpakt3MWULObYS1m8U4wAeyzTgLEf3I8Awu
         pApS/9DtFEl8UOQpyMVmMn6gj2ukaxjqSAeMIesfY3YG8oQvkVp15quxFvmF6TKTf0XW
         6aCugRJjIF8zLUk9g+Jl+m5Rm/D8Tm2/qM1ZaUWNpfj01zBBBQD5E/oOTYqPM05ZWElk
         VnCg==
X-Forwarded-Encrypted: i=1; AJvYcCX7gH4SOxJfVR0x2YCTIm7F3ffd6hn4sg8jetZLTaSFGjx4vNd0fwJhYNLieOQqGMmXa0q4RCqhhyY1cPNqqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpXaRkrFcILQ8rmROjrPuNp/i09B9xpmEKW73Gpmr6wbYqEdk
	xzGV+UHX+B99T8mt6Ye3Np5BxkF5u7R1iECfWkMSH+CmoC/ZdtTIRuo9
X-Gm-Gg: AZuq6aL0aK+LExU6tCk2Y4u5+81TXK4UvLO8EASrST5+PtFDey0nbZgcUK7GeraU1Mq
	WBmlzBMl+j2rtqUohNKE2myDb37Um74hfZiYjUfDiA4JcHmZlRgrh80yuruuT3byasQOeyryD5H
	ejS9/y3rqUttp5vsfbTnUaK98rMNlzQHi3c93nrYJ2MVWABmgozyrE64VSNq5WyMCzoWbQgbxGl
	CQucDx1WHJ3O7uhC/tiDilwvFliOzaKqplDm4sV2cMzf5VcN6eEAmVpN9Zso/YfpCn6H6tKyIuu
	oa+aCxsTQ0BkM1NUcz9KZjdefpTp4M+E8WCAB3q/C7bAXikFvP5QbQ43H73bIOaAP1TJzsW5Q9S
	jTOWad5HRcKSMBG8JgD5rGrOnveGA80zgF75gRctyV0jcWlKZ1rOCi078A0Ek4ggTEBY/HUBejo
	AMo807yXlIVXudyrkVFasHza9T+Gi+9Cj3uGLeJ8q3OiM/ejdjVO/2/djHnkXR
X-Received: by 2002:a05:7301:290a:b0:2ae:60fd:6f18 with SMTP id 5a478bee46e88-2b6b4e8a496mr11903860eec.22.1768890544990;
        Mon, 19 Jan 2026 22:29:04 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:04 -0800 (PST)
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
Subject: [PATCH 06/11] wifi: mt76: mt7925: add mutex protection in critical paths
Date: Mon, 19 Jan 2026 22:28:49 -0800
Message-ID: <20260120062854.126501-7-zac@zacbowling.com>
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
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Add proper mutex protection for mt7925 driver operations that access
hardware state without proper synchronization. This fixes race conditions
that can cause system instability during power management and recovery.

Fixes added:

1. mac.c: mt7925_mac_reset_work()
   - Wrap ieee80211_iterate_active_interfaces() with mt792x_mutex
   - The vif_connect_iter callback accesses hardware state

2. mac.c: mt7925_mac_sta_assoc()
   - Wrap vif_connect_iter call with mutex protection
   - Called during station association which races with PM

3. main.c: mt7925_set_runtime_pm()
   - Add mutex protection around mt76_connac_pm_wake/sleep
   - Runtime PM can race with other operations

4. main.c: mt7925_set_mlo_pm()
   - Add mutex protection around MLO PM configuration
   - Prevents races during MLO link setup/teardown

5. pci.c: mt7925_pci_resume()
   - Add mutex protection around ieee80211_iterate_active_interfaces
   - The vif iteration accesses hardware state that needs synchronization

These protections ensure consistent hardware state access during power
management transitions and recovery operations.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 4 ++++
 3 files changed, 10 insertions(+), 2 deletions(-)

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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 15d1b1b8d9f8..80ca5181150b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -755,9 +755,11 @@ void mt7925_set_runtime_pm(struct mt792x_dev *dev)
 	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
 	pm->enable = pm->enable_user && !monitor;
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_pm_interface_iter, dev);
+	mt792x_mutex_release(dev);
 	pm->ds_enable = pm->ds_enable_user && !monitor;
 	mt7925_mcu_set_deep_sleep(dev, pm->ds_enable);
 }
@@ -1331,14 +1333,12 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (mvif->mlo_pm_state != MT792x_MLO_CHANGED_PS)
 		return;
 
-	mt792x_mutex_acquire(dev);
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
 		if (!bss_conf)
 			continue;
 		mt7925_mcu_uni_bss_ps(dev, bss_conf);
 	}
-	mt792x_mutex_release(dev);
 }
 
 void mt7925_mlo_pm_work(struct work_struct *work)
@@ -1347,9 +1347,11 @@ void mt7925_mlo_pm_work(struct work_struct *work)
 					      mlo_pm_work.work);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
+	mt792x_mutex_acquire(dev);
 	ieee80211_iterate_active_interfaces(hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_mlo_pm_iter, dev);
+	mt792x_mutex_release(dev);
 }
 
 void mt7925_scan_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c01d..3a9e32a1759d 100644
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
@@ -582,10 +584,12 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
 	}
 
 	/* restore previous ds setting */
+	mt792x_mutex_acquire(dev);
 	if (!pm->ds_enable)
 		mt7925_mcu_set_deep_sleep(dev, false);
 
 	mt7925_mcu_regd_update(dev, mdev->alpha2, dev->country_ie_env);
+	mt792x_mutex_release(dev);
 failed:
 	pm->suspended = false;
 
-- 
2.52.0



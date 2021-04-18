Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C730C3636BC
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhDRQq1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhDRQq0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E62261359;
        Sun, 18 Apr 2021 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764358;
        bh=w2CK4bFzudJhD34L7P7Ztg+tIF929ttsnYfncIacNAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgAzdmfWiaZKc7husPbqz/iux7Oiuc98YNawIPqhBCss7QVkhPGKK1R0uPBuvcbHf
         fjM+Y4FTg+OuCDt94f74aWW34y3RqfeCwMpwkT5gIkI9DEDyIcYb4UvmMKWpTw7gk4
         Ia3C8HlSP6QYHqavkQr88oXH0oH+7kbO4QgSLXu47a4w9VxIgQh+pqNJPjem60fSdw
         BZQLOwEjqiDI3Z44r9vf5KGg1lrLyNmHY4xJ+b7qWJtOplYcRqZ7CXxNgB6bzv5Pay
         2Y5wSL0Ml1JStSUZoE7V+CavU98rOSE0bDnopcknoeKE3MNmNePWXB0xvHr75iWiem
         cpHcbaWqVT5cA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 02/19] mt76: mt7663: fix a race between mt7615_mcu_drv_pmctrl and mt7615_mcu_fw_pmctrl
Date:   Sun, 18 Apr 2021 18:45:28 +0200
Message-Id: <732fb9447efb541029536b7d48f0cdfa1c585c0a.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a mutex in order to avoid a race between mt7615_mcu_lp_drv_pmctrl and
mt7615_mcu_fw_pmctrl routines since they are run two independent works

Fixes: 1f549009b5b2 ("mt76: mt7615: do not request {driver,fw}_own if already granted")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 20 +++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index d84662fb0304..5429536e8d43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -505,6 +505,7 @@ void mt7615_init_device(struct mt7615_dev *dev)
 
 	INIT_DELAYED_WORK(&dev->pm.ps_work, mt7615_pm_power_save_work);
 	INIT_WORK(&dev->pm.wake_work, mt7615_pm_wake_work);
+	mutex_init(&dev->pm.mutex);
 	init_completion(&dev->pm.wake_cmpl);
 	spin_lock_init(&dev->pm.txq_lock);
 	set_bit(MT76_STATE_PM, &dev->mphy.state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 364daef4b0be..7081bb4a28bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -323,9 +323,11 @@ static int mt7615_mcu_drv_pmctrl(struct mt7615_dev *dev)
 static int mt7615_mcu_lp_drv_pmctrl(struct mt7615_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
-	int i;
+	int i, err = 0;
+
+	mutex_lock(&dev->pm.mutex);
 
-	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
+	if (!test_bit(MT76_STATE_PM, &mphy->state))
 		goto out;
 
 	for (i = 0; i < MT7615_DRV_OWN_RETRY_COUNT; i++) {
@@ -337,14 +339,16 @@ static int mt7615_mcu_lp_drv_pmctrl(struct mt7615_dev *dev)
 
 	if (i == MT7615_DRV_OWN_RETRY_COUNT) {
 		dev_err(dev->mt76.dev, "driver own failed\n");
-		set_bit(MT76_STATE_PM, &mphy->state);
-		return -EIO;
+		err = -EIO;
+		goto out;
 	}
+	clear_bit(MT76_STATE_PM, &mphy->state);
 
 out:
 	dev->pm.last_activity = jiffies;
+	mutex_unlock(&dev->pm.mutex);
 
-	return 0;
+	return err;
 }
 
 static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
@@ -353,8 +357,10 @@ static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
 	int err = 0;
 	u32 addr;
 
+	mutex_lock(&dev->pm.mutex);
+
 	if (test_and_set_bit(MT76_STATE_PM, &mphy->state))
-		return 0;
+		goto out;
 
 	mt7622_trigger_hif_int(dev, true);
 
@@ -370,6 +376,8 @@ static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
 	}
 
 	mt7622_trigger_hif_int(dev, false);
+out:
+	mutex_unlock(&dev->pm.mutex);
 
 	return err;
 }
-- 
2.30.2


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5578E3636BB
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhDRQqZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231767AbhDRQqZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 100066135A;
        Sun, 18 Apr 2021 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764357;
        bh=0neeECDzcCKWcxVhOeuHzAhGdE3DyOzeliRy1nkHCuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzdpADoc648I9Fxe+ppKEsv1+4NctxddirBtAPs4K5uKLhj/BGG2TZSqf0QKoMos4
         d9v9KiFR3XyPX5yYZaBMaghkqLYJ9kctziDNg5TDbyJdN9zhKYVVifvl7lN1npwB3m
         Q7qtLAAnKmVkZDSVDCN0AZ0hZR0EsvTC8H3mj80Kz0545QypdNS6F4B3yxDtfHBN7w
         CStubv1E5wvo/1pqzLot7HTpxO4F8ga1TuSwDPJf/SYJn6u70uXqCah4AFNy92IXk/
         vezzcL0O0H1b4IInG7HBZ9RCm7SYa5hAewn/zGr2rkO91AJx9x9R6xgT/7bYKBuC1Q
         Nb5V2/+caRq/w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 01/19] mt76: mt7921: fix a race between mt7921_mcu_drv_pmctrl and mt7921_mcu_fw_pmctrl
Date:   Sun, 18 Apr 2021 18:45:27 +0200
Message-Id: <dee187bcde4b0410e09061e8ad786c3bd769497b.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a mutex in order to avoid a race between mt7921_mcu_drv_pmctrl and
mt7921_mcu_fw_pmctrl routines since they are run two independent works

Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 34 +++++++++++++------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index b811f3c410a1..2b31c9794e92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -54,6 +54,7 @@ struct mt76_connac_pm {
 
 	struct work_struct wake_work;
 	struct completion wake_cmpl;
+	struct mutex mutex;
 
 	struct delayed_work ps_work;
 	unsigned long last_activity;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index eab6e2dcdb96..0b8a5a7f4362 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -222,6 +222,7 @@ int mt7921_register_device(struct mt7921_dev *dev)
 
 	INIT_DELAYED_WORK(&dev->pm.ps_work, mt7921_pm_power_save_work);
 	INIT_WORK(&dev->pm.wake_work, mt7921_pm_wake_work);
+	mutex_init(&dev->pm.mutex);
 	init_completion(&dev->pm.wake_cmpl);
 	spin_lock_init(&dev->pm.txq_lock);
 	set_bit(MT76_STATE_PM, &dev->mphy.state);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 14ba856de0b6..ea00f6b6af56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1267,9 +1267,11 @@ int mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
-	int i;
+	int i, err = 0;
 
-	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
+	mutex_lock(&dev->pm.mutex);
+
+	if (!test_bit(MT76_STATE_PM, &mphy->state))
 		goto out;
 
 	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
@@ -1281,23 +1283,30 @@ int mt7921_mcu_drv_pmctrl(struct mt7921_dev *dev)
 
 	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
 		dev_err(dev->mt76.dev, "driver own failed\n");
-		mt7921_reset(&dev->mt76);
-		return -EIO;
+		err = -EIO;
+		goto out;
 	}
+	clear_bit(MT76_STATE_PM, &mphy->state);
 
 out:
 	dev->pm.last_activity = jiffies;
+	mutex_unlock(&dev->pm.mutex);
 
-	return 0;
+	if (err)
+		mt7921_reset(&dev->mt76);
+
+	return err;
 }
 
 int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
-	int i;
+	int i, err = 0;
+
+	mutex_lock(&dev->pm.mutex);
 
 	if (test_and_set_bit(MT76_STATE_PM, &mphy->state))
-		return 0;
+		goto out;
 
 	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
 		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_SET_OWN);
@@ -1308,11 +1317,16 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
 
 	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
 		dev_err(dev->mt76.dev, "firmware own failed\n");
-		mt7921_reset(&dev->mt76);
-		return -EIO;
+		clear_bit(MT76_STATE_PM, &mphy->state);
+		err = -EIO;
 	}
+out:
+	mutex_unlock(&dev->pm.mutex);
 
-	return 0;
+	if (err)
+		mt7921_reset(&dev->mt76);
+
+	return err;
 }
 
 void
-- 
2.30.2


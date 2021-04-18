Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31F33636C4
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhDRQqh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232095AbhDRQqh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4577961359;
        Sun, 18 Apr 2021 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764369;
        bh=QW/N+KulcNzOg7fnGEiWu0qI3VA43sk7aMpeDzAyo3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfB2snVLm6+LAHBQaIvRXq7unHKlIqMIgXYbZs5IHbxV6Pz3JHPliHtfeakmdzImD
         IdlieLU0AcnO47/6CWuBJZ0anzOJTAqP8bYWAQkWnvrwEH5V0VGtxW3dQUas0b1b+N
         dMcP631pBeJfh1rUhr40GZPdW6veMbZPfD7fpuuDcbyoS4+Aqm42SMhVd7KpBeaUwV
         z7K47iyo/NR4pl7Euccb6SS98uVETiguJWhvKjZgV47gg7zXT0R0LkrXEhKVCiLSZS
         GmHP5x94JkooOJRAEyWfXkCeror2IpCkrE4qYk3nAnILWUrUup6GoZga9ADBoDrPFp
         HYtIn0IcMDa8g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 10/19] mt76: connac: check wake refcount in mcu_fw_pmctrl
Date:   Sun, 18 Apr 2021 18:45:36 +0200
Message-Id: <79586a8114bf0831b78181a41fbf2994c4010da2.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to avoid synchronization races between tx and rx path, rely on
mt76_connac_skip_fw_pmctrl putting the chip in sleep mode for mt7921 and
mt7663 devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h | 12 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c  |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 5890fee98d97..45c6fb5832b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -358,7 +358,7 @@ static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
 
 	mutex_lock(&dev->pm.mutex);
 
-	if (test_and_set_bit(MT76_STATE_PM, &mphy->state))
+	if (mt76_connac_skip_fw_pmctrl(mphy, &dev->pm))
 		goto out;
 
 	mt7622_trigger_hif_int(dev, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 85846eab8d7d..116d800c9f9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -116,6 +116,18 @@ mt76_connac_pm_unref(struct mt76_connac_pm *pm)
 	spin_unlock_bh(&pm->wake.lock);
 }
 
+static inline bool
+mt76_connac_skip_fw_pmctrl(struct mt76_phy *phy, struct mt76_connac_pm *pm)
+{
+	bool ret;
+
+	spin_lock_bh(&pm->wake.lock);
+	ret = pm->wake.count || test_and_set_bit(MT76_STATE_PM, &phy->state);
+	spin_unlock_bh(&pm->wake.lock);
+
+	return ret;
+}
+
 static inline void
 mt76_connac_mutex_acquire(struct mt76_dev *dev, struct mt76_connac_pm *pm)
 	__acquires(&dev->mutex)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 44f02cbf9cc7..1204f5d324f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1304,7 +1304,7 @@ int mt7921_mcu_fw_pmctrl(struct mt7921_dev *dev)
 
 	mutex_lock(&dev->pm.mutex);
 
-	if (test_and_set_bit(MT76_STATE_PM, &mphy->state))
+	if (mt76_connac_skip_fw_pmctrl(mphy, &dev->pm))
 		goto out;
 
 	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
-- 
2.30.2


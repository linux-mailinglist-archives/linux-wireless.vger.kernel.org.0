Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6E3AC5C0
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhFRIKr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhFRIKq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:10:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A86361249;
        Fri, 18 Jun 2021 08:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624003718;
        bh=DgBcdPbRRR8zN5iiw5yCAfQFzH88KzMTBDKTGSx4Dq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIEG29Rj7xaBfLHvGGFOic32UlZllPJWO/4DrjejVjOni790Pz5EQLh/c81kYvmyk
         p+/PoQDeWfHg0BW1LVPC1LwWBAediuhbvr2eBha2x98KGTWAk6pbQIOKcvCgPM6tI6
         +zIhaDpHz01ZBoUYOdiJWYELa3bxPC8ZnIwy0z0VSCImVSbIUlGUl2VAXFGn7JKCTV
         hJxYpDA2xtXJBAECAoRa2+NkJtsCsWYSEThP4p3siW5JKF+nyvRh7Y8kXqX5s3q4nv
         7L36mdxDrSOKwk9pJrvy1MOqcTn5mOQ7RCCbyy4eTj48wMEuTUYK8NfbAU9Er4zf7/
         puld5IaTDuJqw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH v2 2/5] mt76: mt7663s: rely on pm reference counting
Date:   Fri, 18 Jun 2021 10:08:21 +0200
Message-Id: <7eea154a0d02b9d47a0fa3ac401a84385cdf32b3.1624003282.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624003282.git.lorenzo@kernel.org>
References: <cover.1624003282.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As already done for mt7921 and mt7663e, rely on pm reference counting in
drv/fw_own

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 36 +++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index d1be78b0711c..6c23c6dbf1c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -55,6 +55,7 @@ static int __mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
 {
 	struct sdio_func *func = dev->mt76.sdio.func;
 	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
 	u32 status;
 	int ret;
 
@@ -64,39 +65,44 @@ static int __mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
 
 	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
 				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(dev->mt76.dev, "Cannot get ownership from device");
-		set_bit(MT76_STATE_PM, &mphy->state);
-		sdio_release_host(func);
-
-		return ret;
-	}
+	else
+		clear_bit(MT76_STATE_PM, &mphy->state);
 
 	sdio_release_host(func);
-	dev->pm.last_activity = jiffies;
+	pm->last_activity = jiffies;
 
-	return 0;
+	return ret;
 }
 
 static int mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
+	int ret = 0;
 
-	if (test_and_clear_bit(MT76_STATE_PM, &mphy->state))
-		return __mt7663s_mcu_drv_pmctrl(dev);
+	mutex_lock(&dev->pm.mutex);
 
-	return 0;
+	if (test_bit(MT76_STATE_PM, &mphy->state))
+		ret = __mt7663s_mcu_drv_pmctrl(dev);
+
+	mutex_unlock(&dev->pm.mutex);
+
+	return ret;
 }
 
 static int mt7663s_mcu_fw_pmctrl(struct mt7615_dev *dev)
 {
 	struct sdio_func *func = dev->mt76.sdio.func;
 	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int ret = 0;
 	u32 status;
-	int ret;
 
-	if (test_and_set_bit(MT76_STATE_PM, &mphy->state))
-		return 0;
+	mutex_lock(&pm->mutex);
+
+	if (mt76_connac_skip_fw_pmctrl(mphy, pm))
+		goto out;
 
 	sdio_claim_host(func);
 
@@ -110,6 +116,8 @@ static int mt7663s_mcu_fw_pmctrl(struct mt7615_dev *dev)
 	}
 
 	sdio_release_host(func);
+out:
+	mutex_unlock(&pm->mutex);
 
 	return ret;
 }
-- 
2.31.1


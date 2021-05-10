Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AFF379A15
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 00:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhEJWat (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 18:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhEJWar (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 18:30:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AE3461581;
        Mon, 10 May 2021 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620685782;
        bh=DgBcdPbRRR8zN5iiw5yCAfQFzH88KzMTBDKTGSx4Dq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxKZsppJJOE/0z6uU3kTnKCydKPmkaQS3NtMgqEJgZT4ZOisp2i3y1c3uSsCpnh4j
         0kr8cfZt7lQBpU8ulBUWYRwI+6dJZf6llUvI/XpqjGHjM56UN0sKiDsdtnwZikO2h2
         0bywJjvkxze460NyVBSY4GE88fDh/wt2DgzM9TP0CEUUOtL6yqQTdKozZN/gQMAq5u
         mI+s+L4VSIMXQPZn+4dddHKAbD7u3SoqJwaSbKi9ewZeqCnH86XlXuOWmrmD9wXKLC
         BRXz/npBZHX7boATHJ6AN1K3ppzCoHYpdF03xgCz3X1iF70s1fcqLLAhvp+gMy7jGv
         88S8kJhqXt87g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 2/5] mt76: mt7663s: rely on pm reference counting
Date:   Tue, 11 May 2021 00:29:21 +0200
Message-Id: <92d33014a577389dfceb54f09af0e548085f2c07.1620685619.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620685619.git.lorenzo@kernel.org>
References: <cover.1620685619.git.lorenzo@kernel.org>
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


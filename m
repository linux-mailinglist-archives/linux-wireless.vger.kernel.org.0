Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D782261147
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgIHMZQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 08:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730193AbgIHLy4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 07:54:56 -0400
Received: from lore-desk.redhat.com (unknown [151.66.86.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76AB206B5;
        Tue,  8 Sep 2020 11:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599566051;
        bh=HO7XeQ+j1AMU7+bash//gpa0sxCtmp+N7ND2icgfZ9g=;
        h=From:To:Cc:Subject:Date:From;
        b=Eo6I1Wyyqd7Lf5yJBxgztk9ZwCs7kOosR6vx3aF6nXfNcYVAeoCYqDDAiQWVIBSlx
         8BD96G4BtrTzBw1+OwoBkyrqyeG1s5m0sqh+4+Ve3vQu5/LPdoBY17kr5yNQSKiVJW
         0mbYey3HYIUQZNrPI7x50Zry89EPbqdHNK5L3rHY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH v2] mt76: mt7622: fix fw hang on mt7622
Date:   Tue,  8 Sep 2020 13:54:03 +0200
Message-Id: <2a24709602ee0f83f2e275170254942a87ffeea5.1599558634.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set poll timeout to 3s for mt7622 devices in order to avoid fw hangs.
Swap mt7622_trigger_hif_int and doorbell configuration order in
mt7615_mcu_drv_pmctrl routine.
Introduce mt7615_mcu_lp_drv_pmctrl routine to take care of drv_own
configuration for runtime-pm.

Fixes: 08523a2a1db5 ("mt76: mt7615: add mt7615_pm_wake utility routine")
Fixes: 894b7767ec2f ("mt76: mt7615: improve mt7615_driver_own reliability")
Fixes: 757b0e7fd6f4 ("mt76: mt7615: avoid polling in fw_own for mt7663")
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- introduce mt7615_mcu_lp_drv_pmctrl
- set mt7615_mcu_drv_pmctrl timeout to 3s
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 46 +++++++++++++------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 074cdefba8aa..8630931a656f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -338,28 +338,46 @@ static int mt7615_mcu_drv_pmctrl(struct mt7615_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_dev *mdev = &dev->mt76;
-	int i;
+	u32 addr;
+	int err;
 
-	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
-		goto out;
+	addr = is_mt7663(mdev) ? MT_PCIE_DOORBELL_PUSH : MT_CFG_LPCR_HOST;
+	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_DRV_OWN);
 
 	mt7622_trigger_hif_int(dev, true);
 
-	for (i = 0; i < MT7615_DRV_OWN_RETRY_COUNT; i++) {
-		u32 addr;
+	addr = is_mt7663(mdev) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
+	err = !mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN, 0, 3000);
 
-		addr = is_mt7663(mdev) ? MT_PCIE_DOORBELL_PUSH : MT_CFG_LPCR_HOST;
-		mt76_wr(dev, addr, MT_CFG_LPCR_HOST_DRV_OWN);
+	mt7622_trigger_hif_int(dev, false);
 
-		addr = is_mt7663(mdev) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
-		if (mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN, 0, 50))
-			break;
+	if (err) {
+		dev_err(mdev->dev, "driver own failed\n");
+		return -ETIMEDOUT;
 	}
 
-	mt7622_trigger_hif_int(dev, false);
+	clear_bit(MT76_STATE_PM, &mphy->state);
+
+	return 0;
+}
+
+static int mt7615_mcu_lp_drv_pmctrl(struct mt7615_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	int i;
+
+	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
+		goto out;
+
+	for (i = 0; i < MT7615_DRV_OWN_RETRY_COUNT; i++) {
+		mt76_wr(dev, MT_PCIE_DOORBELL_PUSH, MT_CFG_LPCR_HOST_DRV_OWN);
+		if (mt76_poll_msec(dev, MT_CONN_HIF_ON_LPCTL,
+				   MT_CFG_LPCR_HOST_FW_OWN, 0, 50))
+			break;
+	}
 
 	if (i == MT7615_DRV_OWN_RETRY_COUNT) {
-		dev_err(mdev->dev, "driver own failed\n");
+		dev_err(dev->mt76.dev, "driver own failed\n");
 		set_bit(MT76_STATE_PM, &mphy->state);
 		return -EIO;
 	}
@@ -386,7 +404,7 @@ static int mt7615_mcu_fw_pmctrl(struct mt7615_dev *dev)
 
 	if (is_mt7622(&dev->mt76) &&
 	    !mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN,
-			    MT_CFG_LPCR_HOST_FW_OWN, 300)) {
+			    MT_CFG_LPCR_HOST_FW_OWN, 3000)) {
 		dev_err(dev->mt76.dev, "Timeout for firmware own\n");
 		clear_bit(MT76_STATE_PM, &mphy->state);
 		err = -EIO;
@@ -1900,7 +1918,7 @@ static const struct mt7615_mcu_ops uni_update_ops = {
 	.add_tx_ba = mt7615_mcu_uni_tx_ba,
 	.add_rx_ba = mt7615_mcu_uni_rx_ba,
 	.sta_add = mt7615_mcu_uni_add_sta,
-	.set_drv_ctrl = mt7615_mcu_drv_pmctrl,
+	.set_drv_ctrl = mt7615_mcu_lp_drv_pmctrl,
 	.set_fw_ctrl = mt7615_mcu_fw_pmctrl,
 };
 
-- 
2.26.2


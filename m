Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE18020BB7C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 23:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgFZV0E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 17:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgFZV0D (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 17:26:03 -0400
Received: from localhost.localdomain.com (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A0E20B80;
        Fri, 26 Jun 2020 21:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593206763;
        bh=9Q8lIrJ52Zp+iLoYJutgGc2fDNrAyLw63oX+jKzAApM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjyPVDymuLomXby+4vgHWtZDhDvwbzBkNGNi2GOsZQTLL6gV6p7FO/Ij/oeoJphow
         BFX7Q/C7o7rfQZ4m8Ae8vQk32PIpH7byhIlM0gA9qjrSegDG/ZdYrLB05UaRQARm0t
         IEbsxy3aX/u6IAQ4masxoPc41lb8ABdB2h0WjpMY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 17/17] mt76: mt7615: improve mt7615_driver_own reliability
Date:   Fri, 26 Jun 2020 23:25:17 +0200
Message-Id: <1b218a4d518c34ea9b9a143ff40b8e5b8ede93ca.1593204577.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593204577.git.lorenzo@kernel.org>
References: <cover.1593204577.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7615_driver_own can fail if it runs too close to mt7615_fw_own. In
order to improve mt7615_driver_own reliability, retry to get runtime-pm
ownership if mt7615_driver_own fails

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 27 ++++++++++++-------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  2 ++
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 293799263412..4f2d25230147 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1918,29 +1918,36 @@ int mt7615_driver_own(struct mt7615_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_dev *mdev = &dev->mt76;
-	int err = 0;
-	u32 addr;
+	int i;
 
 	if (!test_and_clear_bit(MT76_STATE_PM, &mphy->state))
 		goto out;
 
 	mt7622_trigger_hif_int(dev, true);
 
-	addr = is_mt7663(mdev) ? MT_PCIE_DOORBELL_PUSH : MT_CFG_LPCR_HOST;
-	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_DRV_OWN);
+	for (i = 0; i < MT7615_DRV_OWN_RETRY_COUNT; i++) {
+		u32 addr;
 
-	addr = is_mt7663(mdev) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
-	if (!mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN, 0, 3000)) {
-		dev_err(mdev->dev, "Timeout for driver own\n");
-		set_bit(MT76_STATE_PM, &mphy->state);
-		err = -EIO;
+		addr = is_mt7663(mdev) ? MT_PCIE_DOORBELL_PUSH : MT_CFG_LPCR_HOST;
+		mt76_wr(dev, addr, MT_CFG_LPCR_HOST_DRV_OWN);
+
+		addr = is_mt7663(mdev) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
+		if (mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN, 0, 50))
+			break;
 	}
 
 	mt7622_trigger_hif_int(dev, false);
+
+	if (i == MT7615_DRV_OWN_RETRY_COUNT) {
+		dev_err(mdev->dev, "driver own failed\n");
+		set_bit(MT76_STATE_PM, &mphy->state);
+		return -EIO;
+	}
+
 out:
 	dev->pm.last_activity = jiffies;
 
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(mt7615_driver_own);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index d3360196c76a..a555679d8a4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -33,6 +33,8 @@
 #define MT7615_RX_RING_SIZE		1024
 #define MT7615_RX_MCU_RING_SIZE		512
 
+#define MT7615_DRV_OWN_RETRY_COUNT	10
+
 #define MT7615_FIRMWARE_CR4		"mediatek/mt7615_cr4.bin"
 #define MT7615_FIRMWARE_N9		"mediatek/mt7615_n9.bin"
 #define MT7615_ROM_PATCH		"mediatek/mt7615_rom_patch.bin"
-- 
2.26.2


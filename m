Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDFB40B3D0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 17:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhINP4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 11:56:55 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:52303 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhINP4y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 11:56:54 -0400
X-UUID: 69cc4bfe48c7493e8b0803879bfc7a72-20210914
X-UUID: 69cc4bfe48c7493e8b0803879bfc7a72-20210914
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 962019139; Tue, 14 Sep 2021 08:50:27 -0700
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 08:50:25 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 23:50:24 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] mt76: mt7921: robustify hardware initialization flow
Date:   Tue, 14 Sep 2021 23:50:21 +0800
Message-ID: <b3d4a17bdbb819424a6493f14b9cd3d7a6bbc588.1631633959.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Robustify hardware initialization in the current driver probing flow
to get rid of the device is possibly lost after the machine boot due
to possible firmware abnormal state by trying to recover the failure
with more chances.

Tested-by: Leon Yen <Leon.Yen@mediatek.com>
Tested-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 53 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 1f37e64b6038..d26166a612f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -146,33 +146,60 @@ int mt7921_mac_init(struct mt7921_dev *dev)
 	return mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
 }
 
-static int mt7921_init_hardware(struct mt7921_dev *dev)
+static int __mt7921_init_hardware(struct mt7921_dev *dev)
 {
-	int ret, idx;
-
-	ret = mt7921_dma_init(dev);
-	if (ret)
-		return ret;
-
-	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+	struct mt76_dev *mdev = &dev->mt76;
+	int ret;
 
 	/* force firmware operation mode into normal state,
 	 * which should be set before firmware download stage.
 	 */
 	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
-
 	ret = mt7921_mcu_init(dev);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = mt7921_eeprom_init(dev);
-	if (ret < 0)
-		return ret;
+	if (ret)
+		goto out;
 
 	ret = mt7921_mcu_set_eeprom(dev);
+	if (ret)
+		goto out;
+
+	ret = mt7921_mac_init(dev);
+out:
+	if (ret && mdev->eeprom.data) {
+		devm_kfree(mdev->dev, mdev->eeprom.data);
+		mdev->eeprom.data = NULL;
+	}
+
+	return ret;
+}
+
+static int mt7921_init_hardware(struct mt7921_dev *dev)
+{
+	int ret, idx, i;
+
+	ret = mt7921_dma_init(dev);
 	if (ret)
 		return ret;
 
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+
+	for (i = 0; i < MT7921_MCU_INIT_RETRY_COUNT; i++) {
+		ret = __mt7921_init_hardware(dev);
+		if (!ret)
+			break;
+
+		mt7921_wpdma_reset(dev, true);
+	}
+
+	if (i == MT7921_MCU_INIT_RETRY_COUNT) {
+		dev_err(dev->mt76.dev, "hardware init failed\n");
+		return ret;
+	}
+
 	/* Beacon and mgmt frames should occupy wcid 0 */
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
 	if (idx)
@@ -183,7 +210,7 @@ static int mt7921_init_hardware(struct mt7921_dev *dev)
 	dev->mt76.global_wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
 
-	return mt7921_mac_init(dev);
+	return 0;
 }
 
 int mt7921_register_device(struct mt7921_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 6a47ba65b96e..cee7a2507224 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -29,6 +29,7 @@
 #define MT7921_RX_MCU_RING_SIZE		512
 
 #define MT7921_DRV_OWN_RETRY_COUNT	10
+#define MT7921_MCU_INIT_RETRY_COUNT	10
 
 #define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
-- 
2.25.1


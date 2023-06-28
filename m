Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2846740A05
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjF1H4S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:56:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52940 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231218AbjF1HyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:15 -0400
X-UUID: a7b7f3ca158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zX9+VE1IK66LwgIwcnzWoeOin0U+RR9qBX6u4mwZx/U=;
        b=RTBuAPT+cTI/Khz6tQCvaEKkGrzFOOwYr/6tWzWlDotXT/EUOfyINteK4VwkvVUlHlWXeUfNxP2HxwkOjlrNlh91ZxSCULpgYmYFLXkpVRPAExtX0WTltA2G3jgmP1DK4+mOCBFc3NPCjWs1m8x4OEI6aKfwQszLVzj9blJsxFY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:94dd36e0-1ff6-4e14-a868-d8cad7ecaf6f,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.27,REQID:94dd36e0-1ff6-4e14-a868-d8cad7ecaf6f,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:01c9525,CLOUDID:ff889b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:2306281509021ABSIV55,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: a7b7f3ca158211eeb20a276fd37b9834-20230628
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 143698506; Wed, 28 Jun 2023 15:08:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:08:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:08:58 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 07/11] wifi: mt76: mt792x: move mt7921_load_firmware in mt792x-lib module
Date:   Wed, 28 Jun 2023 15:07:20 +0800
Message-ID: <a9f5ca5f2ab7f3da5e7d5b13668f4ee7a259393b.1687920269.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687920269.git.deren.wu@mediatek.com>
References: <cover.1687920269.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

mt7921_load_firmware routine is shared between mt7921 and mt7925 chipset
so move it in mt792x-lib module.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 63 +------------------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  6 --
 drivers/net/wireless/mediatek/mt76/mt792x.h   | 28 +++++++++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 36 +++++++++++
 4 files changed, 66 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index e9caf750bca5..4b77d95af958 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -364,30 +364,6 @@ int mt7921_mcu_uni_rx_ba(struct mt792x_dev *dev,
 				      enable, false);
 }
 
-static char *mt7921_patch_name(struct mt792x_dev *dev)
-{
-	char *ret;
-
-	if (is_mt7922(&dev->mt76))
-		ret = MT7922_ROM_PATCH;
-	else
-		ret = MT7921_ROM_PATCH;
-
-	return ret;
-}
-
-static char *mt7921_ram_name(struct mt792x_dev *dev)
-{
-	char *ret;
-
-	if (is_mt7922(&dev->mt76))
-		ret = MT7922_FIRMWARE_WM;
-	else
-		ret = MT7921_FIRMWARE_WM;
-
-	return ret;
-}
-
 static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 {
 	const struct mt76_connac2_fw_trailer *hdr;
@@ -472,41 +448,6 @@ static int mt7921_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	return ret;
 }
 
-static int mt7921_load_firmware(struct mt792x_dev *dev)
-{
-	int ret;
-
-	ret = mt76_connac2_load_patch(&dev->mt76, mt7921_patch_name(dev));
-	if (ret)
-		return ret;
-
-	if (mt76_is_sdio(&dev->mt76)) {
-		/* activate again */
-		ret = __mt792x_mcu_fw_pmctrl(dev);
-		if (!ret)
-			ret = __mt792x_mcu_drv_pmctrl(dev);
-	}
-
-	ret = mt76_connac2_load_ram(&dev->mt76, mt7921_ram_name(dev), NULL);
-	if (ret)
-		return ret;
-
-	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY,
-			    MT_TOP_MISC2_FW_N9_RDY, 1500)) {
-		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
-
-		return -EIO;
-	}
-
-#ifdef CONFIG_PM
-	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
-#endif /* CONFIG_PM */
-
-	dev_dbg(dev->mt76.dev, "Firmware init done\n");
-
-	return 0;
-}
-
 int mt7921_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl)
 {
 	struct {
@@ -524,7 +465,7 @@ int mt7921_run_firmware(struct mt792x_dev *dev)
 {
 	int err;
 
-	err = mt7921_load_firmware(dev);
+	err = mt792x_load_firmware(dev);
 	if (err)
 		return err;
 
@@ -533,7 +474,7 @@ int mt7921_run_firmware(struct mt792x_dev *dev)
 		return err;
 
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
-	err = mt7921_load_clc(dev, mt7921_ram_name(dev));
+	err = mt7921_load_clc(dev, mt792x_ram_name(dev));
 	if (err)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index cb22be083242..e458ddb7d99a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -17,12 +17,6 @@
 #define MT7921_RX_RING_SIZE		1536
 #define MT7921_RX_MCU_RING_SIZE		512
 
-#define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
-#define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
-
-#define MT7922_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7922_1.bin"
-#define MT7922_ROM_PATCH		"mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin"
-
 #define MT7921_EEPROM_SIZE		3584
 #define MT7921_TOKEN_SIZE		8192
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index b226a863e5de..700cd0ccc5d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -31,6 +31,12 @@
 #define MT792x_MCU_INIT_RETRY_COUNT	10
 #define MT792x_WFSYS_INIT_RETRY_COUNT	2
 
+#define MT7921_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
+#define MT7922_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7922_1.bin"
+
+#define MT7921_ROM_PATCH	"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
+#define MT7922_ROM_PATCH	"mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin"
+
 struct mt792x_vif;
 struct mt792x_sta;
 
@@ -294,6 +300,28 @@ int mt792x_init_wcid(struct mt792x_dev *dev);
 int mt792x_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792x_mcu_fw_pmctrl(struct mt792x_dev *dev);
 
+static inline char *mt792x_ram_name(struct mt792x_dev *dev)
+{
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7922:
+		return MT7922_FIRMWARE_WM;
+	default:
+		return MT7921_FIRMWARE_WM;
+	}
+}
+
+static inline char *mt792x_patch_name(struct mt792x_dev *dev)
+{
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7922:
+		return MT7922_ROM_PATCH;
+	default:
+		return MT7921_ROM_PATCH;
+	}
+}
+
+int mt792x_load_firmware(struct mt792x_dev *dev);
+
 /* usb */
 #define MT_USB_TYPE_VENDOR	(USB_TYPE_VENDOR | 0x1f)
 #define MT_USB_TYPE_UHW_VENDOR	(USB_TYPE_VENDOR | 0x1e)
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index f7dfc2189cc8..46be7f996c7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -804,5 +804,41 @@ int mt792xe_mcu_fw_pmctrl(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt792xe_mcu_fw_pmctrl);
 
+int mt792x_load_firmware(struct mt792x_dev *dev)
+{
+	int ret;
+
+	ret = mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name(dev));
+	if (ret)
+		return ret;
+
+	if (mt76_is_sdio(&dev->mt76)) {
+		/* activate again */
+		ret = __mt792x_mcu_fw_pmctrl(dev);
+		if (!ret)
+			ret = __mt792x_mcu_drv_pmctrl(dev);
+	}
+
+	ret = mt76_connac2_load_ram(&dev->mt76, mt792x_ram_name(dev), NULL);
+	if (ret)
+		return ret;
+
+	if (!mt76_poll_msec(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY,
+			    MT_TOP_MISC2_FW_N9_RDY, 1500)) {
+		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
+
+		return -EIO;
+	}
+
+#ifdef CONFIG_PM
+	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
+#endif /* CONFIG_PM */
+
+	dev_dbg(dev->mt76.dev, "Firmware init done\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_load_firmware);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
-- 
2.18.0


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2F37205DF
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 17:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbjFBPWG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbjFBPWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 11:22:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E02E44
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 08:21:59 -0700 (PDT)
X-UUID: 33667ca4015911eeb20a276fd37b9834-20230602
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NNpqi9IUm/mxyXdLH1D/Oo70z7AziBjI1lWEM28tHw4=;
        b=PqOzYhttvcFylCtqbKZi4l06gl17bvrXm2wOFcIatZMbko13wAGa+zc00pELvcI1ryFdYkEgkNtsgI0GNA6fMobv+LcO0+6tWrCTsgnPFrxUhEDu+R/n1wva97E9zZs0H3xN/Dwnx426kBrqXASwwe/Ph4A40hleQdvqe+c3bAI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:1780dbad-edcb-4a35-9c1f-75b051c70590,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d5b0ae3,CLOUDID:05ef663d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 33667ca4015911eeb20a276fd37b9834-20230602
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 903090666; Fri, 02 Jun 2023 23:21:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 2 Jun 2023 23:21:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 2 Jun 2023 23:21:50 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 03/12] wifi: mt76: mt7996: add dsp firmware download
Date:   Fri, 2 Jun 2023 23:20:59 +0800
Message-ID: <20230602152108.26860-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230602152108.26860-1-shayne.chen@mediatek.com>
References: <20230602152108.26860-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Add DSP firmware for phy-related control. The firmware is transparent to
driver, but it's necessary for the firmware download process.

Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 94 ++++++++-----------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  7 ++
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |  1 +
 3 files changed, 49 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 88e2f9d0e513..243647dbd8c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2155,7 +2155,7 @@ static int mt7996_load_patch(struct mt7996_dev *dev)
 static int
 mt7996_mcu_send_ram_firmware(struct mt7996_dev *dev,
 			     const struct mt7996_fw_trailer *hdr,
-			     const u8 *data, bool is_wa)
+			     const u8 *data, enum mt7996_ram_type type)
 {
 	int i, offset = 0;
 	u32 override = 0, option = 0;
@@ -2167,8 +2167,10 @@ mt7996_mcu_send_ram_firmware(struct mt7996_dev *dev,
 
 		region = (const struct mt7996_fw_region *)((const u8 *)hdr -
 			 (hdr->n_region - i) * sizeof(*region));
+		/* DSP and WA use same mode */
 		mode = mt76_connac_mcu_gen_dl_mode(&dev->mt76,
-						   region->feature_set, is_wa);
+						   region->feature_set,
+						   type != MT7996_RAM_TYPE_WM);
 		len = le32_to_cpu(region->len);
 		addr = le32_to_cpu(region->addr);
 
@@ -2195,8 +2197,10 @@ mt7996_mcu_send_ram_firmware(struct mt7996_dev *dev,
 	if (override)
 		option |= FW_START_OVERRIDE;
 
-	if (is_wa)
+	if (type == MT7996_RAM_TYPE_WA)
 		option |= FW_START_WORKING_PDA_CR4;
+	else if (type == MT7996_RAM_TYPE_DSP)
+		option |= FW_START_WORKING_PDA_DSP;
 
 	return mt76_connac_mcu_start_firmware(&dev->mt76, override, option);
 }
@@ -2207,56 +2211,40 @@ static int mt7996_load_ram(struct mt7996_dev *dev)
 	const struct firmware *fw;
 	int ret;
 
-	ret = request_firmware(&fw, MT7996_FIRMWARE_WM, dev->mt76.dev);
-	if (ret)
-		return ret;
-
-	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
-		dev_err(dev->mt76.dev, "Invalid firmware\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	hdr = (const struct mt7996_fw_trailer *)(fw->data + fw->size - sizeof(*hdr));
-
-	dev_info(dev->mt76.dev, "WM Firmware Version: %.10s, Build Time: %.15s\n",
-		 hdr->fw_ver, hdr->build_date);
-
-	ret = mt7996_mcu_send_ram_firmware(dev, hdr, fw->data, false);
-	if (ret) {
-		dev_err(dev->mt76.dev, "Failed to start WM firmware\n");
-		goto out;
-	}
-
-	release_firmware(fw);
-
-	ret = request_firmware(&fw, MT7996_FIRMWARE_WA, dev->mt76.dev);
-	if (ret)
-		return ret;
-
-	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
-		dev_err(dev->mt76.dev, "Invalid firmware\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	hdr = (const struct mt7996_fw_trailer *)(fw->data + fw->size - sizeof(*hdr));
-
-	dev_info(dev->mt76.dev, "WA Firmware Version: %.10s, Build Time: %.15s\n",
-		 hdr->fw_ver, hdr->build_date);
-
-	ret = mt7996_mcu_send_ram_firmware(dev, hdr, fw->data, true);
-	if (ret) {
-		dev_err(dev->mt76.dev, "Failed to start WA firmware\n");
-		goto out;
-	}
-
-	snprintf(dev->mt76.hw->wiphy->fw_version,
-		 sizeof(dev->mt76.hw->wiphy->fw_version),
-		 "%.10s-%.15s", hdr->fw_ver, hdr->build_date);
-
-out:
-	release_firmware(fw);
+#define LOAD_RAM(_type) \
+	do {									\
+		ret = request_firmware(&fw, MT7996_FIRMWARE_##_type, dev->mt76.dev);\
+		if (ret)							\
+			return ret;						\
+										\
+		if (!fw || !fw->data || fw->size < sizeof(*hdr)) {		\
+			dev_err(dev->mt76.dev, "Invalid firmware\n");		\
+			release_firmware(fw);					\
+			return -EINVAL;						\
+		}								\
+										\
+		hdr = (const struct mt7996_fw_trailer *)			\
+				(fw->data + fw->size - sizeof(*hdr));		\
+										\
+		dev_info(dev->mt76.dev,						\
+			 "%s Firmware Version: %.10s, Build Time: %.15s\n",	\
+			 #_type, hdr->fw_ver, hdr->build_date);			\
+										\
+		ret = mt7996_mcu_send_ram_firmware(dev, hdr, fw->data,		\
+						   MT7996_RAM_TYPE_##_type);    \
+		if (ret) {							\
+			dev_err(dev->mt76.dev, "Failed to start %s firmware\n", #_type);\
+			release_firmware(fw);					\
+			return ret;						\
+		}								\
+										\
+		release_firmware(fw);						\
+	} while (0)
+
+	LOAD_RAM(WM);
+	LOAD_RAM(DSP);
+	LOAD_RAM(WA);
+#undef LOAD_RAM
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 4d7dcb95a620..7dfdc7384056 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -29,6 +29,7 @@
 
 #define MT7996_FIRMWARE_WA		"mediatek/mt7996/mt7996_wa.bin"
 #define MT7996_FIRMWARE_WM		"mediatek/mt7996/mt7996_wm.bin"
+#define MT7996_FIRMWARE_DSP		"mediatek/mt7996/mt7996_dsp.bin"
 #define MT7996_ROM_PATCH		"mediatek/mt7996/mt7996_rom_patch.bin"
 
 #define MT7996_EEPROM_DEFAULT		"mediatek/mt7996/mt7996_eeprom.bin"
@@ -52,6 +53,12 @@ struct mt7996_sta;
 struct mt7996_dfs_pulse;
 struct mt7996_dfs_pattern;
 
+enum mt7996_ram_type {
+	MT7996_RAM_TYPE_WM,
+	MT7996_RAM_TYPE_WA,
+	MT7996_RAM_TYPE_DSP,
+};
+
 enum mt7996_txq_id {
 	MT7996_TXQ_FWDL = 16,
 	MT7996_TXQ_MCU_WM,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 64aee3fb5445..c5301050ff8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -219,4 +219,5 @@ MODULE_DEVICE_TABLE(pci, mt7996_pci_device_table);
 MODULE_DEVICE_TABLE(pci, mt7996_hif_device_table);
 MODULE_FIRMWARE(MT7996_FIRMWARE_WA);
 MODULE_FIRMWARE(MT7996_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7996_FIRMWARE_DSP);
 MODULE_FIRMWARE(MT7996_ROM_PATCH);
-- 
2.39.2


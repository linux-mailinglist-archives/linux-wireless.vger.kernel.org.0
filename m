Return-Path: <linux-wireless+bounces-20917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA59A743A5
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA77173119
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D4821148E;
	Fri, 28 Mar 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b7j//DAi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42091D6DB1
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141247; cv=none; b=CpXFyO+gKv4cXWuSdVgv3kSHmcnedFcFuM/Sjn1ZSQBKC7CgdmWEvb/FxmEnCaYjs0cMEjC+dReayofzAS660pRM6rCpzgIQAJKr3Zo9Ka0xY+CbFB8bYdwyOFv0/opjv2jgp7CU3tyfMwlpiA7aI1lf0gR/7aMwT9N/H/06SxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141247; c=relaxed/simple;
	bh=4Xaru6n/sam0Al6g78Xl9g/R8j2XmHndbKV50MUIQkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQDgN+x7iLRuAJeSxSgmUkD/hXP0OSlTZCGJzSeXG7g0weSXa5mLqb9jRcpVobHD7zUg30N6CmdHhDwPIzL4UY/HesP6XVA9aEuBZX9Ry4GgNcFW7qxQRyy1dhomv7p52ulzycytfaTiTwS7PAiT/BJgMYooUj0UCG5Y8KjGJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=b7j//DAi; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0a8910520b9911f0aae1fd9735fae912-20250328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=futY6c2uLQgzM+VulOPiiPRtQi0w6EpsM/OE547Rw+U=;
	b=b7j//DAiMTly972RPoc0KzO6F8FQrO+jYo3xgVNfGJJ+a1xEDTBCU+ztzXnGDzR8/4u/gEi3RXYtzM9WSaV7M/ZZRVBgwtV6hMosut503f7v9LAC7WRPeWqKmJzXe8+0Jh5cIK2yGQFvAPIs3skCnMcsIeopVVCa9sZzCrmmiss=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:917711e9-aea3-4799-a433-d7d6fdd91b7b,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:e29b67a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0a8910520b9911f0aae1fd9735fae912-20250328
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 411386295; Fri, 28 Mar 2025 13:53:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 28 Mar 2025 13:53:57 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 28 Mar 2025 13:53:57 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 02/10] wifi: mt76: connac: add support to load firmware for mt7990
Date: Fri, 28 Mar 2025 13:50:50 +0800
Message-ID: <20250328055058.1648755-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328055058.1648755-1-shayne.chen@mediatek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

Add firmware download support. Note that mt7990 does not have WA and DSP
firmwares. This is a preliminary patch to support mt7990 chipset.

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  7 +++++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  3 +--
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 23 ++++++++++++-------
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 12 ++++++++++
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |  2 ++
 5 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 455979476d11..192dcc374a64 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -232,9 +232,14 @@ static inline bool is_mt7992(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7992;
 }
 
+static inline bool is_mt7990(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7993;
+}
+
 static inline bool is_mt799x(struct mt76_dev *dev)
 {
-	return is_mt7996(dev) || is_mt7992(dev);
+	return is_mt7996(dev) || is_mt7992(dev) || is_mt7990(dev);
 }
 
 static inline bool is_mt7622(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index bafcf5a279e2..185ba57d416d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -67,8 +67,7 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 	if ((!is_connac_v1(dev) && addr == MCU_PATCH_ADDRESS) ||
 	    (is_mt7921(dev) && addr == 0x900000) ||
 	    (is_mt7925(dev) && (addr == 0x900000 || addr == 0xe0002800)) ||
-	    (is_mt7996(dev) && addr == 0x900000) ||
-	    (is_mt7992(dev) && addr == 0x900000))
+	    (is_mt799x(dev) && addr == 0x900000))
 		cmd = MCU_CMD(PATCH_START_REQ);
 	else
 		cmd = MCU_CMD(TARGET_ADDRESS_LEN_REQ);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 81cc50ae55b0..1d12ccbacbcf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -22,6 +22,9 @@
 			_fw = MT7992_##name;			\
 		}						\
 		break;						\
+	case MT7990_DEVICE_ID:					\
+		_fw = MT7990_##name;				\
+		break;						\
 	case MT7996_DEVICE_ID:						\
 	default:						\
 		switch ((_dev)->var.type) {			\
@@ -265,7 +268,7 @@ mt7996_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 
 	txd_len = cmd & __MCU_CMD_FIELD_UNI ? sizeof(*uni_txd) : sizeof(*mcu_txd);
 	txd = (__le32 *)skb_push(skb, txd_len);
-	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state) && mt7996_has_wa(dev))
 		qid = MT_MCUQ_WA;
 	else
 		qid = MT_MCUQ_WM;
@@ -3011,6 +3014,9 @@ static int mt7996_load_ram(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
+	if (!mt7996_has_wa(dev))
+		return 0;
+
 	ret = __mt7996_load_ram(dev, "DSP", fw_name(dev, FIRMWARE_DSP),
 				MT7996_RAM_TYPE_DSP);
 	if (ret)
@@ -3021,10 +3027,9 @@ static int mt7996_load_ram(struct mt7996_dev *dev)
 }
 
 static int
-mt7996_firmware_state(struct mt7996_dev *dev, bool wa)
+mt7996_firmware_state(struct mt7996_dev *dev, u8 fw_state)
 {
-	u32 state = FIELD_PREP(MT_TOP_MISC_FW_STATE,
-			       wa ? FW_STATE_RDY : FW_STATE_FW_DOWNLOAD);
+	u32 state = FIELD_PREP(MT_TOP_MISC_FW_STATE, fw_state);
 
 	if (!mt76_poll_msec(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE,
 			    state, 1000)) {
@@ -3056,13 +3061,14 @@ mt7996_mcu_restart(struct mt76_dev *dev)
 
 static int mt7996_load_firmware(struct mt7996_dev *dev)
 {
+	u8 fw_state;
 	int ret;
 
 	/* make sure fw is download state */
-	if (mt7996_firmware_state(dev, false)) {
+	if (mt7996_firmware_state(dev, FW_STATE_FW_DOWNLOAD)) {
 		/* restart firmware once */
 		mt7996_mcu_restart(&dev->mt76);
-		ret = mt7996_firmware_state(dev, false);
+		ret = mt7996_firmware_state(dev, FW_STATE_FW_DOWNLOAD);
 		if (ret) {
 			dev_err(dev->mt76.dev,
 				"Firmware is not ready for download\n");
@@ -3078,7 +3084,8 @@ static int mt7996_load_firmware(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt7996_firmware_state(dev, true);
+	fw_state = mt7996_has_wa(dev) ? FW_STATE_RDY : FW_STATE_NORMAL_TRX;
+	ret = mt7996_firmware_state(dev, fw_state);
 	if (ret)
 		return ret;
 
@@ -3248,7 +3255,7 @@ int mt7996_mcu_init(struct mt7996_dev *dev)
 void mt7996_mcu_exit(struct mt7996_dev *dev)
 {
 	mt7996_mcu_restart(&dev->mt76);
-	if (mt7996_firmware_state(dev, false)) {
+	if (mt7996_firmware_state(dev, FW_STATE_FW_DOWNLOAD)) {
 		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
 		goto out;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index bc22c3e12d94..c03747ed6c70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -34,6 +34,8 @@
 #define MT7996_DEVICE_ID_2		0x7991
 #define MT7992_DEVICE_ID		0x7992
 #define MT7992_DEVICE_ID_2		0x799a
+#define MT7990_DEVICE_ID		0x7993
+#define MT7990_DEVICE_ID_2		0x799b
 
 #define MT7996_FIRMWARE_WA		"mediatek/mt7996/mt7996_wa.bin"
 #define MT7996_FIRMWARE_WM		"mediatek/mt7996/mt7996_wm.bin"
@@ -55,6 +57,11 @@
 #define MT7992_FIRMWARE_DSP_23		"mediatek/mt7996/mt7992_dsp_23.bin"
 #define MT7992_ROM_PATCH_23		"mediatek/mt7996/mt7992_rom_patch_23.bin"
 
+#define MT7990_FIRMWARE_WA		""
+#define MT7990_FIRMWARE_WM		"mediatek/mt7996/mt7990_wm.bin"
+#define MT7990_FIRMWARE_DSP		""
+#define MT7990_ROM_PATCH		"mediatek/mt7996/mt7990_rom_patch.bin"
+
 #define MT7996_EEPROM_DEFAULT		"mediatek/mt7996/mt7996_eeprom.bin"
 #define MT7996_EEPROM_DEFAULT_INT	"mediatek/mt7996/mt7996_eeprom_2i5i6i.bin"
 #define MT7996_EEPROM_DEFAULT_233	"mediatek/mt7996/mt7996_eeprom_233.bin"
@@ -709,6 +716,11 @@ static inline u16 mt7996_rx_chainmask(struct mt7996_phy *phy)
 	return tx_chainmask | (BIT(fls(tx_chainmask)) * phy->has_aux_rx);
 }
 
+static inline bool mt7996_has_wa(struct mt7996_dev *dev)
+{
+	return !is_mt7990(&dev->mt76);
+}
+
 void mt7996_mac_init(struct mt7996_dev *dev);
 u32 mt7996_mac_wtbl_lmac_addr(struct mt7996_dev *dev, u16 wcid, u8 dw);
 bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index a4338367aaa1..05248339a17b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -257,3 +257,5 @@ MODULE_FIRMWARE(MT7992_FIRMWARE_WA);
 MODULE_FIRMWARE(MT7992_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7992_FIRMWARE_DSP);
 MODULE_FIRMWARE(MT7992_ROM_PATCH);
+MODULE_FIRMWARE(MT7990_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7990_ROM_PATCH);
-- 
2.39.2



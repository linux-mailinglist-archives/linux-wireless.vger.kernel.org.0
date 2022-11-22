Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34E633783
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 09:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiKVIwO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 03:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiKVIwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 03:52:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3423E09E
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 00:52:07 -0800 (PST)
X-UUID: 16b15257f60b48ce8d1bb72f6a1c4477-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cz2hRvwAA222Ko9eUmi+gmUgEpr2uwtHyTfISsqXX3o=;
        b=G3K0YVsLTsCgDBhNPYmNFwS/eJ6UWYbtzLvXt0sYQvQ0uKkUss6krd1AgIuP83GJbbo/1IlCMpXEHk9lQz8aieHbcyRAol4VfHjXmKMVFCv39MsR37p49ujr2AKlhXoOsPW+bQix71BenSFlN4nWjXkS7RlTXqdtYA7fYKG20AA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:fa99ddfc-3604-4a55-908f-0d2ef20071b2,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.12,REQID:fa99ddfc-3604-4a55-908f-0d2ef20071b2,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:62cd327,CLOUDID:e85ff7f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:2211221652028JUEB0VV,BulkQuantity:1,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0
X-UUID: 16b15257f60b48ce8d1bb72f6a1c4477-20221122
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 173246212; Tue, 22 Nov 2022 16:51:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 16:51:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 16:51:58 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 4/9] wifi: mt76: mt7996: add EEPROM support
Date:   Tue, 22 Nov 2022 16:45:49 +0800
Message-ID: <20221122084554.9494-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221122084554.9494-1-shayne.chen@mediatek.com>
References: <20221122084554.9494-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Split the big patch into smaller intermediate patches by functionality
for easier review. Refer to the cover letter for more info.)

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7996/eeprom.c    | 229 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7996/eeprom.h    |  75 ++++++
 2 files changed, 304 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
new file mode 100644
index 000000000000..b9f62bedbc48
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <linux/firmware.h>
+#include "mt7996.h"
+#include "eeprom.h"
+
+static int mt7996_check_eeprom(struct mt7996_dev *dev)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	u16 val = get_unaligned_le16(eeprom);
+
+	switch (val) {
+	case 0x7990:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static char *mt7996_eeprom_name(struct mt7996_dev *dev)
+{
+	/* reserve for future variants */
+	return MT7996_EEPROM_DEFAULT;
+}
+
+static int
+mt7996_eeprom_load_default(struct mt7996_dev *dev)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	const struct firmware *fw = NULL;
+	int ret;
+
+	ret = request_firmware(&fw, mt7996_eeprom_name(dev), dev->mt76.dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data) {
+		dev_err(dev->mt76.dev, "Invalid default bin\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcpy(eeprom, fw->data, MT7996_EEPROM_SIZE);
+	dev->flash_mode = true;
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int mt7996_eeprom_load(struct mt7996_dev *dev)
+{
+	int ret;
+
+	ret = mt76_eeprom_init(&dev->mt76, MT7996_EEPROM_SIZE);
+	if (ret < 0)
+		return ret;
+
+	if (ret) {
+		dev->flash_mode = true;
+	} else {
+		u8 free_block_num;
+		u32 block_num, i;
+
+		/* TODO: check free block event */
+		mt7996_mcu_get_eeprom_free_block(dev, &free_block_num);
+		/* efuse info not enough */
+		if (free_block_num >= 59)
+			return -EINVAL;
+
+		/* read eeprom data from efuse */
+		block_num = DIV_ROUND_UP(MT7996_EEPROM_SIZE, MT7996_EEPROM_BLOCK_SIZE);
+		for (i = 0; i < block_num; i++)
+			mt7996_mcu_get_eeprom(dev, i * MT7996_EEPROM_BLOCK_SIZE);
+	}
+
+	return mt7996_check_eeprom(dev);
+}
+
+static int mt7996_eeprom_parse_band_config(struct mt7996_phy *phy)
+{
+	u8 *eeprom = phy->dev->mt76.eeprom.data;
+	u32 val = eeprom[MT_EE_WIFI_CONF];
+	int ret = 0;
+
+	switch (phy->mt76->band_idx) {
+	case MT_BAND1:
+		val = FIELD_GET(MT_EE_WIFI_CONF1_BAND_SEL, val);
+		break;
+	case MT_BAND2:
+		val = eeprom[MT_EE_WIFI_CONF + 1];
+		val = FIELD_GET(MT_EE_WIFI_CONF2_BAND_SEL, val);
+		break;
+	default:
+		val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
+		break;
+	}
+
+	switch (val) {
+	case MT_EE_BAND_SEL_2GHZ:
+		phy->mt76->cap.has_2ghz = true;
+		break;
+	case MT_EE_BAND_SEL_5GHZ:
+		phy->mt76->cap.has_5ghz = true;
+		break;
+	case MT_EE_BAND_SEL_6GHZ:
+		phy->mt76->cap.has_6ghz = true;
+		break;
+	case MT_EE_BAND_SEL_5GHZ_6GHZ:
+		phy->mt76->cap.has_5ghz = true;
+		phy->mt76->cap.has_6ghz = true;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy)
+{
+	u8 path, nss, band_idx = phy->mt76->band_idx;
+	u8 *eeprom = dev->mt76.eeprom.data;
+	struct mt76_phy *mphy = phy->mt76;
+
+	switch (band_idx) {
+	case MT_BAND1:
+		path = FIELD_GET(MT_EE_WIFI_CONF2_TX_PATH_BAND1,
+				 eeprom[MT_EE_WIFI_CONF + 2]);
+		nss = FIELD_GET(MT_EE_WIFI_CONF5_STREAM_NUM_BAND1,
+				eeprom[MT_EE_WIFI_CONF + 5]);
+		break;
+	case MT_BAND2:
+		path = FIELD_GET(MT_EE_WIFI_CONF2_TX_PATH_BAND2,
+				 eeprom[MT_EE_WIFI_CONF + 2]);
+		nss = FIELD_GET(MT_EE_WIFI_CONF5_STREAM_NUM_BAND2,
+				eeprom[MT_EE_WIFI_CONF + 5]);
+		break;
+	default:
+		path = FIELD_GET(MT_EE_WIFI_CONF1_TX_PATH_BAND0,
+				 eeprom[MT_EE_WIFI_CONF + 1]);
+		nss = FIELD_GET(MT_EE_WIFI_CONF4_STREAM_NUM_BAND0,
+				eeprom[MT_EE_WIFI_CONF + 4]);
+		break;
+	}
+
+	if (!path || path > 4)
+		path = 4;
+
+	nss = min_t(u8, min_t(u8, 4, nss), path);
+
+	mphy->antenna_mask = BIT(nss) - 1;
+	mphy->chainmask = (BIT(path) - 1) << dev->chainshift[band_idx];
+	dev->chainmask |= mphy->chainmask;
+	if (band_idx < MT_BAND2)
+		dev->chainshift[band_idx + 1] = dev->chainshift[band_idx] +
+						hweight16(mphy->chainmask);
+
+	return mt7996_eeprom_parse_band_config(phy);
+}
+
+int mt7996_eeprom_init(struct mt7996_dev *dev)
+{
+	int ret;
+
+	ret = mt7996_eeprom_load(dev);
+	if (ret < 0) {
+		if (ret != -EINVAL)
+			return ret;
+
+		dev_warn(dev->mt76.dev, "eeprom load fail, use default bin\n");
+		ret = mt7996_eeprom_load_default(dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = mt7996_eeprom_parse_hw_cap(dev, &dev->phy);
+	if (ret < 0)
+		return ret;
+
+	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR, ETH_ALEN);
+	mt76_eeprom_override(&dev->mphy);
+
+	return 0;
+}
+
+int mt7996_eeprom_get_target_power(struct mt7996_dev *dev,
+				   struct ieee80211_channel *chan)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	int target_power;
+
+	if (chan->band == NL80211_BAND_5GHZ)
+		target_power = eeprom[MT_EE_TX0_POWER_5G +
+				      mt7996_get_channel_group_5g(chan->hw_value)];
+	else if (chan->band == NL80211_BAND_6GHZ)
+		target_power = eeprom[MT_EE_TX0_POWER_6G +
+				      mt7996_get_channel_group_6g(chan->hw_value)];
+	else
+		target_power = eeprom[MT_EE_TX0_POWER_2G];
+
+	return target_power;
+}
+
+s8 mt7996_eeprom_get_power_delta(struct mt7996_dev *dev, int band)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	u32 val;
+	s8 delta;
+
+	if (band == NL80211_BAND_5GHZ)
+		val = eeprom[MT_EE_RATE_DELTA_5G];
+	else if (band == NL80211_BAND_6GHZ)
+		val = eeprom[MT_EE_RATE_DELTA_6G];
+	else
+		val = eeprom[MT_EE_RATE_DELTA_2G];
+
+	if (!(val & MT_EE_RATE_DELTA_EN))
+		return 0;
+
+	delta = FIELD_GET(MT_EE_RATE_DELTA_MASK, val);
+
+	return val & MT_EE_RATE_DELTA_SIGN ? delta : -delta;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
new file mode 100644
index 000000000000..8da599e0abea
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#ifndef __MT7996_EEPROM_H
+#define __MT7996_EEPROM_H
+
+#include "mt7996.h"
+
+enum mt7996_eeprom_field {
+	MT_EE_CHIP_ID =		0x000,
+	MT_EE_VERSION =		0x002,
+	MT_EE_MAC_ADDR =	0x004,
+	MT_EE_MAC_ADDR2 =	0x00a,
+	MT_EE_WIFI_CONF =	0x190,
+	MT_EE_MAC_ADDR3 =	0x2c0,
+	MT_EE_RATE_DELTA_2G =	0x1400,
+	MT_EE_RATE_DELTA_5G =	0x147d,
+	MT_EE_RATE_DELTA_6G =	0x154a,
+	MT_EE_TX0_POWER_2G =	0x1300,
+	MT_EE_TX0_POWER_5G =	0x1301,
+	MT_EE_TX0_POWER_6G =	0x1310,
+
+	__MT_EE_MAX =	0x1dff,
+};
+
+#define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF0_BAND_SEL		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF1_BAND_SEL		GENMASK(5, 3)
+#define MT_EE_WIFI_CONF2_BAND_SEL		GENMASK(2, 0)
+
+#define MT_EE_WIFI_CONF1_TX_PATH_BAND0		GENMASK(5, 3)
+#define MT_EE_WIFI_CONF2_TX_PATH_BAND1		GENMASK(5, 3)
+#define MT_EE_WIFI_CONF2_TX_PATH_BAND2		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF4_STREAM_NUM_BAND0	GENMASK(5, 3)
+#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND1	GENMASK(5, 3)
+#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND2	GENMASK(2, 0)
+
+#define MT_EE_RATE_DELTA_MASK			GENMASK(5, 0)
+#define MT_EE_RATE_DELTA_SIGN			BIT(6)
+#define MT_EE_RATE_DELTA_EN			BIT(7)
+
+enum mt7996_eeprom_band {
+	MT_EE_BAND_SEL_DEFAULT,
+	MT_EE_BAND_SEL_2GHZ,
+	MT_EE_BAND_SEL_5GHZ,
+	MT_EE_BAND_SEL_6GHZ,
+	MT_EE_BAND_SEL_5GHZ_6GHZ,
+};
+
+static inline int
+mt7996_get_channel_group_5g(int channel)
+{
+	if (channel <= 64)
+		return 0;
+	if (channel <= 96)
+		return 1;
+	if (channel <= 128)
+		return 2;
+	if (channel <= 144)
+		return 3;
+	return 4;
+}
+
+static inline int
+mt7996_get_channel_group_6g(int channel)
+{
+	if (channel <= 29)
+		return 0;
+
+	return DIV_ROUND_UP(channel - 29, 32);
+}
+
+#endif
-- 
2.25.1


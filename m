Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43725B02BF
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 13:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiIGLTr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 07:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIGLTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 07:19:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD7BF5C
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 04:19:34 -0700 (PDT)
X-UUID: 71c8402d79f64180a43b13b231d59740-20220907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Y/weUNVTeXkHK3Ei3kR2gerJit2E4l8QuYF9N4mNETg=;
        b=kCFb8jWBUNiE1rD9IUN9+JEnHqBmI9zgUAIzYm3NMIHTily8jx23aji8jRn3cDE63poGvHhGVkXhyn9NEThnh1SMEHFZvKjv6kJj+cmX6C6Nrek+8VY+QahDRhzQmlOkBzdWvOZiaGXBhDWEF2sj+y3sxG++t4y8GesdgFS6tl0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:6b85568e-84e4-4eec-bb9e-9f4c6649983d,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Relea
        se_Ham,ACTION:release,TS:70
X-CID-INFO: VERSION:1.1.10,REQID:6b85568e-84e4-4eec-bb9e-9f4c6649983d,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS
        981B3D,ACTION:quarantine,TS:70
X-CID-META: VersionHash:84eae18,CLOUDID:aef203d1-20bd-4e5e-ace8-00692b7ab380,C
        OID:ebb3b2f874da,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 71c8402d79f64180a43b13b231d59740-20220907
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1350626427; Wed, 07 Sep 2022 19:19:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Sep 2022 19:19:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Sep 2022 19:19:30 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v3] wifi: mt76: mt7921: introduce Country Location Control support
Date:   Wed, 7 Sep 2022 19:19:15 +0800
Message-ID: <5ee00f581cc108b606656a9e7cdfe32e47c0b6bb.1662549232.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Country Location Control (CLC) is an additional control for country rules
in firmware. We introduce this new feature to make sure mt7921 series
working properly in all region.

The addtional policies would be put into firmware based on differnt
regions. mt76 driver should be in charge of submitting per region policy.

Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: YN Chen <YN.Chen@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v3: Fix le16/cpu type problem, reported by kernel test robot <lkp@intel.com>
v2: 1. Run mt7921_load_clc() after MT76_STATE_MCU_RUNNING to make sure
       MCU-CMD ready, for all bus type
    2. Add tag Tested-by YN.Chen
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  11 +-
 .../wireless/mediatek/mt76/mt7921/eeprom.h    |   5 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 198 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |   2 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  30 +++
 6 files changed, 244 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f1d7c05bd794..718f427d8f6b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -10,6 +10,7 @@
 #define FW_FEATURE_SET_KEY_IDX		GENMASK(2, 1)
 #define FW_FEATURE_ENCRY_MODE		BIT(4)
 #define FW_FEATURE_OVERRIDE_ADDR	BIT(5)
+#define FW_FEATURE_NON_DL		BIT(6)
 
 #define DL_MODE_ENCRYPT			BIT(0)
 #define DL_MODE_KEY_IDX			GENMASK(2, 1)
@@ -33,6 +34,12 @@
 #define PATCH_SEC_ENC_SCRAMBLE_INFO_MASK	GENMASK(15, 0)
 #define PATCH_SEC_ENC_AES_KEY_MASK		GENMASK(7, 0)
 
+enum {
+	FW_TYPE_DEFAULT = 0,
+	FW_TYPE_CLC = 2,
+	FW_TYPE_MAX_NUM = 255
+};
+
 #define MCU_PQ_ID(p, q)		(((p) << 15) | ((q) << 10))
 #define MCU_PKT_ID		0xa0
 
@@ -174,7 +181,8 @@ struct mt76_connac2_fw_region {
 	__le32 addr;
 	__le32 len;
 	u8 feature_set;
-	u8 rsv1[15];
+	u8 type;
+	u8 rsv1[14];
 } __packed;
 
 struct tlv {
@@ -1172,6 +1180,7 @@ enum {
 	MCU_CE_CMD_SET_ROC = 0x1c,
 	MCU_CE_CMD_SET_EDCA_PARMS = 0x1d,
 	MCU_CE_CMD_SET_P2P_OPPPS = 0x33,
+	MCU_CE_CMD_SET_CLC = 0x5c,
 	MCU_CE_CMD_SET_RATE_TX_POWER = 0x5d,
 	MCU_CE_CMD_SCHED_SCAN_ENABLE = 0x61,
 	MCU_CE_CMD_SCHED_SCAN_REQ = 0x62,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
index 54f30401343c..4b647278eb30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
@@ -11,12 +11,15 @@ enum mt7921_eeprom_field {
 	MT_EE_VERSION =		0x002,
 	MT_EE_MAC_ADDR =	0x004,
 	MT_EE_WIFI_CONF =	0x07c,
-	__MT_EE_MAX =		0x3bf
+	MT_EE_HW_TYPE =		0x55b,
+	__MT_EE_MAX =		0x9ff
 };
 
 #define MT_EE_WIFI_CONF_TX_MASK			BIT(0)
 #define MT_EE_WIFI_CONF_BAND_SEL		GENMASK(3, 2)
 
+#define MT_EE_HW_TYPE_ENCAP			BIT(0)
+
 enum mt7921_eeprom_band {
 	MT_EE_NA,
 	MT_EE_5GHZ,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index cd960e23770f..dcdb3cf04ac1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -39,6 +39,7 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 	dev->mt76.region = request->dfs_region;
 
 	mt7921_mutex_acquire(dev);
+	mt7921_mcu_set_clc(dev, request->alpha2, request->country_ie_env);
 	mt76_connac_mcu_set_channel_domain(hw->priv);
 	mt7921_set_tx_sar_pwr(hw, NULL);
 	mt7921_mutex_release(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index da12d0ae0835..67bf92969a7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -2,14 +2,20 @@
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/fs.h>
+#include <linux/firmware.h>
 #include "mt7921.h"
 #include "mt7921_trace.h"
+#include "eeprom.h"
 #include "mcu.h"
 #include "mac.h"
 
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
 
+static bool mt7921_disable_clc;
+module_param_named(disable_clc, mt7921_disable_clc, bool, 0644);
+MODULE_PARM_DESC(disable_clc, "disable CLC support");
+
 static int
 mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 {
@@ -84,6 +90,27 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_parse_response);
 
+static int mt7921_mcu_read_eeprom(struct mt7921_dev *dev, u32 offset, u8 *val)
+{
+	struct mt7921_mcu_eeprom_info *res, req = {
+		.addr = cpu_to_le32(round_down(offset,
+				    MT7921_EEPROM_BLOCK_SIZE)),
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_QUERY(EFUSE_ACCESS),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	res = (struct mt7921_mcu_eeprom_info *)skb->data;
+	*val = res->data[offset % MT7921_EEPROM_BLOCK_SIZE];
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 
 static int
@@ -354,6 +381,90 @@ static char *mt7921_ram_name(struct mt7921_dev *dev)
 	return ret;
 }
 
+static int mt7921_load_clc(struct mt7921_dev *dev, const char *fw_name)
+{
+	const struct mt76_connac2_fw_trailer *hdr;
+	const struct mt76_connac2_fw_region *region;
+	const struct mt7921_clc *clc;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt7921_phy *phy = &dev->phy;
+	const struct firmware *fw;
+	int ret, i, len, offset = 0;
+	u8 *clc_base = NULL, hw_encap = 0;
+
+	if (mt7921_disable_clc ||
+	    mt76_is_usb(&dev->mt76))
+		return 0;
+
+	if (mt76_is_mmio(&dev->mt76)) {
+		ret = mt7921_mcu_read_eeprom(dev, MT_EE_HW_TYPE, &hw_encap);
+		if (ret)
+			return ret;
+		hw_encap = u8_get_bits(hw_encap, MT_EE_HW_TYPE_ENCAP);
+	}
+
+	ret = request_firmware(&fw, fw_name, mdev->dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(mdev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+	for (i = 0; i < hdr->n_region; i++) {
+		region = (const void *)((const u8 *)hdr -
+					(hdr->n_region - i) * sizeof(*region));
+		len = le32_to_cpu(region->len);
+
+		/* check if we have valid buffer size */
+		if (offset + len > fw->size) {
+			dev_err(mdev->dev, "Invalid firmware region\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if ((region->feature_set & FW_FEATURE_NON_DL) &&
+		    region->type == FW_TYPE_CLC) {
+			clc_base = (u8 *)(fw->data + offset);
+			break;
+		}
+		offset += len;
+	}
+
+	if (!clc_base)
+		goto out;
+
+	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
+		clc = (const struct mt7921_clc *)(clc_base + offset);
+
+		/* do not init buf again if chip reset triggered */
+		if (phy->clc[clc->idx])
+			continue;
+
+		/* header content sanity */
+		if (clc->idx == MT7921_CLC_POWER &&
+		    u8_get_bits(clc->type, MT_EE_HW_TYPE_ENCAP) != hw_encap)
+			continue;
+
+		phy->clc[clc->idx] = devm_kmemdup(mdev->dev, clc,
+						  le32_to_cpu(clc->len),
+						  GFP_KERNEL);
+
+		if (!phy->clc[clc->idx]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+	ret = mt7921_mcu_set_clc(dev, "00", ENVIRON_INDOOR);
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
 static int mt7921_load_firmware(struct mt7921_dev *dev)
 {
 	int ret;
@@ -423,6 +534,10 @@ int mt7921_run_firmware(struct mt7921_dev *dev)
 		return err;
 
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+	err = mt7921_load_clc(dev, mt7921_ram_name(dev));
+	if (err)
+		return err;
+
 	return mt7921_mcu_fw_log_2_host(dev, 1);
 }
 EXPORT_SYMBOL_GPL(mt7921_run_firmware);
@@ -930,3 +1045,86 @@ mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
 				 &req, sizeof(req), true);
 }
+
+static
+int __mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
+			 enum environment_cap env_cap,
+			 struct mt7921_clc *clc,
+			 u8 idx)
+{
+	struct sk_buff *skb;
+	struct {
+		u8 ver;
+		u8 pad0;
+		__le16 len;
+		u8 idx;
+		u8 env;
+		u8 pad1[2];
+		u8 alpha2[2];
+		u8 type[2];
+		u8 rsvd[64];
+	} __packed req = {
+		.idx = idx,
+		.env = env_cap,
+	};
+	int ret, valid_cnt = 0;
+	u8 i, *pos;
+
+	if (!clc)
+		return 0;
+
+	pos = clc->data;
+	for (i = 0; i < clc->nr_country; i++) {
+		struct mt7921_clc_rule *rule = (struct mt7921_clc_rule *)pos;
+		u16 len = le16_to_cpu(rule->len);
+
+		pos += len + sizeof(*rule);
+		if (rule->alpha2[0] != alpha2[0] ||
+		    rule->alpha2[1] != alpha2[1])
+			continue;
+
+		memcpy(req.alpha2, rule->alpha2, 2);
+		memcpy(req.type, rule->type, 2);
+
+		req.len = cpu_to_le16(sizeof(req) + len);
+		skb = __mt76_mcu_msg_alloc(&dev->mt76, &req,
+					   le16_to_cpu(req.len),
+					   sizeof(req), GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+		skb_put_data(skb, rule->data, len);
+
+		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+					    MCU_CE_CMD(SET_CLC), false);
+		if (ret < 0)
+			return ret;
+		valid_cnt++;
+	}
+
+	if (!valid_cnt)
+		return -ENOENT;
+
+	return 0;
+}
+
+int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
+		       enum environment_cap env_cap)
+{
+	struct mt7921_phy *phy = (struct mt7921_phy *)&dev->phy;
+	int i, ret;
+
+	/* submit all clc config */
+	for (i = 0; i < ARRAY_SIZE(phy->clc); i++) {
+		ret = __mt7921_mcu_set_clc(dev, alpha2, env_cap,
+					   phy->clc[i], i);
+
+		/* If no country found, set "00" as default */
+		if (ret == -ENOENT)
+			ret = __mt7921_mcu_set_clc(dev, "00",
+						   ENVIRON_INDOOR,
+						   phy->clc[i], i);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 0d20f7d8d474..96dc870fd35e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -41,7 +41,7 @@ enum {
 struct mt7921_mcu_eeprom_info {
 	__le32 addr;
 	__le32 valid;
-	u8 data[16];
+	u8 data[MT7921_EEPROM_BLOCK_SIZE];
 } __packed;
 
 #define MT_RA_RATE_NSS			GENMASK(8, 6)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c161031ac62a..b665c84b109e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -41,6 +41,8 @@
 #define MT7921_EEPROM_SIZE		3584
 #define MT7921_TOKEN_SIZE		8192
 
+#define MT7921_EEPROM_BLOCK_SIZE	16
+
 #define MT7921_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
 #define MT7921_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
 
@@ -149,6 +151,29 @@ struct mib_stats {
 	u32 tx_amsdu_cnt;
 };
 
+enum {
+	MT7921_CLC_POWER,
+	MT7921_CLC_CHAN,
+	MT7921_CLC_MAX_NUM,
+};
+
+struct mt7921_clc_rule {
+	u8 alpha2[2];
+	u8 type[2];
+	__le16 len;
+	u8 data[];
+} __packed;
+
+struct mt7921_clc {
+	__le32 len;
+	u8 idx;
+	u8 ver;
+	u8 nr_country;
+	u8 type;
+	u8 rsv[8];
+	u8 data[];
+};
+
 struct mt7921_phy {
 	struct mt76_phy *mt76;
 	struct mt7921_dev *dev;
@@ -174,6 +199,8 @@ struct mt7921_phy {
 #ifdef CONFIG_ACPI
 	struct mt7921_acpi_sar *acpisar;
 #endif
+
+	struct mt7921_clc *clc[MT7921_CLC_MAX_NUM];
 };
 
 #define mt7921_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
@@ -479,4 +506,7 @@ mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
 #endif
 int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 			  const struct cfg80211_sar_specs *sar);
+
+int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
+		       enum environment_cap env_cap);
 #endif
-- 
2.18.0


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139DB62B1B3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 04:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiKPDLS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Nov 2022 22:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKPDLR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Nov 2022 22:11:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F2E26127
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 19:11:11 -0800 (PST)
X-UUID: 4a3a84b2eac04e84b7ed03031618d987-20221116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VzDz/+70YbgE00/1Gai8ilawJ6uOuWm7ra01FRi9P2I=;
        b=AQs/mrTIXtIUK45oe93rVSKFfoxWt5Gf28r6NpLltqTD9G4SZZ4Y6+kvHxwDSIY+jTSyEw3e1mBsz5ogR40xIiCCwDi/Pe/v3D0gIlHbtlxoStkROaTaR8cj+QFzZv9t/qDKuJB2/EzfAw+O+7bNUctkzw/VldEOOv5emf0uJlk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:9c18bd78-8898-4f6a-8967-d2606b3d6303,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.12,REQID:9c18bd78-8898-4f6a-8967-d2606b3d6303,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:62cd327,CLOUDID:804a9df3-9094-45e8-b6eb-26f09041f731,B
        ulkID:2211161111039UZAMFZV,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4a3a84b2eac04e84b7ed03031618d987-20221116
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 611673214; Wed, 16 Nov 2022 11:11:02 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 16 Nov 2022 11:11:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 16 Nov 2022 11:11:00 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7915: add support to configure spatial reuse parameter set
Date:   Wed, 16 Nov 2022 11:10:59 +0800
Message-ID: <d621ab20b71d57bb0ca829c51a30b88fe4ce1837.1668566645.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The SPR parameter set comprises OBSS PD threshold for SRG and
non SRG and Bitmap of BSS color and partial BSSID. This adds
support to configure fields of SPR element to firmware.

User can disable firmware SR algorithms by turning sr_scene_detect off.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 196 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  22 ++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   4 +-
 4 files changed, 207 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3933f4f2d71d..a29cbdb47801 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -601,10 +601,8 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		mt7915_mcu_add_sta(dev, vif, NULL, join);
 	}
 
-	if (changed & BSS_CHANGED_ASSOC) {
+	if (changed & BSS_CHANGED_ASSOC)
 		mt7915_mcu_add_bss_info(phy, vif, vif->cfg.assoc);
-		mt7915_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
-	}
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT)
 		mt7915_mac_enable_rtscts(dev, vif, info->use_cts_prot);
@@ -628,7 +626,7 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		mt7915_mcu_set_tx(dev, vif);
 
 	if (changed & BSS_CHANGED_HE_OBSS_PD)
-		mt7915_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
+		mt7915_mcu_add_obss_spr(phy, vif, &info->he_obss_pd);
 
 	if (changed & BSS_CHANGED_HE_BSS_COLOR)
 		mt7915_update_bss_color(hw, vif, &info->he_bss_color);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 8b903a7636a8..b54453b5ee5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -32,6 +32,9 @@
 #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
 #define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
 
+static bool sr_scene_detect = true;
+module_param(sr_scene_detect, bool, 0644);
+
 static u8
 mt7915_mcu_get_sta_nss(u16 mcs_map)
 {
@@ -3270,31 +3273,194 @@ int mt7915_mcu_set_txbf(struct mt7915_dev *dev, u8 action)
 				 sizeof(req), true);
 }
 
-int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-			    bool enable)
+static int
+mt7915_mcu_enable_obss_spr(struct mt7915_phy *phy, u8 action, u8 val)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct mt7915_mcu_sr_ctrl req = {
+		.action = action,
+		.argnum = 1,
+		.band_idx = phy != &dev->phy,
+		.val = cpu_to_le32(val),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_SPR), &req,
+				 sizeof(req), true);
+}
+
+static int
+mt7915_mcu_set_obss_spr_pd(struct mt7915_phy *phy,
+			   struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct {
+		struct mt7915_mcu_sr_ctrl ctrl;
+		struct {
+			u8 pd_th_non_srg;
+			u8 pd_th_srg;
+			u8 period_offs;
+			u8 rcpi_src;
+
+			/* for firmware PD algorithm */
+			__le16 obss_pd_min;
+			__le16 obss_pd_min_srg;
+
+			u8 resp_txpwr_mode;
+			u8 txpwr_restrict_mode;
+			u8 txpwr_ref;
+			u8 rsv[3];
+		} __packed param;
+	} __packed req = {
+		.ctrl = {
+			.action = SPR_SET_PARAM,
+			.argnum = 9,
+			.band_idx = phy != &dev->phy,
+		},
+	};
+	int ret;
+	u8 max_th = 82, non_srg_max_th = 62;
+
+	/* disable firmware dynamical PD asjustment */
+	ret = mt7915_mcu_enable_obss_spr(phy, SPR_ENABLE_DPD, false);
+	if (ret)
+		return ret;
+
+	if (he_obss_pd->sr_ctrl &
+	    IEEE80211_HE_SPR_NON_SRG_OBSS_PD_SR_DISALLOWED)
+		req.param.pd_th_non_srg = max_th;
+	else if (he_obss_pd->sr_ctrl & IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
+		req.param.pd_th_non_srg  = max_th - he_obss_pd->non_srg_max_offset;
+	else
+		req.param.pd_th_non_srg  = non_srg_max_th;
+
+	if (he_obss_pd->sr_ctrl & IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT)
+		req.param.pd_th_srg = max_th - he_obss_pd->max_offset;
+
+	req.param.txpwr_restrict_mode = 0x2;
+	req.param.txpwr_ref = 0x2a;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_SPR), &req,
+				 sizeof(req), true);
+}
+
+static int
+mt7915_mcu_set_obss_spr_siga(struct mt7915_phy *phy, struct ieee80211_vif *vif,
+			     struct ieee80211_he_obss_pd *he_obss_pd)
 {
-#define MT_SPR_ENABLE		1
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_dev *dev = phy->dev;
+	u8 omac = mvif->mt76.omac_idx;
 	struct {
-		u8 action;
-		u8 arg_num;
-		u8 band_idx;
-		u8 status;
-		u8 drop_tx_idx;
-		u8 sta_idx;	/* 256 sta */
-		u8 rsv[2];
-		__le32 val;
+		struct mt7915_mcu_sr_ctrl ctrl;
+		struct {
+			u8 omac;
+			u8 rsv[3];
+			u8 flag[20];
+		} __packed siga;
+	} __packed req = {
+		.ctrl = {
+			.action = SPR_SET_SIGA,
+			.argnum = 1,
+			.band_idx = phy != &dev->phy,
+		},
+		.siga = {
+			.omac = omac > HW_BSSID_MAX ? omac - 12 : omac,
+		},
+	};
+	int ret;
+
+	if (he_obss_pd->sr_ctrl & IEEE80211_HE_SPR_HESIGA_SR_VAL15_ALLOWED)
+		req.siga.flag[req.siga.omac] = 0xf;
+	else
+		return 0;
+
+	/* switch to normal AP mode */
+	ret = mt7915_mcu_enable_obss_spr(phy, SPR_ENABLE_MODE, 0);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_SPR), &req,
+				 sizeof(req), true);
+}
+
+static int
+mt7915_mcu_set_obss_spr_bitmap(struct mt7915_phy *phy,
+			       struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct {
+		struct mt7915_mcu_sr_ctrl ctrl;
+		struct {
+			__le32 color_l[2];
+			__le32 color_h[2];
+			__le32 bssid_l[2];
+			__le32 bssid_h[2];
+		} __packed bitmap;
 	} __packed req = {
-		.action = MT_SPR_ENABLE,
-		.arg_num = 1,
-		.band_idx = mvif->mt76.band_idx,
-		.val = cpu_to_le32(enable),
+		.ctrl = {
+			.action = SPR_SET_SRG_BITMAP,
+			.argnum = 4,
+			.band_idx = phy != &dev->phy,
+		},
 	};
+	u32 bitmap;
+
+	memcpy(&bitmap, he_obss_pd->bss_color_bitmap, sizeof(bitmap));
+	req.bitmap.color_l[req.ctrl.band_idx] = cpu_to_le32(bitmap);
+
+	memcpy(&bitmap, he_obss_pd->bss_color_bitmap + 4, sizeof(bitmap));
+	req.bitmap.color_h[req.ctrl.band_idx] = cpu_to_le32(bitmap);
+
+	memcpy(&bitmap, he_obss_pd->partial_bssid_bitmap, sizeof(bitmap));
+	req.bitmap.bssid_l[req.ctrl.band_idx] = cpu_to_le32(bitmap);
+
+	memcpy(&bitmap, he_obss_pd->partial_bssid_bitmap + 4, sizeof(bitmap));
+	req.bitmap.bssid_h[req.ctrl.band_idx] = cpu_to_le32(bitmap);
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_SPR), &req,
 				 sizeof(req), true);
 }
 
+int mt7915_mcu_add_obss_spr(struct mt7915_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	int ret;
+
+	/* enable firmware scene detection algorithms */
+	ret = mt7915_mcu_enable_obss_spr(phy, SPR_ENABLE_SD, sr_scene_detect);
+	if (ret)
+		return ret;
+
+	/* enable spatial reuse */
+	ret = mt7915_mcu_enable_obss_spr(phy, SPR_ENABLE, he_obss_pd->enable);
+	if (ret)
+		return ret;
+
+	if (!he_obss_pd->enable)
+		return 0;
+
+	ret = mt7915_mcu_enable_obss_spr(phy, SPR_ENABLE_TX, true);
+	if (ret)
+		return ret;
+
+	/* firmware dynamically adjusts PD threshold so skip manual control */
+	if (sr_scene_detect)
+		return 0;
+
+	/* set SRG/non-SRG OBSS PD threshold */
+	ret = mt7915_mcu_set_obss_spr_pd(phy, he_obss_pd);
+	if (ret)
+		return ret;
+
+	/* Set SR prohibit */
+	ret = mt7915_mcu_set_obss_spr_siga(phy, vif, he_obss_pd);
+	if (ret)
+		return ret;
+
+	/* set SRG BSS color/BSSID bitmap */
+	return mt7915_mcu_set_obss_spr_bitmap(phy, he_obss_pd);
+}
+
 int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index c19b5d66c0e1..2fc09fd53777 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -129,6 +129,17 @@ struct mt7915_mcu_background_chain_ctrl {
 	u8 rsv[2];
 } __packed;
 
+struct mt7915_mcu_sr_ctrl {
+	u8 action;
+	u8 argnum;
+	u8 band_idx;
+	u8 status;
+	u8 drop_ta_idx;
+	u8 sta_idx;	/* 256 sta */
+	u8 rsv[2];
+	__le32 val;
+} __packed;
+
 struct mt7915_mcu_eeprom {
 	u8 buffer_mode;
 	u8 format;
@@ -408,6 +419,17 @@ enum {
 #define RATE_CFG_PHY_TYPE		GENMASK(27, 24)
 #define RATE_CFG_HE_LTF			GENMASK(31, 28)
 
+enum {
+	SPR_ENABLE = 0x1,
+	SPR_ENABLE_SD = 0x3,
+	SPR_ENABLE_MODE = 0x5,
+	SPR_ENABLE_DPD = 0x23,
+	SPR_ENABLE_TX = 0x25,
+	SPR_SET_SRG_BITMAP = 0x80,
+	SPR_SET_PARAM = 0xc2,
+	SPR_SET_SIGA = 0xdc,
+};
+
 enum {
 	THERMAL_PROTECT_PARAMETER_CTRL,
 	THERMAL_PROTECT_BASIC_INFO,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 9cb680e7f223..0bad78cf32c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -501,8 +501,8 @@ int mt7915_mcu_update_bss_color(struct mt7915_dev *dev, struct ieee80211_vif *vi
 				struct cfg80211_he_bss_color *he_bss_color);
 int mt7915_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  int enable, u32 changed);
-int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-                            bool enable);
+int mt7915_mcu_add_obss_spr(struct mt7915_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_he_obss_pd *he_obss_pd);
 int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta, bool changed);
 int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
-- 
2.36.1


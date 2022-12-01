Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D49963E86A
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 04:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLADpB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 22:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLADo7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 22:44:59 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E18790770
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 19:44:56 -0800 (PST)
X-UUID: e497b6f1f0084e47ae8fc8b567d62396-20221201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fUqegibYqobSEIYdGjz7sjpr1BoCzzIkXCuaWq1saXk=;
        b=iiHTO3PlFmAKaeOq2jB1VaX/jV9FyotAxbpdxv/rRHayLcS35LTd+GGexRuJbfKaacrurOz/zxhqrsBmCEP+Biztj3xDvaz0+PpSZB+RLfibFySJRI4LQvHveMKQFfK84U98e3mLIU2jN3Aj8hbY+Y50eXpdX7q3z9SGNEwzTLo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:cb5c0fe2-a7ac-4f9e-8e2f-060e44829da2,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:5750d01e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e497b6f1f0084e47ae8fc8b567d62396-20221201
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1165522448; Thu, 01 Dec 2022 11:44:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Dec 2022 11:44:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 1 Dec 2022 11:44:48 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 5/5] wifi: mt76: mt7996: add support to configure spatial reuse parameter set
Date:   Thu, 1 Dec 2022 11:44:44 +0800
Message-ID: <a3da2c944e064811fe82c914dfa82f01a8294d48.1669861864.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <d1c11adff6b57c9104bb16df19f62700e2505473.1669861862.git.ryder.lee@mediatek.com>
References: <d1c11adff6b57c9104bb16df19f62700e2505473.1669861862.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
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
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 191 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   |   7 +
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |   4 +-
 4 files changed, 195 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f2129be25d99..4421cd54311b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -518,10 +518,8 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 		mt7996_mcu_add_sta(dev, vif, NULL, join);
 	}
 
-	if (changed & BSS_CHANGED_ASSOC) {
+	if (changed & BSS_CHANGED_ASSOC)
 		mt7996_mcu_add_bss_info(phy, vif, vif->cfg.assoc);
-		mt7996_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
-	}
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT)
 		mt7996_mac_enable_rtscts(dev, vif, info->use_cts_prot);
@@ -545,7 +543,7 @@ static void mt7996_bss_info_changed(struct ieee80211_hw *hw,
 		mt7996_mcu_set_tx(dev, vif);
 
 	if (changed & BSS_CHANGED_HE_OBSS_PD)
-		mt7996_mcu_add_obss_spr(dev, vif, info->he_obss_pd.enable);
+		mt7996_mcu_add_obss_spr(phy, vif, &info->he_obss_pd);
 
 	if (changed & BSS_CHANGED_HE_BSS_COLOR)
 		mt7996_update_bss_color(hw, vif, &info->he_bss_color);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8193af0982f7..957f59f9ad80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -71,6 +71,10 @@ struct mt7996_fw_region {
 #define HE_PHY(p, c)			u8_get_bits(c, IEEE80211_HE_PHY_##p)
 #define HE_MAC(m, c)			u8_get_bits(c, IEEE80211_HE_MAC_##m)
 
+static bool sr_scene_detect = true;
+module_param(sr_scene_detect, bool, 0644);
+MODULE_PARM_DESC(sr_scene_detect, "Enable firmware scene detection algorithm");
+
 static u8
 mt7996_mcu_get_sta_nss(u16 mcs_map)
 {
@@ -3123,29 +3127,202 @@ int mt7996_mcu_set_txbf(struct mt7996_dev *dev, u8 action)
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_WM_UNI_CMD(BF), true);
 }
 
-int mt7996_mcu_add_obss_spr(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			    bool enable)
+int mt7996_mcu_enable_obss_spr(struct mt7996_phy *phy, u16 action, u8 val)
 {
-#define MT_SPR_ENABLE		1
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = phy->dev;
 	struct {
 		u8 band_idx;
 		u8 __rsv[3];
 
 		__le16 tag;
 		__le16 len;
+
 		__le32 val;
 	} __packed req = {
-		.band_idx = mvif->mt76.band_idx,
-		.tag = cpu_to_le16(UNI_CMD_SR_ENABLE),
+		.band_idx = phy->mt76->band_idx,
+		.tag = cpu_to_le16(action),
 		.len = cpu_to_le16(sizeof(req) - 4),
-		.val = cpu_to_le32(enable),
+		.val = cpu_to_le32(val),
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(SR),
 				 &req, sizeof(req), true);
 }
 
+static int
+mt7996_mcu_set_obss_spr_pd(struct mt7996_phy *phy,
+			   struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	struct mt7996_dev *dev = phy->dev;
+	u8 max_th = 82, non_srg_max_th = 62;
+	struct {
+		u8 band_idx;
+		u8 __rsv[3];
+
+		__le16 tag;
+		__le16 len;
+
+		u8 pd_th_non_srg;
+		u8 pd_th_srg;
+		u8 period_offs;
+		u8 rcpi_src;
+		__le16 obss_pd_min;
+		__le16 obss_pd_min_srg;
+		u8 resp_txpwr_mode;
+		u8 txpwr_restrict_mode;
+		u8 txpwr_ref;
+		u8 __rsv2[3];
+	} __packed req = {
+		.band_idx = phy->mt76->band_idx,
+		.tag = cpu_to_le16(UNI_CMD_SR_SET_PARAM),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.obss_pd_min = cpu_to_le16(max_th),
+		.obss_pd_min_srg = cpu_to_le16(max_th),
+		.txpwr_restrict_mode = 2,
+		.txpwr_ref = 21
+	};
+	int ret;
+
+	/* disable firmware dynamical PD asjustment */
+	ret = mt7996_mcu_enable_obss_spr(phy, UNI_CMD_SR_ENABLE_DPD, false);
+	if (ret)
+		return ret;
+
+	if (he_obss_pd->sr_ctrl &
+	    IEEE80211_HE_SPR_NON_SRG_OBSS_PD_SR_DISALLOWED)
+		req.pd_th_non_srg = max_th;
+	else if (he_obss_pd->sr_ctrl & IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
+		req.pd_th_non_srg  = max_th - he_obss_pd->non_srg_max_offset;
+	else
+		req.pd_th_non_srg  = non_srg_max_th;
+
+	if (he_obss_pd->sr_ctrl & IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT)
+		req.pd_th_srg = max_th - he_obss_pd->max_offset;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(SR),
+				 &req, sizeof(req), true);
+}
+
+static int
+mt7996_mcu_set_obss_spr_siga(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			     struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_dev *dev = phy->dev;
+	u8 omac = mvif->mt76.omac_idx;
+	struct {
+		u8 band_idx;
+		u8 __rsv[3];
+
+		__le16 tag;
+		__le16 len;
+
+		u8 omac;
+		u8 __rsv2[3];
+		u8 flag[20];
+	} __packed req = {
+		.band_idx = phy->mt76->band_idx,
+		.tag = cpu_to_le16(UNI_CMD_SR_SET_SIGA),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.omac = omac > HW_BSSID_MAX ? omac - 12 : omac,
+	};
+	int ret;
+
+	if (he_obss_pd->sr_ctrl & IEEE80211_HE_SPR_HESIGA_SR_VAL15_ALLOWED)
+		req.flag[req.omac] = 0xf;
+	else
+		return 0;
+
+	/* switch to normal AP mode */
+	ret = mt7996_mcu_enable_obss_spr(phy, UNI_CMD_SR_ENABLE_MODE, 0);
+	if (ret)
+		return ret;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(SR),
+				 &req, sizeof(req), true);
+}
+
+static int
+mt7996_mcu_set_obss_spr_bitmap(struct mt7996_phy *phy,
+			       struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct {
+		u8 band_idx;
+		u8 __rsv[3];
+
+		__le16 tag;
+		__le16 len;
+
+		__le32 color_l[2];
+		__le32 color_h[2];
+		__le32 bssid_l[2];
+		__le32 bssid_h[2];
+	} __packed req = {
+		.band_idx = phy->mt76->band_idx,
+		.tag = cpu_to_le16(UNI_CMD_SR_SET_SRG_BITMAP),
+		.len = cpu_to_le16(sizeof(req) - 4),
+	};
+	u32 bitmap;
+
+	memcpy(&bitmap, he_obss_pd->bss_color_bitmap, sizeof(bitmap));
+	req.color_l[req.band_idx] = cpu_to_le32(bitmap);
+
+	memcpy(&bitmap, he_obss_pd->bss_color_bitmap + 4, sizeof(bitmap));
+	req.color_h[req.band_idx] = cpu_to_le32(bitmap);
+
+	memcpy(&bitmap, he_obss_pd->partial_bssid_bitmap, sizeof(bitmap));
+	req.bssid_l[req.band_idx] = cpu_to_le32(bitmap);
+
+	memcpy(&bitmap, he_obss_pd->partial_bssid_bitmap + 4, sizeof(bitmap));
+	req.bssid_h[req.band_idx] = cpu_to_le32(bitmap);
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(SR), &req,
+				 sizeof(req), true);
+}
+
+int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	int ret;
+
+	/* enable firmware scene detection algorithms */
+	ret = mt7996_mcu_enable_obss_spr(phy, UNI_CMD_SR_ENABLE_SD,
+					 sr_scene_detect);
+	if (ret)
+		return ret;
+
+	/* firmware dynamically adjusts PD threshold so skip manual control */
+	if (sr_scene_detect && !he_obss_pd->enable)
+		return 0;
+
+	/* enable spatial reuse */
+	ret = mt7996_mcu_enable_obss_spr(phy, UNI_CMD_SR_ENABLE,
+					 he_obss_pd->enable);
+	if (ret)
+		return ret;
+
+	if (sr_scene_detect || !he_obss_pd->enable)
+		return 0;
+
+	ret = mt7996_mcu_enable_obss_spr(phy, UNI_CMD_SR_ENABLE_TX, true);
+	if (ret)
+		return ret;
+
+	/* set SRG/non-SRG OBSS PD threshold */
+	ret = mt7996_mcu_set_obss_spr_pd(phy, he_obss_pd);
+	if (ret)
+		return ret;
+
+	/* Set SR prohibit */
+	ret = mt7996_mcu_set_obss_spr_siga(phy, vif, he_obss_pd);
+	if (ret)
+		return ret;
+
+	/* set SRG BSS color/BSSID bitmap */
+	return mt7996_mcu_set_obss_spr_bitmap(phy, he_obss_pd);
+}
+
 int mt7996_mcu_update_bss_color(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 				struct cfg80211_he_bss_color *he_bss_color)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index ff12a7168bd8..6084b2337598 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -617,6 +617,13 @@ enum {
 
 enum{
 	UNI_CMD_SR_ENABLE = 0x1,
+	UNI_CMD_SR_ENABLE_SD,
+	UNI_CMD_SR_ENABLE_MODE,
+	UNI_CMD_SR_ENABLE_DPD = 0x12,
+	UNI_CMD_SR_ENABLE_TX,
+	UNI_CMD_SR_SET_SRG_BITMAP = 0x80,
+	UNI_CMD_SR_SET_PARAM = 0xc1,
+	UNI_CMD_SR_SET_SIGA = 0xd0,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 17dcd05d3459..725344791b4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -407,8 +407,8 @@ int mt7996_mcu_add_beacon(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  int enable);
 int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 				    struct ieee80211_vif *vif, u32 changed);
-int mt7996_mcu_add_obss_spr(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-			    bool enable);
+int mt7996_mcu_add_obss_spr(struct mt7996_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_he_obss_pd *he_obss_pd);
 int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta, bool changed);
 int mt7996_set_channel(struct mt7996_phy *phy);
-- 
2.18.0


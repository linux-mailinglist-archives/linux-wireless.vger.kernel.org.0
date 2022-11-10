Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D09624CEC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 22:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiKJVZF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 16:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiKJVYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 16:24:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE9745ED8
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 13:24:03 -0800 (PST)
X-UUID: 0acd09ff32b14c1c8ca175e116681ae8-20221111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=63Z+xk8BmPcO1jTwGwmNyOpt9akHnNa2h1PwHeZ/hWU=;
        b=RcH0INZpWQGMQkfvtEMaOSHT9sifQ61d3IRTMWvSMvGh67CmrXoopiw9eOib083O+BLZda7gCSouRauUGYr8WEncxOMF6Kw1GzfTC+eIpr1HwWPQaZA80icR4Jt4ZOL2UEu5h7gZ82+fWbA02U4PeVZ0412mXtHJCz/yDMFSSY4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:641c49f0-a250-4e63-9f42-dfe397535c2d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:1327ef85-088c-4756-8f76-577be701e693,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0acd09ff32b14c1c8ca175e116681ae8-20221111
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1683049268; Fri, 11 Nov 2022 05:23:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 11 Nov 2022 05:23:56 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 11 Nov 2022 05:23:56 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 1/7] wifi: mt76: connac: add mt76_connac_mcu_uni_set_chctx
Date:   Fri, 11 Nov 2022 05:23:43 +0800
Message-ID: <a6a20f55b9f7d8b2a89c9c8ac69003440d400f0c.1668068326.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1668068326.git.objelf@gmail.com>
References: <cover.1668068326.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add mt76_connac_mcu_uni_set_chctx to set up the channel context per BSS
in the firmware

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 147 ++++++++++--------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   3 +
 2 files changed, 82 insertions(+), 68 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 011fc9729b38..4b12d65dc076 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1313,44 +1313,13 @@ mt76_connac_mcu_uni_bss_he_tlv(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
 }
 
-int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
-				struct ieee80211_vif *vif,
-				struct mt76_wcid *wcid,
-				bool enable)
+int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+				  struct ieee80211_chanctx_conf *ctx)
 {
-	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &phy->chandef;
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
 	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_dev *mdev = phy->dev;
-	struct {
-		struct {
-			u8 bss_idx;
-			u8 pad[3];
-		} __packed hdr;
-		struct mt76_connac_bss_basic_tlv basic;
-		struct mt76_connac_bss_qos_tlv qos;
-	} basic_req = {
-		.hdr = {
-			.bss_idx = mvif->idx,
-		},
-		.basic = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
-			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_basic_tlv)),
-			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
-			.dtim_period = vif->bss_conf.dtim_period,
-			.omac_idx = mvif->omac_idx,
-			.band_idx = mvif->band_idx,
-			.wmm_idx = mvif->wmm_idx,
-			.active = true, /* keep bss deactivated */
-			.phymode = mt76_connac_get_phy_mode(phy, vif, band, NULL),
-		},
-		.qos = {
-			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
-			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_qos_tlv)),
-			.qos = vif->bss_conf.qos,
-		},
-	};
 	struct {
 		struct {
 			u8 bss_idx;
@@ -1388,6 +1357,81 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			.band = band,
 		},
 	};
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_40:
+		rlm_req.rlm.bw = CMD_CBW_40MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		rlm_req.rlm.bw = CMD_CBW_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+		rlm_req.rlm.bw = CMD_CBW_8080MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		rlm_req.rlm.bw = CMD_CBW_160MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_5:
+		rlm_req.rlm.bw = CMD_CBW_5MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_10:
+		rlm_req.rlm.bw = CMD_CBW_10MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+	default:
+		rlm_req.rlm.bw = CMD_CBW_20MHZ;
+		rlm_req.rlm.ht_op_info = 0;
+		break;
+	}
+
+	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 1; /* SCA */
+	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
+		rlm_req.rlm.sco = 3; /* SCB */
+
+	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE), &rlm_req,
+				 sizeof(rlm_req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_set_chctx);
+
+int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
+				struct ieee80211_vif *vif,
+				struct mt76_wcid *wcid,
+				bool enable)
+{
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &phy->chandef;
+	enum nl80211_band band = chandef->chan->band;
+	struct mt76_dev *mdev = phy->dev;
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_bss_basic_tlv basic;
+		struct mt76_connac_bss_qos_tlv qos;
+	} basic_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_basic_tlv)),
+			.bcn_interval = cpu_to_le16(vif->bss_conf.beacon_int),
+			.dtim_period = vif->bss_conf.dtim_period,
+			.omac_idx = mvif->omac_idx,
+			.band_idx = mvif->band_idx,
+			.wmm_idx = mvif->wmm_idx,
+			.active = true, /* keep bss deactivated */
+			.phymode = mt76_connac_get_phy_mode(phy, vif, band, NULL),
+		},
+		.qos = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_QBSS),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_qos_tlv)),
+			.qos = vif->bss_conf.qos,
+		},
+	};
 	int err, conn_type;
 	u8 idx, basic_phy;
 
@@ -1474,40 +1518,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 			return err;
 	}
 
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_40:
-		rlm_req.rlm.bw = CMD_CBW_40MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_80:
-		rlm_req.rlm.bw = CMD_CBW_80MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_80P80:
-		rlm_req.rlm.bw = CMD_CBW_8080MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		rlm_req.rlm.bw = CMD_CBW_160MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_5:
-		rlm_req.rlm.bw = CMD_CBW_5MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_10:
-		rlm_req.rlm.bw = CMD_CBW_10MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_20_NOHT:
-	case NL80211_CHAN_WIDTH_20:
-	default:
-		rlm_req.rlm.bw = CMD_CBW_20MHZ;
-		rlm_req.rlm.ht_op_info = 0;
-		break;
-	}
-
-	if (rlm_req.rlm.control_channel < rlm_req.rlm.center_chan)
-		rlm_req.rlm.sco = 1; /* SCA */
-	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
-		rlm_req.rlm.sco = 3; /* SCB */
-
-	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE), &rlm_req,
-				 sizeof(rlm_req), true);
+	return mt76_connac_mcu_uni_set_chctx(phy, mvif, NULL);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_bss);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index cf4ce3b1fc21..b7e29b177a6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1736,6 +1736,9 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 			   struct ieee80211_ampdu_params *params,
 			   int cmd, bool enable, bool tx);
+int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy,
+				  struct mt76_vif *vif,
+				  struct ieee80211_chanctx_conf *ctx);
 int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				struct ieee80211_vif *vif,
 				struct mt76_wcid *wcid,
-- 
2.25.1


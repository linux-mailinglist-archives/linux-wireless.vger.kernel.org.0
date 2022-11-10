Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F31624CEE
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 22:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiKJVZI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 16:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiKJVYj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 16:24:39 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B51B5E9F9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 13:24:10 -0800 (PST)
X-UUID: 443fcf928b8b41d79515918b413c4a77-20221111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ukrpjAtV5q41Z5KOBVuOWSW1ODCEyS4q5z+TXMdsO6k=;
        b=LSQmGCGAOY2wxFEjSzWrEidAESF1tpFj+k8cdcL/tVu+Y5Ht4tY7XT1OJFtVJlT9kALiJT03LjYNn8xvvdYjct9ffCd2ccMVKNPlRUZS+3fn7X4lAGYW6VdZI5Z4MPiK2RdwcqlNAN6hv4fPyw44Tjgb/9hEUB8+/d+8RllU2oI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:2ef2bdf6-1acb-40fa-a1b8-eded977b7388,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:2ef2bdf6-1acb-40fa-a1b8-eded977b7388,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:4c27ef85-088c-4756-8f76-577be701e693,B
        ulkID:221111052404ZC2SDBKV,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 443fcf928b8b41d79515918b413c4a77-20221111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1286533762; Fri, 11 Nov 2022 05:24:03 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 11 Nov 2022 05:24:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 11 Nov 2022 05:24:01 +0800
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
        <linux-mediatek@lists.infradead.org>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Kaikai Hu <kaikai.hu@mediatek.com>
Subject: [PATCH v3 3/7] wifi: mt76: mt7921: add unified ROC cmd/event support
Date:   Fri, 11 Nov 2022 05:23:45 +0800
Message-ID: <2ec5ef0995c23b02fdea46127d2ec44051c166ec.1668068326.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1668068326.git.objelf@gmail.com>
References: <cover.1668068326.git.objelf@gmail.com>
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

From: Quan Zhou <quan.zhou@mediatek.com>

Add unified ROC cmd/event which is only supported by the newer fw.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Co-developed-by: Kaikai Hu <kaikai.hu@mediatek.com>
Signed-off-by: Kaikai Hu <kaikai.hu@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  10 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 119 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  19 +++
 3 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index bc1c47daa81a..87c65d252d56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -121,11 +121,13 @@ struct mt76_connac2_mcu_rxd {
 
 	u8 eid;
 	u8 seq;
-	u8 rsv[2];
-
+	u8 option;
+	u8 rsv;
 	u8 ext_eid;
 	u8 rsv1[2];
 	u8 s2d_index;
+
+	u8 tlv[0];
 };
 
 struct mt76_connac2_patch_hdr {
@@ -946,6 +948,9 @@ enum {
 	DEV_INFO_MAX_NUM
 };
 
+#define MCU_UNI_CMD_EVENT                       BIT(1)
+#define MCU_UNI_CMD_UNSOLICITED_EVENT           BIT(2)
+
 /* event table */
 enum {
 	MCU_EVENT_TARGET_ADDRESS_LEN = 0x01,
@@ -1152,6 +1157,7 @@ enum {
 	MCU_UNI_CMD_OFFLOAD = 0x06,
 	MCU_UNI_CMD_HIF_CTRL = 0x07,
 	MCU_UNI_CMD_SNIFFER = 0x24,
+	MCU_UNI_CMD_ROC = 0x27,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 67bf92969a7b..2b36c5f6eb40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -302,6 +302,23 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	dev_kfree_skb(skb);
 }
 
+static void
+mt7921_mcu_uni_rx_unsolicited_event(struct mt7921_dev *dev,
+				    struct sk_buff *skb)
+{
+	struct mt76_connac2_mcu_rxd *rxd;
+
+	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
+
+	switch (rxd->eid) {
+	case MCU_UNI_EVENT_ROC:
+		break;
+	default:
+		break;
+	}
+	dev_kfree_skb(skb);
+}
+
 void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_connac2_mcu_rxd *rxd;
@@ -311,6 +328,11 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 
 	rxd = (struct mt76_connac2_mcu_rxd *)skb->data;
 
+	if (rxd->option & MCU_UNI_CMD_UNSOLICITED_EVENT) {
+		mt7921_mcu_uni_rx_unsolicited_event(dev, skb);
+		return;
+	}
+
 	if (rxd->eid == 0x6) {
 		mt76_mcu_rx_event(&dev->mt76, skb);
 		return;
@@ -636,6 +658,103 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 				 &req_mu, sizeof(req_mu), false);
 }
 
+int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+		       struct ieee80211_channel *chan, int duration,
+		       enum mt7921_roc_req type, u8 token_id)
+{
+	int center_ch = ieee80211_frequency_to_channel(chan->center_freq);
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 rsv[4];
+		} __packed hdr;
+		struct roc_acquire_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 bss_idx;
+			u8 tokenid;
+			u8 control_channel;
+			u8 sco;
+			u8 band;
+			u8 bw;
+			u8 center_chan;
+			u8 center_chan2;
+			u8 bw_from_ap;
+			u8 center_chan_from_ap;
+			u8 center_chan2_from_ap;
+			u8 reqtype;
+			__le32 maxinterval;
+			u8 dbdcband;
+			u8 rsv[3];
+		} __packed roc;
+	} __packed req = {
+		.roc = {
+			.tag = cpu_to_le16(UNI_ROC_ACQUIRE),
+			.len = cpu_to_le16(sizeof(struct roc_acquire_tlv)),
+			.tokenid = token_id,
+			.reqtype = type,
+			.maxinterval = cpu_to_le32(duration),
+			.bss_idx = vif->mt76.idx,
+			.control_channel = chan->hw_value,
+			.bw = CMD_CBW_20MHZ,
+			.bw_from_ap = CMD_CBW_20MHZ,
+			.center_chan = center_ch,
+			.center_chan_from_ap = center_ch,
+			.dbdcband = 0xff, /* auto */
+		},
+	};
+
+	if (chan->hw_value < center_ch)
+		req.roc.sco = 1; /* SCA */
+	else if (chan->hw_value > center_ch)
+		req.roc.sco = 3; /* SCB */
+
+	switch (chan->band) {
+	case NL80211_BAND_6GHZ:
+		req.roc.band = 3;
+		break;
+	case NL80211_BAND_5GHZ:
+		req.roc.band = 2;
+		break;
+	default:
+		req.roc.band = 1;
+		break;
+	}
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
+				 &req, sizeof(req), false);
+}
+
+int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+			 u8 token_id)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct {
+		struct {
+			u8 rsv[4];
+		} __packed hdr;
+		struct roc_abort_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 bss_idx;
+			u8 tokenid;
+			u8 dbdcband;
+			u8 rsv[5];
+		} __packed abort;
+	} __packed req = {
+		.abort = {
+			.tag = cpu_to_le16(UNI_ROC_ABORT),
+			.len = cpu_to_le16(sizeof(struct roc_abort_tlv)),
+			.tokenid = token_id,
+			.bss_idx = vif->mt76.idx,
+			.dbdcband = 0xff, /* auto*/
+		},
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(ROC),
+				 &req, sizeof(req), false);
+}
+
 int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
 {
 	struct mt7921_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index eaba114a9c7e..d9d78f6b088e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -53,6 +53,20 @@
 #define MT7921_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
 #define MT7921_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
 
+#define MCU_UNI_EVENT_ROC  0x27
+
+enum {
+	UNI_ROC_ACQUIRE,
+	UNI_ROC_ABORT,
+	UNI_ROC_NUM
+};
+
+enum mt7921_roc_req {
+	MT7921_ROC_REQ_JOIN,
+	MT7921_ROC_REQ_ROC,
+	MT7921_ROC_REQ_NUM
+};
+
 enum mt7921_sdio_pkt_type {
 	MT7921_SDIO_TXD,
 	MT7921_SDIO_DATA,
@@ -508,4 +522,9 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 
 int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 *alpha2,
 		       enum environment_cap env_cap);
+int mt7921_mcu_set_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+		       struct ieee80211_channel *chan, int duration,
+		       enum mt7921_roc_req type, u8 token_id);
+int mt7921_mcu_abort_roc(struct mt7921_phy *phy, struct mt7921_vif *vif,
+			 u8 token_id);
 #endif
-- 
2.25.1


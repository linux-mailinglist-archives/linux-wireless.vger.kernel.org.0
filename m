Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A7A594F16
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 05:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiHPDeA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 23:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiHPDdY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 23:33:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D3E4DF18
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 17:04:09 -0700 (PDT)
X-UUID: 9a6f38fb377f4f5ba7db36ca29d74a7a-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5FkT+XA7XDCjjZ3INEeCL4m7pBBFTNflXZP3PAjUuhk=;
        b=EN+CJUTJJ01l+ZR9MXIad3Z5I0PVzGhVX2R69b9g3a29CjRkD9NCRrikV6X2EydX6CR+1fdGTnLFuqK2Zud5WAoI0n4hlyneTdmWQb7gsgRhofGN4gO/PCRscl1NgHF5O6ResGModUZ+sBa38OKJ7HgPh9KC41C8Wc29R+NtkkE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:9d83ab32-46a4-443f-9ba3-534ee367c99e,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:5
X-CID-META: VersionHash:3d8acc9,CLOUDID:3f0cbe9c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9a6f38fb377f4f5ba7db36ca29d74a7a-20220816
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 869947174; Tue, 16 Aug 2022 08:04:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 16 Aug 2022 08:03:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Aug 2022 08:03:59 +0800
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
Subject: [PATCH 2/9] wifi: mt76: connac: add mt76_connac_mcu_uni_set_chctx
Date:   Tue, 16 Aug 2022 08:03:40 +0800
Message-ID: <57ebfc95640b3f062a1211bf939f9edfd9f58372.1660606893.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1660606893.git.objelf@gmail.com>
References: <cover.1660606893.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 83 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 +
 2 files changed, 86 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 0afcadce87fc..3d5c70765d4f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1311,6 +1311,89 @@ mt76_connac_mcu_uni_bss_he_tlv(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	he->max_nss_mcs[CMD_HE_MCS_BW8080] = cap->he_mcs_nss_supp.tx_mcs_80p80;
 }
 
+int mt76_connac_mcu_uni_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
+				  struct ieee80211_chanctx_conf *ctx)
+{
+	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->chandef;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	enum nl80211_band band = chandef->chan->band;
+	struct mt76_dev *mdev = phy->dev;
+
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct rlm_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 control_channel;
+			u8 center_chan;
+			u8 center_chan2;
+			u8 bw;
+			u8 tx_streams;
+			u8 rx_streams;
+			u8 short_st;
+			u8 ht_op_info;
+			u8 sco;
+			u8 band;
+			u8 pad[2];
+		} __packed rlm;
+	} __packed rlm_req = {
+		.hdr = {
+			.bss_idx = mvif->idx,
+		},
+		.rlm = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_RLM),
+			.len = cpu_to_le16(sizeof(struct rlm_tlv)),
+			.control_channel = chandef->chan->hw_value,
+			.center_chan = ieee80211_frequency_to_channel(freq1),
+			.center_chan2 = ieee80211_frequency_to_channel(freq2),
+			.tx_streams = hweight8(phy->antenna_mask),
+			.ht_op_info = 4, /* set HT 40M allowed */
+			.rx_streams = phy->chainmask,
+			.short_st = true,
+			.band = band,
+		},
+	};
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
 int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				struct ieee80211_vif *vif,
 				struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f1d7c05bd794..bf60b00d6020 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1727,6 +1727,9 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
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


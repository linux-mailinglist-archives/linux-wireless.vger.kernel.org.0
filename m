Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E9B64E9FB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 12:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiLPLHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 06:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiLPLGs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 06:06:48 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84F3E0E5
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 03:06:40 -0800 (PST)
X-UUID: e41a4b9571ef43e9a61346d47a4362f6-20221216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4bu6YTo+tt5u5v9xEYp7vBjjQ9u13lLt2k1kwKDl2yY=;
        b=f0YhY5Fx2Bjf4NFnRUvhU+OuOIUCl8RzxYVuo+ZCftPrGbVlIlcmycvlLqE+R3R3yeTihcPnUogNCyWnuIyYazK4D6w/7bVLD9KHV1yRvjEtLwipVnVc6QJzMf9C0oudfCCgcgsEJiaS2O7Ca7T4qHJEbogNIIJOqtLiswAsE7E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:a86c9a67-3d97-4c3e-8e5c-7862c70622f6,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:19318e89-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e41a4b9571ef43e9a61346d47a4362f6-20221216
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1568966801; Fri, 16 Dec 2022 19:06:28 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 16 Dec 2022 19:06:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Dec 2022 19:06:27 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: fix channel switch fail in monitor mode
Date:   Fri, 16 Dec 2022 19:04:38 +0800
Message-ID: <4de0968684f385c7b7f03ae43b17160ec92aebda.1671172366.git.deren.wu@mediatek.com>
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

When the chanctx enabled, IEEE80211_CONF_CHANGE_CHANNEL in .config()
would not be called anymore. mt76 cannot control RF channel for monitor.
Add monitor type set-channel flow in .change_chanctx().

Fixes: 41ac53c899bd ("wifi: mt76: mt7921: introduce chanctx support")
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  5 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 68 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 76ac5069638f..ef1ab818e69c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1711,7 +1711,10 @@ static void mt7921_ctx_iter(void *priv, u8 *mac,
 	if (ctx != mvif->ctx)
 		return;
 
-	mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->mt76, ctx);
+	if (vif->type & NL80211_IFTYPE_MONITOR)
+		mt7921_mcu_config_sniffer(mvif, ctx);
+	else
+		mt76_connac_mcu_uni_set_chctx(mvif->phy->mt76, &mvif->mt76, ctx);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8930b5a4467c..c4ca6905f050 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1093,6 +1093,74 @@ int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 				 true);
 }
 
+int mt7921_mcu_config_sniffer(struct mt7921_vif *vif,
+			      struct ieee80211_chanctx_conf *ctx)
+{
+	struct cfg80211_chan_def *chandef = &ctx->def;
+	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	const u8 ch_band[] = {
+		[NL80211_BAND_2GHZ] = 1,
+		[NL80211_BAND_5GHZ] = 2,
+		[NL80211_BAND_6GHZ] = 3,
+	};
+	const u8 ch_width[] = {
+		[NL80211_CHAN_WIDTH_20_NOHT] = 0,
+		[NL80211_CHAN_WIDTH_20] = 0,
+		[NL80211_CHAN_WIDTH_40] = 0,
+		[NL80211_CHAN_WIDTH_80] = 1,
+		[NL80211_CHAN_WIDTH_160] = 2,
+		[NL80211_CHAN_WIDTH_80P80] = 3,
+		[NL80211_CHAN_WIDTH_5] = 4,
+		[NL80211_CHAN_WIDTH_10] = 5,
+		[NL80211_CHAN_WIDTH_320] = 6,
+	};
+	struct {
+		struct {
+			u8 band_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct config_tlv {
+			__le16 tag;
+			__le16 len;
+			u16 aid;
+			u8 ch_band;
+			u8 bw;
+			u8 control_ch;
+			u8 sco;
+			u8 center_ch;
+			u8 center_ch2;
+			u8 drop_err;
+			u8 pad[3];
+		} __packed tlv;
+	} __packed req = {
+		.hdr = {
+			.band_idx = vif->mt76.band_idx,
+		},
+		.tlv = {
+			.tag = cpu_to_le16(1),
+			.len = cpu_to_le16(sizeof(req.tlv)),
+			.control_ch = chandef->chan->hw_value,
+			.center_ch = ieee80211_frequency_to_channel(freq1),
+			.drop_err = 1,
+		},
+	};
+	if (chandef->chan->band < ARRAY_SIZE(ch_band))
+		req.tlv.ch_band = ch_band[chandef->chan->band];
+	if (chandef->width < ARRAY_SIZE(ch_width))
+		req.tlv.bw = ch_width[chandef->width];
+
+	if (freq2)
+		req.tlv.center_ch2 = ieee80211_frequency_to_channel(freq2);
+
+	if (req.tlv.control_ch < req.tlv.center_ch)
+		req.tlv.sco = 1; /* SCA */
+	else if (req.tlv.control_ch > req.tlv.center_ch)
+		req.tlv.sco = 3; /* SCB */
+
+	return mt76_mcu_send_msg(vif->phy->mt76->dev, MCU_UNI_CMD(SNIFFER),
+				 &req, sizeof(req), true);
+}
+
 int
 mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
 				  struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index efff4d43d796..edfaeb7ce3d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -529,6 +529,8 @@ void mt7921_set_ipv6_ns_work(struct work_struct *work);
 
 int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 			   bool enable);
+int mt7921_mcu_config_sniffer(struct mt7921_vif *vif,
+			      struct ieee80211_chanctx_conf *ctx);
 
 int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
-- 
2.18.0


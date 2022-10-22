Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FCB6083D0
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Oct 2022 05:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJVDWA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 23:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJVDV6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 23:21:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CF1270D11
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 20:21:49 -0700 (PDT)
X-UUID: 4d027578ba284ef28c97e4361b5e2908-20221022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BIXoU9wDrHq2lnlqdcGGlcZYQhKTdhujkyo9PoidRpc=;
        b=Q6J1ChtxeSsh2uLz7kDqik3CX/CsGu6w4f1bK82lO3jc2+c5sAifLjwJjrP7JURfRahjU8DuDCPLhU18Q+vcSVcWBetoSLNuZFQLHXpK8cmAJPy0eixDIx5mCEHh9nWvoxqPPWq45m6DEO5sWiHvj1ydeL5ywljzO/KIxRXfnvM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:09a3dc1c-459c-45d8-b8b7-e95428e7937f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:09a3dc1c-459c-45d8-b8b7-e95428e7937f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:1b5dbd6c-89d3-4bfa-baad-dc632a24bca3,B
        ulkID:221022112145PABC7IKK,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4d027578ba284ef28c97e4361b5e2908-20221022
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2141278742; Sat, 22 Oct 2022 11:21:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 22 Oct 2022 11:21:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 22 Oct 2022 11:21:44 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
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
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: fix bandwidth 80MHz link fail in 6GHz band
Date:   Sat, 22 Oct 2022 11:21:19 +0800
Message-ID: <7f10cced1976b40f0aeafc281ead0652a54ec718.1666408187.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Due to information missing, the firmware may be fail on bandwidth
related settings in mt7921/mt7922. Add new cmd STA_REC_HE_V2 to apply
additional capabilities in 6GHz band.

Tested-by: Ben Greear <greearb@candelatech.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 38 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 11 ++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 011fc9729b38..cdfc0b0da823 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -744,6 +744,43 @@ mt76_connac_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	he->pkt_ext = 2;
 }
 
+static void
+mt76_connac_mcu_sta_he_tlv_v2(struct sk_buff *skb, struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
+	struct ieee80211_he_cap_elem *elem = &he_cap->he_cap_elem;
+	struct sta_rec_he_v2 *he;
+	struct tlv *tlv;
+	int i;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_HE_V2, sizeof(*he));
+
+	he = (struct sta_rec_he_v2 *)tlv;
+	for (i = 0; i < ARRAY_SIZE(he->he_phy_cap); i++)
+		he->he_phy_cap[i] = cpu_to_le16(elem->phy_cap_info[i]);
+
+	for (i = 0; i < ARRAY_SIZE(he->he_mac_cap); i++)
+		he->he_mac_cap[i] = cpu_to_le16(elem->mac_cap_info[i]);
+
+	switch (sta->deflink.bandwidth) {
+	case IEEE80211_STA_RX_BW_160:
+		if (elem->phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			he->max_nss_mcs[CMD_HE_MCS_BW8080] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80p80;
+
+		he->max_nss_mcs[CMD_HE_MCS_BW160] =
+				he_cap->he_mcs_nss_supp.rx_mcs_160;
+		fallthrough;
+	default:
+		he->max_nss_mcs[CMD_HE_MCS_BW80] =
+				he_cap->he_mcs_nss_supp.rx_mcs_80;
+		break;
+	}
+
+	he->pkt_ext = IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US;
+}
+
 static u8
 mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 			    enum nl80211_band band, struct ieee80211_sta *sta)
@@ -838,6 +875,7 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 	/* starec he */
 	if (sta->deflink.he_cap.has_he) {
 		mt76_connac_mcu_sta_he_tlv(skb, sta);
+		mt76_connac_mcu_sta_he_tlv_v2(skb, sta);
 		if (band == NL80211_BAND_6GHZ &&
 		    sta_state == MT76_STA_INFO_STATE_ASSOC) {
 			struct sta_rec_he_6g_capa *he_6g_capa;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index cf4ce3b1fc21..8166722d4717 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -354,6 +354,16 @@ struct sta_rec_he {
 	u8 rsv2[2];
 } __packed;
 
+struct sta_rec_he_v2 {
+	__le16 tag;
+	__le16 len;
+	u8 he_mac_cap[6];
+	u8 he_phy_cap[11];
+	u8 pkt_ext;
+	/* 0: BW80, 1: BW160, 2: BW8080 */
+	__le16 max_nss_mcs[CMD_HE_MCS_BW_NUM];
+} __packed;
+
 struct sta_rec_amsdu {
 	__le16 tag;
 	__le16 len;
@@ -779,6 +789,7 @@ enum {
 	STA_REC_BFEE,
 	STA_REC_PHY = 0x15,
 	STA_REC_HE_6G = 0x17,
+	STA_REC_HE_V2 = 0x19,
 	STA_REC_MAX_NUM
 };
 
-- 
2.18.0


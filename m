Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB07220DB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 10:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjFEIVC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjFEIUy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 04:20:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6D2A9
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 01:20:53 -0700 (PDT)
X-UUID: dcaaa9a8037911eeb20a276fd37b9834-20230605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dFF1rkNYwMnrMFlz0jnP25dTCfrgs5MmCrR94E+Ejow=;
        b=Gi7COTqfPG5myeJJxBaWKI0RLn9YgfQuxY3cbDqyc5EhBIRmGm6DHxg820z7ENj8vSVSyBO5GCLZk/LJGJfMJyzF1zE2nEZlKtbNU3ZMsgt7qTxIGxBE76XCzB08nI+RWMWitKVS8/zuSQhefQsJFuTYPXoRaguw5SgUOb1UeUc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:1e7df069-efea-4e58-aac9-95f59f7e7717,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:710f0c6e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: dcaaa9a8037911eeb20a276fd37b9834-20230605
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 159448892; Mon, 05 Jun 2023 16:20:42 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 16:20:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Jun 2023 16:20:41 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        "Shayne Chen" <shayne.chen@mediatek.com>
Subject: [PATCH v2 09/10] wifi: mt76: mt7996: add muru support
Date:   Mon, 5 Jun 2023 16:19:46 +0800
Message-ID: <20230605081947.12804-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230605081947.12804-1-shayne.chen@mediatek.com>
References: <20230605081947.12804-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: MeiChia Chiu <MeiChia.Chiu@mediatek.com>

Add sta_rec_muru() fw command to support MU-MIMO and OFDMA features.

Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 56 ++++++++++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 3790d68525e5..48bced4e2e5d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -519,7 +519,8 @@ struct sta_rec_muru {
 		u8 uo_ra;
 		u8 he_2x996_tone;
 		u8 rx_t_frame_11ac;
-		u8 rsv[3];
+		u8 rx_ctrl_frame_to_mbss;
+		u8 rsv[2];
 	} ofdma_ul;
 
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 398d27d522ef..1c5220741ae7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1101,6 +1101,59 @@ mt7996_mcu_sta_amsdu_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
 	}
 }
 
+static void
+mt7996_mcu_sta_muru_tlv(struct mt7996_dev *dev, struct sk_buff *skb,
+			struct ieee80211_vif *vif, struct ieee80211_sta *sta)
+{
+	struct ieee80211_he_cap_elem *elem = &sta->deflink.he_cap.he_cap_elem;
+	struct sta_rec_muru *muru;
+	struct tlv *tlv;
+
+	if (vif->type != NL80211_IFTYPE_STATION &&
+	    vif->type != NL80211_IFTYPE_AP)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_MURU, sizeof(*muru));
+
+	muru = (struct sta_rec_muru *)tlv;
+	muru->cfg.mimo_dl_en = vif->bss_conf.eht_mu_beamformer ||
+			       vif->bss_conf.he_mu_beamformer ||
+			       vif->bss_conf.vht_mu_beamformer ||
+			       vif->bss_conf.vht_mu_beamformee;
+	muru->cfg.ofdma_dl_en = true;
+
+	if (sta->deflink.vht_cap.vht_supported)
+		muru->mimo_dl.vht_mu_bfee =
+			!!(sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+
+	if (!sta->deflink.he_cap.has_he)
+		return;
+
+	muru->mimo_dl.partial_bw_dl_mimo =
+		HE_PHY(CAP6_PARTIAL_BANDWIDTH_DL_MUMIMO, elem->phy_cap_info[6]);
+
+	muru->mimo_ul.full_ul_mimo =
+		HE_PHY(CAP2_UL_MU_FULL_MU_MIMO, elem->phy_cap_info[2]);
+	muru->mimo_ul.partial_ul_mimo =
+		HE_PHY(CAP2_UL_MU_PARTIAL_MU_MIMO, elem->phy_cap_info[2]);
+
+	muru->ofdma_dl.punc_pream_rx =
+		HE_PHY(CAP1_PREAMBLE_PUNC_RX_MASK, elem->phy_cap_info[1]);
+	muru->ofdma_dl.he_20m_in_40m_2g =
+		HE_PHY(CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G, elem->phy_cap_info[8]);
+	muru->ofdma_dl.he_20m_in_160m =
+		HE_PHY(CAP8_20MHZ_IN_160MHZ_HE_PPDU, elem->phy_cap_info[8]);
+	muru->ofdma_dl.he_80m_in_160m =
+		HE_PHY(CAP8_80MHZ_IN_160MHZ_HE_PPDU, elem->phy_cap_info[8]);
+
+	muru->ofdma_ul.t_frame_dur =
+		HE_MAC(CAP1_TF_MAC_PAD_DUR_MASK, elem->mac_cap_info[1]);
+	muru->ofdma_ul.mu_cascading =
+		HE_MAC(CAP2_MU_CASCADING, elem->mac_cap_info[2]);
+	muru->ofdma_ul.uo_ra =
+		HE_MAC(CAP3_OFDMA_RA, elem->mac_cap_info[3]);
+}
+
 static inline bool
 mt7996_is_ebf_supported(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, bool bfee)
@@ -1778,7 +1831,8 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		mt7996_mcu_sta_he_6g_tlv(skb, sta);
 		/* starec eht */
 		mt7996_mcu_sta_eht_tlv(skb, sta);
-		/* TODO: starec muru */
+		/* starec muru */
+		mt7996_mcu_sta_muru_tlv(dev, skb, vif, sta);
 		/* starec bfee */
 		mt7996_mcu_sta_bfee_tlv(dev, skb, vif, sta);
 		/* starec hdr trans */
-- 
2.39.2


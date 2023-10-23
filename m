Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED67D3B1B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 17:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjJWPmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 11:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjJWPmM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 11:42:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7D5DF
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 08:42:06 -0700 (PDT)
X-UUID: b52b0b0271ba11eea33bb35ae8d461a2-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=h1BKAdeDyo7lAKwf3L/9lQuBZpUyHbnGbXrwup1Y0tY=;
        b=g9CyzvV+kS0Xi4WUenXFQx3YXK3athGc0xBgzqrCQNqQZSRMzt4MYox+rMAVftM3HUwTYPFlpSyJuLZJmwkoESSvamtgStWDDR9AicrOFByrWpfUo3aqzyQ8OM2PCu2DFE1GQbimbwJJ2yYjw1lidrMlpsW4YV7IyfjK9i9aYeE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6f5d63b2-a285-46c7-8ef8-1a2d9e8151d3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:ce95abfb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b52b0b0271ba11eea33bb35ae8d461a2-20231023
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1582697335; Mon, 23 Oct 2023 23:42:01 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 23:41:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 23:41:59 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 10/11] wifi: mt76: mt7996: align the format of fixed rate command
Date:   Mon, 23 Oct 2023 23:38:53 +0800
Message-ID: <20231023153854.10708-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231023153854.10708-1-shayne.chen@mediatek.com>
References: <20231023153854.10708-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.220300-8.000000
X-TMASE-MatchedRID: dTwHtQCOr38VAKRaMHqjDrMjW/sniEQKwx0jRRxcQfNcMMd+jCb9t3sN
        U677tWu5UEeV4U1o0G8HbUC3ubj+XZRMdwEiWk2Ndrnuu4cCcfFMkOX0UoduuQCGaccd4ae9MDP
        FcR5xz2R5rpsNj1PJk8YdhlZfQeHl4X8HWMSNX7pIcJTn2HkqsUb8lR3sG9JCNM9QGIWxRxsS99
        dUV0LYknq+9uqy4HnB/4qDTkxhw+UX/ky8TX34OmMdYzySsvg8BCny5lrY72ebKItl61J/yZ+in
        TK0bC9eKrauXd3MZDUal568aygjlyD9swBQE+k9jF/kji12h4CgSVj1NqrotrnE6OO0SanImEoy
        Uv4GC7iBfwb97ojO8WPTiIXeL/1Sd8Zi3goTm0jqtzWWHbJGHRdGg+ZY7eN6THB2Q+oKru8MTI3
        4nyF36MJL1aANdU8KftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.220300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0E0860BF277B5C50B51D37EEFB009E5D87FE67F67CE0EFF6149602B6319516E62000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Use the new fixed rate command format to let the fixed field function
work normally.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 12 ++--
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 71 ++++++++++++++++++-
 2 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8e2037671c9b..8097924d460b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1805,8 +1805,8 @@ int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct sta_phy *phy = data;
-	struct sta_rec_ra_fixed *ra;
+	struct sta_phy_uni *phy = data;
+	struct sta_rec_ra_fixed_uni *ra;
 	struct sk_buff *skb;
 	struct tlv *tlv;
 
@@ -1817,7 +1817,7 @@ int mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif
 		return PTR_ERR(skb);
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
-	ra = (struct sta_rec_ra_fixed *)tlv;
+	ra = (struct sta_rec_ra_fixed_uni *)tlv;
 
 	switch (field) {
 	case RATE_PARAM_AUTO:
@@ -1849,7 +1849,7 @@ mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif
 	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
 	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
 	enum nl80211_band band = chandef->chan->band;
-	struct sta_phy phy = {};
+	struct sta_phy_uni phy = {};
 	int ret, nrates = 0;
 
 #define __sta_phy_bitrate_mask_check(_mcs, _gi, _ht, _he)			\
@@ -1937,13 +1937,13 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
 	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
 	enum nl80211_band band = chandef->chan->band;
-	struct sta_rec_ra *ra;
+	struct sta_rec_ra_uni *ra;
 	struct tlv *tlv;
 	u32 supp_rate = sta->deflink.supp_rates[band];
 	u32 cap = sta->wme ? STA_CAP_WMM : 0;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra));
-	ra = (struct sta_rec_ra *)tlv;
+	ra = (struct sta_rec_ra_uni *)tlv;
 
 	ra->valid = true;
 	ra->auto_rate = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index d3ac6ac0e5c9..a3eae32c8f10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -494,6 +494,73 @@ struct sta_rec_sec_uni {
 	struct sec_key_uni key[2];
 } __packed;
 
+struct sta_phy_uni {
+	u8 type;
+	u8 flag;
+	u8 stbc;
+	u8 sgi;
+	u8 bw;
+	u8 ldpc;
+	u8 mcs;
+	u8 nss;
+	u8 he_ltf;
+	u8 rsv[3];
+};
+
+struct sta_rec_ra_uni {
+	__le16 tag;
+	__le16 len;
+
+	u8 valid;
+	u8 auto_rate;
+	u8 phy_mode;
+	u8 channel;
+	u8 bw;
+	u8 disable_cck;
+	u8 ht_mcs32;
+	u8 ht_gf;
+	u8 ht_mcs[4];
+	u8 mmps_mode;
+	u8 gband_256;
+	u8 af;
+	u8 auth_wapi_mode;
+	u8 rate_len;
+
+	u8 supp_mode;
+	u8 supp_cck_rate;
+	u8 supp_ofdm_rate;
+	__le32 supp_ht_mcs;
+	__le16 supp_vht_mcs[4];
+
+	u8 op_mode;
+	u8 op_vht_chan_width;
+	u8 op_vht_rx_nss;
+	u8 op_vht_rx_nss_type;
+
+	__le32 sta_cap;
+
+	struct sta_phy_uni phy;
+	u8 rx_rcpi[4];
+} __packed;
+
+struct sta_rec_ra_fixed_uni {
+	__le16 tag;
+	__le16 len;
+
+	__le32 field;
+	u8 op_mode;
+	u8 op_vht_chan_width;
+	u8 op_vht_rx_nss;
+	u8 op_vht_rx_nss_type;
+
+	struct sta_phy_uni phy;
+
+	u8 spe_idx;
+	u8 short_preamble;
+	u8 is_5g;
+	u8 mmps_mode;
+} __packed;
+
 struct sta_rec_hdrt {
 	__le16 tag;
 	__le16 len;
@@ -677,9 +744,9 @@ enum {
 					 sizeof(struct sta_rec_amsdu) +		\
 					 sizeof(struct sta_rec_bfee) +		\
 					 sizeof(struct sta_rec_phy) +		\
-					 sizeof(struct sta_rec_ra) +		\
+					 sizeof(struct sta_rec_ra_uni) +	\
 					 sizeof(struct sta_rec_sec) +		\
-					 sizeof(struct sta_rec_ra_fixed) +	\
+					 sizeof(struct sta_rec_ra_fixed_uni) +	\
 					 sizeof(struct sta_rec_he_6g_capa) +	\
 					 sizeof(struct sta_rec_eht) +		\
 					 sizeof(struct sta_rec_hdrt) +		\
-- 
2.39.2


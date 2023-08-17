Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9D977F1B8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Aug 2023 10:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348701AbjHQICf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348729AbjHQIC2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 04:02:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692872D76
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 01:02:20 -0700 (PDT)
X-UUID: 5fafd34e3cd411ee9cb5633481061a41-20230817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rD3xJ0P94qLm1F151Mrvluh9HiJKqb72Cl07WlFf+b0=;
        b=TU+/1o5rzKYJsWvxmjVFxs7RLFMpfHhbhTh/yUh9Ty79jQUuoEdXPnh0szDuThOstCrRbD2blYMVrVVyiYqvg1/PEic5UxW2IDyozNlls81mZ78GMsyPqcv82kkZNEhYhjE/3eYlxYBNv3dK5hVRrZpEwIF6MAJ9zu4wXq0QOwM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:f79bca73-4b76-4dd6-a190-5c2af617d7b7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:3084f5c1-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5fafd34e3cd411ee9cb5633481061a41-20230817
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1832990785; Thu, 17 Aug 2023 16:02:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 17 Aug 2023 16:02:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 17 Aug 2023 16:02:11 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 8/9] wifi: mt76: mt7996: support more options for mt7996_set_bitrate_mask()
Date:   Thu, 17 Aug 2023 16:01:53 +0800
Message-ID: <20230817080154.16475-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230817080154.16475-1-shayne.chen@mediatek.com>
References: <20230817080154.16475-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Howard Hsu <howard-yh.hsu@mediatek.com>

Add support to configure parameters at runtime, such as mcs, gi, and
he_ltf. Note that EHT mode does not support this feature yet.

Co-developed-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 135 +++++++++++++++++-
 1 file changed, 133 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index b0e6f51041fd..3b56b90bb956 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1624,6 +1624,132 @@ int mt7996_mcu_set_fixed_rate_ctrl(struct mt7996_dev *dev,
 				     MCU_WM_UNI_CMD(RA), true);
 }
 
+static int
+mt7996_mcu_set_fixed_field(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, void *data, u32 field)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct sta_phy *phy = data;
+	struct sta_rec_ra_fixed *ra;
+	struct sk_buff *skb;
+	struct tlv *tlv;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
+					      &msta->wcid,
+					      MT7996_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA_UPDATE, sizeof(*ra));
+	ra = (struct sta_rec_ra_fixed *)tlv;
+
+	switch (field) {
+	case RATE_PARAM_AUTO:
+		break;
+	case RATE_PARAM_FIXED:
+	case RATE_PARAM_FIXED_MCS:
+	case RATE_PARAM_FIXED_GI:
+	case RATE_PARAM_FIXED_HE_LTF:
+		if (phy)
+			ra->phy = *phy;
+		break;
+	default:
+		break;
+	}
+	ra->field = cpu_to_le32(field);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+}
+
+static int
+mt7996_mcu_add_rate_ctrl_fixed(struct mt7996_dev *dev, struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta)
+{
+	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = &mvif->phy->mt76->chandef;
+	struct cfg80211_bitrate_mask *mask = &mvif->bitrate_mask;
+	enum nl80211_band band = chandef->chan->band;
+	struct sta_phy phy = {};
+	int ret, nrates = 0;
+
+#define __sta_phy_bitrate_mask_check(_mcs, _gi, _ht, _he)			\
+	do {									\
+		u8 i, gi = mask->control[band]._gi;				\
+		gi = (_he) ? gi : gi == NL80211_TXRATE_FORCE_SGI;		\
+		phy.sgi = gi;							\
+		phy.he_ltf = mask->control[band].he_ltf;			\
+		for (i = 0; i < ARRAY_SIZE(mask->control[band]._mcs); i++) {	\
+			if (!mask->control[band]._mcs[i])			\
+				continue;					\
+			nrates += hweight16(mask->control[band]._mcs[i]);	\
+			phy.mcs = ffs(mask->control[band]._mcs[i]) - 1;		\
+			if (_ht)						\
+				phy.mcs += 8 * i;				\
+		}								\
+	} while (0)
+
+	if (sta->deflink.he_cap.has_he) {
+		__sta_phy_bitrate_mask_check(he_mcs, he_gi, 0, 1);
+	} else if (sta->deflink.vht_cap.vht_supported) {
+		__sta_phy_bitrate_mask_check(vht_mcs, gi, 0, 0);
+	} else if (sta->deflink.ht_cap.ht_supported) {
+		__sta_phy_bitrate_mask_check(ht_mcs, gi, 1, 0);
+	} else {
+		nrates = hweight32(mask->control[band].legacy);
+		phy.mcs = ffs(mask->control[band].legacy) - 1;
+	}
+#undef __sta_phy_bitrate_mask_check
+
+	/* fall back to auto rate control */
+	if (mask->control[band].gi == NL80211_TXRATE_DEFAULT_GI &&
+	    mask->control[band].he_gi == GENMASK(7, 0) &&
+	    mask->control[band].he_ltf == GENMASK(7, 0) &&
+	    nrates != 1)
+		return 0;
+
+	/* fixed single rate */
+	if (nrates == 1) {
+		ret = mt7996_mcu_set_fixed_field(dev, vif, sta, &phy,
+						 RATE_PARAM_FIXED_MCS);
+		if (ret)
+			return ret;
+	}
+
+	/* fixed GI */
+	if (mask->control[band].gi != NL80211_TXRATE_DEFAULT_GI ||
+	    mask->control[band].he_gi != GENMASK(7, 0)) {
+		struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+		u32 addr;
+
+		/* firmware updates only TXCMD but doesn't take WTBL into
+		 * account, so driver should update here to reflect the
+		 * actual txrate hardware sends out.
+		 */
+		addr = mt7996_mac_wtbl_lmac_addr(dev, msta->wcid.idx, 7);
+		if (sta->deflink.he_cap.has_he)
+			mt76_rmw_field(dev, addr, GENMASK(31, 24), phy.sgi);
+		else
+			mt76_rmw_field(dev, addr, GENMASK(15, 12), phy.sgi);
+
+		ret = mt7996_mcu_set_fixed_field(dev, vif, sta, &phy,
+						 RATE_PARAM_FIXED_GI);
+		if (ret)
+			return ret;
+	}
+
+	/* fixed HE_LTF */
+	if (mask->control[band].he_ltf != GENMASK(7, 0)) {
+		ret = mt7996_mcu_set_fixed_field(dev, vif, sta, &phy,
+						 RATE_PARAM_FIXED_HE_LTF);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void
 mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
@@ -1733,6 +1859,7 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct sk_buff *skb;
+	int ret;
 
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
 					      &msta->wcid,
@@ -1752,8 +1879,12 @@ int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	 */
 	mt7996_mcu_sta_rate_ctrl_tlv(skb, dev, vif, sta);
 
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+	if (ret)
+		return ret;
+
+	return mt7996_mcu_add_rate_ctrl_fixed(dev, vif, sta);
 }
 
 static int
-- 
2.39.2


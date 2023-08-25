Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DFC788DFB
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 19:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbjHYRsC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjHYRre (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 13:47:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8322128
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 10:47:32 -0700 (PDT)
X-UUID: 73b5ea12436f11ee9cb5633481061a41-20230826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sMOXqtKXU4WEHY4aOx9vtuMXW7CWH+SmSHRf4ypQWR0=;
        b=D9rXZnUM338Bbtw9CnXRRMTWXkv/jTVbOTR99GE4QNNfJYLmlyLe2GnAMZbk4KoVPpBAODAhPZrvlfA1H4fxCkExF1w9Pz8KpBhgpXQ96dt1F4fKWvVqBn7FNpKtjicnT9fMSH7NUbWCHReQXI3Qd/Bxx8+wqd78dzFFIrsFy1c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:5f05e492-e773-4e29-a5b7-ac3f986a4fc8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:5f05e492-e773-4e29-a5b7-ac3f986a4fc8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:6c3bf4ee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:230826014728MIVTGQZ9,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC
X-UUID: 73b5ea12436f11ee9cb5633481061a41-20230826
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 88536717; Sat, 26 Aug 2023 01:47:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 26 Aug 2023 01:47:24 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 26 Aug 2023 01:47:22 +0800
From:   Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Subject: [PATCH 4/6] wifi: mt76: mt7996: remove periodic MPDU TXS request
Date:   Fri, 25 Aug 2023 10:47:06 -0700
Message-ID: <894656c48c2fcee49a79b29fe7a24abca3e3403a.1692983967.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <09f0cb7f314a08eddb77298411d965ad30a847bb.1692983967.git.yi-chia.hsieh@mediatek.com>
References: <09f0cb7f314a08eddb77298411d965ad30a847bb.1692983967.git.yi-chia.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove periodic MPDU TXS request. Get TID and FrameType from SKB
instead of TXWI, which is empty for Data Frame after MPDU TXS request
is removed, hence prohibiting the establishment of TX BA session.

Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 38 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  1 -
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 -
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ef5d1192ef0e..383b55c8cca8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -948,15 +948,6 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
-	if (sta) {
-		struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-
-		if (time_after(jiffies, msta->jiffies + HZ / 4)) {
-			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-			msta->jiffies = jiffies;
-		}
-	}
-
 	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
 	t->skb = tx_info->skb;
 
@@ -1006,22 +997,35 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 }
 
 static void
-mt7996_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+mt7996_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb)
 {
 	struct mt7996_sta *msta;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	u16 fc, tid;
-	u32 val;
 
 	if (!sta || !(sta->deflink.ht_cap.ht_supported || sta->deflink.he_cap.has_he))
 		return;
 
-	tid = le32_get_bits(txwi[1], MT_TXD1_TID);
+	tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
 	if (tid >= 6) /* skip VO queue */
 		return;
 
-	val = le32_to_cpu(txwi[2]);
-	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
-	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	if (is_8023) {
+		fc = IEEE80211_FTYPE_DATA |
+		     (sta->wme ? IEEE80211_STYPE_QOS_DATA : IEEE80211_STYPE_DATA);
+	} else {
+		/* No need to get precise TID for Action/Management Frame,
+		 * since it will not meet the following Frame Control
+		 * condition anyway.
+		 */
+
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+		fc = le16_to_cpu(hdr->frame_control) &
+		     (IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE);
+	}
+
 	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
 		return;
 
@@ -1049,7 +1053,7 @@ mt7996_txwi_free(struct mt7996_dev *dev, struct mt76_txwi_cache *t,
 		wcid_idx = wcid->idx;
 
 		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-			mt7996_tx_check_aggr(sta, txwi);
+			mt7996_tx_check_aggr(sta, t->skb);
 	} else {
 		wcid_idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
 	}
@@ -1320,7 +1324,7 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	wcidx = le32_get_bits(txs_data[2], MT_TXS2_MLD_ID);
 	pid = le32_get_bits(txs_data[3], MT_TXS3_PID);
 
-	if (pid < MT_PACKET_ID_WED)
+	if (pid < MT_PACKET_ID_NO_SKB)
 		return;
 
 	if (wcidx >= mt7996_wtbl_size(dev))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 37128f7f6671..202c6083e8f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -660,7 +660,6 @@ int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	msta->wcid.idx = idx;
 	msta->wcid.phy_idx = band_idx;
 	msta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	msta->jiffies = jiffies;
 
 	ewma_avg_signal_init(&msta->avg_ack_signal);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index cb67a2d4c6d4..e53cf6a3704c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -110,7 +110,6 @@ struct mt7996_sta {
 	struct ewma_avg_signal avg_ack_signal;
 
 	unsigned long changed;
-	unsigned long jiffies;
 
 	struct mt76_connac_sta_key_conf bip;
 
-- 
2.39.0


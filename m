Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE478F89D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 08:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344857AbjIAGdi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 02:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjIAGdh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 02:33:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D7910CE
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 23:33:28 -0700 (PDT)
X-UUID: 72a92806489111eea33bb35ae8d461a2-20230901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BTJIT/vT5SNltoS1SA1aF31p8dK4g6opJq5J6yEwTSI=;
        b=MZ8FD5DW5mUYOSY8ulic9MfLkO21ikSTVYe0qEia+vNAFXC5VWPynLMEVsv7OFx8ZhFKXI9RNAPvh5UZkCw8r7Wliai0xwZeHM3r+q1aDpvvnLQt+oKvqSjH3C1H1wlOySQ4TbIzxeORHD2JSvpR05KnZOAqvE+YU+IYlJBtFZE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:d2f1e0f5-2e2f-4481-b0c0-52c2933b6a09,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:5be4ff1f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 72a92806489111eea33bb35ae8d461a2-20230901
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 990619625; Fri, 01 Sep 2023 14:33:22 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Sep 2023 14:32:17 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Sep 2023 14:32:10 +0800
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
Subject: [PATCH v2 4/4] wifi: mt76: mt7996: remove periodic MPDU TXS request
Date:   Thu, 31 Aug 2023 23:30:05 -0700
Message-ID: <b2af33d7c00a78c9abc81427b05fc2000b1a2a0c.1693549298.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7554d0a64ff480f1a185f381a59799158fe8bf23.1693549298.git.yi-chia.hsieh@mediatek.com>
References: <7554d0a64ff480f1a185f381a59799158fe8bf23.1693549298.git.yi-chia.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

Remove periodic MPDU TXS request. Get TID and FrameType from SKB
instead of TXWI, which is empty for Data Frame after MPDU TXS request
is removed, hence prohibiting the establishment of TX BA session.

Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
---
v2: split series and update author
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


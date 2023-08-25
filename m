Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78CE788DF8
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 19:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjHYRsB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjHYRra (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 13:47:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B11D212B
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 10:47:25 -0700 (PDT)
X-UUID: 6d9fc350436f11eeb20a276fd37b9834-20230826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NdiWEmaBm07XJozVZFSJii/JVou2Djnru9WP4B+8F+0=;
        b=oFmXbwepJvZHFj33wcqpXTSKtPu9IJSFy4K7hB7OKtIPTAordKyxwnQklX+GwZP/lJuePZv/+UkxYbMtWOb5ubyPKlY/vRrIl6KmlBWP1xtzXBa5mZHmuAO9kETbYMQ4t147ZsbJEnrSZDVa/p0dbhOqFbWzffUJz3BqDw7RNZs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:3f79d73d-57f5-4a05-b0cd-31575c61773a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:3f79d73d-57f5-4a05-b0cd-31575c61773a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:50d5c11f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:230826014717VTYZ1TZR,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 6d9fc350436f11eeb20a276fd37b9834-20230826
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1466951857; Sat, 26 Aug 2023 01:47:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 26 Aug 2023 01:47:14 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 26 Aug 2023 01:47:12 +0800
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
Subject: [PATCH 1/6] wifi: mt76: mt7996: get tx_retries and tx_failed from txfree
Date:   Fri, 25 Aug 2023 10:47:03 -0700
Message-ID: <09f0cb7f314a08eddb77298411d965ad30a847bb.1692983967.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Retrieve tx retries/failed counts from 'txfree done' events and report
them via mt7996_sta_statistics().

Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac3_mac.h |  4 ++--
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 21 ++++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  6 ++++++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
index 68ca0844cbbf..e0354f1ffcc3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
@@ -269,11 +269,11 @@ enum tx_mgnt_type {
 #define MT_TXFREE0_MSDU_CNT		GENMASK(25, 16)
 #define MT_TXFREE0_RX_BYTE		GENMASK(15, 0)
 
-#define MT_TXFREE1_VER			GENMASK(18, 16)
+#define MT_TXFREE1_VER			GENMASK(19, 16)
 
 #define MT_TXFREE_INFO_PAIR		BIT(31)
 #define MT_TXFREE_INFO_HEADER		BIT(30)
-#define MT_TXFREE_INFO_WLAN_ID		GENMASK(23, 12)
+#define MT_TXFREE_INFO_MLD_ID		GENMASK(23, 12)
 #define MT_TXFREE_INFO_MSDU_ID		GENMASK(14, 0)
 #define MT_TXFREE_INFO_COUNT		GENMASK(27, 24)
 #define MT_TXFREE_INFO_STAT		GENMASK(29, 28)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ac8759febe48..0bdb5533847b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1070,6 +1070,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 	struct mt76_phy *phy3 = mdev->phys[MT_BAND2];
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
+	struct mt76_wcid *wcid;
 	LIST_HEAD(free_list);
 	struct sk_buff *skb, *tmp;
 	void *end = data + len;
@@ -1088,7 +1089,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 		mt76_queue_tx_cleanup(dev, phy3->q_tx[MT_TXQ_BE], false);
 	}
 
-	if (WARN_ON_ONCE(le32_get_bits(tx_free[1], MT_TXFREE1_VER) < 4))
+	if (WARN_ON_ONCE(le32_get_bits(tx_free[1], MT_TXFREE1_VER) < 5))
 		return;
 
 	total = le32_get_bits(tx_free[0], MT_TXFREE0_MSDU_CNT);
@@ -1104,10 +1105,9 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 		info = le32_to_cpu(*cur_info);
 		if (info & MT_TXFREE_INFO_PAIR) {
 			struct mt7996_sta *msta;
-			struct mt76_wcid *wcid;
 			u16 idx;
 
-			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
+			idx = FIELD_GET(MT_TXFREE_INFO_MLD_ID, info);
 			wcid = rcu_dereference(dev->mt76.wcid[idx]);
 			sta = wcid_to_sta(wcid);
 			if (!sta)
@@ -1120,10 +1120,21 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 					      &mdev->sta_poll_list);
 			spin_unlock_bh(&mdev->sta_poll_lock);
 			continue;
-		}
+		} else if (info & MT_TXFREE_INFO_HEADER) {
+			u32 tx_retries = 0, tx_failed = 0;
+
+			if (!wcid)
+				continue;
+
+			tx_retries =
+				FIELD_GET(MT_TXFREE_INFO_COUNT, info) - 1;
+			tx_failed = tx_retries +
+				!!FIELD_GET(MT_TXFREE_INFO_STAT, info);
 
-		if (info & MT_TXFREE_INFO_HEADER)
+			wcid->stats.tx_retries += tx_retries;
+			wcid->stats.tx_failed += tx_failed;
 			continue;
+		}
 
 		for (i = 0; i < 2; i++) {
 			msdu = (info >> (15 * i)) & MT_TXFREE_INFO_MSDU_ID;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index c3a479dc3f53..07c13fcc187a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -992,6 +992,12 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 	sinfo->txrate.flags = txrate->flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
+	sinfo->tx_failed = msta->wcid.stats.tx_failed;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+
+	sinfo->tx_retries = msta->wcid.stats.tx_retries;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+
 	sinfo->ack_signal = (s8)msta->ack_signal;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
 
-- 
2.39.0


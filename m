Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64B058F08E
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Aug 2022 18:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiHJQlC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Aug 2022 12:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiHJQlA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Aug 2022 12:41:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34633CF1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 09:40:54 -0700 (PDT)
X-UUID: 86cade0895214b88963c572c62fc7a98-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZeK40Ft+5R9q5wipXEInTBvncIlqpyvU0zkDu9KKEBM=;
        b=uHXKmZGQNqTeYc8DTghEjH/YfePKcS1UxLsfnksa/c1BUlRnc+hZCrpVE3neEP0g9zdPPvpYQFwc2yMB35R1HHcDV3oUHdN+tXPR5TZa41H8RHAJ90wZJqKF7clo90xxsf/C3HwrmEP5rDPXm/Acg5x3zmkat+3Kt56JbaQXkHU=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:379240d5-7305-4aa8-9584-e5d852966fd1,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.9,REQID:379240d5-7305-4aa8-9584-e5d852966fd1,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:100
X-CID-META: VersionHash:3d8acc9,CLOUDID:55a94c9c-da39-4e3b-a854-56c7d2111b46,C
        OID:2d2e3b17dbd7,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 86cade0895214b88963c572c62fc7a98-20220811
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1157970110; Thu, 11 Aug 2022 00:40:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 11 Aug 2022 00:40:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Aug 2022 00:40:45 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: move move mt76_sta_stats to mt76_wcid
Date:   Thu, 11 Aug 2022 00:40:43 +0800
Message-ID: <a9ded159fd293b25c745dea966e5b00a2601e56d.1660092593.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch for WED's TxS support.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 42 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 +-
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 -
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 -
 9 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4da77d47b0a6..a45dd038b967 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -252,6 +252,26 @@ struct mt76_queue_ops {
 	void (*reset_q)(struct mt76_dev *dev, struct mt76_queue *q);
 };
 
+enum mt76_phy_type {
+	MT_PHY_TYPE_CCK,
+	MT_PHY_TYPE_OFDM,
+	MT_PHY_TYPE_HT,
+	MT_PHY_TYPE_HT_GF,
+	MT_PHY_TYPE_VHT,
+	MT_PHY_TYPE_HE_SU = 8,
+	MT_PHY_TYPE_HE_EXT_SU,
+	MT_PHY_TYPE_HE_TB,
+	MT_PHY_TYPE_HE_MU,
+	__MT_PHY_TYPE_HE_MAX,
+};
+
+struct mt76_sta_stats {
+	u64 tx_mode[__MT_PHY_TYPE_HE_MAX];
+	u64 tx_bw[4];		/* 20, 40, 80, 160 */
+	u64 tx_nss[4];		/* 1, 2, 3, 4 */
+	u64 tx_mcs[16];		/* mcs idx */
+};
+
 enum mt76_wcid_flags {
 	MT_WCID_FLAG_CHECK_PS,
 	MT_WCID_FLAG_PS,
@@ -299,6 +319,8 @@ struct mt76_wcid {
 
 	struct list_head list;
 	struct idr pktid;
+
+	struct mt76_sta_stats stats;
 };
 
 struct mt76_txq {
@@ -815,26 +837,6 @@ struct mt76_power_limits {
 	s8 ru[7][12];
 };
 
-enum mt76_phy_type {
-	MT_PHY_TYPE_CCK,
-	MT_PHY_TYPE_OFDM,
-	MT_PHY_TYPE_HT,
-	MT_PHY_TYPE_HT_GF,
-	MT_PHY_TYPE_VHT,
-	MT_PHY_TYPE_HE_SU = 8,
-	MT_PHY_TYPE_HE_EXT_SU,
-	MT_PHY_TYPE_HE_TB,
-	MT_PHY_TYPE_HE_MU,
-	__MT_PHY_TYPE_HE_MAX,
-};
-
-struct mt76_sta_stats {
-	u64 tx_mode[__MT_PHY_TYPE_HE_MAX];
-	u64 tx_bw[4];		/* 20, 40, 80, 160 */
-	u64 tx_nss[4];		/* 1, 2, 3, 4 */
-	u64 tx_mcs[16];		/* mcs idx */
-};
-
 struct mt76_ethtool_worker_info {
 	u64 *data;
 	int idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index d03365530ac1..851874f782c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -355,8 +355,7 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				 struct ieee80211_key_conf *key, int pid,
 				 enum mt76_txq_id qid, u32 changed);
 bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
-				  int pid, __le32 *txs_data,
-				  struct mt76_sta_stats *stats);
+				  int pid, __le32 *txs_data);
 void mt76_connac2_mac_decode_he_radiotap(struct mt76_dev *dev,
 					 struct sk_buff *skb,
 					 __le32 *rxv, u32 mode);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 18dea8e1fb20..d0a94cb6d08b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -551,9 +551,9 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_write_txwi);
 
 bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
-				  int pid, __le32 *txs_data,
-				  struct mt76_sta_stats *stats)
+				  int pid, __le32 *txs_data)
 {
+	struct mt76_sta_stats *stats = &wcid->stats;
 	struct ieee80211_supported_band *sband;
 	struct mt76_phy *mphy;
 	struct ieee80211_tx_info *info;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 60ae834d95a6..3ae5f1359483 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1015,8 +1015,7 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 
 	msta = container_of(wcid, struct mt7915_sta, wcid);
 
-	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data,
-				     &msta->stats);
+	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data);
 	if (!wcid->sta)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index bd3386bf0f8a..090c52803052 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1224,7 +1224,7 @@ static void mt7915_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	if (msta->vif->mt76.idx != wi->idx)
 		return;
 
-	mt76_ethtool_worker(wi, &msta->stats);
+	mt76_ethtool_worker(wi, &msta->wcid.stats);
 }
 
 static
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 54ef2a12a443..1eb11617a625 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -127,8 +127,6 @@ struct mt7915_sta {
 	unsigned long jiffies;
 	unsigned long ampdu_state;
 
-	struct mt76_sta_stats stats;
-
 	struct mt76_connac_sta_key_conf bip;
 
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 47f0aa81ab02..71596024d61d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -539,8 +539,7 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 
 	msta = container_of(wcid, struct mt7921_sta, wcid);
 
-	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data,
-				     &msta->stats);
+	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data);
 	if (!wcid->sta)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 1438a9f8d1fd..e451280d9214 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1045,7 +1045,7 @@ mt7921_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	if (msta->vif->mt76.idx != wi->idx)
 		return;
 
-	mt76_ethtool_worker(wi, &msta->stats);
+	mt76_ethtool_worker(wi, &msta->wcid.stats);
 }
 
 static
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index c161031ac62a..ff109427b94c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -100,7 +100,6 @@ struct mt7921_sta {
 
 	unsigned long last_txs;
 	unsigned long ampdu_state;
-	struct mt76_sta_stats stats;
 
 	struct mt76_connac_sta_key_conf bip;
 };
-- 
2.36.1


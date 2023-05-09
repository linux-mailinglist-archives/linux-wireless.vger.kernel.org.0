Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB566FBDA5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 May 2023 05:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjEID2V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 23:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjEID1T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 23:27:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B181B83C5
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 20:26:57 -0700 (PDT)
X-UUID: 5746c582ee1911edb20a276fd37b9834-20230509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=02iqNIZa7RnGZJ8O44Cy2fajxZMVSC42yjQ4QFuIOMw=;
        b=lTaVgUF3l+VDJk+mNrQIQ/tMV+LK81PrOP/vyUrx65LP97ODaChN7DYlnaVDiy6rofPK9w/Jr6XVkiPkxlX5A3KmL3g9BEBD43g25NUW8Qpwwwg/krK8NhY+BFRV28I4uCcYt6XztoKtmlaLr8/OMzY9roGvpMzzOsasdHA8uMg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:463def6d-2202-4b81-82c0-38721d8ee23e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:697ab71,CLOUDID:78fb36c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 5746c582ee1911edb20a276fd37b9834-20230509
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1511384875; Tue, 09 May 2023 11:26:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 May 2023 11:26:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 May 2023 11:26:51 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v5] wifi: mt76: mt7915: report tx retries/failed counts for non-WED path
Date:   Tue, 9 May 2023 11:26:50 +0800
Message-ID: <13d9169b5709efad969d7d167a1ff19828395fed.1683602740.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get missing tx retries/failed counts from txfree done events and report
them via mt7915_sta_statistics().

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v5 - fix noacked
v4 - switch from Tx latency report to enable Tx count in txfree path for non-v3 format
v3 - add a missing check for mt7921
v2 - add a missing check for non-v3 format
---
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  7 ++++--
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  2 ++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 22 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  7 +++++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 12 +++++-----
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  3 +++
 6 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index ee0fbfcd07d6..6b515f330976 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -728,16 +728,19 @@ bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	skb = mt76_tx_status_skb_get(dev, wcid, pid, &list);
 	if (skb) {
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-		bool noacked = !(info->flags & IEEE80211_TX_STAT_ACK);
+		bool noacked;
 
 		if (!(le32_to_cpu(txs_data[0]) & MT_TXS0_ACK_ERROR_MASK))
 			info->flags |= IEEE80211_TX_STAT_ACK;
 
+		noacked = !(info->flags & IEEE80211_TX_STAT_ACK);
 		info->status.ampdu_len = 1;
 		info->status.ampdu_ack_len = !noacked;
 		info->status.rates[0].idx = -1;
 
-		wcid->stats.tx_failed += noacked;
+		/* avoid double counting if dev supports txfree event */
+		if (is_mt7921(dev))
+			wcid->stats.tx_failed += noacked;
 
 		mt76_connac2_mac_fill_txs(dev, wcid, txs_data);
 		mt76_tx_status_skb_done(dev, skb, &list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ac2049f49bb3..8d6e09605dc4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -581,6 +581,8 @@ void mt7915_mac_init(struct mt7915_dev *dev)
 
 	if (!is_mt7915(&dev->mt76))
 		mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
+	else
+		mt76_clear(dev, MT_PLE_HOST_RPT0, MT_PLE_HOST_RPT0_TX_LATENCY);
 
 	/* enable hardware de-agg */
 	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 7df8d95fc3fb..9b2ccd99854e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -951,6 +951,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
+	struct mt76_wcid *wcid = NULL;
 	LIST_HEAD(free_list);
 	void *end = data + len;
 	bool v3, wake = false;
@@ -977,7 +978,6 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 		info = le32_to_cpu(*cur_info);
 		if (info & MT_TX_FREE_PAIR) {
 			struct mt7915_sta *msta;
-			struct mt76_wcid *wcid;
 			u16 idx;
 
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
@@ -994,7 +994,25 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			continue;
 		}
 
-		if (v3 && (info & MT_TX_FREE_MPDU_HEADER))
+		if (!mtk_wed_device_active(&mdev->mmio.wed) && wcid) {
+			u32 tx_retries = 0, tx_failed = 0;
+
+			if (v3 && (info & MT_TX_FREE_MPDU_HEADER_V3)) {
+				tx_retries =
+					FIELD_GET(MT_TX_FREE_COUNT_V3, info) - 1;
+				tx_failed = tx_retries +
+					!!FIELD_GET(MT_TX_FREE_STAT_V3, info);
+			} else if (!v3 && (info & MT_TX_FREE_MPDU_HEADER)) {
+				tx_retries =
+					FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
+				tx_failed = tx_retries +
+					!!FIELD_GET(MT_TX_FREE_STAT, info);
+			}
+			wcid->stats.tx_retries += tx_retries;
+			wcid->stats.tx_failed += tx_failed;
+		}
+
+		if (v3 && (info & MT_TX_FREE_MPDU_HEADER_V3))
 			continue;
 
 		for (i = 0; i < 1 + v3; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index ce94f87e2042..448b1b380190 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -9,7 +9,12 @@
 #define MT_TX_FREE_VER			GENMASK(18, 16)
 #define MT_TX_FREE_MSDU_CNT_V0		GENMASK(6, 0)
 /* 0: success, others: dropped */
-#define MT_TX_FREE_MPDU_HEADER		BIT(30)
+#define MT_TX_FREE_COUNT		GENMASK(12, 0)
+#define MT_TX_FREE_COUNT_V3		GENMASK(27, 24)
+#define MT_TX_FREE_STAT			GENMASK(14, 13)
+#define MT_TX_FREE_STAT_V3		GENMASK(29, 28)
+#define MT_TX_FREE_MPDU_HEADER		BIT(15)
+#define MT_TX_FREE_MPDU_HEADER_V3	BIT(30)
 #define MT_TX_FREE_MSDU_ID_V3		GENMASK(14, 0)
 
 #define MT_TXS5_F0_FINAL_MPDU		BIT(31)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2ada2806de66..61157248d742 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1046,12 +1046,6 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->tx_packets = msta->wcid.stats.tx_packets;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 
-		sinfo->tx_failed = msta->wcid.stats.tx_failed;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
-
-		sinfo->tx_retries = msta->wcid.stats.tx_retries;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
-
 		if (mtk_wed_get_rx_capa(&phy->dev->mt76.mmio.wed)) {
 			sinfo->rx_bytes = msta->wcid.stats.rx_bytes;
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
@@ -1061,6 +1055,12 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 		}
 	}
 
+	sinfo->tx_failed = msta->wcid.stats.tx_failed;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+
+	sinfo->tx_retries = msta->wcid.stats.tx_retries;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+
 	sinfo->ack_signal = (s8)msta->ack_signal;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index c8e478a55081..71fa9576ad0e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -145,6 +145,9 @@ enum offs_rev {
 #define MT_PLE_BASE			0x820c0000
 #define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
 
+#define MT_PLE_HOST_RPT0		MT_PLE(0x030)
+#define MT_PLE_HOST_RPT0_TX_LATENCY	BIT(3)
+
 #define MT_FL_Q_EMPTY			MT_PLE(__OFFS(PLE_FL_Q_EMPTY))
 #define MT_FL_Q0_CTRL			MT_PLE(__OFFS(PLE_FL_Q_CTRL))
 #define MT_FL_Q2_CTRL			MT_PLE(__OFFS(PLE_FL_Q_CTRL) + 0x8)
-- 
2.18.0


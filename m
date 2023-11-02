Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A367DEF68
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 11:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346158AbjKBKEG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Nov 2023 06:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346118AbjKBKEC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Nov 2023 06:04:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B4112
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 03:03:56 -0700 (PDT)
X-UUID: 1f9e4108796711eea33bb35ae8d461a2-20231102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6tm6jshgx8T5Ti6+7XGq+GsuHEOIcZDBKFrCXiPYgjQ=;
        b=H7/7KWZtd1RUa4d1PmUAQLo9yn9eo3IXud4nm5AZaFywJ1RMjrWE8KvZPtnbtT3NtDuz6IeLYMhfNGgQoKuEpTIHSIREmRKX1hax06doNMMKmqNY6qqMaDZNnAjjc75Ru/0i4diCLThlQqjlLK7uD94sKDWEMP88SQviwXMjfjU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:09c77744-6df5-43a2-9d3d-34335e334904,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:2c58ef94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1f9e4108796711eea33bb35ae8d461a2-20231102
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1504829554; Thu, 02 Nov 2023 18:03:51 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 2 Nov 2023 18:03:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 2 Nov 2023 18:03:50 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 4/8] wifi: mt76: mt7996: switch to mcu command for TX GI report
Date:   Thu, 2 Nov 2023 18:02:58 +0800
Message-ID: <20231102100302.22160-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20231102100302.22160-1-shayne.chen@mediatek.com>
References: <20231102100302.22160-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Lin <benjamin-jw.lin@mediatek.com>

During runtime, the GI value in the WTBL is not updated in real-time. To
obtain the latest results for the TX GI, switch to use an MCU command.

Signed-off-by: Benjamin Lin <benjamin-jw.lin@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 48 ++-----------------
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 47 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 22 +++++++++
 5 files changed, 74 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 65844de6dccd..0185804d8ce3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1328,7 +1328,7 @@ enum {
 };
 
 enum UNI_ALL_STA_INFO_TAG {
-	UNI_ALL_STA_TX_RATE,
+	UNI_ALL_STA_TXRX_RATE,
 	UNI_ALL_STA_TX_STAT,
 	UNI_ALL_STA_TXRX_ADM_STAT,
 	UNI_ALL_STA_TXRX_AIR_TIME,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 56dfbeb51504..9db610e2645f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -102,7 +102,6 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 	};
 	struct ieee80211_sta *sta;
 	struct mt7996_sta *msta;
-	struct rate_info *rate;
 	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
 	LIST_HEAD(sta_poll_list);
 	int i;
@@ -118,7 +117,6 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		u32 addr, val;
 		u16 idx;
 		s8 rssi[4];
-		u8 bw;
 
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		if (list_empty(&sta_poll_list)) {
@@ -174,49 +172,6 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 			ieee80211_sta_register_airtime(sta, tid, tx_cur, rx_cur);
 		}
 
-		/* We don't support reading GI info from txs packets.
-		 * For accurate tx status reporting and AQL improvement,
-		 * we need to make sure that flags match so polling GI
-		 * from per-sta counters directly.
-		 */
-		rate = &msta->wcid.rate;
-
-		switch (rate->bw) {
-		case RATE_INFO_BW_320:
-			bw = IEEE80211_STA_RX_BW_320;
-			break;
-		case RATE_INFO_BW_160:
-			bw = IEEE80211_STA_RX_BW_160;
-			break;
-		case RATE_INFO_BW_80:
-			bw = IEEE80211_STA_RX_BW_80;
-			break;
-		case RATE_INFO_BW_40:
-			bw = IEEE80211_STA_RX_BW_40;
-			break;
-		default:
-			bw = IEEE80211_STA_RX_BW_20;
-			break;
-		}
-
-		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 6);
-		val = mt76_rr(dev, addr);
-		if (rate->flags & RATE_INFO_FLAGS_EHT_MCS) {
-			addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 5);
-			val = mt76_rr(dev, addr);
-			rate->eht_gi = FIELD_GET(GENMASK(25, 24), val);
-		} else if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
-			u8 offs = 24 + 2 * bw;
-
-			rate->he_gi = (val & (0x3 << offs)) >> offs;
-		} else if (rate->flags &
-			   (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
-			if (val & BIT(12 + bw))
-				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
-			else
-				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
-		}
-
 		/* get signal strength of resp frames (CTS/BA/ACK) */
 		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 34);
 		val = mt76_rr(dev, addr);
@@ -1298,6 +1253,8 @@ mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid,
 			goto out;
 
 		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
+			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
 		break;
 	case MT_PHY_TYPE_HE_SU:
 	case MT_PHY_TYPE_HE_EXT_SU:
@@ -2312,6 +2269,7 @@ void mt7996_mac_work(struct work_struct *work)
 
 		mt7996_mac_update_stats(phy);
 
+		mt7996_mcu_get_all_sta_info(phy, UNI_ALL_STA_TXRX_RATE);
 		if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
 			mt7996_mcu_get_all_sta_info(phy, UNI_ALL_STA_TXRX_ADM_STAT);
 			mt7996_mcu_get_all_sta_info(phy, UNI_ALL_STA_TXRX_MSDU_COUNT);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 7336eaa7b9ae..d9ba57ae9fdc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -998,6 +998,7 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 			sinfo->txrate.he_gi = txrate->he_gi;
 			sinfo->txrate.he_dcm = txrate->he_dcm;
 			sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
+			sinfo->txrate.eht_gi = txrate->eht_gi;
 		}
 		sinfo->txrate.flags = txrate->flags;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8141c24ade50..b8d0b52be1e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -449,6 +449,43 @@ mt7996_mcu_ie_countdown(struct mt7996_dev *dev, struct sk_buff *skb)
 	}
 }
 
+static int
+mt7996_mcu_update_tx_gi(struct rate_info *rate, struct all_sta_trx_rate *mcu_rate)
+{
+	switch (mcu_rate->tx_mode) {
+	case MT_PHY_TYPE_CCK:
+	case MT_PHY_TYPE_OFDM:
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+	case MT_PHY_TYPE_VHT:
+		if (mcu_rate->tx_gi)
+			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
+		else
+			rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		if (mcu_rate->tx_gi > NL80211_RATE_INFO_HE_GI_3_2)
+			return -EINVAL;
+		rate->he_gi = mcu_rate->tx_gi;
+		break;
+	case MT_PHY_TYPE_EHT_SU:
+	case MT_PHY_TYPE_EHT_TRIG:
+	case MT_PHY_TYPE_EHT_MU:
+		if (mcu_rate->tx_gi > NL80211_RATE_INFO_EHT_GI_3_2)
+			return -EINVAL;
+		rate->eht_gi = mcu_rate->tx_gi;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void
 mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 {
@@ -465,6 +502,16 @@ mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 		struct mt76_wcid *wcid;
 
 		switch (le16_to_cpu(res->tag)) {
+		case UNI_ALL_STA_TXRX_RATE:
+			wlan_idx = le16_to_cpu(res->rate[i].wlan_idx);
+			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+
+			if (!wcid)
+				break;
+
+			if (mt7996_mcu_update_tx_gi(&wcid->rate, &res->rate[i]))
+				dev_err(dev->mt76.dev, "Failed to update TX GI\n");
+			break;
 		case UNI_ALL_STA_TXRX_ADM_STAT:
 			wlan_idx = le16_to_cpu(res->adm_stat[i].wlan_idx);
 			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 1562c8a6a821..328edc354165 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -175,6 +175,27 @@ struct mt7996_mcu_mib {
 	__le64 data;
 } __packed;
 
+struct all_sta_trx_rate {
+	__le16 wlan_idx;
+	u8 __rsv1[2];
+	u8 tx_mode;
+	u8 flags;
+	u8 tx_stbc;
+	u8 tx_gi;
+	u8 tx_bw;
+	u8 tx_ldpc;
+	u8 tx_mcs;
+	u8 tx_nss;
+	u8 rx_rate;
+	u8 rx_mode;
+	u8 rx_nsts;
+	u8 rx_gi;
+	u8 rx_coding;
+	u8 rx_stbc;
+	u8 rx_bw;
+	u8 __rsv2;
+} __packed;
+
 struct mt7996_mcu_all_sta_info_event {
 	u8 rsv[4];
 	__le16 tag;
@@ -185,6 +206,7 @@ struct mt7996_mcu_all_sta_info_event {
 	u8 rsv3[2];
 
 	union {
+		struct all_sta_trx_rate rate[0];
 		struct {
 			__le16 wlan_idx;
 			u8 rsv[2];
-- 
2.39.2


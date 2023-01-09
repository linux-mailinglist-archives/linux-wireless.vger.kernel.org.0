Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF04662C29
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 18:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbjAIRGn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 12:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbjAIQ6Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 11:58:16 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4553DBE0
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 08:58:10 -0800 (PST)
X-UUID: 2956419f75a946b7992265de30221175-20230110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DdPMItW0J1+1WKgUkqkf4uAqNSmGg8Y3wMzxtnCbEDs=;
        b=LXHe7aXLiaaG38qgiZNzqJg//PcV9KhuF/OoQUzLMHH1YACtK2sNGzrr58tVI4LVDByCxgzocAmy5zQYYGWkTNmWR4EoGZ2tyGQ3CVqfA98gKZfZJyU5oSEd1i1215TKZpulV9JbBvQ3enVR6Pv/wNiUCn6yinOJl8Kyx7LzBos=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:0eb617e8-c9e0-45ed-85c8-d1e4ec9f053a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:bfc84af5-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 2956419f75a946b7992265de30221175-20230110
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1730606468; Tue, 10 Jan 2023 00:58:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 10 Jan 2023 00:58:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 10 Jan 2023 00:58:06 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>
Subject: [PATCH 11/13] wifi: mt76: mt7996: add support for EHT rate report
Date:   Tue, 10 Jan 2023 00:57:29 +0800
Message-ID: <20230109165731.682-12-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230109165731.682-1-shayne.chen@mediatek.com>
References: <20230109165731.682-1-shayne.chen@mediatek.com>
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

Currenly only EHT TX rate report is supported. EHT RX rate is temporally
reported with HE rate.

Co-developed-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  8 ++---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 34 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 3d4fbbbcc206..9c5e9ac1c335 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -791,10 +791,10 @@ static ssize_t mt7996_sta_fixed_rate_set(struct file *file,
 	else
 		buf[count] = '\0';
 
-	/* mode - cck: 0, ofdm: 1, ht: 2, gf: 3, vht: 4, he_su: 8, he_er: 9
-	 * bw - bw20: 0, bw40: 1, bw80: 2, bw160: 3
-	 * nss - vht: 1~4, he: 1~4, others: ignore
-	 * mcs - cck: 0~4, ofdm: 0~7, ht: 0~32, vht: 0~9, he_su: 0~11, he_er: 0~2
+	/* mode - cck: 0, ofdm: 1, ht: 2, gf: 3, vht: 4, he_su: 8, he_er: 9 EHT: 15
+	 * bw - bw20: 0, bw40: 1, bw80: 2, bw160: 3, BW320: 4
+	 * nss - vht: 1~4, he: 1~4, eht: 1~4, others: ignore
+	 * mcs - cck: 0~4, ofdm: 0~7, ht: 0~32, vht: 0~9, he_su: 0~11, he_er: 0~2, eht: 0~13
 	 * gi - (ht/vht) lgi: 0, sgi: 1; (he) 0.8us: 0, 1.6us: 1, 3.2us: 2
 	 * preamble - short: 1, long: 0
 	 * ldpc - off: 0, on: 1
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 31e6c48985d3..8f664c10f93b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -189,6 +189,9 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		rate = &msta->wcid.rate;
 
 		switch (rate->bw) {
+		case RATE_INFO_BW_320:
+			bw = IEEE80211_STA_RX_BW_320;
+			break;
 		case RATE_INFO_BW_160:
 			bw = IEEE80211_STA_RX_BW_160;
 			break;
@@ -205,7 +208,11 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 
 		addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 6);
 		val = mt76_rr(dev, addr);
-		if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
+		if (rate->flags & RATE_INFO_FLAGS_EHT_MCS) {
+			addr = mt7996_mac_wtbl_lmac_addr(dev, idx, 5);
+			val = mt76_rr(dev, addr);
+			rate->eht_gi = FIELD_GET(GENMASK(25, 24), val);
+		} else if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
 			u8 offs = 24 + 2 * bw;
 
 			rate->he_gi = (val & (0x3 << offs)) >> offs;
@@ -560,6 +567,15 @@ mt7996_mac_fill_rx_rate(struct mt7996_dev *dev,
 
 		status->he_dcm = dcm;
 		break;
+	case MT_PHY_TYPE_EHT_SU:
+	case MT_PHY_TYPE_EHT_TRIG:
+	case MT_PHY_TYPE_EHT_MU:
+		/* TODO: currently report rx rate with HE rate */
+		status->nss = nss;
+		status->encoding = RX_ENC_HE;
+		bw = min_t(int, bw, IEEE80211_STA_RX_BW_160);
+		i = min_t(int, i & 0xf, 11);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -584,6 +600,9 @@ mt7996_mac_fill_rx_rate(struct mt7996_dev *dev,
 	case IEEE80211_STA_RX_BW_160:
 		status->bw = RATE_INFO_BW_160;
 		break;
+	case IEEE80211_STA_RX_BW_320:
+		status->bw = RATE_INFO_BW_320;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1434,6 +1453,15 @@ mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid, int pid,
 		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
 		rate.flags = RATE_INFO_FLAGS_HE_MCS;
 		break;
+	case MT_PHY_TYPE_EHT_SU:
+	case MT_PHY_TYPE_EHT_TRIG:
+	case MT_PHY_TYPE_EHT_MU:
+		if (rate.mcs > 13)
+			goto out;
+
+		rate.eht_gi = wcid->rate.eht_gi;
+		rate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		break;
 	default:
 		goto out;
 	}
@@ -1441,6 +1469,10 @@ mt7996_mac_add_txs_skb(struct mt7996_dev *dev, struct mt76_wcid *wcid, int pid,
 	stats->tx_mode[mode]++;
 
 	switch (FIELD_GET(MT_TXS0_BW, txs)) {
+	case IEEE80211_STA_RX_BW_320:
+		rate.bw = RATE_INFO_BW_320;
+		stats->tx_bw[4]++;
+		break;
 	case IEEE80211_STA_RX_BW_160:
 		rate.bw = RATE_INFO_BW_160;
 		stats->tx_bw[3]++;
-- 
2.25.1


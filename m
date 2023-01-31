Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299516828F7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjAaJgr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAaJgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADD2E0D2
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:36:38 -0800 (PST)
X-UUID: be7339e6a14a11ed945fc101203acc17-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hujgxv3dju9uJu1PuoEEmecY0FaFk78aEsFqKQ3slGw=;
        b=bT00wIHxks/uPhKBB15d12Re7tRMmfx/FmEQnItNy3ykn5VQIQBIzo4R+Abiiqym/PvO5d1SyOG3wxO6jeECtW2etMLJBNGjMkadaYMx7eKnb2Biqe4Al3oRvGzlzzoVFKU0iScHdDraIYB8Cp26dOvvjMMO7eeGYdObmWgY/uw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:21777abc-47bc-45de-8a7f-c717b330a15c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:21777abc-47bc-45de-8a7f-c717b330a15c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:1965da55-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230131173633R07UG1JY,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: be7339e6a14a11ed945fc101203acc17-20230131
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 292775989; Tue, 31 Jan 2023 17:36:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 31 Jan 2023 17:36:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:36:30 +0800
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
Subject: [PATCH v2 11/13] wifi: mt76: mt7996: add support for EHT rate report
Date:   Tue, 31 Jan 2023 17:36:09 +0800
Message-ID: <20230131093611.30914-12-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230131093611.30914-1-shayne.chen@mediatek.com>
References: <20230131093611.30914-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
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
index bdc54ff74311..edea96f60f1e 100644
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


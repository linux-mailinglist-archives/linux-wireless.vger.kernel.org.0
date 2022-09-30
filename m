Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8491B5F0E86
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 17:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiI3PNu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 11:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiI3PNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 11:13:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F74012935F
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 08:13:46 -0700 (PDT)
X-UUID: 09a5eebdd4604e54b66cca42e0d25630-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oeGtZ9PAst3+jtVOB7fD8m6J5m3ZzOOccwMwscJjsZE=;
        b=l2Qe/R8RoeVgeJOKQHm73CM40bmtMoEyO6lvT3M19KXtuY1rxpgMzEP6Yav4f2pFwQSCLlIC7OvHlEBn5MtrEkaiosDhgxQsXVBcGNkXDZrI1VZ9fOOtBAGL6O558J8AyfJKDKa2m3a9rqB3GptCBFvnhF6tyWvkx5u7087s9So=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:9565d742-a9f5-4167-86a1-1b3bd487516f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.11,REQID:9565d742-a9f5-4167-86a1-1b3bd487516f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:39a5ff1,CLOUDID:9c4fcde4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:22093023134266GOO50Z,BulkQuantity:0,Recheck:0,SF:28|16|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: 09a5eebdd4604e54b66cca42e0d25630-20220930
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 554090066; Fri, 30 Sep 2022 23:13:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 30 Sep 2022 23:13:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 23:13:40 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 4/6] wifi: mt76: connac: introduce mt76_connac_spe_idx()
Date:   Fri, 30 Sep 2022 23:13:13 +0800
Message-ID: <20220930151315.19012-4-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220930151315.19012-1-shayne.chen@mediatek.com>
References: <20220930151315.19012-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add mt76_connac_spe_idx() for antenna mask to spatial extension
index conversion. This is used to support flexible control of
tx antenna.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 11 ++++++++---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  2 +-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 635192c878cb..0915eb579539 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -261,6 +261,17 @@ mt76_connac_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 	return (void *)(txwi + MT_TXD_SIZE);
 }
 
+static inline u8 mt76_connac_spe_idx(u8 antenna_mask)
+{
+	static const u8 ant_to_spe[] = {0, 0, 1, 0, 3, 2, 4, 0,
+					9, 8, 6, 10, 16, 12, 18, 0};
+
+	if (antenna_mask >= sizeof(ant_to_spe))
+		return 0;
+
+	return ant_to_spe[antenna_mask];
+}
+
 int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm);
 void mt76_connac_power_save_sched(struct mt76_phy *phy,
 				  struct mt76_connac_pm *pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 34ac3d81a510..8b7ec64abc95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -417,9 +417,6 @@ mt76_connac2_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
 	if (ieee80211_is_beacon(fc)) {
 		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
 		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
-		if (!is_mt7921(dev))
-			txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX,
-							  0x18));
 	}
 
 	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
@@ -550,6 +547,14 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 		val |= FIELD_PREP(MT_TXD6_TX_RATE, rate);
 		txwi[6] |= cpu_to_le32(val);
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
+
+		if (!is_mt7921(dev)) {
+			u8 spe_idx = mt76_connac_spe_idx(mphy->antenna_mask);
+
+			if (!spe_idx)
+				spe_idx = 24 + phy_idx;
+			txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX, spe_idx));
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_write_txwi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 718f427d8f6b..cf4ce3b1fc21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -580,7 +580,7 @@ struct sta_rec_ra_fixed {
 
 	struct sta_phy phy;
 
-	u8 spe_en;
+	u8 spe_idx;
 	u8 short_preamble;
 	u8 is_5g;
 	u8 mmps_mode;
-- 
2.25.1


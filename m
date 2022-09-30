Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32CD5F0E84
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiI3PNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiI3PNu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 11:13:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F2C129FF6
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 08:13:49 -0700 (PDT)
X-UUID: c484e1f76b61458cb059182d9bb598df-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vro4aNeMhnKxMo5JO2QxA75dEAUKWi1vnfiFMdsxajM=;
        b=Ku3YdTxfx8yes2Da0gS2qBQOI8eN0Ilp5tuNfff0kZ6h9KePNS/IG8Cd4dgB4TDN2VuxIHCn8tM7htGfYABdY1TFzOvObK9tKFKynLqDbR1sfBk9jEHDs1ku2FOVqeT4va/F/j/6ZzYtaGJfLr6Rcm+f7rHB0xnFmgJBApOe2wo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:c94cead7-83ba-4055-abdb-45455b935799,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:2479a6a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c484e1f76b61458cb059182d9bb598df-20220930
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 165673610; Fri, 30 Sep 2022 23:13:44 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 30 Sep 2022 23:13:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 23:13:42 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 5/6] wifi: mt76: mt7915: add spatial extension index support
Date:   Fri, 30 Sep 2022 23:13:14 +0800
Message-ID: <20220930151315.19012-5-shayne.chen@mediatek.com>
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

In previous, we only allow user to configure tx antenna mask
contiguously (e.g. 0x3, 0xf).
This patch allows user to configure tx antenna mask interleavingly
(e.g. 0x5, 0x8). By setting proper antenna mask and nss, user can
prioritized the signal of different antennas, which helps to test
their performance in normal mode.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  3 ---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 20 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  4 +---
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 8379fbbeaaea..c5d289ac07bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -958,9 +958,6 @@ mt7915_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
 		return -EINVAL;
 
-	if ((BIT(hweight8(tx_ant)) - 1) != tx_ant)
-		tx_ant = BIT(ffs(tx_ant) - 1) - 1;
-
 	mutex_lock(&dev->mt76.mutex);
 
 	phy->mt76->antenna_mask = tx_ant;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 56491364a903..6a1ef3056e22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1306,6 +1306,9 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 	case RATE_PARAM_MMPS_UPDATE:
 		ra->mmps_mode = mt7915_mcu_get_mmps_mode(sta->deflink.smps_mode);
 		break;
+	case RATE_PARAM_SPE_UPDATE:
+		ra->spe_idx = *(u8 *)data;
+		break;
 	default:
 		break;
 	}
@@ -1348,6 +1351,18 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 					      RATE_PARAM_MMPS_UPDATE);
 }
 
+static int
+mt7915_mcu_set_spe_idx(struct mt7915_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt76_phy *mphy = mvif->phy->mt76;
+	u8 spe_idx = mt76_connac_spe_idx(mphy->antenna_mask);
+
+	return mt7915_mcu_set_fixed_rate_ctrl(dev, vif, sta, &spe_idx,
+					      RATE_PARAM_SPE_UPDATE);
+}
+
 static int
 mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 			       struct ieee80211_vif *vif,
@@ -1435,7 +1450,7 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 			return ret;
 	}
 
-	return 0;
+	return mt7915_mcu_set_spe_idx(dev, vif, sta);
 }
 
 static void
@@ -2648,6 +2663,9 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	}
 #endif
 
+	if (mt76_connac_spe_idx(phy->mt76->antenna_mask))
+		req.tx_streams_num = fls(phy->mt76->antenna_mask);
+
 	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
 	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index cd1edf553fc1..87cd1bfff3e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -394,6 +394,7 @@ enum {
 	RATE_PARAM_FIXED_MCS,
 	RATE_PARAM_FIXED_GI = 11,
 	RATE_PARAM_AUTO = 20,
+	RATE_PARAM_SPE_UPDATE = 22,
 };
 
 #define RATE_CFG_MCS			GENMASK(3, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index e1838f046568..a979460fad2d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -432,8 +432,6 @@ mt7915_tm_update_channel(struct mt7915_phy *phy)
 static void
 mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 {
-	static const u8 spe_idx_map[] = {0, 0, 1, 0, 3, 2, 4, 0,
-					 9, 8, 6, 10, 16, 12, 18, 0};
 	struct mt76_testmode_data *td = &phy->mt76->test;
 	struct mt7915_dev *dev = phy->dev;
 	struct ieee80211_tx_info *info;
@@ -450,7 +448,7 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 		if (td->tx_spe_idx)
 			phy->test.spe_idx = td->tx_spe_idx;
 		else
-			phy->test.spe_idx = spe_idx_map[td->tx_antenna_mask];
+			phy->test.spe_idx = mt76_connac_spe_idx(td->tx_antenna_mask);
 	}
 
 	mt7915_tm_set_tam_arb(phy, en,
-- 
2.25.1


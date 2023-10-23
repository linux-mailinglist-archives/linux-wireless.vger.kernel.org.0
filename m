Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878147D3B18
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjJWPmQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 11:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJWPmM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 11:42:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6E9103
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 08:42:08 -0700 (PDT)
X-UUID: b3f982c271ba11ee8051498923ad61e6-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=D0XND4IqUDrMYvtjEGFEdGFtiy9DYjSDrg5ZgTztJ7M=;
        b=IMXXNZRPEWTHYg0NntxqYIUhrrsRJdx7ABldlZHp5Qa83vEC3K0WcgW0PN0di75vpsbx/vATEEIbr5hACGaRRqWSCxADjHOwjuAdTMJ59giyUQKtr9zBogLe8SZRIf0rV3HQba2jVIQoyeXmaLpF19TRrgoTdIGafwyl3giR8tw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ad19c5c3-1034-4bb0-b3d4-770a38473a7e,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:8edb0d7d-ccd9-4df5-91ce-9df5fea3ae01,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b3f982c271ba11ee8051498923ad61e6-20231023
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1458801831; Mon, 23 Oct 2023 23:41:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 23:41:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 23:41:58 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: [PATCH 01/11] wifi: mt76: mt7996: add support for variants with auxiliary RX path
Date:   Mon, 23 Oct 2023 23:38:44 +0800
Message-ID: <20231023153854.10708-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to correctly configure the rx chainmask of variants that
have additional auxiliary RX path. e.g., 4T5R.
The auxiliary RX path is transparent to driver, but driver needs to
correctly configure it in the set channel fw command.

Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7996/eeprom.c    | 21 +++++++++++++++----
 .../wireless/mediatek/mt76/mt7996/eeprom.h    |  3 +++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  2 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    | 14 +++++++++++++
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 544b6c6f1ea3..9db7e531076d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -148,36 +148,49 @@ static int mt7996_eeprom_parse_band_config(struct mt7996_phy *phy)
 
 int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy)
 {
-	u8 path, nss, band_idx = phy->mt76->band_idx;
+	u8 path, rx_path, nss, band_idx = phy->mt76->band_idx;
 	u8 *eeprom = dev->mt76.eeprom.data;
 	struct mt76_phy *mphy = phy->mt76;
+	int max_path = 5, max_nss = 4;
 	int ret;
 
 	switch (band_idx) {
 	case MT_BAND1:
 		path = FIELD_GET(MT_EE_WIFI_CONF2_TX_PATH_BAND1,
 				 eeprom[MT_EE_WIFI_CONF + 2]);
+		rx_path = FIELD_GET(MT_EE_WIFI_CONF3_RX_PATH_BAND1,
+				    eeprom[MT_EE_WIFI_CONF + 3]);
 		nss = FIELD_GET(MT_EE_WIFI_CONF5_STREAM_NUM_BAND1,
 				eeprom[MT_EE_WIFI_CONF + 5]);
 		break;
 	case MT_BAND2:
 		path = FIELD_GET(MT_EE_WIFI_CONF2_TX_PATH_BAND2,
 				 eeprom[MT_EE_WIFI_CONF + 2]);
+		rx_path = FIELD_GET(MT_EE_WIFI_CONF4_RX_PATH_BAND2,
+				    eeprom[MT_EE_WIFI_CONF + 4]);
 		nss = FIELD_GET(MT_EE_WIFI_CONF5_STREAM_NUM_BAND2,
 				eeprom[MT_EE_WIFI_CONF + 5]);
 		break;
 	default:
 		path = FIELD_GET(MT_EE_WIFI_CONF1_TX_PATH_BAND0,
 				 eeprom[MT_EE_WIFI_CONF + 1]);
+		rx_path = FIELD_GET(MT_EE_WIFI_CONF3_RX_PATH_BAND0,
+				    eeprom[MT_EE_WIFI_CONF + 3]);
 		nss = FIELD_GET(MT_EE_WIFI_CONF4_STREAM_NUM_BAND0,
 				eeprom[MT_EE_WIFI_CONF + 4]);
 		break;
 	}
 
-	if (!path || path > 4)
-		path = 4;
+	if (!path || path > max_path)
+		path = max_path;
 
-	nss = min_t(u8, min_t(u8, 4, nss), path);
+	if (!nss || nss > max_nss)
+		nss = max_nss;
+
+	nss = min_t(u8, nss, path);
+
+	if (path != rx_path)
+		phy->has_aux_rx = true;
 
 	mphy->antenna_mask = BIT(nss) - 1;
 	mphy->chainmask = (BIT(path) - 1) << dev->chainshift[band_idx];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
index 0c749774f6b1..412d6e2f8014 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
@@ -33,6 +33,9 @@ enum mt7996_eeprom_field {
 #define MT_EE_WIFI_CONF1_TX_PATH_BAND0		GENMASK(5, 3)
 #define MT_EE_WIFI_CONF2_TX_PATH_BAND1		GENMASK(2, 0)
 #define MT_EE_WIFI_CONF2_TX_PATH_BAND2		GENMASK(5, 3)
+#define MT_EE_WIFI_CONF3_RX_PATH_BAND0		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF3_RX_PATH_BAND1		GENMASK(5, 3)
+#define MT_EE_WIFI_CONF4_RX_PATH_BAND2		GENMASK(2, 0)
 #define MT_EE_WIFI_CONF4_STREAM_NUM_BAND0	GENMASK(5, 3)
 #define MT_EE_WIFI_CONF5_STREAM_NUM_BAND1	GENMASK(2, 0)
 #define MT_EE_WIFI_CONF5_STREAM_NUM_BAND2	GENMASK(5, 3)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 61de5e041627..e379ac4cc5d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -3299,7 +3299,7 @@ int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag)
 		.center_ch = ieee80211_frequency_to_channel(freq1),
 		.bw = mt76_connac_chan_bw(chandef),
 		.tx_path_num = hweight16(phy->mt76->chainmask),
-		.rx_path = phy->mt76->chainmask >> dev->chainshift[band_idx],
+		.rx_path = mt7996_rx_chainmask(phy) >> dev->chainshift[band_idx],
 		.band_idx = band_idx,
 		.channel_band = ch_band[chandef->chan->band],
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index e7818b2b253f..6acc0ae286fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -210,6 +210,8 @@ struct mt7996_phy {
 
 	struct mt76_mib_stats mib;
 	struct mt76_channel_state state_ts;
+
+	bool has_aux_rx;
 };
 
 struct mt7996_dev {
@@ -501,6 +503,18 @@ static inline void mt7996_irq_disable(struct mt7996_dev *dev, u32 mask)
 void mt7996_memcpy_fromio(struct mt7996_dev *dev, void *buf, u32 offset,
 			  size_t len);
 
+static inline u16 mt7996_rx_chainmask(struct mt7996_phy *phy)
+{
+	int max_nss = hweight8(phy->mt76->hw->wiphy->available_antennas_tx);
+	int cur_nss = hweight8(phy->mt76->antenna_mask);
+	u16 tx_chainmask = phy->mt76->chainmask;
+
+	if (cur_nss != max_nss)
+		return tx_chainmask;
+
+	return tx_chainmask | (BIT(fls(tx_chainmask)) * phy->has_aux_rx);
+}
+
 void mt7996_mac_init(struct mt7996_dev *dev);
 u32 mt7996_mac_wtbl_lmac_addr(struct mt7996_dev *dev, u16 wcid, u8 dw);
 bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask);
-- 
2.39.2


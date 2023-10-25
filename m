Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09847D789F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 01:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjJYXej (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 19:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJYXeh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 19:34:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A83313A
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 16:34:31 -0700 (PDT)
X-UUID: 07fe3c52738f11ee8051498923ad61e6-20231026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BO8xex5TrqKc5bh/hA+OWln73QdvPyAo1WOD+A9cnLY=;
        b=cakzDXp9PjZWLEHBOvwe85foTmN85PQRz5ImF0GO87lsBtT5/gPkchBq6q2k8gTdxbHLf8n712o8M0qSTI3IWu1wKIFv/9l+N3tLFhjn1lJdtd9UenxWlZr6DMVr5AFAAsk3h2HXTQWFUPGcf1vt6jH18+eyoplm9s9xuqHAv8o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:a92f932b-2313-4d2e-9309-a91c8ddb0529,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:5f78ec9,CLOUDID:2377c6fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 07fe3c52738f11ee8051498923ad61e6-20231026
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 457424361; Thu, 26 Oct 2023 07:34:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Oct 2023 07:34:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Oct 2023 07:34:22 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt7915: enable mt7986 and mt7916 pre-calibration support
Date:   Thu, 26 Oct 2023 07:34:20 +0800
Message-ID: <f21b261373fc221b8370264c44ee751fa85cf41c.1698274193.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.657900-8.000000
X-TMASE-MatchedRID: fnR2S3QqRUoVAKRaMHqjDlz+axQLnAVBI5K4Cd+0ao/N1rLqpIKz42mt
        ukJWdiprNJnt9TW/xwZX/sAhRmSCr+n7m7FfgPpPS3OTftLNfg05QyrxWymujdq1QfwtMOlPpQm
        bCq8RaKGyNEPkdHcNkr/yMxJu7qUwlwt7DABrvp+O0rt0LpQGeWf6wD367Vgt82HMiBe0UlUYEU
        tWQA3BEMSUQ1jnXMOcMdLQNZUMEkTx3YzTiJbL8h3EEAbn+GRbU+A7YkpDJ1i+FARAmHPCpuJz0
        /I2b9TR4vM1YF6AJbbCCfuIMF6xLcK21zBg2KlfGM6W3U+LnndyhLF+UJD6ydHOvrNLoDEnJMLo
        W9dlXdp7a5Ka2JuTgg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.657900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3B8F6AA5FE336E0DBE28363D30D2A0D7C440CBEBAC3059ADF149881E885CD6BC2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Add pre-calibration for mt7986 and mt7916. Their group cal size are
54k and 94k for 2G + 5G and 2G + 6G, respectively. DPD size is 300k.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  11 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |  34 +++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 100 ++++++++++++++----
 3 files changed, 114 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 76be7308460b..45b216ca7c3c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -9,16 +9,15 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	u8 *eeprom = mdev->eeprom.data;
-	u32 val = eeprom[MT_EE_DO_PRE_CAL];
-	u32 offs;
+	u32 offs = is_mt7915(&dev->mt76) ? MT_EE_DO_PRE_CAL : MT_EE_DO_PRE_CAL_V2;
+	u32 val;
 
-	if (!dev->flash_mode)
+	if (!dev->flash_mode || !eeprom[offs])
 		return 0;
 
-	if (val != (MT_EE_WIFI_CAL_DPD | MT_EE_WIFI_CAL_GROUP))
-		return 0;
+	val = mt7915_get_cal_group_size(dev) +
+	      (is_mt7915(&dev->mt76) ? MT_EE_CAL_DPD_SIZE : MT_EE_CAL_DPD_SIZE_V2);
 
-	val = MT_EE_CAL_GROUP_SIZE + MT_EE_CAL_DPD_SIZE;
 	dev->cal = devm_kzalloc(mdev->dev, val, GFP_KERNEL);
 	if (!dev->cal)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index f3e56817d36e..84c1903b2a6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -19,6 +19,7 @@ enum mt7915_eeprom_field {
 	MT_EE_DDIE_FT_VERSION =	0x050,
 	MT_EE_DO_PRE_CAL =	0x062,
 	MT_EE_WIFI_CONF =	0x190,
+	MT_EE_DO_PRE_CAL_V2 =	0x19a,
 	MT_EE_RATE_DELTA_2G =	0x252,
 	MT_EE_RATE_DELTA_5G =	0x29d,
 	MT_EE_TX0_POWER_2G =	0x2fc,
@@ -39,10 +40,18 @@ enum mt7915_eeprom_field {
 };
 
 #define MT_EE_WIFI_CAL_GROUP			BIT(0)
-#define MT_EE_WIFI_CAL_DPD			GENMASK(2, 1)
+#define MT_EE_WIFI_CAL_DPD_5G			BIT(1)
+#define MT_EE_WIFI_CAL_DPD_2G			BIT(2)
+#define MT_EE_WIFI_CAL_DPD_6G			BIT(3)
+#define MT_EE_WIFI_CAL_DPD			GENMASK(3, 1)
 #define MT_EE_CAL_UNIT				1024
-#define MT_EE_CAL_GROUP_SIZE			(49 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7915		(49 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7916		(54 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7975		(54 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7976		(94 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7916_6G		(94 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_DPD_SIZE			(54 * MT_EE_CAL_UNIT)
+#define MT_EE_CAL_DPD_SIZE_V2			(300 * MT_EE_CAL_UNIT)
 
 #define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
 #define MT_EE_WIFI_CONF0_BAND_SEL		GENMASK(7, 6)
@@ -155,6 +164,27 @@ mt7915_tssi_enabled(struct mt7915_dev *dev, enum nl80211_band band)
 		return val & MT_EE_WIFI_CONF7_TSSI0_5G;
 }
 
+static inline u32
+mt7915_get_cal_group_size(struct mt7915_dev *dev)
+{
+	if (is_mt7915(&dev->mt76)) {
+		return MT_EE_CAL_GROUP_SIZE_7915;
+	} else if (is_mt7916(&dev->mt76)) {
+		u8 *eep = dev->mt76.eeprom.data;
+		u32 val = eep[MT_EE_WIFI_CONF + 1];
+
+		val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
+
+		return (val == MT_EE_V2_BAND_SEL_6GHZ) ?
+			MT_EE_CAL_GROUP_SIZE_7916_6G :
+			MT_EE_CAL_GROUP_SIZE_7916;
+	} else if (mt7915_check_adie(dev, false)) {
+		return MT_EE_CAL_GROUP_SIZE_7976;
+	} else {
+		return MT_EE_CAL_GROUP_SIZE_7975;
+	}
+}
+
 extern const u8 mt7915_sku_group_len[MAX_SKU_RATE_GROUP_NUM];
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b22f06d4411a..da3ee9f91704 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2904,9 +2904,10 @@ static int mt7915_mcu_set_pre_cal(struct mt7915_dev *dev, u8 idx,
 int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev)
 {
 	u8 idx = 0, *cal = dev->cal, *eep = dev->mt76.eeprom.data;
-	u32 total = MT_EE_CAL_GROUP_SIZE;
+	u32 total = mt7915_get_cal_group_size(dev);
+	u32 offs = is_mt7915(&dev->mt76) ? MT_EE_DO_PRE_CAL : MT_EE_DO_PRE_CAL_V2;
 
-	if (!(eep[MT_EE_DO_PRE_CAL] & MT_EE_WIFI_CAL_GROUP))
+	if (!(eep[offs] & MT_EE_WIFI_CAL_GROUP))
 		return 0;
 
 	/*
@@ -2942,9 +2943,9 @@ static int mt7915_find_freq_idx(const u16 *freqs, int n_freqs, u16 cur)
 	return -1;
 }
 
-static int mt7915_dpd_freq_idx(u16 freq, u8 bw)
+static int mt7915_dpd_freq_idx(struct mt7915_dev *dev, u16 freq, u8 bw)
 {
-	static const u16 freq_list[] = {
+	const u16 freq_list_v1[] = {
 		5180, 5200, 5220, 5240,
 		5260, 5280, 5300, 5320,
 		5500, 5520, 5540, 5560,
@@ -2952,65 +2953,118 @@ static int mt7915_dpd_freq_idx(u16 freq, u8 bw)
 		5660, 5680, 5700, 5745,
 		5765, 5785, 5805, 5825
 	};
-	int offset_2g = ARRAY_SIZE(freq_list);
-	int idx;
+	const u16 freq_list_v2[] = {
+		/* 6G BW20 */
+		5955, 5975, 5995, 6015,
+		6035, 6055, 6075, 6095,
+		6115, 6135, 6155, 6175,
+		6195, 6215, 6235, 6255,
+		6275, 6295, 6315, 6335,
+		6355, 6375, 6395, 6415,
+		6435, 6455, 6475, 6495,
+		6515, 6535, 6555, 6575,
+		6595, 6615, 6635, 6655,
+		6675, 6695, 6715, 6735,
+		6755, 6775, 6795, 6815,
+		6835, 6855, 6875, 6895,
+		6915, 6935, 6955, 6975,
+		6995, 7015, 7035, 7055,
+		7075, 7095, 7115,
+		/* 6G BW160 */
+		6025, 6185, 6345, 6505,
+		6665, 6825, 6985,
+		/* 5G BW20 */
+		5180, 5200, 5220, 5240,
+		5260, 5280, 5300, 5320,
+		5500, 5520, 5540, 5560,
+		5580, 5600, 5620, 5640,
+		5660, 5680, 5700, 5720,
+		5745, 5765, 5785, 5805,
+		5825, 5845, 5865, 5885,
+		/* 5G BW160 */
+		5250, 5570, 5815
+	};
+	const u16 *freq_list;
+	int n_freqs, idx;
+
+	if (is_mt7915(&dev->mt76)) {
+		freq_list = freq_list_v1;
+		n_freqs = ARRAY_SIZE(freq_list_v1);
+	} else {
+		freq_list = freq_list_v2;
+		n_freqs = ARRAY_SIZE(freq_list_v2);
+	}
 
 	if (freq < 4000) {
 		if (freq < 2432)
-			return offset_2g;
+			return n_freqs;
 		if (freq < 2457)
-			return offset_2g + 1;
+			return n_freqs + 1;
 
-		return offset_2g + 2;
+		return n_freqs + 2;
 	}
 
-	if (bw == NL80211_CHAN_WIDTH_80P80 || bw == NL80211_CHAN_WIDTH_160)
+	if (bw == NL80211_CHAN_WIDTH_80P80)
 		return -1;
 
 	if (bw != NL80211_CHAN_WIDTH_20) {
-		idx = mt7915_find_freq_idx(freq_list, ARRAY_SIZE(freq_list),
-					   freq + 10);
+		idx = mt7915_find_freq_idx(freq_list, n_freqs, freq + 10);
 		if (idx >= 0)
 			return idx;
 
-		idx = mt7915_find_freq_idx(freq_list, ARRAY_SIZE(freq_list),
-					   freq - 10);
+		idx = mt7915_find_freq_idx(freq_list, n_freqs, freq - 10);
 		if (idx >= 0)
 			return idx;
 	}
 
-	return mt7915_find_freq_idx(freq_list, ARRAY_SIZE(freq_list), freq);
+	return mt7915_find_freq_idx(freq_list, n_freqs, freq);
 }
 
 int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
-	u16 total = 2, center_freq = chandef->center_freq1;
-	u8 *cal = dev->cal, *eep = dev->mt76.eeprom.data;
+	u32 offs = is_mt7915(&dev->mt76) ? MT_EE_DO_PRE_CAL : MT_EE_DO_PRE_CAL_V2;
+	u8 mask, num, *cal = dev->cal, *eep = dev->mt76.eeprom.data;
 	int idx;
 
-	if (!(eep[MT_EE_DO_PRE_CAL] & MT_EE_WIFI_CAL_DPD))
+	switch (chandef->chan->band) {
+	case NL80211_BAND_2GHZ:
+		mask = MT_EE_WIFI_CAL_DPD_2G;
+		break;
+	case NL80211_BAND_5GHZ:
+		mask = MT_EE_WIFI_CAL_DPD_5G;
+		break;
+	case NL80211_BAND_6GHZ:
+		mask = MT_EE_WIFI_CAL_DPD_6G;
+		break;
+	default:
+		mask = 0;
+		break;
+	}
+
+	if (!(eep[offs] & mask))
 		return 0;
 
-	idx = mt7915_dpd_freq_idx(center_freq, chandef->width);
+	idx = mt7915_dpd_freq_idx(dev, chandef->center_freq1, chandef->width);
 	if (idx < 0)
 		return -EINVAL;
 
 	/* Items: Tx DPD, Tx Flatness */
-	idx = idx * 2;
-	cal += MT_EE_CAL_GROUP_SIZE;
+	num = is_mt7915(&dev->mt76) ? 2 : 3;
+	idx *= num;
+	cal += mt7915_get_cal_group_size(dev) + (idx * MT_EE_CAL_UNIT);
 
-	while (total--) {
+	while (num--) {
 		int ret;
 
-		cal += (idx * MT_EE_CAL_UNIT);
 		ret = mt7915_mcu_set_pre_cal(dev, idx, cal, MT_EE_CAL_UNIT,
 					     MCU_EXT_CMD(DPD_PRE_CAL_INFO));
 		if (ret)
 			return ret;
 
 		idx++;
+		cal += MT_EE_CAL_UNIT;
 	}
 
 	return 0;
-- 
2.39.0


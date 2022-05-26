Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB2534C4C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346823AbiEZJJJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 05:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346846AbiEZJJH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 05:09:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32841C6E55
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 02:09:03 -0700 (PDT)
X-UUID: e219785b60034bf788d01b74b0b513f3-20220526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:62aa48d4-6bc3-4cd8-a5fa-07374a487073,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:edd59147-4fb1-496b-8f1d-39e733fed1ea,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: e219785b60034bf788d01b74b0b513f3-20220526
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 252603569; Thu, 26 May 2022 17:08:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 26 May 2022 17:08:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 26 May 2022 17:08:56 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7915: add more ethtool stats
Date:   Thu, 26 May 2022 17:08:54 +0800
Message-ID: <53fffc4aad9d92f7ae5da7e3e9aa1f59033bb662.1653555432.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1ef9b892cc93a36b1e62a6dda0e2e0a019f4e5f7.1653555361.git.ryder.lee@mediatek.com>
References: <1ef9b892cc93a36b1e62a6dda0e2e0a019f4e5f7.1653555361.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add channel time and MAC ready stats.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 52 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 14 +++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  7 +++
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 16 +++---
 4 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 086244d9be76..f59662af3d9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2214,7 +2214,8 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	u32 val;
 
 	cnt = mt76_rr(dev, MT_MIB_SDR3(phy->band_idx));
-	mib->fcs_err_cnt += is_mt7915(&dev->mt76) ? FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK, cnt) :
+	mib->fcs_err_cnt += is_mt7915(&dev->mt76) ?
+		FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR3_FCS_ERR_MASK_MT7916, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR4(phy->band_idx));
@@ -2227,19 +2228,28 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	mib->channel_idle_cnt += FIELD_GET(MT_MIB_SDR6_CHANNEL_IDL_CNT_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR7(phy->band_idx));
-	mib->rx_vector_mismatch_cnt += FIELD_GET(MT_MIB_SDR7_RX_VECTOR_MISMATCH_CNT_MASK, cnt);
+	mib->rx_vector_mismatch_cnt +=
+		FIELD_GET(MT_MIB_SDR7_RX_VECTOR_MISMATCH_CNT_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR8(phy->band_idx));
-	mib->rx_delimiter_fail_cnt += FIELD_GET(MT_MIB_SDR8_RX_DELIMITER_FAIL_CNT_MASK, cnt);
+	mib->rx_delimiter_fail_cnt +=
+		FIELD_GET(MT_MIB_SDR8_RX_DELIMITER_FAIL_CNT_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR10(phy->band_idx));
+	mib->rx_mrdy_cnt += is_mt7915(&dev->mt76) ?
+		FIELD_GET(MT_MIB_SDR10_MRDY_COUNT_MASK, cnt) :
+		FIELD_GET(MT_MIB_SDR10_MRDY_COUNT_MASK_MT7916, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR11(phy->band_idx));
-	mib->rx_len_mismatch_cnt += FIELD_GET(MT_MIB_SDR11_RX_LEN_MISMATCH_CNT_MASK, cnt);
+	mib->rx_len_mismatch_cnt +=
+		FIELD_GET(MT_MIB_SDR11_RX_LEN_MISMATCH_CNT_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR12(phy->band_idx));
 	mib->tx_ampdu_cnt += cnt;
 
 	cnt = mt76_rr(dev, MT_MIB_SDR13(phy->band_idx));
-	mib->tx_stop_q_empty_cnt += FIELD_GET(MT_MIB_SDR13_TX_STOP_Q_EMPTY_CNT_MASK, cnt);
+	mib->tx_stop_q_empty_cnt +=
+		FIELD_GET(MT_MIB_SDR13_TX_STOP_Q_EMPTY_CNT_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR14(phy->band_idx));
 	mib->tx_mpdu_attempts_cnt += is_mt7915(&dev->mt76) ?
@@ -2251,6 +2261,29 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 		FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK, cnt) :
 		FIELD_GET(MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK_MT7916, cnt);
 
+	cnt = mt76_rr(dev, MT_MIB_SDR16(phy->band_idx));
+	mib->primary_cca_busy_time +=
+		FIELD_GET(MT_MIB_SDR16_PRIMARY_CCA_BUSY_TIME_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR17(phy->band_idx));
+	mib->secondary_cca_busy_time +=
+		FIELD_GET(MT_MIB_SDR17_SECONDARY_CCA_BUSY_TIME_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR18(phy->band_idx));
+	mib->primary_energy_detect_time +=
+		FIELD_GET(MT_MIB_SDR18_PRIMARY_ENERGY_DETECT_TIME_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR19(phy->band_idx));
+	mib->cck_mdrdy_time += FIELD_GET(MT_MIB_SDR19_CCK_MDRDY_TIME_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR20(phy->band_idx));
+	mib->ofdm_mdrdy_time +=
+		FIELD_GET(MT_MIB_SDR20_OFDM_VHT_MDRDY_TIME_MASK, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_SDR21(phy->band_idx));
+	mib->green_mdrdy_time +=
+		FIELD_GET(MT_MIB_SDR21_GREEN_MDRDY_TIME_MASK, cnt);
+
 	cnt = mt76_rr(dev, MT_MIB_SDR22(phy->band_idx));
 	mib->rx_ampdu_cnt += cnt;
 
@@ -2266,10 +2299,12 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	mib->rx_ampdu_valid_subframe_bytes_cnt += cnt;
 
 	cnt = mt76_rr(dev, MT_MIB_SDR27(phy->band_idx));
-	mib->tx_rwp_fail_cnt += FIELD_GET(MT_MIB_SDR27_TX_RWP_FAIL_CNT_MASK, cnt);
+	mib->tx_rwp_fail_cnt +=
+		FIELD_GET(MT_MIB_SDR27_TX_RWP_FAIL_CNT_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR28(phy->band_idx));
-	mib->tx_rwp_need_cnt += FIELD_GET(MT_MIB_SDR28_TX_RWP_NEED_CNT_MASK, cnt);
+	mib->tx_rwp_need_cnt +=
+		FIELD_GET(MT_MIB_SDR28_TX_RWP_NEED_CNT_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR29(phy->band_idx));
 	mib->rx_pfdrop_cnt += is_mt7915(&dev->mt76) ?
@@ -2311,7 +2346,8 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 	if (is_mt7915(&dev->mt76)) {
 		for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
 			val = mt76_rr(dev, MT_MIB_MB_SDR1(phy->band_idx, (i << 4)));
-			mib->ba_miss_cnt += FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
+			mib->ba_miss_cnt +=
+				FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
 			mib->ack_fail_cnt +=
 				FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 710ca757fb52..793498175372 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1146,8 +1146,15 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"rx_fifo_full_cnt",
 	"rx_mpdu_cnt",
 	"channel_idle_cnt",
+	"primary_cca_busy_time",
+	"secondary_cca_busy_time",
+	"primary_energy_detect_time",
+	"cck_mdrdy_time",
+	"ofdm_mdrdy_time",
+	"green_mdrdy_time",
 	"rx_vector_mismatch_cnt",
 	"rx_delimiter_fail_cnt",
+	"rx_mrdy_cnt",
 	"rx_len_mismatch_cnt",
 	"rx_ampdu_cnt",
 	"rx_ampdu_bytes_cnt",
@@ -1287,8 +1294,15 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->rx_fifo_full_cnt;
 	data[ei++] = mib->rx_mpdu_cnt;
 	data[ei++] = mib->channel_idle_cnt;
+	data[ei++] = mib->primary_cca_busy_time;
+	data[ei++] = mib->secondary_cca_busy_time;
+	data[ei++] = mib->primary_energy_detect_time;
+	data[ei++] = mib->cck_mdrdy_time;
+	data[ei++] = mib->ofdm_mdrdy_time;
+	data[ei++] = mib->green_mdrdy_time;
 	data[ei++] = mib->rx_vector_mismatch_cnt;
 	data[ei++] = mib->rx_delimiter_fail_cnt;
+	data[ei++] = mib->rx_mrdy_cnt;
 	data[ei++] = mib->rx_len_mismatch_cnt;
 	data[ei++] = mib->rx_ampdu_cnt;
 	data[ei++] = mib->rx_ampdu_bytes_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 4dcae6991669..bd985e6ce36a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -200,8 +200,15 @@ struct mib_stats {
 	/* rx stats */
 	u32 rx_fifo_full_cnt;
 	u32 channel_idle_cnt;
+	u32 primary_cca_busy_time;
+	u32 secondary_cca_busy_time;
+	u32 primary_energy_detect_time;
+	u32 cck_mdrdy_time;
+	u32 ofdm_mdrdy_time;
+	u32 green_mdrdy_time;
 	u32 rx_vector_mismatch_cnt;
 	u32 rx_delimiter_fail_cnt;
+	u32 rx_mrdy_cnt;
 	u32 rx_len_mismatch_cnt;
 	u32 rx_mpdu_cnt;
 	u32 rx_ampdu_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 4953be208c5e..77fd448beed7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -305,7 +305,7 @@ enum offs_rev {
 #define MT_MIB_SDR9_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR9))
 #define MT_MIB_SDR9_CCA_BUSY_TIME_MASK		GENMASK(23, 0)
 
-#define MT_MIB_SDR10_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR10))
+#define MT_MIB_SDR10(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR10))
 #define MT_MIB_SDR10_MRDY_COUNT_MASK		GENMASK(25, 0)
 #define MT_MIB_SDR10_MRDY_COUNT_MASK_MT7916	GENMASK(31, 0)
 
@@ -329,24 +329,24 @@ enum offs_rev {
 #define MT_MIB_SDR15_TX_MPDU_SUCCESS_CNT_MASK_MT7916	GENMASK(31, 0)
 
 /* in units of 'us' */
-#define MT_MIB_SDR16_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR16))
+#define MT_MIB_SDR16(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR16))
 #define MT_MIB_SDR16_PRIMARY_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR17_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR17))
+#define MT_MIB_SDR17(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR17))
 #define MT_MIB_SDR17_SECONDARY_CCA_BUSY_TIME_MASK	GENMASK(23, 0)
 
 #define MT_MIB_SDR18(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR18))
 #define MT_MIB_SDR18_PRIMARY_ENERGY_DETECT_TIME_MASK	GENMASK(23, 0)
 
 /* units are us */
-#define MT_MIB_SDR19_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR19))
+#define MT_MIB_SDR19(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR19))
 #define MT_MIB_SDR19_CCK_MDRDY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR20_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR20))
+#define MT_MIB_SDR20(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR20))
 #define MT_MIB_SDR20_OFDM_VHT_MDRDY_TIME_MASK	GENMASK(23, 0)
 
-#define MT_MIB_SDR21_DNR(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR21))
-#define MT_MIB_SDR20_GREEN_MDRDY_TIME_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR21(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR21))
+#define MT_MIB_SDR21_GREEN_MDRDY_TIME_MASK	GENMASK(23, 0)
 
 /* rx ampdu count, 32-bit */
 #define MT_MIB_SDR22(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR22))
@@ -940,7 +940,7 @@ enum offs_rev {
 #define MT_ADIE_TYPE_MASK		BIT(1)
 
 /* FW MODE SYNC */
-#define MT_FW_EXCEPTION		__REG(FW_EXCEPTION_ADDR)
+#define MT_FW_EXCEPTION			__REG(FW_EXCEPTION_ADDR)
 
 #define MT_SWDEF_BASE			__REG(SWDEF_BASE_ADDR)
 
-- 
2.29.2


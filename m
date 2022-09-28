Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C655ED823
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiI1Ir4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 04:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiI1IrD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 04:47:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EC2B29CBE
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 01:44:43 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28S8iAQP1013419, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28S8iAQP1013419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 28 Sep 2022 16:44:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 28 Sep 2022 16:44:35 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 28 Sep
 2022 16:44:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/9] wifi: rtw89: 8852b: add chip_ops to read efuse
Date:   Wed, 28 Sep 2022 16:43:34 +0800
Message-ID: <20220928084336.34981-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928084336.34981-1-pkshih@realtek.com>
References: <20220928084336.34981-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/28/2022 08:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjggpFekyCAwNzowMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

efuse stores individual data about a chip itself, such as MAC address,
country code, RF and crystal calibration data, and so on. Define a struct
to help access efuse content, and copy them into a common struct.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 106 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852b.h |  75 +++++++++++++
 2 files changed, 181 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index ec6833080b80a..8911900e06f87 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -24,6 +24,105 @@ static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static void rtw8852be_efuse_parsing(struct rtw89_efuse *efuse,
+				    struct rtw8852b_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->e.mac_addr);
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+}
+
+static void rtw8852b_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
+					struct rtw8852b_efuse *map)
+{
+	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
+	struct rtw8852b_tssi_offset *ofst[] = {&map->path_a_tssi, &map->path_b_tssi};
+	u8 i, j;
+
+	tssi->thermal[RF_PATH_A] = map->path_a_therm;
+	tssi->thermal[RF_PATH_B] = map->path_b_therm;
+
+	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
+		memcpy(tssi->tssi_cck[i], ofst[i]->cck_tssi,
+		       sizeof(ofst[i]->cck_tssi));
+
+		for (j = 0; j < TSSI_CCK_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][EFUSE] path=%d cck[%d]=0x%x\n",
+				    i, j, tssi->tssi_cck[i][j]);
+
+		memcpy(tssi->tssi_mcs[i], ofst[i]->bw40_tssi,
+		       sizeof(ofst[i]->bw40_tssi));
+		memcpy(tssi->tssi_mcs[i] + TSSI_MCS_2G_CH_GROUP_NUM,
+		       ofst[i]->bw40_1s_tssi_5g, sizeof(ofst[i]->bw40_1s_tssi_5g));
+
+		for (j = 0; j < TSSI_MCS_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][EFUSE] path=%d mcs[%d]=0x%x\n",
+				    i, j, tssi->tssi_mcs[i][j]);
+	}
+}
+
+static bool _decode_efuse_gain(u8 data, s8 *high, s8 *low)
+{
+	if (high)
+		*high = sign_extend32(FIELD_GET(GENMASK(7,  4), data), 3);
+	if (low)
+		*low = sign_extend32(FIELD_GET(GENMASK(3,  0), data), 3);
+
+	return data != 0xff;
+}
+
+static void rtw8852b_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
+					       struct rtw8852b_efuse *map)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	bool valid = false;
+
+	valid |= _decode_efuse_gain(map->rx_gain_2g_cck,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_CCK],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_2G_CCK]);
+	valid |= _decode_efuse_gain(map->rx_gain_2g_ofdm,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_OFDM],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_2G_OFDM]);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_low,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_LOW],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_LOW]);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_mid,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_MID],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_MID]);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_high,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_HIGH],
+				    &gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_HIGH]);
+
+	gain->offset_valid = valid;
+}
+
+static int rtw8852b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw8852b_efuse *map;
+
+	map = (struct rtw8852b_efuse *)log_map;
+
+	efuse->country_code[0] = map->country_code[0];
+	efuse->country_code[1] = map->country_code[1];
+	rtw8852b_efuse_parsing_tssi(rtwdev, map);
+	rtw8852b_efuse_parsing_gain_offset(rtwdev, map);
+
+	switch (rtwdev->hci.type) {
+	case RTW89_HCI_TYPE_PCIE:
+		rtw8852be_efuse_parsing(efuse, map);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
+
+	return 0;
+}
+
 static u32 rtw8852b_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 				     enum rtw89_phy_idx phy_idx, s16 ref)
 {
@@ -269,6 +368,7 @@ static int rtw8852b_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.enable_bb_rf		= rtw8852b_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
+	.read_efuse		= rtw8852b_read_efuse,
 	.set_txpwr		= rtw8852b_set_txpwr,
 	.set_txpwr_ctrl		= rtw8852b_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852b_init_txpwr_unit,
@@ -280,6 +380,12 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.fifo_size		= 196608,
 	.dle_scc_rsvd_size	= 98304,
 	.dle_mem		= rtw8852b_dle_mem_pcie,
+	.sec_ctrl_efuse_size	= 4,
+	.physical_efuse_size	= 1216,
+	.logical_efuse_size	= 2048,
+	.limit_efuse_size	= 1280,
+	.dav_phy_efuse_size	= 96,
+	.dav_log_efuse_size	= 16,
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.h b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
index a5ff269752a30..578fe55b66957 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
@@ -10,4 +10,79 @@
 #define RF_PATH_NUM_8852B 2
 #define BB_PATH_NUM_8852B 2
 
+struct rtw8852b_u_efuse {
+	u8 rsvd[0x88];
+	u8 mac_addr[ETH_ALEN];
+};
+
+struct rtw8852b_e_efuse {
+	u8 mac_addr[ETH_ALEN];
+};
+
+struct rtw8852b_tssi_offset {
+	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
+	u8 bw40_tssi[TSSI_MCS_2G_CH_GROUP_NUM];
+	u8 rsvd[7];
+	u8 bw40_1s_tssi_5g[TSSI_MCS_5G_CH_GROUP_NUM];
+} __packed;
+
+struct rtw8852b_efuse {
+	u8 rsvd[0x210];
+	struct rtw8852b_tssi_offset path_a_tssi;
+	u8 rsvd1[10];
+	struct rtw8852b_tssi_offset path_b_tssi;
+	u8 rsvd2[94];
+	u8 channel_plan;
+	u8 xtal_k;
+	u8 rsvd3;
+	u8 iqk_lck;
+	u8 rsvd4[5];
+	u8 reg_setting:2;
+	u8 tx_diversity:1;
+	u8 rx_diversity:2;
+	u8 ac_mode:1;
+	u8 module_type:2;
+	u8 rsvd5;
+	u8 shared_ant:1;
+	u8 coex_type:3;
+	u8 ant_iso:1;
+	u8 radio_on_off:1;
+	u8 rsvd6:2;
+	u8 eeprom_version;
+	u8 customer_id;
+	u8 tx_bb_swing_2g;
+	u8 tx_bb_swing_5g;
+	u8 tx_cali_pwr_trk_mode;
+	u8 trx_path_selection;
+	u8 rfe_type;
+	u8 country_code[2];
+	u8 rsvd7[3];
+	u8 path_a_therm;
+	u8 path_b_therm;
+	u8 rsvd8[2];
+	u8 rx_gain_2g_ofdm;
+	u8 rsvd9;
+	u8 rx_gain_2g_cck;
+	u8 rsvd10;
+	u8 rx_gain_5g_low;
+	u8 rsvd11;
+	u8 rx_gain_5g_mid;
+	u8 rsvd12;
+	u8 rx_gain_5g_high;
+	u8 rsvd13[35];
+	u8 path_a_cck_pwr_idx[6];
+	u8 path_a_bw40_1tx_pwr_idx[5];
+	u8 path_a_ofdm_1tx_pwr_idx_diff:4;
+	u8 path_a_bw20_1tx_pwr_idx_diff:4;
+	u8 path_a_bw20_2tx_pwr_idx_diff:4;
+	u8 path_a_bw40_2tx_pwr_idx_diff:4;
+	u8 path_a_cck_2tx_pwr_idx_diff:4;
+	u8 path_a_ofdm_2tx_pwr_idx_diff:4;
+	u8 rsvd14[0xf2];
+	union {
+		struct rtw8852b_u_efuse u;
+		struct rtw8852b_e_efuse e;
+	};
+} __packed;
+
 #endif
-- 
2.25.1


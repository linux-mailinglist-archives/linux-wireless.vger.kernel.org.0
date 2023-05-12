Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3D0700022
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 08:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbjELGNE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 02:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjELGNB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 02:13:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EBF30FB
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 23:12:56 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34C6Cf9G2013956, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34C6Cf9G2013956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 12 May 2023 14:12:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 12 May 2023 14:12:49 +0800
Received: from [127.0.1.1] (172.16.17.85) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 12 May
 2023 14:12:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: 8851b: add to parse efuse content
Date:   Fri, 12 May 2023 14:12:20 +0800
Message-ID: <20230512061220.16544-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512061220.16544-1-pkshih@realtek.com>
References: <20230512061220.16544-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.85]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Parse efuse content to recognize MAC address, RFE type, XTAL offset and
so on. And, parse offset of PHY capability to retrieve TX power
calibration data.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 208 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.h |  61 +++++
 2 files changed, 269 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 898a509454a1a..6ecdd3d3f776f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -296,6 +296,212 @@ static int rtw8851b_pwr_off_func(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw8851b_efuse_parsing(struct rtw89_efuse *efuse,
+				   struct rtw8851b_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->e.mac_addr);
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+}
+
+static void rtw8851b_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
+					struct rtw8851b_efuse *map)
+{
+	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
+	struct rtw8851b_tssi_offset *ofst[] = {&map->path_a_tssi};
+	u8 i, j;
+
+	tssi->thermal[RF_PATH_A] = map->path_a_therm;
+
+	for (i = 0; i < RF_PATH_NUM_8851B; i++) {
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
+		*high = sign_extend32(u8_get_bits(data, GENMASK(7,  4)), 3);
+	if (low)
+		*low = sign_extend32(u8_get_bits(data, GENMASK(3,  0)), 3);
+
+	return data != 0xff;
+}
+
+static void rtw8851b_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
+					       struct rtw8851b_efuse *map)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	bool valid = false;
+
+	valid |= _decode_efuse_gain(map->rx_gain_2g_cck,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_CCK],
+				    NULL);
+	valid |= _decode_efuse_gain(map->rx_gain_2g_ofdm,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_OFDM],
+				    NULL);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_low,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_LOW],
+				    NULL);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_mid,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_MID],
+				   NULL);
+	valid |= _decode_efuse_gain(map->rx_gain_5g_high,
+				    &gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_HIGH],
+				    NULL);
+
+	gain->offset_valid = valid;
+}
+
+static int rtw8851b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw8851b_efuse *map;
+
+	map = (struct rtw8851b_efuse *)log_map;
+
+	efuse->country_code[0] = map->country_code[0];
+	efuse->country_code[1] = map->country_code[1];
+	rtw8851b_efuse_parsing_tssi(rtwdev, map);
+	rtw8851b_efuse_parsing_gain_offset(rtwdev, map);
+
+	switch (rtwdev->hci.type) {
+	case RTW89_HCI_TYPE_PCIE:
+		rtw8851b_efuse_parsing(efuse, map);
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
+static void rtw8851b_phycap_parsing_tssi(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
+	static const u32 tssi_trim_addr[RF_PATH_NUM_8851B] = {0x5D6};
+	u32 addr = rtwdev->chip->phycap_addr;
+	bool pg = false;
+	u32 ofst;
+	u8 i, j;
+
+	for (i = 0; i < RF_PATH_NUM_8851B; i++) {
+		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM; j++) {
+			/* addrs are in decreasing order */
+			ofst = tssi_trim_addr[i] - addr - j;
+			tssi->tssi_trim[i][j] = phycap_map[ofst];
+
+			if (phycap_map[ofst] != 0xff)
+				pg = true;
+		}
+	}
+
+	if (!pg) {
+		memset(tssi->tssi_trim, 0, sizeof(tssi->tssi_trim));
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM] no PG, set all trim info to 0\n");
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8851B; i++)
+		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI] path=%d idx=%d trim=0x%x addr=0x%x\n",
+				    i, j, tssi->tssi_trim[i][j],
+				    tssi_trim_addr[i] - j);
+}
+
+static void rtw8851b_phycap_parsing_thermal_trim(struct rtw89_dev *rtwdev,
+						 u8 *phycap_map)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	static const u32 thm_trim_addr[RF_PATH_NUM_8851B] = {0x5DF};
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8851B; i++) {
+		info->thermal_trim[i] = phycap_map[thm_trim_addr[i] - addr];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] path=%d thermal_trim=0x%x\n",
+			    i, info->thermal_trim[i]);
+
+		if (info->thermal_trim[i] != 0xff)
+			info->pg_thermal_trim = true;
+	}
+}
+
+static void rtw8851b_phycap_parsing_pa_bias_trim(struct rtw89_dev *rtwdev,
+						 u8 *phycap_map)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	static const u32 pabias_trim_addr[] = {0x5DE};
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8851B; i++) {
+		info->pa_bias_trim[i] = phycap_map[pabias_trim_addr[i] - addr];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] path=%d pa_bias_trim=0x%x\n",
+			    i, info->pa_bias_trim[i]);
+
+		if (info->pa_bias_trim[i] != 0xff)
+			info->pg_pa_bias_trim = true;
+	}
+}
+
+static void rtw8851b_phycap_parsing_gain_comp(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	static const u32 comp_addrs[][RTW89_SUBBAND_2GHZ_5GHZ_NR] = {
+		{0x5BB, 0x5BA, 0, 0x5B9, 0x5B8},
+	};
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	u32 phycap_addr = rtwdev->chip->phycap_addr;
+	bool valid = false;
+	int path, i;
+	u8 data;
+
+	for (path = 0; path < BB_PATH_NUM_8851B; path++)
+		for (i = 0; i < RTW89_SUBBAND_2GHZ_5GHZ_NR; i++) {
+			if (comp_addrs[path][i] == 0)
+				continue;
+
+			data = phycap_map[comp_addrs[path][i] - phycap_addr];
+			valid |= _decode_efuse_gain(data, NULL,
+						    &gain->comp[path][i]);
+		}
+
+	gain->comp_valid = valid;
+}
+
+static int rtw8851b_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	rtw8851b_phycap_parsing_tssi(rtwdev, phycap_map);
+	rtw8851b_phycap_parsing_thermal_trim(rtwdev, phycap_map);
+	rtw8851b_phycap_parsing_pa_bias_trim(rtwdev, phycap_map);
+	rtw8851b_phycap_parsing_gain_comp(rtwdev, phycap_map);
+
+	return 0;
+}
+
 static void rtw8851b_set_bb_gpio(struct rtw89_dev *rtwdev, u8 gpio_idx, bool inv,
 				 u8 src_sel)
 {
@@ -1501,6 +1707,8 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.write_rf		= rtw89_phy_write_rf_v1,
 	.set_channel		= rtw8851b_set_channel,
 	.set_channel_help	= rtw8851b_set_channel_help,
+	.read_efuse		= rtw8851b_read_efuse,
+	.read_phycap		= rtw8851b_read_phycap,
 	.fem_setup		= NULL,
 	.rfe_gpio		= rtw8851b_rfe_gpio,
 	.pwr_on_func		= rtw8851b_pwr_on_func,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.h b/drivers/net/wireless/realtek/rtw89/rtw8851b.h
index e34b7d09ad6df..1a5c52654d8a4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.h
@@ -10,6 +10,67 @@
 #define RF_PATH_NUM_8851B 1
 #define BB_PATH_NUM_8851B 1
 
+struct rtw8851bu_efuse {
+	u8 rsvd[0x88];
+	u8 mac_addr[ETH_ALEN];
+};
+
+struct rtw8851be_efuse {
+	u8 mac_addr[ETH_ALEN];
+};
+
+struct rtw8851b_tssi_offset {
+	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
+	u8 bw40_tssi[TSSI_MCS_2G_CH_GROUP_NUM];
+	u8 rsvd[7];
+	u8 bw40_1s_tssi_5g[TSSI_MCS_5G_CH_GROUP_NUM];
+} __packed;
+
+struct rtw8851b_efuse {
+	u8 rsvd[0x210];
+	struct rtw8851b_tssi_offset path_a_tssi;
+	u8 rsvd1[136];
+	u8 channel_plan;
+	u8 xtal_k;
+	u8 rsvd2;
+	u8 iqk_lck;
+	u8 rsvd3[8];
+	u8 eeprom_version;
+	u8 customer_id;
+	u8 tx_bb_swing_2g;
+	u8 tx_bb_swing_5g;
+	u8 tx_cali_pwr_trk_mode;
+	u8 trx_path_selection;
+	u8 rfe_type;
+	u8 country_code[2];
+	u8 rsvd4[3];
+	u8 path_a_therm;
+	u8 rsvd5[3];
+	u8 rx_gain_2g_ofdm;
+	u8 rsvd6;
+	u8 rx_gain_2g_cck;
+	u8 rsvd7;
+	u8 rx_gain_5g_low;
+	u8 rsvd8;
+	u8 rx_gain_5g_mid;
+	u8 rsvd9;
+	u8 rx_gain_5g_high;
+	u8 rsvd10[35];
+	u8 path_a_cck_pwr_idx[6];
+	u8 path_a_bw40_1tx_pwr_idx[5];
+	u8 path_a_ofdm_1tx_pwr_idx_diff:4;
+	u8 path_a_bw20_1tx_pwr_idx_diff:4;
+	u8 path_a_bw20_2tx_pwr_idx_diff:4;
+	u8 path_a_bw40_2tx_pwr_idx_diff:4;
+	u8 path_a_cck_2tx_pwr_idx_diff:4;
+	u8 path_a_ofdm_2tx_pwr_idx_diff:4;
+	u8 rsvd11[0xf2];
+	union {
+		struct rtw8851bu_efuse u;
+		struct rtw8851be_efuse e;
+	};
+} __packed;
+
 extern const struct rtw89_chip_info rtw8851b_chip_info;
 
 #endif
-- 
2.25.1


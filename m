Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FF07EEB2B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 03:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjKQClj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 21:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjKQCli (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 21:41:38 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3765D4F
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 18:41:34 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AH2fSlzD2818746, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AH2fSlzD2818746
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 10:41:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 17 Nov 2023 10:41:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 17 Nov
 2023 10:41:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: 8922a: read efuse content via efuse map struct from logic map
Date:   Fri, 17 Nov 2023 10:40:28 +0800
Message-ID: <20231117024029.113845-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117024029.113845-1-pkshih@realtek.com>
References: <20231117024029.113845-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Define efuse map struct of RTW89_EFUSE_BLOCK_RF block, and read needed
data from efuse logic map into driver. Also, with efuse power-on state,
read MAC address via register interface according to HCI interface.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 150 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.h |  58 +++++++
 2 files changed, 208 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 4a431640a1ce..bed74ab4a7c2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -26,6 +26,155 @@ static const struct rtw89_efuse_block_cfg rtw8922a_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_ADIE]		= {.offset = 0x70000, .size = 0x10},
 };
 
+static void rtw8922a_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
+					struct rtw8922a_efuse *map)
+{
+	struct rtw8922a_tssi_offset *ofst[] = {&map->path_a_tssi, &map->path_b_tssi};
+	u8 *bw40_1s_tssi_6g_ofst[] = {map->bw40_1s_tssi_6g_a, map->bw40_1s_tssi_6g_b};
+	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
+	u8 i, j;
+
+	tssi->thermal[RF_PATH_A] = map->path_a_therm;
+	tssi->thermal[RF_PATH_B] = map->path_b_therm;
+
+	for (i = 0; i < RF_PATH_NUM_8922A; i++) {
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
+		memcpy(tssi->tssi_6g_mcs[i], bw40_1s_tssi_6g_ofst[i],
+		       sizeof(tssi->tssi_6g_mcs[i]));
+
+		for (j = 0; j < TSSI_MCS_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI][EFUSE] path=%d mcs[%d]=0x%x\n",
+				    i, j, tssi->tssi_mcs[i][j]);
+	}
+}
+
+static void rtw8922a_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
+					       struct rtw8922a_efuse *map)
+{
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	bool all_0xff = true, all_0x00 = true;
+	int i, j;
+	u8 t;
+
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_CCK] = map->rx_gain_a._2g_cck;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_2G_CCK] = map->rx_gain_b._2g_cck;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_2G_OFDM] = map->rx_gain_a._2g_ofdm;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_2G_OFDM] = map->rx_gain_b._2g_ofdm;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_LOW] = map->rx_gain_a._5g_low;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_LOW] = map->rx_gain_b._5g_low;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_MID] = map->rx_gain_a._5g_mid;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_MID] = map->rx_gain_b._5g_mid;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_5G_HIGH] = map->rx_gain_a._5g_high;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_5G_HIGH] = map->rx_gain_b._5g_high;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_L0] = map->rx_gain_6g_a._6g_l0;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_L0] = map->rx_gain_6g_b._6g_l0;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_L1] = map->rx_gain_6g_a._6g_l1;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_L1] = map->rx_gain_6g_b._6g_l1;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_M0] = map->rx_gain_6g_a._6g_m0;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_M0] = map->rx_gain_6g_b._6g_m0;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_M1] = map->rx_gain_6g_a._6g_m1;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_M1] = map->rx_gain_6g_b._6g_m1;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_H0] = map->rx_gain_6g_a._6g_h0;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_H0] = map->rx_gain_6g_b._6g_h0;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_H1] = map->rx_gain_6g_a._6g_h1;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_H1] = map->rx_gain_6g_b._6g_h1;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_UH0] = map->rx_gain_6g_a._6g_uh0;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_UH0] = map->rx_gain_6g_b._6g_uh0;
+	gain->offset[RF_PATH_A][RTW89_GAIN_OFFSET_6G_UH1] = map->rx_gain_6g_a._6g_uh1;
+	gain->offset[RF_PATH_B][RTW89_GAIN_OFFSET_6G_UH1] = map->rx_gain_6g_b._6g_uh1;
+
+	for (i = RF_PATH_A; i <= RF_PATH_B; i++)
+		for (j = 0; j < RTW89_GAIN_OFFSET_NR; j++) {
+			t = gain->offset[i][j];
+			if (t != 0xff)
+				all_0xff = false;
+			if (t != 0x0)
+				all_0x00 = false;
+
+			/* transform: sign-bit + U(7,2) to S(8,2) */
+			if (t & 0x80)
+				gain->offset[i][j] = (t ^ 0x7f) + 1;
+		}
+
+	gain->offset_valid = !all_0xff && !all_0x00;
+}
+
+static void rtw8922a_read_efuse_mac_addr(struct rtw89_dev *rtwdev, u32 addr)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	u16 val;
+	int i;
+
+	for (i = 0; i < ETH_ALEN; i += 2, addr += 2) {
+		val = rtw89_read16(rtwdev, addr);
+		efuse->addr[i] = val & 0xff;
+		efuse->addr[i + 1] = val >> 8;
+	}
+}
+
+static int rtw8922a_read_efuse_pci_sdio(struct rtw89_dev *rtwdev, u8 *log_map)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw8922a_read_efuse_mac_addr(rtwdev, 0x3104);
+	else
+		ether_addr_copy(efuse->addr, log_map + 0x001A);
+
+	return 0;
+}
+
+static int rtw8922a_read_efuse_usb(struct rtw89_dev *rtwdev, u8 *log_map)
+{
+	rtw8922a_read_efuse_mac_addr(rtwdev, 0x4078);
+
+	return 0;
+}
+
+static int rtw8922a_read_efuse_rf(struct rtw89_dev *rtwdev, u8 *log_map)
+{
+	struct rtw8922a_efuse *map = (struct rtw8922a_efuse *)log_map;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+	efuse->country_code[0] = map->country_code[0];
+	efuse->country_code[1] = map->country_code[1];
+	rtw8922a_efuse_parsing_tssi(rtwdev, map);
+	rtw8922a_efuse_parsing_gain_offset(rtwdev, map);
+
+	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
+
+	return 0;
+}
+
+static int rtw8922a_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
+			       enum rtw89_efuse_block block)
+{
+	switch (block) {
+	case RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO:
+		return rtw8922a_read_efuse_pci_sdio(rtwdev, log_map);
+	case RTW89_EFUSE_BLOCK_HCI_DIG_USB:
+		return rtw8922a_read_efuse_usb(rtwdev, log_map);
+	case RTW89_EFUSE_BLOCK_RF:
+		return rtw8922a_read_efuse_rf(rtwdev, log_map);
+	default:
+		return 0;
+	}
+}
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
@@ -36,6 +185,7 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 #endif
 
 static const struct rtw89_chip_ops rtw8922a_chip_ops = {
+	.read_efuse		= rtw8922a_read_efuse,
 };
 
 const struct rtw89_chip_info rtw8922a_chip_info = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.h b/drivers/net/wireless/realtek/rtw89/rtw8922a.h
index eae70b1f8d01..597317ab6af7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.h
@@ -10,6 +10,64 @@
 #define RF_PATH_NUM_8922A 2
 #define BB_PATH_NUM_8922A 2
 
+struct rtw8922a_tssi_offset {
+	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
+	u8 bw40_tssi[TSSI_MCS_2G_CH_GROUP_NUM];
+	u8 rsvd[7];
+	u8 bw40_1s_tssi_5g[TSSI_MCS_5G_CH_GROUP_NUM];
+	u8 bw_diff_5g[10];
+} __packed;
+
+struct rtw8922a_rx_gain {
+	u8 _2g_ofdm;
+	u8 _2g_cck;
+	u8 _5g_low;
+	u8 _5g_mid;
+	u8 _5g_high;
+} __packed;
+
+struct rtw8922a_rx_gain_6g {
+	u8 _6g_l0;
+	u8 _6g_l1;
+	u8 _6g_m0;
+	u8 _6g_m1;
+	u8 _6g_h0;
+	u8 _6g_h1;
+	u8 _6g_uh0;
+	u8 _6g_uh1;
+} __packed;
+
+struct rtw8922a_efuse {
+	u8 country_code[2];
+	u8 rsvd[0xe];
+	struct rtw8922a_tssi_offset path_a_tssi;
+	struct rtw8922a_tssi_offset path_b_tssi;
+	u8 rsvd1[0x54];
+	u8 channel_plan;
+	u8 xtal_k;
+	u8 rsvd2[0x7];
+	u8 board_info;
+	u8 rsvd3[0x8];
+	u8 rfe_type;
+	u8 rsvd4[0x5];
+	u8 path_a_therm;
+	u8 path_b_therm;
+	u8 rsvd5[0x2];
+	struct rtw8922a_rx_gain rx_gain_a;
+	struct rtw8922a_rx_gain rx_gain_b;
+	u8 rsvd6[0x22];
+	u8 bw40_1s_tssi_6g_a[TSSI_MCS_6G_CH_GROUP_NUM];
+	u8 rsvd7[0xa];
+	u8 bw40_1s_tssi_6g_b[TSSI_MCS_6G_CH_GROUP_NUM];
+	u8 rsvd8[0xa];
+	u8 bw40_1s_tssi_6g_c[TSSI_MCS_6G_CH_GROUP_NUM];
+	u8 rsvd9[0xa];
+	u8 bw40_1s_tssi_6g_d[TSSI_MCS_6G_CH_GROUP_NUM];
+	u8 rsvd10[0xa];
+	struct rtw8922a_rx_gain_6g rx_gain_6g_a;
+	struct rtw8922a_rx_gain_6g rx_gain_6g_b;
+} __packed;
+
 extern const struct rtw89_chip_info rtw8922a_chip_info;
 
 #endif
-- 
2.25.1


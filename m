Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4934CF19B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 07:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiCGGHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 01:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiCGGHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 01:07:09 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BF05F274
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 22:06:14 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 227667ZC0022647, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 227667ZC0022647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Mar 2022 14:06:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 14:06:07 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Mar
 2022 14:06:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 13/13] rtw89: 8852c: process logic efuse map
Date:   Mon, 7 Mar 2022 14:04:57 +0800
Message-ID: <20220307060457.56789-14-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307060457.56789-1-pkshih@realtek.com>
References: <20220307060457.56789-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/07/2022 05:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNyCkV6TIIDAzOjQ5OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a struct to access logic efuse map, and fill data according to the map.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 67 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h | 62 +++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index df6e9bf69f90a..35a9f40af3c99 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -221,6 +221,72 @@ static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw8852c_e_efuse_parsing(struct rtw89_efuse *efuse,
+				     struct rtw8852c_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->e.mac_addr);
+	efuse->rfe_type = map->rfe_type;
+	efuse->xtal_cap = map->xtal_k;
+}
+
+static void rtw8852c_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
+					struct rtw8852c_efuse *map)
+{
+	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
+	struct rtw8852c_tssi_offset *ofst[] = {&map->path_a_tssi, &map->path_b_tssi};
+	u8 *bw40_1s_tssi_6g_ofst[] = {map->bw40_1s_tssi_6g_a, map->bw40_1s_tssi_6g_b};
+	u8 i, j;
+
+	tssi->thermal[RF_PATH_A] = map->path_a_therm;
+	tssi->thermal[RF_PATH_B] = map->path_b_therm;
+
+	for (i = 0; i < RF_PATH_NUM_8852C; i++) {
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
+static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw8852c_efuse *map;
+
+	map = (struct rtw8852c_efuse *)log_map;
+
+	efuse->country_code[0] = map->country_code[0];
+	efuse->country_code[1] = map->country_code[1];
+	rtw8852c_efuse_parsing_tssi(rtwdev, map);
+
+	switch (rtwdev->hci.type) {
+	case RTW89_HCI_TYPE_PCIE:
+		rtw8852c_e_efuse_parsing(efuse, map);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	rtw89_info(rtwdev, "chip rfe_type is %d\n", efuse->rfe_type);
+
+	return 0;
+}
+
 static void rtw8852c_phycap_parsing_tssi(struct rtw89_dev *rtwdev, u8 *phycap_map)
 {
 	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
@@ -376,6 +442,7 @@ static void rtw8852c_power_trim(struct rtw89_dev *rtwdev)
 }
 
 static const struct rtw89_chip_ops rtw8852c_chip_ops = {
+	.read_efuse		= rtw8852c_read_efuse,
 	.read_phycap		= rtw8852c_read_phycap,
 	.power_trim		= rtw8852c_power_trim,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index 8abca49e6c84b..d0594716040bc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -9,6 +9,68 @@
 
 #define RF_PATH_NUM_8852C 2
 
+struct rtw8852c_u_efuse {
+	u8 rsvd[0x38];
+	u8 mac_addr[ETH_ALEN];
+};
+
+struct rtw8852c_e_efuse {
+	u8 mac_addr[ETH_ALEN];
+};
+
+struct rtw8852c_tssi_offset {
+	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
+	u8 bw40_tssi[TSSI_MCS_2G_CH_GROUP_NUM];
+	u8 rsvd[7];
+	u8 bw40_1s_tssi_5g[TSSI_MCS_5G_CH_GROUP_NUM];
+} __packed;
+
+struct rtw8852c_efuse {
+	u8 rsvd[0x210];
+	struct rtw8852c_tssi_offset path_a_tssi;
+	u8 rsvd1[10];
+	struct rtw8852c_tssi_offset path_b_tssi;
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
+	u8 rsvd8[46];
+	u8 bw40_1s_tssi_6g_a[TSSI_MCS_6G_CH_GROUP_NUM];
+	u8 rsvd9[10];
+	u8 bw40_1s_tssi_6g_b[TSSI_MCS_6G_CH_GROUP_NUM];
+	u8 rsvd10[110];
+	u8 channel_plan_6g;
+	u8 rsvd11[71];
+	union {
+		struct rtw8852c_u_efuse u;
+		struct rtw8852c_e_efuse e;
+	};
+} __packed;
+
 extern const struct rtw89_chip_info rtw8852c_chip_info;
 
 #endif
-- 
2.25.1


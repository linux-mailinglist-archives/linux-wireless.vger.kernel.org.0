Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5A50F11C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 08:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245282AbiDZGgy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 02:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiDZGgq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 02:36:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E1215FE8
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 23:33:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23Q6XCa94015283, This message is accepted by code: ctloc85258
Received: from mail.realtek.com ([172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23Q6XCa94015283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Apr 2022 14:33:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 14:33:12 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 26 Apr
 2022 14:33:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 11/15] rtw89: 8852c: add basic and remaining chip_info
Date:   Tue, 26 Apr 2022 14:32:31 +0800
Message-ID: <20220426063235.41650-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426063235.41650-1-pkshih@realtek.com>
References: <20220426063235.41650-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/26/2022 06:17:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjYgpFekyCAwNDozODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The chip_info include BT coexistence tables, size and number of hardware
components, and supported functions.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 82 ++++++++++++++++++-
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index d2fe3976e4ae9..17612fb4365b5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2662,6 +2662,50 @@ s8 rtw8852c_btc_get_bt_rssi(struct rtw89_dev *rtwdev, s8 val)
 	return clamp_t(s8, val, -100, 0) + 100;
 }
 
+static struct rtw89_btc_rf_trx_para rtw89_btc_8852c_rf_ul[] = {
+	{255, 0, 0, 7}, /* 0 -> original */
+	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
+	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{6, 1, 0, 7},
+	{13, 1, 0, 7},
+	{13, 1, 0, 7}
+};
+
+static struct rtw89_btc_rf_trx_para rtw89_btc_8852c_rf_dl[] = {
+	{255, 0, 0, 7}, /* 0 -> original */
+	{255, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 3- >reserved for shared-antenna */
+	{255, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
+	{255, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{255, 1, 0, 7},
+	{255, 1, 0, 7},
+	{255, 1, 0, 7}
+};
+
+static const
+u8 rtw89_btc_8852c_wl_rssi_thres[BTC_WL_RSSI_THMAX] = {60, 50, 40, 30};
+static const
+u8 rtw89_btc_8852c_bt_rssi_thres[BTC_BT_RSSI_THMAX] = {40, 36, 31, 28};
+
+static struct rtw89_btc_fbtc_mreg rtw89_btc_8852c_mon_reg[] = {
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda00),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda04),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda24),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda30),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda34),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda38),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda44),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda48),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda4c),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xd200),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xd220),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x980),
+};
+
 static
 void rtw8852c_btc_bt_aci_imp(struct rtw89_dev *rtwdev)
 {
@@ -2795,10 +2839,13 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.disable_bb_rf		= rtw8852c_mac_disable_bb_rf,
 	.bb_reset		= rtw8852c_bb_reset,
 	.bb_sethw		= rtw8852c_bb_sethw,
+	.read_rf		= rtw89_phy_read_rf_v1,
+	.write_rf		= rtw89_phy_write_rf_v1,
 	.set_channel		= rtw8852c_set_channel,
 	.set_channel_help	= rtw8852c_set_channel_help,
 	.read_efuse		= rtw8852c_read_efuse,
 	.read_phycap		= rtw8852c_read_phycap,
+	.fem_setup		= NULL,
 	.rfk_init		= rtw8852c_rfk_init,
 	.rfk_channel		= rtw8852c_rfk_channel,
 	.rfk_band_changed	= rtw8852c_rfk_band_changed,
@@ -2809,12 +2856,11 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.set_txpwr_ctrl		= rtw8852c_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852c_init_txpwr_unit,
 	.get_thermal		= rtw8852c_get_thermal,
+	.ctrl_btg		= rtw8852c_ctrl_btg,
 	.query_ppdu		= rtw8852c_query_ppdu,
 	.bb_ctrl_btc_preagc	= rtw8852c_bb_ctrl_btc_preagc,
-	.read_rf		= rtw89_phy_read_rf_v1,
-	.write_rf		= rtw89_phy_write_rf_v1,
-	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
 	.cfg_txrx_path		= rtw8852c_bb_cfg_txrx_path,
+	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
 	.pwr_off_func		= rtw8852c_pwr_off_func,
 	.fill_txdesc		= rtw89_core_fill_txdesc_v1,
@@ -2839,6 +2885,10 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.chip_id		= RTL8852C,
 	.ops			= &rtw8852c_chip_ops,
 	.fw_name		= "rtw89/rtw8852c_fw.bin",
+	.fifo_size		= 458752,
+	.max_amsdu_limit	= 8000,
+	.dis_2g_40m_ul_ofdma	= false,
+	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= rtw8852c_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852c_dle_mem_pcie,
 	.rf_base_addr		= {0xe000, 0xf000},
@@ -2860,7 +2910,17 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
 	.tssi_dbw_table		= &rtw89_8852c_tssi_dbw_table,
+	.support_bands		= BIT(NL80211_BAND_2GHZ) |
+				  BIT(NL80211_BAND_5GHZ) |
+				  BIT(NL80211_BAND_6GHZ),
+	.support_bw160		= true,
 	.hw_sec_hdr		= true,
+	.rf_path_num		= 2,
+	.tx_nss			= 2,
+	.rx_nss			= 2,
+	.acam_num		= 128,
+	.bcam_num		= 20,
+	.scam_num		= 128,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
@@ -2869,6 +2929,22 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dav_log_efuse_size	= 16,
 	.phycap_addr		= 0x590,
 	.phycap_size		= 0x60,
+	.para_ver		= 0x05050764,
+	.wlcx_desired		= 0x05050000,
+	.btcx_desired		= 0x5,
+	.scbd			= 0x1,
+	.mailbox		= 0x1,
+	.afh_guard_ch		= 6,
+	.wl_rssi_thres		= rtw89_btc_8852c_wl_rssi_thres,
+	.bt_rssi_thres		= rtw89_btc_8852c_bt_rssi_thres,
+	.rssi_tol		= 2,
+	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8852c_mon_reg),
+	.mon_reg		= rtw89_btc_8852c_mon_reg,
+	.rf_para_ulink_num	= ARRAY_SIZE(rtw89_btc_8852c_rf_ul),
+	.rf_para_ulink		= rtw89_btc_8852c_rf_ul,
+	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852c_rf_dl),
+	.rf_para_dlink		= rtw89_btc_8852c_rf_dl,
+	.ps_mode_supported	= 0,
 	.low_power_hci_modes	= BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
 	.h2c_cctl_func_id	= H2C_FUNC_MAC_CCTLINFO_UD_V1,
-- 
2.25.1


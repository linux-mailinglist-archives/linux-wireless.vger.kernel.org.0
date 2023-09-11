Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1315A79A5ED
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Sep 2023 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjIKIWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 04:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjIKIWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 04:22:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD518D
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 01:22:17 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38B8M9WF01002935, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38B8M9WF01002935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 16:22:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 11 Sep 2023 16:22:06 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Sep
 2023 16:22:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: add mac_gen pointer to access mac port registers
Date:   Mon, 11 Sep 2023 16:20:49 +0800
Message-ID: <20230911082049.33541-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911082049.33541-1-pkshih@realtek.com>
References: <20230911082049.33541-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Using mac_gen pointer to reuse the code with WiFi 7 chips, and define
MAC ports registers for WiFi 7 chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    |  72 ++++++----
 drivers/net/wireless/realtek/rtw89/mac.h    |   1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c |  27 ++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 147 ++++++++++++++++++++
 4 files changed, 223 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index cd386531830b..e59d18c2e81d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3721,7 +3721,7 @@ int rtw89_mac_set_macid_pause(struct rtw89_dev *rtwdev, u8 macid, bool pause)
 	return 0;
 }
 
-static const struct rtw89_port_reg rtw_port_base = {
+static const struct rtw89_port_reg rtw89_port_base_ax = {
 	.port_cfg = R_AX_PORT_CFG_P0,
 	.tbtt_prohib = R_AX_TBTT_PROHIB_P0,
 	.bcn_area = R_AX_BCN_AREA_P0,
@@ -3759,8 +3759,9 @@ static const struct rtw89_port_reg rtw_port_base = {
 static void rtw89_mac_port_cfg_func_sw(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif *rtwvif)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	const struct rtw89_port_reg *p = &rtw_port_base;
 
 	if (!rtw89_read32_port_mask(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN))
 		return;
@@ -3781,7 +3782,8 @@ static void rtw89_mac_port_cfg_func_sw(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_tx_rpt(struct rtw89_dev *rtwdev,
 				      struct rtw89_vif *rtwvif, bool en)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 
 	if (en)
 		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_TXBCN_RPT_EN);
@@ -3792,7 +3794,8 @@ static void rtw89_mac_port_cfg_tx_rpt(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_rx_rpt(struct rtw89_dev *rtwdev,
 				      struct rtw89_vif *rtwvif, bool en)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 
 	if (en)
 		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_RXBCN_RPT_EN);
@@ -3803,7 +3806,8 @@ static void rtw89_mac_port_cfg_rx_rpt(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_net_type(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 
 	rtw89_write32_port_mask(rtwdev, rtwvif, p->port_cfg, B_AX_NET_TYPE_MASK,
 				rtwvif->net_type);
@@ -3812,7 +3816,8 @@ static void rtw89_mac_port_cfg_net_type(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_bcn_prct(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	bool en = rtwvif->net_type != RTW89_NET_TYPE_NO_LINK;
 	u32 bits = B_AX_TBTT_PROHIB_EN | B_AX_BRK_SETUP;
 
@@ -3825,7 +3830,8 @@ static void rtw89_mac_port_cfg_bcn_prct(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_rx_sw(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	bool en = rtwvif->net_type == RTW89_NET_TYPE_INFRA ||
 		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
 	u32 bit = B_AX_RX_BSSID_FIT_EN;
@@ -3839,7 +3845,8 @@ static void rtw89_mac_port_cfg_rx_sw(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	bool en = rtwvif->net_type == RTW89_NET_TYPE_INFRA ||
 		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
 
@@ -3852,7 +3859,8 @@ static void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_tx_sw(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	bool en = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ||
 		  rtwvif->net_type == RTW89_NET_TYPE_AD_HOC;
 
@@ -3865,8 +3873,9 @@ static void rtw89_mac_port_cfg_tx_sw(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_bcn_intv(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	const struct rtw89_port_reg *p = &rtw_port_base;
 	u16 bcn_int = vif->bss_conf.beacon_int ? vif->bss_conf.beacon_int : BCN_INTERVAL;
 
 	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_space, B_AX_BCN_SPACE_MASK,
@@ -3877,7 +3886,8 @@ static void rtw89_mac_port_cfg_hiq_win(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif *rtwvif)
 {
 	u8 win = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ? 16 : 0;
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	u8 port = rtwvif->port;
 	u32 reg;
 
@@ -3888,8 +3898,9 @@ static void rtw89_mac_port_cfg_hiq_win(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_hiq_dtim(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	const struct rtw89_port_reg *p = &rtw_port_base;
 	u32 addr;
 
 	addr = rtw89_mac_reg_by_idx(rtwdev, p->md_tsft, rtwvif->mac_idx);
@@ -3902,7 +3913,8 @@ static void rtw89_mac_port_cfg_hiq_dtim(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_bcn_setup_time(struct rtw89_dev *rtwdev,
 					      struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 
 	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib,
 				B_AX_TBTT_SETUP_MASK, BCN_SETUP_DEF);
@@ -3911,7 +3923,8 @@ static void rtw89_mac_port_cfg_bcn_setup_time(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_bcn_hold_time(struct rtw89_dev *rtwdev,
 					     struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 
 	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib,
 				B_AX_TBTT_HOLD_MASK, BCN_HOLD_DEF);
@@ -3920,7 +3933,8 @@ static void rtw89_mac_port_cfg_bcn_hold_time(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_bcn_mask_area(struct rtw89_dev *rtwdev,
 					     struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 
 	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_area,
 				B_AX_BCN_MSK_AREA_MASK, BCN_MASK_DEF);
@@ -3929,7 +3943,8 @@ static void rtw89_mac_port_cfg_bcn_mask_area(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_tbtt_early(struct rtw89_dev *rtwdev,
 					  struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 
 	rtw89_write16_port_mask(rtwdev, rtwvif, p->tbtt_early,
 				B_AX_TBTTERLY_MASK, TBTT_ERLY_DEF);
@@ -3938,7 +3953,8 @@ static void rtw89_mac_port_cfg_tbtt_early(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	static const u32 masks[RTW89_PORT_NUM] = {
 		B_AX_BSS_COLOB_AX_PORT_0_MASK, B_AX_BSS_COLOB_AX_PORT_1_MASK,
@@ -3959,7 +3975,8 @@ static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_mbssid(struct rtw89_dev *rtwdev,
 				      struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	u8 port = rtwvif->port;
 	u32 reg;
 
@@ -3975,7 +3992,8 @@ static void rtw89_mac_port_cfg_mbssid(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_hiq_drop(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	u8 port = rtwvif->port;
 	u32 reg;
 	u32 val;
@@ -3991,7 +4009,8 @@ static void rtw89_mac_port_cfg_hiq_drop(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_func_en(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif *rtwvif, bool enable)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 
 	if (enable)
 		rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg,
@@ -4004,7 +4023,8 @@ static void rtw89_mac_port_cfg_func_en(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_bcn_early(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 
 	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK,
 				BCN_ERLY_DEF);
@@ -4013,7 +4033,8 @@ static void rtw89_mac_port_cfg_bcn_early(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_tbtt_shift(struct rtw89_dev *rtwdev,
 					  struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	u16 val;
 
 	if (rtwdev->chip->chip_id != RTL8852C)
@@ -4035,7 +4056,8 @@ void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif *rtwvif_src,
 			     u16 offset_tu)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	u32 val, reg;
 
 	val = RTW89_PORT_OFFSET_TU_TO_32US(offset_tu);
@@ -4177,7 +4199,8 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   u64 *tsf)
 {
-	const struct rtw89_port_reg *p = &rtw_port_base;
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	u32 tsf_low, tsf_high;
 	int ret;
 
@@ -5726,6 +5749,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.indir_access_addr = R_AX_INDIR_ACCESS_ENTRY,
 	.mem_base_addrs = rtw89_mac_mem_base_addrs_ax,
 	.rx_fltr = R_AX_RX_FLTR_OPT,
+	.port_base = &rtw89_port_base_ax,
 
 	.disable_cpu = rtw89_mac_disable_cpu_ax,
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 03d3956f77eb..3c17b57a8ca2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -858,6 +858,7 @@ struct rtw89_mac_gen_def {
 	u32 indir_access_addr;
 	const u32 *mem_base_addrs;
 	u32 rx_fltr;
+	const struct rtw89_port_reg *port_base;
 
 	void (*disable_cpu)(struct rtw89_dev *rtwdev);
 	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason,
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 8cdc594e5703..fbf55274e00e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -30,6 +30,32 @@ static const u32 rtw89_mac_mem_base_addrs_be[RTW89_MAC_MEM_NUM] = {
 	[RTW89_MAC_MEM_WD_PAGE]		= WD_PAGE_BASE_ADDR_BE,
 };
 
+static const struct rtw89_port_reg rtw89_port_base_be = {
+	.port_cfg = R_BE_PORT_CFG_P0,
+	.tbtt_prohib = R_BE_TBTT_PROHIB_P0,
+	.bcn_area = R_BE_BCN_AREA_P0,
+	.bcn_early = R_BE_BCNERLYINT_CFG_P0,
+	.tbtt_early = R_BE_TBTTERLYINT_CFG_P0,
+	.tbtt_agg = R_BE_TBTT_AGG_P0,
+	.bcn_space = R_BE_BCN_SPACE_CFG_P0,
+	.bcn_forcetx = R_BE_BCN_FORCETX_P0,
+	.bcn_err_cnt = R_BE_BCN_ERR_CNT_P0,
+	.bcn_err_flag = R_BE_BCN_ERR_FLAG_P0,
+	.dtim_ctrl = R_BE_DTIM_CTRL_P0,
+	.tbtt_shift = R_BE_TBTT_SHIFT_P0,
+	.bcn_cnt_tmr = R_BE_BCN_CNT_TMR_P0,
+	.tsftr_l = R_BE_TSFTR_LOW_P0,
+	.tsftr_h = R_BE_TSFTR_HIGH_P0,
+	.md_tsft = R_BE_WMTX_MOREDATA_TSFT_STMP_CTL,
+	.bss_color = R_BE_PTCL_BSS_COLOR_0,
+	.mbssid = R_BE_MBSSID_CTRL,
+	.mbssid_drop = R_BE_MBSSID_DROP_0,
+	.tsf_sync = R_BE_PORT_0_TSF_SYNC,
+	.hiq_win = {R_BE_P0MB_HGQ_WINDOW_CFG_0, R_BE_PORT_HGQ_WINDOW_CFG,
+		    R_BE_PORT_HGQ_WINDOW_CFG + 1, R_BE_PORT_HGQ_WINDOW_CFG + 2,
+		    R_BE_PORT_HGQ_WINDOW_CFG + 3},
+};
+
 static void rtw89_mac_disable_cpu_be(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -185,6 +211,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.indir_access_addr = R_BE_INDIR_ACCESS_ENTRY,
 	.mem_base_addrs = rtw89_mac_mem_base_addrs_be,
 	.rx_fltr = R_BE_RX_FLTR_OPT,
+	.port_base = &rtw89_port_base_be,
 
 	.disable_cpu = rtw89_mac_disable_cpu_be,
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 95dc51eb515f..edaf2a13ef98 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3736,6 +3736,153 @@
 #define R_BE_PLE_DBG_FUN_INTF_DATA 0x9114
 #define B_BE_PLE_DFI_DATA_MASK GENMASK(31, 0)
 
+#define R_BE_PORT_0_TSF_SYNC 0x102A0
+#define R_BE_PORT_0_TSF_SYNC_C1 0x142A0
+#define B_BE_P0_SYNC_NOW_P BIT(30)
+#define B_BE_P0_SYNC_ONCE_P BIT(29)
+#define B_BE_P0_AUTO_SYNC BIT(28)
+#define B_BE_P0_SYNC_PORT_SRC_SEL_MASK GENMASK(26, 24)
+#define B_BE_P0_TSFTR_SYNC_OFFSET_MASK GENMASK(18, 0)
+
+#define R_BE_PORT_CFG_P0 0x10400
+#define R_BE_PORT_CFG_P0_C1 0x14400
+#define B_BE_BCN_ERLY_SORT_EN_P0 BIT(18)
+#define B_BE_PROHIB_END_CAL_EN_P0 BIT(17)
+#define B_BE_BRK_SETUP_P0 BIT(16)
+#define B_BE_TBTT_UPD_SHIFT_SEL_P0 BIT(15)
+#define B_BE_BCN_DROP_ALLOW_P0 BIT(14)
+#define B_BE_TBTT_PROHIB_EN_P0 BIT(13)
+#define B_BE_BCNTX_EN_P0 BIT(12)
+#define B_BE_NET_TYPE_P0_MASK GENMASK(11, 10)
+#define B_BE_BCN_FORCETX_EN_P0 BIT(9)
+#define B_BE_TXBCN_BTCCA_EN_P0 BIT(8)
+#define B_BE_BCNERR_CNT_EN_P0 BIT(7)
+#define B_BE_BCN_AGRES_P0 BIT(6)
+#define B_BE_TSFTR_RST_P0 BIT(5)
+#define B_BE_RX_BSSID_FIT_EN_P0 BIT(4)
+#define B_BE_TSF_UDT_EN_P0 BIT(3)
+#define B_BE_PORT_FUNC_EN_P0 BIT(2)
+#define B_BE_TXBCN_RPT_EN_P0 BIT(1)
+#define B_BE_RXBCN_RPT_EN_P0 BIT(0)
+
+#define R_BE_TBTT_PROHIB_P0 0x10404
+#define R_BE_TBTT_PROHIB_P0_C1 0x14404
+#define B_BE_TBTT_HOLD_P0_MASK GENMASK(27, 16)
+#define B_BE_TBTT_SETUP_P0_MASK GENMASK(7, 0)
+
+#define R_BE_BCN_AREA_P0 0x10408
+#define R_BE_BCN_AREA_P0_C1 0x14408
+#define B_BE_BCN_MSK_AREA_P0_MSK 0xfff
+#define B_BE_BCN_CTN_AREA_P0_MASK GENMASK(11, 0)
+
+#define R_BE_BCNERLYINT_CFG_P0 0x1040C
+#define R_BE_BCNERLYINT_CFG_P0_C1 0x1440C
+#define B_BE_BCNERLY_P0_MASK GENMASK(11, 0)
+
+#define R_BE_TBTTERLYINT_CFG_P0 0x1040E
+#define R_BE_TBTTERLYINT_CFG_P0_C1 0x1440E
+#define B_BE_TBTTERLY_P0_MASK GENMASK(11, 0)
+
+#define R_BE_TBTT_AGG_P0 0x10412
+#define R_BE_TBTT_AGG_P0_C1 0x14412
+#define B_BE_TBTT_AGG_NUM_P0_MASK GENMASK(15, 8)
+
+#define R_BE_BCN_SPACE_CFG_P0 0x10414
+#define R_BE_BCN_SPACE_CFG_P0_C1 0x14414
+#define B_BE_SUB_BCN_SPACE_P0_MASK GENMASK(23, 16)
+#define B_BE_BCN_SPACE_P0_MASK GENMASK(15, 0)
+
+#define R_BE_BCN_FORCETX_P0 0x10418
+#define R_BE_BCN_FORCETX_P0_C1 0x14418
+#define B_BE_FORCE_BCN_NUM_P0_MASK GENMASK(15, 8)
+#define B_BE_BCN_MAX_ERR_P0_MASK GENMASK(7, 0)
+
+#define R_BE_BCN_ERR_CNT_P0 0x10420
+#define R_BE_BCN_ERR_CNT_P0_C1 0x14420
+#define B_BE_BCN_ERR_CNT_SUM_P0_MASK GENMASK(31, 24)
+#define B_BE_BCN_ERR_CNT_NAV_P0_MASK GENMASK(23, 16)
+#define B_BE_BCN_ERR_CNT_EDCCA_P0_MASK GENMASK(15, 8)
+#define B_BE_BCN_ERR_CNT_CCA_P0_MASK GENMASK(7, 0)
+
+#define R_BE_BCN_ERR_FLAG_P0 0x10424
+#define R_BE_BCN_ERR_FLAG_P0_C1 0x14424
+#define B_BE_BCN_ERR_FLAG_SRCHEND_P0 BIT(3)
+#define B_BE_BCN_ERR_FLAG_INVALID_P0 BIT(2)
+#define B_BE_BCN_ERR_FLAG_CMP_P0 BIT(1)
+#define B_BE_BCN_ERR_FLAG_LOCK_P0 BIT(0)
+
+#define R_BE_DTIM_CTRL_P0 0x10426
+#define R_BE_DTIM_CTRL_P0_C1 0x14426
+#define B_BE_DTIM_NUM_P0_MASK GENMASK(15, 8)
+#define B_BE_DTIM_CURRCNT_P0_MASK GENMASK(7, 0)
+
+#define R_BE_TBTT_SHIFT_P0 0x10428
+#define R_BE_TBTT_SHIFT_P0_C1 0x14428
+#define B_BE_TBTT_SHIFT_OFST_P0_SH 0
+#define B_BE_TBTT_SHIFT_OFST_P0_MSK 0xfff
+
+#define R_BE_BCN_CNT_TMR_P0 0x10434
+#define R_BE_BCN_CNT_TMR_P0_C1 0x14434
+#define B_BE_BCN_CNT_TMR_P0_MASK GENMASK(31, 0)
+
+#define R_BE_TSFTR_LOW_P0 0x10438
+#define R_BE_TSFTR_LOW_P0_C1 0x14438
+#define B_BE_TSFTR_LOW_P0_MASK GENMASK(31, 0)
+
+#define R_BE_TSFTR_HIGH_P0 0x1043C
+#define R_BE_TSFTR_HIGH_P0_C1 0x1443C
+#define B_BE_TSFTR_HIGH_P0_MASK GENMASK(31, 0)
+
+#define R_BE_MBSSID_CTRL 0x10568
+#define R_BE_MBSSID_CTRL_C1 0x14568
+#define B_BE_MBSSID_MODE_SEL BIT(20)
+#define B_BE_P0MB_NUM_MASK GENMASK(19, 16)
+#define B_BE_P0MB15_EN BIT(15)
+#define B_BE_P0MB14_EN BIT(14)
+#define B_BE_P0MB13_EN BIT(13)
+#define B_BE_P0MB12_EN BIT(12)
+#define B_BE_P0MB11_EN BIT(11)
+#define B_BE_P0MB10_EN BIT(10)
+#define B_BE_P0MB9_EN BIT(9)
+#define B_BE_P0MB8_EN BIT(8)
+#define B_BE_P0MB7_EN BIT(7)
+#define B_BE_P0MB6_EN BIT(6)
+#define B_BE_P0MB5_EN BIT(5)
+#define B_BE_P0MB4_EN BIT(4)
+#define B_BE_P0MB3_EN BIT(3)
+#define B_BE_P0MB2_EN BIT(2)
+#define B_BE_P0MB1_EN BIT(1)
+
+#define R_BE_P0MB_HGQ_WINDOW_CFG_0 0x10590
+#define R_BE_P0MB_HGQ_WINDOW_CFG_0_C1 0x14590
+#define R_BE_PORT_HGQ_WINDOW_CFG 0x105A0
+#define R_BE_PORT_HGQ_WINDOW_CFG_C1 0x145A0
+
+#define R_BE_MBSSID_DROP_0 0x1083C
+#define R_BE_MBSSID_DROP_0_C1 0x1483C
+#define B_BE_GI_LTF_FB_SEL BIT(30)
+#define B_BE_RATE_SEL_MASK GENMASK(29, 24)
+#define B_BE_PORT_DROP_4_0_MASK GENMASK(20, 16)
+#define B_BE_MBSSID_DROP_15_0_MASK GENMASK(15, 0)
+
+#define R_BE_PTCL_BSS_COLOR_0 0x108A0
+#define R_BE_PTCL_BSS_COLOR_0_C1 0x148A0
+#define B_BE_BSS_COLOB_BE_PORT_3_MASK GENMASK(29, 24)
+#define B_BE_BSS_COLOB_BE_PORT_2_MASK GENMASK(21, 16)
+#define B_BE_BSS_COLOB_BE_PORT_1_MASK GENMASK(13, 8)
+#define B_BE_BSS_COLOB_BE_PORT_0_MASK GENMASK(5, 0)
+
+#define R_BE_PTCL_BSS_COLOR_1 0x108A4
+#define R_BE_PTCL_BSS_COLOR_1_C1 0x148A4
+#define B_BE_BSS_COLOB_BE_PORT_4_MASK GENMASK(5, 0)
+
+#define R_BE_WMTX_MOREDATA_TSFT_STMP_CTL 0x10E08
+#define R_BE_WMTX_MOREDATA_TSFT_STMP_CTL_C1 0x14E08
+#define B_BE_TSFT_OFS_MASK GENMASK(31, 16)
+#define B_BE_STMP_THSD_MASK GENMASK(15, 8)
+#define B_BE_UPD_HGQMD BIT(1)
+#define B_BE_UPD_TIMIE BIT(0)
+
 #define R_BE_RX_FLTR_OPT 0x11420
 #define R_BE_RX_FLTR_OPT_C1 0x15420
 #define B_BE_UID_FILTER_MASK GENMASK(31, 24)
-- 
2.25.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EE979A5F3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Sep 2023 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjIKIW6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 04:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjIKIW4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 04:22:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF91DC
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 01:22:50 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38B8MhAxA1003652, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38B8MhAxA1003652
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 16:22:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 11 Sep 2023 16:22:05 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Sep
 2023 16:22:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: consolidate registers of mac port to struct
Date:   Mon, 11 Sep 2023 16:20:48 +0800
Message-ID: <20230911082049.33541-6-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

MAC port is a design to support virtual interface on single MAC hardware.
For next generation chips, register addresses are changed but definitions
are the same, so move registers together to be easier to reuse codes.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  6 +++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 32 ++++++++++++++---------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 77d283db4f49..bbe7a90bc8e7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -926,6 +926,12 @@ struct rtw89_port_reg {
 	u32 bcn_cnt_tmr;
 	u32 tsftr_l;
 	u32 tsftr_h;
+	u32 md_tsft;
+	u32 bss_color;
+	u32 mbssid;
+	u32 mbssid_drop;
+	u32 tsf_sync;
+	u32 hiq_win[RTW89_PORT_NUM];
 };
 
 struct rtw89_txwd_body {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 1b57c356a7a5..cd386531830b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3736,7 +3736,15 @@ static const struct rtw89_port_reg rtw_port_base = {
 	.tbtt_shift = R_AX_TBTT_SHIFT_P0,
 	.bcn_cnt_tmr = R_AX_BCN_CNT_TMR_P0,
 	.tsftr_l = R_AX_TSFTR_LOW_P0,
-	.tsftr_h = R_AX_TSFTR_HIGH_P0
+	.tsftr_h = R_AX_TSFTR_HIGH_P0,
+	.md_tsft = R_AX_MD_TSFT_STMP_CTL,
+	.bss_color = R_AX_PTCL_BSS_COLOR_0,
+	.mbssid = R_AX_MBSSID_CTRL,
+	.mbssid_drop = R_AX_MBSSID_DROP_0,
+	.tsf_sync = R_AX_PORT0_TSF_SYNC,
+	.hiq_win = {R_AX_P0MB_HGQ_WINDOW_CFG_0, R_AX_PORT_HGQ_WINDOW_CFG,
+		    R_AX_PORT_HGQ_WINDOW_CFG + 1, R_AX_PORT_HGQ_WINDOW_CFG + 2,
+		    R_AX_PORT_HGQ_WINDOW_CFG + 3},
 };
 
 #define BCN_INTERVAL 100
@@ -3868,16 +3876,12 @@ static void rtw89_mac_port_cfg_bcn_intv(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_hiq_win(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif *rtwvif)
 {
-	static const u32 hiq_win_addr[RTW89_PORT_NUM] = {
-		R_AX_P0MB_HGQ_WINDOW_CFG_0, R_AX_PORT_HGQ_WINDOW_CFG,
-		R_AX_PORT_HGQ_WINDOW_CFG + 1, R_AX_PORT_HGQ_WINDOW_CFG + 2,
-		R_AX_PORT_HGQ_WINDOW_CFG + 3,
-	};
 	u8 win = rtwvif->net_type == RTW89_NET_TYPE_AP_MODE ? 16 : 0;
+	const struct rtw89_port_reg *p = &rtw_port_base;
 	u8 port = rtwvif->port;
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, hiq_win_addr[port], rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, p->hiq_win[port], rtwvif->mac_idx);
 	rtw89_write8(rtwdev, reg, win);
 }
 
@@ -3888,7 +3892,7 @@ static void rtw89_mac_port_cfg_hiq_dtim(struct rtw89_dev *rtwdev,
 	const struct rtw89_port_reg *p = &rtw_port_base;
 	u32 addr;
 
-	addr = rtw89_mac_reg_by_idx(rtwdev, R_AX_MD_TSFT_STMP_CTL, rtwvif->mac_idx);
+	addr = rtw89_mac_reg_by_idx(rtwdev, p->md_tsft, rtwvif->mac_idx);
 	rtw89_write8_set(rtwdev, addr, B_AX_UPD_HGQMD | B_AX_UPD_TIMIE);
 
 	rtw89_write16_port_mask(rtwdev, rtwvif, p->dtim_ctrl, B_AX_DTIM_NUM_MASK,
@@ -3934,6 +3938,7 @@ static void rtw89_mac_port_cfg_tbtt_early(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 					 struct rtw89_vif *rtwvif)
 {
+	const struct rtw89_port_reg *p = &rtw_port_base;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	static const u32 masks[RTW89_PORT_NUM] = {
 		B_AX_BSS_COLOB_AX_PORT_0_MASK, B_AX_BSS_COLOB_AX_PORT_1_MASK,
@@ -3946,7 +3951,7 @@ static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 	u8 bss_color;
 
 	bss_color = vif->bss_conf.he_bss_color.color;
-	reg_base = port >= 4 ? R_AX_PTCL_BSS_COLOR_1 : R_AX_PTCL_BSS_COLOR_0;
+	reg_base = port >= 4 ? p->bss_color + 4 : p->bss_color;
 	reg = rtw89_mac_reg_by_idx(rtwdev, reg_base, rtwvif->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, masks[port], bss_color);
 }
@@ -3954,6 +3959,7 @@ static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_mbssid(struct rtw89_dev *rtwdev,
 				      struct rtw89_vif *rtwvif)
 {
+	const struct rtw89_port_reg *p = &rtw_port_base;
 	u8 port = rtwvif->port;
 	u32 reg;
 
@@ -3961,7 +3967,7 @@ static void rtw89_mac_port_cfg_mbssid(struct rtw89_dev *rtwdev,
 		return;
 
 	if (port == 0) {
-		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_MBSSID_CTRL, rtwvif->mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, p->mbssid, rtwvif->mac_idx);
 		rtw89_write32_clr(rtwdev, reg, B_AX_P0MB_ALL_MASK);
 	}
 }
@@ -3969,11 +3975,12 @@ static void rtw89_mac_port_cfg_mbssid(struct rtw89_dev *rtwdev,
 static void rtw89_mac_port_cfg_hiq_drop(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif)
 {
+	const struct rtw89_port_reg *p = &rtw_port_base;
 	u8 port = rtwvif->port;
 	u32 reg;
 	u32 val;
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_MBSSID_DROP_0, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, p->mbssid_drop, rtwvif->mac_idx);
 	val = rtw89_read32(rtwdev, reg);
 	val &= ~FIELD_PREP(B_AX_PORT_DROP_4_0_MASK, BIT(port));
 	if (port == 0)
@@ -4028,10 +4035,11 @@ void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif *rtwvif_src,
 			     u16 offset_tu)
 {
+	const struct rtw89_port_reg *p = &rtw_port_base;
 	u32 val, reg;
 
 	val = RTW89_PORT_OFFSET_TU_TO_32US(offset_tu);
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PORT0_TSF_SYNC + rtwvif->port * 4,
+	reg = rtw89_mac_reg_by_idx(rtwdev, p->tsf_sync + rtwvif->port * 4,
 				   rtwvif->mac_idx);
 
 	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_SRC, rtwvif_src->port);
-- 
2.25.1


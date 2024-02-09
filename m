Return-Path: <linux-wireless+bounces-3378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5984F075
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 07:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398821C223B8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5DF657D0;
	Fri,  9 Feb 2024 06:54:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8446657CA
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461644; cv=none; b=N6p/6OQH7c5Z4ORiXYHzGEhmTVpI/Fv+Vlq7HUP6J7eono6S4D8tMOk5agWAQJIYbyDE8RBlpRkPIb3JTto0ZSvobgbqJx0WVDUa44fEr2J6ARzkbLWfvrpLdy6CYlamHDCfQwMANtc5hJOoED1369dlh0Ntt8v7R02oEg2WAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461644; c=relaxed/simple;
	bh=qbsr/XeIGJaw/1/cXO0Hc5s4EY+eMs2WCGAvJJkk5HE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7fJcYIFR6sWxVO7GX6Db90ItpLftiR1Ngl/4Cs+5IG1VCFJ30ebeU+H71w9pMEwkCZEyRlerapInDL//Nqq0Pgv7WDPYuk8ZffrTUM79GptwBn+aLqkJaB6bhACPyKlfS0x9qIM5HJjjh6RLVC/lIAl0dOs2rhYA3tglTC0fh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4196ruJH3548429, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4196ruJH3548429
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 14:53:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 9 Feb 2024 14:53:57 +0800
Received: from [127.0.1.1] (172.16.16.210) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Feb
 2024 14:53:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 09/11] wifi: rtw89: 8922a: implement AP mode related reg for BE generation
Date: Fri, 9 Feb 2024 14:52:27 +0800
Message-ID: <20240209065229.34515-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209065229.34515-1-pkshih@realtek.com>
References: <20240209065229.34515-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chih-Kang Chang <gary.chang@realtek.com>

Modify reg for BE generation when AP stop, otherwise have warning
messages "Polling beacon packet empty fail".

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  3 +++
 drivers/net/wireless/realtek/rtw89/mac.c    | 13 +++++++++----
 drivers/net/wireless/realtek/rtw89/mac_be.c |  3 +++
 drivers/net/wireless/realtek/rtw89/reg.h    |  6 ++++++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 713383b6d818..4411a7d117cf 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -958,6 +958,9 @@ struct rtw89_port_reg {
 	u32 mbssid;
 	u32 mbssid_drop;
 	u32 tsf_sync;
+	u32 ptcl_dbg;
+	u32 ptcl_dbg_info;
+	u32 bcn_drop_all;
 	u32 hiq_win[RTW89_PORT_NUM];
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 16690295b73e..33cc2ce4bb74 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4037,6 +4037,9 @@ static const struct rtw89_port_reg rtw89_port_base_ax = {
 	.mbssid = R_AX_MBSSID_CTRL,
 	.mbssid_drop = R_AX_MBSSID_DROP_0,
 	.tsf_sync = R_AX_PORT0_TSF_SYNC,
+	.ptcl_dbg = R_AX_PTCL_DBG,
+	.ptcl_dbg_info = R_AX_PTCL_DBG_INFO,
+	.bcn_drop_all = R_AX_BCN_DROP_ALL0,
 	.hiq_win = {R_AX_P0MB_HGQ_WINDOW_CFG_0, R_AX_PORT_HGQ_WINDOW_CFG,
 		    R_AX_PORT_HGQ_WINDOW_CFG + 1, R_AX_PORT_HGQ_WINDOW_CFG + 2,
 		    R_AX_PORT_HGQ_WINDOW_CFG + 3},
@@ -4045,13 +4048,15 @@ static const struct rtw89_port_reg rtw89_port_base_ax = {
 static void rtw89_mac_check_packet_ctrl(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif, u8 type)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
 	u8 mask = B_AX_PTCL_DBG_INFO_MASK_BY_PORT(rtwvif->port);
 	u32 reg_info, reg_ctrl;
 	u32 val;
 	int ret;
 
-	reg_info = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_DBG_INFO, rtwvif->mac_idx);
-	reg_ctrl = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_DBG, rtwvif->mac_idx);
+	reg_info = rtw89_mac_reg_by_idx(rtwdev, p->ptcl_dbg_info, rtwvif->mac_idx);
+	reg_ctrl = rtw89_mac_reg_by_idx(rtwdev, p->ptcl_dbg, rtwvif->mac_idx);
 
 	rtw89_write32_mask(rtwdev, reg_ctrl, B_AX_PTCL_DBG_SEL_MASK, type);
 	rtw89_write32_set(rtwdev, reg_ctrl, B_AX_PTCL_DBG_EN);
@@ -4068,7 +4073,7 @@ static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvi
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 
-	rtw89_write32_set(rtwdev, R_AX_BCN_DROP_ALL0, BIT(rtwvif->port));
+	rtw89_write32_set(rtwdev, p->bcn_drop_all, BIT(rtwvif->port));
 	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK, 1);
 	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_area, B_AX_BCN_MSK_AREA_MASK, 0);
 	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK, 0);
@@ -4081,7 +4086,7 @@ static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvi
 	if (rtwvif->port == RTW89_PORT_0)
 		rtw89_mac_check_packet_ctrl(rtwdev, rtwvif, AX_PTCL_DBG_BCNQ_NUM1);
 
-	rtw89_write32_clr(rtwdev, R_AX_BCN_DROP_ALL0, BIT(rtwvif->port));
+	rtw89_write32_clr(rtwdev, p->bcn_drop_all, BIT(rtwvif->port));
 	rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_TBTT_PROHIB_EN);
 	fsleep(2000);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 6388c56a3c90..6447353d35d3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -52,6 +52,9 @@ static const struct rtw89_port_reg rtw89_port_base_be = {
 	.mbssid = R_BE_MBSSID_CTRL,
 	.mbssid_drop = R_BE_MBSSID_DROP_0,
 	.tsf_sync = R_BE_PORT_0_TSF_SYNC,
+	.ptcl_dbg = R_BE_PTCL_DBG,
+	.ptcl_dbg_info = R_BE_PTCL_DBG_INFO,
+	.bcn_drop_all = R_BE_BCN_DROP_ALL0,
 	.hiq_win = {R_BE_P0MB_HGQ_WINDOW_CFG_0, R_BE_PORT_HGQ_WINDOW_CFG,
 		    R_BE_PORT_HGQ_WINDOW_CFG + 1, R_BE_PORT_HGQ_WINDOW_CFG + 2,
 		    R_BE_PORT_HGQ_WINDOW_CFG + 3},
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 26aa2d9bd526..23a09efabab7 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6347,6 +6347,8 @@
 #define R_BE_TSFTR_HIGH_P0_C1 0x1443C
 #define B_BE_TSFTR_HIGH_P0_MASK GENMASK(31, 0)
 
+#define R_BE_BCN_DROP_ALL0 0x10560
+
 #define R_BE_MBSSID_CTRL 0x10568
 #define R_BE_MBSSID_CTRL_C1 0x14568
 #define B_BE_MBSSID_MODE_SEL BIT(20)
@@ -6533,6 +6535,10 @@
 #define B_BE_PTCL_DROP BIT(5)
 #define B_BE_PTCL_TX_QUEUE_IDX_MASK GENMASK(4, 0)
 
+#define R_BE_PTCL_DBG_INFO 0x108F0
+
+#define R_BE_PTCL_DBG 0x108F4
+
 #define R_BE_RX_ERROR_FLAG 0x10C00
 #define R_BE_RX_ERROR_FLAG_C1 0x14C00
 #define B_BE_RX_CSI_NOT_RELEASE_ERROR BIT(31)
-- 
2.25.1



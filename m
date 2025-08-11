Return-Path: <linux-wireless+bounces-26261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23156B2090B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A1318A391F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0AA145A05;
	Mon, 11 Aug 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pQlLkDgZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45323B613
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916047; cv=none; b=iwCt5wjK5XdxtM7bunhMvF0dUQMC43IU501k82k4l1ZfMWR2I1BP7cnu/JObhgJJC0BV5aYBBxsf+MoJDCHSaD8QRHSKST4cEhOp6gYb+RZ8voM2yOHh3goUeBpMje7jGdrwkmTBJH6pK3fd+9M21x68p5HzysHoeldAaRm0Hak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916047; c=relaxed/simple;
	bh=ce+Vnm3Tzh2kHxwjGx5B54u4Rqr5tZjL5YNBMtMefOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5ukaPPae7DHzTftYcf+rO8f51U0nEioQAVL3k7XEHGDn++Ycy/mJ2WXI56f00xo0C/PI8MaoOoOkWRCXSvGrBo7lc269TtpLATfqxIxG2TkswTJVDgW5YtRbcvXQzVyufA5beaXi7F5Y7QYXI6WLEc6ttJqtllxj6kUtw20Puw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pQlLkDgZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57BCegJ23074079, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754916042; bh=ivTc7yBaajPd3y53cT5OCTV5wI9kQv1j4lyXH/ZdFJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pQlLkDgZuVpW+c5myFA9/wnOVOA4H/FCDSPZKy0kaJn8zJLaCWwwB7yHYIlRhMMyc
	 zLsTStAiA1fv5dT0XMz5jIlfzk5ScCVbsshcuW+GvyDX64BMg5zDsxdW+v6QJ+SlNO
	 1GQjmykzbUtPeQSRjYgtxh/Fxqa4UIuJrE8x7RAUmDm0kYZgM6Oxwxqrwux4qBRLs9
	 CEL0AtP/zi2vTH6lM06r7Oxfu/RxB47U88EWUr5hFHNcFxDUkao284tRQqeO5d+Btq
	 6sx3tSPdndknpeWq7YSzkNH/sE8dE4b1gmBT5UTQfI+PP8bNYZnhDP55wAqcQw2GKP
	 uIiJsC6fiBHYA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57BCegJ23074079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 20:40:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 20:40:42 +0800
Received: from [127.0.1.1] (10.22.225.179) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 11 Aug
 2025 20:40:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH rtw-next 8/8] wifi: rtw89: fix group frames loss when connected to non-transmitted BSSID
Date: Mon, 11 Aug 2025 20:40:01 +0800
Message-ID: <20250811124001.15774-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811123744.15361-1-pkshih@realtek.com>
References: <20250811123744.15361-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Kuan-Chung Chen <damon.chen@realtek.com>

When STA connects to AP with dot11MultiBSSIDImplemented set to true,
the layout of the TIM element's Partial Virtual Bitmap changes. Bits
1 to (2^n - 1) are used to indicate buffered group addressed frames
(e.g., broadcast/multicast) for non-transmitted BSSIDs. Fix the
interpretation of this field to ensure group addressed frames
are correctly received.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c    | 26 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h    |  8 +++++++
 4 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ca48426c577f..d8c40ce3ec61 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1011,6 +1011,7 @@ struct rtw89_port_reg {
 	u32 ptcl_dbg;
 	u32 ptcl_dbg_info;
 	u32 bcn_drop_all;
+	u32 bcn_psr_rpt;
 	u32 hiq_win[RTW89_PORT_NUM];
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d7aa279b9f7c..f99cfa2680e8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4197,6 +4197,7 @@ static const struct rtw89_port_reg rtw89_port_base_ax = {
 	.ptcl_dbg = R_AX_PTCL_DBG,
 	.ptcl_dbg_info = R_AX_PTCL_DBG_INFO,
 	.bcn_drop_all = R_AX_BCN_DROP_ALL0,
+	.bcn_psr_rpt = R_AX_BCN_PSR_RPT_P0,
 	.hiq_win = {R_AX_P0MB_HGQ_WINDOW_CFG_0, R_AX_PORT_HGQ_WINDOW_CFG,
 		    R_AX_PORT_HGQ_WINDOW_CFG + 1, R_AX_PORT_HGQ_WINDOW_CFG + 2,
 		    R_AX_PORT_HGQ_WINDOW_CFG + 3},
@@ -4649,6 +4650,30 @@ static void rtw89_mac_port_cfg_bcn_early(struct rtw89_dev *rtwdev,
 				BCN_ERLY_DEF);
 }
 
+static void rtw89_mac_port_cfg_bcn_psr_rpt(struct rtw89_dev *rtwdev,
+					   struct rtw89_vif_link *rtwvif_link)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
+	struct ieee80211_bss_conf *bss_conf;
+	u8 bssid_index;
+	u32 reg;
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	if (bss_conf->nontransmitted)
+		bssid_index = bss_conf->bssid_index;
+	else
+		bssid_index = 0;
+
+	rcu_read_unlock();
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, p->bcn_psr_rpt + rtwvif_link->port * 4,
+				   rtwvif_link->mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_BCAID_P0_MASK, bssid_index);
+}
+
 void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif_link *rtwvif_link,
 			     struct rtw89_vif_link *rtwvif_src,
@@ -4805,6 +4830,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 	rtw89_mac_port_tsf_resync_all(rtwdev);
 	fsleep(BCN_ERLY_SET_DLY);
 	rtw89_mac_port_cfg_bcn_early(rtwdev, rtwvif_link);
+	rtw89_mac_port_cfg_bcn_psr_rpt(rtwdev, rtwvif_link);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 0078080b3999..ef69672b6862 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -56,6 +56,7 @@ static const struct rtw89_port_reg rtw89_port_base_be = {
 	.ptcl_dbg = R_BE_PTCL_DBG,
 	.ptcl_dbg_info = R_BE_PTCL_DBG_INFO,
 	.bcn_drop_all = R_BE_BCN_DROP_ALL0,
+	.bcn_psr_rpt = R_BE_BCN_PSR_RPT_P0,
 	.hiq_win = {R_BE_P0MB_HGQ_WINDOW_CFG_0, R_BE_PORT_HGQ_WINDOW_CFG,
 		    R_BE_PORT_HGQ_WINDOW_CFG + 1, R_BE_PORT_HGQ_WINDOW_CFG + 2,
 		    R_BE_PORT_HGQ_WINDOW_CFG + 3},
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 0aad9dc91736..bfed0bbcfb7e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3370,6 +3370,10 @@
 #define B_AX_CSIPRT_HESU_AID_EN BIT(25)
 #define B_AX_CSIPRT_VHTSU_AID_EN BIT(24)
 
+#define R_AX_BCN_PSR_RPT_P0 0xCE84
+#define R_AX_BCN_PSR_RPT_P0_C1 0xEE84
+#define B_AX_BCAID_P0_MASK GENMASK(10, 0)
+
 #define R_AX_RX_STATE_MONITOR 0xCEF0
 #define R_AX_RX_STATE_MONITOR_C1 0xEEF0
 #define B_AX_RX_STATE_MONITOR_MASK GENMASK(31, 0)
@@ -7494,6 +7498,10 @@
 #define R_BE_DRV_INFO_OPTION_C1 0x15470
 #define B_BE_DRV_INFO_PHYRPT_EN BIT(0)
 
+#define R_BE_BCN_PSR_RPT_P0 0x11484
+#define R_BE_BCN_PSR_RPT_P0_C1 0x15484
+#define B_BE_BCAID_P0_MASK GENMASK(10, 0)
+
 #define R_BE_RX_ERR_ISR 0x114F4
 #define R_BE_RX_ERR_ISR_C1 0x154F4
 #define B_BE_RX_ERR_TRIG_ACT_TO BIT(9)
-- 
2.25.1



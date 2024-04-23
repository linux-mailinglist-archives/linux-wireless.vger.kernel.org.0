Return-Path: <linux-wireless+bounces-6721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4678AE5BB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 14:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B4D1F22838
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 12:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1595485285;
	Tue, 23 Apr 2024 12:13:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1B7E761
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874414; cv=none; b=bMr3nqrzTOZxaMxymWiHuV0gOXrGByVIyAHbI3BLoC1BCT0aUUYlUaQ8xdROsnglPxkXYBhPRQEYColw7BX4D6/ULimdQ4aBdCFtAS35MN+wIR/a16/xTWqdr8fNh8DaW+VmtAZEvr5/iojHbIv88EOI+oRUUhz5wK4O4LhmTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874414; c=relaxed/simple;
	bh=N2Iue3YlegBnmej9FrHZEg2EQxdT0j+hPR496TRqaiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/aP2cxrvtb4eqxlo6pleo+2mY25I242I89fg4DI6samd1jfdbXjHfBYhcA3xcEbVdhOoOf1Mzz3mYJXOxdzO1ytXOY0Ah5SPB4Xzq4225XVCwthxAqdco/7e9T6QxjZSrf0a5QxZ5zJCwHMexLG2LmwTemM6QqWSvItxN3tOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43NCDSpL41225456, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43NCDSpL41225456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:13:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 20:13:29 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 20:13:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH 2/2] wifi: rtw89: 8852b: update hardware parameters for RFE type 5
Date: Tue, 23 Apr 2024 20:12:47 +0800
Message-ID: <20240423121247.24714-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423121247.24714-1-pkshih@realtek.com>
References: <20240423121247.24714-1-pkshih@realtek.com>
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

RFE type 5 of 8852B is a type of hardware module, which can use different
external components, so update register settings accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  3 +++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 0c0d3c84b178..01cbd0312102 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -235,6 +235,9 @@
 
 #define R_AX_SPSANA_ON_CTRL1 0x0224
 
+#define R_AX_SPS_ANA_ON_CTRL2 0x0228
+#define RTL8852B_RFE_05_SPS_ANA 0x4A82
+
 #define R_AX_WLAN_XTAL_SI_CTRL 0x0270
 #define B_AX_WL_XTAL_SI_CMD_POLL BIT(31)
 #define B_AX_BT_XTAL_SI_ERR_FLAG BIT(30)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 85908c55baa9..9b8f1d06512e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -390,6 +390,14 @@ static const struct rtw89_btc_fbtc_mreg rtw89_btc_8852b_mon_reg[] = {
 static const u8 rtw89_btc_8852b_wl_rssi_thres[BTC_WL_RSSI_THMAX] = {70, 60, 50, 40};
 static const u8 rtw89_btc_8852b_bt_rssi_thres[BTC_BT_RSSI_THMAX] = {50, 40, 30, 20};
 
+static void rtw8852b_pwr_sps_ana(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+
+	if (efuse->rfe_type == 0x5)
+		rtw89_write16(rtwdev, R_AX_SPS_ANA_ON_CTRL2, RTL8852B_RFE_05_SPS_ANA);
+}
+
 static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -522,6 +530,10 @@ static int rtw8852b_pwr_off_func(struct rtw89_dev *rtwdev)
 	u32 val32;
 	u32 ret;
 
+	/* Only do once during probe stage after reading efuse */
+	if (!test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags))
+		rtw8852b_pwr_sps_ana(rtwdev);
+
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_RFC2RF,
 				      XTAL_SI_RFC2RF);
 	if (ret)
-- 
2.25.1



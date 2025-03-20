Return-Path: <linux-wireless+bounces-20605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A74A69ED0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 04:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58561887A65
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B71E98FB;
	Thu, 20 Mar 2025 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="h4LSoJdf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF61EB1BA
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441294; cv=none; b=oncS+P6922d1BY6NIva+p6IopZqkC6YxmqkXeckw4F7FhWn9IeYM2XLET3XfteMkdJQlOKrop7uhUPRSLcTUjrwWYHBH560rFHqWutLNUbwf0VtfNuRBpWsuOPy0hN6QXJMOs2vYVtXjL+bpddhrcfGmteFFRaqQ8eYj9RNnwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441294; c=relaxed/simple;
	bh=XVzFhnmmSZL1rPT3hB1zjgjJGEPWEtvKZ+WzfiBdCfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGWmFzaPqIWKUbuPX2DURc5MJ5Jaa0a1euqGZJ7TwWTYUXX9/UWbTQnh3LNhIstFa1WamdFpb0WF/a0EuPG6cekv83DGe7AlpRMcbjdsxxs5XmmnGZRkCqM41qPUPQQBPs68I22iceWklEpoFkqZXK9x1g2tIi5fKM4b9mFVXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=h4LSoJdf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K3SA7O01750988, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742441290; bh=XVzFhnmmSZL1rPT3hB1zjgjJGEPWEtvKZ+WzfiBdCfE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=h4LSoJdf8uxhcW1a0xfjQtw6vmxFJnvflJbqPPRCcqt3WXHvPv7hJzosjv9Vqhy6Y
	 VW9hNIJLWRWvHTPxW+k6Rv9d2v41Rc3R5QcIO+a0s14ZLky0/kxZRjSpCugdTY4cyh
	 q2jJJ4PYalzzY7sxV6H5LIBOc5yUiQkjaA/70CnwgJprGw/sTO2iTOzVdIN5KMiMEw
	 ZUVtUAlKZBy6OsJfe+w8MH81QYvTkd4hDKLoxXVNsCYQQZttazHkKwdmyfnHUyEUqa
	 EYtVBIvDjaTS7We5Dnn/2qxxSGzYHfAeVFzsz/dUbDDaH04HeWQFDlxjaBnAH61OPT
	 hpIbrXRsXq1Uw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K3SA7O01750988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 11:28:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 11:28:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Mar
 2025 11:28:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/12] wifi: rtw89: 8922a: support different SAR configs by antenna
Date: Thu, 20 Mar 2025 11:27:10 +0800
Message-ID: <20250320032712.20284-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320032712.20284-1-pkshih@realtek.com>
References: <20250320032712.20284-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Set SAR configs to the corresponding CRs (control registers) according to
RF path. Then, declare to support SAR by antenna in chip info.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  3 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 29 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c776954ad360..3c01b4994537 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -9360,6 +9360,9 @@
 #define R_TSSI_PWR_P0 0xE610
 #define R_TSSI_PWR_P1 0xE710
 #define B_TSSI_CONT_EN BIT(3)
+#define R_P0_TXPWRB_BE 0xE61C
+#define R_P1_TXPWRB_BE 0xE71C
+#define B_TXPWRB_MAX_BE GENMASK(20, 12)
 #define R_TSSI_MAP_OFST_P0 0xE620
 #define R_TSSI_MAP_OFST_P1 0xE720
 #define B_TSSI_MAP_OFST_OFDM GENMASK(17, 9)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 5b45c18fbbf6..cc595cae53f5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -12,6 +12,7 @@
 #include "reg.h"
 #include "rtw8922a.h"
 #include "rtw8922a_rfk.h"
+#include "sar.h"
 #include "util.h"
 
 #define RTW8922A_FW_FORMAT_MAX 3
@@ -2233,6 +2234,31 @@ static void rtw8922a_set_tx_shape(struct rtw89_dev *rtwdev,
 		rtw8922a_bb_tx_triangular(rtwdev, true, phy_idx);
 }
 
+static void rtw8922a_set_txpwr_sar_diff(struct rtw89_dev *rtwdev,
+					const struct rtw89_chan *chan,
+					enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_sar_parm sar_parm = {
+		.center_freq = chan->freq,
+		.force_path = true,
+	};
+	s16 sar_rf;
+	s8 sar_mac;
+
+	if (phy_idx != RTW89_PHY_0)
+		return;
+
+	sar_parm.path = RF_PATH_A;
+	sar_mac = rtw89_query_sar(rtwdev, &sar_parm);
+	sar_rf = rtw89_phy_txpwr_mac_to_rf(rtwdev, sar_mac);
+	rtw89_phy_write32_mask(rtwdev, R_P0_TXPWRB_BE, B_TXPWRB_MAX_BE, sar_rf);
+
+	sar_parm.path = RF_PATH_B;
+	sar_mac = rtw89_query_sar(rtwdev, &sar_parm);
+	sar_rf = rtw89_phy_txpwr_mac_to_rf(rtwdev, sar_mac);
+	rtw89_phy_write32_mask(rtwdev, R_P1_TXPWRB_BE, B_TXPWRB_MAX_BE, sar_rf);
+}
+
 static void rtw8922a_set_txpwr(struct rtw89_dev *rtwdev,
 			       const struct rtw89_chan *chan,
 			       enum rtw89_phy_idx phy_idx)
@@ -2244,6 +2270,7 @@ static void rtw8922a_set_txpwr(struct rtw89_dev *rtwdev,
 	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
 	rtw8922a_set_txpwr_diff(rtwdev, chan, phy_idx);
 	rtw8922a_set_txpwr_ref(rtwdev, phy_idx);
+	rtw8922a_set_txpwr_sar_diff(rtwdev, chan, phy_idx);
 }
 
 static void rtw8922a_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
@@ -2823,7 +2850,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.support_unii4		= true,
 	.support_ant_gain	= true,
 	.support_tas		= false,
-	.support_sar_by_ant	= false,
+	.support_sar_by_ant	= true,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= false,
-- 
2.25.1



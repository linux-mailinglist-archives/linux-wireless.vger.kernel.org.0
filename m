Return-Path: <linux-wireless+bounces-9632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1031A919DA1
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 04:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F3C3B2224F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 02:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1697134D1;
	Thu, 27 Jun 2024 02:59:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3F5DDA0
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457169; cv=none; b=GuqmrL5ee7cXUXm9ZvBzR+UlSa/9TWwH2rIYmdqHofRTqqIWcOwLgNogNnj2iPprVAa6pEoo+VmyLPnf4Qp4prafLCPU3Sh13olPeNQbZYVrnFqek9/U4ubiooRzF3Whx0s2phcKZCmFr2TEdNItHeBedcroKy0BAGzca79s4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457169; c=relaxed/simple;
	bh=CyUqNNvqYuyjXhdbECOZvUuoVLJAoSxPs3QC9e5xfls=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDsjpuul4Q30ILsBdcI0P9+yfgR4kIynXCcLjxEAlsiQMY51vlS8gUXtaf4oSo2tY2Zs3rZXEe3QAgS8B8Rf358hckvmOOGr3pS1iRkYg0EGJxYhrDO14ND+Hr7oiF3yr+VVYLrYnwvscQ5/kuSExbnTutxvGBbeRzrrm5X2jFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45R2xPqeD2591131, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45R2xPqeD2591131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 10:59:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 10:59:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Jun
 2024 10:59:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: 8852bt: rfk: add RX DCK
Date: Thu, 27 Jun 2024 10:58:47 +0800
Message-ID: <20240627025849.25198-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627025849.25198-1-pkshih@realtek.com>
References: <20240627025849.25198-1-pkshih@realtek.com>
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

RX DCK stands for receiver DC calibration. With this calibration, we have
proper DC offset to reflect correct received signal strength indicator.
Do this calibration when bringing up interface and going to connect.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 57 +++++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |  1 +
 2 files changed, 58 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 4a638e2444db..52dfbe0b3d6b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -13,6 +13,7 @@
 #include "rtw8852bt_rfk_table.h"
 #include "rtw8852b_common.h"
 
+#define RTW8852BT_RXDCK_VER 0x1
 #define RTW8852BT_IQK_VER 0x2a
 #define RTW8852BT_SS 2
 #define RTW8852BT_TSSI_PATH_NR 2
@@ -365,6 +366,47 @@ static void _rfk_bb_afe_restore(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_TXPW_RSTB, 0x2);
 }
 
+static void _set_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			enum rtw89_rf_path path)
+{
+	rtw89_write_rf(rtwdev, path, RR_DCK1, RR_DCK1_CLR, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x0);
+	rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_LV, 0x1);
+	mdelay(1);
+}
+
+static void _rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+{
+	u8 path, dck_tune;
+	u32 rf_reg5;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RX_DCK] ****** RXDCK Start (Ver: 0x%x, CV : 0x%x) ******\n",
+		    RTW8852BT_RXDCK_VER, rtwdev->hal.cv);
+
+	for (path = 0; path < RF_PATH_NUM_8852BT; path++) {
+		rf_reg5 = rtw89_read_rf(rtwdev, path, RR_RSV1, RFREG_MASK);
+		dck_tune = rtw89_read_rf(rtwdev, path, RR_DCK, RR_DCK_FINE);
+
+		if (rtwdev->is_tssi_mode[path])
+			rtw89_phy_write32_mask(rtwdev,
+					       R_P0_TSSI_TRK + (path << 13),
+					       B_P0_TSSI_TRK_EN, 0x1);
+
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_FINE, 0x0);
+		rtw89_write_rf(rtwdev, path, RR_MOD, RR_MOD_MASK, RR_MOD_V_RX);
+		_set_rx_dck(rtwdev, phy, path);
+		rtw89_write_rf(rtwdev, path, RR_DCK, RR_DCK_FINE, dck_tune);
+		rtw89_write_rf(rtwdev, path, RR_RSV1, RFREG_MASK, rf_reg5);
+
+		if (rtwdev->is_tssi_mode[path])
+			rtw89_phy_write32_mask(rtwdev,
+					       R_P0_TSSI_TRK + (path << 13),
+					       B_P0_TSSI_TRK_EN, 0x0);
+	}
+}
+
 static bool _iqk_check_cal(struct rtw89_dev *rtwdev, u8 path, u8 ktype)
 {
 	bool notready = false;
@@ -3286,6 +3328,21 @@ void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
 }
 
+void rtw8852bt_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u32 tx_en;
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
+
+	_rx_dck(rtwdev, phy_idx);
+
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
+}
+
 void rtw8852bt_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
index 22c0c9c3d173..3ac63a2a63f7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
@@ -8,6 +8,7 @@
 #include "core.h"
 
 void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8852bt_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev);
 void rtw8852bt_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
 void rtw8852bt_dpk_track(struct rtw89_dev *rtwdev);
-- 
2.25.1



Return-Path: <linux-wireless+bounces-2990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A104846664
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 04:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831FF28D7B0
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4B7FBFC;
	Fri,  2 Feb 2024 03:08:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF52FBF2
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843281; cv=none; b=H4s0q1A/jnrfhy8IXaD8tEx7u4VtJMPI5iubHx+e19JGrHt0yPdTyCqLhzJglH5GtJbJYjpc4E6rWBaudnoDrLEW1H5KQDKXEyKsPEBc6LWevIKrVPgtgIjOrbZPq0FXVLDYZVUd5wB1CMSveOFiUuK7EJT2xXAaeWd/BaF0eCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843281; c=relaxed/simple;
	bh=sA96mEpwJuvWihYmrieiQ5O7LZTO2QcIIkF+dnhCQDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0dGD+TKLMBOgI5X7eJjMpA2B3l8BilmbRHGR3G2pRY/nGvQrevA1P2b31Eb3oaeub44II9U8XZwIqtyy/z6TvPKWzKrVPSvuAvLcDUwX2yXizp64lkGgbgKeT3LCi2PbQlPwZR661tQ/an0LwI4/qZP2mAHpwnhUw3bLx803iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41237rSG21863156, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41237rSG21863156
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:07:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 2 Feb 2024 11:07:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Feb
 2024 11:07:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/11] wifi: rtw89: 8922a: rfk: implement chip_ops to call RF calibrations
Date: Fri, 2 Feb 2024 11:06:40 +0800
Message-ID: <20240202030642.108385-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202030642.108385-1-pkshih@realtek.com>
References: <20240202030642.108385-1-pkshih@realtek.com>
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

Calling RF calibrations when interface up, connection, switching bands and
going to scan.

For 8922AE, RF calibrations are moved to firmware, so use H2C commands to
trigger RF calibrations and wait for a C2H event to indicate completion.
Then, do next RF calibration.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.h     |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 115 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  25 +++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  69 +++++++++++
 4 files changed, 207 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 46e25c6f88a6..08121fd899e6 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -23,6 +23,7 @@ enum btc_wl_rfk_type {
 	BTC_WRFKT_DACK = 4,
 	BTC_WRFKT_RXDCK = 5,
 	BTC_WRFKT_TSSI = 6,
+	BTC_WRFKT_CHLK = 7,
 };
 
 #define NM_EXEC false
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 77b3b233697b..f02b365b0cec 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2834,6 +2834,7 @@ void (* const rtw89_phy_c2h_rfk_log_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK] = rtw89_phy_c2h_rfk_log_txgapk,
 };
 
+static
 void rtw89_phy_rfk_report_prep(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_rfk_wait_info *wait = &rtwdev->rfk_wait;
@@ -2843,6 +2844,7 @@ void rtw89_phy_rfk_report_prep(struct rtw89_dev *rtwdev)
 	reinit_completion(&wait->completion);
 }
 
+static
 int rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
 			      unsigned int ms)
 {
@@ -2959,6 +2961,119 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	handler(rtwdev, skb, len);
 }
 
+int rtw89_phy_rfk_pre_ntfy_and_wait(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy_idx,
+				    unsigned int ms)
+{
+	int ret;
+
+	rtw89_phy_rfk_report_prep(rtwdev);
+
+	ret = rtw89_fw_h2c_rf_pre_ntfy(rtwdev, phy_idx);
+	if (ret)
+		return ret;
+
+	return rtw89_phy_rfk_report_wait(rtwdev, "PRE_NTFY", ms);
+}
+EXPORT_SYMBOL(rtw89_phy_rfk_pre_ntfy_and_wait);
+
+int rtw89_phy_rfk_tssi_and_wait(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy_idx,
+				enum rtw89_tssi_mode tssi_mode,
+				unsigned int ms)
+{
+	int ret;
+
+	rtw89_phy_rfk_report_prep(rtwdev);
+
+	ret = rtw89_fw_h2c_rf_tssi(rtwdev, phy_idx, tssi_mode);
+	if (ret)
+		return ret;
+
+	return rtw89_phy_rfk_report_wait(rtwdev, "TSSI", ms);
+}
+EXPORT_SYMBOL(rtw89_phy_rfk_tssi_and_wait);
+
+int rtw89_phy_rfk_iqk_and_wait(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx,
+			       unsigned int ms)
+{
+	int ret;
+
+	rtw89_phy_rfk_report_prep(rtwdev);
+
+	ret = rtw89_fw_h2c_rf_iqk(rtwdev, phy_idx);
+	if (ret)
+		return ret;
+
+	return rtw89_phy_rfk_report_wait(rtwdev, "IQK", ms);
+}
+EXPORT_SYMBOL(rtw89_phy_rfk_iqk_and_wait);
+
+int rtw89_phy_rfk_dpk_and_wait(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx,
+			       unsigned int ms)
+{
+	int ret;
+
+	rtw89_phy_rfk_report_prep(rtwdev);
+
+	ret = rtw89_fw_h2c_rf_dpk(rtwdev, phy_idx);
+	if (ret)
+		return ret;
+
+	return rtw89_phy_rfk_report_wait(rtwdev, "DPK", ms);
+}
+EXPORT_SYMBOL(rtw89_phy_rfk_dpk_and_wait);
+
+int rtw89_phy_rfk_txgapk_and_wait(struct rtw89_dev *rtwdev,
+				  enum rtw89_phy_idx phy_idx,
+				  unsigned int ms)
+{
+	int ret;
+
+	rtw89_phy_rfk_report_prep(rtwdev);
+
+	ret = rtw89_fw_h2c_rf_txgapk(rtwdev, phy_idx);
+	if (ret)
+		return ret;
+
+	return rtw89_phy_rfk_report_wait(rtwdev, "TXGAPK", ms);
+}
+EXPORT_SYMBOL(rtw89_phy_rfk_txgapk_and_wait);
+
+int rtw89_phy_rfk_dack_and_wait(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy_idx,
+				unsigned int ms)
+{
+	int ret;
+
+	rtw89_phy_rfk_report_prep(rtwdev);
+
+	ret = rtw89_fw_h2c_rf_dack(rtwdev, phy_idx);
+	if (ret)
+		return ret;
+
+	return rtw89_phy_rfk_report_wait(rtwdev, "DACK", ms);
+}
+EXPORT_SYMBOL(rtw89_phy_rfk_dack_and_wait);
+
+int rtw89_phy_rfk_rxdck_and_wait(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy_idx,
+				 unsigned int ms)
+{
+	int ret;
+
+	rtw89_phy_rfk_report_prep(rtwdev);
+
+	ret = rtw89_fw_h2c_rf_rxdck(rtwdev, phy_idx);
+	if (ret)
+		return ret;
+
+	return rtw89_phy_rfk_report_wait(rtwdev, "RX_DCK", ms);
+}
+EXPORT_SYMBOL(rtw89_phy_rfk_rxdck_and_wait);
+
 static u32 phy_tssi_get_cck_group(u8 ch)
 {
 	switch (ch) {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 459e919ddd24..d80ddc723e86 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -885,9 +885,28 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 bool rtw89_phy_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func);
 void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func);
-void rtw89_phy_rfk_report_prep(struct rtw89_dev *rtwdev);
-int rtw89_phy_rfk_report_wait(struct rtw89_dev *rtwdev, const char *rfk_name,
-			      unsigned int ms);
+int rtw89_phy_rfk_pre_ntfy_and_wait(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy_idx,
+				    unsigned int ms);
+int rtw89_phy_rfk_tssi_and_wait(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy_idx,
+				enum rtw89_tssi_mode tssi_mode,
+				unsigned int ms);
+int rtw89_phy_rfk_iqk_and_wait(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx,
+			       unsigned int ms);
+int rtw89_phy_rfk_dpk_and_wait(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx,
+			       unsigned int ms);
+int rtw89_phy_rfk_txgapk_and_wait(struct rtw89_dev *rtwdev,
+				  enum rtw89_phy_idx phy_idx,
+				  unsigned int ms);
+int rtw89_phy_rfk_dack_and_wait(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy_idx,
+				unsigned int ms);
+int rtw89_phy_rfk_rxdck_and_wait(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy_idx,
+				 unsigned int ms);
 void rtw89_phy_rfk_tssi_fill_fwcmd_efuse_to_de(struct rtw89_dev *rtwdev,
 					       enum rtw89_phy_idx phy,
 					       const struct rtw89_chan *chan,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index aefad3f2e612..69ae8f81181e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2023  Realtek Corporation
  */
 
+#include "coex.h"
 #include "debug.h"
 #include "efuse.h"
 #include "fw.h"
@@ -1369,6 +1370,69 @@ void rtw8922a_hal_reset(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw8922a_rfk_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+
+	rtwdev->is_tssi_mode[RF_PATH_A] = false;
+	rtwdev->is_tssi_mode[RF_PATH_B] = false;
+	memset(rfk_mcc, 0, sizeof(*rfk_mcc));
+}
+
+static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
+{
+	u32 rf_mode;
+	u8 path;
+	int ret;
+
+	for (path = 0; path < RF_PATH_NUM_8922A; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		ret = read_poll_timeout_atomic(rtw89_read_rf, rf_mode, rf_mode != 2,
+					       2, 5000, false, rtwdev, path, 0x00,
+					       RR_MOD_MASK);
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK] Wait S%d to Rx mode!! (ret = %d)\n",
+			    path, ret);
+	}
+}
+
+static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+	u32 tx_en;
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_CHLK, BTC_WRFK_START);
+	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
+	_wait_rx_mode(rtwdev, RF_AB);
+
+	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, phy_idx, 5);
+	rtw89_phy_rfk_txgapk_and_wait(rtwdev, phy_idx, 54);
+	rtw89_phy_rfk_iqk_and_wait(rtwdev, phy_idx, 84);
+	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, RTW89_TSSI_NORMAL, 6);
+	rtw89_phy_rfk_dpk_and_wait(rtwdev, phy_idx, 34);
+	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, 32);
+
+	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_CHLK, BTC_WRFK_STOP);
+}
+
+static void rtw8922a_rfk_band_changed(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_rfk_tssi_and_wait(rtwdev, phy_idx, RTW89_TSSI_SCAN, 6);
+}
+
+static void rtw8922a_rfk_scan(struct rtw89_dev *rtwdev, bool start)
+{
+}
+
+static void rtw8922a_rfk_track(struct rtw89_dev *rtwdev)
+{
+}
+
 static void rtw8922a_set_txpwr_ref(struct rtw89_dev *rtwdev,
 				   enum rtw89_phy_idx phy_idx)
 {
@@ -1622,6 +1686,11 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.read_phycap		= rtw8922a_read_phycap,
 	.fem_setup		= NULL,
 	.rfe_gpio		= NULL,
+	.rfk_init		= rtw8922a_rfk_init,
+	.rfk_channel		= rtw8922a_rfk_channel,
+	.rfk_band_changed	= rtw8922a_rfk_band_changed,
+	.rfk_scan		= rtw8922a_rfk_scan,
+	.rfk_track		= rtw8922a_rfk_track,
 	.power_trim		= rtw8922a_power_trim,
 	.set_txpwr		= rtw8922a_set_txpwr,
 	.set_txpwr_ctrl		= rtw8922a_set_txpwr_ctrl,
-- 
2.25.1



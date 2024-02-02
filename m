Return-Path: <linux-wireless+bounces-2991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6B3846665
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 04:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA38B269B1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 03:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC9101C8;
	Fri,  2 Feb 2024 03:08:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E7101C6
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843285; cv=none; b=trCaZWoXNPYKZkUYFnantStD2nHCQWAH85yMHeOesvqDWBI4rVTH4+IAUB3C+TjbwuEjH/LypJ31aquHBBe+wDQfbGJQ0P856BdJIK4dA3vlhbbzA8CA18LdgXXsmG/QgZHvM3afvNzCSDl2aG2CXL7KqrbN0J1Daaq7qicnl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843285; c=relaxed/simple;
	bh=gTSL2k3gZY4IwJTu2sLtVPfafMztTUskULbEG6R0BEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbM44o9CzwJGs49kl8v9zfP43cy9sXDFsYl2CYC05m3AoPHdPtHWUZwwqG5quScOg2oLiM1mT0wWGyFvPkanI6q8lSR4sqrtGPmoUFWnbliftWlXx8DNdEj5Y77enJKHMC1HR6VjrSijILecpCozy7HHN0iK0D4/ba2AtKGjj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41237wdyE1863172, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41237wdyE1863172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:07:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 2 Feb 2024 11:07:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 2 Feb
 2024 11:07:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/11] wifi: rtw89: 8922a: add chip_ops::rfk_init_late to do initial RF calibrations later
Date: Fri, 2 Feb 2024 11:06:41 +0800
Message-ID: <20240202030642.108385-11-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The RF calibrations are moved into firmware, so we trigger calibrations by
H2C commands and wait for C2H completion events. However, these events
can be received only after HCI (i.e. PCI for now) starts, so we should
do initial RF calibrations after that.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 1 +
 drivers/net/wireless/realtek/rtw89/core.h     | 9 +++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 9 +++++++++
 7 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c6c3e0c0bf84..61a216464b6d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4101,6 +4101,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 
 	set_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
 
+	rtw89_chip_rfk_init_late(rtwdev);
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_ON);
 	rtw89_fw_h2c_fw_log(rtwdev, rtwdev->fw.log.enable);
 	rtw89_fw_h2c_init_ba_cam(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ccc9f96fc18b..270403f6c3d5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3157,6 +3157,7 @@ struct rtw89_chip_ops {
 	void (*fem_setup)(struct rtw89_dev *rtwdev);
 	void (*rfe_gpio)(struct rtw89_dev *rtwdev);
 	void (*rfk_init)(struct rtw89_dev *rtwdev);
+	void (*rfk_init_late)(struct rtw89_dev *rtwdev);
 	void (*rfk_channel)(struct rtw89_dev *rtwdev);
 	void (*rfk_band_changed)(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx);
@@ -5642,6 +5643,14 @@ static inline void rtw89_chip_rfk_init(struct rtw89_dev *rtwdev)
 		chip->ops->rfk_init(rtwdev);
 }
 
+static inline void rtw89_chip_rfk_init_late(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->rfk_init_late)
+		chip->ops->rfk_init_late(rtwdev);
+}
+
 static inline void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 09b23c56aa8e..09e38713bca7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2311,6 +2311,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.fem_setup		= NULL,
 	.rfe_gpio		= rtw8851b_rfe_gpio,
 	.rfk_init		= rtw8851b_rfk_init,
+	.rfk_init_late		= NULL,
 	.rfk_channel		= rtw8851b_rfk_channel,
 	.rfk_band_changed	= rtw8851b_rfk_band_changed,
 	.rfk_scan		= rtw8851b_rfk_scan,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index c28f05bbdccf..01c249dddfb8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2055,6 +2055,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.fem_setup		= rtw8852a_fem_setup,
 	.rfe_gpio		= NULL,
 	.rfk_init		= rtw8852a_rfk_init,
+	.rfk_init_late		= NULL,
 	.rfk_channel		= rtw8852a_rfk_channel,
 	.rfk_band_changed	= rtw8852a_rfk_band_changed,
 	.rfk_scan		= rtw8852a_rfk_scan,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 18ed372ed5cd..fb6ad335a37a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2480,6 +2480,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.fem_setup		= NULL,
 	.rfe_gpio		= NULL,
 	.rfk_init		= rtw8852b_rfk_init,
+	.rfk_init_late		= NULL,
 	.rfk_channel		= rtw8852b_rfk_channel,
 	.rfk_band_changed	= rtw8852b_rfk_band_changed,
 	.rfk_scan		= rtw8852b_rfk_scan,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 431acfaba89b..00861c328ca0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2825,6 +2825,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.fem_setup		= NULL,
 	.rfe_gpio		= NULL,
 	.rfk_init		= rtw8852c_rfk_init,
+	.rfk_init_late		= NULL,
 	.rfk_channel		= rtw8852c_rfk_channel,
 	.rfk_band_changed	= rtw8852c_rfk_band_changed,
 	.rfk_scan		= rtw8852c_rfk_scan,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 69ae8f81181e..0cbe4780eb69 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1379,6 +1379,14 @@ static void rtw8922a_rfk_init(struct rtw89_dev *rtwdev)
 	memset(rfk_mcc, 0, sizeof(*rfk_mcc));
 }
 
+static void rtw8922a_rfk_init_late(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, RTW89_PHY_0, 5);
+
+	rtw89_phy_rfk_dack_and_wait(rtwdev, RTW89_PHY_0, 58);
+	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, 32);
+}
+
 static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 {
 	u32 rf_mode;
@@ -1687,6 +1695,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.fem_setup		= NULL,
 	.rfe_gpio		= NULL,
 	.rfk_init		= rtw8922a_rfk_init,
+	.rfk_init_late		= rtw8922a_rfk_init_late,
 	.rfk_channel		= rtw8922a_rfk_channel,
 	.rfk_band_changed	= rtw8922a_rfk_band_changed,
 	.rfk_scan		= rtw8922a_rfk_scan,
-- 
2.25.1



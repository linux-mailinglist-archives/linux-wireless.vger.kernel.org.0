Return-Path: <linux-wireless+bounces-5708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E70893875
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D786C1C209D4
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B118137E;
	Mon,  1 Apr 2024 06:39:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A207F1113
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711953578; cv=none; b=l1YL22twYDFMDFWwY7/bMbk6/CPNObfpVqpRjyfzJQJ7Ffnb++llpHOE261rZMW2/70Y2eoUVpIif4c1+YaLogOIvcGONJbWVWB00TrDtb07nMzXXqO5YDMgxxyM9DAs12yy+U8Z6XKHMe0cLP70oggEBvCKj7JLxm+h0lVQPes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711953578; c=relaxed/simple;
	bh=Y5FRZmHMrQm4J6Q0HQqXg0jRoqyeRHzk+H8PGTeQ3SE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OCb8vtMIUaea9HriFNZllCvzBECZrtxF/sLhKJ7Xo3hpGIaQ9Pj/qWbjQoC7HVmXcToQP1+QCj0WyFzuOLlTNjJ3mQvTjGEschfs1GYF4QO3T1oZKcGoNcCi3u9r/7rnxaaQ+Q7yCqP4vdc4MTHghXNwt53/QeqkaerW2hRg6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4316dW9112557814, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4316dW9112557814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 1 Apr 2024 14:39:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 14:39:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 14:39:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH] wifi: rtw89: 8922a: configure UL MU/OFDMA power setting
Date: Mon, 1 Apr 2024 14:38:18 +0800
Message-ID: <20240401063818.12880-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

8922A needs to set UL MU/OFDMA power and fine tune power
error tolerance for proper response to AP's trigger frame.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy_be.c | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index be0148f2b96f..72eda9bbd3ae 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -381,6 +381,23 @@ static void rtw89_phy_bb_wrap_ftm_init(struct rtw89_dev *rtwdev,
 	rtw89_write32_mask(rtwdev, addr, 0x7, 0);
 }
 
+static void rtw89_phy_bb_wrap_ul_pwr(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u8 mac_idx;
+	u32 addr;
+
+	if (chip_id != RTL8922A)
+		return;
+
+	for (mac_idx = 0; mac_idx < RTW89_MAC_NUM; mac_idx++) {
+		addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_RSSI_TARGET_LMT, mac_idx);
+		rtw89_write32(rtwdev, addr, 0x0201FE00);
+		addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_TH, mac_idx);
+		rtw89_write32(rtwdev, addr, 0x00FFEC7E);
+	}
+}
+
 static void rtw89_phy_bb_wrap_init_be(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_mac_idx mac_idx = RTW89_MAC_0;
@@ -391,6 +408,7 @@ static void rtw89_phy_bb_wrap_init_be(struct rtw89_dev *rtwdev)
 	rtw89_phy_bb_wrap_force_cr_init(rtwdev, mac_idx);
 	rtw89_phy_bb_wrap_ftm_init(rtwdev, mac_idx);
 	rtw89_phy_bb_wrap_tpu_set_all(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_ul_pwr(rtwdev);
 }
 
 static void rtw89_phy_ch_info_init_be(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ccf74d9f9224..0c0d3c84b178 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7496,6 +7496,9 @@
 #define B_BE_PWR_BT_VAL GENMASK(8, 0)
 #define B_BE_PWR_FORCE_COEX_ON GENMASK(29, 27)
 
+#define R_BE_PWR_TH 0x11A78
+#define R_BE_PWR_RSSI_TARGET_LMT 0x11A84
+
 #define R_BE_PWR_OFST_SW 0x11AE8
 #define B_BE_PWR_OFST_SW_DB GENMASK(27, 24)
 
-- 
2.25.1



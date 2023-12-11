Return-Path: <linux-wireless+bounces-638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875D80C359
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 09:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6F7B20BA1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF00F2110D;
	Mon, 11 Dec 2023 08:35:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0A3ED
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 00:35:06 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB8Z1W802598543, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB8Z1W802598543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 16:35:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 11 Dec 2023 16:35:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Dec
 2023 16:35:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: only reset BB/RF for existing WiFi 6 chips while starting up
Date: Mon, 11 Dec 2023 16:33:41 +0800
Message-ID: <20231211083341.118047-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211083341.118047-1-pkshih@realtek.com>
References: <20231211083341.118047-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

The new WiFi 7 chips change the design, so no need to disable/enable
BB/RF when core_start(). Keep the same logic for existing chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  5 +----
 drivers/net/wireless/realtek/rtw89/mac.h  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d5ee2aa053d4..fd527a249996 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3956,10 +3956,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 	/* efuse process */
 
 	/* pre-config BB/RF, BB reset/RFC reset */
-	ret = rtw89_chip_disable_bb_rf(rtwdev);
-	if (ret)
-		return ret;
-	ret = rtw89_chip_enable_bb_rf(rtwdev);
+	ret = rtw89_chip_reset_bb_rf(rtwdev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 56cd81347784..ed98b49809a4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1108,6 +1108,23 @@ static inline int rtw89_chip_disable_bb_rf(struct rtw89_dev *rtwdev)
 	return chip->ops->disable_bb_rf(rtwdev);
 }
 
+static inline int rtw89_chip_reset_bb_rf(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	if (rtwdev->chip->chip_gen != RTW89_CHIP_AX)
+		return 0;
+
+	ret = rtw89_chip_disable_bb_rf(rtwdev);
+	if (ret)
+		return ret;
+	ret = rtw89_chip_enable_bb_rf(rtwdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev);
 int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err);
 bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func);
-- 
2.25.1



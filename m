Return-Path: <linux-wireless+bounces-3323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848EB84D7D2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 03:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4512871AB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 02:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57E923759;
	Thu,  8 Feb 2024 02:30:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507D225D4
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359444; cv=none; b=BpElBsNxpb8YnwvaK3FuMtDMznHdDCakJ6jukGmwR1NVBezpZNVn5e0Bp5bqyRwe3Pnnl5qhyHROTmALeGwkgpcDF7yUKUvr4LmDC1m6pqw8G6m4mcZMfbRX09JBJ+TeDcYrNrLm7RNqly0MKaXINOx1B7OJFThX/SkPIkMx2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359444; c=relaxed/simple;
	bh=O+lJDbTYGUhs81PtQRpku9zpreJ8PguTwvR27vnezxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWtzLwp7rIlMQMtDET8WNzCaMbi17sL0DRy8Y9lHt8xzAhYjkLLQDyCSc5V/qr9EghjgD5h1TzSWoR7AcoIOZ8jZ+vomfAXG1gzA4Wf2reTHkGZBASdiDCr9eaQkopVKJoiyX6cnYmR72PmzvBL7i00T9gE5vZbOQXSg+7HMJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4182Ub4rA192124, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4182Ub4rA192124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 10:30:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 8 Feb 2024 10:30:38 +0800
Received: from [127.0.1.1] (172.16.17.45) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 8 Feb
 2024 10:30:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 11/11] wifi: rtw89: change qutoa to DBCC by default for WiFi 7 chips
Date: Thu, 8 Feb 2024 10:28:57 +0800
Message-ID: <20240208022857.14379-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208022857.14379-1-pkshih@realtek.com>
References: <20240208022857.14379-1-pkshih@realtek.com>
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

Since WiFi 7 is expected to support MLO, so we should enable MAC-0/1 and
PHY-0/1. By default, set dbcc_en=true, change quota to DBCC mode, and set
MLO mode to 2 + 0 that means we only use 2x2 connection on MAC/PHY-0
for now.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 8 +++++++-
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 8 ++++----
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 7 +++++++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 61a216464b6d..069b65c01719 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4061,7 +4061,6 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 {
 	int ret;
 
-	rtwdev->mac.qta_mode = RTW89_QTA_SCC;
 	ret = rtw89_mac_init(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "mac init fail, ret:%d\n", ret);
@@ -4199,6 +4198,13 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	rtwdev->hal.rx_fltr = DEFAULT_AX_RX_FLTR;
 	rtwdev->dbcc_en = false;
 	rtwdev->mlo_dbcc_mode = MLO_DBCC_NOT_SUPPORT;
+	rtwdev->mac.qta_mode = RTW89_QTA_SCC;
+
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
+		rtwdev->dbcc_en = true;
+		rtwdev->mac.qta_mode = RTW89_QTA_DBCC;
+		rtwdev->mlo_dbcc_mode = MLO_2_PLUS_0_1RF;
+	}
 
 	INIT_WORK(&btc->eapol_notify_work, rtw89_btc_ntfy_eapol_packet_work);
 	INIT_WORK(&btc->arp_notify_work, rtw89_btc_ntfy_arp_packet_work);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4411a7d117cf..1c6f0b46c11c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3305,6 +3305,7 @@ struct rtw89_scan_option {
 
 enum rtw89_qta_mode {
 	RTW89_QTA_SCC,
+	RTW89_QTA_DBCC,
 	RTW89_QTA_DLFW,
 	RTW89_QTA_WOW,
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 917bbc482560..9b78879bf34b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1625,7 +1625,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size19 = {RTW89_WDE_PG_64, 3328, 0,},
 	/* PCIE */
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
-	.ple_size0_v1 = {RTW89_PLE_PG_128, 2672, 256, 212992,},
+	.ple_size0_v1 = {RTW89_PLE_PG_128, 2688, 240, 212992,},
 	.ple_size3_v1 = {RTW89_PLE_PG_128, 2928, 0, 212992,},
 	/* DLFW */
 	.ple_size4 = {RTW89_PLE_PG_128, 64, 1472,},
@@ -1650,8 +1650,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt17 = {0, 0, 0,  0,},
 	/* 8852C PCIE SCC */
 	.wde_qt18 = {3228, 60, 0, 40,},
-	.ple_qt0 = {320, 0, 32, 16, 13, 13, 292, 0, 32, 18, 1, 4, 0,},
-	.ple_qt1 = {320, 0, 32, 16, 1944, 1944, 2223, 0, 1963, 1949, 1, 1935, 0,},
+	.ple_qt0 = {320, 320, 32, 16, 13, 13, 292, 292, 64, 18, 1, 4, 0,},
+	.ple_qt1 = {320, 320, 32, 16, 1316, 1316, 1595, 1595, 1367, 1321, 1, 1307, 0,},
 	/* PCIE SCC */
 	.ple_qt4 = {264, 0, 16, 20, 26, 13, 356, 0, 32, 40, 8,},
 	/* PCIE SCC */
@@ -1677,7 +1677,7 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt_52b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
 	/* 8851B PCIE WOW */
 	.ple_qt_51b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
-	.ple_rsvd_qt0 = {2, 112, 56, 6, 6, 6, 6, 0, 0, 62,},
+	.ple_rsvd_qt0 = {2, 107, 107, 6, 6, 6, 6, 0, 0, 0,},
 	.ple_rsvd_qt1 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
 	.rsvd0_size0 = {212992, 0,},
 	.rsvd1_size0 = {587776, 2048,},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index f7b81daa0b03..a4b7d2e79638 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -47,6 +47,8 @@ static const struct rtw89_hfc_pub_cfg rtw8922a_hfc_pubcfg_pcie = {
 static const struct rtw89_hfc_param_ini rtw8922a_hfc_param_ini_pcie[] = {
 	[RTW89_QTA_SCC] = {rtw8922a_hfc_chcfg_pcie, &rtw8922a_hfc_pubcfg_pcie,
 			   &rtw89_mac_size.hfc_prec_cfg_c0, RTW89_HCIFC_POH},
+	[RTW89_QTA_DBCC] = {rtw8922a_hfc_chcfg_pcie, &rtw8922a_hfc_pubcfg_pcie,
+			   &rtw89_mac_size.hfc_prec_cfg_c0, RTW89_HCIFC_POH},
 	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw89_mac_size.hfc_prec_cfg_c2,
 			    RTW89_HCIFC_POH},
 	[RTW89_QTA_INVALID] = {NULL},
@@ -58,6 +60,11 @@ static const struct rtw89_dle_mem rtw8922a_dle_mem_pcie[] = {
 			   &rtw89_mac_size.wde_qt0_v1, &rtw89_mac_size.ple_qt0,
 			   &rtw89_mac_size.ple_qt1, &rtw89_mac_size.ple_rsvd_qt0,
 			   &rtw89_mac_size.rsvd0_size0, &rtw89_mac_size.rsvd1_size0},
+	[RTW89_QTA_DBCC] = {RTW89_QTA_DBCC, &rtw89_mac_size.wde_size0_v1,
+			   &rtw89_mac_size.ple_size0_v1, &rtw89_mac_size.wde_qt0_v1,
+			   &rtw89_mac_size.wde_qt0_v1, &rtw89_mac_size.ple_qt0,
+			   &rtw89_mac_size.ple_qt1, &rtw89_mac_size.ple_rsvd_qt0,
+			   &rtw89_mac_size.rsvd0_size0, &rtw89_mac_size.rsvd1_size0},
 	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size4_v1,
 			    &rtw89_mac_size.ple_size3_v1, &rtw89_mac_size.wde_qt4,
 			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt9,
-- 
2.25.1



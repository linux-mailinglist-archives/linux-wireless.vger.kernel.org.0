Return-Path: <linux-wireless+bounces-6726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F298AE754
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311B81F24393
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67585938;
	Tue, 23 Apr 2024 13:05:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E678C6E
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877542; cv=none; b=iYv0CKk1EvdFq1iQBTbJ5Qw1VH3j/wybhsCpif533voKj/A0gBEcrv8bGXLR3thbKKtn7XJjnJ0glGGmsKOQuB1MZrqAKUgUBcRrnR6yWOovgIUIXoU5+8Qoj48J0LJizt6UiE3ZHXR0BDf1XoPHmYWjX4/pMeJwpISJvsLeo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877542; c=relaxed/simple;
	bh=Yzh3FCvRWfFPd6aRXzByFdAoJUVGneF3HRaK5KtOnOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnTif2WiTIP6iZI33UzSK7IsvkZq+Oj2o4VE1GVD6a7hNa9RVAJMjgo0fHXy5mVDEVxGdxos8nAPu6fV932Sl+7E5plC7qKqA6mtG65n+O1SAdth6CALLz7fEBNq7s12Z8x8nQgmYMygZcug9zc7Kk1SknKDMjYUShY3fpKNNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43ND5bLD21251180, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43ND5bLD21251180
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 21:05:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:05:38 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 21:05:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 3/8] wifi: rtw89: coex: Add Bluetooth frequency hopping map version 7
Date: Tue, 23 Apr 2024 21:04:57 +0800
Message-ID: <20240423130502.32682-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423130502.32682-1-pkshih@realtek.com>
References: <20240423130502.32682-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

The report is reported from Bluetooth, it described the usable
Bluetooth channel map. Bluetooth should not hopped into Wi-Fi
using channel. Version 8 report adjust the structure variables
order.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index b0921a264f3d..f4ac9354f7ab 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1138,6 +1138,7 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 	struct rtw89_btc_fbtc_btscan_v7 *pscan_v7;
 	struct rtw89_btc_fbtc_btafh *pafh_v1 = NULL;
 	struct rtw89_btc_fbtc_btafh_v2 *pafh_v2 = NULL;
+	struct rtw89_btc_fbtc_btafh_v7 *pafh_v7 = NULL;
 	struct rtw89_btc_fbtc_btdevinfo *pdev = NULL;
 	bool scan_update = true;
 	int i;
@@ -1198,6 +1199,17 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 				memcpy(&bt_linfo->afh_map_le[0], pafh_v2->afh_le_a, 4);
 				memcpy(&bt_linfo->afh_map_le[4], pafh_v2->afh_le_b, 1);
 			}
+		} else if (ver->fcxbtafh == 7) {
+			pafh_v7 = (struct rtw89_btc_fbtc_btafh_v7 *)pfinfo;
+			if (pafh_v7->map_type & RPT_BT_AFH_SEQ_LEGACY) {
+				memcpy(&bt_linfo->afh_map[0], pafh_v7->afh_l, 4);
+				memcpy(&bt_linfo->afh_map[4], pafh_v7->afh_m, 4);
+				memcpy(&bt_linfo->afh_map[8], pafh_v7->afh_h, 2);
+			}
+			if (pafh_v7->map_type & RPT_BT_AFH_SEQ_LE) {
+				memcpy(&bt_linfo->afh_map_le[0], pafh_v7->afh_le_a, 4);
+				memcpy(&bt_linfo->afh_map_le[4], pafh_v7->afh_le_b, 1);
+			}
 		} else if (ver->fcxbtafh == 1) {
 			pafh_v1 = (struct rtw89_btc_fbtc_btafh *)pfinfo;
 			memcpy(&bt_linfo->afh_map[0], pafh_v1->afh_l, 4);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0b1d63b2fa1f..78600e7fbad4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2735,6 +2735,18 @@ struct rtw89_btc_fbtc_btafh_v2 {
 	u8 afh_le_b[4];
 } __packed;
 
+struct rtw89_btc_fbtc_btafh_v7 {
+	u8 fver;
+	u8 map_type;
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 afh_l[4]; /*bit0:2402, bit1:2403.... bit31:2433 */
+	u8 afh_m[4]; /*bit0:2434, bit1:2435.... bit31:2465 */
+	u8 afh_h[4]; /*bit0:2466, bit1:2467.....bit14:2480 */
+	u8 afh_le_a[4];
+	u8 afh_le_b[4];
+} __packed;
+
 struct rtw89_btc_fbtc_btdevinfo {
 	u8 fver; /* btc_ver::fcxbtdevinfo */
 	u8 rsvd;
-- 
2.25.1



Return-Path: <linux-wireless+bounces-4237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D9886C2D0
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71401B25CB9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 07:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1BA4878F;
	Thu, 29 Feb 2024 07:46:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2B482DF
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192811; cv=none; b=tNNLUQy45CSY1LBQi3RelpohlJDemnvWw/YNyNdliDy4RE51jt6z6eCjp1a4+SFR9YK2AGIHFg9b+uY9d8v8LVzZZt+NFgKYTlNtetOHC2/R06T0oFFSyTBUMG2YG8nIDFCYaoSKkhlVOBrX3pQLLegBUYwFqkyiLHOjSDu6q4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192811; c=relaxed/simple;
	bh=llJc35s2V+o3C1xGoGx0i/o++JmCiWwZ2vabl3CV7cc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hngpSjuBL/6Hcnog0sJ9WGcUE78A2KMXUwpjRoU7XG8TTXU7rBYEy6LZOcjcF9Fb8/CCViHHg98yOfjkqKEUtl1bxPWE+CG9/6qDEZwhe2C3XtiCtj5kBAU1mV0Q52nZCLn7BtIqyrwi23OExBxnHKdvyOE+hL7G/2blx3U7tds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T7khhH71229924, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T7khhH71229924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 15:46:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 29 Feb 2024 15:46:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 15:46:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/8] wifi: rtw89: coex: Add coexistence policy to decrease WiFi packet CRC-ERR
Date: Thu, 29 Feb 2024 15:45:14 +0800
Message-ID: <20240229074514.219276-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229074514.219276-1-pkshih@realtek.com>
References: <20240229074514.219276-1-pkshih@realtek.com>
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

The 2 Bluetooth profiles (Hands free profile & Human interface device)
have high duty transmission, it will affect the traffic of WiFi packet
frequently. And once the WiFi traffic down to B/G mode, it will need
a better success rate to recover the transmission rate. Add new policy
option to solve the above situation.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 44 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 6a1f9a555ce7..d9b66d43f32e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -358,17 +358,26 @@ enum btc_cx_poicy_type {
 	/* TDMA off + pri: WL_Rx = BT, BT_HI > WL_Tx > BT_Lo */
 	BTC_CXP_OFF_EQ3 = (BTC_CXP_OFF << 8) | 5,
 
+	/* TDMA off + pri: WL_Rx = BT, BT_HI > WL_Tx > BT_Lo */
+	BTC_CXP_OFF_EQ4 = (BTC_CXP_OFF << 8) | 6,
+
+	/* TDMA off + pri: WL_Rx = BT, BT_HI > WL_Tx > BT_Lo */
+	BTC_CXP_OFF_EQ5 = (BTC_CXP_OFF << 8) | 7,
+
 	/* TDMA off + pri: BT_Hi > WL > BT_Lo */
-	BTC_CXP_OFF_BWB0 = (BTC_CXP_OFF << 8) | 6,
+	BTC_CXP_OFF_BWB0 = (BTC_CXP_OFF << 8) | 8,
 
 	/* TDMA off + pri: WL_Hi-Tx > BT_Hi_Rx, BT_Hi > WL > BT_Lo */
-	BTC_CXP_OFF_BWB1 = (BTC_CXP_OFF << 8) | 7,
+	BTC_CXP_OFF_BWB1 = (BTC_CXP_OFF << 8) | 9,
 
 	/* TDMA off + pri: WL_Hi-Tx > BT, BT_Hi > other-WL > BT_Lo */
-	BTC_CXP_OFF_BWB2 = (BTC_CXP_OFF << 8) | 8,
+	BTC_CXP_OFF_BWB2 = (BTC_CXP_OFF << 8) | 10,
 
 	/* TDMA off + pri: WL_Hi-Tx = BT */
-	BTC_CXP_OFF_BWB3 = (BTC_CXP_OFF << 8) | 9,
+	BTC_CXP_OFF_BWB3 = (BTC_CXP_OFF << 8) | 11,
+
+	/* TDMA off + pri: WL > BT, Block-BT*/
+	BTC_CXP_OFF_WL2 = (BTC_CXP_OFF << 8) | 12,
 
 	/* TDMA off+Bcn-Protect + pri: WL_Hi-Tx > BT_Hi_Rx, BT_Hi > WL > BT_Lo*/
 	BTC_CXP_OFFB_BWB0 = (BTC_CXP_OFFB << 8) | 0,
@@ -3086,6 +3095,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo = &btc->cx.wl.role_info_v1;
 	struct rtw89_btc_bt_hid_desc *hid = &btc->cx.bt.link_info.hid_desc;
 	struct rtw89_btc_bt_hfp_desc *hfp = &btc->cx.bt.link_info.hfp_desc;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	u8 type, null_role;
 	u32 tbl_w1, tbl_b1, tbl_b4;
 
@@ -3111,9 +3121,16 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 			tbl_b4 = cxtbl[2];
 		}
 	} else {
-		tbl_w1 = cxtbl[16];
 		tbl_b1 = cxtbl[17];
 		tbl_b4 = cxtbl[17];
+
+		if (wl->bg_mode)
+			tbl_w1 = cxtbl[8];
+		else if ((wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) &&
+			 hid->exist)
+			tbl_w1 = cxtbl[19];
+		else
+			tbl_w1 = cxtbl[16];
 	}
 
 	btc->bt_req_en = false;
@@ -3727,7 +3744,12 @@ static void _action_bt_hfp(struct rtw89_dev *rtwdev)
 			_set_policy(rtwdev, BTC_CXP_OFF_BWB1, BTC_ACT_BT_HFP);
 		}
 	} else {
-		_set_policy(rtwdev, BTC_CXP_OFF_EQ2, BTC_ACT_BT_HFP);
+		if (wl->bg_mode)
+			_set_policy(rtwdev, BTC_CXP_OFF_BWB1, BTC_ACT_BT_HFP);
+		else if (wl->status.map.traffic_dir & BIT(RTW89_TFC_UL))
+			_set_policy(rtwdev, BTC_CXP_OFF_EQ5, BTC_ACT_BT_HFP);
+		else
+			_set_policy(rtwdev, BTC_CXP_OFF_EQ2, BTC_ACT_BT_HFP);
 	}
 }
 
@@ -3760,7 +3782,12 @@ static void _action_bt_hid(struct rtw89_dev *rtwdev)
 			policy_type = BTC_CXP_OFF_BWB1;
 		}
 	} else { /* dedicated-antenna */
-		policy_type = BTC_CXP_OFF_EQ3;
+		if (wl->bg_mode)
+			policy_type = BTC_CXP_OFF_BWB1;
+		else if (wl->status.map.traffic_dir & BIT(RTW89_TFC_UL))
+			policy_type = BTC_CXP_OFF_EQ4;
+		else
+			policy_type = BTC_CXP_OFF_EQ3;
 	}
 
 	_set_policy(rtwdev, policy_type, BTC_ACT_BT_HID);
@@ -7049,10 +7076,13 @@ static const char *steps_to_str(u16 step)
 	CASE_BTC_POLICY_STR(OFF_EQ1);
 	CASE_BTC_POLICY_STR(OFF_EQ2);
 	CASE_BTC_POLICY_STR(OFF_EQ3);
+	CASE_BTC_POLICY_STR(OFF_EQ4);
+	CASE_BTC_POLICY_STR(OFF_EQ5);
 	CASE_BTC_POLICY_STR(OFF_BWB0);
 	CASE_BTC_POLICY_STR(OFF_BWB1);
 	CASE_BTC_POLICY_STR(OFF_BWB2);
 	CASE_BTC_POLICY_STR(OFF_BWB3);
+	CASE_BTC_POLICY_STR(OFF_WL2);
 	CASE_BTC_POLICY_STR(OFFB_BWB0);
 	CASE_BTC_POLICY_STR(OFFE_DEF);
 	CASE_BTC_POLICY_STR(OFFE_DEF2);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7957b7b9e4c7..cbebfbf1d64a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1741,6 +1741,7 @@ struct rtw89_btc_wl_info {
 	u8 cn_report;
 	u8 coex_mode;
 
+	bool bg_mode;
 	bool scbd_change;
 	u32 scbd;
 };
-- 
2.25.1



Return-Path: <linux-wireless+bounces-23952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7B9AD47F4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A33B7AC52C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 01:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E84685;
	Wed, 11 Jun 2025 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZKfv6UB7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF042AA4
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605769; cv=none; b=QFfnBmLRoPegmQS8nE8rlMIJ2xbbqww1FR67jH2cemLsVTIzu2E1wjPPVyccFbPOWSJwVAVK0QX22SFbf7HZgC3DoGd01CEB0ybTiwE8+mx5wFKOf3pvx3iw98/I77wGyazaHXj7X2JyeMjDHYeT6t8/6r8EWNbwn5Z9edF8bIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605769; c=relaxed/simple;
	bh=d+/ZKRf1/Xcc/xrh8ersCLGXSF3kedM0kPxGfEoWMCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYxU3gOC15OIalBh/8pWlEdl0ViXiB2Ly6K6fHAZBR5mHBE/D872ssVxM6JtZ60fLICy4b5kXmZGBsgXxP9XCgaeRvGl930T4hIK8ZgwsWQ0Z/KA3HWGBcFU7rwUXn5MJOoqwxiZMgww3osod0kOM7LB6E0ak68c35XJktkc5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZKfv6UB7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B1a6kuD3938206, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749605766; bh=SQlOUXB42L4JOonZKogCr2KoRS5OE5QUeCpxJcm0ZRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZKfv6UB7npGSZ3eBu5a7zsJ5NMm1/6CX2JCzWzQeepFjokXJdYEXdZIBS0zwVjdyZ
	 mZ9CY90eBwjKeIGRnrr4t+uReJzl/Q4onnKC+XnZks0SEunTe8CbPr2XO850VR/Pfa
	 ZK7xzcOkZLcJdGcVUxfagSM26lqZ4nD4kaWctUpVQfpTFQ/phHEmTwhlzgMOtf24/U
	 CLC5hEKzSCz0ODdB5xrvQOLnV1Bcdgcw61TO2msHe1oV6z2rogZoEt8pcvkKic17m2
	 UmjAF/RZbCW9+nzJfcj2dTX/0ftManAjwnrInr7yWLU8Ww7xD/twsb41big6JmzbqT
	 cysO3GEdkO0sA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B1a6kuD3938206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:36:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 09:36:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 09:36:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/10] wifi: rtw89: coex: Update Pre-AGC logic for WiFi 7
Date: Wed, 11 Jun 2025 09:35:07 +0800
Message-ID: <20250611013510.15519-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611013510.15519-1-pkshih@realtek.com>
References: <20250611013510.15519-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

Pre-AGC is Wi-Fi auto Rx gain control. The mechanism need to switching
very fast, especially while Wi-Fi is under 2GHz/5GHz multi-port scenario.
To earn a more accuracy & sensitive gain control, in the WiFi 7 later
firmware, Pre-AGC mechanism has offloaded to firmware.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 37 ++++++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index ff5c804d231b..4134c59e876d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -5056,6 +5056,7 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_fbtc_outsrc_set_info *o_info = &btc->dm.ost_info;
 	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt.link_info;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info_v2 *rinfo_v2 = &wl->role_info_v2;
@@ -5087,9 +5088,7 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 		return;
 	}
 
-	if (link_mode == BTC_WLINK_25G_MCC) {
-		is_preagc = BTC_PREAGC_BB_FWCTRL;
-	} else if (!(bt->run_patch_code && bt->enable.now)) {
+	if (!(bt->run_patch_code && bt->enable.now)) {
 		is_preagc = BTC_PREAGC_DISABLE;
 	} else if (link_mode == BTC_WLINK_5G) {
 		is_preagc = BTC_PREAGC_DISABLE;
@@ -5109,6 +5108,9 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 		is_preagc = BTC_PREAGC_ENABLE;
 	}
 
+	if (!btc->ver->fcxosi && link_mode == BTC_WLINK_25G_MCC)
+		is_preagc = BTC_PREAGC_BB_FWCTRL;
+
 	if (dm->wl_pre_agc_rb != dm->wl_pre_agc &&
 	    dm->wl_pre_agc_rb != BTC_PREAGC_NOTFOUND) {
 		_get_reg_status(rtwdev, BTC_CSTATUS_BB_PRE_AGC, &val);
@@ -5122,9 +5124,34 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 	    is_preagc != dm->wl_pre_agc) {
 		dm->wl_pre_agc = is_preagc;
 
-		if (is_preagc > BTC_PREAGC_ENABLE)
+		if (!btc->ver->fcxosi && is_preagc > BTC_PREAGC_ENABLE)
+			return;
+
+		if (o_info->rf_band[BTC_RF_S0] != o_info->rf_band[BTC_RF_S1]) {/* 1+1 */
+			if (o_info->rf_band[BTC_RF_S0]) /* Non-2G */
+				o_info->nbtg_tx[BTC_RF_S0] = BTC_PREAGC_DISABLE;
+			else
+				o_info->nbtg_tx[BTC_RF_S0] = is_preagc;
+
+			if (o_info->rf_band[BTC_RF_S1]) /* Non-2G */
+				o_info->nbtg_tx[BTC_RF_S1] = BTC_PREAGC_DISABLE;
+			else
+				o_info->nbtg_tx[BTC_RF_S1] = is_preagc;
+
+		} else { /* 2+0 or 0+2 */
+			o_info->nbtg_tx[BTC_RF_S0] = is_preagc;
+			o_info->nbtg_tx[BTC_RF_S1] = is_preagc;
+		}
+
+		if (btc->ver->fcxosi)
+			return;
+
+		chip->ops->ctrl_nbtg_bt_tx(rtwdev, o_info->nbtg_tx[BTC_RF_S0],
+					   RTW89_PHY_0);
+		if (chip->chip_id != RTL8922A)
 			return;
-		chip->ops->ctrl_nbtg_bt_tx(rtwdev, dm->wl_pre_agc, RTW89_PHY_0);
+		chip->ops->ctrl_nbtg_bt_tx(rtwdev, o_info->nbtg_tx[BTC_RF_S1],
+					   RTW89_PHY_1);
 	}
 }
 
-- 
2.25.1



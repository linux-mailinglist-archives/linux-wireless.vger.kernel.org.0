Return-Path: <linux-wireless+bounces-23955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF51AD480A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976067A4A17
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 01:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA6219FA92;
	Wed, 11 Jun 2025 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wzJ2C6nK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDF19A297
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 01:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605780; cv=none; b=W4y3rnjkBz+UkGbEYhjxtLE1izjMPAmQbbzXkmm7oBny/wC5g3eI0EE5/wKZ2iqmZnnDTDpkumuduYCa9YAbjzwgvehT3YE0LgQS3gMZS/Cp6Z4dNoKRqvslDz0UizdBnTnznIwjYFR/nQv1bqhksnsFMs2htyJ/0Sxj3455/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605780; c=relaxed/simple;
	bh=ljeRPU5YroadBSrIng1Pio/+fb2M14cTt7mSJEqksBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3qcVaSuMJf6lkQoasz3xEks8AO8kvdAaWw3nu+wWWZTfAWXFPBcyhDe+GyB4pfbPoVZflZ753m6XCcCKt9ExRv3I5hM0kw4ZZEB2QmtTFdnvFev8Zc/xQ8NGFg8fEHailwVNJ3JaomfazhSHQE4QdcOS7Pb/zlf4ZbUTFmO35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wzJ2C6nK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B1aHm653938237, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749605777; bh=imT5urEpsKBAAgZHWl1mhiGINBf383np6fq9iORGX98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wzJ2C6nK83NQN7/rRYBCZ+GNjCN0zKbyCKwXEApg9XqRdaOCvqsTSFYgSJuEvg/ok
	 rpn3gcEM7kTwp71MUkJDb6yBHZ3hmKDeGaTySKYR85aa+L+lU0dPg3lSovu5U7fOmk
	 bDfpxJ6uuxWIZjqmyWq/QccH2xsy1laDat8yl86SPtPycfgjNzD1K+dGEaL7LwBDth
	 b4CIQq2kJsIM+EYjUnYhB2DTCvlNCWhfQHTyalqBlGkuB/uvAsJL5ABOnolFjIsHPf
	 WOmyCE2a8vSO9Sy6gTEuRAtzhcE0OSDv/5wsdUimIhBmvVSr0OLQ6Q1Ch/B1W6fvE8
	 nNEWae6BmMjJA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B1aHm653938237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:36:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 09:36:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 09:36:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/10] wifi: rtw89: coex: Add PTA grant signal setting offload to firmware feature
Date: Wed, 11 Jun 2025 09:35:10 +0800
Message-ID: <20250611013510.15519-11-pkshih@realtek.com>
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

In the before experience there are many issue occurred because of the
grant control signal can not be set in time especially WiFi power save
enter/leave. To control the signal more accuracy, offload the control
to firmware.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 30 +++++++++++++++++------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 77df765dc607..bdda32f735eb 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2866,6 +2866,8 @@ static void _set_gnt_v1(struct rtw89_dev *rtwdev, u8 phy_map,
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_fbtc_outsrc_set_info *osi = &dm->ost_info;
+	struct rtw89_mac_ax_wl_act *b = dm->gnt.bt;
 	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
 	u8 i, bt_idx = dm->bt_select + 1;
 
@@ -2914,21 +2916,35 @@ static void _set_gnt_v1(struct rtw89_dev *rtwdev, u8 phy_map,
 
 			switch (wlact_state) {
 			case BTC_WLACT_HW:
-				dm->gnt.bt[i].wlan_act_en = 0;
-				dm->gnt.bt[i].wlan_act = 0;
+				b[i].wlan_act_en = 0;
+				b[i].wlan_act = 0;
 				break;
 			case BTC_WLACT_SW_LO:
-				dm->gnt.bt[i].wlan_act_en = 1;
-				dm->gnt.bt[i].wlan_act = 0;
+				b[i].wlan_act_en = 1;
+				b[i].wlan_act = 0;
 				break;
 			case BTC_WLACT_SW_HI:
-				dm->gnt.bt[i].wlan_act_en = 1;
-				dm->gnt.bt[i].wlan_act = 1;
+				b[i].wlan_act_en = 1;
+				b[i].wlan_act = 1;
 				break;
 			}
 		}
 	}
-	rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
+
+	if (!btc->ver->fcxosi) {
+		rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
+		return;
+	}
+
+	memcpy(osi->gnt_set, dm->gnt.band, sizeof(osi->gnt_set));
+	memcpy(osi->wlact_set, dm->gnt.bt, sizeof(osi->wlact_set));
+
+	/* GBT source should be GBT_S1 in 1+1 (HWB0:5G + HWB1:2G) case */
+	if (osi->rf_band[BTC_RF_S0] == 1 &&
+	    osi->rf_band[BTC_RF_S1] == 0)
+		osi->rf_gbt_source = BTC_RF_S1;
+	else
+		osi->rf_gbt_source = BTC_RF_S0;
 }
 
 #define BTC_TDMA_WLROLE_MAX 3
-- 
2.25.1



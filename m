Return-Path: <linux-wireless+bounces-2516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFE83D4C2
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5766C1F21BED
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF63A1CD3F;
	Fri, 26 Jan 2024 06:34:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAD1CD2D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250878; cv=none; b=M0oZ1KlB0dJnz67Zx47UtfRYxMZnhhHw7d3h1unAD7km9DbYWtevMIIKeBwmboQ2yp0bH0stHcV4Hw7QeOanvSS1dUQZAxCeDwcND+8G3PU3DVPuMzOfCY9xUbnyvZ0sqCd4iE80tUU9TTaHUadl2fNQxSjxGHe5OwNr4BuUKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250878; c=relaxed/simple;
	bh=seZ/JhUb6e6ergDlQHnwEn5xH6142N16fJidUmPf824=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzXoHjFSyTGdrgTea0ArkPGXt0Enkdc+3fllV/istz9KAJziKw1LM/vDZN6b8TtAUYJBIxI5+BN+IS4iBiIpOyhF4HR7QuGbgwYwz7XxvqDsZEFpxFfu9tXlwrPqGE2xk4H7RrM8vcD37rDQEy3REiGi+bnNivQTwuqrGJ2L+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40Q6YTPW02085589, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40Q6YTPW02085589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:34:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 26 Jan 2024 14:34:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 14:34:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: update scan C2H messages for wifi 7 IC
Date: Fri, 26 Jan 2024 14:33:50 +0800
Message-ID: <20240126063356.17857-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126063356.17857-1-pkshih@realtek.com>
References: <20240126063356.17857-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Add definition and parsing for wifi 7 extended fields. These fields
include hardware index which is current reporting, timestamp and self
defined sequences for debug purposes.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  |  5 +++++
 drivers/net/wireless/realtek/rtw89/mac.c | 24 ++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index a3df701bdc6e..2c94d82d384c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3309,6 +3309,11 @@ struct rtw89_c2h_scanofld {
 #define RTW89_C2H_SCANOFLD_W5_TX_FAIL GENMASK(3, 0)
 #define RTW89_C2H_SCANOFLD_W5_AIR_DENSITY GENMASK(7, 4)
 #define RTW89_C2H_SCANOFLD_W5_BAND GENMASK(25, 24)
+#define RTW89_C2H_SCANOFLD_W5_MAC_IDX BIT(26)
+#define RTW89_C2H_SCANOFLD_W6_SW_DEF GENMASK(7, 0)
+#define RTW89_C2H_SCANOFLD_W6_EXPECT_PERIOD GENMASK(15, 8)
+#define RTW89_C2H_SCANOFLD_W6_FW_DEF GENMASK(23, 16)
+#define RTW89_C2H_SCANOFLD_W7_REPORT_TSF GENMASK(31, 0)
 
 #define RTW89_GET_MAC_C2H_MCC_RCV_ACK_GROUP(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(1, 0))
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index eb94e832e154..6d29a1d7b85f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4686,8 +4686,9 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 	struct rtw89_chan new;
-	u8 reason, status, tx_fail, band, actual_period;
-	u32 last_chan = rtwdev->scan_info.last_chan_idx;
+	u8 reason, status, tx_fail, band, actual_period, expect_period;
+	u32 last_chan = rtwdev->scan_info.last_chan_idx, report_tsf;
+	u8 mac_idx, sw_def, fw_def;
 	u16 chan;
 	int ret;
 
@@ -4700,15 +4701,29 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	reason = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_RSN);
 	band = le32_get_bits(c2h->w5, RTW89_C2H_SCANOFLD_W5_BAND);
 	actual_period = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_PERIOD);
+	mac_idx = le32_get_bits(c2h->w5, RTW89_C2H_SCANOFLD_W5_MAC_IDX);
+
 
 	if (!(rtwdev->chip->support_bands & BIT(NL80211_BAND_6GHZ)))
 		band = chan > 14 ? RTW89_BAND_5G : RTW89_BAND_2G;
 
 	rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
-		    "band: %d, chan: %d, reason: %d, status: %d, tx_fail: %d, actual: %d\n",
-		    band, chan, reason, status, tx_fail, actual_period);
+		    "mac_idx[%d] band: %d, chan: %d, reason: %d, status: %d, tx_fail: %d, actual: %d\n",
+		    mac_idx, band, chan, reason, status, tx_fail, actual_period);
+
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
+		sw_def = le32_get_bits(c2h->w6, RTW89_C2H_SCANOFLD_W6_SW_DEF);
+		expect_period = le32_get_bits(c2h->w6, RTW89_C2H_SCANOFLD_W6_EXPECT_PERIOD);
+		fw_def = le32_get_bits(c2h->w6, RTW89_C2H_SCANOFLD_W6_FW_DEF);
+		report_tsf = le32_get_bits(c2h->w7, RTW89_C2H_SCANOFLD_W7_REPORT_TSF);
+
+		rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
+			    "sw_def: %d, fw_def: %d, tsf: %x, expect: %d\n",
+			    sw_def, fw_def, report_tsf, expect_period);
+	}
 
 	switch (reason) {
+	case RTW89_SCAN_LEAVE_OP_NOTIFY:
 	case RTW89_SCAN_LEAVE_CH_NOTIFY:
 		if (rtw89_is_op_chan(rtwdev, band, chan)) {
 			rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, false);
@@ -4727,6 +4742,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			rtw89_hw_scan_complete(rtwdev, vif, rtwdev->scan_info.abort);
 		}
 		break;
+	case RTW89_SCAN_ENTER_OP_NOTIFY:
 	case RTW89_SCAN_ENTER_CH_NOTIFY:
 		if (rtw89_is_op_chan(rtwdev, band, chan)) {
 			rtw89_assign_entity_chan(rtwdev, rtwvif->sub_entity_idx,
-- 
2.25.1



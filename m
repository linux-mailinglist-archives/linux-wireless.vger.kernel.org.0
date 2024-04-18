Return-Path: <linux-wireless+bounces-6479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A68A910C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 04:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822691C20F75
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B23BBD8;
	Thu, 18 Apr 2024 02:12:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22E29A9
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 02:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406353; cv=none; b=lArmPYhpNL3ICoPfbAEzm1hkTXnlUUJO0YxZ8sZlRBAa2jDWUlOjJvDDpQ+hp9pLDFKMxSH82fQP4h5AMdw7pGCr65bxYMRka04Gub6CyXsZAuWk9J/ynduwRWJ2kiwahM1jlkwxcJ1D1Aj1pG4b6SVVerywGD/M6k6kiniPhVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406353; c=relaxed/simple;
	bh=Mcj2Ezpg6cZIshInuKDuXYkiwCSSAqHRLK7pUKK02Lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYWno3OHwSy0nPc2OJUuIxXZFasnsM703M61mwbCVCbmEwJQtTqtTFCa8hXCfCFQjySDcnnl9hgkycTtXM3wcPgWiZLsMVrkr5m52/rm6/gbR5vEVojYz0WxNzJnAOELGj9Q/c4D7o+ihK+5MTrKUkZ4Bo8kl6wFNfd8JFPv+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I2CTwoC3994694, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I2CTwoC3994694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:12:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:12:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:12:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 1/9] wifi: rtw89: coex: Allow Bluetooth doing traffic during Wi-Fi scan
Date: Thu, 18 Apr 2024 10:11:59 +0800
Message-ID: <20240418021207.32173-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418021207.32173-1-pkshih@realtek.com>
References: <20240418021207.32173-1-pkshih@realtek.com>
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

The Wi-Fi/Bluetooth slot are toggled by firmware timer when Wi-Fi doing
firmware scan, and Wi-Fi slot don't allow Bluetooth do traffic when
Wi-Fi slot. It will trigger Bluetooth audio lag in a random rate, because
Bluetooth can not have enough time slot to keep enough data to play audio.
This patch make Bluetooth can do traffic during Wi-Fi slot, this can help
Bluetooth to collect audio data in time.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 61 +++++++++++++----------
 drivers/net/wireless/realtek/rtw89/core.h |  3 ++
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index e4f70d62b32f..8992ee408b7f 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -212,6 +212,16 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 
 #define RTW89_DEFAULT_BTC_VER_IDX (ARRAY_SIZE(rtw89_btc_ver_defs) - 1)
 
+static const union rtw89_btc_wl_state_map btc_scanning_map = {
+	.map = {
+		.scan = 1,
+		.connecting = 1,
+		.roaming = 1,
+		.transacting = 1,
+		._4way = 1,
+	},
+};
+
 struct rtw89_btc_btf_tlv {
 	u8 type;
 	u8 len;
@@ -4848,6 +4858,30 @@ static void _action_wl_2g_sta(struct rtw89_dev *rtwdev)
 	_action_by_bt(rtwdev);
 }
 
+static void _action_wl_25g_mcc(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	u16 policy_type = BTC_CXP_OFF_BT;
+
+	if (btc->ant_type == BTC_ANT_SHARED) {
+		if (btc->cx.wl.status.map._4way)
+			policy_type = BTC_CXP_OFFE_WL;
+		else if (btc->cx.wl.status.val & btc_scanning_map.val)
+			policy_type = BTC_CXP_OFFE_2GBWMIXB;
+		else if (btc->cx.bt.link_info.profile_cnt.now == 0)
+			policy_type = BTC_CXP_OFFE_2GISOB;
+		else
+			policy_type = BTC_CXP_OFFE_2GBWISOB;
+	} else { /* dedicated-antenna */
+		policy_type = BTC_CXP_OFF_EQ0;
+	}
+
+	btc->dm.e2g_slot_limit = BTC_E2G_LIMIT_DEF;
+
+	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W25G);
+	_set_policy(rtwdev, policy_type, BTC_ACT_WL_25G_MCC);
+}
+
 static void _action_wl_scan(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -4855,14 +4889,7 @@ static void _action_wl_scan(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 
 	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
-		_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W25G);
-		if (btc->ant_type == BTC_ANT_SHARED)
-			_set_policy(rtwdev, BTC_CXP_OFFE_DEF,
-				    BTC_RSN_NTFY_SCAN_START);
-		else
-			_set_policy(rtwdev, BTC_CXP_OFF_EQ0,
-				    BTC_RSN_NTFY_SCAN_START);
-
+		_action_wl_25g_mcc(rtwdev);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], Scan offload!\n");
 	} else if (rtwdev->dbcc_en) {
 		if (wl_dinfo->real_band[RTW89_PHY_0] != RTW89_BAND_2G &&
@@ -4878,24 +4905,6 @@ static void _action_wl_scan(struct rtw89_dev *rtwdev)
 	}
 }
 
-static void _action_wl_25g_mcc(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-
-	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W25G);
-
-	if (btc->ant_type == BTC_ANT_SHARED) {
-		if (btc->cx.bt.link_info.profile_cnt.now == 0)
-			_set_policy(rtwdev, BTC_CXP_OFFE_DEF2,
-				    BTC_ACT_WL_25G_MCC);
-		else
-			_set_policy(rtwdev, BTC_CXP_OFFE_DEF,
-				    BTC_ACT_WL_25G_MCC);
-	} else { /* dedicated-antenna */
-		_set_policy(rtwdev, BTC_CXP_OFF_EQ0, BTC_ACT_WL_25G_MCC);
-	}
-}
-
 static void _action_wl_2g_mcc(struct rtw89_dev *rtwdev)
 {	struct rtw89_btc *btc = &rtwdev->btc;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1fb960af0a85..635100f1c739 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1308,6 +1308,7 @@ struct rtw89_btc_wl_smap {
 	u32 scan: 1;
 	u32 connecting: 1;
 	u32 roaming: 1;
+	u32 transacting: 1;
 	u32 _4way: 1;
 	u32 rf_off: 1;
 	u32 lps: 2;
@@ -1316,6 +1317,8 @@ struct rtw89_btc_wl_smap {
 	u32 traffic_dir : 2;
 	u32 rf_off_pre: 1;
 	u32 lps_pre: 2;
+	u32 lps_exiting: 1;
+	u32 emlsr: 1;
 };
 
 enum rtw89_tfc_lv {
-- 
2.25.1



Return-Path: <linux-wireless+bounces-4235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC01A86C2CE
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9AF1C21639
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 07:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103AE46556;
	Thu, 29 Feb 2024 07:46:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17487481AD
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192803; cv=none; b=V2tWYFcCDmncmYGlrUBEltDMpIJxP9n+BHVnHpKQ43tI3nSY9z5hll7I7OVI69Smbubmanh67XcOeUKe3oPRnE23axEEkaUv9lv76k8Cx+atR7Y2SO3pjY0Mg5S8tBfluf3NGXVBBaIHbyt3/prZWcqTWJanwQOdlCXYry2Dnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192803; c=relaxed/simple;
	bh=7Q76NB9Ehx+Nb1BSG5SQ5hNB93S4Du8PSRRi2jGPApE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpgDfyjHxGsfcFeThIsF9orgmF76lLpf/VVckYYH2YPJqtRvWwfIhADe2LElzeiKNp8pf8N/BoExX4kH5q/OQVZO1tN5K8jv3bPHw9kRbhnVeOxGzLtgceA/NUpA7ZCQ17mAjxVIXw6YL4L9BGxyh386JP9YLkYJVWztQT+HAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T7kYvrD1229906, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T7kYvrD1229906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 15:46:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 29 Feb 2024 15:46:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 15:46:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: coex: add return value to ensure H2C command is success or not
Date: Thu, 29 Feb 2024 15:45:12 +0800
Message-ID: <20240229074514.219276-7-pkshih@realtek.com>
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

Add return value to H2C function, and only record down the value while
H2C command success, this can help us to check the real time status.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 52 ++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/coex.h |  2 +
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index c270d0c26c00..c74b1b6be2d3 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -683,20 +683,25 @@ static void _run_coex(struct rtw89_dev *rtwdev,
 static void _write_scbd(struct rtw89_dev *rtwdev, u32 val, bool state);
 static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update);
 
-static void _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
-			 void *param, u16 len)
+static int _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
+			void *param, u16 len)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
+	struct rtw89_btc_dm *dm = &btc->dm;
 	int ret;
 
-	if (!wl->status.map.init_ok) {
+	if (len > BTC_H2C_MAXLEN || len == 0) {
+		btc->fwinfo.cnt_h2c_fail++;
+		dm->error.map.h2c_buffer_over = true;
+		return -EINVAL;
+	} else if (!wl->status.map.init_ok) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): return by btc not init!!\n", __func__);
 		pfwinfo->cnt_h2c_fail++;
-		return;
+		return -EINVAL;
 	} else if ((wl->status.map.rf_off_pre == BTC_LPS_RF_OFF &&
 		    wl->status.map.rf_off == BTC_LPS_RF_OFF) ||
 		   (wl->status.map.lps_pre == BTC_LPS_RF_OFF &&
@@ -704,15 +709,17 @@ static void _send_fw_cmd(struct rtw89_dev *rtwdev, u8 h2c_class, u8 h2c_func,
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "[BTC], %s(): return by wl off!!\n", __func__);
 		pfwinfo->cnt_h2c_fail++;
-		return;
+		return -EINVAL;
 	}
 
-	pfwinfo->cnt_h2c++;
-
 	ret = rtw89_fw_h2c_raw_with_hdr(rtwdev, h2c_class, h2c_func, param, len,
 					false, true);
-	if (ret != 0)
+	if (ret)
 		pfwinfo->cnt_h2c_fail++;
+	else
+		pfwinfo->cnt_h2c++;
+
+	return ret;
 }
 
 static void _reset_btc_var(struct rtw89_dev *rtwdev, u8 type)
@@ -1938,6 +1945,7 @@ static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
 	struct rtw89_btc_btf_fwinfo *fwinfo = &btc->fwinfo;
 	struct rtw89_btc_btf_set_report r = {0};
 	u32 val, bit_map;
+	int ret;
 
 	if ((wl_smap->rf_off || wl_smap->lps != BTC_LPS_OFF) && rpt_state != 0)
 		return;
@@ -1956,13 +1964,13 @@ static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
 	if (val == fwinfo->rpt_en_map)
 		return;
 
-	fwinfo->rpt_en_map = val;
-
 	r.fver = BTF_SET_REPORT_VER;
 	r.enable = cpu_to_le32(val);
 	r.para = cpu_to_le32(rpt_state);
 
-	_send_fw_cmd(rtwdev, BTFC_SET, SET_REPORT_EN, &r, sizeof(r));
+	ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_REPORT_EN, &r, sizeof(r));
+	if (!ret)
+		fwinfo->rpt_en_map = val;
 }
 
 static void rtw89_btc_fw_set_slots(struct rtw89_dev *rtwdev, u8 num,
@@ -2050,6 +2058,7 @@ static void _fw_set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
+	int ret;
 
 	dm->run_action = action;
 
@@ -2078,11 +2087,12 @@ static void _fw_set_policy(struct rtw89_dev *rtwdev, u16 policy_type,
 	if (btc->lps == 1)
 		rtw89_set_coex_ctrl_lps(rtwdev, btc->lps);
 
-	_send_fw_cmd(rtwdev, BTFC_SET, SET_CX_POLICY,
-		     btc->policy, btc->policy_len);
-
-	memcpy(&dm->tdma_now, &dm->tdma, sizeof(dm->tdma_now));
-	memcpy(&dm->slot_now, &dm->slot, sizeof(dm->slot_now));
+	ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_CX_POLICY,
+			   btc->policy, btc->policy_len);
+	if (!ret) {
+		memcpy(&dm->tdma_now, &dm->tdma, sizeof(dm->tdma_now));
+		memcpy(&dm->slot_now, &dm->slot, sizeof(dm->slot_now));
+	}
 
 	if (btc->update_policy_force)
 		btc->update_policy_force = false;
@@ -2298,20 +2308,22 @@ static void _set_bt_tx_power(struct rtw89_dev *rtwdev, u8 level)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
+	int ret;
 	u8 buf;
 
 	if (bt->rf_para.tx_pwr_freerun == level)
 		return;
 
-	bt->rf_para.tx_pwr_freerun = level;
-	btc->dm.rf_trx_para.bt_tx_power = level;
-
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
 		    "[BTC], %s(): level = %d\n",
 		    __func__, level);
 
 	buf = (s8)(-level);
-	_send_fw_cmd(rtwdev, BTFC_SET, SET_BT_TX_PWR, &buf, 1);
+	ret = _send_fw_cmd(rtwdev, BTFC_SET, SET_BT_TX_PWR, &buf, 1);
+	if (!ret) {
+		bt->rf_para.tx_pwr_freerun = level;
+		btc->dm.rf_trx_para.bt_tx_power = level;
+	}
 }
 
 #define BTC_BT_RX_NORMAL_LVL 7
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index dd9707b4a6d4..13303830684e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -7,6 +7,8 @@
 
 #include "core.h"
 
+#define BTC_H2C_MAXLEN 2020
+
 enum btc_mode {
 	BTC_MODE_NORMAL,
 	BTC_MODE_WL,
-- 
2.25.1



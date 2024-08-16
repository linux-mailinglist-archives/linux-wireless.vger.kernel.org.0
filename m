Return-Path: <linux-wireless+bounces-11556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78237954916
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 14:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB201C2416F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474271B14F6;
	Fri, 16 Aug 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Sjr6r6vd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCECC12C54D
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812410; cv=none; b=clqRcwOolNvGNYKRuU2bk7G0rwuIMn5bZnGuTO5ecKkzNeeBRaxG4c7BaA+5YXZ4n/WMxswJ0PcSLk5jZUh83Q2rpiQgH80lquUNaKxdEfVeJDxWb9HG20TSmwbgnSZrl2mpjjwDKUv5Sik8S0h51bOb9cdyPhVbXlfx3WDFeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812410; c=relaxed/simple;
	bh=ZWdeTRKzUs6/l2EXwUD/xzAnqTuqS4auhiunuuBS4ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBhEJEg3YOl/jFc4OZt6KPur/W02Awy8YOF7kbyQLeyYVMswkkQAaEpdnSanhoPpFcp676Tx5wV70pPU2Q/lUg9oVIEOVXAarMK1/gmfpPXIgo3qAW/KCShZxu1/Y5hO/etUO2vuA1mHJeO78ZkMjYlMwzlX7JjVau0+e8T/CBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Sjr6r6vd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47GCkjUW31028473, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723812405; bh=ZWdeTRKzUs6/l2EXwUD/xzAnqTuqS4auhiunuuBS4ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Sjr6r6vdTYK025g0Aky6lb5nGmP0VUxnh6Ar5gYPbqo03LyQfLDidmkhm9wuW9MaF
	 ZyLGADnEMn8S0mY2b6qWJaSFNustDlKzWLVi4BK+BDvpDtJ6iRjkdWJ7X0Ub04la7z
	 WV3cr5MKmNh4ZdfdTe9SG2df0exOYpxKiJNs81PQ4S61yFRLTB70GB46CQzoi7F13v
	 DYW+KKgyj6MwlgVw/hKdZt+c7yI5nWFu0/hEYf3qZhl8Sruei2D1UWAq6P9Popeqkd
	 f4o7KpM7U7iitF4QaUeMPCwNbNL3j6izOIYsyF6pI5wBZGVp/NByEKMjdkG6CdsuxF
	 CEyaxRdMP+5Fw==
Received: from mail.realtek.com (smtpsrv.realtek.com[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47GCkjUW31028473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 20:46:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 20:46:45 +0800
Received: from [127.0.1.1] (172.16.21.174) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 Aug
 2024 20:46:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 4/4] wifi: rtw89: coex: Add new Wi-Fi role format condition for function using
Date: Fri, 16 Aug 2024 20:46:14 +0800
Message-ID: <20240816124614.25592-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816124614.25592-1-pkshih@realtek.com>
References: <20240816124614.25592-1-pkshih@realtek.com>
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

There are many features need the information those record at Wi-Fi role
structure. Implement the corresponding code for using.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 90 ++++++++++++++++++-----
 1 file changed, 71 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 44e066a04b97..df51b29142aa 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3211,6 +3211,7 @@ static bool _check_freerun(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_bt_hid_desc *hid = &bt_linfo->hid_desc;
@@ -3229,6 +3230,8 @@ static bool _check_freerun(struct rtw89_dev *rtwdev)
 		connect_cnt = wl_rinfo_v1->connect_cnt;
 	else if (ver->fwlrole == 2)
 		connect_cnt = wl_rinfo_v2->connect_cnt;
+	else if (ver->fwlrole == 7)
+		connect_cnt = wl_rinfo_v7->connect_cnt;
 	else if (ver->fwlrole == 8)
 		connect_cnt = wl_rinfo_v8->connect_cnt;
 
@@ -4147,6 +4150,8 @@ static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
 		dbcc_chg = wl->role_info_v1.dbcc_chg;
 	else if (btc->ver->fwlrole == 2)
 		dbcc_chg = wl->role_info_v2.dbcc_chg;
+	else if (btc->ver->fwlrole == 7)
+		dbcc_chg = wl->role_info_v7.dbcc_chg;
 	else if (btc->ver->fwlrole == 8)
 		dbcc_chg = wl->role_info_v8.dbcc_chg;
 
@@ -4819,6 +4824,7 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_wl_role_info *wl_rinfo_v0 = &wl->role_info;
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
@@ -4840,6 +4846,8 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 		wl_rinfo.link_mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
 		wl_rinfo.link_mode = wl_rinfo_v2->link_mode;
+	else if (ver->fwlrole == 7)
+		wl_rinfo.link_mode = wl_rinfo_v7->link_mode;
 	else if (ver->fwlrole == 8)
 		wl_rinfo.link_mode = wl_rinfo_v8->link_mode;
 	else
@@ -4855,6 +4863,8 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 			wl_rinfo.dbcc_2g_phy = wl_rinfo_v1->dbcc_2g_phy;
 		} else if (ver->fwlrole == 2) {
 			wl_rinfo.dbcc_2g_phy = wl_rinfo_v2->dbcc_2g_phy;
+		} else if (ver->fwlrole == 7) {
+			wl_rinfo.dbcc_2g_phy = wl_rinfo_v7->dbcc_2g_phy;
 		} else if (ver->fwlrole == 8) {
 			wl_rinfo.dbcc_2g_phy = wl_rinfo_v8->dbcc_2g_phy;
 		} else {
@@ -4900,37 +4910,56 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_bt_link_info *bt_linfo = &btc->cx.bt.link_info;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info_v2 *wl_rinfo = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v2 *rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &wl->role_info_v7;
+	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &wl->role_info_v8;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	u8 is_preagc, val;
+	u8 is_preagc, val, link_mode, dbcc_2g_phy;
+	u8 role_ver = rtwdev->btc.ver->fwlrole;
+	bool dbcc_en;
 
 	if (btc->manual_ctrl)
 		return;
 
-	if (wl_rinfo->link_mode == BTC_WLINK_25G_MCC)
+	if (role_ver == 2) {
+		dbcc_en = rinfo_v2->dbcc_en;
+		link_mode = rinfo_v2->link_mode;
+		dbcc_2g_phy = rinfo_v2->dbcc_2g_phy;
+	} else if (role_ver == 7) {
+		dbcc_en = rinfo_v7->dbcc_en;
+		link_mode = rinfo_v7->link_mode;
+		dbcc_2g_phy = rinfo_v7->dbcc_2g_phy;
+	} else if (role_ver == 8) {
+		dbcc_en = rinfo_v8->dbcc_en;
+		link_mode = rinfo_v8->link_mode;
+		dbcc_2g_phy = rinfo_v7->dbcc_2g_phy;
+	} else {
+		return;
+	}
+
+	if (link_mode == BTC_WLINK_25G_MCC) {
 		is_preagc = BTC_PREAGC_BB_FWCTRL;
-	else if (!(bt->run_patch_code && bt->enable.now))
+	} else if (!(bt->run_patch_code && bt->enable.now)) {
 		is_preagc = BTC_PREAGC_DISABLE;
-	else if (wl_rinfo->link_mode == BTC_WLINK_5G)
+	} else if (link_mode == BTC_WLINK_5G) {
 		is_preagc = BTC_PREAGC_DISABLE;
-	else if (wl_rinfo->link_mode == BTC_WLINK_NOLINK ||
-		 btc->cx.bt.link_info.profile_cnt.now == 0)
+	} else if (link_mode == BTC_WLINK_NOLINK ||
+		 btc->cx.bt.link_info.profile_cnt.now == 0) {
 		is_preagc = BTC_PREAGC_DISABLE;
-	else if (dm->tdma_now.type != CXTDMA_OFF &&
+	} else if (dm->tdma_now.type != CXTDMA_OFF &&
 		 !bt_linfo->hfp_desc.exist &&
 		 !bt_linfo->hid_desc.exist &&
-		 dm->fddt_train == BTC_FDDT_DISABLE)
+		 dm->fddt_train == BTC_FDDT_DISABLE) {
 		is_preagc = BTC_PREAGC_DISABLE;
-	else if (ver->fwlrole == 2 && wl_rinfo->dbcc_en &&
-		 wl_rinfo->dbcc_2g_phy != RTW89_PHY_1)
+	} else if (dbcc_en && (dbcc_2g_phy != RTW89_PHY_1)) {
 		is_preagc = BTC_PREAGC_DISABLE;
-	else if (btc->ant_type == BTC_ANT_SHARED)
+	} else if (btc->ant_type == BTC_ANT_SHARED) {
 		is_preagc = BTC_PREAGC_DISABLE;
-	else
+	} else {
 		is_preagc = BTC_PREAGC_ENABLE;
+	}
 
 	if (dm->wl_pre_agc_rb != dm->wl_pre_agc &&
 	    dm->wl_pre_agc_rb != BTC_PREAGC_NOTFOUND) {
@@ -5033,6 +5062,7 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_txtime_data data = {.rtwdev = rtwdev};
 	u8 mode, igno_bt, tx_retry;
@@ -5049,6 +5079,8 @@ static void _set_wl_tx_limit(struct rtw89_dev *rtwdev)
 		mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
 		mode = wl_rinfo_v2->link_mode;
+	else if (ver->fwlrole == 7)
+		mode = wl_rinfo_v7->link_mode;
 	else if (ver->fwlrole == 8)
 		mode = wl_rinfo_v8->link_mode;
 	else
@@ -5108,6 +5140,7 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	bool bt_hi_lna_rx = false;
@@ -5119,6 +5152,8 @@ static void _set_bt_rx_agc(struct rtw89_dev *rtwdev)
 		mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
 		mode = wl_rinfo_v2->link_mode;
+	else if (ver->fwlrole == 7)
+		mode = wl_rinfo_v7->link_mode;
 	else if (ver->fwlrole == 8)
 		mode = wl_rinfo_v8->link_mode;
 	else
@@ -5424,15 +5459,26 @@ static void _action_wl_2g_scc_v2(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_wl_role_info_v2 *wl_rinfo = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v2 *rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &wl->role_info_v7;
+	u32 dur, mrole_type, mrole_noa_duration;
 	u16 policy_type = BTC_CXP_OFF_BT;
-	u32 dur;
+
+	if (btc->ver->fwlrole == 2) {
+		mrole_type = rinfo_v2->mrole_type;
+		mrole_noa_duration = rinfo_v2->mrole_noa_duration;
+	} else if (btc->ver->fwlrole == 7) {
+		mrole_type = rinfo_v7->mrole_type;
+		mrole_noa_duration = rinfo_v7->mrole_noa_duration;
+	} else {
+		return;
+	}
 
 	if (btc->ant_type == BTC_ANT_DEDICATED) {
 		policy_type = BTC_CXP_OFF_EQ0;
 	} else {
 		/* shared-antenna */
-		switch (wl_rinfo->mrole_type) {
+		switch (mrole_type) {
 		case BTC_WLMROLE_STA_GC:
 			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
 			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_P2P_CLIENT;
@@ -5450,7 +5496,7 @@ static void _action_wl_2g_scc_v2(struct rtw89_dev *rtwdev)
 		case BTC_WLMROLE_STA_GO_NOA:
 			dm->wl_scc.null_role1 = RTW89_WIFI_ROLE_STATION;
 			dm->wl_scc.null_role2 = RTW89_WIFI_ROLE_NONE;
-			dur = wl_rinfo->mrole_noa_duration;
+			dur = mrole_noa_duration;
 
 			if (wl->status.map._4way) {
 				dm->wl_scc.ebt_null = 0;
@@ -6761,6 +6807,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	u8 mode, igno_bt, always_freerun;
 
@@ -6776,6 +6823,8 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 		mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
 		mode = wl_rinfo_v2->link_mode;
+	else if (ver->fwlrole == 7)
+		mode = wl_rinfo_v7->link_mode;
 	else if (ver->fwlrole == 8)
 		mode = wl_rinfo_v8->link_mode;
 	else
@@ -6922,7 +6971,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 			_action_wl_2g_scc(rtwdev);
 		else if (ver->fwlrole == 1)
 			_action_wl_2g_scc_v1(rtwdev);
-		else if (ver->fwlrole == 2)
+		else if (ver->fwlrole == 2 || ver->fwlrole == 7)
 			_action_wl_2g_scc_v2(rtwdev);
 		else if (ver->fwlrole == 8)
 			_action_wl_2g_scc_v8(rtwdev);
@@ -8124,6 +8173,7 @@ static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	u8 mode;
 
@@ -8138,6 +8188,8 @@ static void _show_wl_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		mode = wl_rinfo_v1->link_mode;
 	else if (ver->fwlrole == 2)
 		mode = wl_rinfo_v2->link_mode;
+	else if (ver->fwlrole == 7)
+		mode = wl_rinfo_v7->link_mode;
 	else if (ver->fwlrole == 8)
 		mode = wl_rinfo_v8->link_mode;
 	else
-- 
2.25.1



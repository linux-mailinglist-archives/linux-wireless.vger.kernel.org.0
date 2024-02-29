Return-Path: <linux-wireless+bounces-4232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C196C86C2CB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FAF1F21778
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079D8374DE;
	Thu, 29 Feb 2024 07:46:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8C4878F
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192793; cv=none; b=ow+pNTe97Xs1K4at7UEQM8FK4JEpSKNeW0d1xSmtQrawIGcX6isg4HqcRWQ6c8+/GMrv8T6Mani8aj6/8BDgc7yydOwzbCMcQGQb91XCir/bQ4mo44a5KT1tJ9CzuqD54IwWhO42RlSW0iGTPCzeybGGhUD1sxjhwuf819T1q5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192793; c=relaxed/simple;
	bh=1I7ErcamV9N2m3zIsqc/qgY8rLYSnHBsN2PjnJKZmf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgFxOu8JJh3yYI6v9SolFPvpSIldGBSHM01a7cp/UUZADoy4d1Qx0OmCnT7TQxDP537dqjx4WngTLjpoVtK/F8uCE0Zvrs+2y7inBBwand6tz8jb1IsgKAjgh4KyVhRJdUD7F57bdSynlD2WJQ03VdEGspt3I3aLg5/2AC8y2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T7kLGN11229766, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T7kLGN11229766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 15:46:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 29 Feb 2024 15:46:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 15:46:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/8] wifi: rtw89: coex: add init_info H2C command format version 7
Date: Thu, 29 Feb 2024 15:45:09 +0800
Message-ID: <20240229074514.219276-4-pkshih@realtek.com>
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

To avoid using bit fields for H2C command, rearrange the structure.
And also patch the corresponding code for the using of this structure.
No logic changes for existing chips.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c     | 158 ++++++++++++------
 drivers/net/wireless/realtek/rtw89/coex.h     |  18 ++
 drivers/net/wireless/realtek/rtw89/core.h     |  67 +++++++-
 drivers/net/wireless/realtek/rtw89/fw.c       |  42 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |   6 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   7 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 150 +++++++++++------
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  64 ++++---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  64 ++++---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  64 ++++---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 110 ++++++++++++
 11 files changed, 586 insertions(+), 164 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index f37afb4cbb63..3ce4ce144b9e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -129,67 +129,74 @@ static const u32 cxtbl[] = {
 
 static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	/* firmware version must be in decreasing order for each chip */
+	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 8, 0),
+	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
+	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
+	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
+	 .fwlrole = 2,   .frptmap = 7,    .fcxctrl = 7,  .fcxinit = 7,
+	 .info_buf = 1800, .max_role_num = 6,
+	},
 	{RTL8851B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
-	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,
+	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 57, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
-	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,
+	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 42, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
-	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,
+	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
 	 .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
-	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,
+	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
 	 .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,  .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
-	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,
+	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 14, 0),
 	 .fcxbtcrpt = 5, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 4,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
-	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,
+	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
-	 .fwlrole = 1,   .frptmap = 1,    .fcxctrl = 1,
+	 .fwlrole = 1,   .frptmap = 1,    .fcxctrl = 1,  .fcxinit = 0,
 	 .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 37, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
-	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,
+	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
 	 .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 0, 0),
 	 .fcxbtcrpt = 1, .fcxtdma = 1,    .fcxslots = 1, .fcxcysta = 2,
 	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
-	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,
+	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
 	 .info_buf = 1024, .max_role_num = 5,
 	},
 
@@ -198,7 +205,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxbtcrpt = 1, .fcxtdma = 1,    .fcxslots = 1, .fcxcysta = 2,
 	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
-	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,
+	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
 	 .info_buf = 1024, .max_role_num = 5,
 	},
 };
@@ -777,22 +784,27 @@ static void _get_reg_status(struct rtw89_dev *rtwdev, u8 type, u8 *val)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
-	struct rtw89_btc_module *md = &btc->mdinfo;
+	union rtw89_btc_module_info *md = &btc->mdinfo;
 	union rtw89_btc_fbtc_mreg_val *pmreg;
 	u32 pre_agc_addr = R_BTC_BB_PRE_AGC_S1;
 	u32 reg_val;
-	u8 idx;
+	u8 idx, switch_type;
 
-	if (md->ant.btg_pos == RF_PATH_A)
+	if (ver->fcxinit == 7)
+		switch_type = md->md_v7.switch_type;
+	else
+		switch_type = md->md.switch_type;
+
+	if (btc->btg_pos == RF_PATH_A)
 		pre_agc_addr = R_BTC_BB_PRE_AGC_S0;
 
 	switch (type) {
 	case BTC_CSTATUS_TXDIV_POS:
-		if (md->switch_type == BTC_SWITCH_INTERNAL)
+		if (switch_type == BTC_SWITCH_INTERNAL)
 			*val = BTC_ANT_DIV_MAIN;
 		break;
 	case BTC_CSTATUS_RXDIV_POS:
-		if (md->switch_type == BTC_SWITCH_INTERNAL)
+		if (switch_type == BTC_SWITCH_INTERNAL)
 			*val = BTC_ANT_DIV_MAIN;
 		break;
 	case BTC_CSTATUS_BB_GNT_MUX:
@@ -2083,7 +2095,10 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 
 	switch (type) {
 	case CXDRVINFO_INIT:
-		rtw89_fw_h2c_cxdrv_init(rtwdev);
+		if (ver->fcxinit == 7)
+			rtw89_fw_h2c_cxdrv_init_v7(rtwdev);
+		else
+			rtw89_fw_h2c_cxdrv_init(rtwdev);
 		break;
 	case CXDRVINFO_ROLE:
 		if (ver->fwlrole == 0)
@@ -2333,7 +2348,7 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 	}
 
 	/* decide trx_para_level */
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) {
+	if (btc->ant_type == BTC_ANT_SHARED) {
 		/* fix LNA2 + TIA gain not change by GNT_BT */
 		if ((btc->dm.wl_btg_rx && b->profile_cnt.now != 0) ||
 		    dm->bt_only == 1)
@@ -2560,8 +2575,16 @@ static bool _check_freerun(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
 	struct rtw89_btc_bt_hid_desc *hid = &bt_linfo->hid_desc;
+	union rtw89_btc_module_info *md = &btc->mdinfo;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	u8 isolation;
+
+	if (ver->fcxinit == 7)
+		isolation = md->md_v7.ant.isolation;
+	else
+		isolation = md->md.ant.isolation;
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) {
+	if (btc->ant_type == BTC_ANT_SHARED) {
 		btc->dm.trx_para_level = 0;
 		return false;
 	}
@@ -2584,7 +2607,7 @@ static bool _check_freerun(struct rtw89_dev *rtwdev)
 	}
 
 	/* TODO get isolation by BT psd */
-	if (btc->mdinfo.ant.isolation >= BTC_FREERUN_ANTISO_MIN) {
+	if (isolation >= BTC_FREERUN_ANTISO_MIN) {
 		btc->dm.trx_para_level = 5;
 		return true;
 	}
@@ -2712,7 +2735,7 @@ void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type)
 	u8 type;
 	u32 tbl_w1, tbl_b1, tbl_b4;
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) {
+	if (btc->ant_type == BTC_ANT_SHARED) {
 		if (btc->cx.wl.status.map._4way)
 			tbl_w1 = cxtbl[1];
 		else
@@ -3028,7 +3051,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 
 	type = FIELD_GET(BTC_CXP_MASK, policy_type);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) {
+	if (btc->ant_type == BTC_ANT_SHARED) {
 		if (btc->cx.wl.status.map._4way)
 			tbl_w1 = cxtbl[1];
 		else if (hid->exist && hid->type == BTC_HID_218)
@@ -3615,7 +3638,7 @@ static void _action_bt_idle(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) { /* shared-antenna */
+	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
 		switch (btc->cx.state_map) {
 		case BTC_WBUSY_BNOSCAN: /*wl-busy + bt idle*/
 		case BTC_WSCAN_BNOSCAN: /* wl-scan + bt-idle */
@@ -3654,7 +3677,7 @@ static void _action_bt_hfp(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) {
+	if (btc->ant_type == BTC_ANT_SHARED) {
 		if (btc->cx.wl.status.map._4way) {
 			_set_policy(rtwdev, BTC_CXP_OFF_WL, BTC_ACT_BT_HFP);
 		} else if (wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) {
@@ -3679,7 +3702,7 @@ static void _action_bt_hid(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) { /* shared-antenna */
+	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
 		if (wl->status.map._4way) {
 			policy_type = BTC_CXP_OFF_WL;
 		} else if (wl->status.map.traffic_dir & BIT(RTW89_TFC_UL)) {
@@ -3947,7 +3970,7 @@ static void _action_wl_other(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED)
+	if (btc->ant_type == BTC_ANT_SHARED)
 		_set_policy(rtwdev, BTC_CXP_OFFB_BWB0, BTC_ACT_WL_OTHER);
 	else
 		_set_policy(rtwdev, BTC_CXP_OFF_EQ0, BTC_ACT_WL_OTHER);
@@ -4083,7 +4106,7 @@ static void _set_wl_preagc_ctrl(struct rtw89_dev *rtwdev)
 	else if (ver->fwlrole == 2 && wl_rinfo->dbcc_en &&
 		 wl_rinfo->dbcc_2g_phy != RTW89_PHY_1)
 		is_preagc = BTC_PREAGC_DISABLE;
-	else if (btc->mdinfo.ant.type == BTC_ANT_SHARED)
+	else if (btc->ant_type == BTC_ANT_SHARED)
 		is_preagc = BTC_PREAGC_DISABLE;
 	else
 		is_preagc = BTC_PREAGC_ENABLE;
@@ -4402,7 +4425,7 @@ static void _action_wl_scan(struct rtw89_dev *rtwdev)
 
 	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
 		_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W25G);
-		if (btc->mdinfo.ant.type == BTC_ANT_SHARED)
+		if (btc->ant_type == BTC_ANT_SHARED)
 			_set_policy(rtwdev, BTC_CXP_OFFE_DEF,
 				    BTC_RSN_NTFY_SCAN_START);
 		else
@@ -4430,7 +4453,7 @@ static void _action_wl_25g_mcc(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W25G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) {
+	if (btc->ant_type == BTC_ANT_SHARED) {
 		if (btc->cx.bt.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev, BTC_CXP_OFFE_DEF2,
 				    BTC_ACT_WL_25G_MCC);
@@ -4447,7 +4470,7 @@ static void _action_wl_2g_mcc(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) { /* shared-antenna */
+	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
 		if (btc->cx.bt.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev, BTC_CXP_OFFE_DEF2,
 				    BTC_ACT_WL_2G_MCC);
@@ -4465,7 +4488,7 @@ static void _action_wl_2g_scc(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) { /* shared-antenna */
+	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
 		if (btc->cx.bt.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev,
 				    BTC_CXP_OFFE_DEF2, BTC_ACT_WL_2G_SCC);
@@ -4487,7 +4510,7 @@ static void _action_wl_2g_scc_v1(struct rtw89_dev *rtwdev)
 	u16 policy_type = BTC_CXP_OFF_BT;
 	u32 dur;
 
-	if (btc->mdinfo.ant.type == BTC_ANT_DEDICATED) {
+	if (btc->ant_type == BTC_ANT_DEDICATED) {
 		policy_type = BTC_CXP_OFF_EQ0;
 	} else {
 		/* shared-antenna */
@@ -4549,7 +4572,7 @@ static void _action_wl_2g_scc_v2(struct rtw89_dev *rtwdev)
 	u16 policy_type = BTC_CXP_OFF_BT;
 	u32 dur;
 
-	if (btc->mdinfo.ant.type == BTC_ANT_DEDICATED) {
+	if (btc->ant_type == BTC_ANT_DEDICATED) {
 		policy_type = BTC_CXP_OFF_EQ0;
 	} else {
 		/* shared-antenna */
@@ -4607,7 +4630,7 @@ static void _action_wl_2g_ap(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) {
+	if (btc->ant_type == BTC_ANT_SHARED) {
 		if (btc->cx.bt.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev, BTC_CXP_OFFE_DEF2,
 				    BTC_ACT_WL_2G_AP);
@@ -4624,7 +4647,7 @@ static void _action_wl_2g_go(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) { /* shared-antenna */
+	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
 		if (btc->cx.bt.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev,
 				    BTC_CXP_OFFE_DEF2, BTC_ACT_WL_2G_GO);
@@ -4642,7 +4665,7 @@ static void _action_wl_2g_gc(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) { /* shared-antenna */
+	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
 		_action_by_bt(rtwdev);
 	} else {/* dedicated-antenna */
 		_set_policy(rtwdev, BTC_CXP_OFF_EQ0, BTC_ACT_WL_2G_GC);
@@ -4655,7 +4678,7 @@ static void _action_wl_2g_nan(struct rtw89_dev *rtwdev)
 
 	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W2G);
 
-	if (btc->mdinfo.ant.type == BTC_ANT_SHARED) { /* shared-antenna */
+	if (btc->ant_type == BTC_ANT_SHARED) { /* shared-antenna */
 		if (btc->cx.bt.link_info.profile_cnt.now == 0)
 			_set_policy(rtwdev,
 				    BTC_CXP_OFFE_DEF2, BTC_ACT_WL_2G_NAN);
@@ -5560,16 +5583,26 @@ static void _set_init_info(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 
-	dm->init_info.wl_only = (u8)dm->wl_only;
-	dm->init_info.bt_only = (u8)dm->bt_only;
-	dm->init_info.wl_init_ok = (u8)wl->status.map.init_ok;
-	dm->init_info.dbcc_en = rtwdev->dbcc_en;
-	dm->init_info.cx_other = btc->cx.other.type;
-	dm->init_info.wl_guard_ch = chip->afh_guard_ch;
-	dm->init_info.module = btc->mdinfo;
+	if (ver->fcxinit == 7) {
+		dm->init_info.init_v7.wl_only = (u8)dm->wl_only;
+		dm->init_info.init_v7.bt_only = (u8)dm->bt_only;
+		dm->init_info.init_v7.wl_init_ok = (u8)wl->status.map.init_ok;
+		dm->init_info.init_v7.cx_other = btc->cx.other.type;
+		dm->init_info.init_v7.wl_guard_ch = chip->afh_guard_ch;
+		dm->init_info.init_v7.module = btc->mdinfo.md_v7;
+	} else {
+		dm->init_info.init.wl_only = (u8)dm->wl_only;
+		dm->init_info.init.bt_only = (u8)dm->bt_only;
+		dm->init_info.init.wl_init_ok = (u8)wl->status.map.init_ok;
+		dm->init_info.init.dbcc_en = rtwdev->dbcc_en;
+		dm->init_info.init.cx_other = btc->cx.other.type;
+		dm->init_info.init.wl_guard_ch = chip->afh_guard_ch;
+		dm->init_info.init.module = btc->mdinfo.md;
+	}
 }
 
 void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode)
@@ -6298,7 +6331,7 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 		if (BTC_RSSI_LOW(link_info->rssi_state[i]))
 			rssi_map |= BIT(i);
 
-		if (btc->mdinfo.ant.type == BTC_ANT_DEDICATED &&
+		if (btc->ant_type == BTC_ANT_DEDICATED &&
 		    BTC_RSSI_CHANGE(link_info->rssi_state[i]))
 			is_sta_change = true;
 	}
@@ -6489,13 +6522,16 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 
 static void _show_cx_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
+	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	u32 ver_main = 0, ver_sub = 0, ver_hotfix = 0, id_branch = 0;
+	u8 cv, rfe, iso, ant_num, ant_single_pos;
 
 	if (!(dm->coex_info_map & BTC_COEX_INFO_CX))
 		return;
@@ -6545,11 +6581,24 @@ static void _show_cx_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 		   ver_main, ver_sub, ver_hotfix, id_branch,
 		   bt->ver_info.fw, bt->run_patch_code ? "patch" : "ROM");
 
+	if (ver->fcxinit == 7) {
+		cv = md->md_v7.kt_ver;
+		rfe = md->md_v7.rfe_type;
+		iso = md->md_v7.ant.isolation;
+		ant_num = md->md_v7.ant.num;
+		ant_single_pos = md->md_v7.ant.single_pos;
+	} else {
+		cv = md->md.cv;
+		rfe = md->md.rfe_type;
+		iso = md->md.ant.isolation;
+		ant_num = md->md.ant.num;
+		ant_single_pos = md->md.ant.single_pos;
+	}
+
 	seq_printf(m, " %-15s : cv:%x, rfe_type:0x%x, ant_iso:%d, ant_pg:%d, %s",
-		   "[hw_info]", btc->mdinfo.cv, btc->mdinfo.rfe_type,
-		   btc->mdinfo.ant.isolation, btc->mdinfo.ant.num,
-		   (btc->mdinfo.ant.num > 1 ? "" : (btc->mdinfo.ant.single_pos ?
-		   "1Ant_Pos:S1, " : "1Ant_Pos:S0, ")));
+		   "[hw_info]", cv, rfe, iso, ant_num,
+		   ant_num > 1 ? "" :
+		   ant_single_pos ? "1Ant_Pos:S1, " : "1Ant_Pos:S0, ");
 
 	seq_printf(m, "3rd_coex:%d, dbcc:%d, tx_num:%d, rx_num:%d\n",
 		   btc->cx.other.type, rtwdev->dbcc_en, hal->tx_nss,
@@ -6722,20 +6771,26 @@ static void _show_bt_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_bt_info *bt = &cx->bt;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
-	struct rtw89_btc_module *module = &btc->mdinfo;
 	struct rtw89_btc_bt_link_info *bt_linfo = &bt->link_info;
+	union rtw89_btc_module_info *md = &btc->mdinfo;
 	u8 *afh = bt_linfo->afh_map;
 	u8 *afh_le = bt_linfo->afh_map_le;
+	u8 bt_pos;
 
 	if (!(btc->dm.coex_info_map & BTC_COEX_INFO_BT))
 		return;
 
+	if (ver->fcxinit == 7)
+		bt_pos = md->md_v7.bt_pos;
+	else
+		bt_pos = md->md.bt_pos;
+
 	seq_puts(m, "========== [BT Status] ==========\n");
 
 	seq_printf(m, " %-15s : enable:%s, btg:%s%s, connect:%s, ",
 		   "[status]", bt->enable.now ? "Y" : "N",
 		   bt->btg_type ? "Y" : "N",
-		   (bt->enable.now && (bt->btg_type != module->bt_pos) ?
+		   (bt->enable.now && (bt->btg_type != bt_pos) ?
 		   "(efuse-mismatch!!)" : ""),
 		   (bt_linfo->status.map.connect ? "Y" : "N"));
 
@@ -7123,7 +7178,6 @@ static void _show_dm_step(struct rtw89_dev *rtwdev, struct seq_file *m)
 static void _show_dm_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_module *module = &btc->mdinfo;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
@@ -7137,7 +7191,7 @@ static void _show_dm_info(struct rtw89_dev *rtwdev, struct seq_file *m)
 	seq_printf(m,
 		   " %-15s : type:%s, reason:%s(), action:%s(), ant_path:%s, init_mode:%s, run_cnt:%d\n",
 		   "[status]",
-		   module->ant.type == BTC_ANT_SHARED ? "shared" : "dedicated",
+		   btc->ant_type == BTC_ANT_SHARED ? "shared" : "dedicated",
 		   steps_to_str(dm->run_reason),
 		   steps_to_str(dm->run_action | BTC_ACT_EXT_BIT),
 		   id_to_ant(FIELD_GET(GENMASK(7, 0), dm->set_ant_path)),
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 08121fd899e6..dd9707b4a6d4 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -153,6 +153,10 @@ enum btc_lps_state {
 
 #define BTC_REG_NOTFOUND 0xff
 
+#define R_BTC_ZB_COEX_TBL_0 0xE328
+#define R_BTC_ZB_COEX_TBL_1 0xE32c
+#define R_BTC_ZB_BREAK_TBL  0xE350
+
 enum btc_ant_div_pos {
 	BTC_ANT_DIV_MAIN = 0,
 	BTC_ANT_DIV_AUX = 1,
@@ -181,6 +185,20 @@ enum btc_btgctrl_type {
 	BTC_BTGCTRL_BB_GNT_NOTFOUND,
 };
 
+enum btc_wa_type {
+	BTC_WA_5G_HI_CH_RX = BIT(0),
+	BTC_WA_NULL_AP = BIT(1),
+	BTC_WA_HFP_ZB = BIT(2),  /* HFP PTA req bit4 define issue */
+};
+
+enum btc_3cx_type {
+	BTC_3CX_NONE = 0,
+	BTC_3CX_BT2 = BIT(0),
+	BTC_3CX_ZB = BIT(1),
+	BTC_3CX_LTE = BIT(2),
+	BTC_3CX_MAX,
+};
+
 void rtw89_btc_ntfy_poweron(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_poweroff(struct rtw89_dev *rtwdev);
 void rtw89_btc_ntfy_init(struct rtw89_dev *rtwdev, u8 mode);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2bf1e4e95c0f..4ecca3e51697 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1277,6 +1277,18 @@ struct rtw89_btc_ant_info {
 	u8 stream_cnt: 4;
 };
 
+struct rtw89_btc_ant_info_v7 {
+	u8 type;  /* shared, dedicated(non-shared) */
+	u8 num;   /* antenna count  */
+	u8 isolation;
+	u8 single_pos;/* wifi 1ss-1ant at 0:S0 or 1:S1 */
+
+	u8 diversity; /* only for wifi use 1-antenna */
+	u8 btg_pos; /* btg-circuit at 0:S0/1:S1/others:all */
+	u8 stream_cnt;  /* spatial_stream count */
+	u8 rsvd;
+} __packed;
+
 enum rtw89_tfc_dir {
 	RTW89_TFC_UL,
 	RTW89_TFC_DL,
@@ -1671,6 +1683,16 @@ struct rtw89_btc_dm_emap {
 	u32 wl_e2g_hang: 1;
 	u32 wl_ver_mismatch: 1;
 	u32 bt_ver_mismatch: 1;
+	u32 rfe_type0: 1;
+	u32 h2c_buffer_over: 1;
+	u32 bt_tx_hang: 1; /* for SNR too low bug, BT has no Tx req*/
+	u32 wl_no_sta_ntfy: 1;
+
+	u32 h2c_bmap_mismatch: 1;
+	u32 c2h_bmap_mismatch: 1;
+	u32 h2c_struct_invalid: 1;
+	u32 c2h_struct_invalid: 1;
+	u32 h2c_c2h_buffer_mismatch: 1;
 };
 
 union rtw89_btc_dm_error_map {
@@ -1736,6 +1758,25 @@ struct rtw89_btc_module {
 	u8 kt_ver_adie;
 };
 
+struct rtw89_btc_module_v7 {
+	u8 rfe_type;
+	u8 kt_ver;
+	u8 bt_solo;
+	u8 bt_pos; /* wl-end view: get from efuse, must compare bt.btg_type*/
+
+	u8 switch_type; /* WL/BT switch type: 0: internal, 1: external */
+	u8 wa_type; /* WA type: 0:none, 1: 51B 5G_Hi-Ch_Rx */
+	u8 kt_ver_adie;
+	u8 rsvd;
+
+	struct rtw89_btc_ant_info_v7 ant;
+} __packed;
+
+union rtw89_btc_module_info {
+	struct rtw89_btc_module md;
+	struct rtw89_btc_module_v7 md_v7;
+};
+
 #define RTW89_BTC_DM_MAXSTEP 30
 #define RTW89_BTC_DM_CNT_MAX (RTW89_BTC_DM_MAXSTEP * 8)
 
@@ -1758,6 +1799,25 @@ struct rtw89_btc_init_info {
 	u16 rsvd;
 };
 
+struct rtw89_btc_init_info_v7 {
+	u8 wl_guard_ch;
+	u8 wl_only;
+	u8 wl_init_ok;
+	u8 rsvd3;
+
+	u8 cx_other;
+	u8 bt_only;
+	u8 pta_mode;
+	u8 pta_direction;
+
+	struct rtw89_btc_module_v7 module;
+} __packed;
+
+union rtw89_btc_init_info_u {
+	struct rtw89_btc_init_info init;
+	struct rtw89_btc_init_info_v7 init_v7;
+};
+
 struct rtw89_btc_wl_tx_limit_para {
 	u16 enable;
 	u32 tx_time;	/* unit: us */
@@ -2496,7 +2556,7 @@ struct rtw89_btc_dm {
 	struct rtw89_btc_fbtc_tdma tdma;
 	struct rtw89_btc_fbtc_tdma tdma_now;
 	struct rtw89_mac_ax_coex_gnt gnt;
-	struct rtw89_btc_init_info init_info; /* pass to wl_fw if offload */
+	union rtw89_btc_init_info_u init_info; /* pass to wl_fw if offload */
 	struct rtw89_btc_rf_trx_para rf_trx_para;
 	struct rtw89_btc_wl_tx_limit_para wl_tx_limit;
 	struct rtw89_btc_dm_step dm_step;
@@ -2717,6 +2777,7 @@ struct rtw89_btc_ver {
 	u8 fwlrole;
 	u8 frptmap;
 	u8 fcxctrl;
+	u8 fcxinit;
 
 	u16 info_buf;
 	u8 max_role_num;
@@ -2730,7 +2791,7 @@ struct rtw89_btc {
 	struct rtw89_btc_cx cx;
 	struct rtw89_btc_dm dm;
 	struct rtw89_btc_ctrl ctrl;
-	struct rtw89_btc_module mdinfo;
+	union rtw89_btc_module_info mdinfo;
 	struct rtw89_btc_btf_fwinfo fwinfo;
 	struct rtw89_btc_dbg dbg;
 
@@ -2742,6 +2803,8 @@ struct rtw89_btc {
 	u32 bt_req_len;
 
 	u8 policy[RTW89_BTC_POLICY_MAXLEN];
+	u8 ant_type;
+	u8 btg_pos;
 	u16 policy_len;
 	u16 policy_type;
 	bool bt_req_en;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f654ad4c2546..b56ecd410907 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3757,7 +3757,7 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_init_info *init_info = &dm->init_info;
+	struct rtw89_btc_init_info *init_info = &dm->init_info.init;
 	struct rtw89_btc_module *module = &init_info->module;
 	struct rtw89_btc_ant_info *ant = &module->ant;
 	struct rtw89_h2c_cxinit *h2c;
@@ -3820,6 +3820,46 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
+int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_init_info_v7 *init_info = &dm->init_info.init_v7;
+	struct rtw89_h2c_cxinit_v7 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_init_v7\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cxinit_v7 *)skb->data;
+
+	h2c->hdr.type = CXDRVINFO_INIT;
+	h2c->hdr.len = len - H2C_LEN_CXDRVHDR;
+	h2c->init = *init_info;
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, BTFC_SET,
+			      SET_DRV_INFO, 0, 0,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+
 #define PORT_DATA_OFFSET 4
 #define H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN 12
 #define H2C_LEN_CXDRVINFO_ROLE_SIZE(max_role_num) \
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 9c5464dcc081..3533b84717d2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2400,6 +2400,11 @@ struct rtw89_h2c_cxinit {
 #define RTW89_H2C_CXINIT_INFO_CX_OTHER BIT(3)
 #define RTW89_H2C_CXINIT_INFO_BT_ONLY BIT(4)
 
+struct rtw89_h2c_cxinit_v7 {
+	struct rtw89_h2c_cxhdr hdr;
+	struct rtw89_btc_init_info_v7 init;
+} __packed;
+
 static inline void RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(void *cmd, u8 val)
 {
 	u8p_replace_bits((u8 *)(cmd) + 2, val, GENMASK(7, 0));
@@ -4532,6 +4537,7 @@ int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi);
 int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index a7f7703a2556..12568eec32ab 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3510,8 +3510,13 @@
 #define B_AX_PTA_EDCCA_EN BIT(0)
 
 #define R_BTC_COEX_WL_REQ 0xDA24
+#define R_BTC_COEX_WL_REQ_BE 0xE324
+#define B_BTC_TX_NULL_HI BIT(23)
 #define B_BTC_TX_BCN_HI BIT(22)
+#define B_BTC_TX_TRI_HI BIT(17)
 #define B_BTC_RSP_ACK_HI BIT(10)
+#define B_BTC_PRI_MASK_TX_TIME GENMASK(4, 3)
+#define B_BTC_PRI_MASK_RX_TIME_V1 GENMASK(2, 1)
 
 #define R_BTC_BREAK_TABLE 0xDA2C
 #define BTC_BREAK_PARAM 0xf0ffffff
@@ -5932,6 +5937,8 @@
 #define B_BE_MACID_ACQ_GRP0_CLR_P BIT(2)
 #define B_BE_R_MACID_ACQ_CHK_EN BIT(0)
 
+#define R_BE_BT_BREAK_TABLE 0x0E344
+
 #define R_BE_GNT_SW_CTRL 0x0E348
 #define B_BE_WL_ACT2_VAL BIT(25)
 #define B_BE_WL_ACT2_SWCTRL BIT(24)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 83db0a686ee2..d1f9cb427f55 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1921,41 +1921,81 @@ static u8 rtw8851b_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_p
 
 static void rtw8851b_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_module *module = &btc->mdinfo;
-
-	module->rfe_type = rtwdev->efuse.rfe_type;
-	module->cv = rtwdev->hal.cv;
-	module->bt_solo = 0;
-	module->switch_type = BTC_SWITCH_INTERNAL;
-	module->ant.isolation = 10;
-	module->kt_ver_adie = rtwdev->hal.acv;
-
-	if (module->rfe_type == 0)
-		return;
-
-	/* rfe_type 3*n+1: 1-Ant(shared),
-	 *	    3*n+2: 2-Ant+Div(non-shared),
-	 *	    3*n+3: 2-Ant+no-Div(non-shared)
-	 */
-	module->ant.num = (module->rfe_type % 3 == 1) ? 1 : 2;
-	/* WL-1ss at S0, btg at s0 (On 1 WL RF) */
-	module->ant.single_pos = RF_PATH_A;
-	module->ant.btg_pos = RF_PATH_A;
-	module->ant.stream_cnt = 1;
-
-	if (module->ant.num == 1) {
-		module->ant.type = BTC_ANT_SHARED;
-		module->bt_pos = BTC_BT_BTG;
-		module->wa_type = 1;
-		module->ant.diversity = 0;
-	} else { /* ant.num == 2 */
-		module->ant.type = BTC_ANT_DEDICATED;
-		module->bt_pos = BTC_BT_ALONE;
-		module->switch_type = BTC_SWITCH_EXTERNAL;
-		module->wa_type = 0;
-		if (module->rfe_type % 3 == 2)
-			module->ant.diversity = 1;
+	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
+	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
+
+	if  (ver->fcxinit == 7) {
+		md->md_v7.rfe_type = rtwdev->efuse.rfe_type;
+		md->md_v7.kt_ver = rtwdev->hal.cv;
+		md->md_v7.bt_solo = 0;
+		md->md_v7.switch_type = BTC_SWITCH_INTERNAL;
+		md->md_v7.ant.isolation = 10;
+		md->md_v7.kt_ver_adie = rtwdev->hal.acv;
+
+		if (md->md_v7.rfe_type == 0)
+			return;
+
+		/* rfe_type 3*n+1: 1-Ant(shared),
+		 *	    3*n+2: 2-Ant+Div(non-shared),
+		 *	    3*n+3: 2-Ant+no-Div(non-shared)
+		 */
+		md->md_v7.ant.num = (md->md_v7.rfe_type % 3 == 1) ? 1 : 2;
+		/* WL-1ss at S0, btg at s0 (On 1 WL RF) */
+		md->md_v7.ant.single_pos = RF_PATH_A;
+		md->md_v7.ant.btg_pos = RF_PATH_A;
+		md->md_v7.ant.stream_cnt = 1;
+
+		if (md->md_v7.ant.num == 1) {
+			md->md_v7.ant.type = BTC_ANT_SHARED;
+			md->md_v7.bt_pos = BTC_BT_BTG;
+			md->md_v7.wa_type = 1;
+			md->md_v7.ant.diversity = 0;
+		} else { /* ant.num == 2 */
+			md->md_v7.ant.type = BTC_ANT_DEDICATED;
+			md->md_v7.bt_pos = BTC_BT_ALONE;
+			md->md_v7.switch_type = BTC_SWITCH_EXTERNAL;
+			md->md_v7.wa_type = 0;
+			if (md->md_v7.rfe_type % 3 == 2)
+				md->md_v7.ant.diversity = 1;
+		}
+		rtwdev->btc.btg_pos = md->md_v7.ant.btg_pos;
+		rtwdev->btc.ant_type = md->md_v7.ant.type;
+	} else {
+		md->md.rfe_type = rtwdev->efuse.rfe_type;
+		md->md.cv = rtwdev->hal.cv;
+		md->md.bt_solo = 0;
+		md->md.switch_type = BTC_SWITCH_INTERNAL;
+		md->md.ant.isolation = 10;
+		md->md.kt_ver_adie = rtwdev->hal.acv;
+
+		if (md->md.rfe_type == 0)
+			return;
+
+		/* rfe_type 3*n+1: 1-Ant(shared),
+		 *	    3*n+2: 2-Ant+Div(non-shared),
+		 *	    3*n+3: 2-Ant+no-Div(non-shared)
+		 */
+		md->md.ant.num = (md->md.rfe_type % 3 == 1) ? 1 : 2;
+		/* WL-1ss at S0, btg at s0 (On 1 WL RF) */
+		md->md.ant.single_pos = RF_PATH_A;
+		md->md.ant.btg_pos = RF_PATH_A;
+		md->md.ant.stream_cnt = 1;
+
+		if (md->md.ant.num == 1) {
+			md->md.ant.type = BTC_ANT_SHARED;
+			md->md.bt_pos = BTC_BT_BTG;
+			md->md.wa_type = 1;
+			md->md.ant.diversity = 0;
+		} else { /* ant.num == 2 */
+			md->md.ant.type = BTC_ANT_DEDICATED;
+			md->md.bt_pos = BTC_BT_ALONE;
+			md->md.switch_type = BTC_SWITCH_EXTERNAL;
+			md->md.wa_type = 0;
+			if (md->md.rfe_type % 3 == 2)
+				md->md.ant.diversity = 1;
+		}
+		rtwdev->btc.btg_pos = md->md.ant.btg_pos;
+		rtwdev->btc.ant_type = md->md.ant.type;
 	}
 }
 
@@ -1965,7 +2005,7 @@ void rtw8851b_set_trx_mask(struct rtw89_dev *rtwdev, u8 path, u8 group, u32 val)
 	if (group > BTC_BT_SS_GROUP)
 		group--; /* Tx-group=1, Rx-group=2 */
 
-	if (rtwdev->btc.mdinfo.ant.type == BTC_ANT_SHARED) /* 1-Ant */
+	if (rtwdev->btc.ant_type == BTC_ANT_SHARED) /* 1-Ant */
 		group += 3;
 
 	rtw89_write_rf(rtwdev, path, RR_LUTWA, RFREG_MASK, group);
@@ -1980,9 +2020,9 @@ static void rtw8851b_btc_init_cfg(struct rtw89_dev *rtwdev)
 	};
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_module *module = &btc->mdinfo;
-	struct rtw89_btc_ant_info *ant = &module->ant;
-	u8 path, path_min, path_max;
+	union rtw89_btc_module_info *md = &btc->mdinfo;
+	const struct rtw89_btc_ver *ver = btc->ver;
+	u8 path, path_min, path_max, str_cnt, ant_sing_pos;
 
 	/* PTA init  */
 	rtw89_mac_coex_init(rtwdev, &coex_params);
@@ -1991,9 +2031,17 @@ static void rtw8851b_btc_init_cfg(struct rtw89_dev *rtwdev)
 	chip->ops->btc_set_wl_pri(rtwdev, BTC_PRI_MASK_TX_RESP, true);
 	chip->ops->btc_set_wl_pri(rtwdev, BTC_PRI_MASK_BEACON, true);
 
+	if (ver->fcxinit == 7) {
+		str_cnt = md->md_v7.ant.stream_cnt;
+		ant_sing_pos = md->md_v7.ant.single_pos;
+	} else {
+		str_cnt = md->md.ant.stream_cnt;
+		ant_sing_pos = md->md.ant.single_pos;
+	}
+
 	/* for 1-Ant && 1-ss case: only 1-path */
-	if (ant->stream_cnt == 1) {
-		path_min = ant->single_pos;
+	if (str_cnt == 1) {
+		path_min = ant_sing_pos;
 		path_max = path_min;
 	} else {
 		path_min = RF_PATH_A;
@@ -2016,7 +2064,7 @@ static void rtw8851b_btc_init_cfg(struct rtw89_dev *rtwdev)
 		/* if GNT_WL = 0 && BT = Tx_group -->
 		 * Shared-Ant && BTG-path:WL mask(0x55f), others:WL THRU(0x5ff)
 		 */
-		if (ant->type == BTC_ANT_SHARED && ant->btg_pos == path)
+		if (btc->ant_type == BTC_ANT_SHARED && btc->btg_pos == path)
 			rtw8851b_set_trx_mask(rtwdev, path, BTC_BT_TX_GROUP, 0x55f);
 		else
 			rtw8851b_set_trx_mask(rtwdev, path, BTC_BT_TX_GROUP, 0x5ff);
@@ -2148,19 +2196,18 @@ void rtw8851b_btc_update_bt_cnt(struct rtw89_dev *rtwdev)
 static void rtw8851b_btc_wl_s1_standby(struct rtw89_dev *rtwdev, bool state)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_ant_info *ant = &btc->mdinfo.ant;
 
-	rtw89_write_rf(rtwdev, ant->btg_pos, RR_LUTWE, RFREG_MASK, 0x80000);
-	rtw89_write_rf(rtwdev, ant->btg_pos, RR_LUTWA, RFREG_MASK, 0x1);
-	rtw89_write_rf(rtwdev, ant->btg_pos, RR_LUTWD1, RFREG_MASK, 0x110);
+	rtw89_write_rf(rtwdev, btc->btg_pos, RR_LUTWE, RFREG_MASK, 0x80000);
+	rtw89_write_rf(rtwdev, btc->btg_pos, RR_LUTWA, RFREG_MASK, 0x1);
+	rtw89_write_rf(rtwdev, btc->btg_pos, RR_LUTWD1, RFREG_MASK, 0x110);
 
 	/* set WL standby = Rx for GNT_BT_Tx = 1->0 settle issue */
 	if (state)
-		rtw89_write_rf(rtwdev, ant->btg_pos, RR_LUTWD0, RFREG_MASK, 0x179c);
+		rtw89_write_rf(rtwdev, btc->btg_pos, RR_LUTWD0, RFREG_MASK, 0x179c);
 	else
-		rtw89_write_rf(rtwdev, ant->btg_pos, RR_LUTWD0, RFREG_MASK, 0x208);
+		rtw89_write_rf(rtwdev, btc->btg_pos, RR_LUTWD0, RFREG_MASK, 0x208);
 
-	rtw89_write_rf(rtwdev, ant->btg_pos, RR_LUTWE, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, btc->btg_pos, RR_LUTWE, RFREG_MASK, 0x0);
 }
 
 #define LNA2_51B_MA 0x700
@@ -2175,7 +2222,6 @@ static void rtw8851b_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 	 * level=1 Fix LNA2=5: TIA 1/0= (LNA2,TIAN6) = (5,0)/(5,1) = 18dB/12dB
 	 */
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_ant_info *ant = &btc->mdinfo.ant;
 	const struct rtw89_reg2_def *rf;
 	u32 n, i, val;
 
@@ -2203,10 +2249,10 @@ static void rtw8851b_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 	for (i = 0; i < n; i++, rf++) {
 		val = rf->data;
 		/* bit[10] = 1 if non-shared-ant for 8851b */
-		if (btc->mdinfo.ant.type == BTC_ANT_DEDICATED)
+		if (btc->ant_type == BTC_ANT_DEDICATED)
 			val |= 0x4;
 
-		rtw89_write_rf(rtwdev, ant->btg_pos, rf->addr, LNA2_51B_MA, val);
+		rtw89_write_rf(rtwdev, btc->btg_pos, rf->addr, LNA2_51B_MA, val);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 8e808ded5d52..ade8604bacb8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1665,28 +1665,55 @@ static u8 rtw8852a_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_p
 
 static void rtw8852a_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_module *module = &btc->mdinfo;
+	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
+	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
 
-	module->rfe_type = rtwdev->efuse.rfe_type;
-	module->cv = rtwdev->hal.cv;
-	module->bt_solo = 0;
-	module->switch_type = BTC_SWITCH_INTERNAL;
+	if (ver->fcxinit == 7) {
+		md->md_v7.rfe_type = rtwdev->efuse.rfe_type;
+		md->md_v7.kt_ver = rtwdev->hal.cv;
+		md->md_v7.bt_solo = 0;
+		md->md_v7.switch_type = BTC_SWITCH_INTERNAL;
 
-	if (module->rfe_type > 0)
-		module->ant.num = (module->rfe_type % 2 ? 2 : 3);
-	else
-		module->ant.num = 2;
+		if (md->md_v7.rfe_type > 0)
+			md->md_v7.ant.num = (md->md_v7.rfe_type % 2 ? 2 : 3);
+		else
+			md->md_v7.ant.num = 2;
 
-	module->ant.diversity = 0;
-	module->ant.isolation = 10;
+		md->md_v7.ant.diversity = 0;
+		md->md_v7.ant.isolation = 10;
 
-	if (module->ant.num == 3) {
-		module->ant.type = BTC_ANT_DEDICATED;
-		module->bt_pos = BTC_BT_ALONE;
+		if (md->md_v7.ant.num == 3) {
+			md->md_v7.ant.type = BTC_ANT_DEDICATED;
+			md->md_v7.bt_pos = BTC_BT_ALONE;
+		} else {
+			md->md_v7.ant.type = BTC_ANT_SHARED;
+			md->md_v7.bt_pos = BTC_BT_BTG;
+		}
+		rtwdev->btc.btg_pos = md->md_v7.ant.btg_pos;
+		rtwdev->btc.ant_type = md->md_v7.ant.type;
 	} else {
-		module->ant.type = BTC_ANT_SHARED;
-		module->bt_pos = BTC_BT_BTG;
+		md->md.rfe_type = rtwdev->efuse.rfe_type;
+		md->md.cv = rtwdev->hal.cv;
+		md->md.bt_solo = 0;
+		md->md.switch_type = BTC_SWITCH_INTERNAL;
+
+		if (md->md.rfe_type > 0)
+			md->md.ant.num = (md->md.rfe_type % 2 ? 2 : 3);
+		else
+			md->md.ant.num = 2;
+
+		md->md.ant.diversity = 0;
+		md->md.ant.isolation = 10;
+
+		if (md->md.ant.num == 3) {
+			md->md.ant.type = BTC_ANT_DEDICATED;
+			md->md.bt_pos = BTC_BT_ALONE;
+		} else {
+			md->md.ant.type = BTC_ANT_SHARED;
+			md->md.bt_pos = BTC_BT_BTG;
+		}
+		rtwdev->btc.btg_pos = md->md.ant.btg_pos;
+		rtwdev->btc.ant_type = md->md.ant.type;
 	}
 }
 
@@ -1717,7 +1744,6 @@ static void rtw8852a_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
 static void rtw8852a_btc_init_cfg(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_module *module = &btc->mdinfo;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_mac_ax_coex coex_params = {
 		.pta_mode = RTW89_MAC_AX_COEX_RTK_MODE,
@@ -1736,7 +1762,7 @@ static void rtw8852a_btc_init_cfg(struct rtw89_dev *rtwdev)
 	rtw89_write_rf(rtwdev, RF_PATH_B, RR_WLSEL, 0xfffff, 0x0);
 
 	/* set WL Tx thru in TRX mask table if GNT_WL = 0 && BT_S1 = ss group */
-	if (module->ant.type == BTC_ANT_SHARED) {
+	if (btc->ant_type == BTC_ANT_SHARED) {
 		rtw8852a_set_trx_mask(rtwdev,
 				      RF_PATH_A, BTC_BT_SS_GROUP, 0x5ff);
 		rtw8852a_set_trx_mask(rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 19454766f3de..5b8c3460e35a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2125,28 +2125,55 @@ static u8 rtw8852b_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_p
 
 static void rtw8852b_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_module *module = &btc->mdinfo;
+	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
+	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
 
-	module->rfe_type = rtwdev->efuse.rfe_type;
-	module->cv = rtwdev->hal.cv;
-	module->bt_solo = 0;
-	module->switch_type = BTC_SWITCH_INTERNAL;
+	if (ver->fcxinit == 7) {
+		md->md_v7.rfe_type = rtwdev->efuse.rfe_type;
+		md->md_v7.kt_ver = rtwdev->hal.cv;
+		md->md_v7.bt_solo = 0;
+		md->md_v7.switch_type = BTC_SWITCH_INTERNAL;
 
-	if (module->rfe_type > 0)
-		module->ant.num = module->rfe_type % 2 ? 2 : 3;
-	else
-		module->ant.num = 2;
+		if (md->md_v7.rfe_type > 0)
+			md->md_v7.ant.num = (md->md_v7.rfe_type % 2 ? 2 : 3);
+		else
+			md->md_v7.ant.num = 2;
 
-	module->ant.diversity = 0;
-	module->ant.isolation = 10;
+		md->md_v7.ant.diversity = 0;
+		md->md_v7.ant.isolation = 10;
 
-	if (module->ant.num == 3) {
-		module->ant.type = BTC_ANT_DEDICATED;
-		module->bt_pos = BTC_BT_ALONE;
+		if (md->md_v7.ant.num == 3) {
+			md->md_v7.ant.type = BTC_ANT_DEDICATED;
+			md->md_v7.bt_pos = BTC_BT_ALONE;
+		} else {
+			md->md_v7.ant.type = BTC_ANT_SHARED;
+			md->md_v7.bt_pos = BTC_BT_BTG;
+		}
+		rtwdev->btc.btg_pos = md->md_v7.ant.btg_pos;
+		rtwdev->btc.ant_type = md->md_v7.ant.type;
 	} else {
-		module->ant.type = BTC_ANT_SHARED;
-		module->bt_pos = BTC_BT_BTG;
+		md->md.rfe_type = rtwdev->efuse.rfe_type;
+		md->md.cv = rtwdev->hal.cv;
+		md->md.bt_solo = 0;
+		md->md.switch_type = BTC_SWITCH_INTERNAL;
+
+		if (md->md.rfe_type > 0)
+			md->md.ant.num = (md->md.rfe_type % 2 ? 2 : 3);
+		else
+			md->md.ant.num = 2;
+
+		md->md.ant.diversity = 0;
+		md->md.ant.isolation = 10;
+
+		if (md->md.ant.num == 3) {
+			md->md.ant.type = BTC_ANT_DEDICATED;
+			md->md.bt_pos = BTC_BT_ALONE;
+		} else {
+			md->md.ant.type = BTC_ANT_SHARED;
+			md->md.bt_pos = BTC_BT_BTG;
+		}
+		rtwdev->btc.btg_pos = md->md.ant.btg_pos;
+		rtwdev->btc.ant_type = md->md.ant.type;
 	}
 }
 
@@ -2162,7 +2189,6 @@ void rtw8852b_set_trx_mask(struct rtw89_dev *rtwdev, u8 path, u8 group, u32 val)
 static void rtw8852b_btc_init_cfg(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_module *module = &btc->mdinfo;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_mac_ax_coex coex_params = {
 		.pta_mode = RTW89_MAC_AX_COEX_RTK_MODE,
@@ -2181,7 +2207,7 @@ static void rtw8852b_btc_init_cfg(struct rtw89_dev *rtwdev)
 	rtw89_write_rf(rtwdev, RF_PATH_B, RR_WLSEL, RFREG_MASK, 0x0);
 
 	/* set WL Tx thru in TRX mask table if GNT_WL = 0 && BT_S1 = ss group */
-	if (module->ant.type == BTC_ANT_SHARED) {
+	if (btc->ant_type == BTC_ANT_SHARED) {
 		rtw8852b_set_trx_mask(rtwdev, RF_PATH_A, BTC_BT_SS_GROUP, 0x5ff);
 		rtw8852b_set_trx_mask(rtwdev, RF_PATH_B, BTC_BT_SS_GROUP, 0x5ff);
 		/* set path-A(S0) Tx/Rx no-mask if GNT_WL=0 && BT_S1=tx group */
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ca8547fbd70e..84ee7483acda 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2365,28 +2365,55 @@ static u8 rtw8852c_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_p
 
 static void rtw8852c_btc_set_rfe(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_module *module = &btc->mdinfo;
+	const struct rtw89_btc_ver *ver = rtwdev->btc.ver;
+	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
 
-	module->rfe_type = rtwdev->efuse.rfe_type;
-	module->cv = rtwdev->hal.cv;
-	module->bt_solo = 0;
-	module->switch_type = BTC_SWITCH_INTERNAL;
+	if (ver->fcxinit == 7) {
+		md->md_v7.rfe_type = rtwdev->efuse.rfe_type;
+		md->md_v7.kt_ver = rtwdev->hal.cv;
+		md->md_v7.bt_solo = 0;
+		md->md_v7.switch_type = BTC_SWITCH_INTERNAL;
 
-	if (module->rfe_type > 0)
-		module->ant.num = (module->rfe_type % 2 ? 2 : 3);
-	else
-		module->ant.num = 2;
+		if (md->md_v7.rfe_type > 0)
+			md->md_v7.ant.num = (md->md_v7.rfe_type % 2 ? 2 : 3);
+		else
+			md->md_v7.ant.num = 2;
 
-	module->ant.diversity = 0;
-	module->ant.isolation = 10;
+		md->md_v7.ant.diversity = 0;
+		md->md_v7.ant.isolation = 10;
 
-	if (module->ant.num == 3) {
-		module->ant.type = BTC_ANT_DEDICATED;
-		module->bt_pos = BTC_BT_ALONE;
+		if (md->md_v7.ant.num == 3) {
+			md->md_v7.ant.type = BTC_ANT_DEDICATED;
+			md->md_v7.bt_pos = BTC_BT_ALONE;
+		} else {
+			md->md_v7.ant.type = BTC_ANT_SHARED;
+			md->md_v7.bt_pos = BTC_BT_BTG;
+		}
+		rtwdev->btc.btg_pos = md->md_v7.ant.btg_pos;
+		rtwdev->btc.ant_type = md->md_v7.ant.type;
 	} else {
-		module->ant.type = BTC_ANT_SHARED;
-		module->bt_pos = BTC_BT_BTG;
+		md->md.rfe_type = rtwdev->efuse.rfe_type;
+		md->md.cv = rtwdev->hal.cv;
+		md->md.bt_solo = 0;
+		md->md.switch_type = BTC_SWITCH_INTERNAL;
+
+		if (md->md.rfe_type > 0)
+			md->md.ant.num = (md->md.rfe_type % 2 ? 2 : 3);
+		else
+			md->md.ant.num = 2;
+
+		md->md.ant.diversity = 0;
+		md->md.ant.isolation = 10;
+
+		if (md->md.ant.num == 3) {
+			md->md.ant.type = BTC_ANT_DEDICATED;
+			md->md.bt_pos = BTC_BT_ALONE;
+		} else {
+			md->md.ant.type = BTC_ANT_SHARED;
+			md->md.bt_pos = BTC_BT_BTG;
+		}
+		rtwdev->btc.btg_pos = md->md.ant.btg_pos;
+		rtwdev->btc.ant_type = md->md.ant.type;
 	}
 }
 
@@ -2449,7 +2476,6 @@ void rtw8852c_set_trx_mask(struct rtw89_dev *rtwdev, u8 path, u8 group, u32 val)
 static void rtw8852c_btc_init_cfg(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_module *module = &btc->mdinfo;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_mac_ax_coex coex_params = {
 		.pta_mode = RTW89_MAC_AX_COEX_RTK_MODE,
@@ -2468,7 +2494,7 @@ static void rtw8852c_btc_init_cfg(struct rtw89_dev *rtwdev)
 	rtw89_write_rf(rtwdev, RF_PATH_B, RR_WLSEL, RFREG_MASK, 0x0);
 
 	/* set WL Tx thru in TRX mask table if GNT_WL = 0 && BT_S1 = ss group */
-	if (module->ant.type == BTC_ANT_SHARED) {
+	if (btc->ant_type == BTC_ANT_SHARED) {
 		rtw8852c_set_trx_mask(rtwdev,
 				      RF_PATH_A, BTC_BT_SS_GROUP, 0x5ff);
 		rtw8852c_set_trx_mask(rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 0e99ecea32a3..ca7babf62f8a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2150,6 +2150,113 @@ static u8 rtw8922a_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_p
 	return clamp_t(int, th, 0, U8_MAX);
 }
 
+static void rtw8922a_btc_set_rfe(struct rtw89_dev *rtwdev)
+{
+	union rtw89_btc_module_info *md = &rtwdev->btc.mdinfo;
+	struct rtw89_btc_module_v7 *module = &md->md_v7;
+
+	module->rfe_type = rtwdev->efuse.rfe_type;
+	module->kt_ver = rtwdev->hal.cv;
+	module->bt_solo = 0;
+	module->switch_type = BTC_SWITCH_INTERNAL;
+	module->wa_type = 0;
+
+	module->ant.type = BTC_ANT_SHARED;
+	module->ant.num = 2;
+	module->ant.isolation = 10;
+	module->ant.diversity = 0;
+	module->ant.single_pos = RF_PATH_A;
+	module->ant.btg_pos = RF_PATH_B;
+
+	if (module->kt_ver <= 1)
+		module->wa_type |= BTC_WA_HFP_ZB;
+
+	rtwdev->btc.cx.other.type = BTC_3CX_NONE;
+
+	if (module->rfe_type == 0) {
+		rtwdev->btc.dm.error.map.rfe_type0 = true;
+		return;
+	}
+
+	module->ant.num = (module->rfe_type % 2) ?  2 : 3;
+
+	if (module->kt_ver == 0)
+		module->ant.num = 2;
+
+	if (module->ant.num == 3) {
+		module->ant.type = BTC_ANT_DEDICATED;
+		module->bt_pos = BTC_BT_ALONE;
+	} else {
+		module->ant.type = BTC_ANT_SHARED;
+		module->bt_pos = BTC_BT_BTG;
+	}
+	rtwdev->btc.btg_pos = module->ant.btg_pos;
+	rtwdev->btc.ant_type = module->ant.type;
+}
+
+static
+void rtw8922a_set_trx_mask(struct rtw89_dev *rtwdev, u8 path, u8 group, u32 val)
+{
+	rtw89_write_rf(rtwdev, path, RR_LUTWA, RFREG_MASK, group);
+	rtw89_write_rf(rtwdev, path, RR_LUTWD0, RFREG_MASK, val);
+}
+
+static void rtw8922a_btc_init_cfg(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_ant_info_v7 *ant = &btc->mdinfo.md_v7.ant;
+	u32 wl_pri, path_min, path_max;
+	u8 path;
+
+	/* for 1-Ant && 1-ss case: only 1-path */
+	if (ant->num == 1) {
+		path_min = ant->single_pos;
+		path_max = path_min;
+	} else {
+		path_min = RF_PATH_A;
+		path_max = RF_PATH_B;
+	}
+
+	path = path_min;
+
+	for (path = path_min; path <= path_max; path++) {
+		/* set DEBUG_LUT_RFMODE_MASK = 1 to start trx-mask-setup */
+		rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, BIT(17));
+
+		/* if GNT_WL=0 && BT=SS_group --> WL Tx/Rx = THRU  */
+		rtw8922a_set_trx_mask(rtwdev, path, BTC_BT_SS_GROUP, 0x5ff);
+
+		/* if GNT_WL=0 && BT=Rx_group --> WL-Rx = THRU + WL-Tx = MASK */
+		rtw8922a_set_trx_mask(rtwdev, path, BTC_BT_RX_GROUP, 0x5df);
+
+		/* if GNT_WL = 0 && BT = Tx_group -->
+		 * Shared-Ant && BTG-path:WL mask(0x55f), others:WL THRU(0x5ff)
+		 */
+		if (btc->ant_type == BTC_ANT_SHARED && btc->btg_pos == path)
+			rtw8922a_set_trx_mask(rtwdev, path, BTC_BT_TX_GROUP, 0x5ff);
+		else
+			rtw8922a_set_trx_mask(rtwdev, path, BTC_BT_TX_GROUP, 0x5ff);
+
+		rtw89_write_rf(rtwdev, path, RR_LUTWE, RFREG_MASK, 0);
+	}
+
+	/* set WL PTA Hi-Pri: Ack-Tx, beacon-tx, Trig-frame-Tx, Null-Tx*/
+	wl_pri = B_BTC_RSP_ACK_HI | B_BTC_TX_BCN_HI | B_BTC_TX_TRI_HI |
+		 B_BTC_TX_NULL_HI;
+	rtw89_write32(rtwdev, R_BTC_COEX_WL_REQ_BE, wl_pri);
+
+	/* set PTA break table */
+	rtw89_write32(rtwdev, R_BE_BT_BREAK_TABLE, BTC_BREAK_PARAM);
+
+	/* ZB coex table init for HFP PTA req-cmd bit-4 define issue COEX-900*/
+	rtw89_write32(rtwdev, R_BTC_ZB_COEX_TBL_0, 0xda5a5a5a);
+
+	rtw89_write32(rtwdev, R_BTC_ZB_COEX_TBL_1, 0xda5a5a5a);
+
+	rtw89_write32(rtwdev, R_BTC_ZB_BREAK_TBL, 0xf0ffffff);
+	btc->cx.wl.status.map.init_ok = true;
+}
+
 static void rtw8922a_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
 					 struct rtw89_rx_phy_ppdu *phy_ppdu,
 					 struct ieee80211_rx_status *status)
@@ -2257,6 +2364,9 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.h2c_default_dmac_tbl	= rtw89_fw_h2c_default_dmac_tbl_v2,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
+
+	.btc_set_rfe		= rtw8922a_btc_set_rfe,
+	.btc_init_cfg		= rtw8922a_btc_init_cfg,
 };
 
 const struct rtw89_chip_info rtw8922a_chip_info = {
-- 
2.25.1



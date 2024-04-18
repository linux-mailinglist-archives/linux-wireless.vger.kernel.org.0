Return-Path: <linux-wireless+bounces-6487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E95E58A9114
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 04:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771F5B2262C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17C7481D3;
	Thu, 18 Apr 2024 02:13:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A93BBD8
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 02:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406391; cv=none; b=eRfxBtqdVcJlaZ726BQ/T4IKc+8r01Ax2P/2FibLo/LeJs1gMHVFZURdjce3hp1Y3KD7iR6/YjlEY+gHep6fFZkgNPR80YWwT3gNqIHo71tayRnHjcGgCrgcrm56MN2/aD/0rOjFPiHLby0pH/7wG2FZ8SaAh6kjOzYzjE9Lg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406391; c=relaxed/simple;
	bh=rzngPV3U/5Av8lItqevJmYTZM94wh1rUtiKRkcgx7P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9S0/QpYcjuJbgOkKDAF586DVYQdHgCm4fOeBIscmr3eL1HjO8dyvVApcoeqZl2kBJbd2Nii2fI9+xbaG6bM9w+Nkb+JpRgXOaGh8GLlXUskAJMB/o9u4KMt9RCUts3fhTFIs069nKvvVYrI4Rd63jPbsu13qY5DgNZyD290+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I2D8mjC3994773, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I2D8mjC3994773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 10:13:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:13:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Apr
 2024 10:13:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 9/9] wifi: rtw89: coex: Re-order the index for the report from firmware
Date: Thu, 18 Apr 2024 10:12:07 +0800
Message-ID: <20240418021207.32173-10-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

The report index has changed, correct the index for the corresponding
firmware version.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 40 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h |  7 +++-
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 15f1c133c70a..1649cb2e217f 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -134,70 +134,70 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
-	 .drvinfo_type = 1, .info_buf = 1800, .max_role_num = 6,
+	 .fwevntrptl = 1, .drvinfo_type = 1, .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8851B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
+	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 57, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
+	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 42, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
-	 .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
+	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
-	 .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
+	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,  .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
+	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 14, 0),
 	 .fcxbtcrpt = 5, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 4,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
+	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 1,    .fcxctrl = 1,  .fcxinit = 0,
-	 .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
+	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 37, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
+	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 0, 0),
 	 .fcxbtcrpt = 1, .fcxtdma = 1,    .fcxslots = 1, .fcxcysta = 2,
 	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
-	 .drvinfo_type = 0, .info_buf = 1024, .max_role_num = 5,
+	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1024, .max_role_num = 5,
 	},
 
 	/* keep it to be the last as default entry */
@@ -206,7 +206,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
-	 .drvinfo_type = 0, .info_buf = 1024, .max_role_num = 5,
+	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1024, .max_role_num = 5,
 	},
 };
 
@@ -1205,6 +1205,22 @@ static void _update_bt_report(struct rtw89_dev *rtwdev, u8 rpt_type, u8 *pfinfo)
 	}
 }
 
+static void rtw89_btc_fw_rpt_evnt_ver(struct rtw89_dev *rtwdev, u8 *index)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
+
+	if (ver->fwevntrptl == 1)
+		return;
+
+	if (*index <= __BTC_RPT_TYPE_V0_SAME)
+		return;
+	else if (*index <= __BTC_RPT_TYPE_V0_MAX)
+		(*index)++;
+	else
+		*index = BTC_RPT_TYPE_MAX;
+}
+
 #define BTC_LEAK_AP_TH 10
 #define BTC_CYSTA_CHK_PERIOD 100
 
@@ -1252,6 +1268,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		    "[BTC], %s(): rpt_type:%d\n",
 		    __func__, rpt_type);
 
+	rtw89_btc_fw_rpt_evnt_ver(rtwdev, &rpt_type);
+
 	switch (rpt_type) {
 	case BTC_RPT_TYPE_CTRL:
 		pcinfo = &pfwinfo->rpt_ctrl.cinfo;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 774050aa21c7..9da8be9927d3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2856,6 +2856,7 @@ enum btf_fw_event_report {
 	BTC_RPT_TYPE_CYSTA,
 	BTC_RPT_TYPE_STEP,
 	BTC_RPT_TYPE_NULLSTA,
+	BTC_RPT_TYPE_FDDT, /* added by ver->fwevntrptl == 1 */
 	BTC_RPT_TYPE_MREG,
 	BTC_RPT_TYPE_GPIO_DBG,
 	BTC_RPT_TYPE_BT_VER,
@@ -2863,7 +2864,10 @@ enum btf_fw_event_report {
 	BTC_RPT_TYPE_BT_AFH,
 	BTC_RPT_TYPE_BT_DEVICE,
 	BTC_RPT_TYPE_TEST,
-	BTC_RPT_TYPE_MAX = 31
+	BTC_RPT_TYPE_MAX = 31,
+
+	__BTC_RPT_TYPE_V0_SAME = BTC_RPT_TYPE_NULLSTA,
+	__BTC_RPT_TYPE_V0_MAX = 12,
 };
 
 enum rtw_btc_btf_reg_type {
@@ -3005,6 +3009,7 @@ struct rtw89_btc_ver {
 	u8 fcxctrl;
 	u8 fcxinit;
 
+	u8 fwevntrptl;
 	u8 drvinfo_type;
 	u16 info_buf;
 	u8 max_role_num;
-- 
2.25.1



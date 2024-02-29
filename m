Return-Path: <linux-wireless+bounces-4234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF786C2CD
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DB0B25A70
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 07:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C283B481AC;
	Thu, 29 Feb 2024 07:46:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B4647F53
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192799; cv=none; b=PvXw/gmzmCsomemdutEXthuG/TP356Ld2TMIcw1TmUcbD/qW0O0Zg5rlEhqXysZIJdk64FpkhMq2naExpN3wCmPu30AibFjHPy9QccSxVJn6kDWTCSaGMv41n8uQ59XRnxwUWtIgxAlimtDayhkszOS6LlHSmsTD6fmKi324fJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192799; c=relaxed/simple;
	bh=nxP/MZ8qUjhnShXg1SdEEjd56AV4D6ot4IcYe8Ub7Uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RM1NPXuABDWivU318xauler6pf4O/uCvpz58z8c/H5dgIhwYOAv4GDvat4w7fLffoyKI53Yeegqq3nNS5pHN2fQbIm+A2LBqTPy0jkhTrQcSuKjeHPNuE/169+IhNusxrVEtY0UadeT4i5nSQSY2TGPLtJhtkp41PFn+CVn/mDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T7kUSG11229851, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T7kUSG11229851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 15:46:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 29 Feb 2024 15:46:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 15:46:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/8] wifi: rtw89: coex: Reorder H2C command index to align with firmware
Date: Thu, 29 Feb 2024 15:45:11 +0800
Message-ID: <20240229074514.219276-6-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

Wi-Fi firmware need some driver information to do decision or do some
real-time control. Driver will update these information by H2C command.
The chip 8922a H2C command index is different from before chips/branch,
so need to assign the correct index to let firmware parsing.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 53 ++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 36 +++++++--------
 drivers/net/wireless/realtek/rtw89/fw.h   | 30 ++++++++-----
 4 files changed, 72 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index ee658d3bea78..c270d0c26c00 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -134,70 +134,70 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 2,   .frptmap = 7,    .fcxctrl = 7,  .fcxinit = 7,
-	 .info_buf = 1800, .max_role_num = 6,
+	 .drvinfo_type = 1, .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8851B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .info_buf = 1800, .max_role_num = 6,
+	 .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 57, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .info_buf = 1280, .max_role_num = 5,
+	 .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 42, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
-	 .info_buf = 1280, .max_role_num = 5,
+	 .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
-	 .info_buf = 1280, .max_role_num = 5,
+	 .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,  .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .info_buf = 1800, .max_role_num = 6,
+	 .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 14, 0),
 	 .fcxbtcrpt = 5, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 4,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .info_buf = 1800, .max_role_num = 6,
+	 .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 1,    .fcxctrl = 1,  .fcxinit = 0,
-	 .info_buf = 1280, .max_role_num = 5,
+	 .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 37, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .info_buf = 1280, .max_role_num = 5,
+	 .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 0, 0),
 	 .fcxbtcrpt = 1, .fcxtdma = 1,    .fcxslots = 1, .fcxcysta = 2,
 	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
-	 .info_buf = 1024, .max_role_num = 5,
+	 .drvinfo_type = 0, .info_buf = 1024, .max_role_num = 5,
 	},
 
 	/* keep it to be the last as default entry */
@@ -206,7 +206,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
-	 .info_buf = 1024, .max_role_num = 5,
+	 .drvinfo_type = 0, .info_buf = 1024, .max_role_num = 5,
 	},
 };
 
@@ -2102,25 +2102,31 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 	switch (type) {
 	case CXDRVINFO_INIT:
 		if (ver->fcxinit == 7)
-			rtw89_fw_h2c_cxdrv_init_v7(rtwdev);
+			rtw89_fw_h2c_cxdrv_init_v7(rtwdev, type);
 		else
-			rtw89_fw_h2c_cxdrv_init(rtwdev);
+			rtw89_fw_h2c_cxdrv_init(rtwdev, type);
 		break;
 	case CXDRVINFO_ROLE:
 		if (ver->fwlrole == 0)
-			rtw89_fw_h2c_cxdrv_role(rtwdev);
+			rtw89_fw_h2c_cxdrv_role(rtwdev, type);
 		else if (ver->fwlrole == 1)
-			rtw89_fw_h2c_cxdrv_role_v1(rtwdev);
+			rtw89_fw_h2c_cxdrv_role_v1(rtwdev, type);
 		else if (ver->fwlrole == 2)
-			rtw89_fw_h2c_cxdrv_role_v2(rtwdev);
+			rtw89_fw_h2c_cxdrv_role_v2(rtwdev, type);
 		break;
 	case CXDRVINFO_CTRL:
+		if (ver->drvinfo_type == 1)
+			type = 2;
+
 		if (ver->fcxctrl == 7)
-			rtw89_fw_h2c_cxdrv_ctrl_v7(rtwdev);
+			rtw89_fw_h2c_cxdrv_ctrl_v7(rtwdev, type);
 		else
-			rtw89_fw_h2c_cxdrv_ctrl(rtwdev);
+			rtw89_fw_h2c_cxdrv_ctrl(rtwdev, type);
 		break;
 	case CXDRVINFO_TRX:
+		if (ver->drvinfo_type == 1)
+			type = 3;
+
 		dm->trx_info.tx_power = u32_get_bits(rf_para.wl_tx_power,
 						     RTW89_BTC_WL_DEF_TX_PWR);
 		dm->trx_info.rx_gain = u32_get_bits(rf_para.wl_rx_gain,
@@ -2131,11 +2137,18 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 						       RTW89_BTC_WL_DEF_TX_PWR);
 		dm->trx_info.cn = wl->cn_report;
 		dm->trx_info.nhm = wl->nhm.pwr;
-		rtw89_fw_h2c_cxdrv_trx(rtwdev);
+		rtw89_fw_h2c_cxdrv_trx(rtwdev, type);
 		break;
 	case CXDRVINFO_RFK:
-		rtw89_fw_h2c_cxdrv_rfk(rtwdev);
+		if (ver->drvinfo_type == 1)
+			return;
+
+		rtw89_fw_h2c_cxdrv_rfk(rtwdev, type);
 		break;
+	case CXDRVINFO_TXPWR:
+	case CXDRVINFO_FDDT:
+	case CXDRVINFO_MLO:
+	case CXDRVINFO_OSI:
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 91a8f62dc70a..7957b7b9e4c7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2791,6 +2791,7 @@ struct rtw89_btc_ver {
 	u8 fcxctrl;
 	u8 fcxinit;
 
+	u8 drvinfo_type;
 	u16 info_buf;
 	u8 max_role_num;
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4c607c8b4d15..185cd339c085 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3753,7 +3753,7 @@ int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi
 	return ret;
 }
 
-int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
+int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
@@ -3773,7 +3773,7 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_cxinit *)skb->data;
 
-	h2c->hdr.type = CXDRVINFO_INIT;
+	h2c->hdr.type = type;
 	h2c->hdr.len = len - H2C_LEN_CXDRVHDR;
 
 	h2c->ant_type = ant->type;
@@ -3820,7 +3820,7 @@ int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
-int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev)
+int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
@@ -3838,7 +3838,7 @@ int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev)
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_cxinit_v7 *)skb->data;
 
-	h2c->hdr.type = CXDRVINFO_INIT;
+	h2c->hdr.type = type;
 	h2c->hdr.ver = btc->ver->fcxinit;
 	h2c->hdr.len = len - H2C_LEN_CXDRVHDR_V7;
 	h2c->init = *init_info;
@@ -3866,7 +3866,7 @@ int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev)
 #define H2C_LEN_CXDRVINFO_ROLE_SIZE(max_role_num) \
 	(4 + 12 * (max_role_num) + H2C_LEN_CXDRVHDR)
 
-int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
+int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
@@ -3891,7 +3891,7 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
 	skb_put(skb, len);
 	cmd = skb->data;
 
-	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_ROLE);
+	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, type);
 	RTW89_SET_FWCMD_CXHDR_LEN(cmd, len - H2C_LEN_CXDRVHDR);
 
 	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, role_info->connect_cnt);
@@ -3947,7 +3947,7 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev)
 #define H2C_LEN_CXDRVINFO_ROLE_SIZE_V1(max_role_num) \
 	(4 + 16 * (max_role_num) + H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN + H2C_LEN_CXDRVHDR)
 
-int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
+int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
@@ -3971,7 +3971,7 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
 	skb_put(skb, len);
 	cmd = skb->data;
 
-	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_ROLE);
+	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, type);
 	RTW89_SET_FWCMD_CXHDR_LEN(cmd, len - H2C_LEN_CXDRVHDR);
 
 	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, role_info->connect_cnt);
@@ -4037,7 +4037,7 @@ int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev)
 #define H2C_LEN_CXDRVINFO_ROLE_SIZE_V2(max_role_num) \
 	(4 + 8 * (max_role_num) + H2C_LEN_CXDRVINFO_ROLE_DBCC_LEN + H2C_LEN_CXDRVHDR)
 
-int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev)
+int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
@@ -4061,7 +4061,7 @@ int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev)
 	skb_put(skb, len);
 	cmd = skb->data;
 
-	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_ROLE);
+	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, type);
 	RTW89_SET_FWCMD_CXHDR_LEN(cmd, len - H2C_LEN_CXDRVHDR);
 
 	RTW89_SET_FWCMD_CXROLE_CONNECT_CNT(cmd, role_info->connect_cnt);
@@ -4121,7 +4121,7 @@ int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev)
 }
 
 #define H2C_LEN_CXDRVINFO_CTRL (4 + H2C_LEN_CXDRVHDR)
-int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev)
+int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
@@ -4138,7 +4138,7 @@ int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev)
 	skb_put(skb, H2C_LEN_CXDRVINFO_CTRL);
 	cmd = skb->data;
 
-	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_CTRL);
+	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, type);
 	RTW89_SET_FWCMD_CXHDR_LEN(cmd, H2C_LEN_CXDRVINFO_CTRL - H2C_LEN_CXDRVHDR);
 
 	RTW89_SET_FWCMD_CXCTRL_MANUAL(cmd, ctrl->manual);
@@ -4165,7 +4165,7 @@ int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
-int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev)
+int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_ctrl_v7 *ctrl = &btc->ctrl.ctrl_v7;
@@ -4182,7 +4182,7 @@ int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev)
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_cxctrl_v7 *)skb->data;
 
-	h2c->hdr.type = CXDRVINFO_INIT;
+	h2c->hdr.type = type;
 	h2c->hdr.ver = btc->ver->fcxctrl;
 	h2c->hdr.len = sizeof(*h2c) - H2C_LEN_CXDRVHDR_V7;
 	h2c->ctrl = *ctrl;
@@ -4205,7 +4205,7 @@ int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev)
 }
 
 #define H2C_LEN_CXDRVINFO_TRX (28 + H2C_LEN_CXDRVHDR)
-int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev)
+int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_trx_info *trx = &btc->dm.trx_info;
@@ -4221,7 +4221,7 @@ int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev)
 	skb_put(skb, H2C_LEN_CXDRVINFO_TRX);
 	cmd = skb->data;
 
-	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_TRX);
+	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, type);
 	RTW89_SET_FWCMD_CXHDR_LEN(cmd, H2C_LEN_CXDRVINFO_TRX - H2C_LEN_CXDRVHDR);
 
 	RTW89_SET_FWCMD_CXTRX_TXLV(cmd, trx->tx_lvl);
@@ -4261,7 +4261,7 @@ int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev)
 }
 
 #define H2C_LEN_CXDRVINFO_RFK (4 + H2C_LEN_CXDRVHDR)
-int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev)
+int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
@@ -4278,7 +4278,7 @@ int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev)
 	skb_put(skb, H2C_LEN_CXDRVINFO_RFK);
 	cmd = skb->data;
 
-	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_RFK);
+	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, type);
 	RTW89_SET_FWCMD_CXHDR_LEN(cmd, H2C_LEN_CXDRVINFO_RFK - H2C_LEN_CXDRVHDR);
 
 	RTW89_SET_FWCMD_CXRFK_STATE(cmd, rfk_info->state);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 51087fa3bc0d..6993451a6ef9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2324,9 +2324,15 @@ enum rtw89_btc_btf_set {
 	SET_BT_IGNORE_WLAN_ACT,
 	SET_BT_TX_PWR,
 	SET_BT_LNA_CONSTRAIN,
-	SET_BT_GOLDEN_RX_RANGE,
+	SET_BT_QUERY_DEV_LIST,
+	SET_BT_QUERY_DEV_INFO,
 	SET_BT_PSD_REPORT,
 	SET_H2C_TEST,
+	SET_IOFLD_RF,
+	SET_IOFLD_BB,
+	SET_IOFLD_MAC,
+	SET_IOFLD_SCBD,
+	SET_H2C_MACRO,
 	SET_MAX1,
 };
 
@@ -2340,6 +2346,10 @@ enum rtw89_btc_cxdrvinfo {
 	CXDRVINFO_CTRL,
 	CXDRVINFO_SCAN,
 	CXDRVINFO_TRX,  /* WL traffic to WL fw */
+	CXDRVINFO_TXPWR,
+	CXDRVINFO_FDDT,
+	CXDRVINFO_MLO,
+	CXDRVINFO_OSI,
 	CXDRVINFO_MAX,
 };
 
@@ -4548,15 +4558,15 @@ int rtw89_fw_h2c_rssi_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_rx_phy_ppdu *phy_ppdu);
 int rtw89_fw_h2c_tp_offload(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_fw_h2c_ra(struct rtw89_dev *rtwdev, struct rtw89_ra_info *ra, bool csi);
-int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev);
-int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev);
-int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev);
-int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev);
-int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev);
-int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev);
-int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev);
-int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev);
-int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_cxdrv_init(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_init_v7(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_ctrl_v7(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev, u8 type);
+int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id);
 int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 				 struct sk_buff *skb_ofld);
-- 
2.25.1



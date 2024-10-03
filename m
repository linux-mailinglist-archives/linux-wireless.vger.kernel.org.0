Return-Path: <linux-wireless+bounces-13458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E419F98ED5F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 12:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9824C28217F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4D0152160;
	Thu,  3 Oct 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pVpWKI+J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571011514F6
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952771; cv=none; b=Ef/v4XDldJGxhwif1zEGEbeoDFpaUoagpcleWyAsg8x3K0Qj6U3YMwBFsx0+WuD9kSm+cJEfgDxm9SKf1quVnO/w4tfHLHd0N5sZjekilesu2zhjMKWh2FMwDK26LbMAlvo8ct57crTJkI4vUlLxJjh1W6mN2wMYMMjQyZyX29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952771; c=relaxed/simple;
	bh=wH8Lyb3NEKSfXfdpFcWE97Ebel3/DfOtP/Q3HM2rbZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjKUYtnhlCUruHTidApd7W3rXMyS4EDgiTC/pM4acHRuPPONaTkZzaEdt4V68KqkGrt08+6BOdDJPtkGYKLPTsJg3eqtGvIq929aj7z1HmGPosWYLtjf/wYarxaII7H9LjCpCC2XROt73xjx087tW3SJRL/AM4by0Y/BZwsNRYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pVpWKI+J; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 493AqlHaB3828703, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727952767; bh=wH8Lyb3NEKSfXfdpFcWE97Ebel3/DfOtP/Q3HM2rbZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pVpWKI+JyJdNm701Tbyz1mmtGidi5cDPmDXF65cP4qhvmptdmqWBx/rLuDbA6znzQ
	 x45Ll/Pn+tZTl/1btrW+u6/xKSVPZbM0DI5ONDrM8xjvWprffu9LoehJdOFYPBIg79
	 1BSiKC6HJS8HGdo/j4vKYmg6jFujWyrQUr3tpMDIKTbz28jgrgOV369mS88Kchqyao
	 5OmnBGEUEbvK2JVi5e4T1/o/GbExYeV8zdRY1R7GWrDO6pbPB0PcUJK/3BAwhTvI+6
	 hV2w/drdWjTgt7OBvfjKAxIBcZ9/9PX+8xzFy9/VP+V6aAiqNvUOtG/baXVMfYghWS
	 dJ7oJ0qNCpPag==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 493AqlHaB3828703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 3 Oct 2024 18:52:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 18:52:47 +0800
Received: from [127.0.1.1] (172.16.22.72) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 3 Oct
 2024 18:52:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 4/4] wifi: rtw89: coex: Add function to reorder Wi-Fi firmware report index
Date: Thu, 3 Oct 2024 18:51:40 +0800
Message-ID: <20241003105140.10867-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003105140.10867-1-pkshih@realtek.com>
References: <20241003105140.10867-1-pkshih@realtek.com>
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

To parsing firmware report correctly, driver need to re-order the report
index to match with different chips and different Wi-Fi firmware version.
Use wrong index to parse the report will lead the coexistence run into
wrong mechanism.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 85 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h |  4 +-
 2 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 3350e982ca5a..989e6e882c6e 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -137,77 +137,88 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 7,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .drvinfo_type = 1, .info_buf = 1800, .max_role_num = 6,
+	 .fwevntrptl = 1, .fwc2hfunc = 2, .drvinfo_type = 1, .info_buf = 1800,
+	 .max_role_num = 6,
 	},
 	{RTL8922A, RTW89_FW_VER_CODE(0, 35, 8, 0),
 	 .fcxbtcrpt = 8, .fcxtdma = 7,    .fcxslots = 7, .fcxcysta = 7,
 	 .fcxstep = 7,   .fcxnullsta = 7, .fcxmreg = 7,  .fcxgpiodbg = 7,
 	 .fcxbtver = 7,  .fcxbtscan = 7,  .fcxbtafh = 7, .fcxbtdevinfo = 7,
 	 .fwlrole = 8,   .frptmap = 3,    .fcxctrl = 7,  .fcxinit = 7,
-	 .fwevntrptl = 1, .drvinfo_type = 1, .info_buf = 1800, .max_role_num = 6,
+	 .fwevntrptl = 1, .fwc2hfunc = 1, .drvinfo_type = 1, .info_buf = 1800,
+	 .max_role_num = 6,
 	},
 	{RTL8851B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
+	 .max_role_num = 6,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 57, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
+	 .max_role_num = 5,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 42, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
+	 .max_role_num = 5,
 	},
 	{RTL8852C, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 2,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
+	 .max_role_num = 5,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 29, 0),
 	 .fcxbtcrpt = 105, .fcxtdma = 3,  .fcxslots = 1, .fcxcysta = 5,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 2,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 2,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 2,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
+	 .max_role_num = 6,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 29, 14, 0),
 	 .fcxbtcrpt = 5, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 4,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1800, .max_role_num = 6,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1800,
+	 .max_role_num = 6,
 	},
 	{RTL8852B, RTW89_FW_VER_CODE(0, 27, 0, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 1,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1280,
+	 .max_role_num = 5,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 37, 0),
 	 .fcxbtcrpt = 4, .fcxtdma = 3,    .fcxslots = 1, .fcxcysta = 3,
 	 .fcxstep = 3,   .fcxnullsta = 2, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 2, .fcxbtdevinfo = 1,
 	 .fwlrole = 1,   .frptmap = 3,    .fcxctrl = 1,  .fcxinit = 0,
-	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1280, .max_role_num = 5,
+	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_type = 0, .info_buf = 1280,
+	 .max_role_num = 5,
 	},
 	{RTL8852A, RTW89_FW_VER_CODE(0, 13, 0, 0),
 	 .fcxbtcrpt = 1, .fcxtdma = 1,    .fcxslots = 1, .fcxcysta = 2,
 	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
-	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1024, .max_role_num = 5,
+	 .fwevntrptl = 0, .fwc2hfunc = 0, .drvinfo_type = 0, .info_buf = 1024,
+	 .max_role_num = 5,
 	},
 
 	/* keep it to be the last as default entry */
@@ -216,7 +227,8 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 	 .fcxstep = 2,   .fcxnullsta = 1, .fcxmreg = 1,  .fcxgpiodbg = 1,
 	 .fcxbtver = 1,  .fcxbtscan = 1,  .fcxbtafh = 1, .fcxbtdevinfo = 1,
 	 .fwlrole = 0,   .frptmap = 0,    .fcxctrl = 0,  .fcxinit = 0,
-	 .fwevntrptl = 0, .drvinfo_type = 0, .info_buf = 1024, .max_role_num = 5,
+	 .fwevntrptl = 0, .fwc2hfunc = 1, .drvinfo_type = 0, .info_buf = 1024,
+	 .max_role_num = 5,
 	},
 };
 
@@ -8029,6 +8041,53 @@ void rtw89_btc_ntfy_wl_sta(struct rtw89_dev *rtwdev)
 	}
 }
 
+static u8 rtw89_btc_c2h_get_index_by_ver(struct rtw89_dev *rtwdev, u8 func)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	const struct rtw89_btc_ver *ver = btc->ver;
+
+	switch (func) {
+	case BTF_EVNT_RPT:
+	case BTF_EVNT_BT_INFO:
+	case BTF_EVNT_BT_SCBD:
+	case BTF_EVNT_BT_REG:
+	case BTF_EVNT_CX_RUNINFO:
+	case BTF_EVNT_BT_PSD:
+		return func;
+	case BTF_EVNT_BT_DEV_INFO:
+		if (ver->fwc2hfunc == 0)
+			return BTF_EVNT_BUF_OVERFLOW;
+		else
+			return BTF_EVNT_BT_DEV_INFO;
+	case BTF_EVNT_BT_LEAUDIO_INFO:
+		if (ver->fwc2hfunc == 0)
+			return BTF_EVNT_C2H_LOOPBACK;
+		else if (ver->fwc2hfunc == 1)
+			return BTF_EVNT_BUF_OVERFLOW;
+		else if (ver->fwc2hfunc == 2)
+			return func;
+		else
+			return BTF_EVNT_MAX;
+	case BTF_EVNT_BUF_OVERFLOW:
+		if (ver->fwc2hfunc == 0)
+			return BTF_EVNT_MAX;
+		else if (ver->fwc2hfunc == 1)
+			return BTF_EVNT_C2H_LOOPBACK;
+		else if (ver->fwc2hfunc == 2)
+			return func;
+		else
+			return BTF_EVNT_MAX;
+	case BTF_EVNT_C2H_LOOPBACK:
+		if (ver->fwc2hfunc == 2)
+			return func;
+		else
+			return BTF_EVNT_MAX;
+	case BTF_EVNT_MAX:
+	default:
+		return BTF_EVNT_MAX;
+	}
+}
+
 void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func)
 {
@@ -8045,6 +8104,8 @@ void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	if (class != BTFC_FW_EVENT)
 		return;
 
+	func = rtw89_btc_c2h_get_index_by_ver(rtwdev, func);
+
 	switch (func) {
 	case BTF_EVNT_BUF_OVERFLOW:
 		pfwinfo->event[func]++;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 96bc3a521e97..4debcaa7bf3f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2977,7 +2977,8 @@ enum rtw89_btc_btf_fw_event {
 	BTF_EVNT_BT_REG = 3,
 	BTF_EVNT_CX_RUNINFO = 4,
 	BTF_EVNT_BT_PSD = 5,
-	BTF_EVNT_BT_DEV_INFO = 6,
+	BTF_EVNT_BT_DEV_INFO = 6, /* fwc2hfunc > 0 */
+	BTF_EVNT_BT_LEAUDIO_INFO = 7, /* fwc2hfunc > 1 */
 	BTF_EVNT_BUF_OVERFLOW,
 	BTF_EVNT_C2H_LOOPBACK,
 	BTF_EVNT_MAX,
@@ -3144,6 +3145,7 @@ struct rtw89_btc_ver {
 	u8 fcxinit;
 
 	u8 fwevntrptl;
+	u8 fwc2hfunc;
 	u8 drvinfo_type;
 	u16 info_buf;
 	u8 max_role_num;
-- 
2.25.1



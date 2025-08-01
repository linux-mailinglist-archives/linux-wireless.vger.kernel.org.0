Return-Path: <linux-wireless+bounces-26089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C3B18841
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49D3582721
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80EE2153C1;
	Fri,  1 Aug 2025 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rghzooti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47B20B7EC
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080777; cv=none; b=nMeF6MHw2lutIgld8PrjS14fUzmbSBD505nEqc3eJj6u0cv5s7j64f6ZX79MQn5xNRmKPFcMq7bBRgliWlsaewGE5NCn6eonNqX3y04WhlalO+DAopArpsWthAYLqmIy3ZpFYvMR/7CuVOqHmXJrPFgw54K+8Jwr5DquZjTlYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080777; c=relaxed/simple;
	bh=YJa6eE7g7x6lqV8mJEEXjcnP/OkcVeG2h5dA8NtL+uY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uRSUy9J6vrEFSck7rtTLEFjxn/6NOC3VrMjRyeEw+1BT/CU8ZTJzoZOLtYCQ3Yu+ITvkfoafPfiNKbIATETG87oLx/D587WHD9v4mViIqXJSKSbKT77waPoWSRL525BTN7q0T+Tf40IpDeJ2ThDTc8JgJ1VLpNdToF9EF9wxEqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rghzooti; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae3b336e936so280126766b.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754080774; x=1754685574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3hdj8I1GurYHASOijqJN6ERwkm/vWSPPilB9CYCoRyw=;
        b=RghzootiB+nTopfuTYtq7C+ZW+ilhc6RS1JylsNsumgvUy3tFjlVi8ppwth8O3WZD+
         rMc5d6NhMJcDZi9OwIu/ThA6d0w7MxymwAyxiq0Bt7w1RwxXRwmdhgb621fBqd2AWnyG
         7To/3gytJd3H+ORgyEuTJGCVJXf0uciPODGNRKBmEncHoybae8RcmCSAUFpwfnEGn4Mu
         XCcAf3qcCZorNkq+rBYrHm5pqGJui4haCU8T1GSv8J3UGtkxsBdk69Vvwh5318GVmrmz
         1aqKO485waEgWxwBT4cnzz67PC9M6NxzhnV+xrIyxHSLOcDpXz1aogq+7Q3ld65/BDxZ
         coZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080774; x=1754685574;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hdj8I1GurYHASOijqJN6ERwkm/vWSPPilB9CYCoRyw=;
        b=l9c4DH5isuQMuHHBBxkqOU8wQg5AYt6MsQ/F8AfdC2jx/q26RcbHFeCK34g0OEOLRt
         OuY9gqyoN2FAklAPfgPj+LLDrGRT8mjOG0VUnSR3oPX3JbQZVoblSR/xrXFPyjNvOXkz
         yTqEeOfHRYU29JMpA+IAPcNIz2xC/W8SfYd6pjQSQQ6WM9OT31qU+ZAhjMS1Eq5xIGyM
         1a7a0phqP4po/ewsh6JRp/iU7WJgn5hDzaSx+TPVyXehP1TzUWDFJ57wjzK2tbUGuBM0
         eJz0kfwUvvWJkMLXnfXCeId7Fq2u7wI2fdEizEth2/jdFWd0O9wj6g8w6mUoREp5xy+2
         j1hg==
X-Gm-Message-State: AOJu0YzPgXKecn37LMOxj33cKn2rVQS7ApfGjthbGVJDmbkxPQkv8t13
	oTqyUHLf+MMHtyMRcnbTJnA+6dRuFBIStQfeTA8IWeszK4RDqiU8mxOsqYN1aw==
X-Gm-Gg: ASbGncskTbTKOAChOMOceyh2s3QoKNqqsEVN9WjIJZMtAtw6wKsqdxFrkfYoeV+qgX+
	zqbl7THs0Qr1x47lEEZBK805K7AF07sQmFNHq5ZJqbS4Zfa0DACkEX9zLdxWUHvx5IZCsXp3oxr
	jL6RQey1RWgVJ1mdlIZ1M+85RApUC4hmxim8qOxsOAuUU6lCsDQ/SdFxdHkELi8hvWMWGD7AkA+
	Qw3raaMZ8dhie2r3fSHzzYarqPK+62aw+JQ1LZbiPhssZBwdAVoaxKC3JindG0J2YX4umDMOwgW
	TemNdVw6eImdAp8c2pwXbzxzlCdDk61YI3FVS+N7z7gY3AAc96JYBO6uxA6UXBQ5JxlTQIOenc5
	pQKO3Hckk2m4HiEPI30ufbsmzjrqqGA==
X-Google-Smtp-Source: AGHT+IHyOPmMoJHkcpsHmVGq8ZndRtH3uoSZQjhWAoLn5ZpLmPM1rXW5Pdv+tubMjTk6DweQGXIMUQ==
X-Received: by 2002:a17:906:730f:b0:af9:3ed3:eda2 with SMTP id a640c23a62f3a-af94029eab5mr126173666b.60.1754080773577;
        Fri, 01 Aug 2025 13:39:33 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a1251sm336733866b.30.2025.08.01.13.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:39:33 -0700 (PDT)
Message-ID: <dcc55970-2d06-47ab-9116-b4b02125458d@gmail.com>
Date: Fri, 1 Aug 2025 23:39:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 07/11] wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ed69fa07-8678-4a40-af44-65e7b1862197@gmail.com>
Content-Language: en-US
In-Reply-To: <ed69fa07-8678-4a40-af44-65e7b1862197@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add rtw8852c_dle_mem_usb2 and rtw8852c_dle_mem_usb3 and their various
quotas and sizes in struct rtw89_mac_size_set.

"dle" could be "Data Link Engine" or "Double Link Engine". These are
some parameters needed for RTL8852CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 20 ++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      | 10 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 31 ++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2d473f1bb66c..1a1ab9c58158 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1659,6 +1659,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size7 = {RTW89_WDE_PG_64, 510, 2,},
 	/* DLFW */
 	.wde_size9 = {RTW89_WDE_PG_64, 0, 1024,},
+	/* 8852C USB3.0 */
+	.wde_size17 = {RTW89_WDE_PG_64, 354, 30,},
 	/* 8852C DLFW */
 	.wde_size18 = {RTW89_WDE_PG_64, 0, 2048,},
 	/* 8852C PCIE SCC */
@@ -1666,6 +1668,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size23 = {RTW89_WDE_PG_64, 1022, 2,},
 	/* 8852B USB2.0/USB3.0 SCC */
 	.wde_size25 = {RTW89_WDE_PG_64, 162, 94,},
+	/* 8852C USB2.0 */
+	.wde_size31 = {RTW89_WDE_PG_64, 384, 0,},
 	/* PCIE */
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
 	.ple_size0_v1 = {RTW89_PLE_PG_128, 2688, 240, 212992,},
@@ -1677,6 +1681,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* DLFW */
 	.ple_size8 = {RTW89_PLE_PG_128, 64, 960,},
 	.ple_size9 = {RTW89_PLE_PG_128, 2288, 16,},
+	/* 8852C USB */
+	.ple_size17 = {RTW89_PLE_PG_128, 3368, 24,},
 	/* 8852C DLFW */
 	.ple_size18 = {RTW89_PLE_PG_128, 2544, 16,},
 	/* 8852C PCIE SCC */
@@ -1685,6 +1691,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size32 = {RTW89_PLE_PG_128, 620, 20,},
 	/* 8852B USB3.0 SCC */
 	.ple_size33 = {RTW89_PLE_PG_128, 632, 8,},
+	/* 8852C USB2.0 */
+	.ple_size34 = {RTW89_PLE_PG_128, 3374, 18,},
 	/* PCIE 64 */
 	.wde_qt0 = {3792, 196, 0, 107,},
 	.wde_qt0_v1 = {3302, 6, 0, 20,},
@@ -1694,6 +1702,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt6 = {448, 48, 0, 16,},
 	/* 8852B PCIE SCC */
 	.wde_qt7 = {446, 48, 0, 16,},
+	/* 8852C USB3.0 */
+	.wde_qt16 = {344, 2, 0, 8,},
 	/* 8852C DLFW */
 	.wde_qt17 = {0, 0, 0,  0,},
 	/* 8852C PCIE SCC */
@@ -1701,6 +1711,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt23 = {958, 48, 0, 16,},
 	/* 8852B USB2.0/USB3.0 SCC */
 	.wde_qt25 = {152, 2, 0, 8,},
+	/* 8852C USB2.0 */
+	.wde_qt31 = {338, 6, 0, 40,},
 	.ple_qt0 = {320, 320, 32, 16, 13, 13, 292, 292, 64, 18, 1, 4, 0,},
 	.ple_qt1 = {320, 320, 32, 16, 1316, 1316, 1595, 1595, 1367, 1321, 1, 1307, 0,},
 	/* PCIE SCC */
@@ -1712,6 +1724,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt13 = {0, 0, 16, 48, 0, 0, 0, 0, 0, 0, 0,},
 	/* PCIE 64 */
 	.ple_qt18 = {147, 0, 16, 20, 17, 13, 89, 0, 32, 14, 8, 0,},
+	/* USB 52C USB3.0 */
+	.ple_qt42 = {1068, 0, 16, 48, 4, 13, 178, 0, 16, 1, 8, 16, 0,},
+	/* USB 52C USB3.0 */
+	.ple_qt43 = {3068, 0, 32, 48, 4, 13, 178, 0, 16, 1, 8, 16, 0,},
 	/* DLFW 52C */
 	.ple_qt44 = {0, 0, 16, 256, 0, 0, 0, 0, 0, 0, 0, 0,},
 	/* DLFW 52C */
@@ -1731,6 +1747,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* USB3.0 52B 92K */
 	.ple_qt74 = {286, 0, 16, 48, 4, 13, 178, 0, 32, 14, 8, 0, 0,},
 	.ple_qt75 = {286, 0, 32, 48, 37, 13, 211, 0, 65, 14, 24, 0, 0,},
+	/* USB2.0 52C */
+	.ple_qt78 = {1560, 0, 16, 48, 13, 13, 390, 0, 32, 38, 8, 16, 0,},
+	/* USB2.0 52C */
+	.ple_qt79 = {1560, 0, 32, 48, 1253, 13, 1630, 0, 1272, 38, 120, 1256, 0,},
 	/* 8852A PCIE WOW */
 	.ple_qt_52a_wow = {264, 0, 32, 20, 64, 13, 1005, 0, 64, 128, 120,},
 	/* 8852B PCIE WOW */
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 134734dbb231..675cd05e0b49 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -923,10 +923,12 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size wde_size6;
 	const struct rtw89_dle_size wde_size7;
 	const struct rtw89_dle_size wde_size9;
+	const struct rtw89_dle_size wde_size17;
 	const struct rtw89_dle_size wde_size18;
 	const struct rtw89_dle_size wde_size19;
 	const struct rtw89_dle_size wde_size23;
 	const struct rtw89_dle_size wde_size25;
+	const struct rtw89_dle_size wde_size31;
 	const struct rtw89_dle_size ple_size0;
 	const struct rtw89_dle_size ple_size0_v1;
 	const struct rtw89_dle_size ple_size3_v1;
@@ -934,19 +936,23 @@ struct rtw89_mac_size_set {
 	const struct rtw89_dle_size ple_size6;
 	const struct rtw89_dle_size ple_size8;
 	const struct rtw89_dle_size ple_size9;
+	const struct rtw89_dle_size ple_size17;
 	const struct rtw89_dle_size ple_size18;
 	const struct rtw89_dle_size ple_size19;
 	const struct rtw89_dle_size ple_size32;
 	const struct rtw89_dle_size ple_size33;
+	const struct rtw89_dle_size ple_size34;
 	const struct rtw89_wde_quota wde_qt0;
 	const struct rtw89_wde_quota wde_qt0_v1;
 	const struct rtw89_wde_quota wde_qt4;
 	const struct rtw89_wde_quota wde_qt6;
 	const struct rtw89_wde_quota wde_qt7;
+	const struct rtw89_wde_quota wde_qt16;
 	const struct rtw89_wde_quota wde_qt17;
 	const struct rtw89_wde_quota wde_qt18;
 	const struct rtw89_wde_quota wde_qt23;
 	const struct rtw89_wde_quota wde_qt25;
+	const struct rtw89_wde_quota wde_qt31;
 	const struct rtw89_ple_quota ple_qt0;
 	const struct rtw89_ple_quota ple_qt1;
 	const struct rtw89_ple_quota ple_qt4;
@@ -954,6 +960,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt9;
 	const struct rtw89_ple_quota ple_qt13;
 	const struct rtw89_ple_quota ple_qt18;
+	const struct rtw89_ple_quota ple_qt42;
+	const struct rtw89_ple_quota ple_qt43;
 	const struct rtw89_ple_quota ple_qt44;
 	const struct rtw89_ple_quota ple_qt45;
 	const struct rtw89_ple_quota ple_qt46;
@@ -965,6 +973,8 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt73;
 	const struct rtw89_ple_quota ple_qt74;
 	const struct rtw89_ple_quota ple_qt75;
+	const struct rtw89_ple_quota ple_qt78;
+	const struct rtw89_ple_quota ple_qt79;
 	const struct rtw89_ple_quota ple_qt_52a_wow;
 	const struct rtw89_ple_quota ple_qt_52b_wow;
 	const struct rtw89_ple_quota ple_qt_52bt_wow;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 49fdcb9aebb5..5e58bab5d39f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -64,6 +64,32 @@ static const struct rtw89_dle_mem rtw8852c_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static const struct rtw89_dle_mem rtw8852c_dle_mem_usb2[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size31,
+			   &rtw89_mac_size.ple_size34, &rtw89_mac_size.wde_qt31,
+			   &rtw89_mac_size.wde_qt31, &rtw89_mac_size.ple_qt78,
+			   &rtw89_mac_size.ple_qt79},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size18,
+			    &rtw89_mac_size.ple_size18, &rtw89_mac_size.wde_qt17,
+			    &rtw89_mac_size.wde_qt17, &rtw89_mac_size.ple_qt44,
+			    &rtw89_mac_size.ple_qt45},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
+static const struct rtw89_dle_mem rtw8852c_dle_mem_usb3[] = {
+	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size17,
+			   &rtw89_mac_size.ple_size17, &rtw89_mac_size.wde_qt16,
+			   &rtw89_mac_size.wde_qt16, &rtw89_mac_size.ple_qt42,
+			   &rtw89_mac_size.ple_qt43},
+	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size18,
+			    &rtw89_mac_size.ple_size18, &rtw89_mac_size.wde_qt17,
+			    &rtw89_mac_size.wde_qt17, &rtw89_mac_size.ple_qt44,
+			    &rtw89_mac_size.ple_qt45},
+	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
+			       NULL},
+};
+
 static const u32 rtw8852c_h2c_regs[RTW89_H2CREG_MAX] = {
 	R_AX_H2CREG_DATA0_V1, R_AX_H2CREG_DATA1_V1, R_AX_H2CREG_DATA2_V1,
 	R_AX_H2CREG_DATA3_V1
@@ -3023,7 +3049,10 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
 	.hfc_param_ini		= {rtw8852c_hfc_param_ini_pcie, NULL, NULL},
-	.dle_mem		= {rtw8852c_dle_mem_pcie, NULL, NULL, NULL},
+	.dle_mem		= {rtw8852c_dle_mem_pcie,
+				   rtw8852c_dle_mem_usb2,
+				   rtw8852c_dle_mem_usb3,
+				   NULL},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xe000, 0xf000},
-- 
2.50.0



Return-Path: <linux-wireless+bounces-26714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4079B38811
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C514461C84
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150622D0606;
	Wed, 27 Aug 2025 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndZ2LQAO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142352C0267
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313696; cv=none; b=P24Y3eVsRjiX+TZGSVDabFjhdJefWQYpeTZStDBl1tXFFHmpc/xrFAJIYZgBkZwqQ0oNdQb+DKUK0ZBg3eo6b56wf6SyFXuTPdjFrDU1NMu+DYUGYFRTKetZLrYhD9eGUWnRcQUaCxgwLcCIE7sqJtEcZ2LaDs5NEwphOFkPHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313696; c=relaxed/simple;
	bh=fvW+4Rz8piVd+AKF0XEml8n9YBjijAak79k75wAx3ZA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F8ROcA2aJV01uGBII8pvOrmwYgd2XqOBan2cqi+cncmPHQA6ZHjDFf7cADzvwB3AxdqinA5ZG7FUOLKfCUSBZivef4UEbn9FexHGBjrdgogl6rQb8kadpypafCrTvk2xkowTCXSg7pihJn0JrQrfus4y8SEnQOoaGaVA7U+NFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndZ2LQAO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so127575e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313692; x=1756918492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T4aEhaWZnIMn2V12If8SeukDF+EBcWdviRXD4kevYTk=;
        b=ndZ2LQAO7L/zlsZb2Z6CSIpsxTyJTJ5zoP0XVCOaKZCAlXRSCgBUwMSZbV0E8LzF7k
         kD0iNp+UkUWrKVyzacWLzgrQ5z50d8l01jVSgoXCQ+g1rOT4YwTPFNI3vmatjDt4nK9/
         AAcMSb7YZk5oNH18Q/5veSvLeJnXC/eFqiK8ByV8lQCaBycDAcUa2MQm/IVeiiC8I3xo
         7MV+4u9zrCztCND6/zV1awTZvemmSpkPGl73ngqIZPGSBQG5e0wDkQ13MrYeXk3eG7Bf
         fPmZPUC/VgKSAJeEFShm7fkPolxw15SIJmeFtz+nonj8PbJwUTm5FIftt9rX0rwyvCd0
         CVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313692; x=1756918492;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4aEhaWZnIMn2V12If8SeukDF+EBcWdviRXD4kevYTk=;
        b=vnPOcjL5j0Mx7sgiPeKzOecFB8G12HN9TPtubQnh9sEID/fIkE0UF2stv01N0pMfqk
         U++kGT0EQ7T6nqJ8RAgtq3Hyx1pF6KPZaqfn6qywSexdQFAiUBQrGiuhl4Cjd3ZAO3lU
         1xl6BK+TY+203Hd8baDW6sHlijSD6sM7NW0ZHOOWoMSCIxEIRuSHzLF+oF0jSpEpirF3
         z2ycbqGD8gcdKhw18gnbuDecrICd34JsWbXOUuFFDG6SclgDpJv4Vj6zzglMjPxVaUr/
         CN9/YaA+sM0qZrBJntFf4zLK+6A6YJu+A6nI7Ns7mMu+vftjTQvohmMxoDogpnNBEAV6
         +baA==
X-Gm-Message-State: AOJu0YwVOTcwemBRGIF0KU79uarFPtPC4hQg25nxc1sVDRDhaB/k08p4
	iN8NgSpb/JkZhwI5+GfdMVfTaP3FV11+plpl7+Ezxp4B0R5CzrwUnhhGrnPe2Q==
X-Gm-Gg: ASbGncsrHxzJhPiKUeXlR6a394ru/zaCxp2D5J+Ejp3+pUKBH0oH4sk6KBDPj/KALzI
	L+rSY2gNQdjPm0NNck+OROIwW6JbSzdZX3cm0QgRGRJUl5pYg1u/Fq1bNzW4XC323DpaO6wduv/
	9ev75hVjjKLLmSeKdPTqCYlpK4/uDe/Z9l4r5z9od802LY220bozovYTD4h5a+Q6NDJw6Kv9FYk
	oBaxegC64kDkhTTRhHVHj1p9AACb5ATOm6+qH1agjqlA6FhwC1+Xcw/Jk8BY9QFNKnYIHny005F
	hTW6vWcnq0Qf+PyZfKBP4qWR1a3zl40iDsoHPHpeBQH+R8L4bqTGkpZzRQHLgDv/5viEtf8efQn
	I17XUKKoLZS03xS3qVB6OMIHaFm/gFA==
X-Google-Smtp-Source: AGHT+IGmWSeTsxv3+549bpWlTSTlrY+hBjU7zYqKLTYdcVakoGLxxt8HFyK1FKdWaehJLPoTt9wlIQ==
X-Received: by 2002:a05:600c:1d25:b0:45b:72a9:28b0 with SMTP id 5b1f17b1804b1-45b7507c42emr8900235e9.28.1756313691974;
        Wed, 27 Aug 2025 09:54:51 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ccac1b892bsm3601937f8f.67.2025.08.27.09.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:54:51 -0700 (PDT)
Message-ID: <0d465848-a633-4916-b778-2dec141422e8@gmail.com>
Date: Wed, 27 Aug 2025 19:54:50 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 07/11] wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add rtw8852c_dle_mem_usb2 and rtw8852c_dle_mem_usb3 and their various
quotas and sizes in struct rtw89_mac_size_set.

"dle" could be "Data Link Engine" or "Double Link Engine". These are
some parameters needed for RTL8852CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 20 ++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      | 10 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 31 ++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6c2de561ddcc..2def8c4a190d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1660,6 +1660,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size7 = {RTW89_WDE_PG_64, 510, 2,},
 	/* DLFW */
 	.wde_size9 = {RTW89_WDE_PG_64, 0, 1024,},
+	/* 8852C USB3.0 */
+	.wde_size17 = {RTW89_WDE_PG_64, 354, 30,},
 	/* 8852C DLFW */
 	.wde_size18 = {RTW89_WDE_PG_64, 0, 2048,},
 	/* 8852C PCIE SCC */
@@ -1667,6 +1669,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size23 = {RTW89_WDE_PG_64, 1022, 2,},
 	/* 8852B USB2.0/USB3.0 SCC */
 	.wde_size25 = {RTW89_WDE_PG_64, 162, 94,},
+	/* 8852C USB2.0 */
+	.wde_size31 = {RTW89_WDE_PG_64, 384, 0,},
 	/* PCIE */
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
 	.ple_size0_v1 = {RTW89_PLE_PG_128, 2688, 240, 212992,},
@@ -1678,6 +1682,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* DLFW */
 	.ple_size8 = {RTW89_PLE_PG_128, 64, 960,},
 	.ple_size9 = {RTW89_PLE_PG_128, 2288, 16,},
+	/* 8852C USB */
+	.ple_size17 = {RTW89_PLE_PG_128, 3368, 24,},
 	/* 8852C DLFW */
 	.ple_size18 = {RTW89_PLE_PG_128, 2544, 16,},
 	/* 8852C PCIE SCC */
@@ -1686,6 +1692,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size32 = {RTW89_PLE_PG_128, 620, 20,},
 	/* 8852B USB3.0 SCC */
 	.ple_size33 = {RTW89_PLE_PG_128, 632, 8,},
+	/* 8852C USB2.0 */
+	.ple_size34 = {RTW89_PLE_PG_128, 3374, 18,},
 	/* PCIE 64 */
 	.wde_qt0 = {3792, 196, 0, 107,},
 	.wde_qt0_v1 = {3302, 6, 0, 20,},
@@ -1695,6 +1703,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt6 = {448, 48, 0, 16,},
 	/* 8852B PCIE SCC */
 	.wde_qt7 = {446, 48, 0, 16,},
+	/* 8852C USB3.0 */
+	.wde_qt16 = {344, 2, 0, 8,},
 	/* 8852C DLFW */
 	.wde_qt17 = {0, 0, 0,  0,},
 	/* 8852C PCIE SCC */
@@ -1702,6 +1712,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt23 = {958, 48, 0, 16,},
 	/* 8852B USB2.0/USB3.0 SCC */
 	.wde_qt25 = {152, 2, 0, 8,},
+	/* 8852C USB2.0 */
+	.wde_qt31 = {338, 6, 0, 40,},
 	.ple_qt0 = {320, 320, 32, 16, 13, 13, 292, 292, 64, 18, 1, 4, 0,},
 	.ple_qt1 = {320, 320, 32, 16, 1316, 1316, 1595, 1595, 1367, 1321, 1, 1307, 0,},
 	/* PCIE SCC */
@@ -1713,6 +1725,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
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
@@ -1732,6 +1748,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
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
index 25fe5e5c8a97..46302f4aa3d9 100644
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
index 6aedbd03e3d4..651ef96d143a 100644
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
@@ -3026,7 +3052,10 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
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
2.50.1



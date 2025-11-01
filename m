Return-Path: <linux-wireless+bounces-28464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A7C28641
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 957474E46D8
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214E256C88;
	Sat,  1 Nov 2025 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFHgVEVc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CC38FA3
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025147; cv=none; b=hu+zcH04GIrrYOYr9rjTM817ONMipQzFV7ivmXQUwYllxL6pmvMBUpcnIUiNYWSu6lcOgrgsw3iPgVJ2V+Xbqy2CcArLv5TYJDf4i8n6b1mQlprKL9AibcERR2Sa+sylzxSv70AssQBER1+Y7T6Y0XH/EVd8PeX6GWo82/8AEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025147; c=relaxed/simple;
	bh=T5IiVrBFIcdN97qY9MaXNoncFWFePLpR+2XhvO5s41g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NgWmzH4e/S33CEgkxFrR2JWxGtJ1cpJKIycp+H9x9c/25xwIS5l+X6iyTjywwJdofl80pePd88I981zkB/Ro3/mLDUTZXpQi6SGKl9BC5fBrhqpAKO+1xoVGuvhTL7S7Z2mvl7++Lfa+xRwDmhoSNzXP/I7EQ1WHkO6eklwqu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFHgVEVc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso28301915e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762025144; x=1762629944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Fq4Lq0Y/by/F50Cv1w+uvBuy5YJgrTqVQZ2SfRnxWs=;
        b=RFHgVEVcewlC/lXRaQ01UYZEtvm4f80J9qXmOpx5Sx1ajf6vgn8L9vUPi7NFB6TxjX
         5z5Tm9+WbpNMn5owXtBW5DzcwNaWFBrI/jyKVFf15Vd4z+n3QhMBPXa+k69p1P+jyfWX
         Tmg/DKzDiXl6ZwOifsHFyAuyiFQdwIk2W3QJSKRhM1KW6apogGrZ2K3VQkWTn0z33ZBd
         WG1BTmga0YJXN4wSNHUNqlIifyYvn4nuk8b/nRTueoq9VVKB0FCqm3hkgjgcBEmNp2r7
         /6qVyJ0lwNPPVNMh23NNASeAU3WY6L7bOnhANyCZjHwILrUmLLvbP1WGnq0qbwogaqds
         GhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762025144; x=1762629944;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Fq4Lq0Y/by/F50Cv1w+uvBuy5YJgrTqVQZ2SfRnxWs=;
        b=OiCdIW7oHaVLF3naGailCvIIyV8Cv6qvPxRtqt0seJcWjcCol2M4twVQQAfm7RE5SM
         cZVRa8ygvwm4e4HRGODIiQw7nobcFO882v508e1fYtp08O5aWJmr7W2E3HHh4G1AAiZC
         aEpOHPz41z6cD/zxH2SkGIBkln7dPbbTYrNzwvSsavecM0FkHYNFuXrdy+4GlD3JZSuE
         6/GYvhZFWtCZleHqdTf7USESjOCcRT0nY7ivoZDXnpJGzTCR4gXcw0CXJ26iJ3oHZyWG
         gNwZY1JSbZsB3MoJ5oIjbtsMs+Uk+yD4cUy6j9nNFLESfjPxUHuPedX1BhmZsjp9PM1f
         ao0g==
X-Gm-Message-State: AOJu0YwbMMY56WrSieLDbME5C+io8C2QYadCQmrtYFGO2L/zx5yt7U26
	3QEUKMFDJqFRdwfpXbq8U+YkclBgtNhFkUifsZ3rLldK078jcBNOzDyG4NY1zw==
X-Gm-Gg: ASbGnctPDRHrLZL740HwFksAd2AdINGtNEXzmSOrc5flcvtet2FJMlqBiPp5MYDnW7E
	WfTATG9WNE27aP8kqXSp6r+vINEEsA2gOTInMEkfT0MqEtzYqjlNzo/YRIEc92rzBwsG+4gMh9e
	u19LXcNUJ3HtRpCtwDUZ+9lKZ9buozCRGrK/fRrUPrWhPbgMMfrxLy4/ZNf7Bdp4OdT7eoaEUL0
	+0Z2dpDX6b05YpLPEMMZ8MknYALGvuk38Ekp5fJ8mlWt2NMHq/XzLskBp5dWrnRUre7fssLStGm
	SgbyB1D3pdfgu+BbXldHvZPqzNEinXmsXA8fc1nlJA4Sv+9ye2ZJCAhXdP3YcmRh9c4jGiTwn1E
	odtIAz9I61mIXc6strwL1aPhzCuNRAwkfsu9++lfL7tjHtamAr3FeMCRR6409mgd9CEjURQ1aiY
	OSx2sU44y8
X-Google-Smtp-Source: AGHT+IEIGcZa5v429ZZUai9zajVKT6Zt7a1LRpWJo59T8bXH8ESIAO3JSlDmZt+yqwXExlpqjj2F6g==
X-Received: by 2002:a05:600c:1f0e:b0:471:9b5:6fd3 with SMTP id 5b1f17b1804b1-477302e4b74mr63811875e9.0.1762025143524;
        Sat, 01 Nov 2025 12:25:43 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1c9esm10761137f8f.22.2025.11.01.12.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:25:43 -0700 (PDT)
Message-ID: <40a58644-13ce-48a4-85e2-ba4f3cbb975b@gmail.com>
Date: Sat, 1 Nov 2025 21:25:41 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 08/12] wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
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

v4:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/mac.c      | 20 ++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      | 10 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 31 ++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b5309ae3fd57..bc39b4f7bc4f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1663,6 +1663,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size7 = {RTW89_WDE_PG_64, 510, 2,},
 	/* DLFW */
 	.wde_size9 = {RTW89_WDE_PG_64, 0, 1024,},
+	/* 8852C USB3.0 */
+	.wde_size17 = {RTW89_WDE_PG_64, 354, 30,},
 	/* 8852C DLFW */
 	.wde_size18 = {RTW89_WDE_PG_64, 0, 2048,},
 	/* 8852C PCIE SCC */
@@ -1670,6 +1672,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_size23 = {RTW89_WDE_PG_64, 1022, 2,},
 	/* 8852B USB2.0/USB3.0 SCC */
 	.wde_size25 = {RTW89_WDE_PG_64, 162, 94,},
+	/* 8852C USB2.0 */
+	.wde_size31 = {RTW89_WDE_PG_64, 384, 0,},
 	/* PCIE */
 	.ple_size0 = {RTW89_PLE_PG_128, 1520, 16,},
 	.ple_size0_v1 = {RTW89_PLE_PG_128, 2688, 240, 212992,},
@@ -1681,6 +1685,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	/* DLFW */
 	.ple_size8 = {RTW89_PLE_PG_128, 64, 960,},
 	.ple_size9 = {RTW89_PLE_PG_128, 2288, 16,},
+	/* 8852C USB */
+	.ple_size17 = {RTW89_PLE_PG_128, 3368, 24,},
 	/* 8852C DLFW */
 	.ple_size18 = {RTW89_PLE_PG_128, 2544, 16,},
 	/* 8852C PCIE SCC */
@@ -1689,6 +1695,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_size32 = {RTW89_PLE_PG_128, 620, 20,},
 	/* 8852B USB3.0 SCC */
 	.ple_size33 = {RTW89_PLE_PG_128, 632, 8,},
+	/* 8852C USB2.0 */
+	.ple_size34 = {RTW89_PLE_PG_128, 3374, 18,},
 	/* PCIE 64 */
 	.wde_qt0 = {3792, 196, 0, 107,},
 	.wde_qt0_v1 = {3302, 6, 0, 20,},
@@ -1698,6 +1706,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt6 = {448, 48, 0, 16,},
 	/* 8852B PCIE SCC */
 	.wde_qt7 = {446, 48, 0, 16,},
+	/* 8852C USB3.0 */
+	.wde_qt16 = {344, 2, 0, 8,},
 	/* 8852C DLFW */
 	.wde_qt17 = {0, 0, 0,  0,},
 	/* 8852C PCIE SCC */
@@ -1705,6 +1715,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.wde_qt23 = {958, 48, 0, 16,},
 	/* 8852B USB2.0/USB3.0 SCC */
 	.wde_qt25 = {152, 2, 0, 8,},
+	/* 8852C USB2.0 */
+	.wde_qt31 = {338, 6, 0, 40,},
 	.ple_qt0 = {320, 320, 32, 16, 13, 13, 292, 292, 64, 18, 1, 4, 0,},
 	.ple_qt1 = {320, 320, 32, 16, 1316, 1316, 1595, 1595, 1367, 1321, 1, 1307, 0,},
 	/* PCIE SCC */
@@ -1716,6 +1728,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
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
@@ -1735,6 +1751,10 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
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
2.51.1



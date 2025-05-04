Return-Path: <linux-wireless+bounces-22406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA0AA8943
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B813AFF21
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F03224CC;
	Sun,  4 May 2025 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDwP1M53"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390FC2FD
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746391803; cv=none; b=KhWVSHmExgjNGbcCIDbRMv4BWUPa6+wBdJNY+Ps892TRzqwqrqjCIs5L3TjpKA/uhjpjE6knax4GXj26KyH+yJlAjj9QAVPzGiBItJcyWnJEeWoKZ0PCJ1KrqRLQEs8UJN5mIKipt9R08NNBgMEH0IbnyrGHogCCiF6GH6vPDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746391803; c=relaxed/simple;
	bh=A+71qUb8nnLkTblksHTUeMLYTnI5KbZH4b2J6DsL4no=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G0l0+E+NoONYKGtcfQj50miAOxKdrGjt+oit3nuyKGDNYDN054FapdMuWxcJILBBSyBHTTL65xtuY57AxAx2ERt3nEmCaAvYdFeygIl+GxcLs1gFN8sp3oiH8MIVo9FInlCiwBUceTwR69WQisMCcGiUP7XEeXe0WplipDRnpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDwP1M53; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f4d28d9fd8so5139034a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746391799; x=1746996599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E02GUsLQMda45q4Vav80uP/RQcdSm7e7PcywZ5KrRAo=;
        b=VDwP1M53itHRl8GtoPhIhBX0OMnTumNgTKLxJ4qojkfq3X5a1T22j5GMjI3U050f2C
         M5JNSDjT5v8F8f0KSPn06fHHOgFF2QTCgSQJkceRlkNgySdHOPllcOR5J85avKuc0IiN
         1v2RNaAATH9nau0cnbo4z/lXZIDmtKNhTwnx9Obizspw6cGfPRu/0b6Ixkt64J9EpJAz
         tZ7mpLETfC5w25DctCyFT/r+4NJFVHUSebNehNkt+fEHa88DuurhxHkQ1NXJxmAK7EeJ
         Ls1Qrtn8TljUv7cVpFqI2XeVuUjFTmQlwnjfj3RteXnoz9BmiHJO9ED4mh9yyybr6ZPe
         bEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746391799; x=1746996599;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E02GUsLQMda45q4Vav80uP/RQcdSm7e7PcywZ5KrRAo=;
        b=t/Gn4RBzU0P1Yr39K3JP1yAnjY981HNlkz30S0EIPcnAET3c+xeTzt7JdlwknMzmIF
         1NZBM6kDevLgzeaEtcnxZK4Tzchf2vubzY+1y7KLPUe8WQUCQei5ICZwfDYW+qOLV6OT
         HmzZUwdSLZjlQd4irbhIEugfyJJbFUGydmSMH8hycKlqXba8PLVuAiOQTVv7UPl9rLAI
         XUW8ZbgEjJFeC7ENtNdCTj4RFH8T5dQZfoTL1PuByxjH0X1RA1ZcghquWZlTYdaiFW+B
         B2HxMe4ri3CNK2VxskSQfSS7RPqbW3V1XduVfVar+xcTC3yrngVV9zz0raEfuxnTRuoF
         pEWQ==
X-Gm-Message-State: AOJu0Yz8q7hH+2hKSCLlZDwu2ysF1WcT9EsghuqIzo7PpL1VLwPEUCZV
	E4f6yWo31mc/FjGQtGbK0zVaPh3h9FKBKoeULtx8cf3VkGvnA1HlGHAKgQ==
X-Gm-Gg: ASbGncvPk8P8mdXgKPmsOoI5UmabHbL6CC6FsH9E2IuFOAFqIJCPeladQDaEseJSX0A
	0gqMremoY1gxLlimJ7bXaXz4HiUQI1TL6TZ6RyWJWKRsDdNi5XFY8qO35YCWMLTjE3TuWX1TJSe
	MOxdGvx/kB2KmETmaMmdpiIj8bdY9xWFzP+ubMys/b4D5YQa45+eOeuhd9L1E6r95TyvKW/XW0/
	zfx5ucJ/T4nfOkH+orED9rw75uq+kaTwDpRviYXXVXclCWkjDofDavJ3J6tyKYmkq1XXb3D/TFO
	Ud52yaGK6rFZEheMyG0wz85gpZJ41vFPbg2FB8jHzl8f4MNyRA==
X-Google-Smtp-Source: AGHT+IHQFAnHcawEyr4uEq23Yh0Aeeh/Hs2fRgD0lWRLrSEIC7zQVivPq2+pYbiNeaMGW4yLSYQdWw==
X-Received: by 2002:a05:6402:40cf:b0:5f9:3174:dcbf with SMTP id 4fb4d7f45d1cf-5fab05e286bmr3879141a12.32.1746391799324;
        Sun, 04 May 2025 13:49:59 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa777557c4sm4275635a12.15.2025.05.04.13.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:49:58 -0700 (PDT)
Message-ID: <26968663-f928-4479-bfbc-8e9e3195f27a@gmail.com>
Date: Sun, 4 May 2025 23:49:58 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 03/13] wifi: rtw89: Rename hfc_param_ini to
 hfc_param_ini_pcie
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Rename hfc_param_ini in struct rtw89_chip_info to hfc_param_ini_pcie.
USB and SDIO will need different sets of values.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.h      | 2 +-
 drivers/net/wireless/realtek/rtw89/mac.c       | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index afcf0353a625..321de0f76026 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4272,7 +4272,7 @@ struct rtw89_chip_info {
 	u16 max_amsdu_limit;
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
-	const struct rtw89_hfc_param_ini *hfc_param_ini;
+	const struct rtw89_hfc_param_ini *hfc_param_ini_pcie;
 	const struct rtw89_dle_mem *dle_mem_pcie;
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 77d35db3e133..a52de0af605e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -881,7 +881,7 @@ static int hfc_reset_param(struct rtw89_dev *rtwdev)
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
-		param_ini = rtwdev->chip->hfc_param_ini[qta_mode];
+		param_ini = rtwdev->chip->hfc_param_ini_pcie[qta_mode];
 		param->en = 0;
 		break;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 1295718b8fdc..8d5ee870617c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2464,7 +2464,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
-	.hfc_param_ini		= rtw8851b_hfc_param_ini_pcie,
+	.hfc_param_ini_pcie	= rtw8851b_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8851b_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 5e9e2fc09458..efa944a66976 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2183,7 +2183,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= rtw8852a_hfc_param_ini_pcie,
+	.hfc_param_ini_pcie	= rtw8852a_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8852a_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index badaea9d4cb8..b157fb831479 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -819,7 +819,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.max_amsdu_limit	= 5000,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
-	.hfc_param_ini		= rtw8852b_hfc_param_ini_pcie,
+	.hfc_param_ini_pcie	= rtw8852b_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8852b_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 74619361e29b..78abe49a6034 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -753,7 +753,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.max_amsdu_limit	= 5000,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= rtw8852bt_hfc_param_ini_pcie,
+	.hfc_param_ini_pcie	= rtw8852bt_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8852bt_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8b049c3ace93..cdabfe6acd72 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3003,7 +3003,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.max_amsdu_limit	= 8000,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= rtw8852c_hfc_param_ini_pcie,
+	.hfc_param_ini_pcie	= rtw8852c_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8852c_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 505f45595dc8..0fce7219246d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2815,7 +2815,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.max_amsdu_limit	= 8000,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
-	.hfc_param_ini		= rtw8922a_hfc_param_ini_pcie,
+	.hfc_param_ini_pcie	= rtw8922a_hfc_param_ini_pcie,
 	.dle_mem_pcie		= rtw8922a_dle_mem_pcie,
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
-- 
2.49.0



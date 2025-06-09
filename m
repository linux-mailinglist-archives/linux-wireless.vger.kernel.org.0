Return-Path: <linux-wireless+bounces-23894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C7AD26B5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132323A5278
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6721C18C;
	Mon,  9 Jun 2025 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6ldm5Yq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B519258E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497140; cv=none; b=mm6xh4m9zpa5RxXRqvZjMPgcrZEpCGqt0hnfwmQRZPJqaSEFnGy3ZqVjHoI1hI2HiiBgUs5Q5aRwqO4ABo6tk0mVSQFLh4ecDeA/SLKhCML8rCKFv4IVDX3qFcq3rWya1J3ESrSaVVPzkMWBNLHFDZyAekMKqXyodXoBuEA56G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497140; c=relaxed/simple;
	bh=PBBKomSB0JM8VcMg+/7xoxo12Bd5Rw2ngawstZF5BdQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=i1szmmXWp99U33k+mrJB3CLrOv9VApBlSGOX9xDUAJ5qVNU1HRV5La+/DpDNCkQ2j3BxtG6YnrcC96nfnEovI2NmzBsp3OW/QDvUjnGTiUxeHkszV5sojRyUvuOYoxGKhWHGXpKsZqaZGi/w0uC5qQTjlPs/YafwnsLwLUl4nsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6ldm5Yq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so9071085a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497136; x=1750101936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V+2TTKvfqQHpJ9haiPqd4pFvaJd/g5ULfGevsQbQgHg=;
        b=A6ldm5YqiZflz5CzZcUpC+m/xxfqYRpvdETv+e34FYXUCaNBlbrIOA9aQOW1vgEg/M
         zRJSqTk024VALK7s1ll5/mFdMScNLpCo2ApvD2AWJ6YhMsE3wBE4God2FsG7mfx5UNWx
         aB6kkGeA6BU1wjS3H1lBoNEH8R3TMDGVWGKlNjomoBDNDuAak5QN0c3oRhI6ojWCE1LU
         lmr7bLpmCFpRLtK3FptwWSU+Rs8jCFLeap5H3InvpNlF+P36+FUeilZFze6HX5BWwo8p
         BbTXsTys25HQCOeCQGh57tpI5JwDSDXqk+FUXy0OYL64QEbL2kxPvT4hgu89R1BPyM6d
         Ns1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497136; x=1750101936;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+2TTKvfqQHpJ9haiPqd4pFvaJd/g5ULfGevsQbQgHg=;
        b=V9KyCtjHz7UWSgOo/7CW9HIQEThAJ8cxwsvErUF/M8j8I7/6MfaqsTA+0ze8PqdKoa
         rI3RrXRrk2QVigyuUILSVSEchZkWdO6ppKehbYQIX2mlGs33tAKYuuTILgqiq6bREflm
         VZVm6B7FXBegkrhxDSZQv44gY5nvUXcdL7UEgE9zK/aBuqvbvqnNDFDONyxaQOvuKtzp
         eKneyXKjbbtu62oE/d2bAHmx2fxZRldwPAdIh3lLygLdrk84FGpdBDUiLQ8v8NHmpVfI
         MjfU7OjJCp1x2Wgswf2r5aATppEmoLXcqWT9gBbmgiFpmaZF078rieJ43Nw/fgVXvB8Q
         eepg==
X-Gm-Message-State: AOJu0YxS5td/e6epmqXdEUojAq0mC8DMndOnhqkfQrJzFR0vAstnfqQ9
	859zzeY4YuZAELGlg2KB/2lV4okpZpt3heOhakwcGxAfPruqQGgdy3u2xlNW+A==
X-Gm-Gg: ASbGncu25YsDSX5wnTg2QrWsXvOI0oYxy3elCapM2p/K6SB4yzMhaHg6/UNEq9LnUR7
	j13yIVzlruBWt3PGLuWug14i07L7JiFlXxegYSY2mPViCmCgib/Oqdiw8taoyzYh0W/1WXj6WbR
	PeKXD6AwWBCz5A9icsa3H5GY+7coppPuRPXnVMFF9zIMtasldcerj+BEH5FgYN1odbrm5fVXaAg
	wmmY5+/Gx3w458NKjk1QT+os3+fTdKOlwM3iW1d8RZLSpgX891g0Uo0mf37EfIozSl0GjJ/pCBH
	/ZD1q7ZxlgmaGBX3rrjYxyzMeRv5+MZbfQgwace0+3vW09aSgj/l5SEpA24=
X-Google-Smtp-Source: AGHT+IH8PyU/iw3sqSrUH2VIH+uKWj0YonXxVWsvVZ+l2p7xP73zHPtGZ/sHyYaM8ikQDxkZAdeT6Q==
X-Received: by 2002:a05:6402:280f:b0:607:fbf8:669c with SMTP id 4fb4d7f45d1cf-607fbf86ee5mr3495131a12.0.1749497136145;
        Mon, 09 Jun 2025 12:25:36 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783e66e6sm4992168a12.81.2025.06.09.12.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:25:35 -0700 (PDT)
Message-ID: <7e05e8a7-d7cd-4cc2-87c5-143ba30e8c54@gmail.com>
Date: Mon, 9 Jun 2025 22:25:34 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 03/14] wifi: rtw89: Make hfc_param_ini in
 rtw89_chip_info an array
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

USB and SDIO will need different sets of values, so make hfc_param_ini
in struct rtw89_chip_info an array.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Make hfc_param_ini an array instead of having (eventually) three
   different hfc_param_ini_* members.
---
 drivers/net/wireless/realtek/rtw89/core.h      | 4 +++-
 drivers/net/wireless/realtek/rtw89/mac.c       | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 2 +-
 8 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 12d5727abfe9..d4c7b47c3ba6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -130,6 +130,8 @@ enum rtw89_hci_type {
 	RTW89_HCI_TYPE_PCIE,
 	RTW89_HCI_TYPE_USB,
 	RTW89_HCI_TYPE_SDIO,
+
+	RTW89_HCI_TYPE_NUM,
 };
 
 enum rtw89_hci_dle_type {
@@ -4302,7 +4304,7 @@ struct rtw89_chip_info {
 	u16 max_amsdu_limit;
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
-	const struct rtw89_hfc_param_ini *hfc_param_ini;
+	const struct rtw89_hfc_param_ini *hfc_param_ini[RTW89_HCI_TYPE_NUM];
 	const struct rtw89_dle_mem *dle_mem[RTW89_HCI_DLE_TYPE_NUM];
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2ee766e37322..0a3603f2e6bf 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -881,13 +881,14 @@ static int hfc_reset_param(struct rtw89_dev *rtwdev)
 
 	switch (rtwdev->hci.type) {
 	case RTW89_HCI_TYPE_PCIE:
-		param_ini = rtwdev->chip->hfc_param_ini[qta_mode];
-		param->en = 0;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	param_ini = rtwdev->chip->hfc_param_ini[rtwdev->hci.type][qta_mode];
+	param->en = 0;
+
 	if (param_ini.pub_cfg)
 		param->pub_cfg = *param_ini.pub_cfg;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index f0755afb1fdc..b825b1b4ad9f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2464,7 +2464,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
-	.hfc_param_ini		= rtw8851b_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8851b_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8851b_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 7c631ccee8fc..4285af5c9ad4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2183,7 +2183,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= rtw8852a_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8852a_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8852a_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index a2dfdc541ce6..aff87cc9bffe 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -819,7 +819,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.max_amsdu_limit	= 5000,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x2f800,
-	.hfc_param_ini		= rtw8852b_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8852b_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8852b_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 96800ccdedc6..e13d6beb9aa3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -753,7 +753,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.max_amsdu_limit	= 5000,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= rtw8852bt_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8852bt_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8852bt_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 5210f2f9124b..f419e6ace39d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3003,7 +3003,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.max_amsdu_limit	= 8000,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
-	.hfc_param_ini		= rtw8852c_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8852c_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8852c_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 0517f0d27a5c..780d449a2140 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2816,7 +2816,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.max_amsdu_limit	= 8000,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x8f800,
-	.hfc_param_ini		= rtw8922a_hfc_param_ini_pcie,
+	.hfc_param_ini		= {rtw8922a_hfc_param_ini_pcie, NULL, NULL},
 	.dle_mem		= {rtw8922a_dle_mem_pcie, NULL, NULL, NULL},
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
-- 
2.49.0



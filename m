Return-Path: <linux-wireless+bounces-18967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD800A370F5
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 23:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC7616E6B2
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 22:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DD3153803;
	Sat, 15 Feb 2025 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYSpJVxc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E6DF59
	for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739656909; cv=none; b=jvD28wjyaJDpRCjj4HL4usAwzGDqcCNiAOKgjpzCCSaX6eObKI8iGdhg6Cd2emlXUCewGI7vYp1l+L069U7J4veKL+X5F5k8mK84RLpX2rS9MN+L0BG3OAmJ7fW2vkwdV+QWdCAyZJKp++7FRmor/kPNoFSabSCoozxLPTbpM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739656909; c=relaxed/simple;
	bh=9orFKUd8pqRjiHdFEjGCqYrAloXTMjgVuLzIRT4qouY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=se2rJnhCbv5a7/bcJvPZ10fSaA9YXM9DFRH3Q2PXgtexmFB14kJz7POGy5r4PGTEzluorsGLKaBzdSS9/eSoBCFW5N+RBtqCvEtZdsKHs/xkO/cfIkJ6085xv2WJXH/5pfS2lTcQbaPF5yA8Dyv3KCceDT/BS9loNrJFWKrN6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYSpJVxc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso3766669a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 14:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739656906; x=1740261706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XgSX5JlBtiwZpFD92J9X1UP69I5uT1pZoLx/NaC6sEo=;
        b=LYSpJVxckn4F0PVbb42yOhyNEN0G4TjTfQdnPBIC1bbQRhT8PissqIe4cWAxe40Wzq
         xci8htZ5GRDz99ysc3Y1/7ue/Y8ViAFlSMe1T0HprJIPAHhSQV9zososbLkb/39efDtz
         x8a8/2VrrDXChC07V+iV63wCrRk12nwhRPVK3dTDGi795xkNLjcQKCUPZ8CFngSPS5mq
         gsX1DhGZkuUuLZgD+bhJrbVWCFHO7Kkq+ePGHIgm07zq6P7u+01p1rMBAX7+udC1z21l
         6zrr9YVlXaTSi0DaSJQuIcX/1sE8Y/CM49W4/sNQNM9jKRUtGguo89XtNS+iy9wSQ+Sm
         taLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739656906; x=1740261706;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgSX5JlBtiwZpFD92J9X1UP69I5uT1pZoLx/NaC6sEo=;
        b=os9ul8NQoatVRwU6krilAp1/7yCGo8LosSx1Rhx//5uXK6EVJxBp9lsL1U+97y5R9I
         gxtY/UNhoxWH29MB0hjy1ryts3pRhzVN9XqMKwO9M6q6uDcCkXOxIygkWl3Tl8C4Td2z
         cKLavtfmSIgm5fok6fa3iLFgJsNu2R7v5EqFY1ayY9zQpUTRunBjKckRoSYArXMmaUvn
         736bVUUdD9+As/A5ULFVLiaiQcp/apbr3WEleKZLUuAND+fy8pWxESkwni42+Jqd9GA2
         yTA8G4UYM8hbeqDel8eKGROGaLmjQTktEE4FoA++podfzb0QGPhtcdJNfZw8LkjtsLFk
         7i4w==
X-Gm-Message-State: AOJu0YzMCeMXgnpLw/sbHPnlz/xppbIVvlWI2Dxxey/2Jthb31wzSMj/
	3zM4z2tpClgNvaxTM0zjkO+Tc625wbAfIthyhuPOnrBm14Xt+W323Dv7Vg==
X-Gm-Gg: ASbGncvOe3nIBlyb0e1ZU6c6edLqm2pP1RUVS5onCdamk0//buimQkmFN2+O5pNYPZK
	5cPR6jWm+FfeH5plPOwJdDLSNlawyfnpVbxteeyoYw15YZ0cjnbrHN2e/8PpN0Kq2MNSpzo0niw
	jURKaH1DjA0CgAc5lr072r55CKnO7LoSsNskfo9tEvmV8OeUK0o98U8MUSJCtkINK1byIvYBHV8
	2hwkKYSQoNrxsy4y3VOzj8SByac4Wps3NojZklzaq8aiE9owP1I44d/AHb6FonYhgYEsBuWqTZz
	ZbnGuQhIE6GMbjGT7M3QMCNO
X-Google-Smtp-Source: AGHT+IEB+xQp44fEkwJW+UznTxgHG857tIvHx03Nl5RtnwGBHC46sqrfdPen3vSU1zzc/+pQGUYw5A==
X-Received: by 2002:a05:6402:4609:b0:5da:d76:7b2e with SMTP id 4fb4d7f45d1cf-5e035f55d88mr4259735a12.0.1739656905894;
        Sat, 15 Feb 2025 14:01:45 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287d3fsm4976396a12.72.2025.02.15.14.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 14:01:44 -0800 (PST)
Message-ID: <11927c36-05b4-4655-911b-9d40da8a9250@gmail.com>
Date: Sun, 16 Feb 2025 00:01:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 6/8] wifi: rtw88: Extend rtw_phy_config_swing_table() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Language: en-US
In-Reply-To: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Select the TX power tracking tables for RF paths C and D as well.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw88/phy.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index b487457d2215..55be0d8e0c28 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -2458,32 +2458,56 @@ void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
 			swing_table->n[RF_PATH_A] = tbl->pwrtrk_2g_ccka_n;
 			swing_table->p[RF_PATH_B] = tbl->pwrtrk_2g_cckb_p;
 			swing_table->n[RF_PATH_B] = tbl->pwrtrk_2g_cckb_n;
+			swing_table->p[RF_PATH_C] = tbl->pwrtrk_2g_cckc_p;
+			swing_table->n[RF_PATH_C] = tbl->pwrtrk_2g_cckc_n;
+			swing_table->p[RF_PATH_D] = tbl->pwrtrk_2g_cckd_p;
+			swing_table->n[RF_PATH_D] = tbl->pwrtrk_2g_cckd_n;
 		} else {
 			swing_table->p[RF_PATH_A] = tbl->pwrtrk_2ga_p;
 			swing_table->n[RF_PATH_A] = tbl->pwrtrk_2ga_n;
 			swing_table->p[RF_PATH_B] = tbl->pwrtrk_2gb_p;
 			swing_table->n[RF_PATH_B] = tbl->pwrtrk_2gb_n;
+			swing_table->p[RF_PATH_C] = tbl->pwrtrk_2gc_p;
+			swing_table->n[RF_PATH_C] = tbl->pwrtrk_2gc_n;
+			swing_table->p[RF_PATH_D] = tbl->pwrtrk_2gd_p;
+			swing_table->n[RF_PATH_D] = tbl->pwrtrk_2gd_n;
 		}
 	} else if (IS_CH_5G_BAND_1(channel) || IS_CH_5G_BAND_2(channel)) {
 		swing_table->p[RF_PATH_A] = tbl->pwrtrk_5ga_p[RTW_PWR_TRK_5G_1];
 		swing_table->n[RF_PATH_A] = tbl->pwrtrk_5ga_n[RTW_PWR_TRK_5G_1];
 		swing_table->p[RF_PATH_B] = tbl->pwrtrk_5gb_p[RTW_PWR_TRK_5G_1];
 		swing_table->n[RF_PATH_B] = tbl->pwrtrk_5gb_n[RTW_PWR_TRK_5G_1];
+		swing_table->p[RF_PATH_C] = tbl->pwrtrk_5gc_p[RTW_PWR_TRK_5G_1];
+		swing_table->n[RF_PATH_C] = tbl->pwrtrk_5gc_n[RTW_PWR_TRK_5G_1];
+		swing_table->p[RF_PATH_D] = tbl->pwrtrk_5gd_p[RTW_PWR_TRK_5G_1];
+		swing_table->n[RF_PATH_D] = tbl->pwrtrk_5gd_n[RTW_PWR_TRK_5G_1];
 	} else if (IS_CH_5G_BAND_3(channel)) {
 		swing_table->p[RF_PATH_A] = tbl->pwrtrk_5ga_p[RTW_PWR_TRK_5G_2];
 		swing_table->n[RF_PATH_A] = tbl->pwrtrk_5ga_n[RTW_PWR_TRK_5G_2];
 		swing_table->p[RF_PATH_B] = tbl->pwrtrk_5gb_p[RTW_PWR_TRK_5G_2];
 		swing_table->n[RF_PATH_B] = tbl->pwrtrk_5gb_n[RTW_PWR_TRK_5G_2];
+		swing_table->p[RF_PATH_C] = tbl->pwrtrk_5gc_p[RTW_PWR_TRK_5G_2];
+		swing_table->n[RF_PATH_C] = tbl->pwrtrk_5gc_n[RTW_PWR_TRK_5G_2];
+		swing_table->p[RF_PATH_D] = tbl->pwrtrk_5gd_p[RTW_PWR_TRK_5G_2];
+		swing_table->n[RF_PATH_D] = tbl->pwrtrk_5gd_n[RTW_PWR_TRK_5G_2];
 	} else if (IS_CH_5G_BAND_4(channel)) {
 		swing_table->p[RF_PATH_A] = tbl->pwrtrk_5ga_p[RTW_PWR_TRK_5G_3];
 		swing_table->n[RF_PATH_A] = tbl->pwrtrk_5ga_n[RTW_PWR_TRK_5G_3];
 		swing_table->p[RF_PATH_B] = tbl->pwrtrk_5gb_p[RTW_PWR_TRK_5G_3];
 		swing_table->n[RF_PATH_B] = tbl->pwrtrk_5gb_n[RTW_PWR_TRK_5G_3];
+		swing_table->p[RF_PATH_C] = tbl->pwrtrk_5gc_p[RTW_PWR_TRK_5G_3];
+		swing_table->n[RF_PATH_C] = tbl->pwrtrk_5gc_n[RTW_PWR_TRK_5G_3];
+		swing_table->p[RF_PATH_D] = tbl->pwrtrk_5gd_p[RTW_PWR_TRK_5G_3];
+		swing_table->n[RF_PATH_D] = tbl->pwrtrk_5gd_n[RTW_PWR_TRK_5G_3];
 	} else {
 		swing_table->p[RF_PATH_A] = tbl->pwrtrk_2ga_p;
 		swing_table->n[RF_PATH_A] = tbl->pwrtrk_2ga_n;
 		swing_table->p[RF_PATH_B] = tbl->pwrtrk_2gb_p;
 		swing_table->n[RF_PATH_B] = tbl->pwrtrk_2gb_n;
+		swing_table->p[RF_PATH_C] = tbl->pwrtrk_2gc_p;
+		swing_table->n[RF_PATH_C] = tbl->pwrtrk_2gc_n;
+		swing_table->p[RF_PATH_D] = tbl->pwrtrk_2gd_p;
+		swing_table->n[RF_PATH_D] = tbl->pwrtrk_2gd_n;
 	}
 }
 EXPORT_SYMBOL(rtw_phy_config_swing_table);
-- 
2.48.1



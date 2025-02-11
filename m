Return-Path: <linux-wireless+bounces-18793-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FCCA31894
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 23:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250CC7A10E0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 22:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9C8267AFB;
	Tue, 11 Feb 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzHR1eJI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADA267714
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739312703; cv=none; b=a6pJYZLUfsMujYus89MkrnIOksgGQ17CV52AnFn+ueXN/7UX+/he8TS4cIuhMVxpHPKB9rdaxyvBdHAlJrRF4KovJFlwE1WravhiXtrf8y7ocL4MYrIsUVLU+X5XAS9UvTY38k5gezUFYoGDOYJtkCet5JSje1lAhPGLbHmpmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739312703; c=relaxed/simple;
	bh=PiiQW0ijNoNFw8f147R0xemdYO5btmKopDfjR7WkyWY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qSbKxQXNtYAypWElMcVnJe/G5FlGN5fv1GUR9p1j8BwUdaYSgaTQNIUs1q3LI6cK9DWFtRSsCBCo2NLWm9JX5emRk5kOeI6HGHS4R1VM5zjus6WMIIe51C9fyA5h1PzSDSn6S+TN9w16rnhh7CfuCa0d7HdyuVlm94H54euye9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzHR1eJI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaeec07b705so965449466b.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 14:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739312700; x=1739917500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Sht9ZoxvjV6jE0d1ZV54/qMwff58zRmJuZIirIf0Dw=;
        b=FzHR1eJI/81zAvYftWv+ACjVV08CDklSRJutK8FVTR/fP4rHlzwj5tuYSMQPnIO4My
         xTpUkavXLgsCBx4W3WrvNINxGOahtS/Q1+qLoTOuU5ZS9nvY3XLsSo4t9k3kQdf1D7Q+
         4De7W0QK6FCNRWky13+OsAABsXM2SqxJuXl3RIlu4aGtHgVzwJFrsklsIwRi6WuHI98z
         OcLJPIbRdpxHuv5wjYpjHBTztSg9et5xyrnO0vTKqsgKNBJaSmMevEi0+FhYbBnzV3RF
         j6Fah1VqAd8RNIBjvKIQqRtpowaY/1H8crsLx8HS4SYtn4uV5PXUgx+RaW4BLG6SKolN
         o3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739312700; x=1739917500;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Sht9ZoxvjV6jE0d1ZV54/qMwff58zRmJuZIirIf0Dw=;
        b=PKxRZtmvDkfpq5jT9CLAfKrnto6cbOkbMPFUrpcjPSpc3ZuuCj565nSM0Z2QYN0TME
         +USFi8bpGX81E/wHEbdQFS3lpG7Cs+eeDN52crxAvLC7vMgP6jr6ze9+Ml2jPY2QPPrN
         m0ayp1LwCX8xjgbcLFZc/c/pb6XiwEHDvlG+kUwoqYE5HPiTyegmAKdusPctTkpEEhcY
         qdv7NrC2ClhfSe0iWYnvREYnvRi8zV6kCdSG9ZPq5j2nsm/WAFNnHcKmDLhaLak88Tlk
         NxC4D/jdv07bqSkb6D/mmckIjuWK9z8xnAh7nnmB4u71gz3Xu6839pm8rgtMgzP7HyaJ
         TeMg==
X-Gm-Message-State: AOJu0YwGqjvZPAZvdQb8NpTwNnqYTuEYurTtTFjUVClLjmIAbOT5PTOe
	yeB2NvlDnfPOC72XdOoOQ9Gw8EjRX1v5FAU3eAd6DfVFsA4CNPh65iflyQ==
X-Gm-Gg: ASbGncvZ1LQWVji/0Zg4CKfbbrpEUBoisjmpcX1e7z6Ir4lNGD6qnINTWxWmsOtqGy9
	zam8/74plCkuoCPBpLkaIWKMM3vSzV1iX+s5EKa+XTSJs766bJrvNTeXuW/3CAtSRwhlVcN85ou
	Gf1jaqW6KyowOCYoDZr6LlwevbJm1G1v3s7whYi4wh9bHM275iEQIl2ZvS+hjal9JJ+kUuEVcBS
	PVhOliBoz4OozxRYveHOg2zQvZjDHFwFqBimG++tbvCKQilcF61cYmdWuvuIZAcPf3wg39rDp/9
	gBBIOwqEYg+/pHtO3T5XRgPY
X-Google-Smtp-Source: AGHT+IE/Vlt1lRVFHXw361r8UbENYfVmq0mOljQ8fdbF9Wr7rEC5WqPCRi3RUBwK4DyiE/q4ILQBlQ==
X-Received: by 2002:a17:907:d410:b0:ab2:faed:f180 with SMTP id a640c23a62f3a-ab7f33daf6amr52989166b.33.1739312699845;
        Tue, 11 Feb 2025 14:24:59 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7ceae3a3bsm354220366b.129.2025.02.11.14.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 14:24:59 -0800 (PST)
Message-ID: <6d04c43c-1d40-46ec-a569-1b19a2aaa59c@gmail.com>
Date: Wed, 12 Feb 2025 00:24:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6/8] wifi: rtw88: Extend rtw_phy_config_swing_table() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Language: en-US
In-Reply-To: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Select the TX power tracking tables for RF paths C and D as well.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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



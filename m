Return-Path: <linux-wireless+bounces-19081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78AA38FA4
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFED3A6419
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE41A5B83;
	Mon, 17 Feb 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fiynd5H8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA1B15666D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835116; cv=none; b=dLHAPFc75Mf0nk6TAV1lT3lgnPfdYwp0R2vFVnxKB7esb5QgK9uWXIf3TtEjEeajW8AAvdKjRCbwBShZ+twkQ1axaHfA/g/AWaMMxCJCa/KfsKi8DvqYDaECER7XtnuSuju+v4gOVcyIox/5YmizqIMRzzRegWrE8tqTC3p+uN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835116; c=relaxed/simple;
	bh=jokbDHz0CUJ0CmtHFimD+XYpo8uAS3BkuZB9tPg+yu0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IjW9EnD/aguWdAOvAVr9po2x2QRUu/+RCQ+YzJTmTZBc4W604oZOtGM4frj5eldFhhSDpg6p/PKMf8JTQTX6kku6tSTyTXcLY7cb0U6qquQR11yTLaYPAUcC4TcMmSXhPkgrBmN8C3E/r1QcIUdYK4q6KmuGpNhfHh0trfykoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fiynd5H8; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abadccdfe5aso574182266b.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 15:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739835113; x=1740439913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TXn0E312stjAPoplpuzfblOhCJFbCZSNVcXgpY5Gpb8=;
        b=Fiynd5H8BQfTmqpnHpkU8RqhSusuEYMV6ZXx4ZkKl90YFkYE68eqpD0P0r7DnO8FGQ
         rZxewVOWVnuHf+W7Ksi3gvUv8kK42gBFPE6PQaYcF1IWhWAEhI36G5jdee9PwlO4eV1d
         MxKVN5nnyK6/0YPjs5fueSeEq5N/SR/gt90yYTwfg3u4cGdDOOpZKNlo+X6yzym7qMGy
         n29rjpSUCDsNu80woKji7yCC1hz4/srof0uwv9CfXDzqQw8iCpBthSgzK83DVp57QK0m
         /4W15BgqvJA64O0NXioCrSuXv0R4LRKV9j36YqQUAoxZ+Quza4r5HxzUk5lJLPPC+cjB
         GZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739835113; x=1740439913;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXn0E312stjAPoplpuzfblOhCJFbCZSNVcXgpY5Gpb8=;
        b=DqV5kVrID5Vz9UCur734AIBLlPQfH5VzcIbFCdPl2QJlakB5MS9T0temANdZjYer1I
         pqRbB8O9TfIImHwLD5LIWg0Z//RcQhk8J8ugDi6qyLK3TOlSfberEXuAX1ZLwuHIlgPC
         df4ezc2GtPWNd4rqQC0KKKaXjmU8bI8+uKlgn1oMCpOSerK2uNEaIMBad9tPaxcB2ZXh
         LYMs12OG7iKHYmfcx8a7z9Lr7LtWOt/gV4sd/oO0tAYnOGtNaRyhB/g2iRzrt6DWsKqH
         YGRbqyQYKb5EUkznsRBWxUlyZcepJuJ/ZYZ0RaBMHB4GkCFWhP+VMRG6d3PXKjqFkXST
         z3UQ==
X-Gm-Message-State: AOJu0YyFXLeMFqOTsksy4GFh16HDlaO9CCDx3tOQcIAnkUTEXqOWNbul
	0j+2F/pFM43XTVbH5AECWMSOKITj83QwDCsXa6tweDL0e0tK0csfQ0IIrw==
X-Gm-Gg: ASbGncuRpk5O5OXLU7Ap7aQA9MMrHYb3jJol7/6tQerqlnVZrT2RVOo7izxlS7fLgbU
	wsSFgKdSrZdc/9cAOLP+ADHZFO43vOehJlaz8dnEMXRMdB2+ewRyPtDbcWbBWxWHwpkqIbv7FJl
	eUV3F0A8SrljZJcWrgkXeCrS3OO1uTYtwrpIENHiBTZpaSDUXKWezaT9KeCPsuVSTx3ZBxGjgBv
	cn9fk9oQM8xYi+WHD29xEN8jb4pqb5knxZWHAFAFpimGScrNNQxRTv1ffYV2GvKgKEPeIfdcVCK
	OZ8NBgFsvjf54baQXNX1mqvx
X-Google-Smtp-Source: AGHT+IG3YM4UAtJzCEkfYoCuvVval7a0tKAEcj+IdK9hzpkF+V+imLVquwQtslyxAI9fpGOvsqjqtg==
X-Received: by 2002:a17:907:9716:b0:ab9:5544:5eb3 with SMTP id a640c23a62f3a-abb70b354e7mr1068716766b.26.1739835113348;
        Mon, 17 Feb 2025 15:31:53 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbac60d938sm131984966b.147.2025.02.17.15.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 15:31:52 -0800 (PST)
Message-ID: <e1e532c9-8733-4ec8-84fe-ced4af6c08da@gmail.com>
Date: Tue, 18 Feb 2025 01:31:51 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 6/8] wifi: rtw88: Extend rtw_phy_config_swing_table() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Language: en-US
In-Reply-To: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Select the TX power tracking tables for RF paths C and D as well.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
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



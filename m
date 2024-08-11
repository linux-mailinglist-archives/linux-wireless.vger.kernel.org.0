Return-Path: <linux-wireless+bounces-11273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E2B94E320
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 22:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E8AB20B76
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF6A1537A7;
	Sun, 11 Aug 2024 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP79Lzuv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E6136352
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723409687; cv=none; b=uycDr7myKprYZmgv9bVgjfsWmaRx5e9ab4J18JjpIigWbRm5awU3ZCDUwtThnYUX4wv9OXjw2bqrM8VxYrgjd/rMsr7fXQ7imA9dDRbT1I++Yu56XPbyUt9MIYldTGAlITzhqwnFOSByL+MLwWcwpIh8GTGgJFRtpY7F/eSlVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723409687; c=relaxed/simple;
	bh=DdV3M0espqjKPyI6aKNdDQVF21BQsilM46Z+Linodck=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m5tD3laxN4vK6ukdU+LczJKlb31bzR1FECC/5Jsqulj0oDJO0uguUENLApAo0j+BoEsMI4G9mDfUH5p0rNpjCx8wdN0BWiKtj6Sjg6ns6RpKilvYD5qG15Mz3vg7HLfy+WZG7wO38WY3gPshhT6bdx2EJIJKrqMNfcYa7v+2Jno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP79Lzuv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so405585966b.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723409684; x=1724014484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RXJwb9wH7q3I7KFmCFMF4GZOUgXKluQZ6C726iCE4Zs=;
        b=dP79LzuvJZELWT4RaFnsdas5KSvbugz3iJoC0XN255Q8dNC3YcknHVNzdxdZ3LE+3S
         23bsNMhFeMiw/i77WJYki4zuMWqynzt/Da+tjvP2Z27MGN7wk6mYWmNiNh8MAh+dYDbK
         ccYDV8lQFpfOvG7cZ78edg3O+1yQY0R/e2Qj0og2tKCQiq1p5LMClzJsVemP9QyNFAW2
         0tNai9c+7Z9zkxYes63zjFwKB8cC3utKISnHQOzp+C4s7cN1eP9Lbi1clphwPHdIOwLY
         b9fPC/XPx+ujlDl0KZEenrr9OpeOvGE2QASmILL1rv/p4z6zIMzqs8av3krutrJW/pYh
         1u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723409684; x=1724014484;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXJwb9wH7q3I7KFmCFMF4GZOUgXKluQZ6C726iCE4Zs=;
        b=SYc2dazJJsKmVOigvnNjZapRE7oY3AEftms8VFb8fO4eYArDNo9epne1LaE4NWO+Dv
         4vPsJXtmHMI2Qli6La6yJwZdZ2jhPN4JRanypbzU0ESx6xhfidepw98G3t86MFNBVdKa
         OF9FBgWhQ/oNLxVK302FzRbAq/tAAYdPXH4h5urgP/pl7FwPoUjISDdVqaG5mePF1nqZ
         FUFgEQLP9sqBjMK94hAH+oRpEHW7KUG1LUdKrahEwK14CDiLTrCLqOf00NM4JZxj4fDB
         A+TSXWYXyPh5nLNTHDEsycUYZnBW59W6JOTAss0gt6Fyj5QOSCI5ZBvNX56rXVjX7Skj
         aBVQ==
X-Gm-Message-State: AOJu0Yxkakr5PLPqHxpoXMzHpYABqkBvyB6GGsaoOi1DIRf/I200KbQF
	1aEFXOFv1TGRH+/RZrThcrWNBlww1aftHZpn41OtsC+aIWAq4hflqUZpfw==
X-Google-Smtp-Source: AGHT+IGBQpjQYX4kayosp87p9afjyOVStuzs7SnMb6agBWPwe2iXi54QUb3FRGMGjDFRvCYOpWuZBQ==
X-Received: by 2002:a17:907:e60b:b0:a7a:9a78:4b59 with SMTP id a640c23a62f3a-a80aa595cb9mr557574966b.23.1723409683722;
        Sun, 11 Aug 2024 13:54:43 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1d1258sm172922766b.105.2024.08.11.13.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 13:54:43 -0700 (PDT)
Message-ID: <32cce43e-8495-4f82-8ab4-527e1606fee3@gmail.com>
Date: Sun, 11 Aug 2024 23:54:42 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 02/20] wifi: rtw88: Dump the HW features only for some chips
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8821AU and RTL8812AU don't support this. They hit the "failed to read
hw feature report" error.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     | 4 ++++
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 7 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index ff045dfdca4a..aeb21ac25e2e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1923,6 +1923,9 @@ static int rtw_dump_hw_feature(struct rtw_dev *rtwdev)
 	u8 bw;
 	int i;
 
+	if (!rtwdev->chip->hw_feature_report)
+		goto print_hw_cap;
+
 	id = rtw_read8(rtwdev, REG_C2HEVT);
 	if (id != C2H_HW_FEATURE_REPORT) {
 		rtw_err(rtwdev, "failed to read hw feature report\n");
@@ -1947,6 +1950,7 @@ static int rtw_dump_hw_feature(struct rtw_dev *rtwdev)
 	    efuse->hw_cap.nss > rtwdev->hal.rf_path_num)
 		efuse->hw_cap.nss = rtwdev->hal.rf_path_num;
 
+print_hw_cap:
 	rtw_dbg(rtwdev, RTW_DBG_EFUSE,
 		"hw cap: hci=0x%02x, bw=0x%02x, ptcl=0x%02x, ant_num=%d, nss=%d\n",
 		efuse->hw_cap.hci, efuse->hw_cap.bw, efuse->hw_cap.ptcl,
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 7e4618095eca..16619432f450 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1202,6 +1202,7 @@ struct rtw_chip_info {
 	const struct rtw_fwcd_segs *fwcd_segs;
 
 	u8 usb_tx_agg_desc_num;
+	bool hw_feature_report;
 
 	u8 default_1ss_tx_path;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 222608de33cd..c9bb779812b6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -2014,6 +2014,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.max_power_index = 0x3f,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
 	.usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
+	.hw_feature_report = true,
 
 	.path_div_supported = false,
 	.ht_supported = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 3fba4054d45f..fea327e5a474 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2172,6 +2172,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
 	.usb_tx_agg_desc_num = 1,
+	.hw_feature_report = true,
 	.ht_supported = true,
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 526e8de77b3e..a95bca79ce02 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -2009,6 +2009,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
 	.usb_tx_agg_desc_num = 3,
+	.hw_feature_report = true,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 6edb17aea90e..42f055eec16b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2550,6 +2550,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
 	.usb_tx_agg_desc_num = 3,
+	.hw_feature_report = true,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 1dbe1cdbc3fd..c646bd4ec5e2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5371,6 +5371,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
 	.usb_tx_agg_desc_num = 3,
+	.hw_feature_report = true,
 	.default_1ss_tx_path = BB_PATH_A,
 	.path_div_supported = true,
 	.ht_supported = true,
-- 
2.46.0



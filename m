Return-Path: <linux-wireless+bounces-17986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7496DA1CF2C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 00:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C2F7A1F97
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 23:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC49425A641;
	Sun, 26 Jan 2025 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6P63eB3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCAE1CD3F
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737932539; cv=none; b=XWIbOlHC+cZuSKW7ewfnHZQAfjDG66DiM4l6QH5U6ht1s9T4n3RH078SjT/l+c/oR+tF8miL7orf6P8qDk8jH020WQzsDL1gUqK8K+fz2FIYBAUUXd9SVHWkYJiiuYSzU8/HRPgBgRs14OICoCaOF6TIL9hZvtRv9FZNcEFtaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737932539; c=relaxed/simple;
	bh=2OmmiSVFpvCnMOonxhO2wDmm6N2Pmu7EoVGn4DC9TVY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OrKe43gtwVlj02C5VbvWDU0CAVUsKV/GU7k4j3ty6ih5ONiU/9OilCzbmDiTZC2l3JPBNayASjCdLScj3R5ZW0SytvfLe4KmSBXDpobsv6q4Tcbi+glRU3BfVdsQBVfo47/n/fU8qqqE6ixDFNDG5CLk+DZg4rwPwwyzC6Z9ckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6P63eB3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2002855f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 15:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737932536; x=1738537336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8OcRTt9Y4PUP8FtGtevnvsP69gFiGEAlUvDZ9pzpupw=;
        b=H6P63eB3DCyHqwEUeqWWsY0EZWzJ48w3DDX6JingF5oLv638jOTaOPsPzik76nUbBJ
         hvK2MN08wlwwsiGkvz5H7BQ0scw1RJBDrmi5YTrZR7MnapJdvudfu2ORl/xFoiePn2qU
         6lzzYZfEzsE6CRsxHrmifA5Rze5HbjV1YUu9vCplfh/VWujIZCOYMmNxss0ZGbKGEcl1
         4Zwj9WjNJv0UPZwLenMsP5jIty7ambstK7X1L21I3sWTCkjVNYVnIrirpthAxsvi1gjX
         BSxCphGcKXvORpyAeZeqOMId00snAPojNvx0NCYWEDP8/L9nHlqb+oM5Clt8W9bkV/oJ
         eRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737932536; x=1738537336;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OcRTt9Y4PUP8FtGtevnvsP69gFiGEAlUvDZ9pzpupw=;
        b=JVAzSEgg657EaEq2Q3qoHCHFtt8Y8kngcmTU0MGwx3RZxDEtXWBIf9Vxrm+hGEYRYX
         VYDsVoB8nz2+ouk7j7TagpWfg6VUVOxBrLQ2qeQyqmkpgdPN3fNrSRoVsZAlN3wqmFks
         uOa30cyPoPwiXH0+XRhE02qG/yRbpOd0+y0WW/lRL5+fyugY5kcdfEfMQjp0HJycl0PD
         h8WhYRV+aSz2RfI7c0g5DmliFm1C3anC7JxpiADoIPIp0gjcge5dXXGtTeTOAeqJKs/S
         sj1V1x0OOEGdodlFNP6tpG2WeEzK/n4v0Dwgm3HZp5eFM1+6CglhyihON6XXCkwWJeC+
         ObKQ==
X-Gm-Message-State: AOJu0Yythf2rMTAPWk5a69s1J74DPP9O3bkclRe0gJYKv5RLBROZI6gq
	+9DDI7UkV4qfLZkEGrretv3150FNLAaJ/bbPqR2tMA8sY4qNWfRbAxxrtg==
X-Gm-Gg: ASbGncv4K+P343NAVgDA7yzOxP0DqvlmjAbDaBylJO3U1OgqqS4uKX5dB62SdNZVMbd
	Tx1JiNZahN5Af5Nn487EIfVRfHDw/y6E4EK30z1tnGd/zQh2Ux5v8ueM5wanvlDgwqnMnNNR7OX
	0dfxCLeeX+FFbocJA2i38zmE2mk14VkyWqc1jrzXar/kYr9TJm/XmGgmu1EfIybTYX1kSKdTe2G
	j+Lbc3n2QEvjmZKuSiA9WDSvriPzSxmX+KvYpJAqhXRFTH91SNgsHm6Zb3q9eDL0Db5OdQ+Bj5q
	gbP/w3+nYOpX
X-Google-Smtp-Source: AGHT+IGAFCqi+GRvNRtBHRc2NClWQrQL0do8SEAqmXpTL4kLIKqEsEN0FHWi3AbUtp/CyLEiglPU4g==
X-Received: by 2002:a5d:6d8d:0:b0:38a:88bc:ace1 with SMTP id ffacd0b85a97d-38bf57a9608mr31831600f8f.34.1737932535965;
        Sun, 26 Jan 2025 15:02:15 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c3c8csm9426882f8f.90.2025.01.26.15.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 15:02:14 -0800 (PST)
Message-ID: <2a7c21bd-e78c-4792-99c7-fc73ce209930@gmail.com>
Date: Mon, 27 Jan 2025 01:02:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 7/7] wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Language: en-US
In-Reply-To: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This function tells the firmware what rates it can use.

Put the 3SS and 4SS HT rates supported by the other station into the
rate mask.

Remove the 3SS and 4SS rates from the rate mask if the hardware only has
2 spatial streams.

And finally, select the right rate ID (a parameter for the firmware)
when the hardware has 3 spatial streams.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 0cee0fd8c0ef..fab7e79fce47 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1234,7 +1234,9 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC)
 			ldpc_en = VHT_LDPC_EN;
 	} else if (sta->deflink.ht_cap.ht_supported) {
-		ra_mask |= (sta->deflink.ht_cap.mcs.rx_mask[1] << 20) |
+		ra_mask |= ((u64)sta->deflink.ht_cap.mcs.rx_mask[3] << 36) |
+			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[2] << 28) |
+			   (sta->deflink.ht_cap.mcs.rx_mask[1] << 20) |
 			   (sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
 		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			stbc_en = HT_STBC_EN;
@@ -1244,6 +1246,9 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 
 	if (efuse->hw_cap.nss == 1 || rtwdev->hal.txrx_1ss)
 		ra_mask &= RA_MASK_VHT_RATES_1SS | RA_MASK_HT_RATES_1SS;
+	else if (efuse->hw_cap.nss == 2)
+		ra_mask &= RA_MASK_VHT_RATES_2SS | RA_MASK_HT_RATES_2SS |
+			   RA_MASK_VHT_RATES_1SS | RA_MASK_HT_RATES_1SS;
 
 	if (hal->current_band_type == RTW_BAND_5G) {
 		ra_mask |= (u64)sta->deflink.supp_rates[NL80211_BAND_5GHZ] << 4;
@@ -1302,10 +1307,9 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
 		break;
 	}
 
-	if (sta->deflink.vht_cap.vht_supported && ra_mask & 0xffc00000)
-		tx_num = 2;
-	else if (sta->deflink.ht_cap.ht_supported && ra_mask & 0xfff00000)
-		tx_num = 2;
+	if (sta->deflink.vht_cap.vht_supported ||
+	    sta->deflink.ht_cap.ht_supported)
+		tx_num = efuse->hw_cap.nss;
 
 	rate_id = get_rate_id(wireless_set, bw_mode, tx_num);
 
-- 
2.48.1



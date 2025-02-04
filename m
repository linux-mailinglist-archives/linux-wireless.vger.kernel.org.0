Return-Path: <linux-wireless+bounces-18470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09542A27A3E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8127D3A38A6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF39217707;
	Tue,  4 Feb 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUkn91lY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E58212FA5
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694534; cv=none; b=MxFUjNb1VfXEi8n6OQYWQYOn53aCznr/KZgqIUASoR+t+44cRKCJyvZWiTTp20/i7JM1xlgttUwC/A1hm3AQbE+oIjb6anpax9cBdwrO15DpY1ogGWtylLhKDcF/w8BLPfAIDtXxvETMeNXtf1m03s024Ybfu1qeICULx0JUBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694534; c=relaxed/simple;
	bh=2iRYT8CAMaCBfscTTLIvgOFiB44rgKP8xvslhjf8H7E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DOaGRyDsDYUiRRaKPg8zKCeGr3FBRmRJQfBGpHU8Yg9NmynNCNg9ymritJruZA0OFwb1poPqNXuFj3zh9QbQBGV/kAoFve+JWT+3E79GcLkjujKgeBsReiQWegjpgy6cYusw0GenOAaDngzsGQDlkncdcN9Qw2ISAzNrgqhO6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUkn91lY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dcd09af4f9so1441267a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694530; x=1739299330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8a+ws9xGIB26df1b1IxmBPvt6VXFNLad3ifZTYSD7+w=;
        b=XUkn91lYdp373GENPTMBCV9AtBIFAG43awKVdA0orpdDUbzi3guB2RcEv8MbeGP5G2
         EKCifxkEqavIIKd7Za71LqhV3VDgs25YOaWX4H5VNU3JNlwjAST4g+G2BO6HG6ml1vcV
         BWAJKGu8RWBmTAwNq4qF4pVT/1d/lLoyx38GX3YybXjMeyMyJIjlOl0bo1dn694sfhWE
         c5a1tAHXyx1J/pH6D0LrKqIIUXh01auH2g4TKWy+UaUs6WRaCZ3WKAh+EwQGAcQonrmp
         lPCCyHn1aRAolOImhEKil5CuUVMMvnni2X9vd4YcEtUUEf4e4oDyVSxgdPmyOuQ7K/m8
         0LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694530; x=1739299330;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8a+ws9xGIB26df1b1IxmBPvt6VXFNLad3ifZTYSD7+w=;
        b=cL+/Pi2hdkLzpqGHHikggBvuGZJ/6rfP5NCWdj8WeRcWeZ50ME0RXLv9dAN6jWb2mZ
         un5rgHheS2parhL2GnTlh2zzVgOpyr5qcplZ7if6I0LNkZoBRvwq0tIzeFp8rWbWRpwN
         XPj43R5yrlHCGOTyGjGqRvfICmVoby/8eTv3p7IqGoo2B6vBIg+zHHXtHyqVnDa8pdWL
         2MPz4F2IsRj1ocTRw3yXMG5ohfbpmIeWvd3NAgGroWvVGx9Pu6ULqpjuu883YDMMMukb
         jAGc3HrCMNpUS9LwS6BSe+5lHoyy/CFHEKc+Inof5Nk+/aFIOeb4bnYiV8ZhwT4aZ1BS
         CmmQ==
X-Gm-Message-State: AOJu0Yzt2Q5AZNCgEhXtZGsjACPWoKxsmXjmuo03XFZ9MYXVaI9zB8dk
	BeRX8ojCdzQIItJcBbzi5BVtHLoKAPoozm+KXMLhgTrBujujeY0cmFuNog==
X-Gm-Gg: ASbGncuTbCLyqpKF5d4oMJDtbPuPS6LlUbRMrpHtNluyb+B9TCtePbzwWpNXba3QeLS
	I71gSNv1Vie7Rz/dlWQwraO1FQWzj2sMHwzs6piivyl3z5qcqatL0KjFcE8i+qfK8owuB6N+/jx
	WEx6U/8/gQyB4Uo2D59nhYkLFZMqxhtdsTyREESxbydxiVrMSYVPMGMKSogc2B+j/DWY8OWIUzY
	TLZN09w4T3agHoRyc8RsGo1WkxU1iWM3Fh5WrxV5ZEELn4RXIoxx/SnA0L6yCBdDexF3GxWaxNM
	GEUOdRSiPVNzjnysremMn1n4
X-Google-Smtp-Source: AGHT+IGtXQxpG8Jfm4YjkKvFp08JocgSMBuz2HqANSXhHqcHSeLcHm/tCX+WDFxJ16SOOicwoDCxfQ==
X-Received: by 2002:a05:6402:358d:b0:5dc:cc02:5d25 with SMTP id 4fb4d7f45d1cf-5dcdb73336emr107725a12.11.1738694530376;
        Tue, 04 Feb 2025 10:42:10 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc87f2e5easm7539267a12.57.2025.02.04.10.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:42:09 -0800 (PST)
Message-ID: <48d1d90f-2aeb-4ec5-9a24-0980e10eae1e@gmail.com>
Date: Tue, 4 Feb 2025 20:42:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 9/9] wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Language: en-US
In-Reply-To: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
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
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 8d22df293e78..e4f9b744f24d 100644
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



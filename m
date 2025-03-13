Return-Path: <linux-wireless+bounces-20354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCF7A60256
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 21:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1891896365
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78156157E88;
	Thu, 13 Mar 2025 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvO4MtQq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0342AA9
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897212; cv=none; b=UFHAa1OWn1zjUeyRwg3BrVga/6RSTykBEM+hVcpBTbid/Ztf5Kua21GLjngwWyshwpv3lLuaXD7fer916HWvP4nbfcSEKEaObCfQHwcCd4ltECDdx3LdeSbg1GvsnpWwADaMZKYl4rlEqlDQpZJRNOhwrr2fssfTR7a/ZdEGAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897212; c=relaxed/simple;
	bh=srALS5zpDFQ8FdDl7bTGl11T2i9F4MoAQVr+hWs0b34=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m17iwM8AHg3wAV7ZLnWV6cwnmlT1ftiKjlCoZvB8KlPJP2g0RDXMqXiEPbUY57/0Twnp/DzYfs4sEukkUnxI8MfkgrcFXXrZD/2c7nM7pNSwxgUKDSmS27h1Svd5IuLVxKbRPB4njCY4ifVaBPnvy4AmAs86uzQcn7ga7kFOla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvO4MtQq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2664656a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897209; x=1742502009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HN0MvMaE+fW87XKbX8FDINB7vpsyz6/+9Fj8lpX10YY=;
        b=hvO4MtQqq/mwmyPqOPMgIqsTUKTch5lG5gGin5aO9iP4+tDa2D8lSzhLmK6vAy2HPu
         EWKKzgUfbDbc7E4hzMCtxAE3E+3L3KxPcHABHgh+ABvcBU74hWGxhcPGU0yV6IcEtQAC
         Ci/HCe4Cccs4Y/3Kvo+x8SQqqJ2YQ1F6lxP0l1h0921qVFpGCqJvfXugxt1XYLDs2fOG
         ZIFqu8zx0xSkcwJL0LEITUNoGwWmENtoWYc/wzyDf0lVqOAeDZKep+lJw+1iby28GtIH
         vaKFzNHHqYrOqEm2wI8CjhoFjzIY0sO3X3I94MhHlgSFDz6xRQQ8T/nBVSzzxH6yspyY
         Gzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897209; x=1742502009;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HN0MvMaE+fW87XKbX8FDINB7vpsyz6/+9Fj8lpX10YY=;
        b=FpV5bErtIeKXuMUwhFfE1zngzIUBfUlpF2m/mFaldC+kbnvQN8Zc13ScCfynBViLAC
         Rwe3Vc13qfQba+Pwog3CwjIaGJJqC4yPe4t/kvt8AP3hk5OKAX5LWgk7A2LHChBtDGqP
         aCgeGtK4zp+XZFYxOwXiGxtlqecdeLNDhdsQGPEyMUs22uxNVIFwXgk2BrZTJlEezwrY
         Oylim4YQz7MSWpOy7xFFQYna0wcvSAXmtcVBe/VjrZLT/a/VFOktCt68FsI7IjgGf4di
         +f30hkKgmIrJlt+O1VO34SzsUR3i+RY1o4rBT4m9YP9s+97tMTvtZ6/hRXHeCWgyNKuK
         /0+A==
X-Gm-Message-State: AOJu0YwI8xHn2oYbPcTDZxNPVNRN2uXY4gnM44CxQI9NiINgeZTZVaVd
	M/E9fVoDkqnWFvg+Bf2qpCmrNaVBpkH8vDzRVblPwVycJG5EhP0A2yrZDw==
X-Gm-Gg: ASbGncvwSZ1pQlTu2YNQsyz5VhtCzOXMPJd8739hdvg/ZB+/x4XskNS4hNQ7mZXygYl
	lDyLbziGreeZy/Z0DRnaJDCcj/rcGAsz8HOsHJpfwyVJ44jHtbFI+8KLtY4K7xwuGaiparodiGp
	0CVNZV+PAy8qlfSun+j+8+/pWSpaMmpFNBB7R+SUTnuY/5Yq9u2vL9Tzh/9FblwFKKUJh9PGT5T
	661yHlYtl2Q6zsOIYpWV/TkqZEvDP/2qrONRrbcZlUNbNAssIBDtchJXnbG4J3Bo+HRnL/6xlQv
	gymp//8RP2KvFrJ+7HxsU5LUv5I0/PywmAZFYAJ9AtfiCvWWZx3rlg==
X-Google-Smtp-Source: AGHT+IHiRf+hlcKQ9LtNxcatmt3DCY7NNc9eU7kUYxdDPEJh5oH4+kZ7k5SvF98qjSztdDnUExn5Jw==
X-Received: by 2002:a05:6402:1ecc:b0:5e0:6e6c:e2b5 with SMTP id 4fb4d7f45d1cf-5e814dedc7dmr4526179a12.9.1741897208359;
        Thu, 13 Mar 2025 13:20:08 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad3914sm1061241a12.64.2025.03.13.13.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 13:20:06 -0700 (PDT)
Message-ID: <9f9a16a3-d326-4f48-9853-134751b63864@gmail.com>
Date: Thu, 13 Mar 2025 22:20:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 4/4] wifi: rtw88: Don't set SUPPORTS_AMSDU_IN_AMPDU
 for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
Content-Language: en-US
In-Reply-To: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8814AU doesn't work well with SUPPORTS_AMSDU_IN_AMPDU. The RX speed
is noticeably lower and the VHT RX statistics are strange. Typical
values with SUPPORTS_AMSDU_IN_AMPDU:

Reverse mode, remote host 192.168.0.1 is sending
[  5] local 192.168.0.50 port 60710 connected to 192.168.0.1 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  74.6 MBytes   626 Mbits/sec
[  5]   1.00-2.00   sec  79.2 MBytes   665 Mbits/sec
[  5]   2.00-3.00   sec  84.9 MBytes   712 Mbits/sec
[  5]   3.00-4.00   sec  83.8 MBytes   703 Mbits/sec
[  5]   4.00-5.00   sec  85.9 MBytes   720 Mbits/sec
[  5]   5.00-6.00   sec  78.9 MBytes   662 Mbits/sec
[  5]   6.00-7.00   sec  81.2 MBytes   682 Mbits/sec
[  5]   7.00-8.00   sec  80.5 MBytes   675 Mbits/sec
[  5]   8.00-9.00   sec  79.4 MBytes   666 Mbits/sec
[  5]   9.00-10.00  sec  82.2 MBytes   689 Mbits/sec
[  5]  10.00-11.00  sec  82.0 MBytes   688 Mbits/sec
[  5]  11.00-12.00  sec  84.2 MBytes   707 Mbits/sec
[  5]  12.00-13.00  sec  71.0 MBytes   596 Mbits/sec
[  5]  13.00-14.00  sec  69.4 MBytes   582 Mbits/sec
[  5]  14.00-15.00  sec  80.2 MBytes   673 Mbits/sec
[  5]  15.00-16.00  sec  74.5 MBytes   625 Mbits/sec

[Rx Counter]:
 * CCA (CCK, OFDM, Total) = (0, 2455, 2455)
 * False Alarm (CCK, OFDM, Total) = (0, 69, 69)
 * CCK cnt (ok, err) = (0, 0)
 * OFDM cnt (ok, err) = (1239, 2)
 * HT cnt (ok, err) = (0, 0)
 * VHT cnt (ok, err) = (21, 12109)

The "VHT ok" number is not believable.

And without SUPPORTS_AMSDU_IN_AMPDU:

Reverse mode, remote host 192.168.0.1 is sending
[  5] local 192.168.0.50 port 50030 connected to 192.168.0.1 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  70.5 MBytes   591 Mbits/sec
[  5]   1.00-2.00   sec  86.9 MBytes   729 Mbits/sec
[  5]   2.00-3.00   sec  98.6 MBytes   827 Mbits/sec
[  5]   3.00-4.00   sec  97.4 MBytes   817 Mbits/sec
[  5]   4.00-5.00   sec  98.6 MBytes   827 Mbits/sec
[  5]   5.00-6.00   sec  96.9 MBytes   813 Mbits/sec
[  5]   6.00-7.00   sec  98.2 MBytes   824 Mbits/sec
[  5]   7.00-8.00   sec  98.0 MBytes   822 Mbits/sec
[  5]   8.00-9.00   sec  99.9 MBytes   838 Mbits/sec
[  5]   9.00-10.00  sec  99.2 MBytes   833 Mbits/sec
[  5]  10.00-11.00  sec  98.0 MBytes   822 Mbits/sec
[  5]  11.00-12.00  sec  98.1 MBytes   823 Mbits/sec
[  5]  12.00-13.00  sec  97.0 MBytes   814 Mbits/sec
[  5]  13.00-14.00  sec  98.2 MBytes   824 Mbits/sec
[  5]  14.00-15.00  sec  98.5 MBytes   826 Mbits/sec
[  5]  15.00-16.00  sec  97.4 MBytes   817 Mbits/sec

[Rx Counter]:
 * CCA (CCK, OFDM, Total) = (0, 3860, 3860)
 * False Alarm (CCK, OFDM, Total) = (0, 2, 2)
 * CCK cnt (ok, err) = (0, 0)
 * OFDM cnt (ok, err) = (1486, 0)
 * HT cnt (ok, err) = (0, 0)
 * VHT cnt (ok, err) = (7399, 9118)

Add a new member "amsdu_in_ampdu" in struct rtw_chip_info and use it
to set SUPPORTS_AMSDU_IN_AMPDU only for the other chips.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     | 3 ++-
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8814a.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 8 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index bc2c1a5a30b3..c4de5d114eda 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2242,7 +2242,8 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
-	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
+	if (rtwdev->chip->amsdu_in_ampdu)
+		ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, TX_AMSDU);
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index f410c554da58..b0f1fabe9554 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1230,6 +1230,7 @@ struct rtw_chip_info {
 	u16 fw_fifo_addr[RTW_FW_FIFO_MAX];
 	const struct rtw_fwcd_segs *fwcd_segs;
 
+	bool amsdu_in_ampdu;
 	u8 usb_tx_agg_desc_num;
 	bool hw_feature_report;
 	u8 c2h_ra_report_size;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8812a.c b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
index 88daab22cdd6..34e052dd2e8b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -1086,6 +1086,7 @@ const struct rtw_chip_info rtw8812a_hw_spec = {
 	.rfe_defs = rtw8812a_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8812a_rfe_defs),
 	.rx_ldpc = false,
+	.amsdu_in_ampdu = true,
 	.hw_feature_report = false,
 	.c2h_ra_report_size = 4,
 	.old_datarate_fb_limit = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814a.c b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
index 57d8920832a3..516444391c46 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8814a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
@@ -2197,6 +2197,7 @@ const struct rtw_chip_info rtw8814a_hw_spec = {
 	.rx_ldpc = true,
 	.max_power_index = 0x3f,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
+	.amsdu_in_ampdu = false,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = false,
 	.c2h_ra_report_size = 6,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index 73e2bb4d5d79..fa4b1a53303b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -1186,6 +1186,7 @@ const struct rtw_chip_info rtw8821a_hw_spec = {
 	.rfe_defs = rtw8821a_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8821a_rfe_defs),
 	.rx_ldpc = false,
+	.amsdu_in_ampdu = true,
 	.hw_feature_report = false,
 	.c2h_ra_report_size = 4,
 	.old_datarate_fb_limit = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index e99ea716b64f..9015625627a8 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1996,6 +1996,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
+	.amsdu_in_ampdu = true,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index ef08729b9f4a..d631c7ade282 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2537,6 +2537,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
+	.amsdu_in_ampdu = true,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index baf519043d43..910bd36b4974 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5355,6 +5355,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
+	.amsdu_in_ampdu = true,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
-- 
2.48.1



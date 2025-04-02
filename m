Return-Path: <linux-wireless+bounces-21091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56518A79231
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696BC3A42F7
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0910F9;
	Wed,  2 Apr 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lii1fMIb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1EF3C0B
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607903; cv=none; b=fHzy3wBCbNEY7aAEjWtUK9XeLpEAR5WZI4hGLEJooaF7YJ1tgI1uJ36qIvR4uea+wN3t0BR0kYuzhqZsZIvpYoE+mLd4MNfMroOP0iuVCXrbyQ3U09jr3KBv4ZHdBgVmtil+N8NI2bEmFiQhcNhDnGrVlxjl1rvh5L6YRf9FJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607903; c=relaxed/simple;
	bh=A0C4lTs0aori9GvCAckx1EvhG/nrGpnUzjW4i71lBDc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XY3cfWq4ZAIlMTQJlXiDhYEGp8zg9ox1Ey7RegM53vT2N9EhFWvqi2yaXCjfrRnEdKosRkcO7Sl26yTkvL0vqGrRoykc0dquvOt+suKQKo9JSI2M2Sgq0r0bXAjDsOectHnGPEqrptfh2nmaJj+1eGh3/+/HgiXO1DmkChlQp7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lii1fMIb; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1383986366b.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743607900; x=1744212700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jel2dOvgHfvNtDXHvg3sajmUKpoOO3yCshyEVJHzjbM=;
        b=lii1fMIbDYvTWY8O7TbM41ralSVbpbGOhPdTPocT0k8EhlARAIMKKd3Uzg/qD8MUQI
         jlYNYXFcuotHzzl9THTBfapMCH2yZ6Pgadg2oGD781fhfBS9Jri5AAlcWSXpWkyBmowZ
         xD0QdnpAhi/fGBbmCUf41wjWF2KuyIpT9pG/9UNFTaFGl6XYKt78pmc037cchJsCt0Ms
         qGdNKLfDarwkSSODrVsqNlJYx5Y7Hj2EzmYIgYadPdePGbolcqRK5ZNxgpAQER6yA5m5
         f2r/2zoqD3f6+DsfkhY+STDQiFKlr8eyDkqG6aVBBNnEzEdyiNqU7XjR9a/af1po8ePM
         Q5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743607900; x=1744212700;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jel2dOvgHfvNtDXHvg3sajmUKpoOO3yCshyEVJHzjbM=;
        b=ZO6cwB7PsTkRIRuj+FK73RkKTlszLWbZ2IDjXzitX7JqByGBJmexivdoATsxM6PLiV
         ytOS+2XgtGmha3DjhA3zVM6fftjQNlOOW8NjzPl9xaQSYQ8q98PVhgZWVs9qaMbSpZW4
         VPPv2NKa9+Wsvz2OpjodbR4OneQslvP4kH2KlcaoZrOu9CHGYVMiPzRKjShJeejpEIFj
         sLrX4wum3NtQ555B/bmuzB/bEof9oHMJprJYQs9jFTcfWjpG/6XCfwK5XQPVPww/LbIE
         0Joav8pV5DF8dphpJqYyuOgsPIcE1O1emO4W7JrZanlkDMY7raAnvH5SAD+Jh+OfBDvv
         k5kA==
X-Gm-Message-State: AOJu0YxbTVlWmjYRgE/xGGG1HJtViULiO2udzyYTQBhb56C0bNJ4EnLs
	64169QecaEtxiQhVag4/az4OZykqz9tZ0Yqn9rqY50g4o/C7Ax/e3OgXag==
X-Gm-Gg: ASbGnct+ALrjHoWhhbl87N3ob901TpaA0IVaaOqCHBER2xtUyNhN9BCgLOqIhkNUVlF
	xCQez2bY9tyn3MpL+XoHgrlA09dL2z3HDrE/72GnMkPWd4Crn3XHhL8r5m1mTh3KVZsKR8kFJhv
	wRmFPqFmmq73WfLR6ciE1AWs0LeApxthyD5KUPhaTRLrxntUkl0u72qhDGZcceE5pUgUd4uvBBy
	RK1YmuQQp85crGf2EW9o1FCuRRdZSXgzvkd5xVnjSv1JfYIbdRfZybjVq/areZMrb8I7cE7/D/i
	1bXOJNl1CJe/RWkjZNYv8VXuQBivGm9etilLWouBggji7dkD0yEkhw==
X-Google-Smtp-Source: AGHT+IFMxVf7cl2wPZ7zutwhai8JMMSwxD9MTXPoIg8MUmgo9mhHNZ2BEsX9ds9ZI5f08PFNJvSA0g==
X-Received: by 2002:a17:907:d1a:b0:ac3:8aa0:9d70 with SMTP id a640c23a62f3a-ac782e939femr714125766b.51.1743607899921;
        Wed, 02 Apr 2025 08:31:39 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922ba63sm928951566b.2.2025.04.02.08.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 08:31:39 -0700 (PDT)
Message-ID: <6202ccfb-feb0-4107-a08d-db2699e179f0@gmail.com>
Date: Wed, 2 Apr 2025 18:31:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 4/4] wifi: rtw88: Don't set
 SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <257632d8-4347-45bc-ab39-4e88d87cdb3b@gmail.com>
Content-Language: en-US
In-Reply-To: <257632d8-4347-45bc-ab39-4e88d87cdb3b@gmail.com>
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
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add a comment explaining why this is needed.

v3:
 - Add Acked-by.
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
index adbfb37105d0..c2ef41767ff9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -1076,6 +1076,7 @@ const struct rtw_chip_info rtw8812a_hw_spec = {
 	.rfe_defs = rtw8812a_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8812a_rfe_defs),
 	.rx_ldpc = false,
+	.amsdu_in_ampdu = true,
 	.hw_feature_report = false,
 	.c2h_ra_report_size = 4,
 	.old_datarate_fb_limit = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8814a.c b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
index ce8d4e4c6c57..44dd3090484b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8814a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8814a.c
@@ -2200,6 +2200,7 @@ const struct rtw_chip_info rtw8814a_hw_spec = {
 	.rx_ldpc = true,
 	.max_power_index = 0x3f,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
+	.amsdu_in_ampdu = false, /* RX speed is better without AMSDU */
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = false,
 	.c2h_ra_report_size = 6,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
index 4d81fb29c9fc..413aec694c33 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -1176,6 +1176,7 @@ const struct rtw_chip_info rtw8821a_hw_spec = {
 	.rfe_defs = rtw8821a_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8821a_rfe_defs),
 	.rx_ldpc = false,
+	.amsdu_in_ampdu = true,
 	.hw_feature_report = false,
 	.c2h_ra_report_size = 4,
 	.old_datarate_fb_limit = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index f68b0041dcc0..413130a30ca9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1991,6 +1991,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
+	.amsdu_in_ampdu = true,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 0da212e27d55..ab199eaea3c7 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2532,6 +2532,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
+	.amsdu_in_ampdu = true,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index ca0cf26b9055..369ca75061b2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5350,6 +5350,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
+	.amsdu_in_ampdu = true,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
-- 
2.49.0



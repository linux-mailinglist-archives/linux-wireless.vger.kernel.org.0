Return-Path: <linux-wireless+bounces-20980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3657CA75A6B
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 16:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8B616856A
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36191B87EE;
	Sun, 30 Mar 2025 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMDcRIA/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D41EA65
	for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743346646; cv=none; b=i/Nxq2fKhUJStM/cV49Ju4Vvq767KqOELkvNxweNNOzTsZNhE3GN94/bjWZ/46oulmU2V8x2qnKUw6CopiFq8QLG58Kodn6rNXvl07dERWRnMzKBuRVJ3qma7W935ArKDUPUZxS+/zi79zkqPcp/MvSEI8MRiWODJlOUiGVJZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743346646; c=relaxed/simple;
	bh=LbyTEveTGwGq/JRZxvViWD+4csFpPwFp1dfZxlKmNx0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aUjcFjYUI//ilqlMEBHZydgv7O6PqW/DpZZP/xAlp/iAu3LgkLGLbJhgibIm/G8AOVQIGd07xy1sIxZTWZ5UeKUsQvyOdKSHzGz4+6zPKonOrSUw9D6NAhV9/3PIbg+u05HZvbZSVUIJcFc3wv64o1u8WNmhBL8TWUloxstNvUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMDcRIA/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so5912728a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743346643; x=1743951443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L9JhUVbvQEQKfL+0nPQDpd0rUJ4LACkorrQVIlwXSEQ=;
        b=BMDcRIA/UdLLCz0nZSXNTdSW4OL4ctUYnzcTCaJ/oe3Hws5EPk+FV2iNhzbmZfUu/q
         LjCKfocOpmrOJaE4K+RLRXQ3ID5SPzpHltftcRukPIad7RqVh3fHxoLNplwMPCrfZ2VZ
         Hb1kHMq5wwBknLg9gDXYWPS7G6dlNGQwFaSGd4+VhUwNfV3nhP73SZtrCGB7HyqJ4c0G
         YPwPJmYyZNcd5r4fZfC6Bi4b7v0c7ec51rJ9l0iGd0LX3GHz8KqtcQ1VuMw6t9RysP9z
         0hq3DI1QDuYBbHvg+JBxiNE2OI4X6dOdCfHlxlwo2afF8HJgVgFJVjWIpnLA4dD6FN/P
         6swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743346643; x=1743951443;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9JhUVbvQEQKfL+0nPQDpd0rUJ4LACkorrQVIlwXSEQ=;
        b=bN51ytxtOqidsrNhGadV5UJ1PCbUJVLB4B7DHqsGFtwQCvstuAKhB1/0ZsN4en5m92
         fKC1TYrha005Rm6/fOJqOsGULec6EldZcX2+vQqwIl3+d9B4TxVgbXOVhKJU8xmvr2tI
         4kMmtsnDoG47S66E0wRQcTTsr/goun8DJHba7DRHhF3RzMtatTQBNdjoVOaDLYNDqxvK
         Wg83zQjBYlUP42rUpeC6leSVg4lWEDqdN0wzjyv26+S94ODU9kPza6EZJZPt4ZSKBXQZ
         wba+uuuMa7A3VMaxDEAl50G82T2Df7KsF2IT5BPoq3s2VrSR3F5Me7G4ofkzOfOzTqhl
         szlQ==
X-Gm-Message-State: AOJu0YyA5p+/epTolsSZkp50f8aA785Ch/E2o+Wjda2vdznUAnEGUgX7
	h3y7alutdra5AcYfqFXWPyIsrc+qM1zLDfvQXfjPAMTEmOfilsXa3CQhUQ==
X-Gm-Gg: ASbGncuuWu/6w7s5FHaIpfRGCZ5vYMnNrtc7X5GGLuLmVGqPItRvjvDJiDZlYdA6+hn
	NT3+TqHPlE4nTbUJC8HEPYoSVJldILjJlkXiuiDUcUmeO3MWgriqXS0vMbySIkc/G8cA6IqW4a+
	DS71TcCbRjnmgnbLRdcHSGbzlSzZyA+kaef5q2osPQXkW0K66gE34IHpHJcfMEQWSYd6B4o8reB
	/T/4L5fIfChk0N7EQa54/4YDYwvMuVE0IxJ0CpGWyW1u6JDU7EIthw1s2pdT13HFsjRdIoDIZ2j
	/K2CyaF8grB0p+8mCa6PrZfK3NvdDyFC1pfrtUJyukDTPAXPT17ARE12kKIp2HBV
X-Google-Smtp-Source: AGHT+IGDyeKZKnRkdKzEWU8LeBh2hVjA1qGOP98Wuxs5y5iqxl3uV+3uw9BNQ2fubIHGQg1pJ3fJhg==
X-Received: by 2002:a05:6402:5254:b0:5e4:92ca:34d0 with SMTP id 4fb4d7f45d1cf-5edfdaf9104mr5064248a12.20.1743346642961;
        Sun, 30 Mar 2025 07:57:22 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae6fsm4351152a12.16.2025.03.30.07.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 07:57:21 -0700 (PDT)
Message-ID: <6aee626f-586b-4f71-b79a-cf1446834f5f@gmail.com>
Date: Sun, 30 Mar 2025 17:57:20 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 4/4] wifi: rtw88: Don't set
 SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
Content-Language: en-US
In-Reply-To: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
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
v2:
 - Add a comment explaining why this is needed.
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
index f9ba2aa2928a..d1cd531ce185 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8812a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8812a.c
@@ -1075,6 +1075,7 @@ const struct rtw_chip_info rtw8812a_hw_spec = {
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
index f68239b07319..8b26150b7c33 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821a.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
@@ -1175,6 +1175,7 @@ const struct rtw_chip_info rtw8821a_hw_spec = {
 	.rfe_defs = rtw8821a_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8821a_rfe_defs),
 	.rx_ldpc = false,
+	.amsdu_in_ampdu = true,
 	.hw_feature_report = false,
 	.c2h_ra_report_size = 4,
 	.old_datarate_fb_limit = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 0ade7f11cbd2..e370a2ea27aa 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1990,6 +1990,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
+	.amsdu_in_ampdu = true,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index b4934da88e33..aad999738869 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2531,6 +2531,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
+	.amsdu_in_ampdu = true,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 5e53e0db177e..645d96ad09fa 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5349,6 +5349,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
+	.amsdu_in_ampdu = true,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
-- 
2.49.0



Return-Path: <linux-wireless+bounces-13902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4789499ADAA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF2C1F227E8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E8F1BE251;
	Fri, 11 Oct 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0QEIi88"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C61198850
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679539; cv=none; b=jLOM+E+qf8hEiBjQ/iWuS4GuA4cLIY1wW481k9osw8jdCSwstcF5LkEtKX5oA9K1kJBPbHFZcCRGXR5hg30BQ1MTHQiDVvfudYEQrr68Kr80wWf71tdUX5TFXZkd+GFnLh0K/IBlMbLwSN471kVBSZTDMWQLCk+J6VrU7CZxs9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679539; c=relaxed/simple;
	bh=hydkE4cokygQbWTW3MfiVswcoo7uY41ll4Lkq1t1ItY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LlPxSVOwBTGCTwGa3xIpZxuZsWUfyqsQlCkkt2hQXdPzsS4nAMeldHAAgk8CDfIrcmx4fc0Ana4cX/8lpTo1akv5x3Y2XlF/ZZFN7JffRSD/sI9j/8CiW8LMxPq+uJ7XQWFP5J9mHTgx1YIVnsyHLV9q3wRaVgWDwRzVqRmbcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0QEIi88; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43055b43604so22107225e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679536; x=1729284336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JTLdt4BxksjHi8NKFiwPHAaByB092+AM07DTNccjOQU=;
        b=l0QEIi88SK2EQI6Kv6m0i3wr/XVs6ayZeSk32oukD1keQRvbDj+58x11TVkztozzSl
         r+fWCNbzfOqk4Z+9ZrPcfaAaYLch4JobOvQXwld/Fwp4iomQ+lQqY1hpEAeV3ESasiH0
         sZ7co2vuZvP8lkBPYpn1x7L5A+QN7mZh6BhfVLvOozHFT8renFuawaCh+G/LYqhX3Rau
         +LA+EObi3v6V3dQGYusfRh77yHzk+Jc60OJYFOVUa8HGBwtvy9LMaArjRFvctuykQMqC
         4pLOFzFLyy8AyjlZXicScBWqPO2tslSX4zXsHKy+7YOEsJG/3pvQ9vfRYf0+HVcTekDt
         kxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679536; x=1729284336;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTLdt4BxksjHi8NKFiwPHAaByB092+AM07DTNccjOQU=;
        b=l2b19vXmh9dTCBABpidUee3ap9iNIhecvEuo9NqP7u8ETGCm4L+DmD0KqnjMkHugGx
         bSRzrnGn9P+GhwzVBHy23WKNqnko0H2Jrge9act0+FwlgYgwwPksVNVUW/hEQmsNcW3p
         b/2vy+FnwhXe4q5eLuuwP4jx5x157xNAROhFidOCajExwXpRNEwE8OiGwAcqRFCYpHuH
         qWXqwAPEglMwhEq9ra0XcYDIQie8XZbXj90b0ZYY4JpE87UgiT22tu5+Jnoz8ztYgTHf
         pxx2AZ6tuOmuCTX2W35dQfThgmoh4FZt8vNV190jVB02x+IXA6aN8CwcBYeWhIIVckth
         GjzQ==
X-Gm-Message-State: AOJu0YzTu4Fwj/LeukOQD9rOrqZh5dVEOT8e573QCt5tBbv5p9ilcZta
	3cRpFhXbsxdR5p0LSmqzCnS+Szcmgo67IaNBjDuHeCotfvNZNmQLM1tkeA==
X-Google-Smtp-Source: AGHT+IGjgVGDwb7YREdQLWJrGU4N683mJD0kZbO+LFjgQIHZmkQ8ThYSvmmt2WSw7NtPkyjekLS+Bw==
X-Received: by 2002:a05:600c:3ba9:b0:42c:b6e4:e3aa with SMTP id 5b1f17b1804b1-4311deae9ccmr36410375e9.5.1728679536211;
        Fri, 11 Oct 2024 13:45:36 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a881bsm4723272f8f.16.2024.10.11.13.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:45:35 -0700 (PDT)
Message-ID: <709c69ad-d272-4738-a443-cf57e54841ee@gmail.com>
Date: Fri, 11 Oct 2024 23:45:34 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 02/22] wifi: rtw88: Dump the HW features only for some
 chips
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8821AU and RTL8812AU don't support this. They hit the "failed to read
hw feature report" error.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 v2:
 - Return instead of printing hw_cap.
---
 drivers/net/wireless/realtek/rtw88/main.c     | 3 +++
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 7 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index bbdef38c7e34..942266324ca4 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1917,6 +1917,9 @@ static int rtw_dump_hw_feature(struct rtw_dev *rtwdev)
 	u8 bw;
 	int i;
 
+	if (!rtwdev->chip->hw_feature_report)
+		return 0;
+
 	id = rtw_read8(rtwdev, REG_C2HEVT);
 	if (id != C2H_HW_FEATURE_REPORT) {
 		rtw_err(rtwdev, "failed to read hw feature report\n");
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index a2bef559cfb8..58c7c6a178a8 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1200,6 +1200,7 @@ struct rtw_chip_info {
 	const struct rtw_fwcd_segs *fwcd_segs;
 
 	u8 usb_tx_agg_desc_num;
+	bool hw_feature_report;
 
 	u8 default_1ss_tx_path;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 77399b8dd8cd..01ac07ac68c8 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1960,6 +1960,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.max_power_index = 0x3f,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
 	.usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
+	.hw_feature_report = true,
 
 	.path_div_supported = false,
 	.ht_supported = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 86a5e2497641..bf87c92087da 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2131,6 +2131,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
 	.usb_tx_agg_desc_num = 1,
+	.hw_feature_report = true,
 	.ht_supported = true,
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 66c79956e8e5..44ef2e246724 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1968,6 +1968,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
 	.usb_tx_agg_desc_num = 3,
+	.hw_feature_report = true,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 24f76a36f23e..9b7c383f37fe 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2509,6 +2509,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
 	.usb_tx_agg_desc_num = 3,
+	.hw_feature_report = true,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index da74e66bda84..063c65c269fe 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5329,6 +5329,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
 	.usb_tx_agg_desc_num = 3,
+	.hw_feature_report = true,
 	.default_1ss_tx_path = BB_PATH_A,
 	.path_div_supported = true,
 	.ht_supported = true,
-- 
2.46.0



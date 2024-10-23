Return-Path: <linux-wireless+bounces-14392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCCA9ACBDA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B61C281AAB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5A01D554;
	Wed, 23 Oct 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgJcV5Ac"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83E1AB6CB
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692131; cv=none; b=l+2ThhwpcJxNUYbJqWJo58H7CXqHwFcdl9rPXiTlIUzCCi+RvY7fSSJTsO8giK93C8b7DFPTeuw3SD5le+5CL8oFWg6uE+xOkorLz6NtiaYzsd8ItKrDd2rN3YTq9uPAA9dQ3LwDLxTLPcB8OhMjruRQhqcH9gBivJErXRrohug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692131; c=relaxed/simple;
	bh=DjAXMMTQmzhj9QznqBawqrSYH729VPwlzdTfuzpL/2o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DG/IH2DHWWKls0c6CKB2HWxLoenJpF20cqIKp5SFPpYOmeqmkSP3lZkV7JhFw1q4axeO5qSkP3vLV2355FOitRuOHlcbg7Ad0DUf2KB6jZMxVehMF+MWMkTaBbMRNfjWJhGpYktxDewJBNeermSp/A+naKM7nZKp6VJ07UGFcTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgJcV5Ac; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9932aa108cso1013425166b.2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692128; x=1730296928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fH1WSLInvhJKhcuHrLpxWa3Vfha63tpkgdOGFNN9vKI=;
        b=MgJcV5Ac3To+3MVCbUzw8ZSMovrL8DQ/aUiCAbXaNz7wjyqHdmayRc67rFzgQxTpq5
         OYOGdfydSGs9ZlNXLWFkvxG8uQiDMvv4aImIq1yhSD/8BPLpKBy1oySFVObsyavHc/NX
         U1UGnTtoQLl2je73H/H1R08vsae/LqrTGlt1+XZvyi44jlN8UlaYu3FwUfOanmb1B16Z
         gohlwH3+8HE41wBGxkLG/g1eMLs49KwkS/+HYnJRYNJxWSVS/PNu7GOTzRa0YzoFLZUF
         In2Nh54T91ge3zlH2x4zeHwHxrDxTOJWQCtZCZHOkQbQN/Hl3VkQD1iS8fNBLHHt1t3P
         oacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692128; x=1730296928;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fH1WSLInvhJKhcuHrLpxWa3Vfha63tpkgdOGFNN9vKI=;
        b=cOBh2XMceNBjvxQEq/rI8dTKfBRgYS1mZwQgjD6BtLjo59gvWp9cJXsfuKZgfR2YBz
         zS1evZdc+PJrMzorBTCrP8PugAMguPOemjTYB0361jsXtN1uYTa3p30+566SgJny8Ba+
         v17B5zTvJqoSgr4yXG1VHODKH0Tw8IlkQ42Dkh7NvuswLO1tRc2L99ksymGROnX1Z24g
         fNNHbRkXo8HZskMyAtqcf6E6n06x/ERIboVb3Qyp+gblL5/GDEHQ4OJTNqAiNZ/97WfC
         bQM+yP3CtkICdiX/ic9luVX7c1zG8eXzVFF4XA0yCPHxfhOK0lII+vjXcUxNFQrbvvgt
         OHlg==
X-Gm-Message-State: AOJu0Yxw/CvbfKJrADVyESjKQeph+5qjWy3NG+ABZf42immHaK+/yi5v
	JLWpiuvyP7RZobltID6+PV0jrI+OFZolf/77UgSOcurrXBykD8MNKkoBkg==
X-Google-Smtp-Source: AGHT+IEn2mGVyuXc6Y+MT42Qy7TpmkP6xnsU7zqEvszwcWzvqOgr78crJYYIh09TMYs4vjY8MlPQqQ==
X-Received: by 2002:a17:907:9406:b0:a99:e850:deb3 with SMTP id a640c23a62f3a-a9abf890eaamr252953666b.18.1729692127315;
        Wed, 23 Oct 2024 07:02:07 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91596ff0sm481045766b.188.2024.10.23.07.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:02:06 -0700 (PDT)
Message-ID: <8becd851-8760-4480-8e8c-c4869ce72507@gmail.com>
Date: Wed, 23 Oct 2024 17:02:05 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 02/22] wifi: rtw88: Dump the HW features only for some
 chips
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8821AU and RTL8812AU don't support this. They hit the "failed to read
hw feature report" error.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 v2:
 - Return instead of printing hw_cap.

v3:
 - No change.
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



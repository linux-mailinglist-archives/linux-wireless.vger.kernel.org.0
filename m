Return-Path: <linux-wireless+bounces-22411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A9AA8948
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340963A6D17
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C1224CC;
	Sun,  4 May 2025 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV8uM7b/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7823A6
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746391952; cv=none; b=T1ndDiGzyWy7iRVHbN7oWFAEjon53xGKaX/I5zV45yRYFkStfNeRLEGM0rby//4e7UQnAdzRJDFgOe2XUDEFmc9HQvNG4otk9K7iMMmLpkJR1vCQNCNbiKrSHTARf4dcG4t5VvSADZcKCM+/Dzi8hUf3BdJvAu6WQWwR8wkB0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746391952; c=relaxed/simple;
	bh=GYeXpEcE3rUdawe2LD8j4jXkXMhaHnpIgJ6CwD4mAKY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aZx7yrK3pawSJFwNiE+w6BWWOVtwLv1P+IzwdfwrhGhlHzTft9O5A4sURFS0ZbaTQPbheT9wDz4jJpVEQZsuwqbzdBYNOzHJVihu2Vz9j8jSrKMHP/zO/edKfzxFyNtTJxNaJSAg7uTKzG+iH0r52ZRs532MDHyiPLBK4l6Zsuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV8uM7b/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso6960076a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746391949; x=1746996749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uCs7yVxwPtnPS7MnVRi8OnBTT5LhqkIyim/rfYvNAnM=;
        b=MV8uM7b/tNqZsfqTrRzoZ7XClddS+Tbz140Zn6yZ7La9spUniwEEVVG+Bl44Nf9mDc
         8pVX6RoA3DYHv+qwmR4uOvosx0n1q6zf8R5g8sxi8ZY6CHM3KM6fkXa+puXH5gC89A7h
         uoer0jr6lovdxbdJOhWxC0BfIf3L0rmaqWIa+FNRj2HQVz69USYQKmdadHKJnJvBKA76
         2KljoO5JzPPPBXTxsZQ4RJeN8zFBBNXF9AxPj8/qmYMeg202I2qSO1//3kUH0IUZQKru
         xMpeQUbaHXxatX9t55VIoiR+xtt82IBAS0umTIv2oHGFGDHdPHztxSpYlKMmtstVepzr
         4Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746391949; x=1746996749;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCs7yVxwPtnPS7MnVRi8OnBTT5LhqkIyim/rfYvNAnM=;
        b=MKk4lWyWifVIsjqS/EqqcYC4HMTwu4Cz/DKS81Zsxkqgibrf0WPjt1w5WpcwUHUr1q
         Dk+IP1YN3lgRq8oAtsRgVbxlE73l5dH+n6H3YJaxs7ctLrE38MmRGZXXhpKlId7Txe64
         ERFu8A+rFzC7Bumj6OS79hh9nzpi3NqbFMLNkS1d97/QrAH4zjTsIxwbnm95lhiKQEZy
         pNrMLzECMM2AtKPzEQsVpIp3Y93OrciL7UwoveZPWcQOO+uWFdzzABkRenx8LTJg7Qto
         fzplqFMkvBbcFpH/u+VLxwTeIePmDBxpSuePcLuEebrTryEScrwy6OytOSRWvnZgvCOD
         g4Zw==
X-Gm-Message-State: AOJu0YyXl9E9FWuem3bGM1DWFEA3ZtSQTEcaZ8YIa8QDH5EQbW0tTtew
	tqlScUYGssabRKuQabmU3JJmcvYicV5lVasGE/+dkRTiCJ3NUU2752GH2Q==
X-Gm-Gg: ASbGncsiL5XpqJSc72qM+PsRIULNvG9lkO7EZ3KdKJjawvixUP4oMYw+PjHxLLBwM2T
	u4ln9fNhXArz+8A39JEAxXIyL0hjkFX6U8V2UGlpZsLd40vhE7T7M3/7MphEYH3B9q9QiH6ZFr6
	UoXFi/Zft1UgavE+Qum+aSZVb5mO859P5QelhquICk/xAueFaaDDS2nB7i820F1W0JXB+4x/Y7j
	ydLzpcR3dPzO2MSKoSRjz3VRFoJYg/m38GbO5za6H9fqYjehiy3Uug6/Imx+jp1zwY5rLAa3Vm4
	i81pn0lE/fKMC69T4j1yZFBWdXaOZBJF2DRM+coktRy/9qp/Jo+qKT0Cim9Q
X-Google-Smtp-Source: AGHT+IFf+/MfUhhN4QecRvKS8ElJmdHc6bQv5lAOo0wOtOfWnkwaH3wnCbWhjnjDGgw+RawXUESvOg==
X-Received: by 2002:a05:6402:42c9:b0:5f9:dbc6:d363 with SMTP id 4fb4d7f45d1cf-5faa8030b88mr4994726a12.32.1746391948681;
        Sun, 04 May 2025 13:52:28 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b914b4sm4229111a12.51.2025.05.04.13.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:52:27 -0700 (PDT)
Message-ID: <6038bad5-4a4e-4f99-8292-e37a6d11961c@gmail.com>
Date: Sun, 4 May 2025 23:52:26 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v1 08/13] wifi: rtw89: Hide some errors when the
 device is unplugged
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Language: en-US
In-Reply-To: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A few unnecessary error messages are printed when the device is
unplugged. "read swsi busy" in particular can appear ~1000 times when
RTL8851BU is unplugged.

Add a new flag RTW89_FLAG_UNPLUGGED and print some error messages only
when this flag is not set. The new USB driver will set the flag when
the device is unplugged.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 13 ++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.c  |  3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f17f046e773f..015eb38a5a14 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4895,6 +4895,7 @@ enum rtw89_flags {
 	RTW89_FLAG_FORBIDDEN_TRACK_WROK,
 	RTW89_FLAG_CHANGING_INTERFACE,
 	RTW89_FLAG_HW_RFKILL_STATE,
+	RTW89_FLAG_UNPLUGGED,
 
 	NUM_OF_RTW89_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 1a03355b340f..99f01fff90fe 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -88,7 +88,7 @@ int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val)
 
 	ret = read_poll_timeout(rtw89_read8, lte_ctrl, (lte_ctrl & BIT(5)) != 0,
 				50, 50000, false, rtwdev, R_AX_LTE_CTRL + 3);
-	if (ret)
+	if (ret && !test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
 		rtw89_err(rtwdev, "[ERR]lte not ready(W)\n");
 
 	rtw89_write32(rtwdev, R_AX_LTE_WDATA, val);
@@ -104,7 +104,7 @@ int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val)
 
 	ret = read_poll_timeout(rtw89_read8, lte_ctrl, (lte_ctrl & BIT(5)) != 0,
 				50, 50000, false, rtwdev, R_AX_LTE_CTRL + 3);
-	if (ret)
+	if (ret && !test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
 		rtw89_err(rtwdev, "[ERR]lte not ready(W)\n");
 
 	rtw89_write32(rtwdev, R_AX_LTE_CTRL, 0x800F0000 | offset);
@@ -5842,13 +5842,15 @@ int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex
 
 	ret = rtw89_mac_read_lte(rtwdev, R_AX_LTE_SW_CFG_2, &val32);
 	if (ret) {
-		rtw89_err(rtwdev, "Read R_AX_LTE_SW_CFG_2 fail!\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "Read R_AX_LTE_SW_CFG_2 fail!\n");
 		return ret;
 	}
 	val32 = val32 & B_AX_WL_RX_CTRL;
 	ret = rtw89_mac_write_lte(rtwdev, R_AX_LTE_SW_CFG_2, val32);
 	if (ret) {
-		rtw89_err(rtwdev, "Write R_AX_LTE_SW_CFG_2 fail!\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "Write R_AX_LTE_SW_CFG_2 fail!\n");
 		return ret;
 	}
 
@@ -5972,7 +5974,8 @@ int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 
 	ret = rtw89_mac_write_lte(rtwdev, R_AX_LTE_SW_CFG_1, val);
 	if (ret) {
-		rtw89_err(rtwdev, "Write LTE fail!\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "Write LTE fail!\n");
 		return ret;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 270f40e44c0b..dfff46b92730 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -895,7 +895,8 @@ static u32 rtw89_phy_read_rf_a(struct rtw89_dev *rtwdev,
 				       30, false, rtwdev, R_SWSI_V1,
 				       B_SWSI_R_DATA_DONE_V1);
 	if (ret) {
-		rtw89_err(rtwdev, "read swsi busy\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "read swsi busy\n");
 		return INV_RF_DATA;
 	}
 
-- 
2.49.0



Return-Path: <linux-wireless+bounces-24301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ADCAE229C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 21:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD89189E32C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB0F2DFA49;
	Fri, 20 Jun 2025 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/PZTkNd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFA1CBEB9
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446021; cv=none; b=VdbqN6hbQJuSlmvxtgh5pCS0jxVEKlQUJWsmd/4aKe11/i+YNZcEDLr95TeuA/IJXCluvVCrexQX60i6iPOVwoGzlNG7ZRpZG7KpZd+ogK0WE9WH6aAlHvxvLjMl2nDal2F/y7rFdXQ9mmxECDtVlIPh1wGgAZF9c1ToKmS4upc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446021; c=relaxed/simple;
	bh=EecI4ncXahD5ETI5nx9BJ2S04DDQ9UVnby155D2goCI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sv6+0i9NlJkVr51bVAevLtlPeg0YYMdkpnTzXj+4RJz+Gl4DIIYttChEPiERQA2RJ1fNxAeoQWWoKIh2t9eEO18dg3OGJNjHzEUBTs8H7h5eoBKW5RvXzQ8F7YF25WIW8ESrUHuQaauO4Rqf01VSk+BK+V77yGuJCNt61prXMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/PZTkNd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a522224582so1065628f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750446018; x=1751050818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ZotzCrjHXdaAp0O7jNf32V0khpYTqTtRNuMubg5kU0=;
        b=M/PZTkNdUQQQ4VpbN8VNxKKLFuelw0HG5C38bu4l5rZVjMKlBEQenVwr1Dq+zfzUZS
         1RShX4J4Ro7YQya4rdqbpTNMgIc60zER/8C52jB5xFzjYEUEuIT2vWEcpEZDnx0fMigz
         j4uwK7WkOvFBKzN0bGA8iCJoDRxjforJJI5rds2aH+Vx3CT9a50EbCCS11qhAeALs+za
         RX9NWPtDRUqWRqlRLbt35lBttLkojscAtu+nLpjRyYrfyE3Y8tGvmedbI2tyGm50xzZW
         hXDCS8GqXhKs3aNDH7tSluPr8sygCM0vXHTzxzS9i34wWXN6pK8Cq4Op8bl4z1aHWTRN
         ZZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750446018; x=1751050818;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZotzCrjHXdaAp0O7jNf32V0khpYTqTtRNuMubg5kU0=;
        b=k3GxciNMWooxHGWj6UW5KxNWXqx7dNo/FNWulqriQyPYYmwWH9KfNI/kyLWX2PMNtV
         Hva3lzi7czrbl9pLwakbq5JPQ4053G8G1YcvdsjrvtYO6FHFY7dPTq6n7BS13RpX2O/J
         sYAS2lK0Zk5oJNB1jyPMEqmdEanJ15wCNAk5hvJPMLG06Ku0A0fgeHst58P/tToEngTQ
         UMq7JLg7oKiSBUqkxtFQfJFWrvjAqV7MO5/pa6V5yvW/UwTlnwdqtJEUyTeDpsKDuqp8
         wztlS0cNYuiwbK/oOa/7Pjn1aJ3+dRY9hUjbq0H731zts4Gp35vgOsZUAm6HMg7SE3hv
         vRjg==
X-Gm-Message-State: AOJu0Yy51rUpj6unIsEAEsFkCt5+tgS2qG5itJWXzV2WrijUv2zB4T2K
	2Nf0Y2GoC3hyeI/fzDmIbZsivVNDzvtIFBlzpEvoPLB+fE1LED/wG36uJujlng==
X-Gm-Gg: ASbGnctkefKaY/iTU+ydplt2pT+nIiejDTpvHt9OCFBJV2FLxesLcvQg6CTdskLUMy4
	aCcq1hgyHTs/LIzGS72+ET8OOQdEPPGkHbJS2l1Ef4NtQND+OggtulLE02GRVgSkAhsT2WsYM1G
	Ks2h8LiC8drduXooSWIZK6gFrHmQIeLHIClsTbDvG4ZjOffLCDNkeHYzURJAcJsaRsuMoWCGP1y
	B0HIGLvI1eORVD3t6Rab66n6t4uvhaXRWQPWg/FJfrXrxqc6nAqPMbR14lse9Th6cilKbyTRtAk
	pt1jhmUxWL2doLHEZPC8J0/+t4AfzdwNrOZ7Alyay0vHZydBq67IBZpIQS0m6f/l+lX9Og==
X-Google-Smtp-Source: AGHT+IEzJgUBmVY/nZvGTh9uBhqgJfFR5kJAYzs5Bhd/AK0ieMh54HzL8SbbSSIFaYHwDosIxx6Cjw==
X-Received: by 2002:a05:6000:230e:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3a6d11937a9mr3426376f8f.10.1750446017567;
        Fri, 20 Jun 2025 12:00:17 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45364703701sm33679135e9.27.2025.06.20.12.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 12:00:17 -0700 (PDT)
Message-ID: <29bb2794-73b2-4228-9cb9-969c57b9d15c@gmail.com>
Date: Fri, 20 Jun 2025 22:00:15 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 08/14] wifi: rtw89: Hide some errors when the
 device is unplugged
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Language: en-US
In-Reply-To: <d055bd81-6c79-46f5-8d6d-62185cc65630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A few unnecessary error messages are printed when the device is
unplugged. "read swsi busy" in particular can appear ~1000 times when
RTL8851BU is unplugged.

Add a new flag RTW89_FLAG_UNPLUGGED and print some error messages only
when this flag is not set. The new USB driver will set the flag when
the device is unplugged.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 13 ++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.c  |  3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cab28dc10b4e..763f7ba76084 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4983,6 +4983,7 @@ enum rtw89_flags {
 	RTW89_FLAG_FORBIDDEN_TRACK_WORK,
 	RTW89_FLAG_CHANGING_INTERFACE,
 	RTW89_FLAG_HW_RFKILL_STATE,
+	RTW89_FLAG_UNPLUGGED,
 
 	NUM_OF_RTW89_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b281668c6c87..c018071c94ee 100644
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
@@ -5922,13 +5922,15 @@ int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex
 
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
 
@@ -6052,7 +6054,8 @@ int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 
 	ret = rtw89_mac_write_lte(rtwdev, R_AX_LTE_SW_CFG_1, val);
 	if (ret) {
-		rtw89_err(rtwdev, "Write LTE fail!\n");
+		if (!test_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags))
+			rtw89_err(rtwdev, "Write LTE fail!\n");
 		return ret;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a05841304e0e..46e2b3bbb313 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -897,7 +897,8 @@ static u32 rtw89_phy_read_rf_a(struct rtw89_dev *rtwdev,
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



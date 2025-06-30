Return-Path: <linux-wireless+bounces-24681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DFBAEE87A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E807A835D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7026289809;
	Mon, 30 Jun 2025 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEtKgvrd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179A422068D
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316306; cv=none; b=EQyDJvk+ybrCHDpPS7jlzYFkGcmWZWx5VKA0/fV8sQQZ8Fua5e21+hHTMo0iY5WjdgsKXBgmmILpK1DWzWHb1uI/oWPZik1JhcWYGbmdQKcL8WNsQ6otllbzRmOMLKECrytsUuMkSW572vl7v5pYT1sYFpgYJkzqR3FBnZXW8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316306; c=relaxed/simple;
	bh=oIOkXWhDLQ4vsFvhOthrG2GuncIY+TuNkZgq2eYC27c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=as9So6hZ1W5C71pG1yJsJT0cLku33X8gGrTuOv+RbxXD+EUhQueD/ygL0NnS3WIY9x8QGV5Dt8j1c0oBU5LM17eYdQQovrSOtOXaTo4KggIIbXyOmdKPhB1ewsFPo35Xkhup3TQdOh4azBanm0314GOSbYXc6ggKyEIFBgGo2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEtKgvrd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453647147c6so54068345e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316303; x=1751921103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0sk16efBaotCaTzkHNfWh/oFCNeQVAzZ1AdR93tRuwA=;
        b=GEtKgvrdgrSfW3lj1hfygaexH7CI5oHYyUWg29GjBieI1zC9lGRyyVNqGJBbMJcfdB
         xitlHCTUwXPfCoJjEQsMPuDxan+Qj6ZDr8RsxJGuy/5YWMGJbIFObK/Sf77iz5S2HpXt
         MP/Ufq8EiqIBVITZs7hWfVpDmS5SGjybTriRYRHKWxK1I8bWT+VUfJY9CtBStPayAuEN
         nd06f4JqgPe+UAW2vRxvKBvolRH+InR7vxZEOvNx+Sm6ro0smtxDvM1Zn28ciV742ixi
         U70tJ3J0Jo+223nKGIcXYqdnFl2FhNmMZU7A/j2taUnQww7n/nZt1okg+pawFbf+FzWh
         1RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316303; x=1751921103;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sk16efBaotCaTzkHNfWh/oFCNeQVAzZ1AdR93tRuwA=;
        b=HTlNae0Qv1FNBNjs6tmUAdlCwLW4mDFr6XRDRyJKnXZ+64gh9JP3aV2TfAYWdjsT+r
         5Y8gjQdz7pSrIFxUBz+N01+1BB/Oled6ByWufdRppdQiTJ5BkP5Ehnl+aspIqg+ccIUL
         6TuHNQmao5DfC2CsvBp7zMBzX7eeaLKR5RsTdKuz7Wrs72f6UnI+pcHpn4i0380xL0Ns
         OkSUbeg0xFGh91diT0zV+Wl4BIeb4M6r/x0lmEloGb0/v1fjULmeJv0w1MgEL66JByLB
         EfA2AYsGDng5FtRTcfXXwYQ0VPrQyeWtFF3AvuOD71sUZw9vSoCtgn2sL/65A0kbWdXX
         9i/w==
X-Gm-Message-State: AOJu0Yw4sT36TL+pfi54kpeIh0UIXsfRtv2Wdj9XzGppxJNoFTBr67Du
	V4VcglgkSWfDn4EJc+81d770/qcg48+JIjJXd7cNkINuV0bS+lhakfDr5OvvwQ==
X-Gm-Gg: ASbGnct02bJzSD6mAFQqpgfQuCjavna/QkJRevG4AOCHs2DbGgFXpdalWpieoPFha9Y
	RW4QZUF8ngUsdHxBoj42KnEO/mhC5HW7ZVsCnxHv1oojEc7ntZzKrdnPwXmz0hkXlNwxgvdaUnp
	A6Z5G0Fzj4hehP5UufcKsWb/g6VsgdNfZDQojIvNjqCPo8JsY0sx5LxPbl/l5BREulGgOfLqrxk
	eBxA++4wuueVVP4K18QgzSMOwX/7GryU3vIB0SAb/WApIHkRqezkxa/oMF2GobQrOD80LRVJ8m/
	A34c0tYs0dyUE1iFgouM2IGHSjIzVpv0JI724TDICo75xz2CnL+qSWwEWmoUZkC7uOsCiw==
X-Google-Smtp-Source: AGHT+IFaN/I9ykO2Hhuqc+fC6Q2oNkXuNiAP6LCrFGSpFnu/YXe7NhZadJZOMp1cu1O0xjIk4N+MhQ==
X-Received: by 2002:a05:600c:450b:b0:453:9b7:c214 with SMTP id 5b1f17b1804b1-4538ee5dd61mr138264615e9.29.1751316303254;
        Mon, 30 Jun 2025 13:45:03 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45388888533sm156906035e9.21.2025.06.30.13.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:45:02 -0700 (PDT)
Message-ID: <cc18b739-6f38-4c1a-a681-1e2a0d4ed60d@gmail.com>
Date: Mon, 30 Jun 2025 23:45:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 08/14] wifi: rtw89: Hide some errors when the
 device is unplugged
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
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

v4:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 13 ++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.c  |  3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b996afc77862..b70d80c112d1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4994,6 +4994,7 @@ enum rtw89_flags {
 	RTW89_FLAG_FORBIDDEN_TRACK_WORK,
 	RTW89_FLAG_CHANGING_INTERFACE,
 	RTW89_FLAG_HW_RFKILL_STATE,
+	RTW89_FLAG_UNPLUGGED,
 
 	NUM_OF_RTW89_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 4c469379be6e..877944cbb8da 100644
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
index f81bee4149bf..7d005db211e5 100644
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



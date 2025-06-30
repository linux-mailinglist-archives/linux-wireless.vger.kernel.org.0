Return-Path: <linux-wireless+bounces-24682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9FEAEE87C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7408189E86F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE561EB5B;
	Mon, 30 Jun 2025 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM9/yI9+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65C10A3E
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316338; cv=none; b=DWdQn35I1BEVwNR8+5qe2kvShPAeXtqdF8c9IXip4UhiYmvoPXCk6oBLefnEmwPDK3GbOn/KYy2f5U6xKLAPZvB/wE1c8mgXjGn8HyFpiL9SwUyRDZ3y2eu9IuZsuJGGN2xXgRmUOCqR0JL3H1xEva5Wr8VFPpJqHojqZlooG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316338; c=relaxed/simple;
	bh=upb/Z/lLXLfCQ2Fw/83FTfyHXDkXVsVCvKVxN08WB7U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l430c8ohirwjJiUtihp91MjLHEJHephswT/lPc4scgIyHFPTFMfdySj+Yg368xKEdBm4MDI1fgZQ3yn1uD+UwLSEHCCttX+mDGmEqMN+VTAwjvi9V2v7wY2O13/MbvVhxuYAKdDpGRFQ8UYfqEoq9+huLpk/oyhXGiYq8J5ToSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM9/yI9+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso21668685e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316333; x=1751921133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qqaXVutAVkV9Hy+Cn9BU9NLTulCag2XYYDbPpxP0260=;
        b=VM9/yI9+v2aB5AhQdM7w92gNVGyBojtNjrHm5OgnV+p4MaeeZjTHDdAJ18XwjTSw7I
         F9AKbmVQH4IGMHEIBc27Jg6oqa6TeMyFp7MqUvRsJMQwibfOHvFdZW8twdtvcOJqGe3l
         7FgN37CNdmg5ywW10MZw7vkbNL9hn3lvWGJvbIgYn1ZH4paaGg/cH+mYxU2BmkC1EXkX
         N8DfPGKxp0wrPETCF4MXbjH8GmkhsLPv5YUHtuWkIaNGvOBqS3zFtYJ2oehsCuLGwDQ4
         ZZGg4gxyB9mTSl9kopup8kwjEGSqKfwoBVq4nfb385LCSxlptzm5b7EXGX/2bt92NvGB
         kdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316333; x=1751921133;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqaXVutAVkV9Hy+Cn9BU9NLTulCag2XYYDbPpxP0260=;
        b=Skb5Erfe+fTWBCQvE0pLvy3ZUoNH3LyFtJsBA0WjJz7pn7RsXOjdAEWDJo7seVfEAc
         OXc2XlSHwUwjNQyMyeYn3QUkxOvb6ZDP1/GOyKiWXTVBWikvt1Zr2xtEU1/J1TJ/k294
         LOa95w512e7wd7hpuHQQKFto/h56yXyuhR7A+Jt8DkXppGnB+YS6M/xQ5mqC4tGM7932
         QiP5a/8Fr3JiEKoO0FBnk/U4+5q7wdu49ldugnvbeFsbe2ph29bvxCGtWZK/VuDxIqxl
         yE/Zhyms35X686X0l6MtM/osHzWZDK1zk7rbWTQTAOAYE1xgspRK79PfX5JbEZW3ZRt3
         CGfQ==
X-Gm-Message-State: AOJu0YyRlrT8lXE5CSXEZKwoKzKvY5KNrc+PHCsEcZG5NqZZq1L+ObDK
	LM6st+5PGlItxvPuKkoXko098FsrVt+8XQV5Orbm/7vxcOT4SH7j2/W73DIZ+Q==
X-Gm-Gg: ASbGncvIEV/YgdEVdhxKpNhJ0BA2kdHTVnJr2QQzoorlZn6i/TIJrttNqhVkZDvNgGE
	iFj46CuVAzC7/X3r6h/tsSzMQz6WetAMFxsk7IURy537EQJDzx2IG5r7hUIBbfvihG+4OhDnopR
	S215mNvy50sjPQxjEAQaSCb+lRzpzqVg1RXxG9CKS6qShOwwpVLU4wc97e94S9lfdeWQqtKMx2o
	Nq/MV9gV/iE3WXj+sLD2XL9j5gtALqTiT4mq06L9cwaMxMC+hpI3m5smRb39JwAonQ6kSs8uqxw
	1hNUep3z8xJwefXSCqcUFDOykAHmFWCE3trFo+EdDJx770xCw/bk5e5zrzC8MjCGSgLhlw==
X-Google-Smtp-Source: AGHT+IEXn5ApF8RZczn153srAF+UwHE0mengTFDGsHTrzIjqwFtKTxIp7eC4l9HTt+QGrMYyhZ8NNw==
X-Received: by 2002:a05:600c:314c:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-4538f377598mr142654785e9.5.1751316333075;
        Mon, 30 Jun 2025 13:45:33 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fb20esm11499412f8f.36.2025.06.30.13.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:45:32 -0700 (PDT)
Message-ID: <469f6882-1859-464d-8a84-9ef1b6c8ce3e@gmail.com>
Date: Mon, 30 Jun 2025 23:45:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 09/14] wifi: rtw89: 8851b: Modify
 rtw8851b_pwr_{on,off}_func() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are a few differences in the power on/off functions between PCIE
and USB.

While the RTL8851BU appears to work without these changes, it's
probably best to implement them, in case they are needed in some
situations.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Patch is new in v2.

v3:
 - Add B_AX_SOP_EDSWR to reg.h, which was accidentally missing in v2.

v4:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 22 ++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 4a65b0c9c2d1..c680441232fb 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -21,6 +21,7 @@
 #define R_AX_SYS_PW_CTRL 0x0004
 #define B_AX_SOP_ASWRM BIT(31)
 #define B_AX_SOP_PWMM_DSWR BIT(29)
+#define B_AX_SOP_EDSWR BIT(28)
 #define B_AX_XTAL_OFF_A_DIE BIT(22)
 #define B_AX_DIS_WLBT_PDNSUSEN_SOPC BIT(18)
 #define B_AX_RDY_SYSPWR BIT(17)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 5fda45174dfb..f03583edec58 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -385,7 +385,8 @@ static int rtw8851b_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write8_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 
 	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
-	rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
 
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_OFF_WEI,
 				      XTAL_SI_OFF_WEI);
@@ -430,8 +431,9 @@ static int rtw8851b_pwr_on_func(struct rtw89_dev *rtwdev)
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B14);
 	rtw89_write32_clr(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
-	rtw89_write32_set(rtwdev, R_AX_GPIO0_16_EECS_EESK_LED1_PULL_LOW_EN,
-			  B_AX_GPIO10_PULL_LOW_EN | B_AX_GPIO16_PULL_LOW_EN_V1);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_set(rtwdev, R_AX_GPIO0_16_EECS_EESK_LED1_PULL_LOW_EN,
+				  B_AX_GPIO10_PULL_LOW_EN | B_AX_GPIO16_PULL_LOW_EN_V1);
 
 	if (rtwdev->hal.cv == CHIP_CAV) {
 		ret = rtw89_read_efuse_ver(rtwdev, &val8);
@@ -515,7 +517,10 @@ static int rtw8851b_pwr_off_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
 
 	if (rtwdev->hal.cv == CHIP_CAV) {
 		rtw8851b_patch_swr_pfm2pwm(rtwdev);
@@ -524,7 +529,14 @@ static int rtw8851b_pwr_off_func(struct rtw89_dev *rtwdev)
 		rtw89_write32_set(rtwdev, R_AX_SPSANA_ON_CTRL1, B_AX_FPWMDELAY);
 	}
 
-	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
+		rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+	} else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB) {
+		val32 = rtw89_read32(rtwdev, R_AX_SYS_PW_CTRL);
+		val32 &= ~B_AX_AFSM_PCIE_SUS_EN;
+		val32 |= B_AX_AFSM_WLSUS_EN;
+		rtw89_write32(rtwdev, R_AX_SYS_PW_CTRL, val32);
+	}
 
 	return 0;
 }
-- 
2.49.0



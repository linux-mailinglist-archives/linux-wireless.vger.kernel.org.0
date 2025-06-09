Return-Path: <linux-wireless+bounces-23900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 954A3AD26BE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5A018894F4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D85B1922DE;
	Mon,  9 Jun 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdFSD1PU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914F38DF9
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497408; cv=none; b=ULgIJ/4aEEmQ4DQbdfkOTV+08rcJefUKs/nu5ewkzWkzPRHWuCUGk0A1WhA1ST7SqjxH6ZtPZqgvOJrGxJaq/PKwv0+oSELv16QQuyyUbE29q71SRGdjk98PIwUJ8Ny4Ag0rXqmaUwXUAQOXLXXIZ+8QUzadT3KPX8nSSkm+3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497408; c=relaxed/simple;
	bh=CS2fAuG0A+bpOrLLie2QhLogYfgoDvdojPJQ1F9crfU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VHPS8M6dnEtQC+aBuxmytYdxu9d0ROv+z13stjiwr9HlxQPdF3eJINwOAHMB5hqQuZn69h0vybtevT+8tFtM47o86k4KAm/3zrIACrOoMWd7CntN41vc5E1aWlym50gOVlBqsY/5b3PXrWyqxI+Oj7C8feLmJYbEeiWu/R+dYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdFSD1PU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso5477898a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497405; x=1750102205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/5qbHu4E+JFmWHgDmTelQjxvod01GN5J3P8cps/tIhk=;
        b=JdFSD1PUqtbIWhO6w4oIB8BHOAnLbuRug6os1YhuKJaB4dgg4XXV+d/UkgjB/D9CLP
         67jcvRLaQh3IAd19NbBfVkBEz99zleZgvShP026h4L4VvU744+vOJSHZwjAMe3KqL2y/
         E3Uf4apwbbM+H2A1jQ9vLjvyV3NxUGbCMeL685/CY7daCNSbLnIGlYErjnAO1dAptrbV
         olSin7sy+UUKr6jWjdS0I3znLqOXb0f8zZpoYjKQPE7QbtH8hOXEt8M7Yly4wlagRlbv
         2BxL4EuVumh8ulJEblQL8O+jG/hJfw8XJ8W4Z3IOnCfavh4G1/gwYTgmWEqQIowRNGp3
         amNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497405; x=1750102205;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5qbHu4E+JFmWHgDmTelQjxvod01GN5J3P8cps/tIhk=;
        b=Z2eDeype2bknvD8rof8WiyE7bWixgwf8RP8LXdQy/5iIUTsiN3qvfaK3tXGAW1lEpn
         5MDI7Aay7fMfjSBV1YIMG82jhIkNlMydE05u+vc5RgN4Ki2qE338+Yw2ttOicbk4jL5B
         c7zUqs3hPOuDplYsNEzEJm4m90aWbcRCnVQroHc7EN+DB6HKAs2j756TPYeKIGFAY3Do
         rUe2QEiTDcyIwI8RpgefplIlvlKeFZroGYGceVbF2is2qASZs1jF8KDn4t9tM5sosMY7
         kaGzPAivGmLXIu2hkbglfqloJuwbs8AZ9QK1vzTLhCB3H2aZRL1Z9DHmj2vMylZevXzE
         WpnA==
X-Gm-Message-State: AOJu0YwzuG5BBv1XKBZPqJnzlGKqugo9DRFlyKRz7zl1frX4oK0cxLiD
	gmyBoZB1ROwpqXAi5QY6TJt80MYqp+zHe21U0VNLgfcWdIPA0MPYzMvfCuBHZQ==
X-Gm-Gg: ASbGnctKAsun/BNkvwhvyf6SgCFWJaHCfL/JMDKscLWFKIqFOYCah8Ir4L/rlnHbMhf
	NdBQTCKtJvBesG+bN3P6tt9IAKc7ZOKvG1q/Q+pgi41vdHOV4tlxwauCl5O8p4oZK3RrsX/hD9K
	6zCtzVRUCEgQvp5gQMzj4YeTu8vHKAWrL5LDRSozZgtahAhK3/2pa4JShAt2f0Dzt5JU7UlNicP
	TbgeZXff9E4xWc3CGMhtD+Fr7Nhdd9Tv7vPlN7ryM8juSw+uZJ3LCjxiHhEyP/h8wlXbApPwWXJ
	4qO3Om1tkezZ1q9AwHURtwSvEwXQv8rM5doKVU2BQqt/TIKx5c+d+oglQxM=
X-Google-Smtp-Source: AGHT+IEYxkwxSv94AXBjt4/RCd8Sk/wLH2zrD2yPwOWzQSPYTP0+BEdCAkiUBys4wL2toqD8RQRF1g==
X-Received: by 2002:a17:906:c145:b0:adb:23e0:9297 with SMTP id a640c23a62f3a-ade1a905877mr1440656466b.17.1749497404957;
        Mon, 09 Jun 2025 12:30:04 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db55ccdsm587446166b.44.2025.06.09.12.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:30:04 -0700 (PDT)
Message-ID: <c1ff2155-ef01-466e-9c34-4437ee57656c@gmail.com>
Date: Mon, 9 Jun 2025 22:30:03 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 09/14] wifi: rtw89: 8851b: Modify
 rtw8851b_pwr_{on,off}_func() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are a few differences in the power on/off functions between PCIE
and USB.

While the RTL8851BU appears to work without these changes, it's
probably best to implement them, in case they are needed in some
situations.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Patch is new in v2.
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 048e64fa1d51..febe9b7afe59 100644
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



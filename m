Return-Path: <linux-wireless+bounces-28463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB93C2863E
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838BD3B5F61
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F047256C88;
	Sat,  1 Nov 2025 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK7SVpYB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A738FA3
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025084; cv=none; b=QbUcBrrzsXmXcLsvifW4/jQw/WxBGxwQVpidSQUlNdrz05kQ2e2Pr3Mx5cNc+rf+QFDsIax1kuAfpcvVdvgKfUR68wrGcHrJ5AffJsVurpv/g5syJ43tOU4ENu8MQbez8roa/m9gTZyd9H1NR3eTKmBwaRY+mp9n0xjv3eU6eDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025084; c=relaxed/simple;
	bh=kjCufC/49XUai6xeYIOjT1uqAyswfTa7xu42QUpjD28=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XnEfkUQAqgYe2/JrohyHryuCgOqOPEzckxElsQyRU1ujhLQLqW2rda8ZSwZPWE57XDUNIvIE5txeVoVGfLIzNJV5xzW7H12tK8R6yNYV76Iu+O//cY9iFCx7lP3fpBb5F8PTjm8t2hwIxwfSRiqHsEkqj+pZLOfPtiA6BtV0ESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK7SVpYB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4283be7df63so1676548f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762025081; x=1762629881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v0k2rvdPgohLtTRIcpVtqsB+ejpIhvQowr3JgImZFyQ=;
        b=lK7SVpYBEXt5/1OHuJOthc5X1e2awArRvqnCkMLi1kOhdPeEW2nwaJlfFGTZE2RqKb
         pTe75yq5EQiDawJatSUPJNVI8WVF2j2pvObRPo1HPaP2aSxEkX6yvs99sGkKbEQwQEz9
         EVtCAXxGtB7oAHDJoqYbjPg4xTNrl/2hPuO78lU+4ahfJY1mP2C8Q274dANnE8yJmHF4
         x7f3h77ABQK7QtzDHkaM3bt79FAnN3IMRT+Pks7GRxMyLiytBc8p+N6k6fdoweknMihQ
         h7wjGTMV432Q0hwze69YQgAsGHhVGTJMXNnexc4rYOWSkil5LQbdZ2URYyTEjMhRP8kq
         a9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762025081; x=1762629881;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0k2rvdPgohLtTRIcpVtqsB+ejpIhvQowr3JgImZFyQ=;
        b=WEhBp4XWr1M+VLkl/E7fLpTWHqN8+nxU0CGFZrKyNqpyM6CTjYrwlNAJsB12ZnA20W
         nLeKKZ7tpd+zFj+coR9SgLPA1R0qfQqmeUkMkSblQR2oAwxELvvTD5nTTkVbdq73O9El
         WGcA28cKYDUKX7pI59XqCJhQj54MCnm+wUObsIicd8rSUg3zSB+xQzygPfaFK+k3eP/F
         VW+W58p3iK21GIYAMMfNqXSVVKssayeKFpsjKiqIuDOrzxPgIhnyXhnjp0HIH/mf1nn3
         ZVkfEWEVuwYMefVwFv+sZxnSwRanyoSM04bjLULagNSCpzEWbOwXyHpEMXHYHy3rvbNm
         1/Ag==
X-Gm-Message-State: AOJu0YyNMq13ZgxYwHt5yuA+f0f43J3kGJejmyJQ5NueJ/1DcR8/pgD3
	pg31zMIvL7rxmi8AkPYRapW+tVW+E1t6z/37Czu1nzidaNVNLNDmd7J/tTyjOQ==
X-Gm-Gg: ASbGncvyidFMYFFK1Xv3ifnVwqHyWA8jibA4WDxPvLTzRqL8h9JvvNybcaJur8q7MRg
	5HXvXhmxiITjoaIAJscBtzgHHEfCJS4bWNIVjFVHyvRB+fZggv25B0+XmhdCWIW7MFtqY6MtG7k
	W/bgX+SVlM6jkRji8PmO3ZP/lLR2+66F6FQYFZSSmC8oFO6yD2Jd03I6dEHloLaTuBwgz3BUAdt
	NrGCz0wMpEuKtCE8n01sbPZIR97B63zpww3UOIB9eCClsigQF7Cvbc7xsYwz9XjC7XzqvznMej/
	FsZIi2VmLR29iOds6xHMs10Gja0g2awyK7Dh7q4eEFGYrUCg8BY0+US7HclZqrZa5wnmUV9zRnE
	m8wzSc4OGv1UjrZOTDt4wWZKRUy6iRYPho0QWmjN1N3D13t3SCjmYp25ephwnU9tx6qg7R/fpr7
	Nrj3TNveJtaME6pBNANz4=
X-Google-Smtp-Source: AGHT+IHpPsVyINsS6xC0sQl7LZ9lhQrU3hQBZP/AlAoRWb4eiMr8KFSGirxvBBXwmht/f8d2QEhZpA==
X-Received: by 2002:a05:6000:228a:b0:3c7:df1d:3d9 with SMTP id ffacd0b85a97d-429bd69ffecmr6716635f8f.39.1762025080707;
        Sat, 01 Nov 2025 12:24:40 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c54efcbasm7062666f8f.8.2025.11.01.12.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:24:40 -0700 (PDT)
Message-ID: <598dec66-b5cc-435a-bcf6-fa66577f8cfc@gmail.com>
Date: Sat, 1 Nov 2025 21:24:39 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 07/12] wifi: rtw89: 8852c: Fix
 rtw8852c_pwr_{on,off}_func() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are a few differences in the power on/off functions between PCIE
and USB. The changes in the power off function in particular are needed
for the RTL8832CU to be able to power on again after it's powered off.

While the RTL8832CU appears to work without the changes in the power on
function, it's probably best to implement them, in case they are needed
in some situations.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Add Acked-by.

v4:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 31 ++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ee1915307376..6aedbd03e3d4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -214,7 +214,8 @@ static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 	int ret;
 
 	val32 = rtw89_read32_mask(rtwdev, R_AX_SYS_STATUS1, B_AX_PAD_HCI_SEL_V2_MASK);
-	if (val32 == MAC_AX_HCI_SEL_PCIE_USB)
+	if (val32 == MAC_AX_HCI_SEL_PCIE_USB ||
+	    rtwdev->hci.type == RTW89_HCI_TYPE_USB)
 		rtw89_write32_set(rtwdev, R_AX_LDO_AON_CTRL0, B_AX_PD_REGU_L);
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_AFSM_WLSUS_EN |
@@ -246,7 +247,9 @@ static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write8_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 
 	rtw89_write8_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
-	rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL, B_AX_PCIE_CALIB_EN_V1);
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND, B_AX_CMAC1_FEN);
 	rtw89_write32_set(rtwdev, R_AX_SYS_ISO_CTRL_EXTEND, B_AX_R_SYM_ISO_CMAC12PP);
@@ -305,9 +308,11 @@ static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B14);
 	rtw89_write32_clr(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
-	rtw89_write32_set(rtwdev, R_AX_GPIO0_15_EECS_EESK_LED1_PULL_LOW_EN,
-			  B_AX_EECS_PULL_LOW_EN | B_AX_EESK_PULL_LOW_EN |
-			  B_AX_LED1_PULL_LOW_EN);
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_set(rtwdev, R_AX_GPIO0_15_EECS_EESK_LED1_PULL_LOW_EN,
+				  B_AX_EECS_PULL_LOW_EN | B_AX_EESK_PULL_LOW_EN |
+				  B_AX_LED1_PULL_LOW_EN);
 
 	rtw89_write32_set(rtwdev, R_AX_DMAC_FUNC_EN,
 			  B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_MPDU_PROC_EN |
@@ -385,12 +390,24 @@ static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32(rtwdev, R_AX_WLLPS_CTRL, SW_LPS_OPTION);
+	else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_SOP_EDSWR);
+
 	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_XTAL_OFF_A_DIE);
 	rtw89_write32_set(rtwdev, R_AX_SYS_SWR_CTRL1, B_AX_SYM_CTRL_SPS_PWMFREQ);
 	rtw89_write32_mask(rtwdev, R_AX_SPS_DIG_ON_CTRL0,
 			   B_AX_REG_ZCDC_H_MASK, 0x3);
-	rtw89_write32_set(rtwdev, R_AX_SYS_PW_CTRL, B_AX_APFM_SWLPS);
+
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
2.51.1



Return-Path: <linux-wireless+bounces-6351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145498A5CBE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 23:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4587C1C2107A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054EC156991;
	Mon, 15 Apr 2024 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaMl8iXU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6E156974
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215718; cv=none; b=EJbtBV2ihP5RVvVl13pVCh47A7eeAt2ABMEwy+gnPWHPgSpF3jGLeSpN9W0oCdI6htUOv8KdofAcYaKliG/HUW69IVDKLH442RFc7wyEWpgog+e+Et7NQsjvpIlOaXpkFuc63lbcFEHA/1rq+glEr3JfMUfCG68uroZICuduXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215718; c=relaxed/simple;
	bh=tUo7yqhMBS5hjaeVXjavtQNbKocs3UMmelYRylJ9DmA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AxFn8rhY5E0saHFbbwHpQRzow3Ix8jhjnffMdq1JLyUcYhNyg8DJ64oQLFMi2jUlC4msgBvU5W+fstkVfRw6fiLedCHzjfiZtIWaGxEZfON7WD7VasAQphDLCMPzBwRFQqCj8uz7RWoSf2qvKq0ONy1JOw5PblvhFBTGM0gcdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaMl8iXU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4155819f710so25264565e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713215715; x=1713820515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI08lRHhgEFPQptPrk8NBN0W32sWGe/abqdIgLhsOg8=;
        b=VaMl8iXUC3HLeOHIe42fOFLGEomVKX0HF05CNGr+toRerBX1q0AELZPgEARI0f+ex+
         AIpE6B0E+4MAxZ4fZTEtOPYESE8YfewVrlTq83MIi9xsQx9Gz/BbFIsrp0hUUS88G1zL
         XgaRIcjd2Gcq7KYif0/1w3lTcdNWi8fnHfQ8W/ate76thDA1jEOOh03lnpyCVE+6ao9S
         aV30M9OPfvNOQQAY4lEmY95pbXOCphFJWSNELWhjCjBCd/p2rQCNFDLt0oDuFTTJLBfk
         Xs7d1EPIyl8Z5f12vvQrxnEV4ZFMI2nS0bROWZoOwKfNU34duFJuSMfLsxw8/GzXNHfd
         NvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215715; x=1713820515;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zI08lRHhgEFPQptPrk8NBN0W32sWGe/abqdIgLhsOg8=;
        b=UXf/khI4+3mlxe8WNeJ5e2fgnCclPjMlYXZEprvaWd64euQsbrlGwu8BZGCpUXfy6y
         agcDuXrfgMzQgF4BnUbMM0HhWZOwlNkRoLg0UCIq1pf135cPaiwCanUskoH5Spq6v5bE
         9mcwVC2WFdddEPXbv2c0ah7zeCpxBjrpkk04q0+cS/ay6Xz0o+loSEDxykq79Ea1TccA
         xW1TKPzNETSHtG4zSo4WTkYolC9SSKWXxYFetuOxPJYNAG8MONSu238/xmeKwlnL0dzU
         wEtnRccFNmv0/YTn6ge+Wcbx6/YUlfS2wopQ2OHB3/ESuvbjGcrs8JqO9Wzb8jkXczMj
         o1og==
X-Gm-Message-State: AOJu0Yz1inWdROPFQOsLfCndJa+INk1m49prTSyxC1aJbSqb8Ef+zWQd
	P8gLqD1SFU843RKhT7qepic8wOTyS/X9jrvXjtDclvk/hbL7/62t4Hl2wUC/
X-Google-Smtp-Source: AGHT+IF4wzGxTKn8rx2NHX4b+JxrGX+gbzJILsw4lWeX9yz2oHuGhs5DvRMaQZ0Vow8DkbezXXQfCQ==
X-Received: by 2002:a05:600c:3acb:b0:418:8b70:47de with SMTP id d11-20020a05600c3acb00b004188b7047demr322462wms.8.1713215715535;
        Mon, 15 Apr 2024 14:15:15 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b00414659ba8c2sm17650820wmq.37.2024.04.15.14.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 14:15:15 -0700 (PDT)
Message-ID: <6a0698cc-9389-414f-b172-7046bec01b3e@gmail.com>
Date: Tue, 16 Apr 2024 00:15:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Add LED control code for RTL8723BU
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tested with EDUP EP-N8568.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 9640c841d20a..c677a47ed46d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1701,6 +1701,28 @@ static s8 rtl8723b_cck_rssi(struct rtl8xxxu_priv *priv, struct rtl8723au_phy_sta
 	return rx_pwr_all;
 }
 
+static int rtl8723bu_led_brightness_set(struct led_classdev *led_cdev,
+					enum led_brightness brightness)
+{
+	struct rtl8xxxu_priv *priv = container_of(led_cdev,
+						  struct rtl8xxxu_priv,
+						  led_cdev);
+	u8 ledcfg = rtl8xxxu_read8(priv, REG_LEDCFG2);
+	ledcfg &= LEDCFG2_DPDT_SELECT;
+
+	if (brightness == LED_OFF) {
+		ledcfg |= LEDCFG2_SW_LED_CONTROL | LEDCFG2_SW_LED_DISABLE;
+	} else if (brightness == LED_ON) {
+		ledcfg |= LEDCFG2_SW_LED_CONTROL;
+	} else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
+		ledcfg |= LEDCFG2_HW_LED_CONTROL | LEDCFG2_HW_LED_ENABLE;
+	}
+
+	rtl8xxxu_write8(priv, REG_LEDCFG2, ledcfg);
+
+	return 0;
+}
+
 struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.identify_chip = rtl8723bu_identify_chip,
 	.parse_efuse = rtl8723bu_parse_efuse,
@@ -1731,6 +1753,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.cck_rssi = rtl8723b_cck_rssi,
+	.led_classdev_brightness_set = rtl8723bu_led_brightness_set,
 	.writeN_block_size = 1024,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
-- 
2.44.0



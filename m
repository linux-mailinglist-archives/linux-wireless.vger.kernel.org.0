Return-Path: <linux-wireless+bounces-6567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3FF8AAE00
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 14:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663DDB21988
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B723983A09;
	Fri, 19 Apr 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOUWztyH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC68121F
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528125; cv=none; b=TyHj3XypwcUJw8CRc2XbLN5p5h3ETIErWv9vSZzllYg5OgIAdhGAkN2SRj89GUU7JxvDeioh9wzySm0rZaRDrs0ICT8aN4MzlqWRQXlfVpQUKZmaij+VI/EW/srjL58qnE35omDiURx42Su9xHoTy+Cjl6OBP6XrtIf4oOLMdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528125; c=relaxed/simple;
	bh=dy4psp5CrOuKFTsF+lf42ngogDtUf1sVitk5/D2tRqo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=loPPen0U6SzJaeXLO3lRCVF2TjIjXSRATD++tOpUYTyRHp42r/GVsx/BNKS0GRLcWmeyueLSelXPFYRWA8zaIk2DKCNE33gK7CxNXtg9FZXTEWb1R1wIDFEESf8ITGwuIfbifXpGll/IcqnZ1GPOIC9M2e4BIqJ0YOvTDoEuz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOUWztyH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51a1c8d931so206796066b.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 05:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713528122; x=1714132922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VnJJkejOTaCErEeemJEUgt5nOCBUvxwcNGMkliGyXA=;
        b=BOUWztyHSfDGkKHNiONJsXgiulozXGSfA/jDhGOWub4dzc08wjvIikc6uk4JEcYnzv
         xHu0HyONM82DOPIYufaSRSYuu4E8yxzA4NQ9SAbMrOBDOBRPDy//lmUYzU0ZosGpMO3S
         0/UhGg38IZ4/p+XX9IWmxI/MobTZ7dGChspvclOunyp0Df7lLWKayPE5lrKj8f26Lwwe
         ptJNvIb4TgrUGRCaTRVsSLEWMmW8FdUHRpBK0ka7UrIbrfUZQL3PgptWY4LaiptKntK2
         bIqLujhcGy1/iueT2lfMNE+18G6LpTQP4/AhVkFPnrwJmEMzXfBUpuLZ8FQMpcji9AOx
         aGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713528122; x=1714132922;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/VnJJkejOTaCErEeemJEUgt5nOCBUvxwcNGMkliGyXA=;
        b=WHIfFmLl7OvCEgREMla93NXBDNS6UOzxewZ/jZDHFD27II59M4uv1GikHQkiz45Ic/
         3tpYvWVGyCEuTK2qTxxootVyOOKBopg4KJ1l1bOunEmxQPbABBWnJ6g9nfPWbMtGfCVx
         q6wicmX2BqPM1XD8t1yaQ4plOTH9WUFIQ5ALYEH2UhYTv0JF56lF6OLTNiy05bi/gkAn
         XwyAoaD5OArJBgLU9kRroCxGH62BjsMa0MGGeqrh3TKb9KNZlwrvJqFwrvkmlBiaLNTq
         L6x9gtCNLTlg2Fx/cowBBLGXguZU5ahXNIqheFA2H+El1j1vXszVJvfCirewmqOuAV4Y
         6aTQ==
X-Gm-Message-State: AOJu0Yy4TTVkgh5/uzXfTWPOnK7Ue1pfPIu9l5YlxdJa8J1kQiebLbJD
	JMFNVrkUC58i5C5geQGRtazvBlQnb3/BQzpeLleYdGbqNygy4gGAisa9T2ZL
X-Google-Smtp-Source: AGHT+IE0LL2ppWt/wDy9nSPTkEZPRr9Jn0Q3uJLrLN/086Q9rzON405wZ/FNy1xeRiqfLNUjF+fH8g==
X-Received: by 2002:a17:906:6549:b0:a52:645a:8ebd with SMTP id u9-20020a170906654900b00a52645a8ebdmr1349529ejn.14.1713528122066;
        Fri, 19 Apr 2024 05:02:02 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id g2-20020a170906348200b00a51da296f66sm2098126ejb.41.2024.04.19.05.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 05:02:01 -0700 (PDT)
Message-ID: <2e3b0b74-8bfc-4ff3-8a0c-ba1bbfa4d535@gmail.com>
Date: Fri, 19 Apr 2024 15:02:00 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v3] wifi: rtl8xxxu: Add LED control code for RTL8723BU
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Software control (on/off) and hardware control (automatic blinking)
tested with EDUP EP-N8568.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Remove unnecessary braces to silence checkpatch

v2:
 - More information in the commit message.
---
 .../realtek/rtl8xxxu/rtl8xxxu_8723b.c         | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 9640c841d20a..de01e21589c5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -1701,6 +1701,27 @@ static s8 rtl8723b_cck_rssi(struct rtl8xxxu_priv *priv, struct rtl8723au_phy_sta
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
+	if (brightness == LED_OFF)
+		ledcfg |= LEDCFG2_SW_LED_CONTROL | LEDCFG2_SW_LED_DISABLE;
+	else if (brightness == LED_ON)
+		ledcfg |= LEDCFG2_SW_LED_CONTROL;
+	else if (brightness == RTL8XXXU_HW_LED_CONTROL)
+		ledcfg |= LEDCFG2_HW_LED_CONTROL | LEDCFG2_HW_LED_ENABLE;
+
+	rtl8xxxu_write8(priv, REG_LEDCFG2, ledcfg);
+
+	return 0;
+}
+
 struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.identify_chip = rtl8723bu_identify_chip,
 	.parse_efuse = rtl8723bu_parse_efuse,
@@ -1731,6 +1752,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.cck_rssi = rtl8723b_cck_rssi,
+	.led_classdev_brightness_set = rtl8723bu_led_brightness_set,
 	.writeN_block_size = 1024,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
-- 
2.44.0



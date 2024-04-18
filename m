Return-Path: <linux-wireless+bounces-6543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD98AA53F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 00:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BFC1F21EA5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 22:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253E178CE4;
	Thu, 18 Apr 2024 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alwjxh96"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77D2F30
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477820; cv=none; b=K3kV0CLE6na+ov6VNdmjlm46vdto331kVLIHLKcfKDJr5Z9fQN6f1yKQU1uVU51KK8UmK4LXuqjr/A3QBmL9GcFYsX23B/rcQiSBd9PU/AZSOs3J6toCIw5GyTTo6Ui0tIER5McLI4EVRCeK907E3NOYVOIG2nmEv7BH/druWEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477820; c=relaxed/simple;
	bh=5bnWIEs6MR9IOOqV6ZO0SzWaf/DcV23InsEv4gvlUOQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ezFuRaAwFOuJSccFf/sE0ZbpYFQt8yp6/CNpNNbaJXOBKwb4pp/f+3WJZ1I4RDdaKCweO1yKRFyoK+yDEbihObCCiZYaMStA7tmK7MLFZIEXHgyt0QxDPjre8SIe81tJi1C7tGLH81sLTOpNEofHlLtHUoH3kHMOQH/hmSNgiF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alwjxh96; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2da888330b1so20028121fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477817; x=1714082617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ga4ejP6J6mcRWgzPjRpDZ9kWIG6kdAF4tmfgVvlo0O4=;
        b=alwjxh96At5FzTzPthcUBSli8UIDjy6jGyXBmR9R9T2NTumbL7ZOQkxNeEL0lSj81M
         yCBgcnmmJLbjbgrT3XI6/LsznDFrIAobO7+lIfGRKuZgZ5/bRT2CL3IgCLweNEmT5E4s
         vGjdzslpmJP5kFJKsYy1VpNXVXRoKOi/JSFt7mjCpGZRotLsIuv+NIj88w9vxVuTl/qB
         BTQggJceyfKVd6WHpGJaG61Cs0h7mRPZsB3l7Zr33NRYZQqbdzsjH1uA6biVFAwxe7lA
         rLW6+WOjqP7XLtf0YwAb9uzUfIh4cVganwzqwfaEOepa/aj+88YpSmkk+ECjNUr8MQ56
         S7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477817; x=1714082617;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ga4ejP6J6mcRWgzPjRpDZ9kWIG6kdAF4tmfgVvlo0O4=;
        b=tX7+Q8mdJS1TKjw/ZDvTjCvFsuv+FA1QA8jzgV3Fqp2cuhNmwOOndYTXuJNDDjO9AK
         FyC0jw1sbcASIOXLms0i0FHGHE/imcc0co7SOFNmUFjxgp0hJ70+Zx2Id4Cw/d06BBgz
         J+gb5E7TOJQPz8C3TZ/WXCvRg03X0qIsP5VSo6zkzDT5/tCqkxvXOezn9mTPmAzYJXmD
         KpOPTeBnWMN6Dhwitv4evGCCeSgkdxtqytdyn3ruPA09jHvu/4Z1kYd7vRME6Zezdkuw
         6dhQc5lnhfIOHiGKD07hcdeNtOZjTRMdmtCkK7VeCWF889IOe4s4F/LrF0ibAiAYDEAw
         MG+Q==
X-Gm-Message-State: AOJu0YwTD5uWG/i/boA2Ke5ry01jO3/18cp8HjK5qphtVQit+tkc5Z6J
	01okvnNF5d7c5Q6JXgCNfIKV1WIqhvBfrrQF99uoRjdEXsVWPRgmt4USZ5tf
X-Google-Smtp-Source: AGHT+IEPzRqQJS5QLUrmuOpiGeWcObT9cAATzIPLm1pVD9TG5Q6tpqXZZ/jkC77ZYsz2mqN9r1r7LA==
X-Received: by 2002:ac2:5195:0:b0:518:8aa3:c4ee with SMTP id u21-20020ac25195000000b005188aa3c4eemr156576lfi.42.1713477816922;
        Thu, 18 Apr 2024 15:03:36 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906265a00b00a51d31924c6sm1378875ejc.189.2024.04.18.15.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 15:03:36 -0700 (PDT)
Message-ID: <4b5970cf-d28b-415a-b911-82cdb5e9ce99@gmail.com>
Date: Fri, 19 Apr 2024 01:03:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] wifi: rtl8xxxu: Add LED control code for RTL8192CU family
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
References: <a53ed8b9-27fc-4871-a20a-ad42c6d210d3@gmail.com>
Content-Language: en-US
In-Reply-To: <a53ed8b9-27fc-4871-a20a-ad42c6d210d3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Also, don't set bit 7 of LEDCFG2 for RTL8192CU. If bit 7 is set the LED
never turns on. In this family only RTL8188CUS needs bit 7 of LEDCFG2
set.

Software control (on/off) and hardware control (automatic blinking)
tested with Netcore NW362 (RTL8192CU).

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../realtek/rtl8xxxu/rtl8xxxu_8192c.c         | 21 +++++++++++++++++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index e54978ca7171..ddf2d9707338 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -609,6 +609,26 @@ static int rtl8192cu_power_on(struct rtl8xxxu_priv *priv)
 	return 0;
 }
 
+static int rtl8192cu_led_brightness_set(struct led_classdev *led_cdev,
+					enum led_brightness brightness)
+{
+	struct rtl8xxxu_priv *priv = container_of(led_cdev,
+						  struct rtl8xxxu_priv,
+						  led_cdev);
+	u8 ledcfg = rtl8xxxu_read8(priv, REG_LEDCFG0);
+
+	if (brightness == LED_OFF)
+		ledcfg = LEDCFG2_SW_LED_CONTROL | LEDCFG2_SW_LED_DISABLE;
+	else if (brightness == LED_ON)
+		ledcfg = LEDCFG2_SW_LED_CONTROL;
+	else if (brightness == RTL8XXXU_HW_LED_CONTROL)
+		ledcfg = LEDCFG2_HW_LED_CONTROL | LEDCFG2_HW_LED_ENABLE;
+
+	rtl8xxxu_write8(priv, REG_LEDCFG0, ledcfg);
+
+	return 0;
+}
+
 struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.identify_chip = rtl8192cu_identify_chip,
 	.parse_efuse = rtl8192cu_parse_efuse,
@@ -635,6 +655,7 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.report_rssi = rtl8xxxu_gen1_report_rssi,
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v1,
 	.cck_rssi = rtl8723a_cck_rssi,
+	.led_classdev_brightness_set = rtl8192cu_led_brightness_set,
 	.writeN_block_size = 128,
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 82037a1f3dfc..7345a893e1fa 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4360,7 +4360,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 
 	/* Let the 8051 take control of antenna setting */
 	if (priv->rtl_chip != RTL8192E && priv->rtl_chip != RTL8188F &&
-	    priv->rtl_chip != RTL8710B) {
+	    priv->rtl_chip != RTL8710B && priv->rtl_chip != RTL8192C) {
 		val8 = rtl8xxxu_read8(priv, REG_LEDCFG2);
 		val8 |= LEDCFG2_DPDT_SELECT;
 		rtl8xxxu_write8(priv, REG_LEDCFG2, val8);
-- 
2.44.0




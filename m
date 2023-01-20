Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD139675956
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 16:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjATPzr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 10:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjATPzp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 10:55:45 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF080707D7
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 07:55:18 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q5so588712wrv.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPgudPCXIBy6FiAHmJXsCq9ARHh8PWxYE16rm8TRgaU=;
        b=n9TwHVB2us0yshwEPLc1rxmtTj1QaYPkrmblQhezOKREF2v1gtxJ7QqpNLI4h4/9+D
         wnBMtRXMoaMxHHu69rDqtoUCmbons9NqnVsGBjNcwAWGG3wpLc9euO6YD1IZLTszidnO
         oQMzoXnyXvBDtcKy98QxCC52P4S/htSZowyq0ZiYGHnfnPPAyNfKkMeDdNRxA9m5KIn0
         OdoIgnDc0l7JearCgGFWahKUWHFNLeEGn/FWBHjolTns8afanVQxd19/N5cLuimpoLOd
         4rmbYtgD3HaecxCE1XJ9LYUvYMB5w3qgkejcVNOFV81KXlYRJTXqjbMg4IOmE1z+hOIY
         teGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPgudPCXIBy6FiAHmJXsCq9ARHh8PWxYE16rm8TRgaU=;
        b=dlD3GIicbrILT0CZ5z/tZgI8C8N12HLU/SBceAbM9XYJUusXZLWWvUSUN5mhG7ZLSW
         76AitC0CPOB/S9+SmWFbJlk3Fz7Rs29hrkc4K+F2nAhHKzvGuXiHm3K/RTjQhtIdn0O6
         wLZmHbklH513MRLUlIUwbiEGJ39WSJba5II+id8mVZ3QOgKh6SsxmYddIuKUCUeG5Ig5
         76clFYhoE9pWgYQTAb5GZByTnGdEPEge8tUcUAhN4DlrQRq8yUUnFrDig9vMqOq6POES
         i1atUadRMvEL5ELaNDpU99XgYLAM0iL44w2TqV8/Lnr+HA8axqlVu2DgQyEgqkAU2OOK
         0WNw==
X-Gm-Message-State: AFqh2koILfLP5ovficYGt+H4ERhzrTdwmrLxHYzhUvtO+xEmMQ2zbdkZ
        umo6OTyQpSP0/0HNQ4Z5aAbuuTBWHC0=
X-Google-Smtp-Source: AMrXdXtggqCoCofyT/Q6zYRe0VY03AqzKE8FE8NB0KVvCEvSu/rsSfhI3XzBbvbh5HdFWKplIRzWRA==
X-Received: by 2002:a05:6000:3c2:b0:2bd:beff:9c47 with SMTP id b2-20020a05600003c200b002bdbeff9c47mr15405043wrg.67.1674230114086;
        Fri, 20 Jan 2023 07:55:14 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id q23-20020adfb197000000b002be5bdbe40csm1874302wra.27.2023.01.20.07.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:55:13 -0800 (PST)
Message-ID: <73323811-aa58-a1be-7867-a5d45b7ae3d6@gmail.com>
Date:   Fri, 20 Jan 2023 17:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH v2 4/4] wifi: rtl8xxxu: Add LED control code for RTL8723AU
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <b8235bca-60c3-d0fe-a958-53c6dd3ba3f6@gmail.com>
In-Reply-To: <b8235bca-60c3-d0fe-a958-53c6dd3ba3f6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

By default the LED will blink when there is some activity.

This is only compile tested.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 .../realtek/rtl8xxxu/rtl8xxxu_8723a.c         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index 5ed523db2d87..5e7b58d395ba 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -457,6 +457,30 @@ s8 rtl8723a_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 	return rx_pwr_all;
 }
 
+static int rtl8723au_led_brightness_set(struct led_classdev *led_cdev,
+					enum led_brightness brightness)
+{
+	struct rtl8xxxu_priv *priv = container_of(led_cdev,
+						  struct rtl8xxxu_priv,
+						  led_cdev);
+	u8 ledcfg = rtl8xxxu_read8(priv, REG_LEDCFG2);
+
+	if (brightness == LED_OFF) {
+		ledcfg &= ~LEDCFG2_HW_LED_CONTROL;
+		ledcfg |= LEDCFG2_SW_LED_CONTROL | LEDCFG2_SW_LED_DISABLE;
+	} else if (brightness == LED_ON) {
+		ledcfg &= ~(LEDCFG2_HW_LED_CONTROL | LEDCFG2_SW_LED_DISABLE);
+		ledcfg |= LEDCFG2_SW_LED_CONTROL;
+	} else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
+		ledcfg &= ~LEDCFG2_SW_LED_DISABLE;
+		ledcfg |= LEDCFG2_HW_LED_CONTROL | LEDCFG2_HW_LED_ENABLE;
+	}
+
+	rtl8xxxu_write8(priv, REG_LEDCFG2, ledcfg);
+
+	return 0;
+}
+
 struct rtl8xxxu_fileops rtl8723au_fops = {
 	.identify_chip = rtl8723au_identify_chip,
 	.parse_efuse = rtl8723au_parse_efuse,
@@ -482,6 +506,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v1,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.cck_rssi = rtl8723a_cck_rssi,
+	.led_classdev_brightness_set = rtl8723au_led_brightness_set,
 	.writeN_block_size = 1024,
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
-- 
2.39.1

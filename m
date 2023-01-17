Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D6670BA1
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 23:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjAQW2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 17:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjAQW1q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 17:27:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D6E5CFCB
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:06:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b7so6097066wrt.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CX8hTnGqPq0dkyhSl1D/8iviiGz5rnkOBochjNST6f8=;
        b=BOg7gHpLJ8PUED61KwPMeGtJ+kA9X5UN+chw4+t/QYZoTRk4q2wFoPV/S8TfF4rvQu
         ecKANHTSngZtVPpktKdwzigNYPNqyQ3D+I9LKBfHGo3Fbg998RDXjGAhu7YiSDPBhsrW
         iJp+A7s4FqOB5gVF6LHNfZtFNAzWM84GR5tEh/9mXfPLIna46xPYU/aa1b7Rs1s/7l2N
         2oBmZ3ZxaBdHmjOXhmg3cuJKhKjKtNjETQSEVnyWJa0QkbXfiXxwmErWpfLEY2Nvl1PC
         WnNUotv2B8zHIBMC+shqRizoR5vLhwqK32mqL6vdz6jN03jZp+P9xfPtGDgHhwvvdGt0
         pQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CX8hTnGqPq0dkyhSl1D/8iviiGz5rnkOBochjNST6f8=;
        b=CC+BXYZQjf1ph/AErCnLyAY9d+uhNqp3T3HZUc/oU9MTnUOyNQbol0e/nNZS/kOFfd
         bvrihGee5LXjewO9lU1rKJJ03PmI74Pr8GZdsO+7aa8FSAIiNzXDmLmRhFV9zVKgytBe
         neIM2dwBm2KWB7I/wd2d1euOb/bI7Eg7HrQub7RlF/Az0aLAqWHV8N5mVq7mnymlkMao
         Jeb4zvO0BDZKq8dSTpelif9o6PhOypi5FeB/HugUnouLz0eWCvSqtb3jUsB1x2lYOS78
         VSEyrstfaeiLMbMkc6zx2x726zJ2/PLVKV5BdttkuyCwdSfiw9HkwBU60y/JdNwrPiqt
         DMEw==
X-Gm-Message-State: AFqh2krYZF/XQ0LSZk3Rtkjpsw7z7KVpzgKI0teHw9aclmH/jWrxlkGR
        Qr5mhF9fD3XtGgbAt6r/gvc4LifvAGM=
X-Google-Smtp-Source: AMrXdXuxFIDOWQl9i4M61A8qPhdeE7U//3vUi25kCjx4B2q9QDVXz1SPNJRCMZiArHJz86x4sL9hww==
X-Received: by 2002:a5d:5954:0:b0:2bd:bdb5:baf1 with SMTP id e20-20020a5d5954000000b002bdbdb5baf1mr3888201wri.10.1673993160059;
        Tue, 17 Jan 2023 14:06:00 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id r18-20020a5d4952000000b002bdda9856b5sm14157779wrs.50.2023.01.17.14.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 14:05:59 -0800 (PST)
Message-ID: <d5f63bd6-6065-10b5-b2da-355c387db4e1@gmail.com>
Date:   Wed, 18 Jan 2023 00:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 4/4] wifi: rtl8xxxu: Add LED control code for RTL8723AU
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <5c03ae42-a2fd-b39a-e754-f52d8528a167@gmail.com>
In-Reply-To: <5c03ae42-a2fd-b39a-e754-f52d8528a167@gmail.com>
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
2.38.0

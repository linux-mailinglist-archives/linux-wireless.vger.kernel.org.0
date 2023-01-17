Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF99670B99
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 23:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjAQW0S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 17:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjAQWZv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 17:25:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138727F9B7
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:04:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b5so10918679wrn.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLy1kCz5UNSqomVwOwqBMNik0CT6fDAtXmToAhAg8Uk=;
        b=KVraa78SesXaCaLgojVFxs5yDr5mEaAwj4W0YjI4Pumw8mRo6QLGDI7IK0ohE4/AON
         EzHN9zh2r884zJg1fjfuJvDQ1s28/cYoVuFC0LTIuN67DIjcBM9gqYLbVzUY3P5aWe4w
         2VNR3zqbKa04riNfQhbS+kUKShstb9sakGe+vhokXPayx4i3sCgHRiBjC80utH8m+LsK
         CcdpY6Xs/itu36x9xngT0O8Nkm42U2zpprvczgoaSh7UXIjkpKLcjyFKZOsG21hOTgd0
         ozO232aThcZaJISwMej/MX+KKhX/A/QfdHIcKla6J6ymuoCNAqb8XGTq9x4lvX7vSDV/
         PXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLy1kCz5UNSqomVwOwqBMNik0CT6fDAtXmToAhAg8Uk=;
        b=ZSbUKK0Xg00E9+QSdz4zdcWtwHBCadNo1hADq6S/4n8+arm4oJEQmhujnXUl99xObb
         2p+aKPkaxFfiw5udvzQevYBrBAnPLUtHh4Cgz2DXWiDVkSwLRz8GqFgTTgwzFj7EgIWc
         ow7vt0MtmZGMH7xpbf8fUsvfp0QQVUrHcsY2YuNWL4JLv336Ah+7rQYz3hHQdLyuu68v
         tPh1EqdMleXdh1l4S6zKo2z3Rno5Fk+zkrdBx4p4gvZz+op5Zll1ljsxfWUYQ40Lh0Mb
         1V1wFRhBmh6WdJFX3VbG8sQlQB5LugbKRVKQBDIeWypO9dawCPMGc7eeXvJPfp1cF9Gb
         0C2A==
X-Gm-Message-State: AFqh2kqmlhk+jj2nCmN5IHyOynDqppWw1PPed6R+WTH1el0SYReCh9PM
        FUY1W9H+r2iFwxxIc6W8YCdNAeVz2Eg=
X-Google-Smtp-Source: AMrXdXudzILa8y2E9YPltzAQDDseW9OKNEdp8Ec5PyB6cY0ZsvAbI2ovTvlzCNiAx6dfl2w1029BwA==
X-Received: by 2002:adf:de81:0:b0:2bd:dc5c:7e4c with SMTP id w1-20020adfde81000000b002bddc5c7e4cmr3932652wrl.15.1673993046211;
        Tue, 17 Jan 2023 14:04:06 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d488b000000b002bc7e5a1171sm22869593wrq.116.2023.01.17.14.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 14:04:05 -0800 (PST)
Message-ID: <77a0ec12-3711-7f21-5b99-95388f0648b1@gmail.com>
Date:   Wed, 18 Jan 2023 00:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 2/4] wifi: rtl8xxxu: Add LED control code for RTL8188EU
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

This was tested with a TP-Link TL-WN725N.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         | 25 +++++++++++++++++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  4 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index 08f3b93ad8d0..a99ddb41cd24 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -1350,6 +1350,30 @@ static s8 rtl8188e_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 	return rx_pwr_all;
 }
 
+static int rtl8188eu_led_brightness_set(struct led_classdev *led_cdev,
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
 static void rtl8188e_set_tx_rpt_timing(struct rtl8xxxu_ra_info *ra, u8 timing)
 {
 	u8 idx;
@@ -1851,6 +1875,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v3,
 	.set_crystal_cap = rtl8188f_set_crystal_cap,
 	.cck_rssi = rtl8188e_cck_rssi,
+	.led_classdev_brightness_set = rtl8188eu_led_brightness_set,
 	.writeN_block_size = 128,
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index 5818b2378bab..d510ce27b1b4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -148,6 +148,10 @@
 #define  LEDCFG0_DPDT_SELECT		BIT(23)
 #define REG_LEDCFG1			0x004d
 #define REG_LEDCFG2			0x004e
+#define  LEDCFG2_HW_LED_CONTROL		BIT(1)
+#define  LEDCFG2_HW_LED_ENABLE		BIT(5)
+#define  LEDCFG2_SW_LED_DISABLE		BIT(3)
+#define  LEDCFG2_SW_LED_CONTROL   	BIT(5)
 #define  LEDCFG2_DPDT_SELECT		BIT(7)
 #define REG_LEDCFG3			0x004f
 #define REG_LEDCFG			REG_LEDCFG2
-- 
2.38.0

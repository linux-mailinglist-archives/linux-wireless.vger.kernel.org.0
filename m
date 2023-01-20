Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF32267593C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 16:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjATPym (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 10:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjATPye (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 10:54:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C51E050D
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 07:54:24 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t5so5256321wrq.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbgUxd/FRuWN3nrz37DBIuagPrn/BWA4uSjLuDTkrWQ=;
        b=A+Q6KI8eikgNEmDX2+f/G6ayCSXBfCh4S6WWBih+Lqba28BphKj8YlECd6IaB62Lkn
         KWUg385oQx4Fv6oq55LYEuEmB30XaJwidI7ga57Rermc7h+LCek2csP8lY6sLSN15vsy
         v+nfmC6mOwsyl/FFQcZu267NWP0nnxoJxEyHJLVOH7RMtd81t4d6lqHHL6keb0KNyPIO
         428Do+axWpST4eU1n1Ma+WUdlMomO9xSY26nvqclXX9kyyGEMFt3wn/5wt91h0pFAUei
         49w7Il+2YMm5o6O8iMtbkZuo2BXr1vdO78W+k0e1u7UZB7faKdbTZrI64gUOyVYEBt2H
         k5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbgUxd/FRuWN3nrz37DBIuagPrn/BWA4uSjLuDTkrWQ=;
        b=g1W5i9JpRhJn9L25s3o41uDHSgw/cI4GuadKkHepb8nfTF8XWeLoICSzwTUKUrcAjQ
         f0SxocuTvjdwSeJ5NJSrre5s0IalFmbIajWzQBZ7/YdDdjThsImycS91rmhXfgLspOmP
         A80+YIK0qgmlA2i2pUqQbMKSzunQsHVbHQNiGGyigoS1GRi5hvIcp/jw6rzaK6Bytzo3
         WOB1r1zr5/NKUpFy1Kp2/xY88QkeFp2G86DkqE7CnKqaqV5KrwPYA46WJj2yreZJOr75
         02maDEEw0vzW1sWrhHnYKzgGDSPzEJ799B2BF2YmonAE/4x9dVZoWzEWpCYliasUBO7r
         citQ==
X-Gm-Message-State: AFqh2kqbqS4NQxrsa+Y3FVuzTY8BwXq6idSB6DQ9qfE7A+kdpudPyzH4
        OJTJi3GI+NHq6rkr/YPM/EgyddlJqWk=
X-Google-Smtp-Source: AMrXdXtAoXfBnjPlAc4vIc+8xv4urf42tRQMWBhvW9hPDFD0gbqf0h8uzeCa7tnij9GXbnxfaC53/w==
X-Received: by 2002:a05:6000:689:b0:2bb:b17e:789 with SMTP id bo9-20020a056000068900b002bbb17e0789mr15164784wrb.58.1674230063179;
        Fri, 20 Jan 2023 07:54:23 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id i6-20020adfe486000000b002423dc3b1a9sm35706506wrm.52.2023.01.20.07.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:54:22 -0800 (PST)
Message-ID: <8f7fd5d7-5baa-b38b-ad2a-977dcd9edd81@gmail.com>
Date:   Fri, 20 Jan 2023 17:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH v2 3/4] wifi: rtl8xxxu: Add LED control code for RTL8192EU
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

This was tested with a cheap "HT-WR813" from Aliexpress.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 .../realtek/rtl8xxxu/rtl8xxxu_8192e.c         | 24 +++++++++++++++++++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 4a1c9bcafe31..5cfc00237f42 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1764,6 +1764,29 @@ static s8 rtl8192e_cck_rssi(struct rtl8xxxu_priv *priv, u8 cck_agc_rpt)
 	return rx_pwr_all;
 }
 
+static int rtl8192eu_led_brightness_set(struct led_classdev *led_cdev,
+					enum led_brightness brightness)
+{
+	struct rtl8xxxu_priv *priv = container_of(led_cdev,
+						  struct rtl8xxxu_priv,
+						  led_cdev);
+	u8 ledcfg = rtl8xxxu_read8(priv, REG_LEDCFG1);
+
+	if (brightness == LED_OFF) {
+		ledcfg &= ~LEDCFG1_HW_LED_CONTROL;
+		ledcfg |= LEDCFG1_LED_DISABLE;
+	} else if (brightness == LED_ON) {
+		ledcfg &= ~(LEDCFG1_HW_LED_CONTROL | LEDCFG1_LED_DISABLE);
+	} else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
+		ledcfg &= ~LEDCFG1_LED_DISABLE;
+		ledcfg |= LEDCFG1_HW_LED_CONTROL;
+	}
+
+	rtl8xxxu_write8(priv, REG_LEDCFG1, ledcfg);
+
+	return 0;
+}
+
 struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.identify_chip = rtl8192eu_identify_chip,
 	.parse_efuse = rtl8192eu_parse_efuse,
@@ -1788,6 +1811,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.fill_txdesc = rtl8xxxu_fill_txdesc_v2,
 	.set_crystal_cap = rtl8723a_set_crystal_cap,
 	.cck_rssi = rtl8192e_cck_rssi,
+	.led_classdev_brightness_set = rtl8192eu_led_brightness_set,
 	.writeN_block_size = 128,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc40),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
index d510ce27b1b4..5849fa4e1566 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
@@ -147,6 +147,8 @@
 #define REG_LEDCFG0			0x004c
 #define  LEDCFG0_DPDT_SELECT		BIT(23)
 #define REG_LEDCFG1			0x004d
+#define  LEDCFG1_HW_LED_CONTROL		BIT(1)
+#define  LEDCFG1_LED_DISABLE		BIT(7)
 #define REG_LEDCFG2			0x004e
 #define  LEDCFG2_HW_LED_CONTROL		BIT(1)
 #define  LEDCFG2_HW_LED_ENABLE		BIT(5)
-- 
2.39.1

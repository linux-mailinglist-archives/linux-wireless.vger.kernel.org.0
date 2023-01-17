Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63692670B9D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 23:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjAQW1u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 17:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjAQW0w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 17:26:52 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F10DBF5ED
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:05:11 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l8so6245884wms.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 14:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7a3Zpknh1kjtBdBo4Hw/KvpGh+L2eeCDBsAjPGHPdhc=;
        b=mbPcIZaBLMRjEx2TQBHTDzOQiYuEhsRucvUaN02rRUZsLBXQpOO3dKRlGMiD4DmU+g
         qqluJJo0y9Mrk5kiQn5W6D1/fyo+hNpsoNbmmoksjXy5fu0fVU12AY1gIHjD7kYwfxit
         TxLHkk0apaAKO/ib6Oda+Id5aoUmw70cMQRsxU7WaR+rqRd/XNReuKtqbxrgmdR1+KB5
         LGCppApJbqzd+RVpyl05HeEe7LJ1gBTLieAnCMrMTLvkZFf17VuosNqlQwY/k5uj+2RY
         bVXS1laXwMIForxo/I7IeLyeFOUmDLKDMM+MGCgujjeRrQVDBJRgKiNbCiHItgqmx8kN
         k1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7a3Zpknh1kjtBdBo4Hw/KvpGh+L2eeCDBsAjPGHPdhc=;
        b=g0zPT/bhBJZIEoYTjbMfFccznd/NlvzlNyKMYaytD3oS62efWuTRyQYghq0FVH//Ai
         ZDZ9mBR56pNXH7O7ks7RoNlASk/T4G/FDhCRF1YkX8oYLXeZri0qFpSfecSIU/nU9zAY
         mwOBRzwVT7cLsAEgm1QCNtsMVKzFrHZ3VWyOOynUUGzaeiTnigsv/NxxmlziMrOOfwZz
         uGNY1bArRS3On4BlaHLfPDRa/LlceHguppr/8h4NL1yfYewkHIZLjtAQU95UufAh0cIT
         1ogg5DkqIAZTQzBmPusQpJhqumelndKXZkrIBqrxRQX9clI2hggn2X58GAftxyi7kLNg
         gusQ==
X-Gm-Message-State: AFqh2kq/pbpMfmC7eUNCFGLIevHbndtZosRy6ctZqVG+V7RqYPoFuIS8
        uTBmKxiGSf/I33oXaQbFuBfNZHO83uU=
X-Google-Smtp-Source: AMrXdXsz73mDXulFyHVNFvQvDt73uITQv9qbzW5z9u3c5h5qn5bery04xmRGyJRNII8CjPb3tBLY8A==
X-Received: by 2002:a05:600c:3d9b:b0:3db:fc4:d003 with SMTP id bi27-20020a05600c3d9b00b003db0fc4d003mr760646wmb.33.1673993104281;
        Tue, 17 Jan 2023 14:05:04 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id fk6-20020a05600c0cc600b003c6b70a4d69sm42010wmb.42.2023.01.17.14.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 14:05:03 -0800 (PST)
Message-ID: <5f105f2e-a829-d0b1-92ac-a0ab90511c38@gmail.com>
Date:   Wed, 18 Jan 2023 00:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 3/4] wifi: rtl8xxxu: Add LED control code for RTL8192EU
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

This was tested with a cheap "HT-WR813" from Aliexpress.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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
2.38.0

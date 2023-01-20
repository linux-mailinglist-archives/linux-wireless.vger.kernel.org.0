Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670D767591E
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 16:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjATPwt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 10:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjATPws (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 10:52:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F694B4A1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 07:52:46 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so4030774wmc.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jan 2023 07:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eGnHjCFuLsS9i5O2gMuu9ltzW4AuhZE76peUc2103pc=;
        b=GWP8DcZh1mNPVHXRgGHnMsK1nnQ9224fRJaSVoFxs7LGd4oU9h9wUl6Ym7LvRrqJeJ
         Pgh0o+WRS+1EN1HSPTl3N67Q7p7z1/V7TsX3o9ATZ+QXc/qB0c70WN4/fmy41s7nJeCt
         Mgxvw4on2eoxCGCFh/L1oOWlPFiH8T8gh39WS1oNCHfk4X06Yw59OyAsXAZF53LMvoKH
         5bXNAlX7z2lGaremANaC1xFU+Wi7ZSABeCfAlauOU6AlwaSQjAlTc6hZ9lgdo8YEWmNA
         BiGvtFog2Uyb5sTzwZS7hPQNq3KDMOQlX/scgLhec2wj7VC8cWH313qTHcdAWWMdv9Sk
         AEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGnHjCFuLsS9i5O2gMuu9ltzW4AuhZE76peUc2103pc=;
        b=Vkdc7k5emxHTfijmr5iwl78JyI1pPtDva4UMZ5B8tcA9BEq/G81Svx3b+F6tKwl0pK
         uWVXLFDPrIFuhvzqwxT+xUmR8rbQxggpOwWQnxdVvk2LqdvJsBQ2QkweTpRAD6zZmvXi
         /rjLzsURe/G1+YQS7T7GYY8JHk5xh2AT/AKI/oKhb40ExE9vSBLA6UOVzNPjmefB0UiK
         1qY5Ke1aqW+d1w/CufFWNwFLdf2JplqrIPGAK82sBLWpqMmQeKTOlVeFwXmOilh4f+Ab
         H31WAcH55ZIop3OVeH2TP9nVkqY/AD+B3eZPADfc+tuNaDL9f0uwqfMXoAiQBQXwndJF
         cJLA==
X-Gm-Message-State: AFqh2kqmS/Xvi4ws3QfAjKY2TcmVxKeM1U/RT25hR1GxFMeXVVDCQyIn
        0knitBfdBwBfxgHq5cdodFux4sB94Ds=
X-Google-Smtp-Source: AMrXdXsqDSMP/cIClCk6/rFpEyWN8xXPXp70b8VrAd02SZ0IsmgSlLBMQTtr7e/8Ae9gCruKmRWXJA==
X-Received: by 2002:a1c:7315:0:b0:3d3:5a4a:9101 with SMTP id d21-20020a1c7315000000b003d35a4a9101mr23104732wmb.23.1674229964827;
        Fri, 20 Jan 2023 07:52:44 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003db012d49b7sm12980786wms.2.2023.01.20.07.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:52:44 -0800 (PST)
Message-ID: <34d62bf5-3595-0c77-2ca7-be78555f765d@gmail.com>
Date:   Fri, 20 Jan 2023 17:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH v2 2/4] wifi: rtl8xxxu: Add LED control code for RTL8188EU
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

This was tested with a TP-Link TL-WN725N.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
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
2.39.1

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DBE64F92D
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Dec 2022 15:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiLQONx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Dec 2022 09:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiLQONv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Dec 2022 09:13:51 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1550F13F2F
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:13:50 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id t17so12340393eju.1
        for <linux-wireless@vger.kernel.org>; Sat, 17 Dec 2022 06:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Y9FHoNwcDPV8AMOOlEJy2lDdr8m8MESsLDV+1GBLU0=;
        b=c3HX2RunNKKddKsnkwRotggGzmftm2m/4VL0flWr0WUdf5qImZnJxxKYG90M66Kw/W
         yyjbQFpvdZ46PX+0r++2DnoQme+u7fulELWbZQ5je5cXRazXwy3Ee6d6g1Okv7khDvhx
         IIQDIuyqnWlzrwtBekEO2i2bbhhoPvJRQwK6b+OqIDK+fQSyEgHvDPjV5V+IB1x7OZt+
         FGg4DJxYq4d3IuuA6NDCurlMetlgw05esHs1AIzlEoPMVAcGPQ+L/fWT93ta3LY3gERQ
         3DvAHx0bwXPkhdQY4259QtYYFbVsxppCPUFmh5PX2B71Th/MBUECm3hGlShS6fwfnK2n
         YyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y9FHoNwcDPV8AMOOlEJy2lDdr8m8MESsLDV+1GBLU0=;
        b=OncK/wsaBRkcDGeoIxFcLWA8B2mrI3cADJbPlQtc3SQisgPi8+loJxp4Y7BwI+Jv0Y
         /zyeJdLiFuid8ofSQ3/+TMzRmDJ+mubOsBxuLI9uynROCnyYDxZDj4kAAkGWxHLrXbUX
         yaFwWmOiY/EDziiQB64mgJoG+ohi688SaX1NSPuaOiv7bfFtVrPzpJ3oQFDtuEYpJAwG
         BQZwfPL7ggyBQ9E5yY/8yAEPqXzxeO0hPqqL9cu1exrby8hvUE9aOjA8U3HO5U4WIv2p
         LTQ7X9jbk/nkcDaaLiV4AUElbpvE4KKE6lJpB3giBoiIKEdmf+EhPJzEqr7hZo4/1AC2
         e3Ww==
X-Gm-Message-State: ANoB5plGVWbRi3Tz3uTFyOZzCX/OKu3lZba5ENdLgBQSi79ohBNgj6++
        75e1PMai0K010VS44K8oh00hReMbp78=
X-Google-Smtp-Source: AA0mqf739rsov3BdD30ZINY5O1bq9Nj5+YLgdrGXn5qK449mKXYb33yLRmAsZE0EAAYbez4fpq3VUQ==
X-Received: by 2002:a17:906:c088:b0:7c4:a773:4d72 with SMTP id f8-20020a170906c08800b007c4a7734d72mr17823165ejz.64.1671286428727;
        Sat, 17 Dec 2022 06:13:48 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id lx5-20020a170906af0500b007af75e6b6fesm2075094ejb.147.2022.12.17.06.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 06:13:48 -0800 (PST)
Message-ID: <361ceac1-cc73-605b-4b63-736bfce80833@gmail.com>
Date:   Sat, 17 Dec 2022 16:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v3 2/5] wifi: rtl8xxxu: Make rtl8xxxu_load_firmware take const
 char*
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
References: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
In-Reply-To: <2aa5200a-ee42-e064-16a1-672bed5708c6@gmail.com>
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

And pass const char* to it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - No change.

v2:
 - Patch is new in v2.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h       | 2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c | 2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c | 2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c | 2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index d26df4095da0..87758295d618 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1560,7 +1560,7 @@ int rtl8xxxu_init_phy_rf(struct rtl8xxxu_priv *priv,
 			 enum rtl8xxxu_rfpath path);
 int rtl8xxxu_init_phy_regs(struct rtl8xxxu_priv *priv,
 			   const struct rtl8xxxu_reg32val *array);
-int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, char *fw_name);
+int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, const char *fw_name);
 void rtl8xxxu_firmware_self_reset(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_power_off(struct rtl8xxxu_priv *priv);
 void rtl8xxxu_identify_vendor_1bit(struct rtl8xxxu_priv *priv, u32 vendor);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index ba28a4c00d3b..94fc4647075a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -742,7 +742,7 @@ static int rtl8188fu_parse_efuse(struct rtl8xxxu_priv *priv)
 
 static int rtl8188fu_load_firmware(struct rtl8xxxu_priv *priv)
 {
-	char *fw_name;
+	const char *fw_name;
 	int ret;
 
 	fw_name = "rtlwifi/rtl8188fufw.bin";
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index d43f8afeb876..8981a86c833f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -386,7 +386,7 @@ static int rtl8192cu_identify_chip(struct rtl8xxxu_priv *priv)
 
 static int rtl8192cu_load_firmware(struct rtl8xxxu_priv *priv)
 {
-	char *fw_name;
+	const char *fw_name;
 	int ret;
 
 	if (!priv->vendor_umc)
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 91f018f6fca0..c769d0eaa03c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -709,7 +709,7 @@ static int rtl8192eu_parse_efuse(struct rtl8xxxu_priv *priv)
 
 static int rtl8192eu_load_firmware(struct rtl8xxxu_priv *priv)
 {
-	char *fw_name;
+	const char *fw_name;
 	int ret;
 
 	fw_name = "rtlwifi/rtl8192eu_nic.bin";
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index 707ac48ecc83..e881ee33c6e8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -231,7 +231,7 @@ static int rtl8723au_parse_efuse(struct rtl8xxxu_priv *priv)
 
 static int rtl8723au_load_firmware(struct rtl8xxxu_priv *priv)
 {
-	char *fw_name;
+	const char *fw_name;
 	int ret;
 
 	switch (priv->chip_cut) {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index b26737447035..65ebf9dcf5f9 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -502,7 +502,7 @@ static int rtl8723bu_parse_efuse(struct rtl8xxxu_priv *priv)
 
 static int rtl8723bu_load_firmware(struct rtl8xxxu_priv *priv)
 {
-	char *fw_name;
+	const char *fw_name;
 	int ret;
 
 	if (priv->enable_bluetooth)
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7f2adb1a9c70..7aa00442c3a5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1980,7 +1980,7 @@ static int rtl8xxxu_download_firmware(struct rtl8xxxu_priv *priv)
 	return ret;
 }
 
-int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, char *fw_name)
+int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, const char *fw_name)
 {
 	struct device *dev = &priv->udev->dev;
 	const struct firmware *fw;
-- 
2.38.0

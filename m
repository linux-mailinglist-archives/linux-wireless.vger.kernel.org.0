Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156DC64BAF9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Dec 2022 18:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiLMR3M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 12:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiLMR3D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 12:29:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1906122BE5
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 09:29:02 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gh17so38272643ejb.6
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 09:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiv6Ect3uX24zHrZBZxWtlhTG0jssaJGwHju4+uSP8o=;
        b=QLngrRHHS9K79xWC0ZlxKWqlF0ylf+rMvm+G/4WiBPXV9LIFQmHpcTu34vukbnDiQH
         9o7ul+Y1JotLCkuTvXq24qaPGS1+t87nHUVO+mHv/q7EVVxeD8AG7B+ZkwxytFKRrzIq
         wkB+WHVKCA9G9uqWZLslQ8LCwW9p39rydGp7FFTHqT7zkVEfx7/cdVcL2WbfO7iulXgy
         bM8YdPUk5Hm9MOFT+2murIP3L5Oa0v2WHz3zZ+aBcg8Q7Itd+WB+IE6xp/nZmhGqccHB
         cIxRHOlXdG9z9e5l+h0ZtId2WNcIZK9ZtHdmkVkU2oasIk9cC7xkVqX4J7s+ha+mCb85
         3Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiv6Ect3uX24zHrZBZxWtlhTG0jssaJGwHju4+uSP8o=;
        b=wzwqgJIk0IgEDImEcHo3dh7WY1HNLTlOTaYB87a9vNGFtmzxRqXUDMY9VSclA9KI4u
         gKuPMxVJx7XeEDr3uHHv9j+Z984fE2Pzz8wfTFYc5cGvidiRi2B+8gnujEkoXfMa1IpP
         PyyM8FdEbpRc/xXWq0A72qDIe+OJnhBl9W0wFTE4Vb9zUzEelbz2q1rJWstGXd8UpF7L
         vYRfZrKY6PX4QJ6wqRHIqx4EMhW3Yn4kG+v9lJ54Mhq9xQrQjhJhUSVKS363BjBcuX4Z
         /6QXnBtR/tFTe9nFkFu7FAQmZfPI3Jby7hzM48TCOaxqgFb4snxPW6ZqU102m6icMnWd
         es3w==
X-Gm-Message-State: ANoB5pmf8kUjydQNQQ/vOoFoJpdlMgw4Sm8ZoKr4bb6+ymppuuJdLdFr
        FOOoj0rbUsZ6BLjWi0BmjVp1iQWcK98=
X-Google-Smtp-Source: AA0mqf72MgwrxpgAEAdUaiIHYZPwZnrKAcaTkFLq6R16+H0We6uxJuq5EGGPgQutbsnK2HKxiya9CA==
X-Received: by 2002:a17:906:1805:b0:7b2:7b66:9ed4 with SMTP id v5-20020a170906180500b007b27b669ed4mr23749918eje.47.1670952540714;
        Tue, 13 Dec 2022 09:29:00 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id l3-20020a170907914300b007bc30c06aa1sm4716647ejs.186.2022.12.13.09.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:29:00 -0800 (PST)
Message-ID: <5ffc2ae2-9f90-6a60-370c-5e614262616e@gmail.com>
Date:   Tue, 13 Dec 2022 19:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 2/5] wifi: rtl8xxxu: Make rtl8xxxu_load_firmware take const
 char*
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
References: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
In-Reply-To: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
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
index 827672ce953d..2b8d259497dc 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1981,7 +1981,7 @@ static int rtl8xxxu_download_firmware(struct rtl8xxxu_priv *priv)
 	return ret;
 }
 
-int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, char *fw_name)
+int rtl8xxxu_load_firmware(struct rtl8xxxu_priv *priv, const char *fw_name)
 {
 	struct device *dev = &priv->udev->dev;
 	const struct firmware *fw;
-- 
2.38.0

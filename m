Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11535F84D7
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Oct 2022 12:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJHK6m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Oct 2022 06:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHK6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Oct 2022 06:58:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EC33B714
        for <linux-wireless@vger.kernel.org>; Sat,  8 Oct 2022 03:58:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id nb11so16090810ejc.5
        for <linux-wireless@vger.kernel.org>; Sat, 08 Oct 2022 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4NLTiNArMFgEoEmg3R5NGe9/tCTC+xhcuMMPWS7YRg=;
        b=OHGwu/AZN95eofRkejgXDOsOCAa+MlOvko7cE2VrdkNJhQveBJK9jHzwuMtznxKqnX
         MlJmZn4x5st29aXLLYm18ukXJOKS2O5bxwpXGVhJOGU3sLuRiP9DXhrjqF3lmb/ZKve+
         OaCx1l6dkZOQotnbxDDEBBFwxWtK5z5NsG6QM+Q/bwcRsIOdQvt6OtV5dGhcslU4XEKb
         ZHMokGIKW4NAMUigGc2jr+7JAZ5GuRFpTFVjLlsEA68tIflQrpNQwT7JjxbsGxHWmeCJ
         OjhHc4yK9JkijH4ZTYwknIFRXl3YVSC2fh2pA5KaBgziDxfm7fEpsL4UBApC+mSS1tEg
         9AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4NLTiNArMFgEoEmg3R5NGe9/tCTC+xhcuMMPWS7YRg=;
        b=O5Lcnw8mwQNGWMiquKO8osa8BburyiwT+kmaZKiyTgO7QNQe6yzARWO+UmXHK/bMaw
         zLyLnZnjtrI1CePN+4/kZ8WPaRBMW61nRZuVTxJTz6xslY05cdz2wUrtwWSzrGrzFEOT
         jN02LqB772njs23S/5lqSqPuBQOJWg/vGZTKq5aeylueOCDhGcm8SXQ3X4nfhMRD6EZc
         kV1eTdAj52Ce25k9rwQGpUnmnpqoDbmu9JV/X+mCy3ppTgRxYY7IfGue2oU+MZfyVZzi
         fOSir/iqji0jFxCmldGp1MZdOsUxEfW/c7TFqP+ux9V3MkNscWdcqrRGdxNM/bnwCO68
         OpyA==
X-Gm-Message-State: ACrzQf0iZSBbig5lwDq0m7C1YiMRKgGammUxMa/JjpFR3ZHKrCYvRui1
        +nV79TBDE60XTSJVnVWUMaTNqOqLHd8=
X-Google-Smtp-Source: AMsMyM7xjnJjxpa8gCboMRRnTAxdudL14944ZlGrTDfMTl3G8SxSWz8DS1kkdjL8Puo+dN1hYjL1fw==
X-Received: by 2002:a17:907:da7:b0:789:efd0:3995 with SMTP id go39-20020a1709070da700b00789efd03995mr7377251ejc.759.1665226719022;
        Sat, 08 Oct 2022 03:58:39 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7c911000000b00458f82462a5sm3160529edt.25.2022.10.08.03.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 03:58:38 -0700 (PDT)
Message-ID: <ecb7512a-07e8-112d-c815-1494582de5f8@gmail.com>
Date:   Sat, 8 Oct 2022 13:58:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: [PATCH 3/3] wifi: rtl8xxxu: Update module description
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <9407f219-a7ba-676e-3d99-154d67b312d2@gmail.com>
In-Reply-To: <9407f219-a7ba-676e-3d99-154d67b312d2@gmail.com>
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

Make the title more future-proof, using rtw88 as a model.

Mention support for RTL8723BU, RTL8192EU, and RTL8188FU.

Correct the module name.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/Kconfig b/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
index a263507a77a6..631d078278be 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
+++ b/drivers/net/wireless/realtek/rtl8xxxu/Kconfig
@@ -3,13 +3,14 @@
 # RTL8XXXU Wireless LAN device configuration
 #
 config RTL8XXXU
-	tristate "RTL8723AU/RTL8188[CR]U/RTL819[12]CU (mac80211) support"
+	tristate "Realtek 802.11n USB wireless chips support"
 	depends on MAC80211 && USB
 	help
 	  This is an alternative driver for various Realtek RTL8XXX
 	  parts written to utilize the Linux mac80211 stack.
 	  The driver is known to work with a number of RTL8723AU,
-	  RL8188CU, RTL8188RU, RTL8191CU, and RTL8192CU devices
+	  RL8188CU, RTL8188RU, RTL8191CU, RTL8192CU, RTL8723BU, RTL8192EU,
+	  and RTL8188FU devices.
 
 	  This driver is under development and has a limited feature
 	  set. In particular it does not yet support 40MHz channels
@@ -22,7 +23,7 @@ config RTL8XXXU
 	  but you will need to control which module you wish to load.
 
 	  To compile this driver as a module, choose M here: the module will
-	  be called r8xxxu.  If unsure, say N.
+	  be called rtl8xxxu.  If unsure, say N.
 
 config RTL8XXXU_UNTESTED
 	bool "Include support for untested Realtek 8xxx USB devices (EXPERIMENTAL)"
-- 
2.37.2

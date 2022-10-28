Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516766117AD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJ1Qkf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJ1Qkd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 12:40:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A855B134
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 09:40:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so14247347eja.6
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHUiZBZtHVvr+CDZCfeihxKSFs3eEqzAbpsLRw5vt5g=;
        b=JGhO0GIsU6GkbuUNPysKNEscY3f8HaCfOvg68tl90Q1KoPHb2l44+Qj3+n/gl4gSHy
         9k3J9H7JL2pSEFSFpgar/Tr4/J+UY3aO+52kqZYeOfroDpe15gLdtCi8LOCxrTrIhCY1
         EZ/qtow0DLsJr9sKEbMhS0PKl+1iKJClqk0SCufvdndxhmqNSlEmhazXi2tZsgVtgd2E
         +hFUHVePG0Yw+HEdfNtc24ubEq5Gbrivrbl6PeK1JmkoHKRrR/jDQ3t/E7bi5tlC05Fw
         l5eobsBry7Nz4ZOYXKbd8HrXxmchJMYaLsdAux4ZfHf+hpzIbTn4175nGhW4LJGHIAum
         9eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHUiZBZtHVvr+CDZCfeihxKSFs3eEqzAbpsLRw5vt5g=;
        b=bFUfKCJrfsHYhffoAFphFH9DwS6MQoYDCP+8phkt6jwVpKQo5H0mO2IoY5a+EHGAjM
         m7mcYouwfaEPxOkkoRe+zvnsAof0R4DcSg80Smzfl7vM8fposhsA00u8GAxQ1gBW8wfK
         33zFOePlKiDpUBM2nvxPHx8YWlGhJR39uXrcDhlNVi3qdA4GIwRgkZzROFiz++1D/RTc
         ldr5+Efz5lTL+WF5YBMQdqJZe0vRahaF7EsyGIfOxSx+g8ig72kyY0wBs/FVQr9X6wVS
         8Ag0SlVRpH8rgXL8LIKX21e87Fqqc5N59R6RX+YoyW5nkuUAelW8W5tS7pdoHkGiwsVy
         26Iw==
X-Gm-Message-State: ACrzQf2hCXSauiCHM9xFNHLeNgM8SVW1Ovhc8DfMABkCjxgOfyqG7EMi
        Mo7pSSghDv6CFUc6LUpcYzcqyE7EiNI=
X-Google-Smtp-Source: AMsMyM7cVsD59OjFMsNlHQGXDuzqqT5lyhFuF29dxjUzrgsDyuH4iK7RAqG9XKKfotXzuxCJms+hRQ==
X-Received: by 2002:a17:907:7e95:b0:78d:e9cf:82c7 with SMTP id qb21-20020a1709077e9500b0078de9cf82c7mr205695ejc.724.1666975230727;
        Fri, 28 Oct 2022 09:40:30 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906411600b0073d638a7a89sm2397891ejk.99.2022.10.28.09.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:40:30 -0700 (PDT)
Message-ID: <f5ceeb63-bfd2-0fe5-c88b-2bc4c9c7c46a@gmail.com>
Date:   Fri, 28 Oct 2022 19:40:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v3 5/5] wifi: rtl8xxxu: Use dev_info instead of pr_info
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
In-Reply-To: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
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

Replace two instances of bare pr_info with dev_info.

Also make their messages a little more informative.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - No change.
 
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 57800c3575b4..e86553b8fa3d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -2015,7 +2015,8 @@ static int rtl8xxxu_download_firmware(struct rtl8xxxu_priv *priv)
 
 	val8 = rtl8xxxu_read8(priv, REG_MCU_FW_DL);
 	if (val8 & MCU_FW_RAM_SEL) {
-		pr_info("do the RAM reset\n");
+		dev_info(&priv->udev->dev,
+			 "Firmware is already running, resetting the MCU.\n");
 		rtl8xxxu_write8(priv, REG_MCU_FW_DL, 0x00);
 		priv->fops->reset_8051(priv);
 	}
@@ -5420,7 +5421,8 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
 			rtl8xxxu_queue_rx_urb(priv, rx_urb);
 			break;
 		default:
-			pr_info("failed to requeue urb %i\n", ret);
+			dev_info(&priv->udev->dev,
+				 "failed to requeue urb with error %i\n", ret);
 			skb = (struct sk_buff *)rx_urb->urb.context;
 			dev_kfree_skb(skb);
 			usb_free_urb(&rx_urb->urb);
-- 
2.38.0

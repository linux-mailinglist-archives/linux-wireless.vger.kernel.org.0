Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5026B793C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjCMNnG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCMNnD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:43:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B42A5C7
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:43:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y4so19430817edo.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678714981;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFsfPSSLfdCc0QkoLPWkwLIKuLEb1xsUf7BNSzJguNg=;
        b=IzBgfjg2sbstBbmX1HTbH5xDM1BV6/gw+Qj0VMBXSvjG3L5SIGFmXmKdQu/pF5YX79
         w1mlqM4mbB6SogOzgh4PkQ35CeGaTo2/ZM6WCApA3dsLZeQ+a3riVIrNYm6sIlaEaRzf
         3uAdFMnccMYUM/o/Uo2zkwHqtVCNP8i2NEoE58xoJXwI1kcGZ8SPdvR8b8thFBqKcoLc
         PHb8Trr4+elu62Zv16ADnyBKIPNl0+Mi6Ip/x8VPwfy7qUCwL3joj33n/usbDGLmcnNQ
         1xqpv2lBb2w5MnHEKlfJXWpvb4pfmWQiFw0n5WypUIDSiaiW2jwCp3/MUUiFHtE3N50J
         0SVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714981;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GFsfPSSLfdCc0QkoLPWkwLIKuLEb1xsUf7BNSzJguNg=;
        b=igUaaEaaU3Zwd1g/m+Q2oXaZNgd5oDnWYLWFPTFA3mz8mYPItKLEr38w0lKvc2mfIs
         plhwfOHVz8X75r5Kyycd2n/Ld5JpJaeSPur7kbrg4SyMhmIRbv3x3ZWdbfRUmpRcBQl2
         mnDz1NP14BTUVktZNz9EBrC2gJOGjWp1YSdcODAMNHbz25H5zkl1broScbbAl81jPI4e
         eYF3nfpmaGhHfojUfEgFt7EzkDKePECeSIV0gHHNZaslurmmen5uFnAvaJa9K3oPpRme
         8VHMt+gvex32NaT4V/4UHaYi6a62SoNdaB+TEW0I5cV994uT/RAMikJe3P5pVt+/m1TQ
         DKSw==
X-Gm-Message-State: AO0yUKWXBLhVVu8QU0/2xwM6c+2tVS2iBhPWv7xTDa/uTl7dYZuJmOa3
        ZKSt+scJTVO0C5rDryRdE9tXnbUG704=
X-Google-Smtp-Source: AK7set89v+nu+nBb9QI9LtvzpT8gHTdQgvsprXBNpmNZ+bh8PZzzgLTGJnPdYcMGg3+FHZGFaKZGiQ==
X-Received: by 2002:a17:906:b189:b0:8b1:7b5c:bde7 with SMTP id w9-20020a170906b18900b008b17b5cbde7mr36542325ejy.77.1678714980957;
        Mon, 13 Mar 2023 06:43:00 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.25])
        by smtp.gmail.com with ESMTPSA id lv24-20020a170906bc9800b00923f05b2931sm2392543ejb.118.2023.03.13.06.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 06:43:00 -0700 (PDT)
Message-ID: <4eb111a9-d4c4-37d0-b376-4e202de7153c@gmail.com>
Date:   Mon, 13 Mar 2023 15:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: RTL8192EU always needs full init
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

Always run the entire init sequence (rtl8xxxu_init_device()) for
RTL8192EU. It's what the vendor driver does too.

This fixes a bug where the device is unable to connect after
rebooting:

wlp3s0f3u2: send auth to ... (try 1/3)
wlp3s0f3u2: send auth to ... (try 2/3)
wlp3s0f3u2: send auth to ... (try 3/3)
wlp3s0f3u2: authentication with ... timed out

Rebooting leaves the device powered on (partially? at least the
firmware is still running), but not really in a working state.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 0bd1b527b420..4498748164af 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1820,6 +1820,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
 	.has_s0s1 = 0,
 	.gen2_thermal_meter = 1,
+	.needs_full_init = 1,
 	.adda_1t_init = 0x0fc01616,
 	.adda_1t_path_on = 0x0fc01616,
 	.adda_2t_path_on_a = 0x0fc01616,
-- 
2.39.2

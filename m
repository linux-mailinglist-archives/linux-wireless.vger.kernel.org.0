Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC64861DF33
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Nov 2022 23:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKEWzB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Nov 2022 18:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEWzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Nov 2022 18:55:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB7BCBF
        for <linux-wireless@vger.kernel.org>; Sat,  5 Nov 2022 15:54:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q9so21768346ejd.0
        for <linux-wireless@vger.kernel.org>; Sat, 05 Nov 2022 15:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiBH05apkwRxv+xCAFB0dSmkGW5KmgPKchh5k7ZV7mk=;
        b=U61NTJqtexrrnWjO4gbaeJffQKlQOkdFqbULAtmkHd2J90TCmvOY7ycjFpBgmoZExC
         rTqL3XFgCp1endJ8P5Muh8abLSv00GBTvj9VK5J54DY3B04ahNWbI+Aaza7kmJo5+Jof
         Smt2CeunssdfUPhgMznzLSQMto7Stjy0Tt3q1hFiaatNiv+t41Uewq1rw133ZCJSb3IW
         G4A69PAqLN5zediV+Wu14ohGcfJHmka+tMLtHOvvK8WUfsY3b4P8FYjl7NhRZ7QmpIht
         qrYWwJ83LwWqwUzf8qEu2Kdnom7Jo/hIbkw/oyBqKVF6bjkth5+8KoFwUSAT9+UPb8JD
         HWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiBH05apkwRxv+xCAFB0dSmkGW5KmgPKchh5k7ZV7mk=;
        b=nZLtHsetIuRTaAz7QkKEFKKjKVm7AKqqOH6mcmJFW/CSyhDcuU8sPxW57dRkiaXJpg
         w6D/AYOGvFfcl1AJa1XA0lvI4CNCSPKVFET3QeaG1rcY3NAcVtnM15mGQug/2GNYbm/V
         mx6RdxqeHt3LTix/NtXFiGDI5qCR9ZilgUFgNQZutNDTfb4VvqOmlspyh97QlqFQMsCs
         qNDvEEMoDQUmjVfNKieMB/mNJfHNcDGOx1TjEwIz71i9jfk5p1jQrC6Bqm0j7f0besKR
         e3Z4hL+v0tHtUJ2HXtp6xw9byAlPhfQCVQfrSA/9B02Ro2ehiUS+av8Tw8ORkJXkD8eo
         NrgQ==
X-Gm-Message-State: ACrzQf04S0iUyRE1+r/E/8HYce1tt9Y4v32a1IugzWAHrMLQm6RIif8u
        OvbYbgMW//hb6Kgk1/58a9ZqTEeAp1Y=
X-Google-Smtp-Source: AMsMyM7/yoV44iS8s6aF6DX49wmGjQ4qEBFv74mOVoPx5PoiASjTYWvRn1w32dqjOi82yHNPIgtEiA==
X-Received: by 2002:a17:907:2c72:b0:7a5:47da:5893 with SMTP id ib18-20020a1709072c7200b007a547da5893mr40617180ejc.612.1667688897962;
        Sat, 05 Nov 2022 15:54:57 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id o16-20020a170906769000b007ad9028d684sm1420987ejm.104.2022.11.05.15.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 15:54:57 -0700 (PDT)
Message-ID: <ba8e3ea2-74f5-e1db-296e-4ae5f03084dc@gmail.com>
Date:   Sun, 6 Nov 2022 00:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 3/3] wifi: rtl8xxxu: Rename rtl8xxxu_8188f_channel_to_group
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
In-Reply-To: <bef90bf8-716f-c92f-9403-12ef2bfefc15@gmail.com>
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

This name is an anomaly. Change it to rtl8188f_channel_to_group to
follow the same pattern as the other functions.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 4d044a8baa30..0f77312dd0ca 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -352,7 +352,7 @@ static int rtl8188fu_identify_chip(struct rtl8xxxu_priv *priv)
 	return ret;
 }
 
-static void rtl8xxxu_8188f_channel_to_group(int channel, int *group, int *cck_group)
+static void rtl8188f_channel_to_group(int channel, int *group, int *cck_group)
 {
 	if (channel < 3)
 		*group = 0;
@@ -378,7 +378,7 @@ rtl8188f_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 	u8 cck, ofdmbase, mcsbase;
 	int group, cck_group;
 
-	rtl8xxxu_8188f_channel_to_group(channel, &group, &cck_group);
+	rtl8188f_channel_to_group(channel, &group, &cck_group);
 
 	cck = priv->cck_tx_power_index_A[cck_group];
 
-- 
2.38.0

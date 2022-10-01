Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E715F1FDD
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Oct 2022 23:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJAVmz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Oct 2022 17:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJAVmy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Oct 2022 17:42:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9F4685F
        for <linux-wireless@vger.kernel.org>; Sat,  1 Oct 2022 14:42:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a26so15511002ejc.4
        for <linux-wireless@vger.kernel.org>; Sat, 01 Oct 2022 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=5heumV1qzyXk7fM3v1dRqzqB/a3WrfPie7PMYqtZaV0=;
        b=ID9IR/OisA3mm/7Z8eo0C2K/ej2c765SKvG6IdYulJgvcREPtoqJQvPm3Z0ILIzIk9
         TsXlfVRkzVX7wdmWhOjpXMbX9hJxlzrfwVU5MPhFuOTA/B1cF9L7h7CDGA0H0J8BmTJ+
         4sYPltHZArLd5Lp8UZW1wZp7eTfPbLnWls+/SafNnAcfZo9H8xQMP+hjlzlSODlPnlH/
         URs5qQKBPn8HF9E80CvkG3GLVY2fw5FpDb1DiA2340LQb1haVuaEY92+5JLZox7QaXAk
         F7BIUqC+kTG4zMgulGSaeg+/C0IXpiRfbMw6S/YoVKniYx97hFHSM+k7lAjLOLQbOH3u
         BHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=5heumV1qzyXk7fM3v1dRqzqB/a3WrfPie7PMYqtZaV0=;
        b=NjLHBjtgQ38ul68gIQUcW75oQDV3r7Y3bfyr7Oup8HeUjcNDdogNc7Dv1+XeyTISts
         yDuwdbbrmmM7wE74llQ4nGDDiIceIMbRnIKtlOPXagxvsB5UCxJBGj/H48U11rOQKGhm
         IGkG9iiQ+LR2TywgHb3ey+Wd2Kq3NuW6wO2tOlWVHXV5GYTL1FLWhvGXBO9taLT2KlMj
         Zej1oXt66Z15phSiNeKKFbc2HfdAOMjvrkllU801wtPxSSeqN+jtkfCeoPOvwanI53CK
         bnWXfwYO152qjDGcyFe2OROZ7oeGOtCKB+x4ZHjDm0/5BknccBsbcZ7RV3dM8yvth8ry
         vxsw==
X-Gm-Message-State: ACrzQf1MlXl7V8ymYwm9nmwCuI0i8Ife1226FvkZR5Cxbnj4LcbPujG6
        ZcSz+aC8EWsNZsQogeYtJZalXrFTSgg=
X-Google-Smtp-Source: AMsMyM4UV/Q6lMiUtx26JqO/WkrO309xhjy5TkvRvwNHMeHqz4y5o30EiSRCypfcVNh5fwlAnzzQhQ==
X-Received: by 2002:a17:907:6e90:b0:782:a5ef:89a8 with SMTP id sh16-20020a1709076e9000b00782a5ef89a8mr10637741ejc.639.1664660571376;
        Sat, 01 Oct 2022 14:42:51 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id c5-20020a17090603c500b007835316a1aesm3193907eja.65.2022.10.01.14.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 14:42:51 -0700 (PDT)
Message-ID: <2999b8e8-5706-8bfb-c3a5-5c547ab0a170@gmail.com>
Date:   Sun, 2 Oct 2022 00:42:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: rtl8xxxu: Should it support RTL8188EU?
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
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

Considering there is a driver for RTL8188EU already in staging,
which people have been whittling down, should I put any effort
into adding support to rtl8xxxu?

It's actually mostly working already [0], but rtl8xxxu doesn't
have AP mode, adhoc mode, power saving, etc so it wouldn't be
necessarily better than the driver in staging.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git/log/drivers/net/wireless/realtek/rtl8xxxu?h=rtl8xxxu-8188eu

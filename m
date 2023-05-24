Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3259C70FE11
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 20:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjEXSwR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 14:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEXSv4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 14:51:56 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BB2FA
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 11:51:55 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3980c92d8d6so407999b6e.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684954314; x=1687546314;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KDDo3Aq7HIBHvyEGinnXK3HBT6zAGSlt0yPY+SXxKug=;
        b=XN+oSnG9WDlQse3bJGJV4JgN25d1g6lW601JMiU0qSPp4//aspS5rUolBiwphawUyh
         Y76GLDThXWzuVYmZT/zfPrZKzD0RNXKfA46FoyoWtO5mc/MTTQ7T6Cdg5MDb1A6Q5u3Q
         wx8F652Mfjp82eApRf07/FGy9FVkBPmOC1dqfDAMaGpOYXVXTycdY9i+81V+v5ZSUsUC
         cKd0H7K9tFCwQolDmddO4EgGN9SjUODuh+pH2n3DPxx/bs7rqvhAw1qUOX6fo2uUP0kH
         Xk8crw4nGCuD++9Pb3se9neHHXTDuSXcYGGgOtNpNbsQoe/0j30dCNQuZgPdaMzXuLWL
         fe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684954314; x=1687546314;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KDDo3Aq7HIBHvyEGinnXK3HBT6zAGSlt0yPY+SXxKug=;
        b=bskkso6MTkcLOh4EJ/JZigM4+BGWJQfoZizeOrWXSoKzXIQnAnb3A+zlwRWbnR6HSZ
         BD8R/yeELNnjvI/NZGQVX3PZB0jjct0EB0A7uzhaVF53zOV6DccWuoMLvgD2/EhoEqrF
         1AacsdAYKFV6fuEjBj6RKnjNWRvzsLkvBS6zmm8WGtFAXvLskCVSmbXOZPWNUM9n2Iui
         sknU0+1HYVCd5/IMVagvuNyQA7Mt8ISEn5yY56anKcohFREuZBpB4h3Uj0KEOG8FWd9f
         Bx/7qYoGsW5T3Cc3MU4JiwBqRDJzejHt5IpoElGkx++rGDvohTRVifmc4I/NXxYKxROF
         GaxA==
X-Gm-Message-State: AC+VfDz2GfwIPJv9NJSzCFoPqvRYjvuD6pLbi0XkN6ycc+8nfWJ9jJi4
        ZXlRl8JRifR6DlZ4nIF5bgU=
X-Google-Smtp-Source: ACHHUZ6snOkNfEJ4YfEtlrP+WGL/nwnb69iQjl21xAxeTDNtbanXNYXCDx4kEhWAwth6ZQTVJfM+MA==
X-Received: by 2002:a05:6808:b14:b0:398:460f:c884 with SMTP id s20-20020a0568080b1400b00398460fc884mr1788843oij.28.1684954314657;
        Wed, 24 May 2023 11:51:54 -0700 (PDT)
Received: from [192.168.0.159] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id z130-20020aca3388000000b0038de3f4e375sm5565823oiz.23.2023.05.24.11.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 11:51:54 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <1027342a-97dd-83cd-f363-43cff49967e2@lwfinger.net>
Date:   Wed, 24 May 2023 13:51:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: rtw88: Problem with sdio.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Martin,

When I applied your latest changes to my rtw88 repo, the driver for 8723ds 
broke. The dmesg log first showed things like:

[    3.603884] rtw_8723ds mmc1:0001:1: Firmware version 48.0.0, H2C version 0
[    3.615430] sunxi-mmc 4021000.mmc: unaligned scatterlist: os e80 length 2
[    3.622248] sunxi-mmc 4021000.mmc: map DMA failed
[    3.626974] rtw_8723ds mmc1:0001:1: sdio read16 failed (0x10040): -22
[    3.633435] sunxi-mmc 4021000.mmc: unaligned scatterlist: os e80 length 2
[    3.640236] sunxi-mmc 4021000.mmc: map DMA failed

There were similar messages for write16 operations.

I was able to "fix" the problem by turning off rea16/write16 operations for the 
RTW8723DS with the following patch that uses the rtw_chip_wcpu_11n() function:

diff --git a/sdio.c b/sdio.c
index 1647cdc..2051c30 100644
--- a/sdio.c
+++ b/sdio.c
@@ -87,7 +87,7 @@ static void rtw_sdio_writew(struct rtw_dev *rtwdev, u16 val, 
u32 addr,
         u8 buf[2];
         int i;

-       if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2)) {
+       if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2) && !rtw_chip_wcpu_11n(rtwdev)) {
                 sdio_writew(rtwsdio->sdio_func, val, addr, err_ret);
                 return;
         }
@@ -125,7 +125,7 @@ static u16 rtw_sdio_readw(struct rtw_dev *rtwdev, u32 addr, 
int *err_ret)
         u8 buf[2];
         int i;

-       if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2))
+       if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2) && !rtw_chip_wcpu_11n(rtwdev))
                 return sdio_readw(rtwsdio->sdio_func, addr, err_ret);

         for (i = 0; i < 2; i++) {

This leaves 16-bit reads and write enabled for the other chips. Alternatives 
would be to detect when this particular SDIO controller is in use, or last of 
all, add a module parameter.

Larry

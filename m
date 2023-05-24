Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065C970FE61
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 21:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjEXTSS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 15:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEXTSR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 15:18:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE75A4
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 12:18:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51190fd46c3so2525011a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684955894; x=1687547894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCEHiMZmuwTNVUdwjTWepSBtatrmKEIluaAneglLNVI=;
        b=K0d2TAe64fFe5Ld6a5VBc+LP5dPcp2dRoVAJ8IbRBAV2X9mYTnS0poFhcIWk46Hodt
         WEipHkzjJkZ4PzdKjIVuZGnCfpbxU6EhbaG+NeBsinf+nl+ozqjEc+a8anV2qwoW6gxN
         6YcCj2483rfzRWUJFMIT+OZ4KzWXSNywg9+n/mTi0XmQHq07UrOwyFHesGB/Glk4rCal
         ygoCzoIICGBAE08zUSE2jlVj9z5HwJRUY/GQ1FetCST5ULB2VfQx/YKOTBpmvW3KYu8F
         OqsEbBX7CHMyjRRNMJWiC+zI31sXe680ALTxg2JfqXfRZaHs7N4/jFNUrHmimy8K3Mem
         Al3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684955894; x=1687547894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCEHiMZmuwTNVUdwjTWepSBtatrmKEIluaAneglLNVI=;
        b=drzxRpfVrdk/s3V78Hk+NNu7RpLM6BSgl84rvRaIrQCGo1S6JCuSkoMIy5Yib/2tBK
         TtqLPuF4P2gUKW6MZJ66ugXe6w9mYC1H/YXfejUCuI8T/THrEXjaBXETIgz59YogvKIO
         T/2zCNXw1tobUnPo3ocLT9DNg48YW3zyXb5rHh0va7wqfLBtVP8pzVssX6LwCk3hcj0M
         fgueh0I+AMGDVQikh3tv0AvDrmgt65DI+NW07WXMHu6bKYTl9Fyq/LrkMCGevLQnkXfs
         HWUqpKPAOiHCcOt/T/z5lhrRnJ0xtxRX/Ybpm4W6nZOlmSxMX5MeMZ3Ur4N8Uc67tcG3
         mNtQ==
X-Gm-Message-State: AC+VfDwOO4WMoiy54E3JS3g0HMOLWnFGrytfWULS+vc6Dr1G6mqmxJNK
        b0m8VAb4c3O4qBTs/AjaXQ8=
X-Google-Smtp-Source: ACHHUZ4QSg/Uj4W5sc0MCR0ffm1tNzcvcJlaCycC49TVHmq+b5YVoH4mp4Lt9GuFEGBY/7JjVmgy4Q==
X-Received: by 2002:a17:907:2d9f:b0:96f:a0ee:114b with SMTP id gt31-20020a1709072d9f00b0096fa0ee114bmr13852997ejc.21.1684955894489;
        Wed, 24 May 2023 12:18:14 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id jx26-20020a170907761a00b0096f8ec46498sm6049807ejc.2.2023.05.24.12.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 12:18:13 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: rtw88: Problem with sdio.c
Date:   Wed, 24 May 2023 21:18:12 +0200
Message-ID: <2681990.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <1027342a-97dd-83cd-f363-43cff49967e2@lwfinger.net>
References: <1027342a-97dd-83cd-f363-43cff49967e2@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dne sreda, 24. maj 2023 ob 20:51:53 CEST je Larry Finger napisal(a):
> Martin,
> 
> When I applied your latest changes to my rtw88 repo, the driver for 8723ds 
> broke. The dmesg log first showed things like:
> 
> [    3.603884] rtw_8723ds mmc1:0001:1: Firmware version 48.0.0, H2C version 0
> [    3.615430] sunxi-mmc 4021000.mmc: unaligned scatterlist: os e80 length 2
> [    3.622248] sunxi-mmc 4021000.mmc: map DMA failed
> [    3.626974] rtw_8723ds mmc1:0001:1: sdio read16 failed (0x10040): -22
> [    3.633435] sunxi-mmc 4021000.mmc: unaligned scatterlist: os e80 length 2
> [    3.640236] sunxi-mmc 4021000.mmc: map DMA failed
> 
> There were similar messages for write16 operations.

This was fixed in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cb0ddaaa5db09d7d216fcbf0e68779be223a1128

Best regards,
Jernej

> 
> I was able to "fix" the problem by turning off rea16/write16 operations for the 
> RTW8723DS with the following patch that uses the rtw_chip_wcpu_11n() function:
> 
> diff --git a/sdio.c b/sdio.c
> index 1647cdc..2051c30 100644
> --- a/sdio.c
> +++ b/sdio.c
> @@ -87,7 +87,7 @@ static void rtw_sdio_writew(struct rtw_dev *rtwdev, u16 val, 
> u32 addr,
>          u8 buf[2];
>          int i;
> 
> -       if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2)) {
> +       if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2) && !rtw_chip_wcpu_11n(rtwdev)) {
>                  sdio_writew(rtwsdio->sdio_func, val, addr, err_ret);
>                  return;
>          }
> @@ -125,7 +125,7 @@ static u16 rtw_sdio_readw(struct rtw_dev *rtwdev, u32 addr, 
> int *err_ret)
>          u8 buf[2];
>          int i;
> 
> -       if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2))
> +       if (rtw_sdio_use_memcpy_io(rtwdev, addr, 2) && !rtw_chip_wcpu_11n(rtwdev))
>                  return sdio_readw(rtwsdio->sdio_func, addr, err_ret);
> 
>          for (i = 0; i < 2; i++) {
> 
> This leaves 16-bit reads and write enabled for the other chips. Alternatives 
> would be to detect when this particular SDIO controller is in use, or last of 
> all, add a module parameter.
> 
> Larry
> 





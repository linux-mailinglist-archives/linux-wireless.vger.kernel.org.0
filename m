Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278596FB685
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 20:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjEHSzR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 14:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjEHSzQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 14:55:16 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDF15FD8
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 11:55:15 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-18f4a6d2822so33339857fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 May 2023 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683572115; x=1686164115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V+cZgoVXMTeot4CcFP11ye9m+IxX9dxWTEk0/Mbar68=;
        b=ljLbg3qK4XHRflCswHJotuBdeJVelF2uWE0Dsq8dQTfoM090LDvV3HLPL8G5k9nO7d
         u2v8AvsWcXnt/DbMn+zGB5a0OSS1u8HSA2N1Qvt8iCfyKZ8yIzRIpIlt2CeKgAcDEqHn
         dy84JQTritptWnS4RE33Fj29icL9yGXwdONSER4/DKh8BgQTBPKxFYDyN1A5aQON/8wK
         RGtP/bvXJZYdzO0ZKw4XVDmjezUkdJD3g4EWL4jMno9dlycV9io08/R0NVZxCkYyWx50
         wo1nI8xMd84JtrnjGRBI6ilfGn4UpnRPxyqIs/NfScvIfLOGBEEcLjdUXK1zw3Wcl5Zi
         GbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683572115; x=1686164115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+cZgoVXMTeot4CcFP11ye9m+IxX9dxWTEk0/Mbar68=;
        b=F/B1HLn58do2B2fDxKmdOHCv1uUHHfC0HHBk8cjSzgkLYoN4TCzQSqlm1d4YF3kLEz
         lD96kG1oLorvwOVXBJJwSn1sNcvgeoARuT8DCz1bsTk5k3CXCLP7UTrsYvDn3S3yYWDX
         /cBjTNwx8T2+xkpE5SFDD+syTh4EiZNmqqF+kM20J6NCmruGYqyxzSM67HvMSlQyyRBF
         flGLqhKzVZ//ZyI7uvGS9i1YtkLNiDQom0psRCCdk2TYDkaHf+F6CWMlCz77WwLl0eYq
         ZqUkcSsQ4FQ2qygiq2GAg+rNjmN8l3akyYuZTD6exfehx39VLcQcmoPWWi8a+VwB0B8r
         WNIw==
X-Gm-Message-State: AC+VfDz5Azs6OZH/nrYe+M79iOviyTO1rb9AyrxYACuqfQlN6yD7i1ny
        48D7n6jt3yp6v/tXLeYGrUY=
X-Google-Smtp-Source: ACHHUZ5nT1J7Xi1wcOQdNTPHuWdoEV5UbL0xz+OORhYx8N106RDzlc5Z25qIXIsEux11jl2jvSNSmQ==
X-Received: by 2002:a05:6870:63a3:b0:192:b56e:1ab7 with SMTP id t35-20020a05687063a300b00192b56e1ab7mr7704372oap.12.1683572114861;
        Mon, 08 May 2023 11:55:14 -0700 (PDT)
Received: from [10.62.118.118] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id z17-20020a056871039100b0017264f96879sm5223305oaf.17.2023.05.08.11.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 11:55:14 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net>
Date:   Mon, 8 May 2023 13:55:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Driver for rtw8723ds
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <5930608.lOV4Wx5bFT@jernej-laptop>
 <813d74b8-6d9f-c7b0-40b4-c661fca13002@lwfinger.net>
 <CAFBinCB3xnCrLvEvqsFMQuDxL+xC9tkxnwubfC+xEMP3-ZXqSg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAFBinCB3xnCrLvEvqsFMQuDxL+xC9tkxnwubfC+xEMP3-ZXqSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Martin and Jernej,

It took a bit of working through some problems, but the user now has the 
rtw8723ds loading and starting. The first problem other than the mechanics of 
building and installing the driver on his SoC was that there is a second SDIO 
vendor ID/device ID for his device, namely 0x024c:0xd724. As I am carrying a 
local copy of sdio_ids.h, that was relatively easy to fix.

At the moment, when the device starts, the log shows the following:
[    3.640866] rtw_8723ds mmc1:0001:1: Firmware version 48.0.0, H2C version 0
[    3.645302] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 length 2
[    3.654556] sunxi-mmc 4021000.mmc: map DMA failed
[    3.659268] rtw_8723ds mmc1:0001:1: sdio read16 failed (0x10040): -22
[    3.665710] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 length 2
[    3.672499] sunxi-mmc 4021000.mmc: map DMA failed
[    3.677208] rtw_8723ds mmc1:0001:1: sdio write16 failed (0x10040): -22
[    3.683739] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 length 2
[    3.690528] sunxi-mmc 4021000.mmc: map DMA failed
[    3.695236] rtw_8723ds mmc1:0001:1: sdio write16 failed (0x10100): -22
[    3.873173] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 length 2
[    3.879978] sunxi-mmc 4021000.mmc: map DMA failed
[    3.884690] rtw_8723ds mmc1:0001:1: sdio read16 failed (0x10002): -22
[    3.891141] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 length 2
[    3.897931] sunxi-mmc 4021000.mmc: map DMA failed
[    3.902640] rtw_8723ds mmc1:0001:1: sdio write16 failed (0x10002): -22
[    3.909172] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 length 2
[    3.915962] sunxi-mmc 4021000.mmc: map DMA failed
[    3.920672] rtw_8723ds mmc1:0001:1: sdio read16 failed (0x10008): -22
[    3.927116] sunxi-mmc 4021000.mmc: unaligned scatterlist: os b00 length 2
[    3.933906] sunxi-mmc 4021000.mmc: map DMA failed
[    3.938616] rtw_8723ds mmc1:0001:1: sdio write16 failed (0x10008): -22
  [ ok ]

This problem is beyond my knowledge of SDIO.

Thanks for any help you can give.

Larry


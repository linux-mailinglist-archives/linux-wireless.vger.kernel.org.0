Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6786AB981
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Mar 2023 10:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCFJRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Mar 2023 04:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCFJR3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Mar 2023 04:17:29 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B3620D37
        for <linux-wireless@vger.kernel.org>; Mon,  6 Mar 2023 01:17:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l1so7985675wry.12
        for <linux-wireless@vger.kernel.org>; Mon, 06 Mar 2023 01:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678094243;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fpTAGmKjYnXHgPn/6xv3IbFtnqRgDalc7dH55K8iLHQ=;
        b=zeWUmLbLKttdjBAG5tsk+a/h8WCkuQQLbmMPuLAo+Xi+V4u1S+vdAMDUthDr8oZnwO
         gpZ7C2DTQ/aigtkdk2RYFzUGpiKyiIrlZ+9iTFYhrv/WmQowjD+QueqY2yrVP5RJQ8hD
         hT4MY4D0vsU9Qur7e0NL1TnO5llzwVkOrl/JcnNeo2fu5wMbpM6RI+t80MiaEaIlxo6z
         JWRx2jF6lndIL4Uxh6UOXXp3E5dC2H7QjNLNsVWIX3dzI6myiLfFQPi+s0ffsk04Z2VS
         TLy2yFSDr9Dws1jlbOTPpOOozNANM/OFTw+KkW9cp63WsR6OPtLEZwY7YT+zGyve4ji9
         kr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678094243;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpTAGmKjYnXHgPn/6xv3IbFtnqRgDalc7dH55K8iLHQ=;
        b=M/SCShKaL75u91Leb4kVmbdNOUIWhfkq1OsNDGe3kWaQRsX66uqXgZLCo6CYxgO5r0
         PCaM8n+hF4jA+XVQN/WiccP8AYC2uP0dzs1XCkBOawF8uI0oard5CDWFej2+IrUOxLoQ
         45vxMFINPAfp+HSQSPHkMZGH7ebSuQbt/scpqbRahDRn5DtmGfMA0RQr7xpJc8PbKfLt
         sMLdzZuE35W5sWZq7zKppNALX/6XhvlcsdlmcfbS9cZiy8cg0rcas2NTlIuvQu18YHbu
         +o+6awrrT7+P1GOT+rxsJ8He5+j2gKzS03CnU6HWgyb9x8eRjimIVx5NLisk1GWJ1JKq
         XUwg==
X-Gm-Message-State: AO0yUKWhpcXEDJ1YVqtchLaKYg4LYSSvd8VGfpR33AS71B6JTvsYWbuy
        OsgLb05WtSZhFAThm76VdnMNiA==
X-Google-Smtp-Source: AK7set9uoqNTzYvFyRGiT60AnI53z1pW5Hm7qll3aqsyCgi3MeRz1fHkDbXj/iDBVU5klVUCbV4RIA==
X-Received: by 2002:a5d:4404:0:b0:2c7:107c:e172 with SMTP id z4-20020a5d4404000000b002c7107ce172mr5642251wrq.41.1678094243500;
        Mon, 06 Mar 2023 01:17:23 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id q9-20020a5d61c9000000b002c54911f50bsm9294134wrv.84.2023.03.06.01.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 01:17:23 -0800 (PST)
Message-ID: <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
Date:   Mon, 6 Mar 2023 10:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: Unsupported WiFi adapter on S905X2 board
Content-Language: en-US
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Angus Ainslie <angus@akkea.ca>
Cc:     linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
Organization: Linaro Developer Services
In-Reply-To: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Mark,

On 03/03/2023 19:19, Marc Gonzalez wrote:
> Hello,
> 
> I think there's an unsupported device in this system:
> 
> # cat /sys/bus/sdio/devices/mmc2:0001:1/uevent
> OF_NAME=wifi
> OF_FULLNAME=/soc/sd@ffe03000/wifi@1
> OF_COMPATIBLE_0=brcm,bcm4329-fmac
> OF_COMPATIBLE_N=1
> SDIO_CLASS=00
> SDIO_ID=02D0:AAE7
> SDIO_REVISION=0.0
> MODALIAS=sdio:c00v02D0dAAE7
> 
> 0xaae7 = 43751
> 
> Isn't there some overlap between
> include/linux/mmc/sdio_ids.h
> and
> drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
> ?
> 
> (Relevant commit: d2587c57ffd8dc)
> 
> Looking at all the occurrences of 43752 to insert a 43751,
> could someone comment whether this looks reasonable?
> 

<snip>


I think you should send this as a patch as RFC to trigger a review.

Neil


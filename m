Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C89D6C30A5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 12:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCULp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjCULpr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 07:45:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0134A1D2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 04:45:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so9282782wmq.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679399144;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CWaFMETeX/+TKLp3wWaAj/K4R6NJn/u3jzbD2kkaod8=;
        b=TDANZ5rpe7xVRSUP+k3oW4ktOf9YCtQFDmv1r49y9jkA5moQ2RkdRzliKDqmc01hsP
         c05U/OKuEQpxdNMo1kJGQv0B0Bn9Nct0pweh1+HjC9aDNhiNHkU5bOOz9mVTzdAYjR84
         lJYj0M6cHdT0I6PibG646pmbFi7O5yWhcSZ30FRBYrf5P4SxkFwbXLCX7SuRPQ7OZJeF
         GaxOjk92FennVyXNiUSYRCPFBD55IMbtk1cbeEhL/Xp2SV3pgBbbUHRG2ui44X42KWH9
         sXGFD5xyoVnzXknkxR5AS3C9Re9euop/6gMrgoR46ACc9wnNSGZ7+ztm0qo5B9vfFcOF
         rBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399144;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWaFMETeX/+TKLp3wWaAj/K4R6NJn/u3jzbD2kkaod8=;
        b=z5FGqBQ9j6rm6cv614yeTwRbfUCTITLtEfw6lINgXB1hhFFy1T/sNgKt0hprdDJZKv
         9V3YSaV82CrbjalaQ1EvMgBaZ4NhFZWa2/Jd+vu2roIisGnRBrAX32hiEDPPFyvvnETt
         cbIw4hwlh+qSu2ISJ5H5xu/zPCl84wCS5MpYsmlxSPYkWmKgx3D5YMm7jGQF1pC8PVki
         pc2kiucVJZyZYMzET+HLQLAg5fPjbKjba55ZdOR7NNQoAWdPvnft5GutTTQ0QQgam0s6
         wQLuCiKzVMpulLEuc7jn1NTMBhbPbmpWSWN2iBAkGN9V9Di0aARKTemtaTC2Az3mqroI
         Puyg==
X-Gm-Message-State: AO0yUKVJRbHvivOaQbg+PGnMph+TaTFkzBAds0dNbTfxaVpbbXqAwsU7
        YA/hbaECj1KRgjBAgIX1S4BR4w==
X-Google-Smtp-Source: AK7set9DoeZ/JPDoJWMDBwfc9kGtDnReJItkVdQ0K1yGSehrtPPLWrN934gadK43lFJzYEPXt7CXKA==
X-Received: by 2002:a05:600c:24e:b0:3ed:4b2e:c27e with SMTP id 14-20020a05600c024e00b003ed4b2ec27emr2100114wmj.36.1679399143875;
        Tue, 21 Mar 2023 04:45:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c8ed:7915:30cc:f830? ([2a01:e0a:982:cbb0:c8ed:7915:30cc:f830])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003eda46d6792sm10913658wmq.32.2023.03.21.04.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 04:45:43 -0700 (PDT)
Message-ID: <40efc558-6fde-6250-3639-5e8f86c24315@linaro.org>
Date:   Tue, 21 Mar 2023 12:45:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [Performance regression] BCM4359/9 on S905X2
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-wireless@vger.kernel.org, MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Pierre-Hugues Husson <phh@phh.me>
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_PORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Marc,

On 21/03/2023 11:40, Marc Gonzalez wrote:
> Hello everyone,
> 
> I've been benchmarking an Amlogic S905X2 board.
> It provides a BCM4359/9 WiFi chip connected through SDIO.
> 
> There's a large performance gap between vendor kernel and mainline.
> (Downloading a 1GB file to /dev/null from a device inches away)
> 
> # curl -o /dev/null http://192.168.1.254:8095/fixed/1G
>    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                   Dload  Upload   Total   Spent    Left  Speed
> 100 1024M  100 1024M    0     0  27.5M      0  0:00:37  0:00:37 --:--:-- 28.6M
> vs
> 100 1024M  100 1024M    0     0  11.0M      0  0:01:32  0:01:32 --:--:-- 11.0M
> 
> Line 1 = vendor kernel (4.9.180 amlogic android)
> Line 2 = mainline kernel (6.2.0-rc8)
> 
> Why is the vendor kernel 2.5 times faster?
> 
> (I'm using the same firmware files, but it seems the vendor kernel reads
> an additional configuration file that the mainline vendor seems to ignore.)

I think you shall look at https://lore.kernel.org/all/20190527124307.32075-1-narmstrong@baylibre.com/

In summary, for G12A & G12B SoCs (S905X/Y/D2, A311D, S922X) the SDIO controller cannot access
the DDR directly due to an HW design bug, but it can only use the 1.5KiB scratch buffer memory
at the end of the controller registers.

Amlogic did a mask fix on those SoCs to allow routing the SDCard controller to the SDIO pads,
and in their kernel fork they use the SDCard controller for both SDCard and SDIO busses by
switching the pads.

With this trick they managed to have allmost the same bandwidth but with some limitations
when some SDCard transaction occurs and probably some conformance issues since they affect
the SDCard & SDIO pads state when they are switched.

It was decided to only upstream the scratch buffer memory fix because it wasn't invasive
and used the already in-place scratch buffer mechanism. This works but has limitations
due to the very short buffer, and doesn't permit scatter gather.

Porting the Amlogic current solution is out-of-scope because shared controller for multiple
SD slots isn't implemented and not even planned do to some concerns on the I/O states.

Neil

> 
> Regards


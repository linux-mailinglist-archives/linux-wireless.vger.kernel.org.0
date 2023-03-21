Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D7B6C2F8D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCUKwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 06:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjCUKwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 06:52:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CFC7D8B
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 03:52:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e18so1623694wra.9
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679395923;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=K68XFluEkJ4EyRHJihXO8/AhJVwZseuuuSGDSObQY3Q=;
        b=fpY2Lc/LNVH4063nraiPu6JJwbMVe7kciEmg4YMy729ZFshtgzOmhChumgtEIdVQtN
         YHHfEN4Ftgu5pSNSZuF0qvoDPopC6ThvEmU3DSUpZd5UU4rXczI/alLwGe4mfT3KulQq
         br7dB0Gqixii/Nix6fcsD42k/bgP9SdBIRY4X2BXrqVvFKtzxXUbuX68ZXVEkpc4ace+
         mSSXKwX3or4PVABNmH0mc5BABVq/MR+4d0pgeq+NZU3NQYq+sbCeuc+7MdxrX14GBcqm
         6FTy/tg6an6FpCjJSB5XmtA+E4AUoYpKR6af4quxuslqXeikSEXo/XjBm//+JrcCX2ep
         Ty0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679395923;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K68XFluEkJ4EyRHJihXO8/AhJVwZseuuuSGDSObQY3Q=;
        b=BRp0FUbonLZGEbbJi5GDweCBDnhlYLwX7WAHGq/7XhjkNHaEH7eUCh9ayxQkVQtbBa
         hWmokAWsP23eQkia/oW4jdunQIQwX7JgOzCnLW2o2GS0/Y9e5QaTA08JpasV+X0pGwEh
         FMgywwaBFWMVQP9Bu1hAvpc8kf6UbFEXadwUZdVSGazB5HgUBGw6CSgh/ZS1p6gfyXRW
         YewV8vTiNnfWnCX4e+fijZBEBSJcYvU0GzZFzosqauvIn4oVBimf3CYtE7mew48V8784
         g15/wCeUimfbPP/D+eG/i+NqK9HGLOd8wCEI5MG+GaXFPuW2J8znBkDHzz9NEn9LdtI0
         +9Lw==
X-Gm-Message-State: AO0yUKUxOsZWkLPH+s4/mZi0HnaPNsgcZKCpmBFLBRFdtuKiZAHgF+b3
        9V6xJS84R+SmdnSuDz/ktXnsbQ==
X-Google-Smtp-Source: AK7set868qGoElUpfskvJ9bfPpYZPqFEK55esIAH/gTwGF/+V98A4OOLYzWOB74M6NG2BH6E97IH2A==
X-Received: by 2002:adf:ec8e:0:b0:2d9:10e7:57e8 with SMTP id z14-20020adfec8e000000b002d910e757e8mr1312758wrn.16.1679395923106;
        Tue, 21 Mar 2023 03:52:03 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b002c567881dbcsm10944294wrr.48.2023.03.21.03.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:52:02 -0700 (PDT)
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-wireless@vger.kernel.org, MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Pierre-Hugues Husson <phh@phh.me>
Subject: Re: [Performance regression] BCM4359/9 on S905X2
Date:   Tue, 21 Mar 2023 11:46:57 +0100
In-reply-to: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
Message-ID: <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Tue 21 Mar 2023 at 11:40, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:

> Hello everyone,
>
> I've been benchmarking an Amlogic S905X2 board.
> It provides a BCM4359/9 WiFi chip connected through SDIO.
>
> There's a large performance gap between vendor kernel and mainline.
> (Downloading a 1GB file to /dev/null from a device inches away)

The title is misleading. You are comparing different sources. This is
not a regression. This is merely a difference.

If we are talking about mainline, then which board is it ? What is the
corresponding DT ? What is the MMC configuration in both case ? Have
you checked you are running with the same clock configuration to begin
with ?

>
> # curl -o /dev/null http://192.168.1.254:8095/fixed/1G
>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                  Dload  Upload   Total   Spent    Left  Speed
> 100 1024M  100 1024M    0     0  27.5M      0  0:00:37  0:00:37 --:--:-- 28.6M
> vs
> 100 1024M  100 1024M    0     0  11.0M      0  0:01:32  0:01:32 --:--:-- 11.0M
>
> Line 1 = vendor kernel (4.9.180 amlogic android)

This cannot help indentify a downstream kernel, and the infinite number
of forks and patches associated with it.

> Line 2 = mainline kernel (6.2.0-rc8)
>
> Why is the vendor kernel 2.5 times faster?
>
> (I'm using the same firmware files, but it seems the vendor kernel reads
> an additional configuration file that the mainline vendor seems to ignore.)
>
> Regards


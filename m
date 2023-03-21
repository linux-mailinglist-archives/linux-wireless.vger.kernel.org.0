Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C66C3392
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 15:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjCUOBt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 10:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCUOBs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 10:01:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E231B2E5
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 07:01:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ek18so60096566edb.6
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679407304;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=j26tJt6NnNAzyGu4WLnvCWTv3oW1M1SUyeftfDPTWn0=;
        b=AbSVI+I4DHx9JetIGlhjpnoJxZA1uEiOjSQ7e9QiUFYmPRnCkKFhggCMOaaKHpEg1e
         B5ivMtyPoPROhkWW8phhjDBBgw6i7oN1Lsd/t77dtgkjgLE7CcKNls0mmbd535YlMap6
         LOAhwYzaO0eM7oYDuVPvHuCEFOqb8FTMrUUc1SiXDRyVWzz7lX88ex5GqEFv+tXMYgqQ
         m7rC87SBxuN9OK9EE9+m7MQVXqrrwIP1I+ausKlEj5vSKmvAZWcidxD1kdFwtKDz0xXH
         QOr5lId57Rnb34NZPWyAk08L0eRdLZTwZYpUzFeNHsgY+juw5IJxFTeui5dtHWbhfdwE
         INYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407304;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j26tJt6NnNAzyGu4WLnvCWTv3oW1M1SUyeftfDPTWn0=;
        b=ddU097Ewv5zjDiHCQditPodnQTWh1mfxnrQaFPki93SpdxSGME8rhc1zo2DDu+NMm2
         GbewWbu2ZXqI60nupRWn/dEtcA6lg0tfXGQN9zAEVf/MLQ1VG94N8Fe4qTKThy+349Qj
         JslpA3JmFbI5/zJXLUpVx7fdOqxrYjZYbObkR/SudPsNhLpPYq1A+CSrcbBjEb4jOzuC
         9wQ7axhu7Mz9e8JYoMef91W0BXDf0BXwfeoA0Li7sh+J4RTZhzfMcj1IlKZVyZIWlG6/
         ELbnSYq1rrkcDfL1L0w5S0elPjt5vJ2Uafg3OdQPqrZcihDLmDBmZkzHoRNmJivhbDlj
         4Wqg==
X-Gm-Message-State: AO0yUKVFITXc0i69Ip8Qar/sXJJowOrRmwff2UK5ipzVNN0aIOmCWI2c
        eVYRNB/aFRhN4mr7usElpPGgwg==
X-Google-Smtp-Source: AK7set8ucDLG9fAEqf9uy4PxfqGzqLuGzyH3LRu5tCGF8OOY6SlApdT9f6NHyGcmg6+WtRQjZlRzag==
X-Received: by 2002:a05:6402:b35:b0:4fa:ee01:a0cb with SMTP id bo21-20020a0564020b3500b004faee01a0cbmr3386046edb.32.1679407304662;
        Tue, 21 Mar 2023 07:01:44 -0700 (PDT)
Received: from localhost ([2a04:cec0:11b9:8a49:3d4e:8d15:74df:30e7])
        by smtp.gmail.com with ESMTPSA id z23-20020a50cd17000000b004bd1fe2cc02sm6412163edi.16.2023.03.21.07.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:01:44 -0700 (PDT)
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
 <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
 <ce0bd9a5-e44d-b30b-3434-9d5fd36e251a@free.fr>
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
Subject: Re: Performance lower than expected with BCM4359/9 on S905X2
Date:   Tue, 21 Mar 2023 14:54:39 +0100
In-reply-to: <ce0bd9a5-e44d-b30b-3434-9d5fd36e251a@free.fr>
Message-ID: <1jcz526w53.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


>
> I was not asking anyone to reproduce my exact setup.
>
> I find it confusing that some assume there is something different
> about the board I'm using. The more likely hypothesis is that all
> S905X2 boards have the same behavior.

High-speed MMC modes are usually defined/limited per boards.
Check the different  DTs in arch/arm64/boot/dts/amlogic, you'll see
that not all have the same configs.

Yes the S905X2 has the bounce buffer work-around which plays a role on
the overall performance. MMC high-speed modes is critical just has well.

The Amlogic 4.9 downstream does all kinds of fancy (and unsafe) things
to enable higher modes.

So there is no assumption here, merely a tentative to get a clearer
picture.

>
> Regards


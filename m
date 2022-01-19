Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07824935A2
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 08:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352145AbiASHlH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 02:41:07 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38124
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352090AbiASHlF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 02:41:05 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AF5D440055
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jan 2022 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642578063;
        bh=KOwrbfmVaaY4sfUgcL8mu/NpRfAwFGVtSAETT0kqBAg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bF6u0UizThWnJKp9pfXokpEjorghdPKIBCyYZVG592/0jQr6gphbDQQJQFsbgd+bq
         XGlWkWs/0SNPm9ei8uLzJWg5pMRyNXlwewTO+ZuNLtnUA2bv8NeeZGWYJ4JHsQIejC
         4N8z2TZLdxFXEjczxTWXhU58hEYyrKcrpxxrGk5kpzLRXdRmUeJTiPx/hP2fmMZ+Ky
         k1ioqf0B79tAKqH/WzbiVpU9y3KqDHOTwlHBlWLt76Hp8tMv336XmOIY5xiJJbNQJH
         W4kz/FTlebmC579eNQIULhud3PymyeOGSZU0dqvA1Ev9H+WtL726WVHjsI+hMbB0/b
         vQIv95TBHjg9Q==
Received: by mail-lf1-f71.google.com with SMTP id p17-20020ac246d1000000b0042fcd89952bso974968lfo.15
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jan 2022 23:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KOwrbfmVaaY4sfUgcL8mu/NpRfAwFGVtSAETT0kqBAg=;
        b=MSClo31mGSBXzckEx6MapYYrJf/KqqNZo17JRleSdHil0ny3AjHC7BZ5zqwysC/NeJ
         GPDMEcV4INnz5Lu4AHiKP8ta7TE/XjXie/QWTpLmYQZhzFAQKBETTozkCRR23xBr04Nc
         /OzEcSXSxbs88IO7Beyq8u0zTdO5iBWRHTdup3QEYbH1cI6W30NbY1zINAtM8W6oWiIR
         zcc2aIQr2J4/5cNATMSCNJltEmd9ORhZY/0YfZdqjUXSKv1psRZYoGLTvDaPjfFM40oW
         WW4T3IElvJCsOOUGt9EyYQ2vs0IEMMBAiNUwYuUaootqIU8I3XN2UBlkIaEMC3uPjNVN
         p6EA==
X-Gm-Message-State: AOAM533vMHjwRlzPDkht1RZnnR/8xy8Pm7j5roFAESU77aVoWj0zwb6S
        hNhy5NMuS6WgYSjGmCmoQCqhVEBamEuSg24vJn4oBfznPIScH1+2A3w1ZAQ7wiFxByMPvQAAXVJ
        RXnAB6xEO1p8z4xdoUPkNZ3iO57EDimvZH4lDemWxNc27
X-Received: by 2002:a17:907:7ea6:: with SMTP id qb38mr23673612ejc.557.1642578052334;
        Tue, 18 Jan 2022 23:40:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcC/F4TT/k1wEFa2HsX2oDgdxrLKxkyNjrLq8ReErAXQsVWpB2ePW4VmJCVcsiAdC0JWuWGg==
X-Received: by 2002:a17:907:7ea6:: with SMTP id qb38mr23673541ejc.557.1642578052033;
        Tue, 18 Jan 2022 23:40:52 -0800 (PST)
Received: from [192.168.0.42] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id d2sm791994edy.86.2022.01.18.23.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 23:40:51 -0800 (PST)
Message-ID: <21b72055-e158-6586-f48a-17695128b507@canonical.com>
Date:   Wed, 19 Jan 2022 08:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] dt-bindings: Improve phandle-array schemas
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-can@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org
References: <20220119015038.2433585-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220119015038.2433585-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/01/2022 02:50, Rob Herring wrote:
> The 'phandle-array' type is a bit ambiguous. It can be either just an
> array of phandles or an array of phandles plus args. Many schemas for
> phandle-array properties aren't clear in the schema which case applies
> though the description usually describes it.
> 
> The array of phandles case boils down to needing:
> 
> items:
>   maxItems: 1
> 
> The phandle plus args cases should typically take this form:
> 
> items:
>   - items:
>       - description: A phandle
>       - description: 1st arg cell
>       - description: 2nd arg cell
> 
> With this change, some examples need updating so that the bracketing of
> property values matches the schema.
> 

Samsung and memory controller bits look good:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof

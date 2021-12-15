Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E5475118
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 03:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhLOCxw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 21:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhLOCxw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 21:53:52 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A5CC061574
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 18:53:52 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id t7so2320679iln.12
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 18:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=JNO9HQcOsTQ+/F9tSokn+P//npmreQ8s7nXWJHfyG24=;
        b=CuQG5eSOTY/tUfMP0an7paoYzjHJVEIbnHZwcTjDFrJZ0TJ12mOP9DxIfYEGjAY+UB
         F7B0mYZ8jabh435YjXvzj6LZna23yjj3ktCG7S4RsDFQ//EuInPcwzBtky6+4NdAkZ/U
         vEC5IpxdrLlr0B+eqvAZx/IHJOh3MA7tFin51XwWARWieWTDjKflAhAHyPtYh0mIATQ0
         3WnOpopnrwqHcEjY75YWIM4XnwU0EDDp8+4D2Io0ZmZLOHLQYZhdkdGOF5Er05ZV3HQa
         8ZPQG75yQx0PhGWbLwY7XBi2BPJU2/PiAXDepQauzIwtvJxKJrydN5LqYVy2dz0f72Aj
         3MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=JNO9HQcOsTQ+/F9tSokn+P//npmreQ8s7nXWJHfyG24=;
        b=Fo4EumAkcqtPxF8XkF8DC0u89li2Qv3n0x9PQvaOrJFQmyeBoj0kWpcSV4ZzmxOa5f
         R6wA/YON4vNRmbHleDmP+DiuDadP0O2tVSwWpw+lbykUmMCwqqAKQALiAB+wSMeeUtb2
         C3rNaXR2YRRuwKm5h6/QXY6sAnn92YZDeQDF32F1fqW7Bd6aV3zpWh2klj/s8Mft8tcY
         f6AY3JQVLhBBpkbwPNeeSaMtz03mPF7hnl7QN2i06TGXlXGgKoWeqTcE+AYyqjeHW3nb
         yjOPOGLC2hjoEktB36IbWlnDkKypLig5t4gw2B2L1MPszEKTd3g4LKwp8uBdexZ+ihPS
         eymQ==
X-Gm-Message-State: AOAM532FoOWz9NhQbasqlUVUwO2GJfUZ5pE5t/WrAOLujpgpExC82KR0
        ye6llg4N8QnjJJNlYLw95ROI
X-Google-Smtp-Source: ABdhPJxLGSeS/jppKnX2n6TOk9j0USm9m1EGq0mFiKyRnVAqy2C4LTg9ZxO23/COdOBgXqD0ktwj+A==
X-Received: by 2002:a92:b708:: with SMTP id k8mr5613023ili.181.1639536831145;
        Tue, 14 Dec 2021 18:53:51 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:2ba9:697d:eeec:13b? ([2601:281:8300:4e0:2ba9:697d:eeec:13b])
        by smtp.gmail.com with ESMTPSA id g20sm456762iov.35.2021.12.14.18.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 18:53:50 -0800 (PST)
Message-ID: <4a571870f8d95432e53fcce7bcb34e2b41632aef.camel@egauge.net>
Subject: Re: [PATCH v4 2/2] wilc1000: Document enable-gpios and reset-gpios
 properties
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, netdev <netdev@vger.kernel.org>,
        Adham Abozaeid <adham.abozaeid@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ajay Singh <ajay.kathat@microchip.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Date:   Tue, 14 Dec 2021 19:53:42 -0700
In-Reply-To: <CAL_JsqLFyaAvTGQJc0GjYbXwyhpmfpRm3_rkGopD8cz6-ZX5zw@mail.gmail.com>
References: <20211214163315.3769677-1-davidm@egauge.net>
         <20211214163315.3769677-3-davidm@egauge.net>
         <1639512290.330041.3819896.nullmailer@robh.at.kernel.org>
         <e88e908e720172d8571d48bd1ebdab3617534f73.camel@egauge.net>
         <CAL_JsqLFyaAvTGQJc0GjYbXwyhpmfpRm3_rkGopD8cz6-ZX5zw@mail.gmail.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-12-14 at 17:54 -0600, Rob Herring wrote:
> On Tue, Dec 14, 2021 at 5:30 PM David Mosberger-Tang <davidm@egauge.net> wrote:
> > On Tue, 2021-12-14 at 14:04 -0600, Rob Herring wrote:
> > > 
> > > dtschema/dtc warnings/errors:
> > > Error: Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.example.dts:30.37-38 syntax error
> > > FATAL ERROR: Unable to parse input tree
> > > make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.example.dt.yaml] Error 1
> > > make[1]: *** Waiting for unfinished jobs....
> > > make: *** [Makefile:1413: dt_binding_check] Error 2
> > 
> > So this error appears due to GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW in these
> > lines:
> > 
> >         enable-gpios = <&pioA 5 GPIO_ACTIVE_HIGH>;
> >         reset-gpios = <&pioA 6 GPIO_ACTIVE_LOW>;
> > 
> > I can replace those with 0 and 1 respectively, but I doubt a lot of people would
> > recognize what those integers standard for.  Is there a better way to get this
> > to pass?
> 
> Include the header(s) you use in the example.

Huh, that works, thanks!

  --david


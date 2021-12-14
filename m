Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0580474E93
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 00:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbhLNXaY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 18:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhLNXaW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 18:30:22 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C0FC06173F
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 15:30:22 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 14so27000424ioe.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 15:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=AVKBudmt9G81SkbUfzt3qtmKS50VDi84/QAtg5tb48o=;
        b=fUCmXQBFmpf5Gr1QfyxLjFBDavTnDARaTFZ/rwQ2Ux3CneWhH+/BjTx6+Ce4lyxSCa
         yFjOgno0JA6c5j1UJ6zn9fTwO8CEzeph97jI3TYlisVjnArc5NAneju5b+NIKeHY2FiD
         eX2ZzxJc3sgApFL+56CixrE0V2E99mpp2+2eWFOgmBikf9tyYsJBc6Fo5AkAb0h57lr4
         Qp9qnIBNQHw/VKqY08i0dM1XSuyI4mzPhnwCdD6DRIdxiSCFOqhHV3JBE8NGHeFWk4PR
         BLnpZ2AREMMmv6ZIf+sZ6RtTn26Zvsnjq6JygaYOyNCA/H0E52trlmg6k/Y4T7grnPtU
         7ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=AVKBudmt9G81SkbUfzt3qtmKS50VDi84/QAtg5tb48o=;
        b=iTGwdRZoFJ8r5f0cP+CFah7mvaw7GVzrMylS+AiZxpDvjR5PYunXs4EBL+QJs2RwFg
         QcRWq8ONkUfDv/CAa/7Iy+Kpdt27iC+tEeHccoM8K8+DOpTPDuLt4mx6BiR+Dmb9mUMr
         Auh7TU1whl/h9+okB/kRb0lScJawjvyum705igaQy19ffk9Y+VnOeLqyTBJ4xWNyU+JC
         qr7a6mwe/YZRq6xm1u9H3T8el56JSJU9X5L2EBoE4Ro1qXR6TR0NzaX9s3Lb1MlTRmEi
         bPsQTEuVdUlN+o5Y4EBBGUZ7Ei5VASZpZzmmPDkSpJ+kA4feIe7c9uKeFJ7QZKb7Cn6h
         Q3cg==
X-Gm-Message-State: AOAM533OuYzvEJy5cmGJ6o7dpvjvTJNTQa4XiCfxu9X2sLWWxhNmTmBY
        Ju2FWEEwj/YO7+n08b+RAVqG
X-Google-Smtp-Source: ABdhPJw4SVrNuJhAydW0rdGa58Fa2riWaCU0ZYAwdxkxtptJsiAE1NaXtrf12CH0lf59HYeQ/IgAUg==
X-Received: by 2002:a05:6638:4089:: with SMTP id m9mr4712723jam.187.1639524621556;
        Tue, 14 Dec 2021 15:30:21 -0800 (PST)
Received: from bixby.lan (c-73-181-115-211.hsd1.co.comcast.net. [73.181.115.211])
        by smtp.gmail.com with ESMTPSA id k13sm174077iow.45.2021.12.14.15.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 15:30:21 -0800 (PST)
Message-ID: <e88e908e720172d8571d48bd1ebdab3617534f73.camel@egauge.net>
Subject: Re: [PATCH v4 2/2] wilc1000: Document enable-gpios and reset-gpios
 properties
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, netdev@vger.kernel.org,
        Adham Abozaeid <adham.abozaeid@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Ajay Singh <ajay.kathat@microchip.com>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Date:   Tue, 14 Dec 2021 16:30:20 -0700
In-Reply-To: <1639512290.330041.3819896.nullmailer@robh.at.kernel.org>
References: <20211214163315.3769677-1-davidm@egauge.net>
         <20211214163315.3769677-3-davidm@egauge.net>
         <1639512290.330041.3819896.nullmailer@robh.at.kernel.org>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-12-14 at 14:04 -0600, Rob Herring wrote:
> On Tue, 14 Dec 2021 16:33:22 +0000, David Mosberger-Tang wrote:
> > Add documentation for the ENABLE and RESET GPIOs that may be needed by
> > wilc1000-spi.
> > 
> > Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> > ---
> >  .../net/wireless/microchip,wilc1000.yaml        | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.example.dts:30.37-38 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1413: dt_binding_check] Error 2

So this error appears due to GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW in these
lines:

        enable-gpios = <&pioA 5 GPIO_ACTIVE_HIGH>;
        reset-gpios = <&pioA 6 GPIO_ACTIVE_LOW>;

I can replace those with 0 and 1 respectively, but I doubt a lot of people would
recognize what those integers standard for.  Is there a better way to get this
to pass?

  --david


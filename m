Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29D050B578
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Apr 2022 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446833AbiDVKqb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Apr 2022 06:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446821AbiDVKq1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Apr 2022 06:46:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A82CDF13;
        Fri, 22 Apr 2022 03:43:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y10so15533423ejw.8;
        Fri, 22 Apr 2022 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8LyP1jMrL/HWxqHlyehEURdHGMAT2lknQN+ykct+Ec=;
        b=fe8wFU4/llDIkg/0FHZ99uPZ9nVwDXKSu27moTjaarOZHftoCizgCgtLtkv1Mp5o2f
         Qv4B8DuN6/OSEAqIxyfbWvSvYuzRson+6P0HhTXWsjdYj25vLLixxkZgApF7fA3Gw40D
         OHkaR0aZe7bGoTaygK+YmeUdTokyTCyqzTylXRUA/BxxOmnSC0+jD2daJCOVQGq2RABW
         JgGYmYf19bi/W9gqagGxjslh/yEslQono/Nc7BB40RtTCZqJXQoiT2nSwzGotvsEHJuu
         DFeiLhEAA1BNl9xflCYB7+bhlGXtFTPkIfTPSB1x0Dc2KuzChlMKj0HrF5wJweSUVCxl
         tq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8LyP1jMrL/HWxqHlyehEURdHGMAT2lknQN+ykct+Ec=;
        b=ZI/vREUfxeoojt9mWdPZyky6aHgWru1HCZdBN3SNnSE0/e66YFLHJD5MBAc4D+SKdP
         PdGwGtDONNyYahxeRBtZtqwH1hRfdxt00OfKRm6CqoPVWRM/p0y52D9UqvTrMFik6nrE
         6M9APHEHmgHAd7g6GUBsd7UYIBV3ZzPVwGtKTgNslnLZltwXAIW6bI+vvs9umXpm8GXq
         X8Rfsz/r4O7idX59BOkkhwb9Ma62cDN9Z9RM8qrFHX9Llgl0HjtunYwwGlwoUNUrm+B4
         /Bx6EFf7dmOIW+FhWJOaFrW70yp+p1xQgLLb2z1ZwpicYr4BzZF5i7jZkuvbi83tZ9Il
         Dthw==
X-Gm-Message-State: AOAM530B/0n+GFuHO9T0uSyMflxmIHpUo129ZpreR0dq2fXMyOqDRiIP
        Z06ljKJL2i4QlGeLHzKN/EeHo4FEcXb+cuUcgII=
X-Google-Smtp-Source: ABdhPJyX0kLUj7gdkg4bFrTZHlBBJUWe1qkUkAmTvnFP8mcymPt0ZjB9thqj5HOJCgsw9ZCGhD0+ZRetn2td6u7m3mM=
X-Received: by 2002:a17:907:60cf:b0:6f3:60ab:d1ed with SMTP id
 hv15-20020a17090760cf00b006f360abd1edmr1136013ejc.22.1650624212383; Fri, 22
 Apr 2022 03:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAGm1_ktEim1vGOf5i=H_sqrPvg=dT50790YYwXgYKgAut-a=ng@mail.gmail.com>
 <YmDpTAu9wmlLijDA@atomide.com> <CAGm1_kv+b1h1OuWr4w5jS_mqfQpXF7UexiWFsOSs+MJK546=ew@mail.gmail.com>
In-Reply-To: <CAGm1_kv+b1h1OuWr4w5jS_mqfQpXF7UexiWFsOSs+MJK546=ew@mail.gmail.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Fri, 22 Apr 2022 12:43:21 +0200
Message-ID: <CAGm1_ksOt-JtOcTBG7wEqaHagx1NTGYXTMTOG40AN2RELqWKwg@mail.gmail.com>
Subject: Re: wl18xx: NVS file handling
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-wireless@vger.kernel.org, sebastian.reichel@collabora.co.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tony,

On Thu, Apr 21, 2022 at 11:01 AM Yegor Yefremov
<yegorslists@googlemail.com> wrote:
>
> Hi Tony,
>
> On Thu, Apr 21, 2022 at 7:19 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi,
> >
> > * Yegor Yefremov <yegorslists@googlemail.com> [220420 13:58]:
> > > Hi all,
> > >
> > > using the 5.18.x kernel, I get the following warning:
> > >
> > > wlcore: WARNING Detected unconfigured mac address in nvs, derive from
> > > fuse instead.
> > > wlcore: WARNING This default nvs file can be removed from the file system
> > >
> > > removing the /lib/firmware/ti-connectivity/wl127x-nvs.bin file, I get
> > > this warning:
> > >
> > > wl18xx_driver wl18xx.0.auto: Direct firmware load for
> > > ti-connectivity/wl1271-nvs.bin failed with error -2
> > >
> > > What's the best way to get rid of these warnings when I don't want to
> > > handle WLAN's MAC address via the wl127x-nvs.bin?
> >
> > See commit d382b9c00782 ("wlcore: add missing nvs file name info for
> > wilink8"), to me looks like the the second warning should be just removed
> > for wl18xx.
> >
> > > According to this discussion [1], NVS file is the last resort for
> > > handling the MAC address.
> > >
> > > [1] https://patchwork.kernel.org/project/linux-wireless/patch/8665E2433BC68541A24DFFCA87B70F5B363E1A3D@DFRE01.ent.ti.com/
> >
> > Yes the NVS file does not work at all for NFSroot for multiple devices.
> >
> > To me it seems we should have the option for the MAC address to be
> > populated by the bootloader for the devicetree property like Ethernet
> > adapters typically do. Not sure what that might take, maybe it
> > already works. I guess the first step would be to make the nvs file
> > completely optional for wlcore.
>
> I'll try to create a patch for making nvs file optional.
>
> P.S. a TI maintainer for wlcore would be great .... WPA3 and mesh are
> still not really there [1].
>
> [1] https://software-dl.ti.com/ecs/WiLink8/R8_8/change_log_R8_8.html

Wouldn't we need this functionality [1] to make the NVS fw file optional? :-(

[1] https://patchwork.kernel.org/project/linux-dmaengine/patch/20181112160143.4459-1-l.stach@pengutronix.de/

Regards,
Yegor

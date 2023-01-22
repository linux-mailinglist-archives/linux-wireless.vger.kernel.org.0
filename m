Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D020676C5E
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jan 2023 12:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjAVLci (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Jan 2023 06:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVLch (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Jan 2023 06:32:37 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45CD83F3;
        Sun, 22 Jan 2023 03:32:36 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id z9so7658753qtv.5;
        Sun, 22 Jan 2023 03:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoUQsuWkxLgz5UoczyxhIR2hsfTe+OgnR3rck5uq+v8=;
        b=CdZVf5fqDcUBqQr1ez5IG+dmI1TYVx1fuO5BLcSgxqysWAnFIVuxlN7/ABjrIzAICj
         8cEwCSdsmkAQhYKCy+w6lLPpNepXHYoKftwpxYmCz92/wjUPAsYSIA93/GRKhUQ8KjK6
         E6Doks5u10OFzJphoTi60GEDQHeTvynsA8M0RqHM6br6X59f634vmlREkw2D0ws1vJSQ
         QJz8etPaPDnWXzsvG+56TPLDYVgNIFZNq5bA1IUsF/TTKgT+90Xfc38x1BwpwnEhi5Qc
         vk9A2oKYz3NrDjEJG0+dPWuRNl4BcLegzAF0lHifBkTzoJdsPzme6DOIe/11SidrIqA5
         BJxQ==
X-Gm-Message-State: AFqh2kpUAzQ0ZFeiQbzv3fdI88YCibYvUZwYUawyHpLkQiariplmwn3c
        HI/cst16fg9nlx7peovREBqMcD6FLQooKg==
X-Google-Smtp-Source: AMrXdXvbJKdCADp7ev5qF3k5yzvEOd9jCu7JWGkWAqTCOOFrTBijM9DkkfFi0/MgIMPGu39YEOq1Hw==
X-Received: by 2002:ac8:6e84:0:b0:3b6:2f47:de80 with SMTP id c4-20020ac86e84000000b003b62f47de80mr32146859qtv.20.1674387155834;
        Sun, 22 Jan 2023 03:32:35 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id t1-20020ac86a01000000b003a7e4129f83sm23110406qtr.85.2023.01.22.03.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:32:35 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-4ff07dae50dso89820817b3.2;
        Sun, 22 Jan 2023 03:32:35 -0800 (PST)
X-Received: by 2002:a05:690c:c89:b0:4dd:7a8e:1cf3 with SMTP id
 cm9-20020a05690c0c8900b004dd7a8e1cf3mr2209934ywb.384.1674387155088; Sun, 22
 Jan 2023 03:32:35 -0800 (PST)
MIME-Version: 1.0
References: <a85c256af01f64389a078c2b37c3b72a27d97536.1668005062.git.geert+renesas@glider.be>
 <0bb76233-062c-a1c5-da88-4f04feccd5b2@linaro.org> <CABBYNZJX+9SxW48qSSmyyMa7_bvqzwHafa0BNOz4Kz_Jc+gu9Q@mail.gmail.com>
 <CAMuHMdUHo6zEPMF_VR=0Xn2PNHrQRGwzrOP2GXvDN9S19jMaGQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUHo6zEPMF_VR=0Xn2PNHrQRGwzrOP2GXvDN9S19jMaGQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 22 Jan 2023 12:32:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXA_htZuV0VORpfnf9NTvTO=UPne-Y7UV7Fr=KvRxe==A@mail.gmail.com>
Message-ID: <CAMuHMdXA_htZuV0VORpfnf9NTvTO=UPne-Y7UV7Fr=KvRxe==A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: leds: Document Bluetooth and WLAN triggers
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Luiz,

On Sun, Jan 22, 2023 at 11:48 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Jan 20, 2023 at 10:42 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > On Fri, Jan 20, 2023 at 8:42 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 09/11/2022 15:46, Geert Uytterhoeven wrote:
> > > > Add the missing trigger patterns for Bluetooth and WLAN activity, which
> > > > are already in active use.
> > > >
> > > > While at it, move the mmc pattern comment where it belongs, and restore
> > > > alphabetical sort order.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: bt_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> > > >       'hci0-power' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> > > >       'hci0-power' does not match '^mmc[0-9]+$'
> > > >       From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
> > > > arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: wlan_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> > > >       'phy0tx' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> > > >       'phy0tx' does not match '^mmc[0-9]+$'
> > > >       From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
> > >
> > > This patch got lost... Rob, Lee or Pavel, can you pick it up?
> > >
> > > It's with Rob's approval:
> > > https://lore.kernel.org/all/166861772609.231295.14812410099261417331.robh@kernel.org/
> >
> > If it is going to be applied via bluetooth-next make sure to resend it
> > since last time our CI was not able to apply it thus why we didn't
> > apply it in the first place.
>
> Resent as v2, https://lore.kernel.org/r/0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be

According to your CI, it still does not apply.
However, there are no changes to
Documentation/devicetree/bindings/leds/leds-gpio.yaml
between v6.2-rc1 and next-20230120.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

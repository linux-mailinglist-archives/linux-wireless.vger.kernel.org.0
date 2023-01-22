Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59321676C26
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jan 2023 11:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjAVKs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Jan 2023 05:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAVKs4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Jan 2023 05:48:56 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2E816322;
        Sun, 22 Jan 2023 02:48:55 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id u20so7120209qvq.4;
        Sun, 22 Jan 2023 02:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqaHL17YkcYl2MpnxdcgTIjHQUTlapqDHuhLmiWa9Bc=;
        b=gbQ2AH+JTuzhlLJAPjP2mekCYPgVIRNrWmxdzQPhP25Y4qTb3Lv898WmjsPkISnLBl
         eofxsUiQRSc+JreF6NJQ2IRdd4kLvOUKWL+8uTpWk89gzoDonondGM/fdcth30pwYftW
         BD4UssSWmgVUWvVhjSN1IOwA0jfV7grVyqFNfXC48uCj5iUI03+6gTxdUMNq00JSg659
         gOQfLu+zrMajODdVJwxz6zbkdNh97RSZcAviH8ZZRy5uO7B+z32dayYG28o9krEXvQmI
         FZxlu8CGaqwq0PHzA2gQHMritt5uRwVGHtYZDQ4xuJfQHGF0mv7fpp23eyx3cmA+LFHK
         93EQ==
X-Gm-Message-State: AFqh2kqSiKJf0PSogaNJQo/uq/zn0TfJ7PGSJLVmPyToBhwTX9P0Nca/
        PACU/SU4OfU5XTPQfZpfQE87Hyr1Z5wEqg==
X-Google-Smtp-Source: AMrXdXuuvaaqou2sGpOfGtEv0RFLZPCbmXNtdTakI6WViQeCUsxUptelsSAsM6RFvLsYqOoXcsf0+w==
X-Received: by 2002:a05:6214:88e:b0:537:4d4a:6da9 with SMTP id cz14-20020a056214088e00b005374d4a6da9mr10267940qvb.12.1674384534444;
        Sun, 22 Jan 2023 02:48:54 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id d8-20020ae9ef08000000b0070905e2674dsm5631770qkg.76.2023.01.22.02.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 02:48:54 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id t16so7021184ybk.2;
        Sun, 22 Jan 2023 02:48:53 -0800 (PST)
X-Received: by 2002:a25:9012:0:b0:7b8:a0b8:f7ec with SMTP id
 s18-20020a259012000000b007b8a0b8f7ecmr2856562ybl.36.1674384533646; Sun, 22
 Jan 2023 02:48:53 -0800 (PST)
MIME-Version: 1.0
References: <a85c256af01f64389a078c2b37c3b72a27d97536.1668005062.git.geert+renesas@glider.be>
 <0bb76233-062c-a1c5-da88-4f04feccd5b2@linaro.org> <CABBYNZJX+9SxW48qSSmyyMa7_bvqzwHafa0BNOz4Kz_Jc+gu9Q@mail.gmail.com>
In-Reply-To: <CABBYNZJX+9SxW48qSSmyyMa7_bvqzwHafa0BNOz4Kz_Jc+gu9Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 22 Jan 2023 11:48:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHo6zEPMF_VR=0Xn2PNHrQRGwzrOP2GXvDN9S19jMaGQ@mail.gmail.com>
Message-ID: <CAMuHMdUHo6zEPMF_VR=0Xn2PNHrQRGwzrOP2GXvDN9S19jMaGQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jan 20, 2023 at 10:42 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> On Fri, Jan 20, 2023 at 8:42 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 09/11/2022 15:46, Geert Uytterhoeven wrote:
> > > Add the missing trigger patterns for Bluetooth and WLAN activity, which
> > > are already in active use.
> > >
> > > While at it, move the mmc pattern comment where it belongs, and restore
> > > alphabetical sort order.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: bt_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> > >       'hci0-power' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> > >       'hci0-power' does not match '^mmc[0-9]+$'
> > >       From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
> > > arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dtb: leds: wlan_active_led:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> > >       'phy0tx' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> > >       'phy0tx' does not match '^mmc[0-9]+$'
> > >       From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml
> >
> > This patch got lost... Rob, Lee or Pavel, can you pick it up?
> >
> > It's with Rob's approval:
> > https://lore.kernel.org/all/166861772609.231295.14812410099261417331.robh@kernel.org/
>
> If it is going to be applied via bluetooth-next make sure to resend it
> since last time our CI was not able to apply it thus why we didn't
> apply it in the first place.

Resent as v2, https://lore.kernel.org/r/0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

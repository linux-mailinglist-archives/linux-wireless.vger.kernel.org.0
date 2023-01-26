Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09AC67D6BE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 21:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjAZUrN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 15:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjAZUrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 15:47:10 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9E24C95;
        Thu, 26 Jan 2023 12:46:34 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id j15so2377945ljg.8;
        Thu, 26 Jan 2023 12:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8JRQs423qpWUog+nHFrhwfEo9FGIHhJlHpgtXHnAI8=;
        b=CsuY8hOc0S6TR3cGDg1ExGVIPOKn+OqJ1OwxwuO0c8Gdz2WpuxTlcEP+ZPFz3Khu5F
         475ELIhic+XXrq8MLA7tnMYq0CUF/u/GlT7ksJOKJ+9SF8OzL7cikSLpwu+vlDbPo/+v
         o4EuGtkgRM1pipK8GTVOHiRBBm8I26P6qj66tdVgOb5Py5a7Xnz+q/qIjkt11N2zpMRk
         xN/7D0VapK/jGTPA1fxq0lNuyZoliqV296SJh01eyNJvVjfwE6kjR69QdrmEEWNtAHP6
         FV6cMMcQe0mHT0U22M/B9oceNBLNeLuwNd9o64spofEtq2H02/uA+JpZQT+o0gpoNMbs
         6CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8JRQs423qpWUog+nHFrhwfEo9FGIHhJlHpgtXHnAI8=;
        b=UIHs2FlG/AwJbe8bCVB1CKtACCL0AIA1YzjhTC6I8qb+WKPeoAWcBpiqFcNynVmjiM
         7bD/LeObK29mjgpy3KX3jv7zK5c82l8VNUYY8bbvD6wNUo6vV0dKLaL3z9Y1XXWDmNQB
         rJG/598q9JIc7++zX9ziuTAXGnBLBWdbRFyeTLEGYt1A+MYxTIL5VWVowpNr5i0Mepuu
         aKxua3UQ8mIoTj+wxHwHCUnZ9uzWvokFBXATTKEGXMSts4Bf+1dg9U3sjj6ajExayMsG
         caOnpxzkXhZ7gUkzDgbNj6EZHvUm4SPLrWvZ5uiQ09OFZ1IsY6KJ5Ir9q96tQ7FiN57D
         ExkQ==
X-Gm-Message-State: AFqh2kriAy5jud22BVB3t/ASu4f1BhZeABoXI6pQJYgZdWCjiQEZF2Dr
        5P88w6q4VkqhQMV1D14twaNX+FxhK2l5BfZ6KmKfWCpVOrk=
X-Google-Smtp-Source: AMrXdXu5PjFxdJB5hjmPujykCvCLIaf5NB7r9JeAmJ8eyeje/IITqH8iAEreW99bV6+d700rH1R32SF16e+bCJKaYpY=
X-Received: by 2002:a2e:8e84:0:b0:289:ae03:644b with SMTP id
 z4-20020a2e8e84000000b00289ae03644bmr2348689ljk.66.1674765981705; Thu, 26 Jan
 2023 12:46:21 -0800 (PST)
MIME-Version: 1.0
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
 <167460363944.4058.4676712965831302643.git-patchwork-notify@kernel.org>
 <Y9FG5Wg0PmP4zfV6@google.com> <CABBYNZJEU-GD5J6K8_Ur4PWLvP10VNJGP7e_43H0=W3DOS=PNw@mail.gmail.com>
 <Y9IzMWnOq+r2/4V2@google.com>
In-Reply-To: <Y9IzMWnOq+r2/4V2@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 26 Jan 2023 12:46:09 -0800
Message-ID: <CABBYNZ+Na7os7D_C_iV22UhyhobxiETjKkngPWVr14QAph6DfQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
To:     Lee Jones <lee@kernel.org>
Cc:     patchwork-bot+bluetooth@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lee,

On Thu, Jan 26, 2023 at 12:00 AM Lee Jones <lee@kernel.org> wrote:
>
> On Wed, 25 Jan 2023, Luiz Augusto von Dentz wrote:
>
> > Hi Lee,
> >
> > On Wed, Jan 25, 2023 at 7:16 AM Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Tue, 24 Jan 2023, patchwork-bot+bluetooth@kernel.org wrote:
> > >
> > > > Hello:
> > > >
> > > > This patch was applied to bluetooth/bluetooth-next.git (master)
> > > > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> > > >
> > > > On Sun, 22 Jan 2023 11:47:27 +0100 you wrote:
> > > > > Add the missing trigger patterns for Bluetooth and WLAN activity,=
 which
> > > > > are already in active use.
> > > > >
> > > > > While at it, move the mmc pattern comment where it belongs, and r=
estore
> > > > > alphabetical sort order.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > >
> > > > > [...]
> > > >
> > > > Here is the summary with links:
> > > >   - [v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
> > > >     https://git.kernel.org/bluetooth/bluetooth-next/c/ef017002b93b
> > >
> > > Why are you taking LED patches through the Bluetooth tree?
> >
> > I assume there isn't a tree dedicated to dt-bindings/leds
>
> % ./scripts/get_maintainer.pl -f Documentation/devicetree/bindings/leds/c=
ommon.yaml
>  Pavel Machek <pavel@ucw.cz> (maintainer:LED SUBSYSTEM,in file)
>  Lee Jones <lee@kernel.org> (maintainer:LED SUBSYSTEM)
>  Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED=
 DEVICE TREE BINDINGS)
>  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN=
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>  Jacek Anaszewski <jacek.anaszewski@gmail.com> (in file)
>  linux-leds@vger.kernel.org (open list:LED SUBSYSTEM)
>  devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE=
 TREE BINDINGS)
>  linux-kernel@vger.kernel.org (open list)

Well this doesn't tell us what parts of the dt_bindings have a
dedicated tree and which doesn't, anyway this doesn't show
linux-bluetooth so I wonder why people are CCing it.

> > not to mention this was submitted to linux-bluetooth and nobody else
> > other than Rob reviewed it,
>
> To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
>     Rob Herring <robh+dt@kernel.org>,
>     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
>     Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
>     linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
>     linux-renesas-soc@vger.kernel.org,
>     Geert Uytterhoeven <geert+renesas@glider.be>,
>     Rob Herring <robh@kernel.org>
>
> > anyway I'd be happy if the dt-bindings patches
> > would be handled elsewhere.
>
> Yep, we got this. :)

So if it starts with dt-binding: prefix shall we ignore? Or is just
for dt-bindings: leds? Or perhaps we can just ignore patches received
as CC: rather than directly To: field.

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]



--=20
Luiz Augusto von Dentz

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7716C11B2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 13:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCTMS7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 08:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCTMS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 08:18:56 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6C083C1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 05:18:54 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bm1so3569148qkb.13
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679314733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWf5gi7PrYZdVUHXcKdkDx3upI/sFws1Y5rBepbY1Hk=;
        b=XklaahEZswnybOsFHUDjjMJr6GdVYOI4yCjRTYxfrngvgWD0Auz/Bu97GQybvRE2KT
         nkKh3TLCtBSPQG7+u2KGlPEYBukyP64gaIeJPBlVOE3ybT6khDDT4Rg6rsEnU99D/PiB
         KQmKec7oBBc4gxue/4sZIiQkac4CxfP7k1fyLwNqnzUhzDZlrTjLqewtDtoyFtgcliUG
         kZMA+xx+UIvPcsmKGs6dDT31Nlsh/dAfkb2XsxFMtxdQCCzSKgvaSUweEwJmPhVe0gbH
         6Vj+RV9wNAi6T1MagIgWXHVS16ccnHQENCR+n5pWO1FPbYjrdLvi64dMQ9O/SpA9Vbvk
         RUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679314733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWf5gi7PrYZdVUHXcKdkDx3upI/sFws1Y5rBepbY1Hk=;
        b=n7V4W5Wy/Fg4/fHoQCIUnZkOaPagabpwANvYKhrFqYInPlLa0OmQ4/GEuyEfbVf2Yp
         ubPiY8xvLcUFqG1eI/VHhZz7NgWVP/Sva7uumYF3CYHeHh8lhpnNtFFY4sCkQB/Qi1hv
         4u/CEhqkHPQ5Y9U3Klr12g7uFRaJaIfs/vGXITJcOEErs0DzkFDAF8r9EJKok709x4oJ
         4YCXF0b60Vjb1IeybO8PzTxwaXaZu8h46kZjlvuauYfB7B4TWVslzucxKOoyzlMp4W0g
         yzMX5cxxG+UBRCv+uhS5oteT5VJSu/w/a/jRS/5d/qKs11rka0b3fwMr2Cfl3ZCh0mxD
         XXlw==
X-Gm-Message-State: AO0yUKUswx5l5cul8JRaXFw2RFdfOWmy8Qte1qU0oZlQS90Wkk4cjMUf
        ydBSxWqhYBTOnoSfMbnSApfmmo8CeOrYj184oac=
X-Google-Smtp-Source: AK7set8G7AdNOiizKha+eN8c4ArRK1ze5kar2qVKpv1F8V4dYXxnlI5Xd46kHOrhRh7TGZLwiTvbxv6TQ+ZdgulS0xI=
X-Received: by 2002:a05:620a:d5a:b0:742:412d:1dc6 with SMTP id
 o26-20020a05620a0d5a00b00742412d1dc6mr8752258qkl.14.1679314733445; Mon, 20
 Mar 2023 05:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU0TuNA26F+hFwTRGc2pVvW34-7Sc7oQ9EW8V+2cVFgcag@mail.gmail.com>
 <CAD8Lp44c1k-xP1U9X8PR_kw=8joMY8RUwcKVBvuWaV7faNhWZg@mail.gmail.com>
In-Reply-To: <CAD8Lp44c1k-xP1U9X8PR_kw=8joMY8RUwcKVBvuWaV7faNhWZg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Mar 2023 14:18:17 +0200
Message-ID: <CAHp75VeHxZqqvuJXYet=Nt1GA2n_Up23Uf+p7LidY8=fvbvxxQ@mail.gmail.com>
Subject: Re: ath9k legacy vs MSI interrupt issue on imx8mm soc
To:     Daniel Drake <drake@endlessos.org>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        rhu@qti.qualcomm.com, ryanhsu@qti.qualcomm.com,
        rwchang@qti.qualcomm.com, aeolus@qti.qualcomm.com,
        "Valo, Kalle" <kvalo@qca.qualcomm.com>,
        ath9k-devel <ath9k-devel@qca.qualcomm.com>, linux@endlessm.com,
        rafael.j.wysocki@intel.com, andy@infradead.org
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

On Mon, Mar 20, 2023 at 1:29=E2=80=AFPM Daniel Drake <drake@endlessos.org> =
wrote:
>
> On Sat, Mar 18, 2023 at 8:17=E2=80=AFAM Tim Harvey <tharvey@gateworks.com=
> wrote:
> > It seems that Daniel may have been running into something similar back
> > when commit 7368160f0ab0 ("ath9k: add MSI support") was merged
> > [1][2][3]
> >
> > Does anyone have any advice here about what can be going on?
>
> The issue we found earlier was that ath9k MSI is broken unless the MSI
> IRQ number coincidentally is aligned to 4.
>
> Worked around with:
> https://github.com/endlessm/linux/commit/0a2d86a2b9da8f936d873addf0a97e34=
1177fe8a
> https://github.com/endlessm/linux/commit/970d2b4b59465cd926e5213e0feb633f=
6b623447
>
> IIRC the PCI patch wasn't accepted upstream at the time

Briefly looking into it, it won't be accepted in the future either (in
the current form).
The solution there as far as I (possibly mistakenly) can see is that
it's only for x86 cases. For ARM or others there is no explanation on
what would be the effect of the MSI enabling. Hence, it's not widely
tested, nor root caused: May it be the certain x86 PCI bridge / switch
issue? May it be the APIC related issue on that x86 platform? Is it a
bug in Atheros FW/HW?

> and I never
> got any response from Atheros/Qualcomm about this device
> hardware/firmware bug.

--=20
With Best Regards,
Andy Shevchenko

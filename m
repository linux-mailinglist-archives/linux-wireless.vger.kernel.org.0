Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915B07C507D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346329AbjJKKpe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjJKKpc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:45:32 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FBAB9
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:45:31 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d77ad095f13so6968492276.2
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1697021130; x=1697625930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YL127oscJH6gp+yTxggd3LK31C8e1HyGUVVsaS6zp14=;
        b=s6/DIQkRDGdNnJh9ZpyAgywbQ16XujPIJpwBxOeb8qDyZDoSLjRxAK6VqvJYRkYEX3
         OvoZC4YBZ20iwHRLMiicACWSjmDle58xYY3sIqxw9T/CG0beNYYoSLBvLpp/Wi5gvxS9
         K5Zl1afT/8/dKJPj7YKQiU3RDMQmoK5nTlx3ib5ivqBsqGb4k85eNWjIyUwPICH57kZb
         plW1JwaR+JtxgUL5mKXfyOKxDOyIjuf4UdZ9BwPsYJ3BZ3mJ5HyZjUZ4dk+dLZ11r5LS
         H2MrRWnCmfoWfZ2UK0QCmtCwLhjlyo5arele19xiBSawClkbBGK6jiW2Pjjs1aA8ZGJJ
         XdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697021130; x=1697625930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YL127oscJH6gp+yTxggd3LK31C8e1HyGUVVsaS6zp14=;
        b=PgwUlBFUum1pBqzZ/nTEXUi9LuyXY7+LXnlHL1Wg2Tpvo9bUaTBYYioDl0QsFkGsVV
         OOTNAKIBUBvF6JIy163/7MWSkAP6etHpgKX+s2hEZm34eyaTRCXD/4ALh5vy0R6BaGQh
         els7gfQ2K/O8rGITF3fDJRbq11h3c/taOd6khe5yxc3D3ZgRh/rMWPT2XvqPZrHA30qm
         iCefE7V5Br1cUu5DrJwRCUwIqRAtGKKJ1f2MZEYI81bg/r22n5OFMFn7GdcZ9vMa8YMv
         47QSW1ySqar5BRVkya4SAMicD6vUDJwzdljOxfBrw9BlhyfJlUjH9NlGysJPQcZiMzaA
         daEA==
X-Gm-Message-State: AOJu0YxWqdaQT49zpE1p6BmO2risRnueLXBLwGeJo3I6k2BsHMwJilK8
        6K183KX/ZHUqsyxzwums4UWQgkC/hv1JW5uXQex/mSIAqBTXPuAS2J0=
X-Google-Smtp-Source: AGHT+IEVy8EiOeFMRwy82Ir7VUyJ+VT9Vb2TmVUBB9wyYFi+w/lohD+ek63I+hZOrWHuWUg2Bmz6JRy1diehmTzQzwc=
X-Received: by 2002:a25:aaad:0:b0:d9a:526a:2514 with SMTP id
 t42-20020a25aaad000000b00d9a526a2514mr4809848ybi.62.1697021130679; Wed, 11
 Oct 2023 03:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org> <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
 <e1ee4d76-f717-a67c-8099-7b91192ba1ca@yandex.ru> <e470902a-35eb-9bb4-7a9e-167f985c98bb@marcan.st>
 <CAEg-Je-mpcrEoM_nD3_8A=gZhdWpn3hxfGZNEfGRNupGwRdetw@mail.gmail.com>
 <CAMEGJJ3jeOK2WbW7YP4=y2E0Z7GnffHiqZhgAmXJjKchv3jG+A@mail.gmail.com> <87a5sp4fha.fsf@kernel.org>
In-Reply-To: <87a5sp4fha.fsf@kernel.org>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Wed, 11 Oct 2023 11:45:19 +0100
Message-ID: <CAMEGJJ35-D5ReGsfUwhOxKE1OC6NaBWoAGudBp=QRkuLU5BYnA@mail.gmail.com>
Subject: Re: On brcm80211 maintenance and support
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com,
        Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Wed, 11 Oct 2023 at 11:32, Kalle Valo <kvalo@kernel.org> wrote:
>
> Phil Elwell <phil@raspberrypi.com> writes:
>
> > This is just a quick note to say that Raspberry Pi obviously has a
> > vested interest in the future of the brcmfmac driver. In our
> > downstream tree we use the upstream driver largely unmodified - there
> > are a handful of patches that tinker around the edges, the largest of
> > which is in the area of firmware location and being phased out - no
> > patches from Infineon/Cypress, Synaptics or Broadcom.
> >
> > We're very much WiFi users as opposed to WiFi developers, but if
> > there's something useful we can contribute then please speak up and
> > I'll see what we can do.
>
> Is it possible to run upstream vanilla kernels on a Raspberry Pi? For
> example at least once a month take latest wireless-next[1], install it
> to a Raspberry Pi and run some simple wireless tests. If any regressions
> are found report that to linux-wireless. Preferably with a bisect log to
> easily find the offending commit.
>
> Testing patches before they are applied would be even more helpful,
> especially for the risky ones. We have a hard "no regressions" rule so
> earlier we catch the regressions the better.
>
> I also wonder should there be a dedicated brcm80211 specific mailing
> list? That way people who want to help could easily follow and discuss
> brcm80211 development, and no need to follow linux-wireless. For example
> we do that with ath12k driver.

It's a very busy time for us at the moment, but a monthly-ish wireless
smoke test sounds reasonable. Hopefully once we have a process for
that then occasional regression checks on upcoming patches would
become possible.

A dedicated brcm80211 mailing list would be good - I'd definitely sign up.

Phil

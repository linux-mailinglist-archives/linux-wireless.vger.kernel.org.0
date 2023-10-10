Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34F57C0074
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjJJPfx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 11:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjJJPfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 11:35:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E529B6
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 08:35:49 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d8afe543712so6194191276.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1696952148; x=1697556948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+bVvVmNARXfzksOwpB0sUT7ON07eOsylXSyNT6q0Wk=;
        b=LwsYK1mDbwygFdLcK0M2Fwg3dER8Hx6z0CnEhnMU/5pOkgW1l4KNxKnAgf0zAVt8r4
         4VKOMXBBwS+x9Cvr1c6qJgO2oxnpxDJOGMj02EZh/WgR0qV9qJyt6onG3PYA/sMhqiKQ
         BFNUY4AlxVcH2Pc3NW8nhYRhS8Z3kbkwSm8eohNpVYv22c4Dw/+YnMV9ja4XtL5d+ys0
         lnwiKY09NQ6Yk3pbAc1cYG/DB/gjzYM/Sl3p5ThSz2o+DElM3j3PxenNpVEwPOTSnOPZ
         NCYCVgPFQNyZbS7OGtQKiGm2n93hgfgWZpV5DZnFHozHWsL85h90qw6KBDnqTNo7bDWv
         XOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696952148; x=1697556948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+bVvVmNARXfzksOwpB0sUT7ON07eOsylXSyNT6q0Wk=;
        b=kWX7TL43fkaoawTfRoB4k09EYRXOl0JGX/xg1UBwN0oBtaPbi8v03A7Dhiy2h0qMnw
         siNDwiZSu0cFpLPg1VsPH4kq7njP6OaJYAMJuO5gPQbkP9oCIP3gWzahC6DQ13XgVjru
         HzZPNPQ0NdDyckPPp7IESq+FlfcA/R2RKcwVh2WCLqTAD470+9LUpiwIYIWKUL9en0vJ
         1xjBxQ9o/LM8B22RKfpbUYr/UwlNiBG4hUWmmPCPazdT4flQ4OffHShM2p1E3rNwkVyt
         DcTNMxIlyD1t5kJaBEFrBEsDH5Yb71c1K+jNLWcJQAkkAJcW34Mx0r3LJ4byL4Ykt63j
         3uGQ==
X-Gm-Message-State: AOJu0YyHelEGCHDcKd3SJIxMvBn4URN4tdjct6ecCpXVY5y2UhcDTZZ8
        2vv3Uw/ZA1mWcor0YAjX6pwxZt/NenCemPgWKzDRSQ==
X-Google-Smtp-Source: AGHT+IHyKvPvteLHJsP21FSAJDsvCrIM7jAUYYBVWwm3qsR0h8B0YjeevGze8t/rDMvBAMvKtKPMdsN1QwahNOoS6YM=
X-Received: by 2002:a25:4cc9:0:b0:d9a:6aaf:2589 with SMTP id
 z192-20020a254cc9000000b00d9a6aaf2589mr1415894yba.9.1696952148563; Tue, 10
 Oct 2023 08:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org> <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
 <e1ee4d76-f717-a67c-8099-7b91192ba1ca@yandex.ru> <e470902a-35eb-9bb4-7a9e-167f985c98bb@marcan.st>
 <CAEg-Je-mpcrEoM_nD3_8A=gZhdWpn3hxfGZNEfGRNupGwRdetw@mail.gmail.com>
In-Reply-To: <CAEg-Je-mpcrEoM_nD3_8A=gZhdWpn3hxfGZNEfGRNupGwRdetw@mail.gmail.com>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Tue, 10 Oct 2023 16:35:37 +0100
Message-ID: <CAMEGJJ3jeOK2WbW7YP4=y2E0Z7GnffHiqZhgAmXJjKchv3jG+A@mail.gmail.com>
Subject: Re: On brcm80211 maintenance and support
To:     Neal Gompa <neal@gompa.dev>
Cc:     Hector Martin <marcan@marcan.st>,
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
        Kalle Valo <kvalo@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi everyone,

On Tue, 10 Oct 2023 at 15:53, Neal Gompa <neal@gompa.dev> wrote:
>
> * Spam *
> On Sat, Oct 7, 2023 at 8:51=E2=80=AFAM Hector Martin <marcan@marcan.st> w=
rote:
> >
> > On 07/10/2023 00.48, Dmitry Antipov wrote:
> > > On 10/6/23 18:34, Hector Martin wrote:
> > >
> > >> For better or worse, if nobody else does, I'm willing to sign up to
> > >> maintain the chips shipping on Apple ARM64 machines (i.e. BCM4378,
> > >> BCM4387, BCM4388 - that last one I have bringup for downstream, just=
 got
> > >> it done this week) and partially BCM4377 as a bonus (since I have ac=
cess
> > >> to an older Intel Mac with that one, and already did bringup for it,
> > >> though my access is sporadic). I'm already playing part time maintai=
ner
> > >> anyway (other folks have already sent us patches I'll have to upstre=
am),
> > >> and we need this driver to keep working and continue to support new =
chips.
> > >
> > > Good news. Would you capable to consider some generic (not hooked to =
any
> > > particular hardware) things like [1] ?
> > >
> > > [1] https://lore.kernel.org/linux-wireless/20230703162458.155942-1-dm=
antipov@yandex.ru/
> > >
> >
> > Sure, I've done cleanup type stuff myself too.
> >
>
> Can we please get this done so that the pile of Broadcom patches can
> actually start landing again? It's been frustrating watching patch
> submissions be ignored for over a year now. At least add Hector as a
> co-maintainer and allow him to land stuff people have been using
> outside to get Broadcom Wi-Fi to *work*.
>
> Having stuff sit on the pile and be *ignored* is frustrating for
> contributors and users, and massively disincentivizes people from
> working in upstream Linux.

This is just a quick note to say that Raspberry Pi obviously has a
vested interest in the future of the brcmfmac driver. In our
downstream tree we use the upstream driver largely unmodified - there
are a handful of patches that tinker around the edges, the largest of
which is in the area of firmware location and being phased out - no
patches from Infineon/Cypress, Synaptics or Broadcom.

We're very much WiFi users as opposed to WiFi developers, but if
there's something useful we can contribute then please speak up and
I'll see what we can do.

Phil

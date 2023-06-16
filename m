Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22A4732925
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 09:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbjFPHqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 03:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244744AbjFPHqL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 03:46:11 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A07B2D61
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 00:46:00 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so432649e87.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686901558; x=1689493558;
        h=in-reply-to:references:message-id:subject:cc:to:from:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU0qxCzPl20kJKOqOVSGY+gianqgCNGR85w4fJS8dg4=;
        b=SBE/iYM4gopO1FtPL2J1JAyCWy8jhpYjMK9ORY5/b7SfWeUDekB7wAzikYTfmnqqNu
         marqrD0/+uA95OE3t0XraKg1Sn30TlOQ6xxCKlwKnD2z9FNrzRfTjQmEa5WsXGdLEglc
         MVw3CpftDEXWmndc1c0Cmn/SLMuTePww6X/wfeaidcPKVfhUdoY5Qm02SMhwyy5b5Z8U
         TtuhAH1/Y0rLFRLOImHscfiuWS5c/5e6LIn2reaZmwFklJKgvHV7PrMC9PNL71WojEXi
         MSttrBPgciQWOvFNHBfzES135vQZe48pGEyKpSY8ujn9TP4I2lvLbVJQleAQj8JDXdjB
         EifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901558; x=1689493558;
        h=in-reply-to:references:message-id:subject:cc:to:from:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EU0qxCzPl20kJKOqOVSGY+gianqgCNGR85w4fJS8dg4=;
        b=gv0BXx+O8CbuxugugbZg2ZsGd/ZeaLMzjykmw6YEFgI0Pk7BUa91CInt+Dy6WKqMlN
         Nw784E1LT2SiDEMsEe3UvZofn8a00rlzKZtj9v196pj3olPcSTWHb8ktFKtei1OXFzXT
         sQGFXcVMfjYaTcPSnuyU6Od7kNNHiLiYcnTtSwf0TuIBcZvbSspTYk1WUB7kbFa74ayJ
         dpHwEfg+eY8b1nouIX+EBZeXhx01VNe4USy1IlV3sV1m1uiqwQiixFIvdaWJJtiFGF43
         AodrcgdaiijAHg8yRpvwi++qpalP5nWxyD4fWj2s8sClFtn7kE2+AhphvKZxGcawb7VC
         qIUQ==
X-Gm-Message-State: AC+VfDysHfRjyP7cpeh8XxznawBqC7Qd3DBGfaNhPv2oPgDvbXn0j3SK
        b+l9P/LN6phftPT0TmpWSLU=
X-Google-Smtp-Source: ACHHUZ4JlwEt9VjsDLTTnFYd85ySoaH+5kHFYr3jQQ/GMigh263c6y/0Gm5Ft7nktkzB4VSfuDoPlQ==
X-Received: by 2002:a19:e30e:0:b0:4f6:116d:6d26 with SMTP id a14-20020a19e30e000000b004f6116d6d26mr607146lfh.42.1686901558119;
        Fri, 16 Jun 2023 00:45:58 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id u14-20020a7bcb0e000000b003f42314832fsm1425490wmj.18.2023.06.16.00.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 00:45:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 16 Jun 2023 09:45:57 +0200
From:   "Nicolas Escande" <nico.escande@gmail.com>
To:     "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>, <nbd@nbd.name>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "Kalle Valo" <kvalo@kernel.org>,
        "Johannes Berg" <johannes.berg@intel.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [regression] STP on 80211s is broken in 6.4-rc4
Message-Id: <CTDWJJDKSYYD.XBG1CAZB3A5W@syracuse>
X-Mailer: aerc 0.15.1
References: <CT5GNZSK28AI.2K6M69OXM9RW5@syracuse>
 <ZIQbs0wqdRh7c0Kx@debian.me>
 <a9d02800-2cd6-a27b-7998-4c97cf2eb692@leemhuis.info>
In-Reply-To: <a9d02800-2cd6-a27b-7998-4c97cf2eb692@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu Jun 15, 2023 at 2:54 PM CEST, Linux regression tracking (Thorsten Le=
emhuis) wrote:
> On 10.06.23 08:44, Bagas Sanjaya wrote:
> > On Tue, Jun 06, 2023 at 12:55:57PM +0200, Nicolas Escande wrote:
> >> Hello Felix,
> >>
> >> As user of the mesh part of mac80211 on multiple products at work let =
me say
> >> thank you for all the work you do on wifi, especially on 80211s, and e=
specially
> >> the recent improvements you made for mesh fast RX/TX & cross vendor AM=
SDU compat
> >>
> >> We upgraded our kernel from an older (5.15) to a newer 6.4. The proble=
m is STP=20
> >> doesn't work anymore and alas we use it for now (for the better or wor=
se).
> >>
> >> What I gathered so far from my setup:
> >>  - we use ath9k & ath10k
> >>  - in my case STP frames are received as regular packet and not as ams=
du
> >>  - the received packets have a wrong length of 44 in tcpdump
> >>    (instead of 38 with our previous kernel)
> >>  - llc_fixup_skb() tries to pull some 41 bytes out of a 35 bytes packe=
t
> >>    this makes llc_rcv() discard the frames & breaks STP
> >>
> >> >From bisecting the culprit seems to be 986e43b19ae9176093da35e0a844e6=
5c8bf9ede7
> >> (wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces)
> >>
> >> I guess that your changes to handle both ampdu subframes & normal fram=
es in the
> >> same datapath ends up putting a wrong skb->len for STP (multicast) fra=
mes ?
> >> Honestly I don't understand enough of the 80211 internals & spec to pi=
npoint the
> >> exact problem.
> >>
> >> It seems this change was already in the 6.3 kernel so I guess someone =
should
> >> have seen it before (but I didn't find anything..) ? Maybe I missed so=
mething...
> >>
> >> Anyway I'm happy to provide more info or try anything you throw at me.
> >>
> >=20
> > Thanks for the regression report. I'm adding it to regzbot:
> >=20
> > (Felix: it looks like this regression is introcued by a commit authored=
 by you.
> > Would you like to take a look on it?)
> >=20
> > #regzbot ^introduced: 986e43b19ae917
>
> Hmmm, Felix did not reply. But let's ignore that for now.

I haven't seen mails from felix on the list for a few days, I'm guessing he=
's
unavailable for now but I'll hapilly wait.

>
> Nicolas, I noticed there are a few patches in next that refer to the
> culprit. Might be worth giving this series a try:
>
> https://lore.kernel.org/all/20230314095956.62085-1-nbd@nbd.name/

Well this series already landed in 6.4 and that is the version I did my ini=
tial
testing with. So no luck there.

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

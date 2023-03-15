Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24FB6BBDA5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 20:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjCOTxy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 15:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjCOTxx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 15:53:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4EF18B0E
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 12:53:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r29so10334143wra.13
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg.ch; s=google; t=1678910030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO+lrnC0VhciQ2doVDFyAUPl+/auTYXI4kOFvcvZBY0=;
        b=cDpX3OlaUaqQorG0d8d1v//+TmiHfsN4tfOKjv84LncIaROx1u+eXtUqERnsuS/5tc
         2hyS5DswFpcIL1Xw5W0L4YHdRhMgLlKUYN8PWhjBqk9ZSom2L9ERV5YsQY0Y8SwO3WbA
         pO5K3PHvpt0bYPUOZiz18Uo4Zn1dg79hi1WyDk461+Q80hLBHiV+6fT5awG5LSx9ilnx
         mS1bpHWYLZSd+oku+3Mc4RzUbwnNj/yitLD83LyN4fPdEYgpsfJXB88MlUggspbE6kuV
         GpGHa4QX/YUxlna31MGMWamfeXcYMXouO4AhoWXkRLuY2NQeFzEJuCbqqONVknk7ZiZn
         KV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678910030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO+lrnC0VhciQ2doVDFyAUPl+/auTYXI4kOFvcvZBY0=;
        b=WapzsvDf8DGSNTi/OXm/DVGzE/4lO+PezeATP7hI3GaniMVqUGR0Elk7z/5dklis3v
         qGB5xLhAD2LtAowYLT5MXUZTl09wkSabnmPc2gZaoFeXzr00Zb2VaBeCIx3dNw9zAlnl
         Postoxx/eN2GoXpMgUieOutFzrgnXWKrEaj9ymkpSoEiyTP9urIXWHiB42WFyN1A3PsG
         TB7GunBXaPve6C5gIBANwYyXpN1v0O2xn2p0J/qB7niAKLYECE/x4cn2AY5Trg403H2B
         AyvG3wnszpxhVMAVyteWcc2KotZ8wiInQBP3UGpkPKz+N5HyoPi4qCX2+utSqgSAb7tz
         KYSA==
X-Gm-Message-State: AO0yUKUXVyBbnfK5omkHeuT3PF/fKL7jiYvkSl/JnABxuYr9rdI2nlyv
        jplgxA1foMrrZ7xxPXPMyVSrkRqWQYGFhKy4HbRjIA==
X-Google-Smtp-Source: AK7set/DtNrClO7btyZx9aLyoRAvA+IawrY11kAw8KUuCSYl03dt1DmFf0LhBLUTFGSGAwvcdpmMUUlw0uSIGyrzzg4=
X-Received: by 2002:a5d:47ae:0:b0:2cf:ea35:f8bc with SMTP id
 14-20020a5d47ae000000b002cfea35f8bcmr1096842wrb.6.1678910029674; Wed, 15 Mar
 2023 12:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <CANnVG6=a3etRagG+RaSEH-b4_nfzxpEKffQtuMWrttrbgjunZQ@mail.gmail.com>
 <186e23b5668.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kjWj02eEFv_OeLiRtjrJ6yn4EsELz_BtrzFHH15GNMLw@mail.gmail.com>
 <186e26dc0a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6n-eqKUQnX_6wncmjG1kyVfhxqs2L82xYQpDmGq89eVAQ@mail.gmail.com>
 <186e4673718.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kaGj1SVCqf2y3=Xj_N2G9j+-VhLDN4_WY_ywDswNkO3g@mail.gmail.com>
 <89262772-7358-77e8-8913-c459819d544a@broadcom.com> <a459b9adc5eb7b67a432bd947d47d1df08718762.camel@sipsolutions.net>
 <f430c376-5992-d394-ce55-5994c793c7c7@broadcom.com>
In-Reply-To: <f430c376-5992-d394-ce55-5994c793c7c7@broadcom.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Wed, 15 Mar 2023 20:53:33 +0100
Message-ID: <CANnVG6neOX+Bgc3zWA8k=hwrifmXb=xBN95aMUEyJ=orz3+Wkg@mail.gmail.com>
Subject: Re: wifi breakage due to commit "wifi: brcmfmac: add support for
 vendor-specific firmware api"
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey Arend

Thanks for looking into it.

Your suspicion was spot on: we don=E2=80=99t have /sbin/modprobe (we don=E2=
=80=99t
even have /sbin!)

I addressed this issue by loading the brcmfmac-wcc module where we
also load the others:
https://github.com/gokrazy/wifi/commit/f611656338b68faa5f42bc2c8bbf1e0231a7=
4a50

I=E2=80=99m not entirely sure why I concluded in my earlier testing that
loading the module doesn=E2=80=99t help.
Perhaps the issue was that I was manually loading the module after the
wifi program
tried to use the interface already and had it fail its firmware load =E2=80=
=94
in either case,
loading brcmfmac-wcc from the wifi program seems to work fine.

I also realize that the error message gives a number of pointers once
you know how to interpret it:

+ brcmfmac: brcmf_fwvid_request_module: mod=3Dwcc: failed -2

I now understand this was trying to tell me that
request_module("brcmfmac-wcc") failed
with error code -2 (ENOENT), which means that the kernel=E2=80=99s
request_module() function
could not find CONFIG_MODPROBE_PATH.

For comparison, when the user space tool exists but fails, including
when it can=E2=80=99t find
the requested module (ENOENT), it always returns exit code 1:
https://salsa.debian.org/md/kmod/-/blob/7d761268ebb68245daf47167e418823c68c=
3eb98/tools/modprobe.c#L1025

I think it would be nice if the Linux kernel could print a more
descriptive error message in this case.
I=E2=80=99m not sure what the kernel conventions are: should the caller of
request_module() produce a good error message?
Ideally, the message would translate -2 into ENOENT, and mention the
name =E2=80=9Cbrcmfmac-wcc=E2=80=9D.

Or maybe we could have a kconfig option to indicate there is no
CONFIG_MODPROBE_PATH,
and instead make any request_module() call fail loudly with a
descriptive error in dmesg?

Thanks for considering
Best regards
Michael

On Wed, 15 Mar 2023 at 11:11, Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 3/15/2023 10:57 AM, Johannes Berg wrote:
> > On Wed, 2023-03-15 at 10:12 +0100, Arend van Spriel wrote:
> >>
> >> I think it works pretty similar to firmware loading. These days firmwa=
re
> >> loading does not rely on a user-space helper and I assumed the same is
> >> true for module loading. Will look into it.
> >>
> >
> > As far as I know you still need the modprobe helper in
> >
> > /proc/sys/kernel/modprobe
>
> Hi Michael,
>
> With hint from Johannes I found this Kconfig option:
>
> config MODPROBE_PATH
>          string "Path to modprobe binary"
>          default "/sbin/modprobe"
>          help
>            When kernel code requests a module, it does so by calling
>            the "modprobe" userspace utility. This option allows you to
>            set the path where that binary is found. This can be changed
>            at runtime via the sysctl file
>            /proc/sys/kernel/modprobe. Setting this to the empty string
>            removes the kernel's ability to request modules (but
>            userspace can still load modules explicitly).
>
> Now checking the .config that you sent it says:
>
> CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"
>
> So my suspicion is that modprobe is not at that given location?
>
> Regards,
> Arend

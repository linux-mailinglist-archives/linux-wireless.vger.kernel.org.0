Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E76C5750FA
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jul 2022 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiGNOkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jul 2022 10:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiGNOkX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jul 2022 10:40:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C53B3ED42
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 07:40:22 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id l24so1536743ion.13
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPptDn6/bTV5XFfAOC8aiiU0WUtAjgi8jYsv12GLY40=;
        b=A46YfhqHkKqjiqcsyPHMmMWH5qTnuzJ//AuqYAsT4zJoFMzmoEl3rGoKy2ZQ5dw2ER
         fI4sLkMek7gQMkC9a+yy9QSOVXp/su0itbY+ecj/Dr/RWc3dJ2CzKWmDgFmnyRo6f5Rb
         yiEHE622A8duAqPFkeAK+GvW6vRAM8L+q3v9VOhCF/g8YT+L4opvumWvUPTlOK6CLgQU
         njttP/laFu1OF9E1018LhrSTgryJVvzmEL+SkYq3IxLBUMjYHSqmsmruRmG+8mag9AEJ
         lVXG9qKBqPV7XXixobYcSHe47CdsyDvbKXi8VC678dkaoAOUiTIWr1/+aegUUeGtWSjb
         U0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPptDn6/bTV5XFfAOC8aiiU0WUtAjgi8jYsv12GLY40=;
        b=nkLWATr9a0RjhuvcvaK0nSvfz0ploi8yb3+g8UeiqF5fJclQ0y5ULx3w6SWxjLqB65
         6/4BoKTvpYwGrwqDg2SV7mE1nvAKETaite3DLJDEMTZ09bqDMuQnnlktgvwYti/UTlVg
         TGX9Flsfs6YEY6x5+YcuwVTNuge2aRWd6ElCUYtigD80q0Q0PUCa/g1jL4MzqKvJBj3j
         /2JrZS/A/CS3jzYKzmKb13HZAZ0t/PX0nNX4yDQbk4kRQ99iNsu+F9N1124RvPYX+FAr
         1qnEe67rdKbsmeX0olBRfpjaLYweGj/jWQw5aB5JXQmgCleVnD3mMi1E+YaQxbV9hA5B
         3xOw==
X-Gm-Message-State: AJIora9UVItOg5BoqcxxDH6VAW8LO6iuR4DuEiMxzSZA8DjxkA4r8D5K
        tUN0+xs+Xj+qdLGxeGjKOcmaB0mGmXAWie6zCqUtrg==
X-Google-Smtp-Source: AGRyM1sKEKEcNThzqwwYbWWqIiO3M1XAqv9mDVUef8sx7mzl0RggFCo1LE/ciC4A9ZGN1eG4jHS6HZcs76UCgZ3yCkg=
X-Received: by 2002:a5d:890d:0:b0:668:afd6:5477 with SMTP id
 b13-20020a5d890d000000b00668afd65477mr4786729ion.195.1657809621802; Thu, 14
 Jul 2022 07:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
 <CAPDyKFpa6Z0Uhb0OnhMJ-KTQg5CQW93KMz1j1cQJS-Ho8FVhmQ@mail.gmail.com> <fa052de7-31ca-2657-858f-651b97908ba7@gmail.com>
In-Reply-To: <fa052de7-31ca-2657-858f-651b97908ba7@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Jul 2022 16:39:45 +0200
Message-ID: <CAPDyKFoRRxe8wUtJWfuDCxuz8wktUOyMD7jQApYGJO0zbax1Jw@mail.gmail.com>
Subject: Re: [PATCH v5] brcmfmac: prevent double-free on hardware-reset
To:     Arend Van Spriel <aspriel@gmail.com>
Cc:     Danny van Heumen <danny@dannyvanheumen.nl>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 14 Jul 2022 at 14:49, Arend Van Spriel <aspriel@gmail.com> wrote:
>
> On 7/14/2022 12:04 PM, Ulf Hansson wrote:
> > On Tue, 12 Jul 2022 at 01:22, Danny van Heumen <danny@dannyvanheumen.nl> wrote:
> >>
> >> In case of buggy firmware, brcmfmac may perform a hardware reset. If during
> >> reset and subsequent probing an early failure occurs, a memory region is
> >> accidentally double-freed. With hardened memory allocation enabled, this error
> >> will be detected.
> >>
> >> - return early where appropriate to skip unnecessary clean-up.
> >> - set '.freezer' pointer to NULL to prevent double-freeing under possible
> >>    other circumstances and to re-align result under various different
> >>    behaviors of memory allocation freeing.
> >> - correctly claim host on func1 for disabling func2.
> >> - after reset, do not initiate probing immediately, but rely on events.
> >>
> >> Given a firmware crash, function 'brcmf_sdio_bus_reset' is called. It calls
> >> 'brcmf_sdiod_remove', then follows up with 'brcmf_sdiod_probe' to reinitialize
> >> the hardware. If 'brcmf_sdiod_probe' fails to "set F1 blocksize", it exits
> >> early, which includes calling 'brcmf_sdiod_remove'. In both cases
> >> 'brcmf_sdiod_freezer_detach' is called to free allocated '.freezer', which
> >> has not yet been re-allocated the second time.
> >>
> >> Stacktrace of (failing) hardware reset after firmware-crash:
> >>
> >> Code: b9402b82 8b0202c0 eb1a02df 54000041 (d4210000)
> >>   ret_from_fork+0x10/0x20
> >>   kthread+0x154/0x160
> >>   worker_thread+0x188/0x504
> >>   process_one_work+0x1f4/0x490
> >>   brcmf_core_bus_reset+0x34/0x44 [brcmfmac]
> >>   brcmf_sdio_bus_reset+0x68/0xc0 [brcmfmac]
> >>   brcmf_sdiod_probe+0x170/0x21c [brcmfmac]
> >>   brcmf_sdiod_remove+0x48/0xc0 [brcmfmac]
> >>   kfree+0x210/0x220
> >>   __slab_free+0x58/0x40c
> >> Call trace:
> >> x2 : 0000000000000040 x1 : fffffc00002d2b80 x0 : ffff00000b4aee40
> >> x5 : ffff8000013fa728 x4 : 0000000000000001 x3 : ffff00000b4aee00
> >> x8 : ffff800009967ce0 x7 : ffff8000099bfce0 x6 : 00000006f8005d01
> >> x11: ffff8000099bfce0 x10: 00000000fffff000 x9 : ffff8000083401d0
> >> x14: 0000000000000000 x13: 657a69736b636f6c x12: 6220314620746573
> >> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000030
> >> x20: fffffc00002d2ba0 x19: fffffc00002d2b80 x18: 0000000000000000
> >> x23: ffff00000b4aee00 x22: ffff00000b4aee00 x21: 0000000000000001
> >> x26: ffff00000b4aee00 x25: ffff0000f7753705 x24: 000000000001288a
> >> x29: ffff80000a22bbf0 x28: ffff000000401200 x27: 000000008020001a
> >> sp : ffff80000a22bbf0
> >> lr : kfree+0x210/0x220
> >> pc : __slab_free+0x58/0x40c
> >> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >> Workqueue: events brcmf_core_bus_reset [brcmfmac]
> >> Hardware name: Pine64 Pinebook Pro (DT)
> >> CPU: 2 PID: 639 Comm: kworker/2:2 Tainted: G         C        5.16.0-0.bpo.4-arm64 #1  Debian 5.16.12-1~bpo11+1
> >>   nvmem_rockchip_efuse industrialio_triggered_buffer videodev snd_soc_core snd_pcm_dmaengine kfifo_buf snd_pcm io_domain mc industrialio mt>
> >> Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje>
> >> Internal error: Oops - BUG: 0 [#1] SMP
> >> kernel BUG at mm/slub.c:379!
> >>
> >> Signed-off-by: Danny van Heumen <danny@dannyvanheumen.nl>
> >
> > I have to admit that, to me, it looks a bit weird to have one driver
> > instance managing two different SDIO func devices. On the other hand,
> > I don't know the HW so there might be good reasons for why.
> >
> > In any case, I want to point out a commit [1] for the mwifiex driver,
> > which could serve as a good inspiration of how to make use of the
> > mmc_hw_reset(). For example, one may look at the return code from
> > mmc_hw_reset() to understand whether the reset will be done
> > synchronous or asynchronous (via device re-registration).
>
> Thanks, Uffe
>
> Could the API be extended so the caller can request the reset to be
> asynchronous.

Yes, that should be fine. The current behaviour is that it will be
asynchronous if there are more than one SDIO func device bound to a
driver.

Kind regards
Uffe

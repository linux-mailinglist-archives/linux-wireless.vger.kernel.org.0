Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE7558C0C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jun 2022 02:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiFXABn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 20:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiFXABl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 20:01:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C685560F0B;
        Thu, 23 Jun 2022 17:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C30B761F8A;
        Fri, 24 Jun 2022 00:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A004EC3411D;
        Fri, 24 Jun 2022 00:01:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="evmAxucN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656028895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSfgHUzcQlsGz4nLqyf9mmVVM/tnA+NqQ1QWWyq0UzA=;
        b=evmAxucNY9qj5GaRyt50rCvkV9IZGqHq8PIeJAyFhCIKEe2wEJT2FvpWbucb9TrwyZHMda
        pNDVQWsRGWT1OU6GF85PD8hNZFjfaEqF7kMudGEz1mod31t73VFOisel/3L8fO+K/bwCaK
        gs16d0F1YJb4VCrqq4dmDyr7khAnmbs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 68d505a3 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 00:01:34 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id k6so455175ilq.2;
        Thu, 23 Jun 2022 17:01:34 -0700 (PDT)
X-Gm-Message-State: AJIora9phU0VmFMIeFiiukYyBV3AP3bHa/yR0q+MNav575CKpCoC5zge
        xBDNquuTq+/9yLka9RZL2EHG6LbhUMcSTfFvnQI=
X-Google-Smtp-Source: AGRyM1ulf+/NBalRrLsPKIO2U9HiHxp5PNgYXe2/X8RCGU7V1kdhIoZ9mHK2Vaaua/EWf+zToeuwj9GvlxckvN85GmM=
X-Received: by 2002:a92:c26d:0:b0:2d9:1c09:8d0c with SMTP id
 h13-20020a92c26d000000b002d91c098d0cmr6753766ild.42.1656028894088; Thu, 23
 Jun 2022 17:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsFGTEjs0c00giw@mail.gmail.com>
 <YrRZLPQHK0QbLTjr@zx2c4.com> <YrRZoGBMBa3lFkwx@zx2c4.com> <CAO+Okf5JbZ7vUeXWMOZU9Fz=igoVBOZZAiWn7w7SxW5t+dO0Ag@mail.gmail.com>
 <CAHmME9otPsJz5WUq_S2NuJFy0RzjUKEaU=4mZx-dAgfJF8P-yQ@mail.gmail.com>
In-Reply-To: <CAHmME9otPsJz5WUq_S2NuJFy0RzjUKEaU=4mZx-dAgfJF8P-yQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 24 Jun 2022 02:01:22 +0200
X-Gmail-Original-Message-ID: <CAHmME9oAV+YbtfYh+h1OBpjTnJJzyfAujuCC1BSKMwsH8hDx0w@mail.gmail.com>
Message-ID: <CAHmME9oAV+YbtfYh+h1OBpjTnJJzyfAujuCC1BSKMwsH8hDx0w@mail.gmail.com>
Subject: Re: ath9k: hwrng blocks for several minutes when phy is un-associated
To:     Gregory Erwin <gregerwin256@gmail.com>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey again,

On Fri, Jun 24, 2022 at 1:47 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey Gregory,
>
> On Fri, Jun 24, 2022 at 1:36 AM Gregory Erwin <gregerwin256@gmail.com> wrote:
> >
> > No luck.
> >
> > The first patch caused a warning and oops with ath9k_rng_read() at the
> > top of the call stack when reading from /dev/hwrng:
> >   WARNING: CPU: 1 PID: 454 at kernel/kthread.c:75 kthread_should_stop+0x2a/0x30
> >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >
> > The second didn't have a noticeable effect, for better or worse.
>
> Alright. That's actually getting us somewhere. So the path in question
> here is from reading /dev/hwrng, not from the kthread that's doing the
> same read.
>
> Can you do a `cat /dev/hwrng > /dev/null`, and then do whatever it is
> you do that causes everything to hang, and then while things are hung
> in the bad way, look at the contents of /proc/[the pid of the cat you
> just ran]/stack?

There's another flow I'm interested in. You said it prevents the
system from sleeping. Does it also make a `ip link set wlan0 down`
hang too? If so, could you send the `/proc/[pid of ip link set
down]/stack ` of a hung ip process? That seems like the more relevant
deadlock to look into.

Jason

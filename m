Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AE4558BE1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jun 2022 01:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiFWXrz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 19:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiFWXry (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 19:47:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C63314;
        Thu, 23 Jun 2022 16:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69885B8251D;
        Thu, 23 Jun 2022 23:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8176C341C7;
        Thu, 23 Jun 2022 23:47:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F5U9Ufgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656028067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzRYNEve/L7J3c5x1SgnuNfzDWVvderbcOvcfCQAlj0=;
        b=F5U9Ufgsc8Qm981bfzZoC1lBbfXyu6FOWOTWMpN3Ba+RaH/nBnjlFyC8t78KgSNHyvWBRX
        qLPFMa+4Oixjic3CphAzZKscS5rxqvYJyBy7W/mZqB8gQfWaKRxF3s+9H8vdFU4OyHuaKB
        i2x73P7NHFX+j7xUZkP26AuRP4yqBdY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 721ab2a9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 23 Jun 2022 23:47:47 +0000 (UTC)
Received: by mail-io1-f52.google.com with SMTP id m13so1160256ioj.0;
        Thu, 23 Jun 2022 16:47:47 -0700 (PDT)
X-Gm-Message-State: AJIora8AmRgfWI853WSWkLlfXE6bTx642kKzWlxJ1yeStBizZS05Gizy
        hk+rHuYndEz0cn48CRVOH+CBgxRDoDHaMcSYTXU=
X-Google-Smtp-Source: AGRyM1u6M3P4uMDyyqBNntXvswjhmLT4Zh+fKyA8cZbEMjU6lGEn2tABpn/u7Xy7ACzXP2IZfC9vif1lUV4Q2xBwWUY=
X-Received: by 2002:a02:8568:0:b0:339:c51c:867 with SMTP id
 g95-20020a028568000000b00339c51c0867mr6868253jai.170.1656028066438; Thu, 23
 Jun 2022 16:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsFGTEjs0c00giw@mail.gmail.com>
 <YrRZLPQHK0QbLTjr@zx2c4.com> <YrRZoGBMBa3lFkwx@zx2c4.com> <CAO+Okf5JbZ7vUeXWMOZU9Fz=igoVBOZZAiWn7w7SxW5t+dO0Ag@mail.gmail.com>
In-Reply-To: <CAO+Okf5JbZ7vUeXWMOZU9Fz=igoVBOZZAiWn7w7SxW5t+dO0Ag@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 24 Jun 2022 01:47:35 +0200
X-Gmail-Original-Message-ID: <CAHmME9otPsJz5WUq_S2NuJFy0RzjUKEaU=4mZx-dAgfJF8P-yQ@mail.gmail.com>
Message-ID: <CAHmME9otPsJz5WUq_S2NuJFy0RzjUKEaU=4mZx-dAgfJF8P-yQ@mail.gmail.com>
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

Hey Gregory,

On Fri, Jun 24, 2022 at 1:36 AM Gregory Erwin <gregerwin256@gmail.com> wrote:
>
> No luck.
>
> The first patch caused a warning and oops with ath9k_rng_read() at the
> top of the call stack when reading from /dev/hwrng:
>   WARNING: CPU: 1 PID: 454 at kernel/kthread.c:75 kthread_should_stop+0x2a/0x30
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>
> The second didn't have a noticeable effect, for better or worse.

Alright. That's actually getting us somewhere. So the path in question
here is from reading /dev/hwrng, not from the kthread that's doing the
same read.

Can you do a `cat /dev/hwrng > /dev/null`, and then do whatever it is
you do that causes everything to hang, and then while things are hung
in the bad way, look at the contents of /proc/[the pid of the cat you
just ran]/stack?

Jason

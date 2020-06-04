Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77911EEB22
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 21:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFDT3a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgFDT33 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 15:29:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB3C08C5C0
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 12:29:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t7so2626167plr.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2020 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BN0NA5oXxaJmgloA0bV1VuRl7DweslwGb9BXC5tlSZI=;
        b=qNWdjuwtEh3SepeFF9fNagsbBVKMOdC+i2KqVDopsH6dlehq61YjmGsjU3zQ6/6Sm+
         RI59y6nTt3iJaugOaLxusXHriKBWVNJCrzHeENeqAGVpHLkPMQooCck+j2xRNg4QVbq2
         U7Aga0bTxqeYSMNSshjefDdYD9kzqlGJMlmXX3yAeOrKcPi394fVJzn+N+UEYVrgLikW
         PJ80Ob/zePEkwKogqqleJVCwqC4lBAXZfyFsOJ1Q71OHbRbc0fyAs9RyF+VvGzxb6jyN
         PR+j0XjbkYKBjIdoJN78dsQ95HeKy3QSGz7aES9jpi6oH42fz2hvJ1Opql+7AsV4VMb8
         cVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BN0NA5oXxaJmgloA0bV1VuRl7DweslwGb9BXC5tlSZI=;
        b=FZxdwz8E5MKM8Jpw5INzWIPYNC30O5f4+zc3vbFYpMUho9DH2kWyXAiiNje2iQggy9
         ZtVCptw1aQy2mCVC7q4j4egV3v6b3uOMRqeVS+c9Q+/qqZ/0JpEnUm1thRwtbxGFDJk7
         1CKQW7+qSlmzvIVQ3oiXlggMfrKsMrweGexfgkcMzSasBAkwUgM/DIwtZ9RYQJrVMTDl
         3gdyVOhlbD7Uj9ObqTYd3eAm51iJWexq77GiF239DYUfTYc+VULU5CG6z/OBmEOS9e7j
         WAJKhKsdytFGvlLF49r7cPDvmOLiVvw9WYrphiNvOGTyLdUe1HzlRh+CeLSXcGOPmD3X
         BZ8Q==
X-Gm-Message-State: AOAM5314towZUmr9wvpH9u6XdFwiqsYxLmcTvtKCyu2vI3u9nCWyg1ID
        ylFRUofVKZT43d96X+Q53K1H9l5A6snv7coq+WeqJA==
X-Google-Smtp-Source: ABdhPJzSzKsiHc4z7LwcmpkgMu0NbAbDQYhYcnmTB/97B33m/EUjE6lKfBun6ZCLEkmHQ8gJwyD1p9mb5gkpJj8C3R0=
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr6119344pll.223.1591298968901;
 Thu, 04 Jun 2020 12:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200603233203.1695403-1-keescook@chromium.org> <20200603233203.1695403-6-keescook@chromium.org>
In-Reply-To: <20200603233203.1695403-6-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Jun 2020 12:29:17 -0700
Message-ID: <CAKwvOdm5zDide5RuppY_jG=r46=UMdVJBrkBqD5x=dOMTG9cZg@mail.gmail.com>
Subject: Re: [PATCH 05/10] ide: Remove uninitialized_var() usage
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 3, 2020 at 4:32 PM Kees Cook <keescook@chromium.org> wrote:
>
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings (e.g.
> "unused variable"). If the compiler thinks it is uninitialized, either
> simply initialize the variable or make compiler changes. As a precursor
> to removing[2] this[3] macro[4], just remove this variable since it was
> actually unused:
>
> drivers/ide/ide-taskfile.c:232:34: warning: unused variable 'flags' [-Wunused-variable]
>         unsigned long uninitialized_var(flags);
>                                         ^
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Fixes ce1e518190ea ("ide: don't disable interrupts during kmap_atomic()")

> ---
>  drivers/ide/ide-taskfile.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
> index aab6a10435b6..a26f85ab58a9 100644
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
> @@ -229,7 +229,6 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
>         ide_hwif_t *hwif = drive->hwif;
>         struct scatterlist *sg = hwif->sg_table;
>         struct scatterlist *cursg = cmd->cursg;
> -       unsigned long uninitialized_var(flags);
>         struct page *page;
>         unsigned int offset;
>         u8 *buf;
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200603233203.1695403-6-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers

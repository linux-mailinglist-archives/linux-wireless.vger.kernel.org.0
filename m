Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01A0203F4C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgFVSjP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbgFVSjO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 14:39:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B56C061573
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 11:39:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so7939066pls.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 11:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gb+JetmJfxvfJpxHC8m6WwdUvvjtG/PEO/NrvZ7SUq0=;
        b=g47As6pTItcLFTPBKcE7GoqTMDitRniLcUVZb/sgo6Z6hU1SBXf3XA30MossVWhFm+
         WrZs8HM7KrKN7vIEe4hAi7PM9veaLBUBzmO1d6hg/ZrKjGDYlC+J8mnlzIu7m8jCiDVX
         oUMZ6YXzkXP7P/9ND3v2M3GdghI0Eiq5bwNDzgs5cWvWuZbpdd3bSkITbG7/ShPdrwrX
         oq7EH8OJ65SqfDB5bRXrhOWPzVNj9lb6ggrqKdEFfG/SWqJeDT88TfoVD+co4a3hK8cD
         TZxZzP6pibR5VmEHPFJiQguXyVlIy2oApu1xDzwGn7gtMfXUFW3LNOourTReEdtotVmu
         1u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gb+JetmJfxvfJpxHC8m6WwdUvvjtG/PEO/NrvZ7SUq0=;
        b=lNTXboFlUdorhYVJ3mh93Ykxaj5CnXML2gwUgN0W50ZaYvZS9O0DS2987/OPKpcqjp
         XqrlVOtKVRyD7nl1vxx9V1qDVhYj/tBEeLYCHz1bASwpjMHgi4ohxJ4GxmuiDBZKmz7b
         VwJbg8Ry0BCQBsAW/Xni6xOhl6cZxLokgzKeomqa+mGQIESqe0416xSH2K7hkt/rTKPD
         aihcR2DkuTee8FHx7GoLTrpUFyx/C1TJrg498d2ip8k8OyyosbcAfghiX0bAOxz54fbQ
         OyE2sk/JPLVDbNKE8fCkV6o36Y0949sBp5I+IqaXyd+wAKtfqdI1JJ0c4f9U6OsLBljw
         6V4g==
X-Gm-Message-State: AOAM532SZ2cH/maZ524egG/lzn5mkRAxaQi+C2y+25qLzOXxi3sAwUmq
        gmdRKC7O5nUAdzR/YiN4eshH+WI7UuMnVCOgcgKRPw==
X-Google-Smtp-Source: ABdhPJxjYmvT3fQkCRcyhTKfiFZOdTkx+4rML9Oc+LRvsn6ucoVJwJ7PtyGZkVKmwrq2pv/vivr0Qr/enJgVlPaAiao=
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr20457257plm.179.1592851152937;
 Mon, 22 Jun 2020 11:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200620033007.1444705-1-keescook@chromium.org> <20200620033007.1444705-12-keescook@chromium.org>
In-Reply-To: <20200620033007.1444705-12-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jun 2020 11:39:01 -0700
Message-ID: <CAKwvOdm7+8xhbMZRPq0+2X1hez=cNGf=psX7ofNUfqq9iY5ScA@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] media: sur40: Remove uninitialized_var() usage
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
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 19, 2020 at 8:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> Using uninitialized_var() is dangerous as it papers over real bugs[1]
> (or can in the future), and suppresses unrelated compiler warnings (e.g.
> "unused variable"). If the compiler thinks it is uninitialized, either
> simply initialize the variable or make compiler changes. As a precursor
> to removing[2] this[3] macro[4], just remove this variable since it was
> actually unused:
>
> drivers/input/touchscreen/sur40.c:459:6: warning: variable 'packet_id' set but not used [-Wunused-but-set-variable]
>   459 |  u32 packet_id;
>       |      ^~~~~~~~~
>
> However, in keeping with the documentation desires outlined in commit
> 335abaea7a27 ("Input: sur40 - silence unnecessary noisy debug output"),
> comment out the assignment instead of removing it.
>
> [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
>
> Fixes: 335abaea7a27 ("Input: sur40 - silence unnecessary noisy debug output")

Probably should comment out `/* u32 packet_id */` rather than removing
it then, but that doesn't really matter. Either way,
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/input/touchscreen/sur40.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index 34d31c7ec8ba..620cdd7d214a 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -456,8 +456,6 @@ static void sur40_poll(struct input_dev *input)
>  {
>         struct sur40_state *sur40 = input_get_drvdata(input);
>         int result, bulk_read, need_blobs, packet_blobs, i;
> -       u32 uninitialized_var(packet_id);
> -
>         struct sur40_header *header = &sur40->bulk_in_buffer->header;
>         struct sur40_blob *inblob = &sur40->bulk_in_buffer->blobs[0];
>
> @@ -491,7 +489,7 @@ static void sur40_poll(struct input_dev *input)
>                 if (need_blobs == -1) {
>                         need_blobs = le16_to_cpu(header->count);
>                         dev_dbg(sur40->dev, "need %d blobs\n", need_blobs);
> -                       packet_id = le32_to_cpu(header->packet_id);
> +                       /* packet_id = le32_to_cpu(header->packet_id); */
>                 }
>
>                 /*
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200620033007.1444705-12-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers

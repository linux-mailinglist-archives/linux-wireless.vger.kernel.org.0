Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B367B203D53
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 19:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgFVRAH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbgFVRAH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 13:00:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE54C06179A
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 10:00:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h10so8403803pgq.10
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BGCSUQL5tzelRNBUzUtnoDU4FBOgbBEZDAqmf1y2tY=;
        b=qyfkzOIs3IOcHqZGIEiR8JGq0nJVsevXD15ku29SFyXssZXEUC3c86hg9Gv/KJ2BHe
         y3Hp8Hq1zqOS9OOFR3gNNpt0Qv7Nm37wmlte3OKeZWdMeR9NA90wXNwkm6gxb1GWESrg
         FV+TpCchSKop95+zTyCexbHOPt326ZBObp2o6QnHWx5CQujP1LVI+R0x75IanRkYHnnq
         8sIguoxvjbcrJCtaYT0jWDLSWi2vPjWi4gWLpfFDTJyQet65QDVBdYYTPy34m1tTALHH
         MyJ02UqH4YfMYS1tNdV8DEY2h1OHgS9vwRBU8tnsCUN5ZqCoUAJ9paYX1bhDXSLYsgvR
         L24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BGCSUQL5tzelRNBUzUtnoDU4FBOgbBEZDAqmf1y2tY=;
        b=pSfWyGyD3TLugIFvBiBMtbyHG2qVPUIiA1FNTj+KqEMTQDFvdp4zIOxq06M3p9kIW4
         y58sHM2viCrmX+eJ1zfdnu8zl8uxSmWxbprX3o5bH7w1Mha0/bfEOOGnSezJ6xOWNDDr
         b8AEQ8fX4df/g12QUIbP2OMTKhDJy3YYH8JfWdq9qjS+MHBBUkvhvVQ5XnojwicMtXmj
         KMNiLia8VpYzfMczSnul9KaDWJ6g/970Zp51dzI5jpn9nlkrKPvGXD7C5g5aFGiWVGM6
         Afl6wYXty68pD7tcGxcUO4iyNKp4nXfb2xyJSMIv8n4avysLPNB/EYioldG89/kxmQ3u
         5kqg==
X-Gm-Message-State: AOAM533VDyZ0LxXmBUCWvO4NnBj3yqET5ByyYWGgGs56yJXwhhl5KrPD
        LaxvBzf4QMPwbcb9+PusTAf+WK/fl6SF/A5zOmatbg==
X-Google-Smtp-Source: ABdhPJzRctk7sbdkIMQOmqVpecK2ZcMwEAt3JEckAnE+NdDNoij2Ixhlu/aU/MySqDydTtISB1suO3tr/npvXJ5DjBc=
X-Received: by 2002:aa7:9abc:: with SMTP id x28mr21131306pfi.39.1592845205633;
 Mon, 22 Jun 2020 10:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200620033007.1444705-1-keescook@chromium.org> <20200620033007.1444705-2-keescook@chromium.org>
In-Reply-To: <20200620033007.1444705-2-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jun 2020 09:59:54 -0700
Message-ID: <CAKwvOd=a+aSb5Scg=jD-jDfvnKJjOCVQ8CidgEo-39g2b2z-3A@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] docs: deprecated.rst: Add uninitialized_var()
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
> Nothing should be using this macro, and the entire idea of tricking the
> compiler into silencing such warnings is a mistake.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Documentation/process/deprecated.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 652e2aa02a66..943a926ecbbb 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -51,6 +51,24 @@ to make sure their systems do not continue running in the face of
>  "unreachable" conditions. (For example, see commits like `this one
>  <https://git.kernel.org/linus/d4689846881d160a4d12a514e991a740bcb5d65a>`_.)
>
> +uninitialized_var()
> +-------------------
> +For any compiler warnings about uninitialized variables, just add
> +an initializer. Using the uninitialized_var() macro (or similar
> +warning-silencing tricks) is dangerous as it papers over `real bugs
> +<https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/>`_
> +(or can in the future), and suppresses unrelated compiler warnings
> +(e.g. "unused variable"). If the compiler thinks it is uninitialized,
> +either simply initialize the variable or make compiler changes. Keep in
> +mind that in most cases, if an initialization is obviously redundant,
> +the compiler's dead-store elimination pass will make sure there are no
> +needless variable writes.
> +
> +As Linus has said, this macro
> +`must <https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/>`_
> +`be <https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/>`_
> +`removed <https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/>`_.
> +
>  open-coded arithmetic in allocator arguments
>  --------------------------------------------
>  Dynamic size calculations (especially multiplication) should not be
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200620033007.1444705-2-keescook%40chromium.org.



-- 
Thanks,
~Nick Desaulniers

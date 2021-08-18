Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E445F3F08F6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 18:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhHRQWJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 12:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhHRQWG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 12:22:06 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D8C0613CF
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 09:21:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y23so2774359pgi.7
        for <linux-wireless@vger.kernel.org>; Wed, 18 Aug 2021 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OH0HDKV+n0nyhzkCexO3gFPelNIO9Yru8xPdeMKzgNE=;
        b=goFTNk2pOD39Gup5sODHofjJbZ0OzQuKLSJ5szOEafXDzHz5Z0wBqdtJClNs/rE/tW
         7PwbLmjnxHXjbhh0BzN3LG9dJqur3Mqs90yPp/cr//BR623UGy0jJs6TaanH9hFZouYo
         ucc1EoD4M9EZXQgtNDGs+me/sXAkgiKlFyKrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OH0HDKV+n0nyhzkCexO3gFPelNIO9Yru8xPdeMKzgNE=;
        b=rb+PFAesCVsvQOCQdQ5gZedd48dtsX7jfbjXfyE6K0cJD1afqHAJ8Sq+izUj5TmcZa
         u+gN4xWO4OVXkFlznXIwLVQp3a3lbo2Ml49C1MxpFpGhkx7Kr8weGt5VtwGO7nMceoG3
         Ak9M6CxwhQJ9Dd+8H7gKCOi7oyyWMHkr5K4Cgvdvx3zM2JdKOPwvicsAXCWPuXm9RoiD
         yDG28NcEzSVxaCo4+Ao9kbPCxN4yuE3mymFfth5k0dqzYpAPMuigTkV8dqxANgYslJbX
         0+nX8U8uGJINhaxgZ9aCjcUPDBHzW587p2GWD474dnJSDcf3om9qoeUE0f9p33kE5vET
         rtDQ==
X-Gm-Message-State: AOAM531HFTjFY90PYbvQrR+knncCDHIqWVQHmPpCo8TNS2kqV6pUmS9C
        R7/8jURJVuAsV194Ihr8eXsKNA==
X-Google-Smtp-Source: ABdhPJysjR7p2Aks52eVXwNTLErN8CgrnMCpOcHbZLHJn8/HoaaFASj8USZBM3cqcWkjecc88CSxDQ==
X-Received: by 2002:a05:6a00:10cf:b0:3e2:139b:6d6c with SMTP id d15-20020a056a0010cf00b003e2139b6d6cmr10295546pfu.3.1629303691009;
        Wed, 18 Aug 2021 09:21:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q29sm220062pfl.142.2021.08.18.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:21:30 -0700 (PDT)
Date:   Wed, 18 Aug 2021 09:21:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 50/63] tracing: Use memset_startat() to zero struct
 trace_iterator
Message-ID: <202108180918.E239CE0@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-51-keescook@chromium.org>
 <20210818093349.3144276b@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818093349.3144276b@oasis.local.home>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 18, 2021 at 09:33:49AM -0400, Steven Rostedt wrote:
> On Tue, 17 Aug 2021 23:05:20 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memset(), avoid intentionally writing across
> > neighboring fields.
> > 
> > Use memset_startat() to avoid confusing memset() about writing beyond
> > the target struct member.
> > 
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  kernel/trace/trace.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 13587e771567..9ff8c31975cd 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6691,9 +6691,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
> >  		cnt = PAGE_SIZE - 1;
> >  
> >  	/* reset all but tr, trace, and overruns */
> > -	memset(&iter->seq, 0,
> > -	       sizeof(struct trace_iterator) -
> > -	       offsetof(struct trace_iterator, seq));
> > +	memset_startat(iter, 0, seq);
> 
> I can't find memset_startat() in mainline nor linux-next. I don't see it
> in this thread either, but since this has 63 patches, I could have
> easily missed it.

Sorry, it isn't called out in the Subject, but it's part of this patch:
https://lore.kernel.org/lkml/20210818060533.3569517-38-keescook@chromium.org/

> This change really should belong to a patch set that just introduces
> memset_startat() (and perhaps memset_after()) and then updates all the
> places that should use it. That way I can give it a proper review. In
> other words, you should break this patch set up into smaller, more
> digestible portions for the reviewers.

I will split memset_after() and memset_startat() introduction patches. I
already split up each use into individual cases, so that those changes
could be checked one step at a time for differences in pahole struct
layout and object code.

Thanks for taking a look!

-Kees

-- 
Kees Cook

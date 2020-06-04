Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E9A1EDB56
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 04:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgFDCo7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 22:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgFDCo5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 22:44:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3E8C08C5C2
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 19:44:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n9so1552571plk.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2020 19:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NJuDdLVQU9WLVc7Nj2WL3ekqw3GERe/Y3vOpHmHCX0Q=;
        b=OAFQ8jI87ZswNf70zyd8MKAqfVTIv4fRHLBkUjQMzBpQKKSwhTPoeh+eTEftSsoQ3Z
         HAfupEeEgEm2Pz8TJLNYEZLBTGUokCA2YuqCmi90nZNcwF3edAJEhQH1SzU247DcPAha
         17bHofqx0OK4rg5aVzrI04rDxImgVclAv6egg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJuDdLVQU9WLVc7Nj2WL3ekqw3GERe/Y3vOpHmHCX0Q=;
        b=sfQEMytaC2aAXgQ1mN8kAa8f1Csnh0nB2o5kMG3gop5WFhQ53c2Pxo6TUkrmvGFaWd
         armN0Yp7/+06ubl5WNAvxxkk9gEtpQRXbVUByiIIAMyBCihq8aRX+pCrxe8QP6muJHbs
         mKzQiIWCAHzOd0pynbgirVa10Ivyo0c1fOmDzzh0T4d7n7LzGGBP6U911nguCg4G6NeV
         CtQFS/+HTuGZuM8sj+Th4FkAmYZY/+97HUSeVrQnjRfjLOUCKx5sr+KmFZ55mVbS1R9H
         Qr8/oHZMp1UehTccHPklSZw5bQW6Drf7lMF0M9WcSR+cSNtvss0JMn9zAZQ+e8r6z5To
         YCww==
X-Gm-Message-State: AOAM531klZMOvR4fFTJHrDmp0SF8jemEip6/4yW6wD2L6tBP2JDltdst
        Sx0MKMtM3+qsGHVfMR8NEWgp9A==
X-Google-Smtp-Source: ABdhPJySxWma3GbjobWM5fu0OzUyfUL6/aSJ2YRQ1+d5LPdQ7FnjaDErNGW25ctBsWEbTRZ3ftZi5w==
X-Received: by 2002:a17:902:848a:: with SMTP id c10mr2705871plo.124.1591238695641;
        Wed, 03 Jun 2020 19:44:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm2934984pfr.106.2020.06.03.19.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 19:44:54 -0700 (PDT)
Date:   Wed, 3 Jun 2020 19:44:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 08/10] checkpatch: Remove awareness of
 uninitialized_var() macro
Message-ID: <202006031944.9551FAA68E@keescook>
References: <20200603233203.1695403-1-keescook@chromium.org>
 <20200603233203.1695403-9-keescook@chromium.org>
 <ff9087b0571e1fc499bd8a4c9fd99bfc0357f245.camel@perches.com>
 <202006031838.55722640DC@keescook>
 <6f921002478544217903ee4bfbe3c400e169687f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f921002478544217903ee4bfbe3c400e169687f.camel@perches.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 03, 2020 at 06:47:13PM -0700, Joe Perches wrote:
> On Wed, 2020-06-03 at 18:40 -0700, Kees Cook wrote:
> > On Wed, Jun 03, 2020 at 05:02:29PM -0700, Joe Perches wrote:
> > > On Wed, 2020-06-03 at 16:32 -0700, Kees Cook wrote:
> > > > Using uninitialized_var() is dangerous as it papers over real bugs[1]
> > > > (or can in the future), and suppresses unrelated compiler warnings
> > > > (e.g. "unused variable"). If the compiler thinks it is uninitialized,
> > > > either simply initialize the variable or make compiler changes.
> > > > 
> > > > In preparation for removing[2] the[3] macro[4], effectively revert
> > > > commit 16b7f3c89907 ("checkpatch: avoid warning about uninitialized_var()")
> > > > and remove all remaining mentions of uninitialized_var().
> > > > 
> > > > [1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
> > > > [2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
> > > > [3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
> > > > [4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/
> > > 
> > > nack.  see below.
> > > 
> > > I'd prefer a simple revert, but it shouldn't
> > > be done here.
> > 
> > What do you mean? (I can't understand this and "fine by me" below?)
> 
> I did write "other than that"...
> 
> I mean that the original commit fixed 2 issues,
> one with the uninitialized_var addition, and
> another with the missing void function declaration.
> 
> I think I found the missing void function bit because
> the uninitialized_var use looked like a function so I
> fixed both things at the same time.
> 
> If you change it, please just remove the bit that
> checks for uninitialized_var.

Ah! Gotcha. Thanks; I will update it.

-Kees

> 
> Thanks, Joe
> 
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > []
> > > > @@ -4075,7 +4074,7 @@ sub process {
> > > >  		}
> > > >  
> > > >  # check for function declarations without arguments like "int foo()"
> > > > -		if ($line =~ /(\b$Type\s*$Ident)\s*\(\s*\)/) {
> > > > +		if ($line =~ /(\b$Type\s+$Ident)\s*\(\s*\)/) {
> > > 
> > > This isn't right because $Type includes a possible trailing *
> > > where there isn't a space between $Type and $Ident
> > 
> > Ah, hm, that was changed in the mentioned commit:
> > 
> > -               if ($line =~ /(\b$Type\s+$Ident)\s*\(\s*\)/) {
> > +               if ($line =~ /(\b$Type\s*$Ident)\s*\(\s*\)/) {
> > 
> > > e.g.:	int *bar(void);
> > > 
> > > Other than that, fine by me...
> > 
> > Thanks for looking it over! I'll adjust it however you'd like. :)
> > 
> 

-- 
Kees Cook

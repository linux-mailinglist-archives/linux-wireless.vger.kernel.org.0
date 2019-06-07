Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28731393F6
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 20:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfFGSIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 14:08:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40124 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbfFGSIb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 14:08:31 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so3064031itc.5
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46o9teIFxXJpHSlK03ACr5jm/nmZOQ89XNQuLWL2Vrg=;
        b=QRPhxxFl/jBQO+euDBoQtl/Xax6LX6l+MU+t1ur7MtZ2YdwcSLwnK6UWEMMaOwDGWI
         v2DJ6KmFZ8GIc/5euHuNA4I8LCdxNgyoqeUlwwilLD+Uhwm/hyw1kduJ31vDDOcwpyJp
         QzzP8zvuP3NEGcnQKH0IJoYr5qNtfYKW2EliaoL3cT3q5yEffUVpfVA0Qw2ZbqqWYz6W
         rU+34uxpWQEhN3MQAUnCeYJM3gilA2ukFyTHAFsDXIY8uQtcuLLSevFrvADLfJXU1CM4
         oQZLagv+IVKXb0E1m3ackRp652W20dKe5lTBNtK50+hlVSTVrAATLsJdyxIQx10gK7PK
         iYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46o9teIFxXJpHSlK03ACr5jm/nmZOQ89XNQuLWL2Vrg=;
        b=nOALACXlPnz582Vl1tNe/IuHnYdtKk+cHLLJtb+15mVW+uXACw9sgye8NoOvM8JUMX
         fZLEUO+HHmAxVc90J8JrF9h2pDNFJNJj+zeHdnc65hbNfxw7LLOVDord/1tfXUFarpmq
         a+Kchh/MTwdv7pfamqO/qWbwNU/PYgKTtXCOuPANixtPEs0xWK2mufUSNCLbcWVu+hzp
         Vyx24Cm29TNQ7ZCUpN/R2QCG+Xj1SYSs0XT/BJqOgUDxE4brDZdLnerPh9vkBZX70ic9
         beUwOMdoutv/xQ0Ivz6I50gKcwfsdNS05DaVrhtpUZ/7apgDkaqCt4OONMWWzPh2oLKU
         +HyQ==
X-Gm-Message-State: APjAAAXyizCRf/+ZjYaeGi5+v7pRU5CC9VhI+u1qijdUvnaH9q4m2ong
        Tgw27QsvUkVrXGh4eOE2Rjt3uv1f+uwCtsVgwnmnRg==
X-Google-Smtp-Source: APXvYqyGDQ7+7lEeLzdqkbK5JHWSdDYqWifx2GOAq3qlgz2X+dhLHn7pkPpyBEg1jVQd3r3RuXy38Oq/b40LVXjutQQ=
X-Received: by 2002:a24:4f88:: with SMTP id c130mr4847181itb.104.1559930910878;
 Fri, 07 Jun 2019 11:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org> <20190607175947.GB648@sol.localdomain>
In-Reply-To: <20190607175947.GB648@sol.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Jun 2019 20:08:19 +0200
Message-ID: <CAKv+Gu-uV4EELw+wYsHQ88YP05ScrYWgf02Qym+fDjrwPtGh9A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] move WEP implementation to skcipher interface
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Berg <johannes@sipsolutions.net>,
        "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 7 Jun 2019 at 19:59, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Jun 07, 2019 at 04:49:41PM +0200, Ard Biesheuvel wrote:
> > One of the issues that I would like to see addressed in the crypto API
> > is they way the cipher abstraction is used. In general, a cipher should
> > never be used directly, and so it would be much better to clean up the
> > existing uses of ciphers outside of the crypto subsystem itself, so that
> > we can make the cipher abstraction part of the internal API, only to
> > be used by templates or crypto drivers that require them as a callback.
> >
> > As a first step, this series moves all users of the 'arc4' cipher to
> > the ecb(arc4) skcipher, which happens to be implemented by the same
> > driver, and is already a stream cipher, given that ARC4_BLOCK_SIZE
> > actually evaluates to 1.
> >
> > Next step would be to switch the users of the 'des' and 'aes' ciphers
> > to other interfaces that are more appropriate, either ecb(...) or a
> > library interface, which may be more appropriate in some cases. In any
> > case, the end result should be that ciphers are no longer used outside
> > of crypto/ and drivers/crypto/
> >
> > This series is presented as an RFC, since I am mostly interested in
> > discussing the above, but I prefer to do so in the context of actual
> > patches rather than an abstract discussion.
> >
> > Ard Biesheuvel (3):
> >   net/mac80211: switch to skcipher interface for arc4
> >   lib80211/tkip: switch to skcipher interface for arc4
> >   lib80211/wep: switch to skcipher interface for arc4
> >
>
> The way the crypto API exposes ARC4 is definitely broken.  It treats it as a
> block cipher (with a block size of 1 byte...), when it's actually a stream
> cipher.  Also, it violates the API by modifying the key during each encryption.
>
> Since ARC4 is fast in software and is "legacy" crypto that people shouldn't be
> using, and the users call it on virtual addresses, perhaps we should instead
> remove it from the crypto API and provide a library function arc4_crypt()?  We'd
> lose support for ARC4 in three hardware drivers, but are there real users who
> really are using ARC4 and need those to get acceptable performance?  Note that
> they aren't being used in the cases where the 'cipher' API is currently being
> used, so it would only be the current 'skcipher' users that might matter.
>

In fact, this is what I started out doing, i.e., factor out the core
arc4 code into crypto/arc4_lib.c, and make the existing driver a thin
wrapper around it, so that we can invoke the library directly.

> Someone could theoretically be using "ecb(arc4)" via AF_ALG or dm-crypt, but it
> seems unlikely...
>

Yes, that seems highly unlikely.

> As for removing the "cipher" API entirely, we'd have to consider how to convert
> all the current users, not just ARC4, so that would be a somewhat different
> discussion.  How do you propose to handle dm-crypt and fscrypt which use the
> cipher API to do ESSIV?
>

Without having looked in too much detail, ESSIV seems like something
that could be moved into the crypto subsystem, and be implemented as a
template.

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E837D47D25
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 10:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFQIc1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 04:32:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36855 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfFQIc1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 04:32:27 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so19415644ioh.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2019 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/UVFvSTOnQx2MdEwCsdbLMftAMFG5W38DFDRZnlaqE=;
        b=SUP0HB8CO812sk5oBxHZBrx0VmZ/7Tn8LPjsNe48JSOup+I9iNPzIepwpMxWQwOr8O
         KCDs4lKIm1EfJGd/e7NiKdRBd40qx2t0L8zAXk8Axh8jMohrGjO/7WmH0DyZbrv3yPcg
         ukGi6X2f6pJES1kiGjYUkc5VUfC8KxWn1Uh+eO9mWdXHT8KMx7OZKGZsl0ee0gWlMoxH
         xWLXjbPrRS55FFj7io0SM+hkIMfcctPC6L8oozNOzt/Hl/kZ7S9ZHAN4UXChXsyRexoL
         +2UA84C2ri0PpIj3SPhQkDxO9i0TOl4Q6HbwDq6pbMhMZNVJkuf3rntsQsYYRiDZklN2
         2hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/UVFvSTOnQx2MdEwCsdbLMftAMFG5W38DFDRZnlaqE=;
        b=uPa5+ue/XCiA5eP8iQwg9B3TBPdNN5AXJe6+SzZpYeHNakDBgazRRDn9Il30QttQjO
         wnaidDzPUZDH1rGm78KGukg6NNOpNncYDKyYrOVgwA/8F/rkcdlOcL2nlLN6V1NNVyOv
         9cvqOEY9i2K2o7vq94CtCwmwzFxfr2IrdEjjsuXJu7xcO5BTdIrk/7fIM7CZCWuA8oa2
         SSp5rU6iIOJs0nJfp/zXn7ni3Q/rRqcRb/u7EraSD8NUdLFnbLqcc5SBWQ2HX3hu9iKp
         x5p3pCw+zItx4JqIch6GsWV6eqHTI47bCQ36JVzBrdaFeX5cI47HuKEoDD0abhfvKwEb
         7d8w==
X-Gm-Message-State: APjAAAW/Bl2fPBW2IYIcSwlfJ7AjMEjFLnXYuVSoGz0aJKS5QsSP3e8N
        9m0jFw+zqnjt0vpalPHrr/7RHvdyF4On6xC7PNV2UMpJxBo=
X-Google-Smtp-Source: APXvYqyCvSdGF/kKkdQvExm0EaKRVOaiq6eSYb+tcdvLqnTy4SD4UKTQokJrBkDaNyi2JnJNn/7Nxkqwv5SAu6szY4k=
X-Received: by 2002:a5e:820a:: with SMTP id l10mr15338296iom.283.1560760346379;
 Mon, 17 Jun 2019 01:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190614093603.22771-1-ard.biesheuvel@linaro.org>
 <20190616071206.GB698@sol.localdomain> <CAKv+Gu97xkz5qxycyjqmukFhWAD6p=eYbTqoPWt-ZNbBFDbNAw@mail.gmail.com>
 <20190616194322.GC923@sol.localdomain>
In-Reply-To: <20190616194322.GC923@sol.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Jun 2019 10:32:14 +0200
Message-ID: <CAKv+Gu8qgDgONkt0_2vpu3FacPbbFFMc=4tPrtnxqXt9gNexOw@mail.gmail.com>
Subject: Re: [PATCH] wireless: airo: switch to skcipher interface
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux@rainbow-software.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 16 Jun 2019 at 21:43, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sun, Jun 16, 2019 at 09:03:58PM +0200, Ard Biesheuvel wrote:
> > >
> > > Otherwise this patch looks correct to me.
> > >
> > > The actual crypto in this driver, on the other hand, looks very outdated and
> > > broken.  Apparently it's implementing some Cisco proprietary extension to WEP
> > > that uses a universal hashing based MAC, where the hash key is generated from
> > > AES-CTR.  But the MAC is only 32 bits, and the universal hash (MMH) is
> > > implemented incorrectly: there's an off-by-one error in emmh32_final() in the
> > > code that is supposed to be an optimized version of 'sum % ((1ULL << 32) + 15)'.
> > >
> >
> > I stared at that code for a bit, and I don't see the problem.
> >
>
> I'm fairly certain that the line:
>
>         if (utmp > 0x10000000fLL)
>
> is supposed to be:
>
>         if (utmp >= 0x10000000fLL)
>

Ah yes, I see what you mean. 0x10000000f % 0x10000000f == 0 not 15
(after truncation). So yes, that is definitely a bug.

> Since it's doing mod 0x10000000f.  It's supposed to be an optimized
> implementation of 'val = (u32)(context->accum % 0x10000000f)' where 0x10000000f
> is the prime number 2^32 + 15.  It's meant to be the MMH algorithm: Section 3.2
> of https://link.springer.com/content/pdf/10.1007/BFb0052345.pdf.  But there are
> values of 'accum' where it gives the wrong result, e.g. 14137323879880455377.
>
> Possibly this is a bug in the Cisco MIC protocol itself so can't be fixed.
>

Highly unlikely. But also highly irrelevant :-)

> > > Do we know whether anyone is actually using this, or is this just another old
> > > driver that's sitting around unused?
> > >
> >
> > Excellent question. I take it this is pre-802.11b hardware, and so
> > even the OpenWRT people are unlikely to still be using this.
>

I'd be fine with dropping this driver. I am just trying to get rid of
(ab)use of the crypto cipher interface, so either we change it or we
drop it.

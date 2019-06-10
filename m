Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E463B38E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbfFJK6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 06:58:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39887 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388504AbfFJK6S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 06:58:18 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so6496869iod.6
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2019 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/b3tFGEWgoEdACLdg7bokuFxZeG6ioFu7pHbHubtFI=;
        b=ZxLTd3tK5rGZM6S/oPVuEsCRQRG6sqjjVvC72/00peTjqUw43MsXlIruiVrqQ/lu9e
         9vFdvWqlAZxyAWnU40mxayVAsSHBXA39zzKfoydpGIYpF0Fps6tDAkh1A9akJIkB+MAx
         NQFEvdBSkA+5ff55xrX5PHjx58LEnIlhXtA4CY0I9Frq1eEXBlWa72loYV9l4hdO4QFb
         jO4Q3hIZFPegygoQNy7dbaNTNCXscGAZy4pXv9AnlPuAcGG4McsSqj9RV9C2IORKWTN+
         1dY4w9VWso8rMkQe6+BwexeSH6S2t/6yrHxo2AnkzguU6NxuqNHR4qhu7FkwCCy7ZQ7r
         iHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/b3tFGEWgoEdACLdg7bokuFxZeG6ioFu7pHbHubtFI=;
        b=mYmsHhLnl0FDaU7f/Q1RIdOG4eD+dhvg11f3vJvnAmt4DiJF6pH/P7Wj/0UqBrEG92
         0DmG78QuzQ4rKbC5Zdt711v8m0ZxbASrozFJpNAygdUy8IcdmmUG2muHdpmYFIL29UTG
         vB60rCtbUOBrEouV0Il1R4B8+Lw7YISsWdEIF+Uw0Ax3l574kpzh5RApweQwF9ed2RvB
         kQBlGdaGtFpvyC80N7jg5u/y/F33gWkTcghIxZK/NksMue4l3Xeuv3YHmzijspJ9BFJh
         SKvvj6TnSrsDVmjUVQ8DWY+nkFrPEPulRpxVQVmjv3/j1wDpk78HNwlaVP4Q7Fnpqni+
         PrfQ==
X-Gm-Message-State: APjAAAUi4icTfyJ/fY7G9OCkh5cfrw7yGXpjPbaTMROjqfcWyPAile6Q
        pqO9xxZt8XXsMzqw9rk9Y2jjD5BPI2Ea7ly1TpggxQ==
X-Google-Smtp-Source: APXvYqwcRurlC0KKJ62r5ApibARM+qdQ7meWrwXkgJri6K8WHRmL/lsqRVwhESAZpZPNromQfB+E0wEWUv/kHehTPBI=
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr9343513iob.49.1560164297208;
 Mon, 10 Jun 2019 03:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190609115509.26260-1-ard.biesheuvel@linaro.org>
 <20190609115509.26260-3-ard.biesheuvel@linaro.org> <107dc7707e6c9d0110aa5535bd5baf4f6db7f6a5.camel@sipsolutions.net>
In-Reply-To: <107dc7707e6c9d0110aa5535bd5baf4f6db7f6a5.camel@sipsolutions.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 10 Jun 2019 12:58:04 +0200
Message-ID: <CAKv+Gu9jknEqPN15pKW7PGDww_xcoF0o5piUi0SJphw2e_QwTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] net/mac80211: move WEP handling to ARC4 library interface
To:     Johannes Berg <johannes@sipsolutions.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
        "John W. Linville" <linville@tuxdriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 9 Jun 2019 at 22:09, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi Ard,
>
> In general, I have no objections to this.
>
> However, with this
>
> > -     select CRYPTO_ARC4
> > +     select CRYPTO_LIB_ARC4
>
> and this
>
> >       case WLAN_CIPHER_SUITE_WEP40:
> >       case WLAN_CIPHER_SUITE_TKIP:
> >       case WLAN_CIPHER_SUITE_WEP104:
> > -             if (IS_ERR(local->wep_tx_tfm))
> > -                     return -EINVAL;
> > -             break;
>
> there's one quirk that I worry about. Does this mean WEP is now *always*
> available/enabled?
>
> I had to dig in history a bit, but vaguely remembered this commit:
>
> commit 3473187d2459a078e00e5fac8aafc30af69c57fa
> Author: John W. Linville <linville@tuxdriver.com>
> Date:   Wed Jul 7 15:07:49 2010 -0400
>
>     mac80211: remove wep dependency
>
>
> Since you create the new CRYPTO_LIB_ARC4 in patch 1, I wonder if
> something is broken? I can't really seem to figure out how WEP is
> disallowed in FIPS mode to start with though.
>
>
> (This also is the reason for all the code that removes WEP/TKIP from the
> list of permitted cipher suites when ARC4 isn't available...)
>

Good point. And in the future, there may be other reasons besides FIPS
compliance to turn off WEP support, so it makes sense to retain this
logic.

I am still curious whether FIPS compliance actually requires us to do
this, or whether that code is simply there to work around the lack of
RC4 in the crypto API when FIPS support happens to be enabled.

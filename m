Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984BE3A04A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfFHOiH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jun 2019 10:38:07 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37403 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfFHOiG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jun 2019 10:38:06 -0400
Received: by mail-it1-f193.google.com with SMTP id x22so7129944itl.2
        for <linux-wireless@vger.kernel.org>; Sat, 08 Jun 2019 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgw+zu8aNI0Oyo6Bp/cLRgyzSPa8eGz7V1sMOc8tj+k=;
        b=F7/OUvUHTcLWxWCR1j4jQjwCkKp/2/tWkrKSj0HGad6wZJburRqlSh/BKv4M0OiIT7
         e0hIfqswC6TgNv3ItqfMn8Checkl99pHAoJzDkJXVoCXPOYnz+pFBtADYohN2UyUHtOy
         9Vwlj33nMiYVtezxJmhvDFqUdCWqaHWBjzpCZ+EZYfPo6IJo4Q+geUdwciQ9bYFJ/FUE
         fFy6Kq18LCEqKUsj/7LIhygkdfDRRC3VNeY/nWOJ9SA0zKauijnErpTJAGYGxoW9Sv5E
         dDhqSWm550P1MFg1mhviIjg5gr07jQiLTktPO3pNiF9QdtH2rt3WBX33/amlXLy41OBY
         EThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgw+zu8aNI0Oyo6Bp/cLRgyzSPa8eGz7V1sMOc8tj+k=;
        b=FaIigZGzUGzQZJgEZvYGqeqYiRR0nKHoRoA9cuHvCZjikKqKkWmqfBxDBaBUNFELcr
         /DtM8aTw5k6pr9b5K5ze4SwoQCi4pLbd2Gs7QeuENos0llI6CXfbA3z2riE/qOvnFYSH
         oUyS7nfKU9LDW/h6j8vRghNh3lO7+p7lMGWSYn6i1C5zMgeFGWNUl0rIxmsa5XyojoAs
         9QoeYWIfLOo/AXN0edpGloIdH9RIrpm3SGQe5crNSW8Ijd03NKX9S598Ys5TQRj3SpZm
         X/KdnfxVfF5WnymRSSEB2S9Jd19osFxCSgeyIR0jVYUCWSdtckYs1m/kY2NEuTLi3Roz
         307A==
X-Gm-Message-State: APjAAAWhafrZVD+S8+vXwaaDR9XWvEs7nog4WZ4AwIoWtGaZVfzAPybx
        gndPLJSo9Da6lKEPFq9kZSiefkEwCZbSL0J4PdWDzg==
X-Google-Smtp-Source: APXvYqz0mzPyv+CLrzzohQpGBRJSeZ7CmvErRXn3C9uT3eznykeKngX3NgKATgmHI3Mq1O89gbTtZDXT6sNSdm+DbSk=
X-Received: by 2002:a02:c90d:: with SMTP id t13mr18937313jao.62.1560004685155;
 Sat, 08 Jun 2019 07:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
 <20190607175947.GB648@sol.localdomain> <97BB95F6-4A4C-4984-9EAB-6069E19B4A4F@holtmann.org>
 <CAKv+Gu-ek4nK+cACx5QZTbp=ciQq_Fvtn9y3g-wFWSOabyczZg@mail.gmail.com>
 <f40ad169-93b9-636f-9656-634ff331ee2b@gmail.com> <20190607211514.GD648@sol.localdomain>
 <d394b421-799d-2019-fcf0-97ba0b2abb5f@gmail.com> <20190607214120.GE648@sol.localdomain>
 <78298612-a36b-deaa-1510-94cf0001af9d@gmail.com> <20190607224040.GG648@sol.localdomain>
 <61e1cd8a-4891-4e37-417e-1c31cd95a278@gmail.com> <CACXcFm=2_1S75G7NWRCQjBS6gi+vDZFROzg6Ntjh-fAcPfYhyQ@mail.gmail.com>
In-Reply-To: <CACXcFm=2_1S75G7NWRCQjBS6gi+vDZFROzg6Ntjh-fAcPfYhyQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 8 Jun 2019 16:37:53 +0200
Message-ID: <CAKv+Gu8Ex63n-YV7aaQEz7VBZ137vi113jv5NCPjbxP8=9Q=qQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] move WEP implementation to skcipher interface
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     Denis Kenzior <denkenz@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:NFC SUBSYSTEM" <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 8 Jun 2019 at 15:03, Sandy Harris <sandyinchina@gmail.com> wrote:
>
> First off, it is not clear we should implement WEP at all since it is
> fatally flawed. This has been known for about a decade, there have
> been at least two better algorithms added to the standards, & the only
> reason anyone would need WEP today would be to connect to an old
> router in an obviously insecure way.
> https://www.schneier.com/blog/archives/2007/04/breaking_wep_in.html
> https://www.tomshardware.com/reviews/wireless-security-hack,2981-4.html
>
> Twenty years ago the FreeS/WAN project implemented IPsec for Linux &
> deliberately did not include things like single DES which were known
> to be insecure:
> https://www.freeswan.org/freeswan_trees/freeswan-1.99/doc/compat.html#dropped
> I think a similar policy was would be a fine idea for the kernel today
> & WEP is hopelessly insecure.
>

It is actually pretty clear that we should implement WEP, simply
because we already do. We all know how broken it is, but that does not
mean we should be the ones policing its use. People may have good
reasons to stick with WEP in their particular use case, or maybe they
have bad reasons, but the bottom line is that it does not really
matter: if it works today, we can't just remove it.

What we can do is make the existing code less of an eyesore than it
already is, and in the context of what I want to achieve for the
crypto API, this involves moving it from the cipher API to something
else.

> > > As I am attempting to explain, ecb(arc4) does not implement this API correctly
> > > because it updates the *key* after each operation, not the IV.  I doubt this is
> > > documented anywhere, but this can only be changed if people aren't relying on it
> > > already.
>
> It is more the case that the API does not apply to arc4, or more
> generally to stream ciphers, than that "ecb(arc4) does not implement
> this API correctly".
>
> ECB (electronic code book) is a mode of operation for block ciphers
> https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation
> Stream ciphers do not have those modes.
>

This is exactly the point Eric was making. Our skcipher abstraction
deals with stream ciphers fine, but the way the arc4 code is exposed
as ecb(arc4) and updates the key in the process makes absolutely no
sense.

> For that matter, not all block cipher modes use an IV. The very common
> CBC mode -- the only mode used in IPsec, for example -- does, but
> others including ECB do not. I do not know of any mode that ever
> updates the IV. CBC uses the IV with the first block & on all other
> blocks uses the ciphertext from the previous block the same way; one
> might call that updating the IV I suppose, but I do not see why one
> would want to.
>

If you want to split up a CBC transformation into several invocations
of the underlying API, then the last ciphertext block of the first
call serves as the IV for the next call. Arguing that we should not be
calling this an IV serves little purpose, since the code already
treats it exactly the same. In fact, our CTS template relies on this
feature as well, so a CBC implementation that does not return the last
ciphertext block in the IV buffer is broken wrt our API requirements.

> > It sounds to me like it was broken and should be fixed.  So our vote /
> > preference is to have ARC4 fixed to follow the proper semantics.
>
> As I see it, those are clearly not "he proper semantics" for a stream
> cipher & the question of forcing it into them should not even arise.
>
> One alternative would be to drop arc4. That would make sense if WEP is
> the only usage & we elect to drop WEP. One could also argue the arc4
> itself is insecure & should go, but I'm not sure that is accurate.
> Certainly there have been some published attacks & other stream
> ciphers are now generally preferrred, but I have not followed things
> closely enough to know if RC$ should be considered fatally flawed.
>
> A better choice might be to change the interface, defining a new
> interface for stream ciphers and/or generalising the interface so it
> works for either stream ciphers or block ciphers.

Dropping WEP is out of the question, and apparently, there are
userspace dependencies on the ecb(arc4) cipher as well, so
unfortunately, we have already painted ourselves into a corner here.

skcipher works fine for block ciphers wrapped in CTR mode, and for
chacha/salsa as well, so I don't think there is a problem with the API
for other stream ciphers we care about. Calling the rc4 skcipher
'ecb(arc4)' was obviously a mistake, but it seems we're stuck with
that as well :-(

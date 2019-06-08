Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65D739FC8
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 15:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfFHNDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jun 2019 09:03:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53641 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfFHNDn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jun 2019 09:03:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so4525692wmj.3;
        Sat, 08 Jun 2019 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9mYiopIPpps0A5+Rr62JCfqsyqeSnG5/SRF+hwgzDj0=;
        b=DAuCMhALiMoYefyaWD/jlHJ6nNUjhzwmRPoEMEqSvhi67JYR9cIHk7tewbXF8CV0KE
         afepfulBc7+zlcZiEbxUPAZPpV68l+5y3nPZesZqT5YA2m0Iar/EIitVUWRQw6tRdWWI
         o3QqkRM31t7stQL/MMx/+A6lzLOV1FrtgUTI7Q281FcBFwdhN8xK/rMDb5fDrm3kQCBX
         dEJ8UJ+2GyIoj54Qy0xemUATA/Y5zrr9iwMuBL5f+ZFJ1TXUaN33pQgMl/GhJ1Jnn3wp
         EF9nKMN3zvMniwZW1Bq5h50l7xInp8o7hCH3XzvrSdRzgY1KKzKnq2GWLEuWx9i7iFCW
         AKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9mYiopIPpps0A5+Rr62JCfqsyqeSnG5/SRF+hwgzDj0=;
        b=OeUa6jOPLhqs7vdxT6kLqNVJ3aNDss8TGyB5od/mjlN/Zbu/9M+1jnmE+wibkkk01V
         8up8H98ehXUAgHfTjoBHo1p5mFBTMJrWgoutDZ+hLYwC4OT1hgtUMxroL2zcRcESZi88
         zJi964TJx9sVjFFizJ5hBAeN00wyuSCk+L1KmNjRNudTP8/TU4Tq/Zz14djG+f2WTUyn
         ebac9y8/LhLG+a+XNUCYLqpfKnykHuPmro9eJNt5LhtLzVjWgRzeKBjm+vZg/NR+9rfN
         7Vy6DUj+NZr3dgohu/j4U+5G/2MIeaSKFFd62UC5zXYr8BAcYPwY0XxDqaIdsonH8Qck
         MbaQ==
X-Gm-Message-State: APjAAAUtf5Q5aw57XwYZ7Tmu88Zob3Y92GJe2RIH++IsIpUu9BmQ0Kcs
        r5vljVxvjnUX5PMphc2PCp/seqP2XixpTd+0er8=
X-Google-Smtp-Source: APXvYqwayRDzvzU3yrmx8g9aiE3Bz1mt911cA1S1ZOUVX85HnZXSfqG8PzJXY5zcZRSNifZJO3iyFxEncgZpyPK7bxU=
X-Received: by 2002:a1c:bbc1:: with SMTP id l184mr6990075wmf.111.1559999020591;
 Sat, 08 Jun 2019 06:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
 <20190607175947.GB648@sol.localdomain> <97BB95F6-4A4C-4984-9EAB-6069E19B4A4F@holtmann.org>
 <CAKv+Gu-ek4nK+cACx5QZTbp=ciQq_Fvtn9y3g-wFWSOabyczZg@mail.gmail.com>
 <f40ad169-93b9-636f-9656-634ff331ee2b@gmail.com> <20190607211514.GD648@sol.localdomain>
 <d394b421-799d-2019-fcf0-97ba0b2abb5f@gmail.com> <20190607214120.GE648@sol.localdomain>
 <78298612-a36b-deaa-1510-94cf0001af9d@gmail.com> <20190607224040.GG648@sol.localdomain>
 <61e1cd8a-4891-4e37-417e-1c31cd95a278@gmail.com>
In-Reply-To: <61e1cd8a-4891-4e37-417e-1c31cd95a278@gmail.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Sat, 8 Jun 2019 09:03:28 -0400
Message-ID: <CACXcFm=2_1S75G7NWRCQjBS6gi+vDZFROzg6Ntjh-fAcPfYhyQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] move WEP implementation to skcipher interface
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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

First off, it is not clear we should implement WEP at all since it is
fatally flawed. This has been known for about a decade, there have
been at least two better algorithms added to the standards, & the only
reason anyone would need WEP today would be to connect to an old
router in an obviously insecure way.
https://www.schneier.com/blog/archives/2007/04/breaking_wep_in.html
https://www.tomshardware.com/reviews/wireless-security-hack,2981-4.html

Twenty years ago the FreeS/WAN project implemented IPsec for Linux &
deliberately did not include things like single DES which were known
to be insecure:
https://www.freeswan.org/freeswan_trees/freeswan-1.99/doc/compat.html#dropped
I think a similar policy was would be a fine idea for the kernel today
& WEP is hopelessly insecure.

> > As I am attempting to explain, ecb(arc4) does not implement this API correctly
> > because it updates the *key* after each operation, not the IV.  I doubt this is
> > documented anywhere, but this can only be changed if people aren't relying on it
> > already.

It is more the case that the API does not apply to arc4, or more
generally to stream ciphers, than that "ecb(arc4) does not implement
this API correctly".

ECB (electronic code book) is a mode of operation for block ciphers
https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation
Stream ciphers do not have those modes.

For that matter, not all block cipher modes use an IV. The very common
CBC mode -- the only mode used in IPsec, for example -- does, but
others including ECB do not. I do not know of any mode that ever
updates the IV. CBC uses the IV with the first block & on all other
blocks uses the ciphertext from the previous block the same way; one
might call that updating the IV I suppose, but I do not see why one
would want to.

> It sounds to me like it was broken and should be fixed.  So our vote /
> preference is to have ARC4 fixed to follow the proper semantics.

As I see it, those are clearly not "he proper semantics" for a stream
cipher & the question of forcing it into them should not even arise.

One alternative would be to drop arc4. That would make sense if WEP is
the only usage & we elect to drop WEP. One could also argue the arc4
itself is insecure & should go, but I'm not sure that is accurate.
Certainly there have been some published attacks & other stream
ciphers are now generally preferrred, but I have not followed things
closely enough to know if RC$ should be considered fatally flawed.

A better choice might be to change the interface, defining a new
interface for stream ciphers and/or generalising the interface so it
works for either stream ciphers or block ciphers.

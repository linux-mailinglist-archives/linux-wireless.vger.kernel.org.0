Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1849439912
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 00:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfFGWkm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 18:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbfFGWkm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 18:40:42 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA50E20840;
        Fri,  7 Jun 2019 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559947242;
        bh=9aTkaOerlb4Rleo7y3S1wIRbAA3fQBN+zxYN7HUhn1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zvX+Bvu+bVJKmRo2P06UNV2bdpix/u+pn3XnrSVqE5+xSaOs67XXdXW1AUN9BQrtJ
         jYOqx7PJrpiEuESOIntFpE0b5nw+Nnnd7ytlBOmqQREudCPzm7pvftkzxl5ea4LXMK
         AA7DpwmX+IcCTVPl8rAJUh4f1F7s8sBX2sdyBy1Q=
Date:   Fri, 7 Jun 2019 15:40:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:NFC SUBSYSTEM" <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 0/3] move WEP implementation to skcipher interface
Message-ID: <20190607224040.GG648@sol.localdomain>
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
 <20190607175947.GB648@sol.localdomain>
 <97BB95F6-4A4C-4984-9EAB-6069E19B4A4F@holtmann.org>
 <CAKv+Gu-ek4nK+cACx5QZTbp=ciQq_Fvtn9y3g-wFWSOabyczZg@mail.gmail.com>
 <f40ad169-93b9-636f-9656-634ff331ee2b@gmail.com>
 <20190607211514.GD648@sol.localdomain>
 <d394b421-799d-2019-fcf0-97ba0b2abb5f@gmail.com>
 <20190607214120.GE648@sol.localdomain>
 <78298612-a36b-deaa-1510-94cf0001af9d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78298612-a36b-deaa-1510-94cf0001af9d@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 07, 2019 at 04:54:04PM -0500, Denis Kenzior wrote:
> Hi Eric,
> 
> On 06/07/2019 04:41 PM, Eric Biggers wrote:
> > On Fri, Jun 07, 2019 at 04:28:59PM -0500, Denis Kenzior wrote:
> > > Hi Eric,
> > > 
> > > On 06/07/2019 04:15 PM, Eric Biggers wrote:
> > > > On Fri, Jun 07, 2019 at 03:45:45PM -0500, Denis Kenzior wrote:
> > > > > Hi Ard,
> > > > > 
> > > > > > 
> > > > > > Ah ok, good to know. That does imply that the driver is not entirely
> > > > > > broken, which is good news I suppose.
> > > > > > 
> > > > > 
> > > > > Not entirely, but we did have to resort to using multiple sockets, otherwise
> > > > > parallel encrypt/decrypt operations on the socket would result in invalid
> > > > > behavior.  Probably due to the issue Eric already pointed out.
> > > > > 
> > > > > No such issue with any other ciphers that we use.
> > > > > 
> > > > > Regards,
> > > > > -Denis
> > > > 
> > > > Okay, that sucks, so we do have to keep "ecb(arc4)" in the crypto API then.  And
> > > > we can't fix its name to be just "arc4".  It's odd that someone would choose to
> > > > use AF_ALG over writing a 20 line arc4_crypt() in userspace, but whatever.
> > > > 
> > > > Yes, "ecb(arc4)" isn't currently thread safe.  ARC4 uses a single key whereas
> > > > modern stream ciphers use a key + IV.  To comply with the crypto API it would
> > > > have to copy the key to a stack buffer for each encryption/decryption.  But it
> > > > doesn't; it just updates the key instead, making it non thread safe.  If users
> > > > are actually relying on that, we'll have to settle for adding a mutex instead.
> > > 
> > > Well the issue isn't even about being thread safe.  We run a single thread
> > > in iwd.  The details are a bit fuzzy now due to time elapsed, but if I
> > > recall correctly, even behavior like:
> > > 
> > > fd = socket();
> > > bind(fd, ecb(arc4));
> > > setsockopt(fd, ...key...);
> > > 
> > > sendmsg(fd, OP_ENCRYPT, ...);
> > > sendmsg(fd, OP_DECRYPT, ...);
> > > sendmsg(fd, OP_ENCRYPT, ...);
> > > 
> > > would produce different (incorrect) encrypted results compared to
> > > 
> > > sendmsg(fd, OP_ENCRYPT, ...)
> > > sendmsg(fd, OP_ENCRYPT, ...)
> > > 
> > 
> > That's because currently each operation uses the next bytes from the keystream,
> > and a new keystream is started only by setsockopt(..., ALG_SET_KEY, ...).
> > There's no difference between ARC4 encryption and decryption; both just XOR the
> > keystream with the data.  Are you saying you expected each encryption to be a
> > continuation of the previous encryption, but decryptions to be independent?
> > 
> 
> From a userspace / api perspective, yes I would have expected the encrypt
> and decrypt to work independently.  No biggie now, but I remember being
> surprised when this bit me as no other cipher had this behavior.  E.g.
> interleaving of operations seemed to only affect arc4 results.
> 
> Are the exact semantics spelled out somewhere?
> 

For all other skcipher algorithms, every operation is independent and depends
only on the key which was set previously on the algorithm socket, plus the IV
provided for the operation.  There is no way to perform a single encryption or
decryption incrementally in multiple parts, unless the algorithm supports it
naturally by updating the IV (e.g. CBC mode).

As I am attempting to explain, ecb(arc4) does not implement this API correctly
because it updates the *key* after each operation, not the IV.  I doubt this is
documented anywhere, but this can only be changed if people aren't relying on it
already.

- Eric

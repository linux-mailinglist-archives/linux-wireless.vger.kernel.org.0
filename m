Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF388396C4
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 22:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfFGUYR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 16:24:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43536 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbfFGUYR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 16:24:17 -0400
Received: from marcel-macpro.fritz.box (p5B3D2A37.dip0.t-ipconnect.de [91.61.42.55])
        by mail.holtmann.org (Postfix) with ESMTPSA id 71658CF2C8;
        Fri,  7 Jun 2019 22:32:39 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 0/3] move WEP implementation to skcipher interface
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190607175947.GB648@sol.localdomain>
Date:   Fri, 7 Jun 2019 22:24:15 +0200
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:NFC SUBSYSTEM" <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <97BB95F6-4A4C-4984-9EAB-6069E19B4A4F@holtmann.org>
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
 <20190607175947.GB648@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Eric,

>> One of the issues that I would like to see addressed in the crypto API
>> is they way the cipher abstraction is used. In general, a cipher should
>> never be used directly, and so it would be much better to clean up the
>> existing uses of ciphers outside of the crypto subsystem itself, so that
>> we can make the cipher abstraction part of the internal API, only to
>> be used by templates or crypto drivers that require them as a callback.
>> 
>> As a first step, this series moves all users of the 'arc4' cipher to
>> the ecb(arc4) skcipher, which happens to be implemented by the same
>> driver, and is already a stream cipher, given that ARC4_BLOCK_SIZE
>> actually evaluates to 1.
>> 
>> Next step would be to switch the users of the 'des' and 'aes' ciphers
>> to other interfaces that are more appropriate, either ecb(...) or a
>> library interface, which may be more appropriate in some cases. In any
>> case, the end result should be that ciphers are no longer used outside
>> of crypto/ and drivers/crypto/
>> 
>> This series is presented as an RFC, since I am mostly interested in
>> discussing the above, but I prefer to do so in the context of actual
>> patches rather than an abstract discussion.
>> 
>> Ard Biesheuvel (3):
>>  net/mac80211: switch to skcipher interface for arc4
>>  lib80211/tkip: switch to skcipher interface for arc4
>>  lib80211/wep: switch to skcipher interface for arc4
>> 
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
> Someone could theoretically be using "ecb(arc4)" via AF_ALG or dm-crypt, but it
> seems unlikely…

that is not unlikely, we use ecb(arc4) via AF_ALG in iwd. It is what the WiFi standard defines to be used.

Regards

Marcel


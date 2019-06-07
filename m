Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0035393D2
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 19:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfFGR7t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 13:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbfFGR7t (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 13:59:49 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D6D2212F5;
        Fri,  7 Jun 2019 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559930388;
        bh=nRCIwBcdk3xHkjHKH9YvvTTdANQdS8/mNXTIjHJ8jXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=piwy5pU6pd5asVn95zXKs1rbcoLhYCyJDxsCg0HctMGH6gPimi+ffA4fLLQkLUzp3
         zOCVnc5o2NDh+4xN8ziXnOhDliaN9iCkefmBSHr2uvRJt1gG7iOx8yY01ldrl/QURh
         lR6YR8/rBb0jGZyIM8PkCY5+Mt7q0zSuZgqdsldU=
Date:   Fri, 7 Jun 2019 10:59:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [RFC PATCH 0/3] move WEP implementation to skcipher interface
Message-ID: <20190607175947.GB648@sol.localdomain>
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 07, 2019 at 04:49:41PM +0200, Ard Biesheuvel wrote:
> One of the issues that I would like to see addressed in the crypto API
> is they way the cipher abstraction is used. In general, a cipher should
> never be used directly, and so it would be much better to clean up the
> existing uses of ciphers outside of the crypto subsystem itself, so that
> we can make the cipher abstraction part of the internal API, only to
> be used by templates or crypto drivers that require them as a callback.
> 
> As a first step, this series moves all users of the 'arc4' cipher to
> the ecb(arc4) skcipher, which happens to be implemented by the same
> driver, and is already a stream cipher, given that ARC4_BLOCK_SIZE
> actually evaluates to 1.
> 
> Next step would be to switch the users of the 'des' and 'aes' ciphers
> to other interfaces that are more appropriate, either ecb(...) or a
> library interface, which may be more appropriate in some cases. In any
> case, the end result should be that ciphers are no longer used outside
> of crypto/ and drivers/crypto/
> 
> This series is presented as an RFC, since I am mostly interested in
> discussing the above, but I prefer to do so in the context of actual
> patches rather than an abstract discussion.
> 
> Ard Biesheuvel (3):
>   net/mac80211: switch to skcipher interface for arc4
>   lib80211/tkip: switch to skcipher interface for arc4
>   lib80211/wep: switch to skcipher interface for arc4
> 

The way the crypto API exposes ARC4 is definitely broken.  It treats it as a
block cipher (with a block size of 1 byte...), when it's actually a stream
cipher.  Also, it violates the API by modifying the key during each encryption.

Since ARC4 is fast in software and is "legacy" crypto that people shouldn't be
using, and the users call it on virtual addresses, perhaps we should instead
remove it from the crypto API and provide a library function arc4_crypt()?  We'd
lose support for ARC4 in three hardware drivers, but are there real users who
really are using ARC4 and need those to get acceptable performance?  Note that
they aren't being used in the cases where the 'cipher' API is currently being
used, so it would only be the current 'skcipher' users that might matter.

Someone could theoretically be using "ecb(arc4)" via AF_ALG or dm-crypt, but it
seems unlikely...

As for removing the "cipher" API entirely, we'd have to consider how to convert
all the current users, not just ARC4, so that would be a somewhat different
discussion.  How do you propose to handle dm-crypt and fscrypt which use the
cipher API to do ESSIV?

- Eric

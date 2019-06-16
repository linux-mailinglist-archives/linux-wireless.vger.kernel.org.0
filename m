Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2EE47699
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 21:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfFPTnZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 15:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfFPTnY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 15:43:24 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C7E2070B;
        Sun, 16 Jun 2019 19:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560714204;
        bh=1AgnnT0S6q2v3YXitGi8Q9A33dcfbgKdTOY6HZU7i8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qThrRM9iE3m6BsJgprPRppxZOhCLl0+LTd+186RfRwXg1YgiXZbDZCM9yBtSPTL9O
         7SMe/RPsOO0GzJM1eQ9JuK7f29a0H4TsNyzwSeSacVy+3Hyk3YDhyGQISvARRpu4EJ
         JtdCBx23eIXnKBu7PNH6dSa1wTbPV93zkTq0Xq+Y=
Date:   Sun, 16 Jun 2019 12:43:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] wireless: airo: switch to skcipher interface
Message-ID: <20190616194322.GC923@sol.localdomain>
References: <20190614093603.22771-1-ard.biesheuvel@linaro.org>
 <20190616071206.GB698@sol.localdomain>
 <CAKv+Gu97xkz5qxycyjqmukFhWAD6p=eYbTqoPWt-ZNbBFDbNAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu97xkz5qxycyjqmukFhWAD6p=eYbTqoPWt-ZNbBFDbNAw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jun 16, 2019 at 09:03:58PM +0200, Ard Biesheuvel wrote:
> >
> > Otherwise this patch looks correct to me.
> >
> > The actual crypto in this driver, on the other hand, looks very outdated and
> > broken.  Apparently it's implementing some Cisco proprietary extension to WEP
> > that uses a universal hashing based MAC, where the hash key is generated from
> > AES-CTR.  But the MAC is only 32 bits, and the universal hash (MMH) is
> > implemented incorrectly: there's an off-by-one error in emmh32_final() in the
> > code that is supposed to be an optimized version of 'sum % ((1ULL << 32) + 15)'.
> >
> 
> I stared at that code for a bit, and I don't see the problem.
> 

I'm fairly certain that the line:

	if (utmp > 0x10000000fLL)

is supposed to be:

	if (utmp >= 0x10000000fLL)

Since it's doing mod 0x10000000f.  It's supposed to be an optimized
implementation of 'val = (u32)(context->accum % 0x10000000f)' where 0x10000000f
is the prime number 2^32 + 15.  It's meant to be the MMH algorithm: Section 3.2
of https://link.springer.com/content/pdf/10.1007/BFb0052345.pdf.  But there are
values of 'accum' where it gives the wrong result, e.g. 14137323879880455377.

Possibly this is a bug in the Cisco MIC protocol itself so can't be fixed.

> > Do we know whether anyone is actually using this, or is this just another old
> > driver that's sitting around unused?
> >
> 
> Excellent question. I take it this is pre-802.11b hardware, and so
> even the OpenWRT people are unlikely to still be using this.

- Eric

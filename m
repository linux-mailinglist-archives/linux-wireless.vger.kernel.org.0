Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269604542DD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhKQItT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 03:49:19 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:56160 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbhKQItS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 03:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1637138779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iuXwVFGg3YCBDP5Ljt+fN+IuTJFfYGidqYCQ28UJkMI=;
        b=SjOfvxAsD0LBx0uQdbTga4tT6i0tdDeoNHhK7u0DXneeTQaDb76bDTVZ1VSlFkhai1YNvX
        +EN4wlcRW/DdFvJwlqLtIyH3xA3HTQo2yJrzRFZTwKW8SsVm7kgJaXSkeFOJewiz3uYAAV
        yPa8S+ZxCPRRty+suS758rG0iMPXCyc=
From:   Sven Eckelmann <sven@narfation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>,
        linux-wireless@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/4] ath11k: add support for device recovery for QCA6390
Date:   Wed, 17 Nov 2021 09:46:08 +0100
Message-ID: <2357945.8AGfkZV0UB@sven-desktop>
In-Reply-To: <87mtm3dwu0.fsf@codeaurora.org>
References: <20211116041522.23529-1-quic_wgong@quicinc.com> <1752085.FWK5zBq28I@ripper> <87mtm3dwu0.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1845216.Og6EX3yCZx"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1845216.Og6EX3yCZx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/4] ath11k: add support for device recovery for QCA6390
Date: Wed, 17 Nov 2021 09:46:08 +0100
Message-ID: <2357945.8AGfkZV0UB@sven-desktop>
In-Reply-To: <87mtm3dwu0.fsf@codeaurora.org>
References: <20211116041522.23529-1-quic_wgong@quicinc.com> <1752085.FWK5zBq28I@ripper> <87mtm3dwu0.fsf@codeaurora.org>

On Wednesday, 17 November 2021 09:12:55 CET Kalle Valo wrote:
> > https://www.kernel.org/doc/html/v5.15/process/coding-style.html#using-bool
[...]
> 
> Yeah, I have been worried about this as well and we should fix this. But
> instead of u8 I would prefer to use bool like mt76 uses:
[...]
> I didn't even know using bool is legal until I saw it in mt76.

Interesting, I was also not aware of it. And it also seems to have some 
interesting implications when assigning values to it (example 4):

    #include <stdbool.h>
    #include <stdint.h>
    #include <stdio.h>
    
    struct test {
    	uint8_t u:1;
    	uint8_t u2:1;
    	bool b:1;
    	bool b2:1;
    };
    
    int main(void)
    {
    	struct test x;
    
    	x.u = false;
    	x.b = false;
    	printf("u %u b %u\n", x.u, x.b);
    
    	x.u = true;
    	x.b = true;
    	printf("u %u b %u\n", x.u, x.b);
    
    	x.u = 0;
    	x.b = 0;
    	printf("u %u b %u\n", x.u, x.b);
    
    	x.u = 8;
    	x.b = 8;
    	printf("u %u b %u\n", x.u, x.b);
    
    	return 0;
    }


Result:

    u 0 b 0
    u 1 b 1
    u 0 b 0
    u 0 b 1


The last example is basically the reason we see stuff like

    boolean_like_value = !!(some_retrieved_value);

when using unsigned bitfields instead of bool (bitfields).


And the memory layout (on x86-64):

    $ pahole test.o                                    
    struct test {
            uint8_t                    u:1;                  /*     0: 0  1 */
            uint8_t                    u2:1;                 /*     0: 1  1 */
            _Bool                      b:1;                  /*     0: 2  1 */
            _Bool                      b2:1;                 /*     0: 3  1 */
    
            /* size: 1, cachelines: 1, members: 4 */
            /* bit_padding: 4 bits */
            /* last cacheline: 1 bytes */
    };


To my surprise, it was already mentioned in one of the discussions [1].
Was there anything in the discussion which I might have missed and 
is a good reason to not use "bool ...:1" in structs?

Kind regards,
	Sven

[1] https://lore.kernel.org/all/CA+55aFwVZk1OfB9T2v014PTAKFhtVan_Zj2dOjnCy3x6E4UJfA@mail.gmail.com/T/#u
--nextPart1845216.Og6EX3yCZx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGUwVAACgkQXYcKB8Em
e0b6JBAA0zifY/YwpDdxoScQKo9J5bG4vN1SEnMchgKICaNa7P1e97sJ1ogkhj+8
pq+5krHbE35vopH96mFTvQ0JZVze3m8kom0TXSnN+erwjzV/JrO8vF4qg6Wac2c3
U5ySpWWS8/a2ziipcB5YrLEJzjNzxpJb20hKxE5juJ1gwhmay97wsVFzbnFX403v
ceDIN+fmcRtUg3LGpVXsUQIjIKHb6T/21ud5Cjv6rx/1SsUUrRRvokKWJuvU5JKD
MYbzS2xnleofgJKCjk1/LM4V9F3s0qR7sQYxGr2jlA6MebMer4E8iY2sXuSULdRt
1YbSd0TN535hMprBCmj/lhmWiC0OIwbw1zagjWAbFdB9sksF9eEka6nbXoTzH9w9
q1CLX8uhBgChYXhT5CSAHiv4KtlfrjqAsYsPbuYALMo9G+Pqwtnf0WArWeloPbPu
4ll2X5jOptPpKIPvHvI+FWY/XNJG1DYFQKsXMs2s8A7iSidaKcPj62sLLql4tMsr
zt5ZyQa4gLvI0A4mUQ5uoXgz5AfspFfNPQqsybjs/0/H/B+HIUAfsD+B7Gi/LSlj
SKyYs4ChOowKTR/aYvZZ9RDXOvW0lLS6Ma7hZEAH2cRwZKR+Uc6x86n453wiTB1y
z4Dq/G+v1SiwRNRPbOSE2tyT2gqPEPlAXghdT4rUcyoGiaxXFqc=
=Gdz9
-----END PGP SIGNATURE-----

--nextPart1845216.Og6EX3yCZx--




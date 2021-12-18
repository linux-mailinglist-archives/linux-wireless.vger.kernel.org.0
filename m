Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B5C4799F1
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Dec 2021 10:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhLRJRH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Dec 2021 04:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhLRJRG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Dec 2021 04:17:06 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF72C061574
        for <linux-wireless@vger.kernel.org>; Sat, 18 Dec 2021 01:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1639819022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SF02bACsOlKBBTjhK78ueYmpKRKGRba4v5mKU006x8g=;
        b=GmGIbvW/gFj4ogrSfpdY8TLE4kVLY4FA0Zn6lTelRqDCgp+T9SLy80rVnztPLKwpEMrVb7
        gZdSMJGZhVgxVI9851zzj+6R8dP79B0J0ZUNcrR2kEEcncmSWJm9+0UvZXpUdgMaJq5cgm
        JcpeKtXGcrULF5u7kc8Z2f8szVBY7A0=
From:   Sven Eckelmann <sven@narfation.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
Date:   Sat, 18 Dec 2021 10:16:59 +0100
Message-ID: <2127318.8OWqheGOAS@sven-l14>
In-Reply-To: <2102838.219ycuhFCz@sven-l14>
References: <20211011193750.4891-1-cjhuang@codeaurora.org> <4f28496abae7743ab2a9fa7150c5d64c@codeaurora.org> <2102838.219ycuhFCz@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2472807.WDt2SMqAfp"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart2472807.WDt2SMqAfp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
Date: Sat, 18 Dec 2021 10:16:59 +0100
Message-ID: <2127318.8OWqheGOAS@sven-l14>
In-Reply-To: <2102838.219ycuhFCz@sven-l14>
References: <20211011193750.4891-1-cjhuang@codeaurora.org> <4f28496abae7743ab2a9fa7150c5d64c@codeaurora.org> <2102838.219ycuhFCz@sven-l14>

On Saturday, 18 December 2021 09:37:02 CET Sven Eckelmann wrote:
> Why are you defining it as `u8 replay_counter[GTK_REPLAY_COUNTER_BYTES];` in 
> the struct instead of using `__le64 replay_counter;`?
> 
> What ensures that this is value is 64 bit aligned in memory? Wouldn't it be 
> more correct to (see above) use
> 
>     replay_ctr = cpu_to_be64(get_unaligned_le64(ev->replay_counter));
> 

Sorry for the noise, but the part of not knowing in which endianness the 
firmware return multi-byte values is freaking me out. The above statements 
assume that it is returning everything as little endian.

If it is actually returns in host byte order (no idea how the firmware 
determines this) then of course, the questions should be:

* Why are you defining it as `u8 replay_counter[GTK_REPLAY_COUNTER_BYTES];` in 
  the struct instead of using `u64 replay_counter;`?

* What ensures that this is value is 64 bit aligned in memory? Wouldn't it be 
  more correct (assuming it is a u64) to use

    replay_ctr = cpu_to_be64(get_unaligned64(ev->replay_counter));


Kind regards,
	Sven
--nextPart2472807.WDt2SMqAfp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmG9pwwACgkQXYcKB8Em
e0auIQ/8CkFgbaoLmhL9m6AtlCC1vVLG84dopRi73TAhkmFO4ZZPHJ718cmcYiUh
npz6aU7O5uZLaHtGYgZbXFyl6/K6Z9PIGPOmUqTuQSnv1GnMuMI5R92iBaaRmDvY
vVShMx/0HQHB3PnIzBt7RMdqBXbVYU4Cl1/0Y6voPqHuFML4uTg7x0YhLE2BfPmc
+ygNN7h286Y1REqh4oKHXQLwL70dWK0l4gV4ZlCAe0qWIE4S4FnDlbU9c0poIpKv
CGlUjcV7JHfr3zTgLgvNIYR1pga9i2pv2gCNdKEplY3lZ7Nj92Zq87xBZbqhBIyR
FXbnELW45L7AJhOy03/q4sgYYwSDBHjHxLcB0P/nYy5aSQnBXCNXYKwC+atIODIK
3/ktur5QCB568YuH0KFlxnD5xFf9EOcZfwQEbgGaS3IpgFKJjvD9u7IeGzZs63Fs
sCEwRnpsboLGbGOzZfvTz6TxFQur8vy+eij7TVBdKfv2Fb1phHNNfnWEzMICHIMl
ZuxNN5kiiYnMjFdKqm/CXCX0Lau00vHpecSyib3VyUphcf2sbRR7Xp8HmnTEov26
APE4H9sNKi1zPe3x/rD6sl23YMk1ib8rBcnDsWkxxVASsja9lA7H9uGDlzOf2HUP
agxXtp2WCYeQcXiQsj110rupSWY0pJ1dyYzx7SUST09lTHu/1wk=
=QbwG
-----END PGP SIGNATURE-----

--nextPart2472807.WDt2SMqAfp--




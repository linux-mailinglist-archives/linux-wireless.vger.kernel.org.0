Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497284799BF
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Dec 2021 09:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhLRIhJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Dec 2021 03:37:09 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:52186 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhLRIhJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Dec 2021 03:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1639816627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XGIosFYTDWGNz4+uFjHL6ROYC57PsHCdGUmmDVimiA=;
        b=2UpmT8HHh/ITqa7HrXJYhk20MsxFlLxfYmnYhHtZ+VJbuuu0xScqoUlixa3ziz5Pp8c33D
        USNWtrBKmIKLX/lItH76SuoAz/s1gPjzxPx/YgfAsUruv583EWU4i/kbO6cKSq2wZhATMs
        o6+6fwjN543I3FGkpxC+ak1xhggj0Ms=
From:   Sven Eckelmann <sven@narfation.org>
To:     Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
Date:   Sat, 18 Dec 2021 09:37:02 +0100
Message-ID: <2102838.219ycuhFCz@sven-l14>
In-Reply-To: <4f28496abae7743ab2a9fa7150c5d64c@codeaurora.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org> <87lf0tydad.fsf@codeaurora.org> <4f28496abae7743ab2a9fa7150c5d64c@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1939230.MS5jTM4reW"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1939230.MS5jTM4reW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, quic_cjhuang@quicinc.com, Carl Huang <cjhuang@codeaurora.org>
Subject: Re: [PATCH 6/6] ath11k: support GTK rekey offload
Date: Sat, 18 Dec 2021 09:37:02 +0100
Message-ID: <2102838.219ycuhFCz@sven-l14>
In-Reply-To: <4f28496abae7743ab2a9fa7150c5d64c@codeaurora.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org> <87lf0tydad.fsf@codeaurora.org> <4f28496abae7743ab2a9fa7150c5d64c@codeaurora.org>

> On Thursday, 9 December 2021 17:05:14 CET Kalle Valo wrote:
>> Isn't ath11k WMI commands and events supposed to be in CPU
>> endian and the firmware automatically translates them if CPU is little
>> or big endian? 
[...]
On Friday, 17 December 2021 12:04:45 CET Carl Huang wrote:
> Both cpu and firmware are supposed to be little endian in ath11k.

I hope this statement is incorrect. But if it isn't:

You cannot limit a non-architecture dependent driver to be only used by little 
endian CPUs. This would be grave bug in ath11k.

If your firmware requires wmi messages and similar things in little endian 
then you have to mark types correctly as big/little endian. E.g. __le32 
instead of u32. And then you have to convert everything manually with 
cpu_to_le32 and so on. See the ath10k code for examples.

Tools like sparse can assist you in your search for problematic places when 
your kernel has the __CHECK_ENDIAN__ related code activated. This is the 
default for kernels >= 4.10.


If Kalle' statement is true that the firmware takes care of endianness 
translation of WMI messages to host endianness, then your code would still be 
questionable:

>> +       /* supplicant expects big-endian replay counter */
>> +       replay_ctr = cpu_to_be64(le64_to_cpup((__le64 
>> *)ev->replay_counter));

Why isn't the firmware taking care of the conversion at that place?

Why are you defining it as `u8 replay_counter[GTK_REPLAY_COUNTER_BYTES];` in 
the struct instead of using `__le64 replay_counter;`?

What ensures that this is value is 64 bit aligned in memory? Wouldn't it be 
more correct to (see above) use

    replay_ctr = cpu_to_be64(get_unaligned_le64(ev->replay_counter));

Kind regards,
	Sven
--nextPart1939230.MS5jTM4reW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmG9na4ACgkQXYcKB8Em
e0aCNhAAhHy4Q89qTeLnxf2M2B4EsogXkCDmByJKzD2zh2RKOZGR4Cr83zZZQLrt
Ugf6tUgjPJHku22jnulsJQEYgghpYDdko0ajh8dFtW9GHsikQwM2KuE55XkM1I/Y
FF7hauJdsSQNpXbLZZxTtnf4NI3xLSU5tVKr+qMvgG6e64IJ1TOfsM0n+0X0YHkW
qnL89QqjpOodEwChsg8aOBEJnrIWcBgZKFSS8lMn3wmbt2uMIx3YkgLkxmcNQCF6
mBopA9rLU5De87ouxvmOt2r81CHeqFFzJ1IBE28toCHf3BprCxEF08yFkFJLszTx
6wlbSVtq5ba9cHI0Hg8j2fydVIixf2AxOSdqKo3WuYvsuSjwsbJVE/zsclt3DGQE
STpAoQUCZ+tHcVA3pM209uvyz2LQ2Bt3+8hxF404BmAbGVuc1lPyg0JXyOLFCdqJ
KEvRn2qVa2j5qp5xw0KRnxEVAgl+sW25dbZ1Y/isCa3y0uSRTKhq5D6Avlq9hyEd
8rgqzeAZ+4yzUgCbO8Oa3vTiMnDE0edi53xBzlxmfRgz9V1000evT7YpvwK88L1Q
HdFGXwkTj2DYY8MAfhKzyPOJTEMSSv9Lkv1JLC22CC+hrHGfotSnTQY1dgWyAsh/
Cw6cyqt6Zb8YJfD2FPjnkU9JJJfiL7P9r9dqAUlC8F82a8hCfAY=
=DiwO
-----END PGP SIGNATURE-----

--nextPart1939230.MS5jTM4reW--




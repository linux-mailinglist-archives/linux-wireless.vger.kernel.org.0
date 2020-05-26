Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BCA1E30E8
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 23:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391451AbgEZVDI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 17:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389600AbgEZVDH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 17:03:07 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA700C061A0F
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 14:03:06 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 49WmdN2vLLzQlHl;
        Tue, 26 May 2020 23:03:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id rSnrGA-xLr6d; Tue, 26 May 2020 23:03:01 +0200 (CEST)
Subject: Re: [PATCH] wireless: Use linux/stddef.h instead of stddef.h
To:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     johannes.berg@intel.com, ndesaulniers@google.com,
        pihsun@chromium.org, linux-wireless@vger.kernel.org
References: <20200521201422.16493-1-hauke@hauke-m.de>
 <2555103.LUZAIfNjjX@pc-42>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Autocrypt: addr=hauke@hauke-m.de; keydata=
 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
Message-ID: <d2db65dc-527b-b9a7-45a6-82a4df9cb732@hauke-m.de>
Date:   Tue, 26 May 2020 23:02:56 +0200
MIME-Version: 1.0
In-Reply-To: <2555103.LUZAIfNjjX@pc-42>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8H4wtj38kQFs7sVfRmdOoOyPBgtkTLmjj"
X-Rspamd-Queue-Id: 391ED17EE
X-Rspamd-Score: -6.83 / 15.00 / 15.00
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8H4wtj38kQFs7sVfRmdOoOyPBgtkTLmjj
Content-Type: multipart/mixed; boundary="NuLDnzvpGEIIgcr2jgenanXk2YbDzJXOs"

--NuLDnzvpGEIIgcr2jgenanXk2YbDzJXOs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/25/20 11:35 AM, J=C3=A9r=C3=B4me Pouiller wrote:
> On Thursday 21 May 2020 22:14:22 CEST Hauke Mehrtens wrote:
>> When compiling inside the kernel include linux/stddef.h instead of
>> stddef.h. When I compile this header file in backports for power PC I
>> run into a conflict with ptrdiff_t. I was unable to reproduce this in
>> mainline kernel. I still would like to fix this problem in the kernel.=

>>
>> Fixes: 6989310f5d43 ("wireless: Use offsetof instead of custom macro."=
)
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  include/uapi/linux/wireless.h | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wirele=
ss.h
>> index a2c006a364e0..24f3371ad826 100644
>> --- a/include/uapi/linux/wireless.h
>> +++ b/include/uapi/linux/wireless.h
>> @@ -74,7 +74,11 @@
>>  #include <linux/socket.h>              /* for "struct sockaddr" et al=
  */
>>  #include <linux/if.h>                  /* for IFNAMSIZ and co... */
>>
>> -#include <stddef.h>                     /* for offsetof */
>> +#ifdef __KERNEL__
>> +#      include <linux/stddef.h>        /* for offsetof */
>> +#else
>> +#      include <stddef.h>              /* for offsetof */
>> +#endif
>=20
> Hello,
>=20
> This patch also solves a warning I encountered when I launched sparse
> (with make C=3D1):
>=20
>   /usr/lib/gcc-cross/arm-linux-gnueabihf/9/include/stddef.h:406:9: warn=
ing: preprocessor token offsetof redefined
>   ./include/linux/stddef.h:17:9: this was the original definition
>=20
> However, I wonder if it useful to keep 'include <stddef.h>' when this f=
ile
> is included from userspace. If it does not compile anymore, there is
> problem somewhere else, no?
>=20
> (Globally, I always find suspicious a kernel source that includes a sys=
tem
> header)
Hi,

The wireless.h makes use of offsetof and this is defined in system
stddef.h and in include/linux/stddef.h. When we only include
linux/stddef.h it will work fine when compiled inside the kernel, but it
could cause problems when used in user space, because this would include
=2E/include/uapi/linux/stddef.h which does not define offsetof.

I think we need the #ifdef __KERNEL__ to make this work in the kernel
and in the user space.

Hauke


--NuLDnzvpGEIIgcr2jgenanXk2YbDzJXOs--

--8H4wtj38kQFs7sVfRmdOoOyPBgtkTLmjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAl7NhAAACgkQ8bdnhZyy
68f2uAf6AjHAOWJgy4Y+gVEat+CGJ7KE4fU5vvtE6iS6PZjcD9MaWYr92OH2kkGk
uzyecgqAecnZ65aCy0eqjRM2XBlRdE66WSkFwsgQ/VdtDx0wr91yHzPWC1CKntPP
wUOyAa42OaT9eXIfz59kspVJ5tP4Y0rRq4RPcZdq7SaADOegB4mKe/WmEn/6VxKm
UN2a8GxQQr5wYOEMJxe1AZpHS5dFpxOOWzAQzzn+N7D1ZFMSm5nBOsk4PTAscwZZ
dYCVWpo4DUkX+hAq7OLX3Rs0fMri7NZsri2ySwhkinzDDUfsrXffkcmtvK1TILa8
KrZfMmxhxwIcs3hnCbITr8dCHnxLmA==
=TO0o
-----END PGP SIGNATURE-----

--8H4wtj38kQFs7sVfRmdOoOyPBgtkTLmjj--

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665971F6981
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgFKOAv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 10:00:51 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:55412 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKOAv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 10:00:51 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 49jQVl4bZVzQlHK;
        Thu, 11 Jun 2020 16:00:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 0A5zNTMD-cgZ; Thu, 11 Jun 2020 16:00:44 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] wireless: Use linux/stddef.h instead of stddef.h
To:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     johannes.berg@intel.com, ndesaulniers@google.com,
        pihsun@chromium.org, linux-wireless@vger.kernel.org
References: <20200521201422.16493-1-hauke@hauke-m.de>
 <2555103.LUZAIfNjjX@pc-42> <d2db65dc-527b-b9a7-45a6-82a4df9cb732@hauke-m.de>
 <3791715.gBGQRhG51r@pc-42>
Autocrypt: addr=hauke@hauke-m.de; keydata=
 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
Message-ID: <ab7a0c7b-6a38-66cc-d1c4-6bc4fd627227@hauke-m.de>
Date:   Thu, 11 Jun 2020 16:00:31 +0200
MIME-Version: 1.0
In-Reply-To: <3791715.gBGQRhG51r@pc-42>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="C1gEJfrldlkbwR2xIdl9Jntdbke4wuzzn"
X-Rspamd-Queue-Id: 8420717ED
X-Rspamd-Score: -5.31 / 15.00 / 15.00
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C1gEJfrldlkbwR2xIdl9Jntdbke4wuzzn
Content-Type: multipart/mixed; boundary="vRDBA7RL5PeIJuMTUHaGkuRsb8G3mNJ77"

--vRDBA7RL5PeIJuMTUHaGkuRsb8G3mNJ77
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/27/20 4:03 PM, J=C3=A9r=C3=B4me Pouiller wrote:
> On Tuesday 26 May 2020 23:02:56 CEST Hauke Mehrtens wrote:
>> On 5/25/20 11:35 AM, J=C3=A9r=C3=B4me Pouiller wrote:
>>> On Thursday 21 May 2020 22:14:22 CEST Hauke Mehrtens wrote:
>>>> When compiling inside the kernel include linux/stddef.h instead of
>>>> stddef.h. When I compile this header file in backports for power PC =
I
>>>> run into a conflict with ptrdiff_t. I was unable to reproduce this i=
n
>>>> mainline kernel. I still would like to fix this problem in the kerne=
l.
>>>>
>>>> Fixes: 6989310f5d43 ("wireless: Use offsetof instead of custom macro=
=2E")
>>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>>> ---
>>>>  include/uapi/linux/wireless.h | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wire=
less.h
>>>> index a2c006a364e0..24f3371ad826 100644
>>>> --- a/include/uapi/linux/wireless.h
>>>> +++ b/include/uapi/linux/wireless.h
>>>> @@ -74,7 +74,11 @@
>>>>  #include <linux/socket.h>              /* for "struct sockaddr" et =
al  */
>>>>  #include <linux/if.h>                  /* for IFNAMSIZ and co... */=

>>>>
>>>> -#include <stddef.h>                     /* for offsetof */
>>>> +#ifdef __KERNEL__
>>>> +#      include <linux/stddef.h>        /* for offsetof */
>>>> +#else
>>>> +#      include <stddef.h>              /* for offsetof */
>>>> +#endif
>>>
>>> Hello,
>>>
>>> This patch also solves a warning I encountered when I launched sparse=

>>> (with make C=3D1):
>>>
>>>   /usr/lib/gcc-cross/arm-linux-gnueabihf/9/include/stddef.h:406:9: wa=
rning: preprocessor token offsetof redefined
>>>   ./include/linux/stddef.h:17:9: this was the original definition
>>>
>>> However, I wonder if it useful to keep 'include <stddef.h>' when this=
 file
>>> is included from userspace. If it does not compile anymore, there is
>>> problem somewhere else, no?
>>>
>>> (Globally, I always find suspicious a kernel source that includes a s=
ystem
>>> header)
>> Hi,
>>
>> The wireless.h makes use of offsetof and this is defined in system
>> stddef.h and in include/linux/stddef.h. When we only include
>> linux/stddef.h it will work fine when compiled inside the kernel, but =
it
>> could cause problems when used in user space, because this would inclu=
de
>> ./include/uapi/linux/stddef.h which does not define offsetof.
>>
>> I think we need the #ifdef __KERNEL__ to make this work in the kernel
>> and in the user space.
>=20
> In this case, maybe the problem should be resolved directly in
> uapi/linux/stddef.h?
>=20
> I have found other headers that use offsetof and may have the same prob=
lem
> (currently, they do not include stddef.h. So, some of the macros do not=

> compile):
>    - include/uapi/linux/fuse.h
>    - include/uapi/linux/genwqe/genwqe_card.h
>    - include/uapi/linux/gfs2_ondisk.h
>=20
Hi,

Would you prefer to add this to include/uapi/linux/stddef.h:
#ifndef offsetof
#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
#endif

and then include linux/stddef.h in all header files which use offsetof?

include/uapi/linux/fuse.h checks for __KERNEL__ and then includes
linux/types.h or stdint.h, my initial approach would be to do this in a
similar way for stddef.h.


What is the kernel policy of including system header files like stddef.h?=


Hauke


--vRDBA7RL5PeIJuMTUHaGkuRsb8G3mNJ77--

--C1gEJfrldlkbwR2xIdl9Jntdbke4wuzzn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAl7iOP8ACgkQ8bdnhZyy
68eOYggAxp80tGPBgIYyuzao5HcWg+FOVFIiZab1lh3putCwqtTXi+u5K7M4vFuW
X9MamoXUXaYkNdeZ+eU6cbLVFvad87ZD5YtfTATaPwRJozoxFM0i5DPgYpV8wLHM
1h01eHJr06PE/XCukK+sDviD8SHm7PGO6u98j+ZH9MPo/gNV7g3NTebkrz58A+sS
B8xdS6Aaup58TrKCtfgBdA293iCmR67VrzlGmMQo8aU7cDmsx7BTZLQXpTpKEsll
sqcTRUAeX821zlfO4/pRfa45SyK7OyN4SoUOhfj6HJTW483+j6tXgMP7sTxaawnV
kWG1xivfjvCPNX7870oJxpCCwEtxRw==
=J4wE
-----END PGP SIGNATURE-----

--C1gEJfrldlkbwR2xIdl9Jntdbke4wuzzn--

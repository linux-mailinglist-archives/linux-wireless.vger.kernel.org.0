Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5442BAD2F7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 08:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfIIGJW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 02:09:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:37625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfIIGJW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 02:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568009354;
        bh=KbQtLTywhaE42u3hIbBuQUO9k8fNz7hsH4JOGBUhLko=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SjDTdQ7SeA67D6xf2MVE3PSNDVJvgGnXrqjKggFQL7DHub6Y8/o1jE6fv13NMFQ/q
         bbWV5qRP9klamrv7emoX76bRavY185tap4DCu7056oAmHrAjyIffLCfv1oAU6alcHk
         R+fbvumHWfLeMcuMQELpNWwY0TWg5MQUfGO79hQw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKUp-1hqu8630IB-00LjQ5; Mon, 09
 Sep 2019 08:09:14 +0200
Subject: Re: [linuxwifi] Slow performance (~30mbps) with Intel 9260 (and 8265,
 3168) using 5G
To:     Luciano Coelho <luciano.coelho@intel.com>, linuxwifi@intel.com,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <c078f515-51bd-2195-6b96-901db8872028@gmx.com>
 <5d79c06b7d718e8255ee192902dba5aad780fba5.camel@intel.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <42bd356c-6c59-79dc-bb37-5bc36d07a9af@gmx.com>
Date:   Mon, 9 Sep 2019 14:09:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <5d79c06b7d718e8255ee192902dba5aad780fba5.camel@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yzfnwMgYtLDWDVerQkGYykpbRSGTeCph9"
X-Provags-ID: V03:K1:j3Anbu+DdhJHMfpPIYl5gjMSKY927G5yyDDwsUm6gsAvBRLGjwD
 kMLlo4LenvA6TAXO7mLmakPhIm55UeQezDpoMP8mQixlLfixVqT6m4YfNpPWsZnYdkJXUu3
 4bVGB4RlmBJVAsnTI2NBJ81YzXKdHqEm5SsqrCGOCTqx/OudP6WaOtjxmtRAcl3lG/yBZTW
 allX5mQliRW/QF/O8F5tg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fsn4iBt/sbQ=:E7VxMCnKFCXcA3pIlebqpq
 vAVsgcwq9iM4n5DJ5otiiXl1XvqRIgzLg/puTXhMvJT6h0jBv1nAQvFTYoVDwy+KuRvEVoboR
 vXwBGlUuXEHlJJlGW4HMhhX9vZ1fTZ8bhklNzDZqkXiJCO23byVIyrh4h4PRK1zMWVXLqk+ln
 uCLZn3gMcmARWGJPaO5suPvmSiqOcyVXrLniOdkAp7QJ3hdt3F4gP+ZlfzXCVQFLwAtzmIPOw
 Iana+n+zIYj/gMvE/qJy3x6DH6YMy3fQY7GyauPqTzoR6T3ETIHYvPJnxIzYId7f/Kn149WN6
 6aKmhUcjJxVMFm93EW3MEVd4ulqDo3yucX9VemmItWkjsmL0jv9KGUqqyVekJ/nee2lniIguB
 +5Xs3hpj/8JmTbYrmmGmQlqdTN9/HhpQ9HYkpTzJftYkzjtZLVwAeWaxRgXtasV4tqxy+d9oT
 xCabkIJipsWrhnwjeADS3b8Ncx9SsUkHluSJ5iMOQF45c6/N+/WCW+bCO9hlAtKIJWea8gimV
 pPjB5gswfOEc5xT+0GkSMDpwd4C7LUg7tGM5XfDHmRTlrora1x/eyomeBfTRwfSVwXFMXfJF9
 JgFksNXnFZZA2qwOrinBsaJYkRWv7Nbb+YUsop8lHFUWHqZpYQuxiHxlCdlyu2rq4CXHKgnY/
 xpOMtxS9Z1/dsoB/X6LaTJtv43FxChmRuRv3QUmSYtcRr2U0IwH+8RE/N1tUF5FtrpENvIfww
 bzi+0P1AjF2J9hVJC/wAwBiB8XgFdCYnFvSUggFrLyAIG7lBgmZsqV1xfNlgmjzA6lgvhvLd9
 Qb3cUnZoU6trFLUhrXPezQskO8PeuQz27q/VUI5bLxsRrIpKt7AnvgFxP2DeNMVD0ZEbLc0kF
 lRs33L/zNQc9jkLvlpeYViR+9tgMHQ9zt/WAzbjiHOZfu7+upKoZxFtAkBBA5dBgMVmj2QdBZ
 HM0o7gAS69aWUJe8/SjSa8rAoQqShg/0xOJjBxbYAZTBqK8HfRfv9n57G+C62mSjgeU3e9Hpi
 B1lO28nrFeU+gj5SAlRAXtffiH73y0Lbu766bOMGVseXezRL+aL7uTBcHUChQeEdeqYS00U7J
 9mrzmPmbEzxQCSBRjAS9A7W5lX1XwL9wxf9+JPoyaMU5NpdD6s0tKEXlB+anisqNHlMrJzTcR
 XuPChl6FxtZWfDtmjuxXywWQwOhxJTMEJhWA8FdxVM6MS2BmbVytuVdwtnqFJTBgfucZwpXV/
 nFooev66T6q4zps6M
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yzfnwMgYtLDWDVerQkGYykpbRSGTeCph9
Content-Type: multipart/mixed; boundary="yaBC2IPk3DMkH3yXNEzULknAS1J2sr2Ei"

--yaBC2IPk3DMkH3yXNEzULknAS1J2sr2Ei
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/9 =E4=B8=8B=E5=8D=882:00, Luciano Coelho wrote:
> Hi,
>=20
> On Sun, 2019-09-08 at 06:45 +0800, Qu Wenruo wrote:
>> Hi,
>>
[...]
>>
>> Any ideas how this could happen to 3 different intel cards on two
>> different systems? (Although all running the same Arch kernel and late=
st
>> firmware)
>=20
> This really must be an environment issue.  You are describing the same
> problem with different NICs (which mean different FWs are being used)
> and the same problem on Windows (which means different driver version
> being used), so it's not a new bug in either the firmware or the
> driver.

You're completely right. I have reset and upgraded my router (an MT7621
based router with OpenWRT) to latest OpenWRT, then the problem just went
away.

It looks like, under the original environment, it's the Android phone
doing something strange.

>=20
> Was it working properly before? Did it start happening only when you
> changed the NIC (even though you changed it back and it remained not
> working)? What else changed?

Nothing really, so I may hit something wrong with the NIC of the router,
not all these NICs.

>=20
> I can't see anything hinting any issues in dmesg.  Also, I'm a bit
> confused about the "5G" you mention.  Does that mean that the AP is
> connected to the internet via 5G?

Sorry for the confusion, I mean 5Ghz.

All tests are done in 5GHz freq (802.11ac), and iperf server is
connected by RJ45 (1Gbps) and iperf client is through wifi.

Anyway, after resetting the router, it's now back to the ~300 mpbs range.=


Thanks,
Qu

>=20
> --
> Cheers,
> Luca.
>=20


--yaBC2IPk3DMkH3yXNEzULknAS1J2sr2Ei--

--yzfnwMgYtLDWDVerQkGYykpbRSGTeCph9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl117IQACgkQwj2R86El
/qhi5wf+JDeztVmIG0sfSjA5YWdUKwztdgq78OXYTlCnuxkywjJXdn5yCOlvHS3H
ZwBfPwgaoH2ozm+w6JJRDJGn5QSIk8c3VaVsXJkE8EPsm7gJvlF7O0zxdNTUQvy1
8JYbiJNug1XhkfnPge7ylBwMqQ7tJ1P4mjXCtBXgAnG28biK3JDtLa90ziqfYUuR
EjryjsZd3tbspGr0e8g3lvlrHTvttBoZ8DdvrSFG0e0sLVK8JJCHJoCr2WGVxISz
trmzO9zm7BL8cTQxi6WrNBnGbYdbHFbMuqiupl28cQ+uh98wCSFZDIrYIoAZdKdL
+jH1eeVMR/Kr7eMXn/rloY6JwXxxRQ==
=Q08r
-----END PGP SIGNATURE-----

--yzfnwMgYtLDWDVerQkGYykpbRSGTeCph9--

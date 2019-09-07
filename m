Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00369AC9BA
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 00:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfIGWpa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Sep 2019 18:45:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:58315 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfIGWpa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Sep 2019 18:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567896321;
        bh=4lXI7mpOD8zVmTmtFm0u3CfzyV2aXBi9k00W0xTME8o=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=jjJkviBW3vW4MJln/sy2UHp2HvopHoH1y/93vaEllLS9zh7QuFDIlv1fnNReg2IzK
         oNBEZ30321Q2h6Vd38/DE6+wlx8OKIZaIn2yKOT6+f2WHLhOG+Q21EfGIxbiWRFy0R
         +x4AD9uDiEyQ23gwsFqBGLydm8y1Kc7zxb/TD8s8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M0LtB-1iPvP2017N-00uYHB; Sun, 08
 Sep 2019 00:45:21 +0200
To:     linuxwifi@intel.com,
        linux-wireless <linux-wireless@vger.kernel.org>
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
Subject: Slow performance (~30mbps) with Intel 9260 (and 8265, 3168) using 5G
Message-ID: <c078f515-51bd-2195-6b96-901db8872028@gmx.com>
Date:   Sun, 8 Sep 2019 06:45:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p0O42tIYRPwAAth2rgBH57Zz7yzaHZBdv"
X-Provags-ID: V03:K1:0LCM4roEYBMogqzTivF16va/9q6Oc4OK2rPNfedoBLP/mLjxMfb
 Ij5p30zLNvGU0MaP7oY53xJSsMROkxDeYPzVfJwLKltf79DJycMngxQEyiqzjdHg0O2dAPY
 SmCpuRvXVmBZmWDJr+N7hoeMd2/bpl6OOxRh2VBOYSkZjbBkKVpShuj5f2VY4lYEik/VclY
 qVrfWuRYgtQkh2NY3+FgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uxfawLsfVso=:2PZaYQRYISaI2B1CtzoxtP
 jB5KSVsvfaddCSdIm/rV35o65vfD/nCal54oSg8sHQ7qhH/g4tfnPBZAUj3Dzmf2HvyAfXuSy
 UdewW5o08bK8l997BMWIBIjro+jGubgoLlD9CVGoWEcchR3nW9BLbn/lAaX5byglUp5UbllFe
 pUfBcE94nnLcDQFJlyjbqD0gQxyWXblg4SOYLTvf+PWKKf+AX/Zs4D8ZV6MuKlAD/BGmVTfaW
 PSZrDuQnlFQ5VEejpvctYJ9/WMcsnaUFdan2bMP2NO8z/O150JIsmM+yMxkg5aGPeoJuqsGrZ
 LOi7rPpIdxseoQUUKLGx4+sIKTKL+KuF2EFKbjGUTJEa3EWeQsye+aa197yIndBD7DLHW24BG
 AetSX8Jvaw7GydQizbbuEGl5VZhdfJzDkNpwv675ElJolgYKO3SNsGpGbFtmr7099osEjcJZh
 zx+pYrT2vJyHz/vZV02AXZLaPU6cB8dCsqR7e0YcyYAwXnqxcMh2taBCI52dqek36ag4gui47
 UoSmFBBME6/ZMynBPvaMssvB5BoHI6slVipxbPo76BdQ9mNNucUl0jO+512OWwok7z0F5HEoG
 FsV4wVnPWf+xp+bhfXdcjkWomGMrgPvJuXNvxW7KvqR92aDS0CxPCS1H7Wzy5eWamovMO+TL8
 cviTJ3yAJVDv7RPsu+vYeaaTym/qW4PAx8lad6Tje1g2DC78Mo22GVAqRl3HrwvWcTVggi2fi
 rkcGJeykMemcIsPToMDGN0pmS0DLNSLIz9e7VJD1CVkY4DKhRSKGnWphzB/nACqPw6Rs7UL4K
 RyA7Ol8eZ1Ixf9FMm1Z62a9Q5RpchH8q9LFnEoDbAHupcwAdsaE15cmwJMEq2T7G3ft6V2kP+
 W4ly5VoKHL9x+zn/RMlYBICpt38cnJg6LoKNPxvqFoxYxu/q+H9EHW5VZYnXCUzlzTbGxe8sA
 4OLdzb6GlomzFzdqRDNwSRL51W0Rf37DsfdZzh0VW/lBAfo1QZGy2WQLPHJs/y5sbUfEIq8Ig
 n7JaXKb3iP249lInVclSB9YIog+a2o5WvNEODFQFGgq6fQYuSWQR0plM2YK5cXp6DtmKq22jw
 +h7y9KkdcNamQKMf0Mk/7ENSxMP6nI9tebUXioMxC903e6jSwYZ2PwFZNxj7b9UF740kmBehV
 z5EMabteT4VNnhGicwcroCeu04SdM13nMnz7nawa7MNhsNvX9q+GUMJIgdaSFPMLUswp2OL94
 +4A3kByLZjiTP9Uo8
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p0O42tIYRPwAAth2rgBH57Zz7yzaHZBdv
Content-Type: multipart/mixed; boundary="YpyZWlzSilrNyNS5jdk3WJNSrIkaZwcAd"

--YpyZWlzSilrNyNS5jdk3WJNSrIkaZwcAd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Recent upgraded my wifi adapter from 8265 to 9260 of my ThinkPad X1C 6th
gen.

However the initial test is producing some unacceptable results:

Furthermore, my desktop (intel 3168), and the original 8265 of my laptop
also reproduce the same result.
Kernels are the same 5.2.11-arch1-1-ARCH across my laptop and desktop.
Tried lts (4.19) on my laptop, the same result.
Even under Windows, it's all the same.

[  5] local 240e:3a1:c40:6c0::278 port 43334 connected to
240e:3a1:c40:6c0::16b port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  4.95 MBytes  41.5 Mbits/sec    0    219 KBytes

[  5]   1.00-2.00   sec  2.44 MBytes  20.5 Mbits/sec    0    248 KBytes

[  5]   2.00-3.00   sec  1.58 MBytes  13.3 Mbits/sec    1   1.39 KBytes

[  5]   3.00-4.00   sec  1.10 MBytes  9.21 Mbits/sec   44    194 KBytes

[  5]   4.00-5.00   sec  4.39 MBytes  36.8 Mbits/sec    0    226 KBytes

[  5]   5.00-6.00   sec  4.39 MBytes  36.8 Mbits/sec    0    247 KBytes

[  5]   6.00-7.00   sec  4.39 MBytes  36.8 Mbits/sec    0    257 KBytes

[  5]   7.00-8.00   sec  4.57 MBytes  38.3 Mbits/sec    0    259 KBytes

[  5]   8.00-9.00   sec  3.84 MBytes  32.2 Mbits/sec    0    259 KBytes

[  5]   9.00-10.00  sec  4.39 MBytes  36.8 Mbits/sec    0    261 KBytes

- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  36.0 MBytes  30.2 Mbits/sec   45             sen=
der
[  5]   0.00-10.02  sec  34.9 MBytes  29.2 Mbits/sec
receiver

Yep, less than 40mbps using 5G.
While I can even feel obvious lag when using ssh, some quick keystroke
will easily cause a lag.

I though it's the Linux support causing problem (even I'm using Arch
with 5.2 kernel) for the newer 9260 card, then I switched back to 8265.
But the same problem still exists!!
What makes things even stranger, under Windows, it's all the same result.=


To exclude the problem of the AP, my android phone can easily get over
200mbps through the same AP.

Furthermore, I tested my desktop which has an Intel 3168 card, and to my
surprise, it's the same result less than 40mbps.


Although it doesn't really hurt as both my desktop and laptop is mostly
connected through ethernet, it still doesn't make sense to me.

Here is the dmesg of my laptop. (Please ignore the perf buffer warning,
as I also tried to trace iwlwifi:* and iwlwifi_msg:* events)
https://paste.fedoraproject.org/paste/d5TO6kvbBOwQ~tkLgDbXsQ/raw

The iw list output:
https://paste.fedoraproject.org/paste/QKIOLyItCLcwTJoan8Wd3g/raw


Any ideas how this could happen to 3 different intel cards on two
different systems? (Although all running the same Arch kernel and latest
firmware)

Thanks,
Qu


--YpyZWlzSilrNyNS5jdk3WJNSrIkaZwcAd--

--p0O42tIYRPwAAth2rgBH57Zz7yzaHZBdv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl10Mv0ACgkQwj2R86El
/qhzhAgAj26cpa48bUL5MjqTalEVGPgZDD7hLOUyOiwJe0kw4RrReRd5G4Fokyyl
hXPqG02KeSfSTZCC7cTMFiHVbb/BX7yI7GouaMoR/z/X1EvbTSSnDGpncbUC1NrT
G4a/XD1MCdDo0CF9cIb0Wx6je7meRi5EyzAiE1WWBmxrn4ARTgOMhaRq5SS8Zsjk
bgUQcG+pMl6Otp0a3Nlj0WSbQdIcj3jni4HB7KUX3ubmiQMus9on0/c86jphSi70
3fjwII6E8RIFsnb7w/Iv5dGV+hYwjx3h7g4NuxzuOrFEr7dVvN+jPGlokLhyHWYc
AnhtNYZToi1Um1yQ7ob2u8WLA5zGoA==
=28EL
-----END PGP SIGNATURE-----

--p0O42tIYRPwAAth2rgBH57Zz7yzaHZBdv--

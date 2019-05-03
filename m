Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26313259
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 18:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfECQlG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 12:41:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54150 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726719AbfECQlF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 12:41:05 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hMbF8-0000go-52; Fri, 03 May 2019 19:41:02 +0300
Message-ID: <76e0ec375091a0b0f16d3cd9b15abc7b1840e89d.camel@coelho.fi>
Subject: pull request: iwlwifi firmware updates 2019-05-03
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>
Date:   Fri, 03 May 2019 19:40:59 +0300
References: <1546157106.3213.3.camel@intel.com>
In-Reply-To: <1546157106.3213.3.camel@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-VGeJXWaL+5YeP7W2r2pb"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-VGeJXWaL+5YeP7W2r2pb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some new versions of firmwares for the 9000 series of
devices and the firmware for a new device, namely 22260.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit 92e17d0dd2437140fab044ae62baf69b35d7d1fa=
:

  amdgpu: update vega20 to the latest 19.10 firmware (2019-05-02 06:24:19 -=
0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2019-05-03

for you to fetch changes up to 95a93535b723085ff74845eb8733d01c8ff5c052:

  iwlwifi: update -46 firmwares for 22260 and 9000 series (2019-05-03 19:33=
:53 +0300)

----------------------------------------------------------------
updates for -46.ucode for 9260, 9000 and 22260

----------------------------------------------------------------
Luca Coelho (3):
      iwlwifi: add -46.ucode firmwares for 9000 series
      iwlwifi: add firmware for 22260 and update 9000 series -46 firmwares
      iwlwifi: update -46 firmwares for 22260 and 9000 series

 WHENCE                            |   9 +++++++++
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 0 -> 1448644 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 0 -> 1456088 bytes
 iwlwifi-cc-a0-46.ucode            | Bin 0 -> 1044072 bytes
 4 files changed, 9 insertions(+)
 create mode 100644 iwlwifi-9000-pu-b0-jf-b0-46.ucode
 create mode 100644 iwlwifi-9260-th-b0-jf-b0-46.ucode
 create mode 100644 iwlwifi-cc-a0-46.ucode

--=-VGeJXWaL+5YeP7W2r2pb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAlzMbxsACgkQoUecoho8
xfpOJRAAnoaP2M6KhwyHgTkaBQbogPk5d5SW/IkyTp24C01Rx84a6sfLfsraSZTp
v+PrYWJ59sD5ZFeenhNAldwvPE7Eo5q2RYSeZKrP0LfjcFYBOpviuPj8GkxO3yD/
MJQO7StUU8ehQz4zDyoZnwcgpNvnHVFrAfjFVuKW+Dy4WdAAfov73u53eI2a4FLZ
FyRv724Yn5pPfKNSEhxZrmQx7AgoMw2nE6JZEn83gCu5spQDxUHiNuqLpeGsT7A9
ksSDpr0Qwpi8wmc3rm+zmW8JpT2KsvPbDAZbLYxF3WZKG3w5cMLX4iPbATLiA/2R
55GH/2bwrauXswzsWVEtrUKuyl60Ym1VE61DYCvmFQxSg+N1sDCsEVRCOxQBmuuK
HqQaLNsu4WOh8WLUC9tAsYeEaw6rBYyXGvxWtl1dOwtXxnKayMw6lYG8P6wQR8ZM
UOQ9/QKlKh7RMYpHoAFv6ev+WW0hA0h+dWEIysd6Vu/N+6HCd2dC72e4ykurAX1F
8aIhWo+AxpDFK3q8dnZEDSdokupWzlu1k5KBGd1JWdchgAbTXJlL7ZExS565j9zZ
6bo7UWbaTNz+ye3h1xN1Ch6a0ptoT/fTWl9L+s1BOozLzG5rewmwJARYXoGuKzOO
mIVZ6cRIOvo+4stWdw62zJSLVvOJO4+1rM3YaGRjjxqnDtY6c9Q=
=eQ21
-----END PGP SIGNATURE-----

--=-VGeJXWaL+5YeP7W2r2pb--


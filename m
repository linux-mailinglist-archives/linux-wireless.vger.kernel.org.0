Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEA8159DA6
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2020 00:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgBKXsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 18:48:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:29089 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgBKXsK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 18:48:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 15:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="asc'?scan'208";a="233621554"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.74])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2020 15:48:09 -0800
Message-ID: <43c9336e1c0c23e374420586868052e947b75126.camel@intel.com>
Subject: Re: [PATCH 20/28] drivers: net: Call cpu_latency_qos_*() instead of
 pm_qos_*()
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        intel-wired-lan@lists.osuosl.org,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Date:   Tue, 11 Feb 2020 15:48:09 -0800
In-Reply-To: <10624145.o336LLEsho@kreacher>
References: <1654227.8mz0SueHsU@kreacher> <10624145.o336LLEsho@kreacher>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GaZoanpPv4L3uFpFpUoG"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-GaZoanpPv4L3uFpFpUoG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-12 at 00:24 +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Call cpu_latency_qos_add/update/remove_request() instead of
> pm_qos_add/update/remove_request(), respectively, because the
> latter are going to be dropped.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com

For the e1000e changes

> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c   | 13 ++++++-------
>  drivers/net/wireless/ath/ath10k/core.c       |  4 ++--
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c | 10 +++++-----
>  3 files changed, 13 insertions(+), 14 deletions(-)


--=-GaZoanpPv4L3uFpFpUoG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAl5DPTkACgkQ5W/vlVpL
7c4a3g//SCBWhCZ3vnz6qb26ASH5pK5fgz/l9o0FmD/sOn6jHfXbGmD3C8zTo6ic
j1pQ488wAXMKm+Ay6CNyy3tqC3l9Lg1GKu6wQ4R/evm7cCk38Mwg7+sHa5aNdjwo
6+KmMvHD9aY3Ya+QzsrJg5ZztvW/CWP69SJ1J2JfM9a401S0Us5MX/O2WmdyYo/9
nXRGTYYj3Aekg1Ghs2JdWkYyiPGUDTic1R8psB8I7rDHZV5zmrrBferSMz8jB9Gk
ReQE43h5rF0CZKQevMws/J6gO2Ndfbre5BZoXA7wydzs4kkV2O98u0aTc/HBP16l
q8vf//TZ0cJy+rTEexxKIlWsfdIKQbYsWIenY6GEjR7W0n/chJYQZw40wGODisMd
Et4ZZwL7fVpWxLxVtSrhlAieD2RpAYyCYl6l9s46lcmHSf59kbx1EyN/EmwrpEIn
N9wCiCX9s1Nj4kH1CQAdTXhK8InLFKxKdApKSbACTwXyKuxMB/Pk65fbh4BVGTGo
kX0PZgKNIFo4+YvZZUwin+rioyBGQopgfbgy5z4StXQ2Rd0jEpwrMIu0mxXy39PG
X9A0+gUBAlsWDr+Jv8NCXpw5Q74vbSzHuUZwi4wpDbwnjqb6WO2yXv9mJXJCgR+b
xJA8RDrjt9XmBr4zk43EzPZqqPlp5w2oiPH3e7cJ84sDSG7H9Sc=
=6ivJ
-----END PGP SIGNATURE-----

--=-GaZoanpPv4L3uFpFpUoG--


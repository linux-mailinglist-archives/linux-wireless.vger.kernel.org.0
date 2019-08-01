Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274357DD89
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfHAONZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 10:13:25 -0400
Received: from backus.hahnjo.de ([193.30.122.186]:35150 "EHLO mail.hahnjo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbfHAONY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 10:13:24 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 10:13:23 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.hahnjo.de (Postfix) with ESMTP id 096B7170757F;
        Thu,  1 Aug 2019 16:07:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hahnjo.de; s=default;
        t=1564668476; bh=PvD55/uGxmNxFR8+EGAZs/3WYfxYDRjZsOgNEg2pGhA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=W7c3T2ZKz8KhneqoRXhumOLgkyH73AtnZNVvfzwVqpfuNC3oIPk9tF9fI0AolYCwy
         OXioDOSREBfp+SHCQZciusiLqmzcYD+9MpMoHFawR3l+33FPffkQ/9hRRhcuK9GvE6
         38r4TUZMZtu9wO03F6pa6a7op3wqVLC9QhPsH4wKd5YpiC5XRu/QkRyxM558/NG8qE
         6Ib97sSNeH81hbHOxosB44G4EYDxrt0CqvxRLttLISc/gwgTU6HRnMr9h6O+K1+Mif
         s1P9UbHUCIjGmsIKmG+fm29ObmCtnnCvUi8D4xjCsva068LNmaLGQMYm2co3fIL094
         hc9PruzMOTziQ==
Received: from Jonas-Dell ([2001:4dd7:9682:0:105e:6635:4119:b62b])
        by localhost with ESMTPSA
        id MIhiOzvyQl3SWAAA0J78UA
        (envelope-from <hahnjo@hahnjo.de>); Thu, 01 Aug 2019 16:07:55 +0200
Message-ID: <8402552457c387269d3e535b5f2ef42159e17f91.camel@hahnjo.de>
Subject: Re: [PATCH 16/16] iwlwifi: mvm: fix version check for
 GEO_TX_POWER_LIMIT support
From:   Jonas Hahnfeld <hahnjo@hahnjo.de>
To:     Luca Coelho <luca@coelho.fi>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Thu, 01 Aug 2019 16:07:50 +0200
In-Reply-To: <20190720102545.5952-17-luca@coelho.fi>
References: <20190720102545.5952-1-luca@coelho.fi>
         <20190720102545.5952-17-luca@coelho.fi>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ns1MWpmaQ1noJytFZ6wh"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-ns1MWpmaQ1noJytFZ6wh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Samstag, den 20.07.2019, 13:25 +0300 schrieb Luca Coelho:
> From: Luca Coelho <
> luciano.coelho@intel.com
> >
>=20
> We erroneously added a check for FW API version 41 before sending
> GEO_TX_POWER_LIMIT, but this was already implemented in version 38.
> Additionally, it was cherry-picked to older versions, namely 17, 26
> and 29, so check for those as well.
>=20
> Signed-off-by: Luca Coelho <
> luciano.coelho@intel.com
> >
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wi=
reless/intel/iwlwifi/mvm/fw.c
> index a837cf40afde..00c89bcfdf6a 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -886,9 +886,14 @@ static bool iwl_mvm_sar_geo_support(struct iwl_mvm *=
mvm)
>  	 * The GEO_TX_POWER_LIMIT command is not supported on earlier
>  	 * firmware versions.  Unfortunately, we don't have a TLV API
>  	 * flag to rely on, so rely on the major version which is in
> -	 * the first byte of ucode_ver.
> +	 * the first byte of ucode_ver.  This was implemented
> +	 * initially on version 38 and then backported to 36, 29 and
> +	 * 17.
>  	 */
> -	return IWL_UCODE_SERIAL(mvm->fw->ucode_ver) >=3D 41;
> +	return IWL_UCODE_SERIAL(mvm->fw->ucode_ver) >=3D 38 ||
> +	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) =3D=3D 36 ||
> +	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) =3D=3D 29 ||
> +	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) =3D=3D 17;
>  }
> =20
>  int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)

After pulling iwlwifi-fixes-for-kvalo-2019-07-30, I still get firmware
crashes on my "Intel(R) Dual Band Wireless AC 8260" which uses firmware
version 36. I tried the latest ucode in linux-firmware (36.77d01142.0),
but it seems GEO_TX_POWER_LIMIT is not yet implemented there.

Could you let me know which firmware version I need for Linux 5.3? Can
there be a check in iwl_mvm_sar_geo_support() that the backported
support is indeed available?

Thanks,
Jonas

--=-ns1MWpmaQ1noJytFZ6wh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEXw/5YGpL6H9VOgO2kcnDPSxhrNsFAl1C8jYACgkQkcnDPSxh
rNv4DAf+ImRyqgeZWiFpvdwkej6YmIW7PVOfwpLYfXi5sRJxKzWBdklDHdOZuLHV
9yY6JZmIPMP8U6oyTcnC8loMMIW8pI4kCIu+Qm7tNSsm3C1hmS4QXrO5y7kxtP2p
TmqWmvet6oN/XLpLunW6sDLh49eiYcUgf70e/gTW5nWLKYrpkez/Rhs2oiFEcLwk
hlgX2RUYao/fMe3m07o6wpaLYwqPf9PMU4AUegdZfT7XRPwChphDJMoklmNDaOpA
vVYp41M248n04mZtkjKe45xdULo/JDofynP221S6Kgun5S2tFZRufPr0XG275lIp
Z1V1xSi8pclymNdKwtrL2mGYk7DwuA==
=nI1E
-----END PGP SIGNATURE-----

--=-ns1MWpmaQ1noJytFZ6wh--


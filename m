Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA76D62CEA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 02:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGIAJ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jul 2019 20:09:56 -0400
Received: from ozlabs.org ([203.11.71.1]:49405 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfGIAJ4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jul 2019 20:09:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jN3z64BRz9sN4;
        Tue,  9 Jul 2019 10:09:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562630993;
        bh=xPxcJ6P8tH+jIDo5QQqs5SnjvwOcFQh+59wbcITTAo4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AUWGCqdKj+yAIR/UDkXE08ZG8Oc6Xf8XGav5V6fKXtDhAYma1jgwbNMj/Dp0TByx6
         QYAqYCLstk+wCUVwnT43LOAkAJVbdQT8Dinvr+9bNw9TALU28N82cKiRHS+LyIKqE5
         4twmFJgRaCqxkFB5B8rDB8DXSBiZJjCsR++CZ4Dec15e4B2mTA2M62pxLNsdF3/Y4N
         +d3/jwOuF1G+BccqHwaFTvQAwdRjAgRbLXlvMcbCsaFsEiIW5VlPqABAJD+CYDwNJr
         9CiIEnLGnDJ+SmJAbhozAeRIbyQevYPJTZs6nKmF/iG1kaP937DLNhSbBp4dd1nn6+
         oCGGjmLq0A4Jg==
Date:   Tue, 9 Jul 2019 10:09:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20190709100951.38b3402e@canb.auug.org.au>
In-Reply-To: <20190625160432.533aa140@canb.auug.org.au>
References: <20190625160432.533aa140@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_s7id3wA3S_Z2qmdsjD1SRW"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/_s7id3wA3S_Z2qmdsjD1SRW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 25 Jun 2019 16:04:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> drivers/net/wireless/intersil/p54/txrx.c: In function 'p54_rx_data':
> drivers/net/wireless/intersil/p54/txrx.c:386:28: error: implicit declarat=
ion of function 'ktime_get_boot_ns'; did you mean 'ktime_get_raw_ns'? [-Wer=
ror=3Dimplicit-function-declaration]
>    rx_status->boottime_ns =3D ktime_get_boot_ns();
>                             ^~~~~~~~~~~~~~~~~
>                             ktime_get_raw_ns
>=20
> Caused by commit
>=20
>   c11c75ec784e ("p54: Support boottime in scan results")
>=20
> from the wireless-drivers-next tree interacting with commit
>=20
>   9285ec4c8b61 ("timekeeping: Use proper clock specifier names in functio=
ns")
>=20
> from the tip tree.
>=20
> I have added the following merge fix patch:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 25 Jun 2019 15:55:36 +1000
> Subject: [PATCH] p54: fix up for ktime_get_boot_ns() name change
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/wireless/intersil/p54/txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wirel=
ess/intersil/p54/txrx.c
> index be6968454282..873fea59894f 100644
> --- a/drivers/net/wireless/intersil/p54/txrx.c
> +++ b/drivers/net/wireless/intersil/p54/txrx.c
> @@ -383,7 +383,7 @@ static int p54_rx_data(struct p54_common *priv, struc=
t sk_buff *skb)
> =20
>  	fc =3D ((struct ieee80211_hdr *)skb->data)->frame_control;
>  	if (ieee80211_is_probe_resp(fc) || ieee80211_is_beacon(fc))
> -		rx_status->boottime_ns =3D ktime_get_boot_ns();
> +		rx_status->boottime_ns =3D ktime_get_boottime_ns();
> =20
>  	if (unlikely(priv->hw->conf.flags & IEEE80211_CONF_PS))
>  		p54_pspoll_workaround(priv, skb);
> --=20
> 2.20.1

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/_s7id3wA3S_Z2qmdsjD1SRW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j208ACgkQAVBC80lX
0Gw7ZQf+KEDciOXpR5S/in68ldPfTLfZlj77Ng5gIcSC63tKqknTJ19RIFi65bKi
cwI9Jrg3f//cnwv7ZS2c/jPkQhJm+A2imbXovB4SAxiviNRnNROIFXFsjzK5CWLH
1sNpFYj3FhW1cVCw8Z8hW0c9d9ztTwsR4Bm0eOex7QxoZXsmutI8Ke9HHE0Mv3Kx
PDtSWz9/OHoDO91C3WXXUEoWCRcT3fnwYm+Z5UxkhDq3VD2Vni6iyDLulvXpLX+q
7xas7YnR0zJN8DDiNNgWHavdVoU2Xg0/t1h55Oqyp+qEKJWxWb8ibNMVJ9Mqox31
p772Anjel8BIM6YH/iWZkKLmP8mD6w==
=eSGL
-----END PGP SIGNATURE-----

--Sig_/_s7id3wA3S_Z2qmdsjD1SRW--

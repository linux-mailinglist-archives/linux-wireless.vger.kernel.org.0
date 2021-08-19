Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8BE3F1CB4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbhHSP2T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238643AbhHSP2S (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:28:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B545D6101A;
        Thu, 19 Aug 2021 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629386862;
        bh=Xop4c49vcx4vurHfQJu8rNJT2PZCKPSm8sGMUaLTugc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHaWTiiPBSijYUXzpIc5xQc7MU7KpOonkbN0ajOSM779Amxdm2sbkbC9WYgXn1VQ9
         hFz+KxjH6yrQ37VIJh5r592mCsDb2dBZUED7/2739m4rAzc1lJ2o6YihwoBYDwxp9N
         3gPY4VL853poiFPgGf0vMPzMCfrHJ8M3zIQ+hJBPqjwjtuhSZRQWSB+qYc/6O+B4Yi
         vycJB4iPVadDWtpVez+xOZejUfhact0ahw2JKOUPaHVgOixRbqD4UOsDAGJZpZkdVB
         U1DUQSVeCbLg9vznid7OvRondz+2fmc+tAIANWljO4Yhq8s/2gmfXJD88kVHJ4NwCP
         QDUEEMi8HGz5Q==
Date:   Thu, 19 Aug 2021 17:27:37 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        Deren.Wu@mediatek.com
Subject: Re: [PATCH 3/5] mt76: mt7921: report tx rate directly from tx status
Message-ID: <YR54aQ2Rih62lZYj@lore-desk>
References: <cover.1629277624.git.lorenzo@kernel.org>
 <1aa7b946cac8bb1c3d3ad3eaa41a7c610d122d92.1629277624.git.lorenzo@kernel.org>
 <87a6ldbi20.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XjC+AgyjIn/rinKE"
Content-Disposition: inline
In-Reply-To: <87a6ldbi20.fsf@tynnyri.adurom.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--XjC+AgyjIn/rinKE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 19, Kalle Valo wrote:
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Report tx rate from tx status packets instead of receiving periodic mcu
> > event. This improves flexibility, accuracy and AQL performance, and
> > simplifies code flow for better readability.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> [...]
>=20
> > +		/* We don't support reading GI info from txs packets.
> > +		 * For accurate tx status reporting and AQL improvement,
> > +		 * we need to make sure that flags match so polling GI
> > +		 * from per-sta counters directly.
> > +		 */
> > +		rate =3D &msta->wcid.rate;
> > +		addr =3D MT_WTBL_LMAC_OFFS(idx, 0) + 7 * 4;
>=20
> Magic values.

ack, I reused what was already in mt7921_mac_sta_poll(), but I can add some
definitions :)

>=20
> > +		val =3D mt76_rr(dev, addr);
> > +
> > +		switch (rate->bw) {
> > +		case RATE_INFO_BW_160:
> > +			bw =3D IEEE80211_STA_RX_BW_160;
> > +			break;
> > +		case RATE_INFO_BW_80:
> > +			bw =3D IEEE80211_STA_RX_BW_80;
> > +			break;
> > +		case RATE_INFO_BW_40:
> > +			bw =3D IEEE80211_STA_RX_BW_40;
> > +			break;
> > +		default:
> > +			bw =3D IEEE80211_STA_RX_BW_20;
> > +			break;
> > +		}
> > +
> > +		if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
> > +			u8 offs =3D 24 + 2 * bw;
> > +
> > +			rate->he_gi =3D (val & (0x3 << offs)) >> offs;
>=20
> Ditto.

same here, I just reused the code from mt7915, I will fix it.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--XjC+AgyjIn/rinKE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYR54ZQAKCRA6cBh0uS2t
rAGMAP0SDrQcyfqMU+Q4RaQkQ6wfXdZbjnfiFDnD5fFLk+wyDAEAwEtRa1zAGf2D
YRRVzgMKEIuvcC/uyrCWOrGD6fXSJQg=
=0DAG
-----END PGP SIGNATURE-----

--XjC+AgyjIn/rinKE--

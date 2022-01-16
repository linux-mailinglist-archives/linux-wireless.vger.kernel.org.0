Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B42148FEED
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 21:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiAPU6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 15:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiAPU6t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 15:58:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598B1C061574
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 12:58:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE658B80D9C
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 20:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B09C36AE3;
        Sun, 16 Jan 2022 20:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642366726;
        bh=b8dQhnGnvWLP7U/MmPTUM1aIKqvPsaHrXfIFNfa0hoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlQKKkH6NjjUnTRWVWt7bTWutKIY48SQgfDgjTe7YItrIFYoWeajiGsVPSXtO2sm6
         LJhAwGW8rdPiuhZCs+2DgppgD+D4/oSQVbIgiQ9zc8hLOOFKm0iKxH3IJF/MsLdg9t
         kxe5nDJyJqVhTvpZITuHISAYNECfkr6H9JSFj4CX9OxdkFce4h9wN/3EkiaDHNc2Kh
         hCoOPaN5p2fS1/aZzyVMebzMDpyHqYPkPt7wR5Q49qwrnMtQ+YbFYuCMG2mklcBnCp
         0vkVvKhICyjo26gzsbMvx54wOO7K2i+GNaSvOKOapRB5u4U0doZY4rAFv94Sl632bt
         PsCQ88oK+ssmw==
Date:   Sun, 16 Jan 2022 21:58:42 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com
Subject: Re: [PATCH 4/5] mt76: connac: move he radiotap parsing in connac
 module
Message-ID: <YeSHAhI5HzjKsuKx@lore-desk>
References: <cover.1642336806.git.lorenzo@kernel.org>
 <dcd7e4a9f10b1f0c94050453e4de4e1443fbc642.1642336806.git.lorenzo@kernel.org>
 <5fdb8db1f02ffdacd554b7db531cf7719399cbdd.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B+lTE28PY6x2jOAV"
Content-Disposition: inline
In-Reply-To: <5fdb8db1f02ffdacd554b7db531cf7719399cbdd.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--B+lTE28PY6x2jOAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 2022-01-16 at 13:43 +0100, Lorenzo Bianconi wrote:
> > Move HE radiotap parsing code in mt76-connac module since it is
> > shared
> > between mt7921 and mt7915 drivers.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../net/wireless/mediatek/mt76/mt76_connac.h  |   2 +
> >  .../wireless/mediatek/mt76/mt76_connac_mac.c  | 168 ++++++++++++++++
> >  .../wireless/mediatek/mt76/mt76_connac_mac.h  |   4 +
> >  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 175 +---------------
> > -
>=20
> [...]
>=20
> > +mt76_connac_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32
> > *rxv)
> > +{
> > +	struct mt76_rx_status *status =3D (struct mt76_rx_status *)skb-
> > >cb;
> > +	static const struct ieee80211_radiotap_he_mu mu_known =3D {
> > +		.flags1 =3D HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
> > +			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
> > +			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
> > +			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN) |
> > +			  HE_BITS(MU_FLAGS1_SIG_B_COMP_KNOWN),
> > +		.flags2 =3D HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN) |
> > +			  HE_BITS(MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN),
>=20
> I think hardware doesn't report MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN and
> MU_FLAGS1_SIG_B_COMP_KNOWN. Should align mt7915 here.

ack, thx for point this out.
@Sean: can you please confirm it?

Regards,
Lorenzo

>=20
> Ryder
>=20

--B+lTE28PY6x2jOAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYeSHAgAKCRA6cBh0uS2t
rLzhAP9+kYBTz08W5sEWU2zfbv9MjHgHeV3ngm0b3I+cPrgbbAEA+UGECTGsIR78
o7vsXZTIAf0NbdCjvm8Iwi3nWRT0Lgg=
=Y8ZX
-----END PGP SIGNATURE-----

--B+lTE28PY6x2jOAV--

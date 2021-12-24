Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFAD47EDC8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 10:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352251AbhLXJaN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 04:30:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51474 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343794AbhLXJaN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 04:30:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DAFC62029
        for <linux-wireless@vger.kernel.org>; Fri, 24 Dec 2021 09:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00060C36AE5;
        Fri, 24 Dec 2021 09:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640338212;
        bh=hMd5fq8pI+RLWctT1qOsKOBNJ36WrtEsMxkPmx+St7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtIOTC5jBIx7oFXeUGrCbFqXLtANzjb3a+a8nbfH/pFKiB7QZmt6mXFRF6BUJv0wA
         SmhpkuuCgbq/BGqFzNAUWGn4qvFRUCcVMhIn3RjkcUxKHb87DqxO2us0iTTy2kXXk0
         akWYqU/ho0GSQQn5/WX2UxLi4gMQYnX+TaWjDdeAbsejU8YVTVDdRRaABNX0FqfhTl
         VkcPlB98JCyjoFm1GdO3IpeG41xzNV6ZLfrnOQECQWZKJxe2AiMD9yi+0Z0aQlvwte
         SLQ2tvoQsX7dooX8whCftsBSxZg9lU72zYJjuYARMnGoJ2iM/oyXKDSCba8/GGm3nN
         0GBwc0Ut9lHrw==
Date:   Fri, 24 Dec 2021 10:30:08 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/1] mt76: add mt7916 to set wlan_idx_hi
Message-ID: <YcWTIEGR7pz7+t5v@lore-desk>
References: <cover.1640175865.git.Bo.Jiao@mediatek.com>
 <5b82d68ee7c879591e22da51bfdb4af2e5fad228.1640175865.git.Bo.Jiao@mediatek.com>
 <YcTwP6Hu5VoTMHEq@lore-desk>
 <6d3a52918457d4fedf91a6a224cf35eaf940f22c.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tefrqXE5aXn843G5"
Content-Disposition: inline
In-Reply-To: <6d3a52918457d4fedf91a6a224cf35eaf940f22c.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--tefrqXE5aXn843G5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 2021-12-23 at 22:55 +0100, Lorenzo Bianconi wrote:
> > > From: Bo Jiao <Bo.Jiao@mediatek.com>
> > >=20
> > > since mt7916 support up to 544 wcid entries,
> > > add it to set wlan_idx_hi.
> > >=20
> > > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > > Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 5 +++++
> > >  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > > b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > > index e999d71..8701f04 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> > > @@ -110,6 +110,11 @@ static inline bool is_mt7915(struct mt76_dev
> > > *dev)
> > >  	return mt76_chip(dev) =3D=3D 0x7915;
> > >  }
> > > =20
> > > +static inline bool is_mt7916(struct mt76_dev *dev)
> > > +{
> > > +	return mt76_chip(dev) =3D=3D 0x7906;
> > > +}
> > > +
> > >  static inline u8 mt76_connac_chan_bw(struct cfg80211_chan_def
> > > *chandef)
> > >  {
> > >  	static const u8 width_to_bw[] =3D {
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > > b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > > index edad583..fc9a084 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > > @@ -1464,7 +1464,7 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev
> > > *dev, struct mt76_wcid *wcid,
> > >  {
> > >  	*wlan_idx_hi =3D 0;
> > > =20
> > > -	if (is_mt7921(dev) || is_mt7915(dev)) {
> > > +	if (is_mt7921(dev) || is_mt7915(dev) || is_mt7916(dev)) {
> > >  		*wlan_idx_lo =3D wcid ? to_wcid_lo(wcid->idx) : 0;
> > >  		*wlan_idx_hi =3D wcid ? to_wcid_hi(wcid->idx) : 0;
> >=20
> > I guess I have already included the fix here:
> >=20
> https://patchwork.kernel.org/project/linux-wireless/patch/df4d462f1ef4cfc=
1ae4f6482051a28a10c78262b.1640260901.git.lorenzo@kernel.org/
> >=20
> > Regards,
> > Lorenzo
> >=20
>=20
> I think we can fold these patches together and use !is_connac_v1
> instead so that we can avoid endless is_mtxxxx || ... || ...

yes, it is already in my tree and I will post it in the next series.
@Felix: can you please ignore this patch?

Regards,
Lorenzo

>=20
> Ryder
>=20
>=20

--tefrqXE5aXn843G5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYcWTIAAKCRA6cBh0uS2t
rJQeAP0UBrw+k2EUHpoTT9i6Ll/vZsmYLkbrn/aLr2t0yyftcAEA4A9k06Nc/+3L
k/szkWoofkrONcykvd7Q6Q/8ClTGTAQ=
=Wid9
-----END PGP SIGNATURE-----

--tefrqXE5aXn843G5--

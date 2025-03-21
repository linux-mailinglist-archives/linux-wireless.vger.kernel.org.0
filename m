Return-Path: <linux-wireless+bounces-20681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC301A6C107
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 18:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA3A3AD41A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD8822D791;
	Fri, 21 Mar 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdXmluXM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367D215078;
	Fri, 21 Mar 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577292; cv=none; b=eHPVfeJx+DH3HF/avIVXm+vXn0GR3Py1Mibw5sG+rkUd/0slB6YDON+yLLTV83/HVRFRkMjNTRuezS+G8+4BDzJxIqx9EIDbtwmpPMtLY7vwZBAzFzhklTkURheKGCK/WnNBTzK8zP4K1kJLGtfxeFkBr2fWOU/vBqSDrUbIGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577292; c=relaxed/simple;
	bh=OYwfK7dKSULJx6KrMxl2ffWMKsD8SMJMTT/g3BO9tfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Voq3uPwiEP5rsNmy3rwiHqQdesl9fVabyL6A6h7MBzLJCt9juUaC9svN2FqSOrgDAxDwobDiXSko+Twdf48nTJpAiAg4JE+acJA3kw3jfQNETDsMmY1H2xwhmQ6UqBU2i9w1m5GInhMSddEobumjxsP05tOs5AovkWJPpl4JPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdXmluXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35D6C4CEE3;
	Fri, 21 Mar 2025 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577292;
	bh=OYwfK7dKSULJx6KrMxl2ffWMKsD8SMJMTT/g3BO9tfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdXmluXMuygbFnEz+mBkQweEMG0/+5z3ZNK7ee7N3wDkUz6QUXFZNh7p1dpwwCNSZ
	 WFSakXag6CGQeK/dlUeUe0f3uLZdSip/vLRkgJViOqSO4D3HjWWajf/lqGqhnPVqYa
	 f+WwQk+NrALh6g73mQcQu9DGQ6i5RJYpV3gKq0Y3x/GbXFFVabAwNpXYKNHYs0X4do
	 pYLnLLYRcBlQ8JaPNzbl4hnWY24gJJCQIylSE7I1RetgJA04EeL+JExencinU/7XGS
	 npCtEojE2tVW0mzZ4gCH1J60clp6Ccfnhk1nJjCDpHCqKFaJy5f3EIyt6KgeP8bBXL
	 dPMwSNepnQ2VQ==
Date: Fri, 21 Mar 2025 18:14:49 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Qasim Ijaz <qasdev00@gmail.com>, nbd@nbd.name, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com, Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
Message-ID: <Z92eiVIFIUOFKXj_@lore-desk>
References: <20250320201914.48159-1-qasdev00@gmail.com>
 <46a714fb-8a14-4d24-a0a6-a22cc9d45768@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Im/5E5uh21z8mW9u"
Content-Disposition: inline
In-Reply-To: <46a714fb-8a14-4d24-a0a6-a22cc9d45768@stanley.mountain>


--Im/5E5uh21z8mW9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Mar 20, 2025 at 08:19:14PM +0000, Qasim Ijaz wrote:
> > If link_conf_dereference_protected() or mt7996_vif_link()=20
> > or link_sta_dereference_protected() fail the code jumps to
> > the error_unlink label and returns ret which is uninitialised.
> >=20
> > Fix this by setting err before jumping to error_unlink.
> >=20
> > Fixes: c7e4fc362443 ("wifi: mt76: mt7996: Update mt7996_mcu_add_sta to =
MLO support")
> > Fixes: dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in st=
a_add/sta_remove callbacks")
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers=
/net/wireless/mediatek/mt76/mt7996/main.c
> > index 91c64e3a0860..78f7f1fc867e 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > @@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, =
struct ieee80211_vif *vif,
> >  			continue;
>=20
> What about if the list is empty or we hit this continue on every link?

we will return 0 and I guess that's fine, agree?

Regards,
Lorenzo

>=20
> regards,
> dan carpenter
>=20
> > =20
> >  		link_conf =3D link_conf_dereference_protected(vif, link_id);
> > -		if (!link_conf)
> > +		if (!link_conf) {
> > +			err =3D -EINVAL;
> >  			goto error_unlink;
> > +		}
> > =20
> >  		link =3D mt7996_vif_link(dev, vif, link_id);
> > -		if (!link)
> > +		if (!link) {
> > +			err =3D -EINVAL;
> >  			goto error_unlink;
> > +		}
> > =20
> >  		link_sta =3D link_sta_dereference_protected(sta, link_id);
> > -		if (!link_sta)
> > +		if (!link_sta) {
> > +			err =3D -EINVAL
> >  			goto error_unlink;
> > +		}
> > =20
> >  		err =3D mt7996_mac_sta_init_link(dev, link_conf, link_sta, link,
> >  					       link_id);
> > --=20
> > 2.39.5
> >=20

--Im/5E5uh21z8mW9u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ92eiQAKCRA6cBh0uS2t
rC0WAP9lvbXpg7ssaJUu7lkS/J6GAy9WpU7XvuJ3Oqe5fwivTwD7BcCwlQlkn39X
EIghtzuMU7YZQNxndt3LZeIeBD46Pwo=
=+24y
-----END PGP SIGNATURE-----

--Im/5E5uh21z8mW9u--


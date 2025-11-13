Return-Path: <linux-wireless+bounces-28905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6FC5711E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 12:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DCDE4E53F3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B9733373C;
	Thu, 13 Nov 2025 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyS+VXkB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7142D0607;
	Thu, 13 Nov 2025 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031467; cv=none; b=WxjHEoWfPoOB4K0cskKPKN5b/Mlkx4eeOdH3Qgm4zZY29i7uzoKl/APpGcLWN1LtadT/+eWmDoqSrQVXs0SC5kV69CwqedevmQkkKkLcmUUPREfDyf/9fwBDRlKT02poDo/RCl/v9sswQ9aMyJReIaPuxRef/LzyoZEULZyD6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031467; c=relaxed/simple;
	bh=OMfFW1nnKw5k2mezbZUycTzr4g1sGGxhFbFHTc77Xdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtMiKuRT68MWf8PE5ESOCX7pUlXqkEJH4qHqNESpkB1wULTYW2PVjgwEFqwKwL9YsufB6omqUvFDOtAnejTnuK8xkE5NydGh6OuXnP0GHyAEtsNm90BiM7Xd9+Icb2sQZv/dQQ+qFU1r8+NaX732eKK6a9TgGTy88E5/5pZw9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyS+VXkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E90C19422;
	Thu, 13 Nov 2025 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031465;
	bh=OMfFW1nnKw5k2mezbZUycTzr4g1sGGxhFbFHTc77Xdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyS+VXkBGeRBeL5aBOjs4Sn+VEaE8YGlvkKK2hPFzt7EwSjw7KcbtxQVJ3iXn4ybL
	 wz9BbOzaNDw12FDRBwsGzz3aEM2VaycoDGFswsIVB9Qxw/CRx6NroC8NhBlKnVebQ0
	 WeSpZqhOwDJarwAc+UEFyNGVkIck1h75Vue3D/qw8nWTBWcNoOtNzw40HLySVKuP86
	 +my6QnYEhxrsArnkQjOOWBJaZ90wuoIypbYpfTIH9o6K/b97vTX0ujhlZtF4HnT8uf
	 u5IXhpTj20X16k4aTVjRilFqJ6qpyh3LrRLH9AFpeK2EU0znmDMOWiph3Badx6zl+C
	 Kjphjdzx0Bkwg==
Date: Thu, 13 Nov 2025 11:57:42 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: angelogioacchino.delregno@collabora.com, jianhao.xu@seu.edu.cn,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
	matthias.bgg@gmail.com, nbd@nbd.name, ryder.lee@mediatek.com,
	sean.wang@mediatek.com, shayne.chen@mediatek.com
Subject: Re: [PATCH net] mt76: mt7615: Fix memory leak in
 mt7615_mcu_wtbl_sta_add()
Message-ID: <aRW5phMmzul8wTn-@lore-desk>
References: <aRWF9QJuwGaDlUvT@lore-desk>
 <20251113094135.348383-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="39OyxfwhcaPPfO4y"
Content-Disposition: inline
In-Reply-To: <20251113094135.348383-1-zilin@seu.edu.cn>


--39OyxfwhcaPPfO4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Nov 13, 2025 at 08:17:09AM +0100, Lorenzo Bianconi wrote:
> > [-- Attachment #1: Type: text/plain, Size: 1475 bytes --]
> >=20
> > > In mt7615_mcu_wtbl_sta_add(), an skb sskb is allocated. If the
> > > subsequent call to mt76_connac_mcu_alloc_wtbl_req() fails, the functi=
on
> > > returns an error without freeing sskb, leading to a memory leak.
> > >=20
> > > Fix this by calling dev_kfree_skb() on sskb in the error handling path
> > > to ensure it is properly released.
> > >=20
> > > Fixes: 99c457d902cf9 ("mt76: mt7615: move mt7615_mcu_set_bmc to mt761=
5_mcu_ops")
> > > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/driver=
s/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > index 4064e193d4de..08ee2e861c4e 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > @@ -874,8 +874,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, =
struct ieee80211_vif *vif,
> > >  	wtbl_hdr =3D mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
> > >  						  WTBL_RESET_AND_SET, NULL,
> > >  						  &wskb);
> > > -	if (IS_ERR(wtbl_hdr))
> > > +	if (IS_ERR(wtbl_hdr)) {
> > > +		dev_kfree_skb(sskb);
> >=20
> > Hi Zilin,
> >=20
> > I can't see how this is useful since if mt76_connac_mcu_alloc_wtbl_req =
returns
> > an error, wskb will not be allocated.
> >=20
> > Regards,
> > Lorenzo
>=20
> Hi Lorenzo,
>=20
> Thanks for your review.
>=20
> You are correct that 'wskb' is not allocated in this error path.=20
> However, my patch is intended to free 'sskb', which was allocated=20
> earlier in the function. Without this change, 'sskb' is leaked if
> mt76_connac_mcu_alloc_wtbl_req() fails.
>=20
> This approach is similar to the error handling logic later in the
> function, where a failure in sending one skb results in the other one
> being freed.
>=20
> Hope this clarifies.

yes, right. I misread the code. I agree with the fix.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> > >  		return PTR_ERR(wtbl_hdr);
> > > +	}
> > > =20
> > >  	if (enable) {
> > >  		mt76_connac_mcu_wtbl_generic_tlv(&dev->mt76, wskb, vif, sta,
> > > --=20
> > > 2.34.1
> > >=20
>=20
> Best Regards,
> Zilin Guan

--39OyxfwhcaPPfO4y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaRW5pgAKCRA6cBh0uS2t
rMwDAP47wALgPmIE6tUjCgJFQCsffcrKOTD677lZaRxgFK1KiQEAgtoWFZ4Rph8X
FRyBF15dTBXErLYgBnyapoMTJ/x/gQw=
=IWEV
-----END PGP SIGNATURE-----

--39OyxfwhcaPPfO4y--


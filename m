Return-Path: <linux-wireless+bounces-20674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6A0A6BE98
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 16:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E668D189CC17
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE744A00;
	Fri, 21 Mar 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSsqN3XN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04A227E90
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572094; cv=none; b=F3m70Ae/ukGFJx+d+sEkn7fjTuskCDbZBABV236ADV55UxTPI/C+lrdPz73DQBRx07Ig/Fyk1Cqj36fVImUxLL51WqjG+dWmtoT13OCKFszHKN5auFb2EjnMMmEstZd1WYtocdy0kjryeW1aLsHKHWB8Sf8vld11ifXuHEcjrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572094; c=relaxed/simple;
	bh=DU5u7zzqxk8b3LOzHKAd92FrOH93E891MIYgL+Z1eac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAsEDJ2xW1KogUXQ8KOByWHHlVoOfBJ4sZCOprYtmYyapKoaRyk+TbJ3wmmaWl9+EwcMFGbJrlhfB5a1WzLR2PWEgMat0FkCV5Jv68+M1fGV6h/TELaItkO2ZEJhmVhybE7SM1l4xbzbDxI8PXqmO/xzVVX4I4c/zSmkM9foqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSsqN3XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533E5C4CEED;
	Fri, 21 Mar 2025 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742572093;
	bh=DU5u7zzqxk8b3LOzHKAd92FrOH93E891MIYgL+Z1eac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSsqN3XNrfb16zXuntT1jMfUhCBZLAQFG96m5MK28imTXVzybiRv/4Re31lgHRydo
	 Be6miDqEeyMPR+3K/T8q5nYmteXWy0B58FDtxuq4aoWoq5I/0YxG3K5EfL0/2FLHJO
	 2sbAHp5kldh3zjfs6/6mBZrdW93AFuJxUBAzYF6Qva0NV60gLPv/eRoU2WWZOeuzOY
	 aiFI03QCrDzuDTd/JJYLsZlBy39+QxTFUdMZhHlgIkfzMpslX3zNMkZ0WA2XfYoc+M
	 j6dcZFtdGqu1PhEj5NPoTZFy0l7KZU6BdvtYncqv8cnkrxNDocj/zLEdraJ6+Ek4K1
	 wZGMMkcjn94gQ==
Date: Fri, 21 Mar 2025 16:48:11 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [bug report] wifi: mt76: mt7996: Rely on mt7996_sta_link in
 sta_add/sta_remove callbacks
Message-ID: <Z92KO68zKlqKcF1W@lore-desk>
References: <f335328d-8554-401b-83c2-36e8d7668a62@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EHUAeOz4fd75awZd"
Content-Disposition: inline
In-Reply-To: <f335328d-8554-401b-83c2-36e8d7668a62@stanley.mountain>


--EHUAeOz4fd75awZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo Bianconi,

Hi Dan,

this issue is already fixed by the following patch:
https://lore.kernel.org/linux-wireless/20250320201914.48159-1-qasdev00@gmai=
l.com/T/#u

Regards,
Lorenzo

>=20
> Commit dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in
> sta_add/sta_remove callbacks") from Mar 11, 2025 (linux-next), leads
> to the following Smatch static checker warning:
>=20
> 	drivers/net/wireless/mediatek/mt76/mt7996/main.c:1023 mt7996_mac_sta_add=
_links()
> 	error: uninitialized symbol 'err'.
>=20
> drivers/net/wireless/mediatek/mt76/mt7996/main.c
>     984 static int
>     985 mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211=
_vif *vif,
>     986                          struct ieee80211_sta *sta, unsigned long=
 new_links)
>     987 {
>     988         struct mt7996_sta *msta =3D (struct mt7996_sta *)sta->drv=
_priv;
>     989         unsigned int link_id;
>     990         int err;
>     991=20
>     992         for_each_set_bit(link_id, &new_links, IEEE80211_MLD_MAX_N=
UM_LINKS) {
>     993                 struct ieee80211_bss_conf *link_conf;
>     994                 struct ieee80211_link_sta *link_sta;
>     995                 struct mt7996_vif_link *link;
>     996=20
>     997                 if (rcu_access_pointer(msta->link[link_id]))
>     998                         continue;
>=20
> What about if there are no new links or we hit the continue on every
> iteration.
>=20
>     999=20
>     1000                 link_conf =3D link_conf_dereference_protected(vi=
f, link_id);
>     1001                 if (!link_conf)
>     1002                         goto error_unlink;
>=20
> error code?
>=20
>     1003=20
>     1004                 link =3D mt7996_vif_link(dev, vif, link_id);
>     1005                 if (!link)
>     1006                         goto error_unlink;
>=20
> error code?
>=20
>     1007=20
>     1008                 link_sta =3D link_sta_dereference_protected(sta,=
 link_id);
>     1009                 if (!link_sta)
>     1010                         goto error_unlink;
>=20
> error code?
>=20
>     1011=20
>     1012                 err =3D mt7996_mac_sta_init_link(dev, link_conf,=
 link_sta, link,
>     1013                                                link_id);
>     1014                 if (err)
>     1015                         goto error_unlink;
>     1016         }
>     1017=20
>     1018         return 0;
>     1019=20
>     1020 error_unlink:
>     1021         mt7996_mac_sta_remove_links(dev, sta, new_links);
>     1022=20
> --> 1023         return err;
>     1024 }
>=20
> regards,
> dan carpenter

--EHUAeOz4fd75awZd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ92KOwAKCRA6cBh0uS2t
rG5cAQDphmP9K6IfiUhNPlSlfzsCq2U+tHPbt379ElB7baJv3QD/WpT91hM+ML6V
f3ep0hi29dXXuvRt8mNx0qUiRB4WXgE=
=PyZM
-----END PGP SIGNATURE-----

--EHUAeOz4fd75awZd--


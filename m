Return-Path: <linux-wireless+bounces-35405-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBymEULB72mLFQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35405-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 22:04:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A3E479AC6
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 22:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4412A3028025
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A1D2DD5F6;
	Mon, 27 Apr 2026 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmBuXREf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B92D7DD4;
	Mon, 27 Apr 2026 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320255; cv=none; b=PiGHfnpBgswL4RD/fjetq+rpz3X0uxzbg2MSUBxnwzKFfM3Wv3EjryMafWr4HMHBsbNNKvesViLijJgCf7pkcfzLHGcUh6KGmU8C5BnF8K6oVCf/q0ft6c9uu9wnBlJVUWHhACoZiDmNkQyN4SemS9mI1rTNfXCm/gpTHkAyX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320255; c=relaxed/simple;
	bh=nOBHti0wrHIQHTwQnJvsrWPDG3yEViQYOsOP4A5im4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KM37la3JZTZuRX5GS4XjliHsE8zIG7CMb8g6/R9/VWHeY8FbRv90o04K3wXpybyIY0mhtylqVvaVGRXGe8Tht+iYp9wJfkFQfr35BVOcZZ3bgu0rsdEeawPMZcWYVxCZBJjCqsq2sfk26phJcabNmCbqjCmlhwFupQqp+zJhySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmBuXREf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C6CC19425;
	Mon, 27 Apr 2026 20:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777320255;
	bh=nOBHti0wrHIQHTwQnJvsrWPDG3yEViQYOsOP4A5im4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmBuXREfmQAXnYSF9q5c7g4TKf65q7wBmO/Pr7wznrXG71gEoVcJ70jumCaFOOdnS
	 Lxgz+GsnS/HXDUwI5oebFrRDr5zA6yecrBab2HnilNsk7Y4PyiTWsfsBCVgpveZwKs
	 /RjlEPv6Ye3NMCWcdpzRVUw7s6nIuG1vM3oEg0I9RMCKVEiDsPqL84cKbW1bGNID7N
	 IRdlVKoXA0nBmYM6UxQglYugCmb1hiDar0PvSmpb3b6sTGStl+NGofz2vVierIy692
	 nnhWi6H/R0GYRXjLJNg+LxxluNcXg/RxWGy6TyzuSaYLYvaGiIaMVLxlGJBaMJ74wR
	 7lJA5CXT6Og1Q==
Date: Mon, 27 Apr 2026 21:04:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: devicetree@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"open list:MEDIATEK MT76 WIRELESS LAN DRIVER" <linux-wireless@vger.kernel.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 3/3] wifi: mt76: remove mt76_get_of_data_from_mtd
Message-ID: <20260427-sevenfold-scapegoat-9b66fb09da5c@spud>
References: <20260427034427.881389-1-rosenp@gmail.com>
 <20260427034427.881389-4-rosenp@gmail.com>
 <20260427-hug-baboon-d60bb8fdfa51@spud>
 <CAKxU2N-mhrhjDEc2MnOvDZC5PpMzj=vRgMemNK4qSQzNQ-=BPQ@mail.gmail.com>
 <20260427-safeguard-unthawed-cfb87dc55a32@spud>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bmrn+DgUsYWxn18C"
Content-Disposition: inline
In-Reply-To: <20260427-safeguard-unthawed-cfb87dc55a32@spud>
X-Rspamd-Queue-Id: 98A3E479AC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-35405-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,sipsolutions.net,gmail.com,collabora.com,alpha.franken.de,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--bmrn+DgUsYWxn18C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 09:02:56PM +0100, Conor Dooley wrote:
> On Mon, Apr 27, 2026 at 12:17:04PM -0700, Rosen Penev wrote:
> > On Mon, Apr 27, 2026 at 12:09=E2=80=AFPM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Sun, Apr 26, 2026 at 08:44:27PM -0700, Rosen Penev wrote:
> > > > mt76_get_of_data_from_mtd has been replaced by
> > > > mt76_get_of_data_from_nvmem in all usages.
> > >
> > > All users in the kernel, but what about other sources of devicetrees?
> > > Those built into firmware etc? Are there none of those too?
> > I'm actively removing those: https://github.com/openwrt/openwrt/pull/23=
113
> >=20
> > Anyway, irrelevant here.
>=20
> Hardly, you can't break backwards compatibility with old devicetrees.
> Removing known users from the kernel is one step in that process, but if
> there's devicetrees in other places those cunt too!
>=20
> With the moving pieces in this patchset alone it's problematic to move
> this fast, since you're changing the dts user in the same series as
> removing driver support (AFIACT), which means that neither netdev nor
> the platform tree will work with their portion applied.

Well, maybe the platform tree will work, but not the netdev tree unless
I've misunderstood completely.

>=20
> > >
> > > Conor.
> > >
> > > >
> > > > Remove it to prevent people from using the deprecated
> > > > mediatek,mtd-eeprom binding.
> > > >
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > > >  drivers/net/wireless/mediatek/mt76/eeprom.c   | 87 ---------------=
----
> > > >  drivers/net/wireless/mediatek/mt76/mt76.h     |  1 -
> > > >  .../wireless/mediatek/mt76/mt7915/eeprom.c    |  4 -
> > > >  3 files changed, 92 deletions(-)
> > > >
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/=
net/wireless/mediatek/mt76/eeprom.c
> > > > index afdb73661866..092804323d81 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> > > > @@ -35,89 +35,6 @@ static int mt76_get_of_eeprom_data(struct mt76_d=
ev *dev, void *eep, int len)
> > > >       return 0;
> > > >  }
> > > >
> > > > -int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int=
 offset, int len)
> > > > -{
> > > > -#ifdef CONFIG_MTD
> > > > -     struct device_node *np =3D dev->dev->of_node;
> > > > -     struct mtd_info *mtd;
> > > > -     const __be32 *list;
> > > > -     const char *part;
> > > > -     phandle phandle;
> > > > -     size_t retlen;
> > > > -     int size;
> > > > -     int ret;
> > > > -
> > > > -     list =3D of_get_property(np, "mediatek,mtd-eeprom", &size);
> > > > -     if (!list)
> > > > -             return -ENOENT;
> > > > -
> > > > -     phandle =3D be32_to_cpup(list++);
> > > > -     if (!phandle)
> > > > -             return -ENOENT;
> > > > -
> > > > -     np =3D of_find_node_by_phandle(phandle);
> > > > -     if (!np)
> > > > -             return -EINVAL;
> > > > -
> > > > -     part =3D of_get_property(np, "label", NULL);
> > > > -     if (!part)
> > > > -             part =3D np->name;
> > > > -
> > > > -     mtd =3D get_mtd_device_nm(part);
> > > > -     if (IS_ERR(mtd)) {
> > > > -             ret =3D  PTR_ERR(mtd);
> > > > -             goto out_put_node;
> > > > -     }
> > > > -
> > > > -     if (size <=3D sizeof(*list)) {
> > > > -             ret =3D -EINVAL;
> > > > -             goto out_put_node;
> > > > -     }
> > > > -
> > > > -     offset +=3D be32_to_cpup(list);
> > > > -     ret =3D mtd_read(mtd, offset, len, &retlen, eep);
> > > > -     put_mtd_device(mtd);
> > > > -     if (mtd_is_bitflip(ret))
> > > > -             ret =3D 0;
> > > > -     if (ret) {
> > > > -             dev_err(dev->dev, "reading EEPROM from mtd %s failed:=
 %i\n",
> > > > -                     part, ret);
> > > > -             goto out_put_node;
> > > > -     }
> > > > -
> > > > -     if (retlen < len) {
> > > > -             ret =3D -EINVAL;
> > > > -             goto out_put_node;
> > > > -     }
> > > > -
> > > > -     if (of_property_read_bool(dev->dev->of_node, "big-endian")) {
> > > > -             u8 *data =3D (u8 *)eep;
> > > > -             int i;
> > > > -
> > > > -             /* convert eeprom data in Little Endian */
> > > > -             for (i =3D 0; i < round_down(len, 2); i +=3D 2)
> > > > -                     put_unaligned_le16(get_unaligned_be16(&data[i=
]),
> > > > -                                        &data[i]);
> > > > -     }
> > > > -
> > > > -#ifdef CONFIG_NL80211_TESTMODE
> > > > -     dev->test_mtd.name =3D devm_kstrdup(dev->dev, part, GFP_KERNE=
L);
> > > > -     if (!dev->test_mtd.name) {
> > > > -             ret =3D -ENOMEM;
> > > > -             goto out_put_node;
> > > > -     }
> > > > -     dev->test_mtd.offset =3D offset;
> > > > -#endif
> > > > -
> > > > -out_put_node:
> > > > -     of_node_put(np);
> > > > -     return ret;
> > > > -#else
> > > > -     return -ENOENT;
> > > > -#endif
> > > > -}
> > > > -EXPORT_SYMBOL_GPL(mt76_get_of_data_from_mtd);
> > > > -
> > > >  int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
> > > >                               const char *cell_name, int len)
> > > >  {
> > > > @@ -163,10 +80,6 @@ static int mt76_get_of_eeprom(struct mt76_dev *=
dev, void *eep, int len)
> > > >       if (!ret)
> > > >               return 0;
> > > >
> > > > -     ret =3D mt76_get_of_data_from_mtd(dev, eep, 0, len);
> > > > -     if (!ret)
> > > > -             return 0;
> > > > -
> > > >       return mt76_get_of_data_from_nvmem(dev, eep, "eeprom", len);
> > > >  }
> > > >
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/ne=
t/wireless/mediatek/mt76/mt76.h
> > > > index 527bef97e122..f447ecac664d 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> > > > @@ -1339,7 +1339,6 @@ void mt76_seq_puts_array(struct seq_file *fil=
e, const char *str,
> > > >
> > > >  int mt76_eeprom_init(struct mt76_dev *dev, int len);
> > > >  int mt76_eeprom_override(struct mt76_phy *phy);
> > > > -int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int=
 offset, int len);
> > > >  int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
> > > >                               const char *cell_name, int len);
> > > >
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/d=
rivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> > > > index eb92cbf1a284..c24e1276700b 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> > > > @@ -29,10 +29,6 @@ static int mt7915_eeprom_load_precal(struct mt79=
15_dev *dev)
> > > >
> > > >       offs =3D is_mt7915(&dev->mt76) ? MT_EE_PRECAL : MT_EE_PRECAL_=
V2;
> > > >
> > > > -     ret =3D mt76_get_of_data_from_mtd(mdev, dev->cal, offs, size);
> > > > -     if (!ret)
> > > > -             return ret;
> > > > -
> > > >       ret =3D mt76_get_of_data_from_nvmem(mdev, dev->cal, "precal",=
 size);
> > > >       if (!ret)
> > > >               return ret;
> > > > --
> > > > 2.54.0
> > > >



--bmrn+DgUsYWxn18C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCae/BOQAKCRB4tDGHoIJi
0hiVAQCuQjZQ0kXNujxtGnjAFyCtQV5vV/cdvN5oxs2/TTgkRgEA0Qb6OYc/8bMe
eImO8EwL5nRHSDd29R9EVtG7DSFgGQQ=
=5iMX
-----END PGP SIGNATURE-----

--bmrn+DgUsYWxn18C--


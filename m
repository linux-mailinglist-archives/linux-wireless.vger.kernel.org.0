Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2422D318E97
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 16:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBKPaI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 10:30:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhBKP0D (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 10:26:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BA3564E08;
        Thu, 11 Feb 2021 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613057122;
        bh=e0FeqHbh2wkDDSJ2Mj9IZix0lS/Aa4xetp4JVGSL3W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4g6IY2VXkh/cN74SL4A98WdJnOIsbngqReuvaQm6oP4gVRoruRzpuWb7yEq+FLea
         OwsdmbH0hW6eYxHM8YDmOBNGsZM10iKA5w6YpX/sYEyCmpvmFehVZRwxH8nzntIyXl
         bnxXOf1xsrCFJBSlAhJRekq8e8qhN+qiCoU9ydmUqC0BrYgBb1PPukGzXPvkg0Et48
         PlJkUOqfvJDbaUSM9j3/cF4ZN0u1GhTjK3NitjoEQWNojMdIX2dnzH0+vf7iMZseOf
         Nwj1OwpZqLIDpaOSNtsG2EucZ4bJ27SapX1iQ6o00JS/82MIbwSJhvZImybdqmUnwc
         dGzsvWoZT+SJg==
Date:   Thu, 11 Feb 2021 16:25:17 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [bug report] mt76: mt76_connac: create mcu library
Message-ID: <YCVMXXgPFp6/ZLC/@lore-desk>
References: <YCU0k+mAXAEYbiW4@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lBwRe+1wcfC8nyfg"
Content-Disposition: inline
In-Reply-To: <YCU0k+mAXAEYbiW4@mwanda>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--lBwRe+1wcfC8nyfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo Bianconi,

Hi Dan,

>=20
> The patch d0e274af2f2e: "mt76: mt76_connac: create mcu library" from
> Jan 26, 2021, leads to the following static checker warning:
>=20
> 	drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:837 mt76_connac_mcu=
_add_sta_cmd()
> 	error: 'wtbl_hdr' dereferencing possible ERR_PTR()
>=20
> drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>    810  int mt76_connac_mcu_add_sta_cmd(struct mt76_phy *phy,
>    811                                  struct ieee80211_vif *vif,
>    812                                  struct ieee80211_sta *sta,
>    813                                  struct mt76_wcid *wcid,
>    814                                  bool enable, int cmd)
>    815  {
>    816          struct mt76_vif *mvif =3D (struct mt76_vif *)vif->drv_pri=
v;
>    817          struct mt76_dev *dev =3D phy->dev;
>    818          struct wtbl_req_hdr *wtbl_hdr;
>    819          struct tlv *sta_wtbl;
>    820          struct sk_buff *skb;
>    821 =20
>    822          skb =3D mt76_connac_mcu_alloc_sta_req(dev, mvif, wcid);
>    823          if (IS_ERR(skb))
>    824                  return PTR_ERR(skb);
>    825 =20
>    826          mt76_connac_mcu_sta_basic_tlv(skb, vif, sta, enable);
>    827          if (enable && sta)
>    828                  mt76_connac_mcu_sta_tlv(phy, skb, sta, vif);
>    829 =20
>    830          sta_wtbl =3D mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
>    831                                             sizeof(struct tlv));
>    832 =20
>    833          wtbl_hdr =3D mt76_connac_mcu_alloc_wtbl_req(dev, wcid,
>    834                                                    WTBL_RESET_AND_=
SET,
>    835                                                    sta_wtbl, &skb);
>=20
> if (IS_ERR(wtbl_hdr)) {
> 	do some cleanup?
> 	return PTR_ERR(wtbl_hdr);
> }

I think this is a false positive since reviewing
mt76_connac_mcu_alloc_wtbl_req(), it can return ERR_PTR(-ENOMEM) only if ns=
kb
is NULL and it is not the case.

Regards,
Lorenzo

>=20
>    836          if (enable) {
>    837                  mt76_connac_mcu_wtbl_generic_tlv(dev, skb, vif, s=
ta, sta_wtbl,
>    838                                                   wtbl_hdr);
>    839                  if (sta)
>    840                          mt76_connac_mcu_wtbl_ht_tlv(dev, skb, sta=
, sta_wtbl,
>    841                                                      wtbl_hdr);
>    842          }
>    843 =20
>    844          return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
>    845  }
>=20
> regards,
> dan carpenter

--lBwRe+1wcfC8nyfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYCVMWwAKCRA6cBh0uS2t
rBTYAP9JHQV3y95zfln2aRwVSz81imnF6l89OUNPlnORQf2QaQEAo4/HULfH1HM/
di0Ze4cq6k5/WrLvS8WS0jnbUtdxvQI=
=09Sd
-----END PGP SIGNATURE-----

--lBwRe+1wcfC8nyfg--

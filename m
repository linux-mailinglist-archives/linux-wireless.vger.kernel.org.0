Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EF93AFD24
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 08:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFVGnE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 02:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhFVGnE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 02:43:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD443611CE;
        Tue, 22 Jun 2021 06:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624344049;
        bh=8IVeoj39SKXmg91zm5BlPJZ7feT5hJa+UWQdSelyYpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5Fo0hQOj+PgJXEE8O8+cJkzFlyJ/iY5e4XbvTZNMZSR/A4QpP/hHGZ/v/P2/UK8R
         kCOVTfq7tmpzeaCsxeKBwBTV7lbywvGJ2Gqi43GOF121RPi8K3niEsimgGXDxR+2nT
         LXxun14q6ObSb0hII/5NU/MhaakH1ApC0EqRbTUfEcDziiatm1qN7921XEzXUagJHQ
         DeU2xBtraxoNZ0ruMAS38n1gcSl8pwiH7AZvuQiMXwE6ymtjf62SqJirdFeIXyxnW0
         PsV2I/PVWWAb8qaOV0O0D45z3Mwq/hO8iIXY5lFOpv8mGg2YEqG7YPmUSUl3CPK058
         qwIeJOXKvlj4g==
Date:   Tue, 22 Jun 2021 08:40:44 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     lorenzo.bianconi@redhat.com, nbd@nbd.name, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: add .set_sar_specs support
Message-ID: <YNGF7Bl2uP0SAnv9@lore-desk>
References: <YM8NBUZp+/97kiIH@lore-desk--annotate>
 <1624315331-16608-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gGYiClTCWJBu/p1R"
Content-Disposition: inline
In-Reply-To: <1624315331-16608-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--gGYiClTCWJBu/p1R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> >
> >I guess there is an use-after-free here since sar is freed at the end of=
 nl80211_set_sar_specs, right?
> >
>=20
> Nope, there is no use-after-free case happens here because frp->range jus=
t points to an entry of const struct cfg80211_sar_specs table, not the one =
created from nl80211_set_sar_specs.

ack, right. I misread the code.

Regards,
Lorenzo

>=20
> >Regards,
> >Lorenzo
> >
> >> +		frp->power =3D power;
> >> +	}
> >> +
> >> +	err =3D mt76_connac_mcu_set_rate_txpower(mphy);
> >> +
> >> +out:
> >> +	mt7921_mutex_release(dev);
> >> +
> >> +	return err;
> >> +}
> >> +
> >>  const struct ieee80211_ops mt7921_ops =3D {
> >>	.tx =3D mt7921_tx,
> >>	.start =3D mt7921_start,
> >> @@ -1209,4 +1253,5 @@ const struct ieee80211_ops mt7921_ops =3D {
> >>	.set_rekey_data =3D mt7921_set_rekey_data,  #endif /* CONFIG_PM */
> >>	.flush =3D mt7921_flush,
> >> +	.set_sar_specs =3D mt7921_set_sar_specs,
> >>  };
> >> --
> >> 2.25.1
> >>

--gGYiClTCWJBu/p1R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYNGF5wAKCRA6cBh0uS2t
rBhsAP95npOocHCGoicDiaIO8Uf1rLxnUf6RItP8GT8jhzI96wD9Grh9Tc8PSd/+
JGauE3SBfDXGS9Ey6tjP/AIhbplcdgY=
=rm2D
-----END PGP SIGNATURE-----

--gGYiClTCWJBu/p1R--

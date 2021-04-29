Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79EA36E7CB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 11:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhD2JTK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 05:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237366AbhD2JTK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 05:19:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 594E961445;
        Thu, 29 Apr 2021 09:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619687903;
        bh=K/egRLl1LkQqfLlp8hnE6ni3Yg7KzMgI7I/EHWxqgCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEvEo7I1CelKSoRuzK4bSb1CAkakaQttdp9Jz1/23oI1hFl4iUcVZJdGtyVmRa3RK
         gZUZlfwZ8RLjvZG4ukfwsp/NAGVnbQTD9Rot9ukpQaRA6sH1mt3ccXExetGgKm06u5
         143o4TlqACRM8/IgNH+ONdB4MWbqaMtIi8rfp/u+myG2TZ+6z7BONfG2ZgwEtSv4d0
         0m7647ktLSDLLGGmfGEgFpefZArMaPm1lFjt566MEcmwnc+3riyc5ledBu5DBXtMYh
         ftrW475/fqCftxS+6cYgq2s4luSRs3D1bKEUfnBiu9CqDMGhc1buXRiqfIN0rcVcZv
         u3ngG8fzzzE/Q==
Date:   Thu, 29 Apr 2021 11:18:18 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] mt76: move mt76_rates in mt76 module
Message-ID: <YIp52gS+gumkHDLY@lore-desk>
References: <a8da66822d9dbfd7afbebcd915f1c4e1bb59d41f.1619685085.git.lorenzo@kernel.org>
 <3d5251c8-dfad-7b46-4603-3df3f50c5770@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nQHsL+kKFsiv7XqR"
Content-Disposition: inline
In-Reply-To: <3d5251c8-dfad-7b46-4603-3df3f50c5770@nbd.name>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--nQHsL+kKFsiv7XqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> On 2021-04-29 10:32, Lorenzo Bianconi wrote:
> > Move mt76_rates array in mt76 module and remove duplicated code since it
> > is shared by all drivers
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mac80211.c | 16 +++++++++
> >  drivers/net/wireless/mediatek/mt76/mt76.h     | 15 ++++++++
> >  .../net/wireless/mediatek/mt76/mt7603/init.c  | 13 -------
> >  .../net/wireless/mediatek/mt76/mt7615/init.c  | 33 ++---------------
> >  .../wireless/mediatek/mt76/mt7615/pci_init.c  |  4 +--
> >  .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |  4 +--
> >  .../net/wireless/mediatek/mt76/mt76x02_util.c | 16 +++------
> >  .../net/wireless/mediatek/mt76/mt7915/init.c  | 36 +++----------------
> >  .../net/wireless/mediatek/mt76/mt7921/init.c  | 32 ++---------------
> >  9 files changed, 48 insertions(+), 121 deletions(-)
> >=20
> > index e1b2cfa56074..b46097ea334a 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
> > @@ -304,19 +304,6 @@ mt7603_init_hardware(struct mt7603_dev *dev)
> >  	return 0;
> >  }
> > =20
> > -#define CCK_RATE(_idx, _rate) {					\
> > -	.bitrate =3D _rate,					\
> > -	.flags =3D IEEE80211_RATE_SHORT_PREAMBLE,			\
> > -	.hw_value =3D (MT_PHY_TYPE_CCK << 8) | (_idx),		\
> > -	.hw_value_short =3D (MT_PHY_TYPE_CCK << 8) | (4 + _idx),	\
> > -}
> > -
> > -#define OFDM_RATE(_idx, _rate) {				\
> > -	.bitrate =3D _rate,					\
> > -	.hw_value =3D (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
> > -	.hw_value_short =3D (MT_PHY_TYPE_OFDM << 8) | (_idx),	\
> > -}
> > -
> >  static struct ieee80211_rate mt7603_rates[] =3D {
> >  	CCK_RATE(0, 10),
> >  	CCK_RATE(1, 20),
> I think you can drop mt7603_rates as well and replace it with
> mt76_rates. The rest looks good to me.

it was in my plan but I forgot it, I will fix it in v2, thanks.

Regards,
Lorenzo

>=20
> - Felix

--nQHsL+kKFsiv7XqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYIp52AAKCRA6cBh0uS2t
rCEiAP9SLdlTCKuxoO9KvhH9gJUlWkpvw1DjhRFlloX2xsVE9gD8CdIHRguM5LNh
bvFrNY5Q3HPrBKA5481Ct8KkuDDl6wU=
=vjKY
-----END PGP SIGNATURE-----

--nQHsL+kKFsiv7XqR--

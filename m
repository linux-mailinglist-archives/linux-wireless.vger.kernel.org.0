Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2428FEC50
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 13:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfKPMnu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 07:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbfKPMnu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 07:43:50 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71287206E6;
        Sat, 16 Nov 2019 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573908229;
        bh=NxQsszbOSfkj48xkLU7YA+cMWdnNAlXFIk2HNGvvnao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAchgwgbKZtOZb2GYeUaR4N4nHl4NlDtHLWG0X5MUseuZgv6NMRS74iNp7Stm7Rih
         +ZzK/GjQQZo5FC2w9TfNKnIenOFYXaMBnMdj1C3saWNoMLQTUoRaTu/onJE+xq0NbB
         KQqBauR6PowxR9mANt7a7ekAcC3tpRcWLvWvERW8=
Date:   Sat, 16 Nov 2019 14:43:40 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH 4/4] mt76: mt76x02: add channel switch support for usb
 interfaces
Message-ID: <20191116124340.GE20820@localhost.localdomain>
References: <20191116111709.4686-1-markus.theil@tu-ilmenau.de>
 <20191116111709.4686-5-markus.theil@tu-ilmenau.de>
 <20191116114517.GD20820@localhost.localdomain>
 <5dffcc2f-e722-395a-0077-1286f1c786b8@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
In-Reply-To: <5dffcc2f-e722-395a-0077-1286f1c786b8@tu-ilmenau.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 11/16/19 12:45 PM, Lorenzo Bianconi wrote:
> >> This patch enables channel switch support on mt76 usb interfaces.
> >>
> > Hi Markus,
> >
> > I was thinking about it, but since usb does not support DFS what is the=
 purpose
> > of CSA in this case?
> >
> > Regards,
> > Lorenzo
>=20
> Hi Lorenzo,
>=20
> for research purposes I'm currently trying out some dynamic channel
> allocation strategies with multiple indoor APs. I use a dedicated
> interface to perform surveys and monitoring the environment. These
> survey results are then correlated between different with traffic
> patterns to find out interferers. Afterwards I let the AP interfaces
> change their channel to a less congested one if necessary and notice the
> STAs via CSAs.
>=20
> I use mt76 based USB devices for my tests as they are quite versatile
> and useful for debugging with a notebook (I can just attach multiple
> ones). Therefore I thought, having the possibility to dynamically switch
> channels on this devices would maybe useful to other researchers and
> submitted my patches.
>=20
> Regards,
> Markus

ack, sounds good to me.

Regards,
Lorenzo

>=20
> >> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> >> ---
> >>  drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 7 +++++++
> >>  drivers/net/wireless/mediatek/mt76/mt76x02_util.c     | 2 +-
> >>  drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c  | 5 +++++
> >>  3 files changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/d=
rivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> >> index aedab4cc8d40..32e6c37aa80d 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> >> @@ -179,6 +179,12 @@ static void mt76x02u_pre_tbtt_work(struct work_st=
ruct *work)
> >> =20
> >>  	mt76x02_resync_beacon_timer(dev);
> >> =20
> >> +	mt76_csa_check(&dev->mt76);
> >> +	if (dev->mt76.csa_complete) {
> >> +		mt76_csa_finish(&dev->mt76);
> >> +		goto out;
> >> +	}
> >> +
> >>  	mt76x02_mac_set_beacon_prepare(dev);
> >> =20
> >>  	ieee80211_iterate_active_interfaces(mt76_hw(dev),
> >> @@ -195,6 +201,7 @@ static void mt76x02u_pre_tbtt_work(struct work_str=
uct *work)
> >> =20
> >>  	mt76x02_mac_set_beacon_finish(dev);
> >> =20
> >> +out:
> >>  	mt76x02u_restart_pre_tbtt_timer(dev);
> >>  }
> >> =20
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drive=
rs/net/wireless/mediatek/mt76/mt76x02_util.c
> >> index 414b22399d93..3f95e5b24e1d 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
> >> @@ -174,7 +174,6 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
> >>  		wiphy->reg_notifier =3D mt76x02_regd_notifier;
> >>  		wiphy->iface_combinations =3D mt76x02_if_comb;
> >>  		wiphy->n_iface_combinations =3D ARRAY_SIZE(mt76x02_if_comb);
> >> -		wiphy->flags |=3D WIPHY_FLAG_HAS_CHANNEL_SWITCH;
> >> =20
> >>  		/* init led callbacks */
> >>  		if (IS_ENABLED(CONFIG_MT76_LEDS)) {
> >> @@ -184,6 +183,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
> >>  		}
> >>  	}
> >> =20
> >> +	wiphy->flags |=3D WIPHY_FLAG_HAS_CHANNEL_SWITCH;
> >>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
> >> =20
> >>  	hw->sta_data_size =3D sizeof(struct mt76x02_sta);
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/dr=
ivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
> >> index eb73cb856c81..2f2c39a6a9e6 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
> >> @@ -100,6 +100,10 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 chang=
ed)
> >>  	return err;
> >>  }
> >> =20
> >> +void mt76x2u_channel_switch_beacon(struct ieee80211_hw *hw,
> >> +				   struct ieee80211_vif *vif,
> >> +				   struct cfg80211_chan_def *chandef) {}
> >> +
> >>  const struct ieee80211_ops mt76x2u_ops =3D {
> >>  	.tx =3D mt76x02_tx,
> >>  	.start =3D mt76x2u_start,
> >> @@ -121,4 +125,5 @@ const struct ieee80211_ops mt76x2u_ops =3D {
> >>  	.get_survey =3D mt76_get_survey,
> >>  	.set_tim =3D mt76_set_tim,
> >>  	.release_buffered_frames =3D mt76_release_buffered_frames,
> >> +	.channel_switch_beacon =3D mt76x2u_channel_switch_beacon,
> >>  };
> >> --=20
> >> 2.24.0
> >>
> --=20
> Markus Theil
>=20
> Technische Universit=E4t Ilmenau, Fachgebiet Telematik/Rechnernetze
> Postfach 100565
> 98684 Ilmenau, Germany
>=20
> Phone: +49 3677 69-4582
> Email: markus[dot]theil[at]tu-ilmenau[dot]de
> Web: http://www.tu-ilmenau.de/telematik
>=20
>=20

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXc/u+QAKCRA6cBh0uS2t
rP2OAQCYe5yhPYVcctpAVF7bbvwRrE+psrWL7WqDQOqBMH3vswD/Y/zfPvycnk7S
o5Cp33FZ/sFNm5BxjTqMU7lsQth9Wgs=
=D0oD
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--

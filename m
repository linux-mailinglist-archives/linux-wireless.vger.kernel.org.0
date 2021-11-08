Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBAE447D51
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Nov 2021 11:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhKHKNX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 05:13:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237526AbhKHKNQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 05:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636366232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KXW6AMI8MXj+MQHQ58vJfdzGmjddNlorclH16glEsdw=;
        b=R+miDu+i9cZG0fRDTefEy2Rz6y3yFEzgQYj+qdSGZ8GaYFado4pTa7y4cMwZnJAQFD4DDv
        5x4aWIWh5qA7r0JI071DmcRqkUIlWHLvRnv4gfP2cgR0HBTVCwbwfygx03D9IXq3ggX4ba
        iPBDJbJR/3xJXov8JKQc0o/pwXgmjzA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-HgTtO7U_P-ms2mkUF9O6xw-1; Mon, 08 Nov 2021 05:10:30 -0500
X-MC-Unique: HgTtO7U_P-ms2mkUF9O6xw-1
Received: by mail-ed1-f69.google.com with SMTP id y20-20020a056402359400b003e28c9bc02cso14502967edc.9
        for <linux-wireless@vger.kernel.org>; Mon, 08 Nov 2021 02:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KXW6AMI8MXj+MQHQ58vJfdzGmjddNlorclH16glEsdw=;
        b=ocAFuCHT8aErzwdnCdkiWsVU7Jcbc9mtlVM2sJxD+UQtO1bEqB/+iU3ckOuSJjQX9v
         AmnmV9HxoDK6GRBAUW8WqZCyRrL37E1yO2EGH9H5I2ElH5i6GbLFMMwOoxwOimuiK1cy
         UmuiFnJv8N/wt34oDbCNy6y2Q6alHd6TjZ0N1ABGVrK0bobhNMb+O+eXfEywRZtEtJ5T
         zamSJJ4GspmaGs478kMtyTXlUaVzg6ldXkdkRkAhdUTZF1MRlSkB7IH+bToGWpJo4hXv
         uYfSVO8o2030wU1PD8f66Oy56gM50UQ62o58grONou4jmd3LB2t/8PDHp14XdAPAOGFs
         UXWA==
X-Gm-Message-State: AOAM533ICIg/p8g8U+wILKxdTGqVUYBl6lbh28BFDQKwwQYz0BCRyhpt
        njfTBD/FLRdGfqSZa0SEn95lXxme22VSZT8xSZoHbMyCAyZ7BPrZ4q1gBa92UmAcUMdAc7Mw/Vn
        Z3V9RgeXX+iHbyLLs4RRK61zxWK8=
X-Received: by 2002:a05:6402:26c5:: with SMTP id x5mr48998315edd.156.1636366229428;
        Mon, 08 Nov 2021 02:10:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxezOdH8WnAoMyjSTYWFmpw7TLlY8Nz1Xr00+4fu6NZ6ltyNejIQvmt6qFK8ObaOjS2YqkTQw==
X-Received: by 2002:a05:6402:26c5:: with SMTP id x5mr48998279edd.156.1636366229183;
        Mon, 08 Nov 2021 02:10:29 -0800 (PST)
Received: from localhost (net-37-119-217-95.cust.vodafonedsl.it. [37.119.217.95])
        by smtp.gmail.com with ESMTPSA id q8sm3023365edd.26.2021.11.08.02.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 02:10:28 -0800 (PST)
Date:   Mon, 8 Nov 2021 11:10:26 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921: introduce 160 MHz channel bandwidth support
Message-ID: <YYj3kibdi2RB4ZT5@lore-desk>
References: <d4e93e0ffa11d7126b2ab48a34d0b4a4a17f2134.1636207928.git.deren.wu@mediatek.com>
 <YYeuMs+QD067Fc5R@lore-desk>
 <8780cd7315953270b14d491dd426032a697fba0b.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yvWV5q0m1emAfDVB"
Content-Disposition: inline
In-Reply-To: <8780cd7315953270b14d491dd426032a697fba0b.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--yvWV5q0m1emAfDVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lore,
>=20
> The definition of cap->max_bw is identical to
> ieee80211_sta_rx_bandwidth. For now, the value would be=20
> IEEE80211_STA_RX_BW_160 if the chip supports bw160.

ok, so why not something like:

dev->phy.cap.has_bw160 =3D cap->max_bw =3D=3D IEEE80211_STA_RX_BW_160;

Regards,
Lorenzo

>=20
>=20
> Regards,
> Deren
>=20
> On Sun, 2021-11-07 at 11:45 +0100, Lorenzo Bianconi wrote:
> > > From: Deren Wu <deren.wu@mediatek.com>
> > >=20
> > > Introduce the basic configuration for chips with BW160 capability
> > >=20
> > > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/mt76.h            |  1 +
> > >  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  1 +
> > >  drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  4 ++++
> > >  drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 12
> > > ++++++++++++
> > >  4 files changed, 18 insertions(+)
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h
> > > b/drivers/net/wireless/mediatek/mt76/mt76.h
> > > index e2da720a91b6..babca8086027 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> > > @@ -346,6 +346,7 @@ struct mt76_hw_cap {
> > >  	bool has_2ghz;
> > >  	bool has_5ghz;
> > >  	bool has_6ghz;
> > > +	bool has_bw160;
> > >  };
> > > =20
> > >  #define MT_DRV_TXWI_NO_FREE		BIT(0)
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > > b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > > index 26b4b875dcc0..4da20537aaf9 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> > > @@ -1775,6 +1775,7 @@ static void
> > > mt76_connac_mcu_parse_phy_cap(struct mt76_dev *dev,
> > >  	dev->phy.chainmask =3D dev->phy.antenna_mask;
> > >  	dev->phy.cap.has_2ghz =3D cap->hw_path & BIT(WF0_24G);
> > >  	dev->phy.cap.has_5ghz =3D cap->hw_path & BIT(WF0_5G);
> > > +	dev->phy.cap.has_bw160 =3D (cap->max_bw >=3D
> > > IEEE80211_STA_RX_BW_160);
> >=20
> > Hi Deren,
> >=20
> > just out of my curiosity, what are the possible values of cap->max_bw=
=20
> > here?
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >  }
> > > =20
> > >  int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy)
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > index 210998f086ab..30c0246fba3a 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > @@ -264,6 +264,10 @@ int mt7921_register_device(struct mt7921_dev
> > > *dev)
> > >  			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
> > >  			IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
> > >  			(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
> > > +	if (dev->mt76.phy.cap.has_bw160)
> > > +		dev->mphy.sband_5g.sband.vht_cap.cap |=3D
> > > +			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
> > > +			IEEE80211_VHT_CAP_SHORT_GI_160;
> > > =20
> > >  	dev->mphy.hw->wiphy->available_antennas_rx =3D dev-
> > > >mphy.chainmask;
> > >  	dev->mphy.hw->wiphy->available_antennas_tx =3D dev-
> > > >mphy.chainmask;
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > index 633c6d2a57ac..af8c675f909f 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> > > @@ -128,11 +128,23 @@ mt7921_init_he_caps(struct mt7921_phy *phy,
> > > enum nl80211_band band,
> > >  				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_
> > > THAN_242_TONE_RU |
> > >  				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USI
> > > NG_MU_WITH_COMP_SIGB |
> > >  				IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USI
> > > NG_MU_WITH_NON_COMP_SIGB;
> > > +
> > > +			if (phy->mt76->cap.has_bw160) {
> > > +				he_cap_elem->phy_cap_info[0] |=3D
> > > +					IEEE80211_HE_PHY_CAP0_CHANNEL_W
> > > IDTH_SET_160MHZ_IN_5G;
> > > +				he_cap_elem->phy_cap_info[8] |=3D
> > > +					IEEE80211_HE_PHY_CAP8_20MHZ_IN_
> > > 160MHZ_HE_PPDU |
> > > +					IEEE80211_HE_PHY_CAP8_80MHZ_IN_
> > > 160MHZ_HE_PPDU;
> > > +			}
> > >  			break;
> > >  		}
> > > =20
> > >  		he_mcs->rx_mcs_80 =3D cpu_to_le16(mcs_map);
> > >  		he_mcs->tx_mcs_80 =3D cpu_to_le16(mcs_map);
> > > +		if (phy->mt76->cap.has_bw160) {
> > > +			he_mcs->rx_mcs_160 =3D cpu_to_le16(mcs_map);
> > > +			he_mcs->tx_mcs_160 =3D cpu_to_le16(mcs_map);
> > > +		}
> > > =20
> > >  		memset(he_cap->ppe_thres, 0, sizeof(he_cap-
> > > >ppe_thres));
> > >  		if (he_cap_elem->phy_cap_info[6] &
> > > --=20
> > > 2.18.0
> > >=20
> >=20
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>=20

--yvWV5q0m1emAfDVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYYj3kgAKCRA6cBh0uS2t
rEk8AQDSHZqT0RGI+/wxoyUgOaN0CB/nhxXVBythnuhNNJWtIwD/USeppwop+3cM
yUN7UkWhx9mDQt1ioEQDWStbEiquhgY=
=qvzV
-----END PGP SIGNATURE-----

--yvWV5q0m1emAfDVB--


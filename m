Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E5B4DC247
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 10:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiCQJFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 05:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiCQJFQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 05:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AD45DAFC9
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647507839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R9qqzVKD4bzKL/JelFivaINl/L/KOQW4w8HcJ8yqItI=;
        b=MSUbstpfRQOQ4pa4vqd0FP4MFOO2o8XORr/OJ7R6j/46f5YsDxUNdd36eIJRoYomaSOgdf
        7SAKDC/qBCC6aBrYN8MY+ThwmCTPSqdHDEE4+1zKCw+Om70LR5QQBbIXdT00imBF0KPyTl
        EuPTN0r8blEs47Ud79CLTXwEdfuSS8A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-q6XJjr7vP0Oj_tFgIdabiA-1; Thu, 17 Mar 2022 05:03:57 -0400
X-MC-Unique: q6XJjr7vP0Oj_tFgIdabiA-1
Received: by mail-wr1-f70.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so1320513wrg.19
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 02:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R9qqzVKD4bzKL/JelFivaINl/L/KOQW4w8HcJ8yqItI=;
        b=K98JzhyJtueINVMU9ugIiwSd4JcRcoxsBRNqzVtVJhwY59+hMrPGv+hwNUPzm09/Fb
         2Ob8veI4Hf2VMYqu3B2sYrswS7J9TR30x8+lFNBVQHsjKF2zw2Wv92/L4nc6MxQNcsrz
         3KMUBJ4wo+lZPmUtnvZPCEJIJKSHiL+vr0pO/6VySkJwSmKIx6LjvB13fpkGtbNHCSW/
         49on+m3MLpggQ4hrbehpMelRxGNsL6oevJuPYwfH5z4CgT8V/8fgl6h0MwipWZlWUvG+
         Hb5X9/YwLoch5oCrDVUyGtINjCOHLueLR7TJ5kvzwriCsbL7VOovUjQuyFde//V72lln
         NXHQ==
X-Gm-Message-State: AOAM532cSI5RDvxZ6n/yCCfcTDyjDuVz6jDgwrb/O8zhfzg6eqR+hcXp
        1l5cIt01ODpIetfPi6HV1YNmAF8rtd5KP/yZkUBtAgGzdyCSKbgr03O3FSovoYK+lnGIQO5nrHy
        qnhwOAkkEn0/Le/vyI75muEIIaVA=
X-Received: by 2002:adf:816b:0:b0:203:7fae:a245 with SMTP id 98-20020adf816b000000b002037faea245mr3072224wrm.619.1647507836530;
        Thu, 17 Mar 2022 02:03:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzExt6iMQxlvIY5XabLDtCiG/Czc36a1klsSly4lwbam9nCGD9/JSLvaBuOG236YqudHLFxyg==
X-Received: by 2002:adf:816b:0:b0:203:7fae:a245 with SMTP id 98-20020adf816b000000b002037faea245mr3072197wrm.619.1647507836205;
        Thu, 17 Mar 2022 02:03:56 -0700 (PDT)
Received: from localhost (net-93-144-71-136.cust.vodafonedsl.it. [93.144.71.136])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b00389d8c3e2b9sm3850893wms.15.2022.03.17.02.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 02:03:55 -0700 (PDT)
Date:   Thu, 17 Mar 2022 10:03:53 +0100
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
Subject: Re: [PATCH] mt76: fix monitor rx FCS error in DFS channel
Message-ID: <YjL5ecm51SUyxxpb@lore-desk>
References: <7243650f3d51b1919bd4fd0017ff8b0186149e54.1647421054.git.deren.wu@mediatek.com>
 <YjH/GCCfQoZ5OPPM@localhost.localdomain>
 <ef6a0d876587e3efaa228f9d28f5a6f7b97e4aef.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AuwHAuPZagE1dC5E"
Content-Disposition: inline
In-Reply-To: <ef6a0d876587e3efaa228f9d28f5a6f7b97e4aef.camel@mediatek.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--AuwHAuPZagE1dC5E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lore,
>=20
> On Wed, 2022-03-16 at 16:15 +0100, Lorenzo Bianconi wrote:
> > > From: Deren Wu <deren.wu@mediatek.com>
> > >=20
> > > When setup monitor mode in DFS channel, mt76 send CH_SWITCH_DFS to
> > > fw for channel config. This would cause rx performance bad while
> > > monitoring frames. Settings CH_SWITCH_NORMAL in monitor mode would
> > > get the same performance as normal channels.
> >=20
> > Hi Deren,
> >=20
> > >=20
> > > Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
> > > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 ++-
> > >  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 3 ++-
> > >  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 3 ++-
> > >  3 files changed, 6 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > index 390add3144c2..97e2a85cb728 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> > > @@ -2151,7 +2151,8 @@ int mt7615_mcu_set_chan_info(struct
> > > mt7615_phy *phy, int cmd)
> > >  		.center_chan2 =3D ieee80211_frequency_to_channel(freq2),
> > >  	};
> > > =20
> > > -	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH))
> > > +	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH) ||
> > > +	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
> >=20
> > is this patch compliant with 802.11h DFS standard?
>=20
> Monitor mode would not tx packets and still follow standard. We will
> keep tracking this point to avoid violations.

Hi Deren,

this IEEE80211_CONF_MONITOR flags indicates there is a monitor interface,
not it is the only one so we can have multiple vifs on the device
(e.g. AP + monitor). I was wondering if CH_SWITCH_SCAN_BYPASS_DPD is used
to avoid transmitting packets during chip calibration on DFS channels.

Regards,
Lorenzo

>=20
>=20
> Regards,
> Deren
>=20
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >  		req.switch_reason =3D CH_SWITCH_NORMAL;
> > >  	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
> > >  		req.switch_reason =3D CH_SWITCH_SCAN_BYPASS_DPD;
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> > > b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> > > index 10dc4bf5adec..c56d48342aaf 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> > > @@ -2833,7 +2833,8 @@ int mt7915_mcu_set_chan_info(struct
> > > mt7915_phy *phy, int cmd)
> > >  	}
> > >  #endif
> > > =20
> > > -	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH))
> > > +	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH) ||
> > > +	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
> > >  		req.switch_reason =3D CH_SWITCH_NORMAL;
> > >  	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
> > >  		req.switch_reason =3D CH_SWITCH_SCAN_BYPASS_DPD;
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > > b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > > index 5ef8b24f0ab3..da2be050ed7c 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > > @@ -863,7 +863,8 @@ int mt7921_mcu_set_chan_info(struct mt7921_phy
> > > *phy, int cmd)
> > >  	else
> > >  		req.channel_band =3D chandef->chan->band;
> > > =20
> > > -	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH))
> > > +	if (cmd =3D=3D MCU_EXT_CMD(SET_RX_PATH) ||
> > > +	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
> > >  		req.switch_reason =3D CH_SWITCH_NORMAL;
> > >  	else if (dev->mt76.hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
> > >  		req.switch_reason =3D CH_SWITCH_SCAN_BYPASS_DPD;
> > > --=20
> > > 2.18.0
> > >=20
>=20

--AuwHAuPZagE1dC5E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYjL5eQAKCRA6cBh0uS2t
rHeaAP9rpvWFTEXCqoSqp2KBbPfjlbHUhLkVwIYctyl72HZEXAD/TlpNfsswC5Of
65WCUQJGGY7nSTVIzV2Msoim8lT3RwY=
=e04/
-----END PGP SIGNATURE-----

--AuwHAuPZagE1dC5E--


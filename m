Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFBE4D0132
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 15:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbiCGO26 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 09:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiCGO25 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 09:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 838B01EACB
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 06:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646663281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FFpozJq6RMgGzgt6zubmvdbNekdO+2Rf6+eqvcT21cE=;
        b=L2/VVhaMxxiRpUQLwNnxOvw9rLbdWCiFuY8IR38gP6RoHjtRPyR6rc6r1oHyd1LVwKpbLs
        29xBWUQn8l+m+TcXkErXS74moPYjPn6IH2FvsPZYz2XdGiEFPrlaqBg3aHviKAehTZYBJH
        gX4u9gT4G3ikIwRtXp7p4DhRZHTCQ5Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-dIkge7hWO8qdE5D1XW5w6g-1; Mon, 07 Mar 2022 09:28:00 -0500
X-MC-Unique: dIkge7hWO8qdE5D1XW5w6g-1
Received: by mail-wr1-f71.google.com with SMTP id l10-20020a05600012ca00b001f1e4669c98so926327wrx.23
        for <linux-wireless@vger.kernel.org>; Mon, 07 Mar 2022 06:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FFpozJq6RMgGzgt6zubmvdbNekdO+2Rf6+eqvcT21cE=;
        b=wwwEM7m8K5xv4BmtfEjgdd30KU0PwJqbkkUuh1MFf9dC97KaYAl6IcFMYYdcZnZ7BD
         kBi+DMppc+4L0Fmqd4zghqee5ssnS6EXAZttoyRSefmUP6eYWyuFc262Yg6r1bI4g4Os
         s3jD8NPfNWai1bwGTTIvIjk9wO5b1HNXSH7q0R+70SBZxclvjNkUxXWNhV1XJRh7yOaA
         dp2A0TtxjLfp+xOf2zqE2WS94d3pVSCbbXDGKv76OY21+f2Stg1qauitDM0IsOJBPDVN
         0frCdyh6Z+p6O6ZKL84wu/ay8kq/HMcR1lcwHo/WM73kejbuozX8Nrn23YFc0L/aZNl+
         Jsqg==
X-Gm-Message-State: AOAM530vil6wecfmUO3vhhNuWEV50wCdBFY5UMrfdnVIdF6kDWFpN2k2
        a1l9DkYuoSlcic9Q7Puvn3Vp1BXZUQWniEnaVH8mSSLyIY0vcDf1QBXNTs4lgK4App2GmRbzMB/
        wUZvjmcaQkXJkH20QjqQUJ8u2Qt4=
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id m3-20020a7bcb83000000b0037ebc503c6bmr18314424wmi.67.1646663278720;
        Mon, 07 Mar 2022 06:27:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBMguA6kjniQljQ0HZdDRMfHjXUgTJHJM7xxkvd5iBNAWLkpXR9EA2VjxiwB+Uh9acEEbhAA==
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id m3-20020a7bcb83000000b0037ebc503c6bmr18314411wmi.67.1646663278427;
        Mon, 07 Mar 2022 06:27:58 -0800 (PST)
Received: from localhost ([37.183.9.66])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0037bd5fabd10sm15131555wmq.48.2022.03.07.06.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:27:58 -0800 (PST)
Date:   Mon, 7 Mar 2022 15:27:56 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] mt76: mt7921: move mt7921_init_hw in a dedicated work
Message-ID: <YiYWbFLhV7+Sw9zM@lore-desk>
References: <0358e31e71481dec87f7ecb3b040db53076ffc4a.1646654230.git.lorenzo@kernel.org>
 <CAJ0CqmWQxORW8+++DVW3ujYccfCq_DB5hNOMn+gMs8kgoTk=5w@mail.gmail.com>
 <700fc094dbca7406326dde1b169c2d2fe6a1bb24.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bfAh3h8oI8IIWJTO"
Content-Disposition: inline
In-Reply-To: <700fc094dbca7406326dde1b169c2d2fe6a1bb24.camel@mediatek.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--bfAh3h8oI8IIWJTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 2022-03-07 at 13:00 +0100, Lorenzo Bianconi wrote:
> > >=20
> > > Firmware initialization can take a while. Move mt7921_init_hw
> > > routine in
> > > a dedicated work in order to not slow down bootstrap process.
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >=20
> > Hi Sean and Deren,
> >=20
> > I tested this patch on mt7921e and mt7921u. Can you double check if
> > it
> > works fine even on mt7921s? Thanks.
> >=20
> > Regards,
> > Lorenzo
>=20
> Hi Lore,

Hi Deren,

>=20
> The patch is good on normal initial flow with mt7921s. However, if I
> run command "insmod mt7921s && rmmod mt7921s" quickly, there would be
> some problems in the remove process. The problem can be avoided if
> adding "cancel_work_sync(&dev->init_work)" in unregiser hook.
>=20
> I think the patch is still good now and we may need another patch to
> cover the stress problem.
>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>

ack, I will include it in v2 as soon as the other pending patches are appli=
ed.
Thanks.

Regards,
Lorenzo

>=20
>=20
> >=20
> > > ---
> > >  .../net/wireless/mediatek/mt76/mt7921/init.c  | 66 +++++++++++++
> > > ------
> > >  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
> > >  2 files changed, 49 insertions(+), 19 deletions(-)
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > index fa6af85bba7b..332af886b95a 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > @@ -165,7 +165,7 @@ static int __mt7921_init_hardware(struct
> > > mt7921_dev *dev)
> > >=20
> > >  static int mt7921_init_hardware(struct mt7921_dev *dev)
> > >  {
> > > -       int ret, idx, i;
> > > +       int ret, i;
> > >=20
> > >         set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
> > >=20
> > > @@ -182,6 +182,13 @@ static int mt7921_init_hardware(struct
> > > mt7921_dev *dev)
> > >                 return ret;
> > >         }
> > >=20
> > > +       return 0;
> > > +}
> > > +
> > > +static int mt7921_init_wcid(struct mt7921_dev *dev)
> > > +{
> > > +       int idx;
> > > +
> > >         /* Beacon and mgmt frames should occupy wcid 0 */
> > >         idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA
> > > - 1);
> > >         if (idx)
> > > @@ -195,6 +202,42 @@ static int mt7921_init_hardware(struct
> > > mt7921_dev *dev)
> > >         return 0;
> > >  }
> > >=20
> > > +static void mt7921_init_work(struct work_struct *work)
> > > +{
> > > +       struct mt7921_dev *dev =3D container_of(work, struct
> > > mt7921_dev,
> > > +                                             init_work);
> > > +       int ret;
> > > +
> > > +       ret =3D mt7921_init_hardware(dev);
> > > +       if (ret)
> > > +               return;
> > > +
> > > +       mt76_set_stream_caps(&dev->mphy, true);
> > > +       mt7921_set_stream_he_caps(&dev->phy);
> > > +
> > > +       ret =3D mt76_register_device(&dev->mt76, true, mt76_rates,
> > > +                                  ARRAY_SIZE(mt76_rates));
> > > +       if (ret) {
> > > +               dev_err(dev->mt76.dev, "register device failed\n");
> > > +               return;
> > > +       }
> > > +
> > > +       ret =3D mt7921_init_debugfs(dev);
> > > +       if (ret) {
> > > +               dev_err(dev->mt76.dev, "debugfs register
> > > failed\n");
> > > +               goto error;
> > > +       }
> > > +
> > > +       ret =3D mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev-
> > > >pm.ds_enable);
> > > +       if (ret)
> > > +               goto error;
> > > +
> > > +       dev->hw_init_done =3D true;
> > > +       return;
> > > +error:
> > > +       mt76_unregister_device(&dev->mt76);
> > > +}
> > > +
> > >  int mt7921_register_device(struct mt7921_dev *dev)
> > >  {
> > >         struct ieee80211_hw *hw =3D mt76_hw(dev);
> > > @@ -222,6 +265,7 @@ int mt7921_register_device(struct mt7921_dev
> > > *dev)
> > >         spin_lock_init(&dev->sta_poll_lock);
> > >=20
> > >         INIT_WORK(&dev->reset_work, mt7921_mac_reset_work);
> > > +       INIT_WORK(&dev->init_work, mt7921_init_work);
> > >=20
> > >         dev->pm.idle_timeout =3D MT7921_PM_TIMEOUT;
> > >         dev->pm.stats.last_wake_event =3D jiffies;
> > > @@ -234,7 +278,7 @@ int mt7921_register_device(struct mt7921_dev
> > > *dev)
> > >         if (mt76_is_sdio(&dev->mt76))
> > >                 hw->extra_tx_headroom +=3D MT_SDIO_TXD_SIZE +
> > > MT_SDIO_HDR_SIZE;
> > >=20
> > > -       ret =3D mt7921_init_hardware(dev);
> > > +       ret =3D mt7921_init_wcid(dev);
> > >         if (ret)
> > >                 return ret;
> > >=20
> > > @@ -262,23 +306,7 @@ int mt7921_register_device(struct mt7921_dev
> > > *dev)
> > >         dev->mphy.hw->wiphy->available_antennas_rx =3D dev-
> > > >mphy.chainmask;
> > >         dev->mphy.hw->wiphy->available_antennas_tx =3D dev-
> > > >mphy.chainmask;
> > >=20
> > > -       mt76_set_stream_caps(&dev->mphy, true);
> > > -       mt7921_set_stream_he_caps(&dev->phy);
> > > -
> > > -       ret =3D mt76_register_device(&dev->mt76, true, mt76_rates,
> > > -                                  ARRAY_SIZE(mt76_rates));
> > > -       if (ret)
> > > -               return ret;
> > > -
> > > -       ret =3D mt7921_init_debugfs(dev);
> > > -       if (ret)
> > > -               return ret;
> > > -
> > > -       ret =3D mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev-
> > > >pm.ds_enable);
> > > -       if (ret)
> > > -               return ret;
> > > -
> > > -       dev->hw_init_done =3D true;
> > > +       queue_work(system_wq, &dev->init_work);
> > >=20
> > >         return 0;
> > >  }
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > > b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > > index 394a677140da..b6c8f84acb64 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> > > @@ -204,6 +204,8 @@ struct mt7921_dev {
> > >         struct list_head sta_poll_list;
> > >         spinlock_t sta_poll_lock;
> > >=20
> > > +       struct work_struct init_work;
> > > +
> > >         u8 fw_debug;
> > >=20
> > >         struct mt76_connac_pm pm;
> > > --
> > > 2.35.1
> > >=20
> >=20
> >=20
>=20

--bfAh3h8oI8IIWJTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYiYWawAKCRA6cBh0uS2t
rDt/AQDGyBzMm0iYd8AaE4VnyZlhjz3tXsGR4zVFO5s1kIcK9gD/bBIJ8SN9yqwA
kQe+AfJCkXdWOZkDoPyufNevqLkGUAE=
=yglT
-----END PGP SIGNATURE-----

--bfAh3h8oI8IIWJTO--


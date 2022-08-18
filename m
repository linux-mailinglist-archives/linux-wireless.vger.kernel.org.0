Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF751597F5D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 09:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbiHRHjd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 03:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243621AbiHRHja (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 03:39:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231792B24D
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 00:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FF06B81BAF
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 07:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5910DC433D7;
        Thu, 18 Aug 2022 07:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660808365;
        bh=sH0amc1oQGzoAx6pTnDSo2dE4ufvfCYoouKwkZPO7eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sS+PPvzx/vTOy2Z6pKTG1pDTeuG2A+I7oYn/PXOJu5tNAewCl7Ajfg65wU/7/C990
         O6lg4oGzH4MGY6eXuyG0m2yNmPuajrMAaSMVrB/exAb2yM4lQYY8o/FYVTffRSDfRb
         Bydx544aU+bIjdoxCI5meX0VN4MBaEhZx+IPVo5pWNSdTg4jYLsIQKv6xljJetfB4K
         SbMLR3WE6My0hHtmuOMeGgkIta6T8+5m1VWPS8xJGpKDOg7UuH0i2Nf12F0mM+yXyV
         A8INz718eaHV19DMmb1bJfoJa6iUryp2zsJC4uWddBytwSYVz6UJW+ehG69TwBdlQG
         dyxgefqhgYCIw==
Date:   Thu, 18 Aug 2022 09:39:22 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Sean Wang =?utf-8?B?KOeOi+W/l+S6mCk=?= <sean.wang@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, lorenzo.bianconi@redhat.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren Wu <Deren.Wu@mediatek.com>, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 8/9] wifi: mt76: mt7921: introduce remain_on_channel
 support
Message-ID: <Yv3sqvhXnGiOpKkE@lore-desk>
References: <cover.1660606893.git.objelf@gmail.com>
 <f48a750e8ad17d5b2410eea03fc30a6403732168.1660606893.git.objelf@gmail.com>
 <YvyUwEdURYHiAduf@lore-desk>
 <CAGp9LzrvVQOrUNPR8aguUTgWo1wZFMR2Y3kdTk8WqxmG=B8--w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3UM8ZQzh0v68rXAd"
Content-Disposition: inline
In-Reply-To: <CAGp9LzrvVQOrUNPR8aguUTgWo1wZFMR2Y3kdTk8WqxmG=B8--w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--3UM8ZQzh0v68rXAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> On Wed, Aug 17, 2022 at 12:18 AM Lorenzo Bianconi <lorenzo@kernel.org> wr=
ote:
> >
> > > From: Sean Wang <sean.wang@mediatek.com>
> > >
> > > Introduce remain_on_channel support. Additionally, we add
> > > mt7921_check_offload_capability to disable .remain_on_channel and
> > > .cancel_remain_on_channel and related configuration because those
> > > operations would rely on the fundamental MCU commands that will be on=
ly
> > > supported with newer firmware.
> > >
> > > Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> > > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > ---
> > >  .../net/wireless/mediatek/mt76/mt7921/init.c  |  36 ++++++
> > >  .../net/wireless/mediatek/mt76/mt7921/main.c  | 112 ++++++++++++++++=
++
> > >  .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  24 ++++
> > >  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  34 ++++++
> > >  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  13 +-
> > >  .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  11 +-
> > >  .../net/wireless/mediatek/mt76/mt7921/usb.c   |   1 +
> > >  7 files changed, 225 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drive=
rs/net/wireless/mediatek/mt76/mt7921/init.c
> > > index cd960e23770f..1b7a18d42f5b 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > @@ -44,6 +44,35 @@ mt7921_regd_notifier(struct wiphy *wiphy,
> > >       mt7921_mutex_release(dev);
> > >  }
> > >
> > > +static int mt7921_check_offload_capability(struct mt7921_dev *dev)
> > > +{
> > > +     struct ieee80211_hw *hw =3D mt76_hw(dev);
> > > +     int year, mon, day, hour, min, sec;
> > > +     struct wiphy *wiphy =3D hw->wiphy;
> > > +     bool fw_can_roc =3D false;
> > > +     int ret;
> > > +
> > > +     ret =3D sscanf(dev->mt76.hw->wiphy->fw_version + 11, "%4d%2d%2d=
%2d%2d%2d",
> > > +                  &year, &mon, &day, &hour, &min, &sec);
> >
> > does the fw have a differnt base version with respect to the previous o=
nes?
> > checking the date is a bit ugly.
>=20
> I admitted that way was a bit ugly, but I have investigated for a
> while, and that is the only way we can use to distinguish the version
> in current mt7921 firmware.

the fw seems pretty new (2022/7/15), is it already available in linux-firmw=
are
git tree? If not I guess you can increment fw version in a more evident way.
For the future please remember to do it for major fw changes.

>=20
> >
> > > +     if (ret !=3D 6)
> > > +             goto out;
> > > +
> > > +     /* Old firmware cannot support remained on channel and channel
> > > +      * context management.
> > > +      */
> > > +     fw_can_roc =3D  mktime64(year, mon, day, hour, min, sec) >=3D
> > > +                   mktime64(2022, 7, 15, 12, 1, 1);
> > > +out:
> > > +     if (!fw_can_roc) {
> > > +             dev->ops->remain_on_channel =3D NULL;
> > > +             dev->ops->cancel_remain_on_channel =3D NULL;
> > > +
> > > +             wiphy->flags &=3D ~WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
>=20
> <snip>
>=20
> > > -     mdev =3D mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_op=
s,
> > > -                              &drv_ops);
> > > +     ops =3D devm_kmemdup(&pdev->dev, &mt7921_ops, sizeof(mt7921_ops=
),
> > > +                        GFP_KERNEL);
> >
> > why do we need to copy mt7921_ops?
> >
>=20
> As the old fw cannot support the roc and chanctx and considering
> backward compatibility, I need to copy the mt7921_ops here and
> disable related operations for old fw before registering the hw to mac802=
11.

ack, right.

Regards,
Lorenzo

>=20
>      Sean
>=20
> > Regards,
> > Lorenzo
> >
> > > +     if (!ops) {
> > > +             ret =3D -ENOMEM;
> > > +             goto err_free_pci_vec;
> > > +     }
> > > +
> > > +     mdev =3D mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_=
ops);
> > >       if (!mdev) {
> > >               ret =3D -ENOMEM;
> > >               goto err_free_pci_vec;
> > > @@ -286,7 +293,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
> > >
> > >       dev =3D container_of(mdev, struct mt7921_dev, mt76);
> > >       dev->hif_ops =3D &mt7921_pcie_ops;
> > > -
> > > +     dev->ops =3D ops;
> > >       mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
> > >       tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned l=
ong)dev);
> > >
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drive=
rs/net/wireless/mediatek/mt76/mt7921/sdio.c
> > > index 487acd6e2be8..6d27875f41b8 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> > > @@ -120,18 +120,23 @@ static int mt7921s_probe(struct sdio_func *func,
> > >               .fw_own =3D mt7921s_mcu_fw_pmctrl,
> > >       };
> > >
> > > +     struct ieee80211_ops *ops;
> > >       struct mt7921_dev *dev;
> > >       struct mt76_dev *mdev;
> > >       int ret;
> > >
> > > -     mdev =3D mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_op=
s,
> > > -                              &drv_ops);
> > > +     ops =3D devm_kmemdup(&func->dev, &mt7921_ops, sizeof(mt7921_ops=
),
> > > +                        GFP_KERNEL);
> > > +     if (!ops)
> > > +             return -ENOMEM;
> > > +
> > > +     mdev =3D mt76_alloc_device(&func->dev, sizeof(*dev), ops, &drv_=
ops);
> > >       if (!mdev)
> > >               return -ENOMEM;
> > >
> > >       dev =3D container_of(mdev, struct mt7921_dev, mt76);
> > >       dev->hif_ops =3D &mt7921_sdio_ops;
> > > -
> > > +     dev->ops =3D ops;
> > >       sdio_set_drvdata(func, dev);
> > >
> > >       ret =3D mt76s_init(mdev, func, &mt7921s_ops);
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/usb.c
> > > index d06cee386acd..cf3ec59a4270 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> > > @@ -217,6 +217,7 @@ static int mt7921u_probe(struct usb_interface *us=
b_intf,
> > >
> > >       dev =3D container_of(mdev, struct mt7921_dev, mt76);
> > >       dev->hif_ops =3D &hif_ops;
> > > +     dev->ops =3D ops;
> > >
> > >       udev =3D usb_get_dev(udev);
> > >       usb_reset_device(udev);
> > > --
> > > 2.25.1
> > >

--3UM8ZQzh0v68rXAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYv3sqQAKCRA6cBh0uS2t
rFZiAQCjVE2G83nEhykFqvrmQDycLZfoVOVpNo2bSixUSKciLQEAgnQ5ZQSRmaSw
VY39dBMtdmjpyiKfolq8q7Q5ghNJ0wg=
=I+5d
-----END PGP SIGNATURE-----

--3UM8ZQzh0v68rXAd--

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F88708ABC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjERVuY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjERVuX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 17:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610ECE7A
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 14:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAB1D65265
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 21:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B9DC433D2;
        Thu, 18 May 2023 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684446621;
        bh=d4QQ61ZSMghe8tSspFIwBhXqAKHIUixZPK8avoQLJWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1LntZtYFmae3HC1DnGr5+Ml1tYRaldtoj8Iv1vIJNakOirfHORp1ofTd2Vv53cxm
         o4Tm/UiZmWx+QvvjeAHxQ2wJk9LtXjplGt9Ow4N2ivapAtf1CNSVY+7wx+ZgoBGLhT
         k9GUrnOu+4UfFjU8n49lXMgvtsT5BRf17nKAeYm+1pYeK1kbPzkNIc+Ye3BYgyFMFX
         +iz971/OpM5WsEdy27ovn7NxRDhVKD08OAieMG5ZUjGbElHimNH23YHgNZIwQ8UwJA
         BuILusmxkTxmf22ueI9upLudeJAgMZK2z+VJ1QT0M/w27b/mNdfC1h/WeZkUNFwaKm
         X5MxsLlM/8L6g==
Date:   Thu, 18 May 2023 23:51:27 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7921: Support temp sensor.
Message-ID: <ZGad36FQEK2/MduJ@localhost.localdomain>
References: <20230518200718.1367381-1-greearb@candelatech.com>
 <ZGaNm8mMfbqdtWa0@lore-desk>
 <43d01aa8-b594-2770-59d0-13e6388c5758@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C6NMl48XVxljFi9E"
Content-Disposition: inline
In-Reply-To: <43d01aa8-b594-2770-59d0-13e6388c5758@candelatech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--C6NMl48XVxljFi9E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 5/18/23 13:42, Lorenzo Bianconi wrote:
> > > From: Ben Greear <greearb@candelatech.com>
> > >=20
> > > Allow sensors tool to read radio's temperature, example:
> > >=20
> > > mt7921_phy17-pci-1800
> > > Adapter: PCI adapter
> > > temp1:        +72.0=B0C
> > >=20
> > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > > ---
> > >   .../net/wireless/mediatek/mt76/mt7921/init.c  | 53 ++++++++++++++++=
+++
> > >   .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 17 ++++++
> > >   .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
> > >   3 files changed, 71 insertions(+)
> > >=20
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drive=
rs/net/wireless/mediatek/mt76/mt7921/init.c
> > > index c15ce1a19000..18f0f2dfbbcf 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> > > @@ -2,6 +2,9 @@
> > >   /* Copyright (C) 2020 MediaTek Inc. */
> > >   #include <linux/etherdevice.h>
> > > +#include <linux/hwmon.h>
> > > +#include <linux/hwmon-sysfs.h>
> > > +#include <linux/thermal.h>
> > >   #include <linux/firmware.h>
> > >   #include "mt7921.h"
> > >   #include "../mt76_connac2_mac.h"
> > > @@ -58,6 +61,50 @@ static const struct ieee80211_iface_combination if=
_comb_chanctx[] =3D {
> > >   	}
> > >   };
> > > +static ssize_t mt7921_thermal_temp_show(struct device *dev,
> > > +					struct device_attribute *attr,
> > > +					char *buf)
> > > +{
> > > +	struct mt7921_phy *phy =3D dev_get_drvdata(dev);
> > > +	int i =3D to_sensor_dev_attr(attr)->index;
> > > +	int temperature;
> > > +
> > > +	switch (i) {
> >=20
> > nit: you can drop i and just use to_sensor_dev_attr(attr)->index
> >=20
> > > +	case 0:
> >=20
> > I think you need to wake the device up here running mt7921_mutex_acquire
> > before sending the mcu command.
>=20
> I need to wake it up and acquire a mutex, or does acquiring the mutex wak=
e it
> automatically?

acquiring the lock with mt7921_mutex_acquire() will wake the device up.

>=20
> And, mt7915 has some other logic in this area.  I left the switch logic in
> to match that, thinking maybe later we can add the other options to 7921?
>=20
> Do you know if 7921 supports the other options like 7915?

nope.

Regards,
Lorenzo

>=20
> Thanks,
> Ben
>=20
>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>=20
>=20

--C6NMl48XVxljFi9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZGad3AAKCRA6cBh0uS2t
rKpRAP45Q8ZJSJ861BW/+1ZNwmE5X85hvzWDVsKKDr/NKKPZNAEAtZd2ZwzS8Mvb
IgPiZiSAzc4BeRq+j9BeZPrSiSnPJgM=
=wmMR
-----END PGP SIGNATURE-----

--C6NMl48XVxljFi9E--

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB297089AF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 22:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjERUmK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjERUmJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 16:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00648E77
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 13:42:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9174765156
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 20:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C595C433D2;
        Thu, 18 May 2023 20:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684442527;
        bh=jNFqD115gyQICnfT+kDx7ARTLX1QxehqNz+k44hPym8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVR0hY/96YYWk4hkh1Bjn2QUMBsp6QluTLgFXvmR8P0PrH/Lkj+8UGJtFUoYhJ08Z
         88ntDBqmCv8ikkfc+w+1OimSdkZ+X4478Gq0NkCA9SdYkhcassvgM554SMhJzBgcSx
         aD9MDycmqH5b6tYZJgc0lTCGPV1kOrf7SP2mj8I7r+8nwau/EpPs5BmmMUgtpNLGQ5
         V/OpWMMcYoh3+vFpGrk04c4QWtryutQQGPeZTagJPmRnNPvvPLd2waw+jaRavnWKq7
         4wfreUMACbu0avXP4dw4Rb7GR7MJL+u1gHV2VHe5jf/u/rR22W96E3zvVxOaZFaccz
         3bNDSTZli+ifA==
Date:   Thu, 18 May 2023 22:42:03 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7921:  Support temp sensor.
Message-ID: <ZGaNm8mMfbqdtWa0@lore-desk>
References: <20230518200718.1367381-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JTBVpOe4gWSqFGQd"
Content-Disposition: inline
In-Reply-To: <20230518200718.1367381-1-greearb@candelatech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--JTBVpOe4gWSqFGQd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> Allow sensors tool to read radio's temperature, example:
>=20
> mt7921_phy17-pci-1800
> Adapter: PCI adapter
> temp1:        +72.0=B0C
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/init.c  | 53 +++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 17 ++++++
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
>  3 files changed, 71 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index c15ce1a19000..18f0f2dfbbcf 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -2,6 +2,9 @@
>  /* Copyright (C) 2020 MediaTek Inc. */
> =20
>  #include <linux/etherdevice.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/thermal.h>
>  #include <linux/firmware.h>
>  #include "mt7921.h"
>  #include "../mt76_connac2_mac.h"
> @@ -58,6 +61,50 @@ static const struct ieee80211_iface_combination if_com=
b_chanctx[] =3D {
>  	}
>  };
> =20
> +static ssize_t mt7921_thermal_temp_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct mt7921_phy *phy =3D dev_get_drvdata(dev);
> +	int i =3D to_sensor_dev_attr(attr)->index;
> +	int temperature;
> +
> +	switch (i) {

nit: you can drop i and just use to_sensor_dev_attr(attr)->index

> +	case 0:

I think you need to wake the device up here running mt7921_mutex_acquire
before sending the mcu command.

nit: you can move temperature variable definition here.

Regards,
Lorenzo

> +		temperature =3D mt7921_mcu_get_temperature(phy);
> +		if (temperature < 0)
> +			return temperature;
> +		/* display in millidegree celcius */
> +		return sprintf(buf, "%u\n", temperature * 1000);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +static SENSOR_DEVICE_ATTR_RO(temp1_input, mt7921_thermal_temp, 0);
> +
> +static struct attribute *mt7921_hwmon_attrs[] =3D {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(mt7921_hwmon);
> +
> +static int mt7921_thermal_init(struct mt7921_phy *phy)
> +{
> +	struct wiphy *wiphy =3D phy->mt76->hw->wiphy;
> +	struct device *hwmon;
> +	const char *name;
> +
> +	name =3D devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7921_%s",
> +			      wiphy_name(wiphy));
> +
> +	hwmon =3D devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
> +						       mt7921_hwmon_groups);
> +	if (IS_ERR(hwmon))
> +		return PTR_ERR(hwmon);
> +
> +	return 0;
> +}
> +
>  static void
>  mt7921_regd_notifier(struct wiphy *wiphy,
>  		     struct regulatory_request *request)
> @@ -384,6 +431,12 @@ static void mt7921_init_work(struct work_struct *wor=
k)
>  		return;
>  	}
> =20
> +	ret =3D mt7921_thermal_init(&dev->phy);
> +	if (ret) {
> +		dev_err(dev->mt76.dev, "thermal_init failed\n");
> +		return;
> +	}
> +
>  	/* we support chip reset now */
>  	dev->hw_init_done =3D true;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 9c4dcc0e5a7c..abeedacc28f2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -1346,6 +1346,23 @@ int mt7921_mcu_set_clc(struct mt7921_dev *dev, u8 =
*alpha2,
>  	return 0;
>  }
> =20
> +int mt7921_mcu_get_temperature(struct mt7921_phy *phy)
> +{
> +	struct mt7921_dev *dev =3D phy->dev;
> +	struct {
> +		u8 ctrl_id;
> +		u8 action;
> +		u8 band_idx;
> +		u8 rsv[5];
> +	} req =3D {
> +		.ctrl_id =3D THERMAL_SENSOR_TEMP_QUERY,
> +		.band_idx =3D phy->mt76->band_idx,
> +	};
> +
> +	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_CTRL), &req,
> +				 sizeof(req), true);
> +}
> +
>  int mt7921_mcu_set_rxfilter(struct mt7921_dev *dev, u32 fif,
>  			    u8 bit_op, u32 bit_map)
>  {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 706f00df6836..85fddf99d497 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -568,6 +568,7 @@ int mt7921_mcu_set_sniffer(struct mt7921_dev *dev, st=
ruct ieee80211_vif *vif,
>  			   bool enable);
>  int mt7921_mcu_config_sniffer(struct mt7921_vif *vif,
>  			      struct ieee80211_chanctx_conf *ctx);
> +int mt7921_mcu_get_temperature(struct mt7921_phy *phy);
> =20
>  int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
>  				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
> --=20
> 2.40.0
>=20

--JTBVpOe4gWSqFGQd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZGaNmwAKCRA6cBh0uS2t
rBvFAP9sUjwrhYZkvjReODj4DYUL9K0RDF0MkdRmnglDJzf/XAD6ApnRk4UlVaFL
VHyFYRDFzGXVI3NLDJnxMGnCdL7+pAA=
=iKEf
-----END PGP SIGNATURE-----

--JTBVpOe4gWSqFGQd--

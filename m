Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7BD3637D5
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 23:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhDRV0u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 17:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232480AbhDRV0t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 17:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618781179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TPcs5TB0ONhcFVAEw0E0MCP+R2+YREZ08wBbXd6m+0c=;
        b=g9zj+ZYlbXEFv6SnC6bV0n2uTv8/uUDyI5a33HORnYPU8mhP1VFhtwer6IrZLU010MTVmv
        5WNb2+2FaYhPFyXdhkOu0WHljT+xmDL9T1I9yO0NQvtpvTt5+K/BdsN0FX8bUjUMj+TkGk
        Y0uJBj5mqsMjLOvWsc7Wuo0Ki+3tIOE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-IQzulNDvNT24AxU4rPgW5g-1; Sun, 18 Apr 2021 17:26:17 -0400
X-MC-Unique: IQzulNDvNT24AxU4rPgW5g-1
Received: by mail-ed1-f72.google.com with SMTP id f1-20020a0564021941b02903850806bb32so4101580edz.9
        for <linux-wireless@vger.kernel.org>; Sun, 18 Apr 2021 14:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TPcs5TB0ONhcFVAEw0E0MCP+R2+YREZ08wBbXd6m+0c=;
        b=ZtThR7Y45zeSXEed8gHzRFbhinhqyXDiQ5qfC4jr4tRPQCjbrFDjg7M8FVJbXagp9i
         eUFn3wk+bTTm76YCy2OzOLnHbaZlAMJfLEy+pV94D7c+jPxF/eSL4qKRtauir0CBzUkk
         1shQ+9QYmmhOYbaUnTETULUQ8j7gTsCgrkLNCXqQ2nHmprsv8ejXRDrwyNQD3nrIONOf
         ylZdn1tAZyeFGyGSY7SleJEJg+p3d6SyIMZz3dpx/MXGZ1OFCYMETnKdNku+E9wrJtqr
         oIaopA+D1sKJpBFtX+phC9vGPKZNZJMapc3ELoNT+wzsfDqh5rb4Fyvsi4ZBhgPv9SdH
         75yQ==
X-Gm-Message-State: AOAM530v0jLEVK0NjulTexjWbRM9hhJUQ1wuLK/aOCR97qgywPryKPOA
        ixuB9OurWFhBVvWRra8GIAf4IDkzMu0yIP0NAlX6fIoHNzHhfIdPNdZ6dBC0Ku/6bczx/x5cY4B
        nA9W5cakVWGkamnW5ujENV3OwWEA=
X-Received: by 2002:a17:906:3e54:: with SMTP id t20mr18905027eji.53.1618781176568;
        Sun, 18 Apr 2021 14:26:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBKJZIgQlc9hQywL+WtI+KLt35fb6/JZtjFfLmtl/EiX87D0fiTdVmmH6NDI4Gb6cbNDZ6cQ==
X-Received: by 2002:a17:906:3e54:: with SMTP id t20mr18905020eji.53.1618781176413;
        Sun, 18 Apr 2021 14:26:16 -0700 (PDT)
Received: from localhost ([151.66.28.185])
        by smtp.gmail.com with ESMTPSA id s20sm11194233edu.93.2021.04.18.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 14:26:15 -0700 (PDT)
Date:   Sun, 18 Apr 2021 23:26:12 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7915: add thermal sensor device support
Message-ID: <YHyj9H52zgoDXWbN@lore-desk>
References: <b51d79d257e150a09d51029e3465e2ce925d6cfe.1618691395.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TFPJU7dGCv8470U4"
Content-Disposition: inline
In-Reply-To: <b51d79d257e150a09d51029e3465e2ce925d6cfe.1618691395.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--TFPJU7dGCv8470U4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> =20
> +static ssize_t mt7915_thermal_show_temp(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct mt7915_phy *phy =3D dev_get_drvdata(dev);
> +	int temperature;
> +
> +	mutex_lock(&phy->dev->mt76.mutex);
> +	temperature =3D mt7915_mcu_get_temperature(phy);
> +	mutex_unlock(&phy->dev->mt76.mutex);

I guess we do not need this lock here since mcu already has its own lock (m=
cu
mutex) and mt7915 does not support runtime-pm.

Regards,
Lorenzo

> +
> +	if (temperature < 0)
> +		return temperature;
> +
> +	/* display in millidegree celcius */
> +	return sprintf(buf, "%u\n", temperature * 1000);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, 0444, mt7915_thermal_show_temp,
> +			  NULL, 0);
> +
> +static struct attribute *mt7915_hwmon_attrs[] =3D {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(mt7915_hwmon);
> +
> +static int mt7915_thermal_init(struct mt7915_phy *phy)
> +{
> +	struct wiphy *wiphy =3D phy->mt76->hw->wiphy;
> +	struct device *hwmon;
> +
> +	/* TODO: add cooling device for throttling */
> +
> +	if (!IS_REACHABLE(CONFIG_HWMON))
> +		return 0;
> +
> +	hwmon =3D devm_hwmon_device_register_with_groups(&wiphy->dev,
> +						       wiphy_name(wiphy), phy,
> +						       mt7915_hwmon_groups);
> +	if (IS_ERR(hwmon))
> +		return PTR_ERR(hwmon);
> +
> +	return 0;
> +}
> +
>  static void
>  mt7915_init_txpower(struct mt7915_dev *dev,
>  		    struct ieee80211_supported_band *sband)
> @@ -286,6 +334,10 @@ static int mt7915_register_ext_phy(struct mt7915_dev=
 *dev)
>  	if (ret)
>  		goto error;
> =20
> +	ret =3D mt7915_thermal_init(phy);
> +	if (ret)
> +		goto error;
> +
>  	return 0;
> =20
>  error:
> @@ -739,6 +791,10 @@ int mt7915_register_device(struct mt7915_dev *dev)
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D mt7915_thermal_init(&dev->phy);
> +	if (ret)
> +		return ret;
> +
>  	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
> =20
>  	ret =3D mt7915_register_ext_phy(dev);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index 559ad230eabe..17a617df6dba 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -3469,16 +3469,17 @@ int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *ph=
y)
>  	return 0;
>  }
> =20
> -int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index)
> +int mt7915_mcu_get_temperature(struct mt7915_phy *phy)
>  {
> +	struct mt7915_dev *dev =3D phy->dev;
>  	struct {
>  		u8 ctrl_id;
>  		u8 action;
> -		u8 band;
> +		u8 dbdc_idx;
>  		u8 rsv[5];
>  	} req =3D {
>  		.ctrl_id =3D THERMAL_SENSOR_TEMP_QUERY,
> -		.action =3D index,
> +		.dbdc_idx =3D phy !=3D &dev->phy,
>  	};
> =20
>  	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_CTRL), &req,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers=
/net/wireless/mediatek/mt76/mt7915/mt7915.h
> index 80eb35231a1a..d5296e2d481b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
> @@ -357,7 +357,7 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, i=
nt index,
>  			    const struct mt7915_dfs_pattern *pattern);
>  int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev);
>  int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy);
> -int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index);
> +int mt7915_mcu_get_temperature(struct mt7915_phy *phy);
>  int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx=
);
>  int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif =
*vif,
>  			   struct ieee80211_sta *sta, struct rate_info *rate);
> --=20
> 2.18.0
>=20

--TFPJU7dGCv8470U4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYHyj8gAKCRA6cBh0uS2t
rFc1AP0TzFM9UeSoGdkc3dw0YHYpaI+eTfh5nH0oLez6fUqLYgEAmuffVpsIXLN9
vSsV+rGBbRwtmHzZoNXIQqCWZRrHdg8=
=5nH8
-----END PGP SIGNATURE-----

--TFPJU7dGCv8470U4--


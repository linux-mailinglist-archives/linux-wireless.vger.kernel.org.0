Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3CF40C5FE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhIONPl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 09:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232940AbhIONPl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 09:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631711662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7oQ950/Pyu/LxpdrskR5m0WjgHUUF+FwtQRkRVzSQQ=;
        b=Msx5Fk53bTWJrayfoznS97wNIKrXltIDIM4kktPWUbgJCgY19OsGZzUq7Hr6iSYKMIlFB8
        P4IoNUV9n4jQ8NNwFLMXnLmFthX9nmNICxxJ/fT2x5HNjQ8uIDxwcPWVp02NSt2v9tqoUV
        rhc9CCgAAWdOaKkZOJ7qDP44cVcTfUE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-ZaqTuY5VNWKLjrIOhXlf8A-1; Wed, 15 Sep 2021 09:14:20 -0400
X-MC-Unique: ZaqTuY5VNWKLjrIOhXlf8A-1
Received: by mail-ed1-f71.google.com with SMTP id m20-20020aa7c2d4000000b003d1add00b8aso1629372edp.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 06:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7oQ950/Pyu/LxpdrskR5m0WjgHUUF+FwtQRkRVzSQQ=;
        b=KuH6+Bce7y8pte085fwLQxJhrMC+QcUjgY0reu7qMjezzCIxUp5UUQkB4g7NPNkHM4
         Ze7TvEAfrJ0nkSbVzUuD3L39vImk5vbnMygl2+ff50CWNSa7wEin98W1eKnnoMI9pN/Y
         ScwiIS/G/cvMwnzKTThzDT05vezqrvzkh4B1cAnhHro4dunrDr235Y+M+ZUiGx2udYai
         tG8FpC/bNSF3f9HMZw/mDoBEGmqaXx32mHz/Uu0WNDVHtWxz3rxAiBydj4TR4rlbt3Af
         3W88h+O4zxosaGuj0JjOBnyralW8QgVpyQfvmMtDhO2FcY4o9O3KogtkQL40zCRuqvY6
         4pTg==
X-Gm-Message-State: AOAM5306YmpmmyZLw7hV4qP4sCPX2D6HEy9bUL05EPKUtlSTaRAPQKoj
        c8cEUd7rZlPYBMn3ikVu86sOZdOXj6ef/bOdPWsb3F2PLu9UlMuvrCnIzCjemdUmvYkHp1zsX9r
        hvhmCiqd7UlzfEdkCyvLwrn1WBWE=
X-Received: by 2002:a17:906:31cf:: with SMTP id f15mr24774222ejf.272.1631711659460;
        Wed, 15 Sep 2021 06:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGx1iKfJAV1iZ9k4R1rPMLOWa4JNqnaSyvdsIlXHx/TO/17QrrkTfTFE0dbsSanw8jx3mWJw==
X-Received: by 2002:a17:906:31cf:: with SMTP id f15mr24774188ejf.272.1631711659115;
        Wed, 15 Sep 2021 06:14:19 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id e22sm7419235edu.35.2021.09.15.06.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:14:18 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:14:15 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        steve.lee@mediatek.com, jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 04/16] mt76: mt7921: refactor init.c to be bus
 independent
Message-ID: <YUHxpwccPHlVQSsW@lore-desk>
References: <cover.1631667941.git.objelf@gmail.com>
 <210a8cd3ab6698401b55a3268719d194cc96e0b5.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l6W5gynAvom1fuO+"
Content-Disposition: inline
In-Reply-To: <210a8cd3ab6698401b55a3268719d194cc96e0b5.1631667941.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--l6W5gynAvom1fuO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> This is a preliminary patch to introduce mt7921s support.
>=20
> Make init.c reusable between mt7921s and mt7921e
>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt7921/Makefile    |  4 +--
>  .../net/wireless/mediatek/mt76/mt7921/dma.c   |  8 ++++++
>  .../net/wireless/mediatek/mt76/mt7921/init.c  | 28 +------------------
>  .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 ++
>  .../net/wireless/mediatek/mt76/mt7921/pci.c   |  5 ++++
>  .../wireless/mediatek/mt76/mt7921/pci_init.c  | 26 +++++++++++++++++
>  6 files changed, 45 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_init.c
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers=
/net/wireless/mediatek/mt76/mt7921/Makefile
> index 4cb0b000cfe1..15f940a23ea9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
> @@ -4,6 +4,6 @@ obj-$(CONFIG_MT7921E) +=3D mt7921e.o
> =20
>  CFLAGS_trace.o :=3D -I$(src)
> =20
> -mt7921e-y :=3D pci.o pci_mac.o pci_mcu.o mac.o mcu.o dma.o eeprom.o main=
=2Eo \
> -	     init.o debugfs.o trace.o
> +mt7921e-y :=3D pci.o pci_mac.o pci_mcu.o pci_init.o mac.o mcu.o dma.o \
> +	     eeprom.o main.o init.o debugfs.o trace.o
>  mt7921e-$(CONFIG_NL80211_TESTMODE) +=3D testmode.o
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/dma.c
> index d3e2036a1974..be24241fb8e6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> @@ -313,6 +313,11 @@ int mt7921_wpdma_reset(struct mt7921_dev *dev, bool =
force)
>  	return 0;
>  }
> =20
> +int mt7921e_init_reset(struct mt7921_dev *dev)
> +{
> +	return mt7921_wpdma_reset(dev, true);
> +}

it seems used only in pci.c, right? maybe you can move it there and make it
static.

> +
>  int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev)
>  {
>  	struct mt76_connac_pm *pm =3D &dev->pm;
> @@ -343,6 +348,9 @@ int mt7921_dma_init(struct mt7921_dev *dev)
>  	struct mt76_bus_ops *bus_ops;
>  	int ret;
> =20
> +	dev->phy.dev =3D dev;
> +	dev->phy.mt76 =3D &dev->mt76.phy;
> +	dev->mt76.phy.priv =3D &dev->phy;
>  	dev->bus_ops =3D dev->mt76.bus;
>  	bus_ops =3D devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
>  			       GFP_KERNEL);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 7c7a26102e11..f0fd32c424c6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -181,10 +181,6 @@ static int mt7921_init_hardware(struct mt7921_dev *d=
ev)
>  {
>  	int ret, idx, i;
> =20
> -	ret =3D mt7921_dma_init(dev);
> -	if (ret)
> -		return ret;
> -
>  	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
> =20
>  	for (i =3D 0; i < MT7921_MCU_INIT_RETRY_COUNT; i++) {
> @@ -192,7 +188,7 @@ static int mt7921_init_hardware(struct mt7921_dev *de=
v)
>  		if (!ret)
>  			break;
> =20
> -		mt7921_wpdma_reset(dev, true);
> +		mt7921_init_reset(dev);
>  	}
> =20
>  	if (i =3D=3D MT7921_MCU_INIT_RETRY_COUNT) {
> @@ -289,25 +285,3 @@ int mt7921_register_device(struct mt7921_dev *dev)
> =20
>  	return 0;
>  }
> -
> -void mt7921_unregister_device(struct mt7921_dev *dev)
> -{
> -	int i;
> -	struct mt76_connac_pm *pm =3D &dev->pm;
> -
> -	mt76_unregister_device(&dev->mt76);
> -	mt76_for_each_q_rx(&dev->mt76, i)
> -		napi_disable(&dev->mt76.napi[i]);
> -	cancel_delayed_work_sync(&pm->ps_work);
> -	cancel_work_sync(&pm->wake_work);
> -
> -	mt7921_tx_token_put(dev);
> -	mt7921_mcu_drv_pmctrl(dev);
> -	mt7921_dma_cleanup(dev);
> -	mt7921_wfsys_reset(dev);
> -	mt7921_mcu_exit(dev);
> -	mt7921_mcu_fw_pmctrl(dev);
> -
> -	tasklet_disable(&dev->irq_tasklet);
> -	mt76_free_device(&dev->mt76);
> -}
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers=
/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index dbace154bfa5..60f4552cb212 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -133,11 +133,13 @@ struct mt7921_phy {
>  	struct delayed_work scan_work;
>  };
> =20
> +#define mt7921_init_reset(dev)	((dev)->hif_ops->init_reset(dev))
>  #define mt7921_dev_reset(dev)	((dev)->hif_ops->reset(dev))
>  #define mt7921_mcu_init(dev)	((dev)->hif_ops->mcu_init(dev))
>  #define mt7921_drv_own(dev)	((dev)->hif_ops->drv_own(dev))
>  #define mt7921_fw_own(dev)	((dev)->hif_ops->fw_own(dev))
>  struct mt7921_hif_ops {
> +	int (*init_reset)(struct mt7921_dev *dev);
>  	int (*reset)(struct mt7921_dev *dev);
>  	int (*mcu_init)(struct mt7921_dev *dev);
>  	int (*drv_own)(struct mt7921_dev *dev);
> @@ -394,5 +396,6 @@ int mt7921e_mac_reset(struct mt7921_dev *dev);
>  int mt7921e_mcu_init(struct mt7921_dev *dev);
>  int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
>  int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
> +int mt7921e_init_reset(struct mt7921_dev *dev);
> =20
>  #endif
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index b16bcee08cd7..f6bc3505b06a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -116,6 +116,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>  	};
> =20
>  	static const struct mt7921_hif_ops mt7921_pcie_ops =3D {
> +		.init_reset =3D mt7921e_init_reset,
>  		.reset =3D mt7921e_mac_reset,
>  		.mcu_init =3D mt7921e_mcu_init,
>  		.drv_own =3D mt7921e_mcu_drv_pmctrl,
> @@ -172,6 +173,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto err_free_dev;
> =20
> +	ret =3D mt7921_dma_init(dev);
> +	if (ret)
> +		goto err_free_irq;
> +
>  	ret =3D mt7921_register_device(dev);
>  	if (ret)
>  		goto err_free_irq;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_init.c b/drive=
rs/net/wireless/mediatek/mt76/mt7921/pci_init.c
> new file mode 100644
> index 000000000000..4511fec79d43
> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_init.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: ISC
> +/* Copyright (C) 2021 MediaTek Inc. */
> +
> +#include "mt7921.h"
> +
> +void mt7921_unregister_device(struct mt7921_dev *dev)

same here, we have pci_init.c just for mt7921_unregister_device(). Just mov=
e it
in pci.c and call it mt7921e_unregister_device(). Agree?

Regards,
Lorenzo

> +{
> +	int i;
> +	struct mt76_connac_pm *pm =3D &dev->pm;
> +
> +	mt76_unregister_device(&dev->mt76);
> +	mt76_for_each_q_rx(&dev->mt76, i)
> +		napi_disable(&dev->mt76.napi[i]);
> +	cancel_delayed_work_sync(&pm->ps_work);
> +	cancel_work_sync(&pm->wake_work);
> +
> +	mt7921_tx_token_put(dev);
> +	mt7921_mcu_drv_pmctrl(dev);
> +	mt7921_dma_cleanup(dev);
> +	mt7921_wfsys_reset(dev);
> +	mt7921_mcu_exit(dev);
> +	mt7921_mcu_fw_pmctrl(dev);
> +
> +	tasklet_disable(&dev->irq_tasklet);
> +	mt76_free_device(&dev->mt76);
> +}
> --=20
> 2.25.1
>=20

--l6W5gynAvom1fuO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUHxpQAKCRA6cBh0uS2t
rDmnAQDCmHAzM70Z+T2x7lXFoKgbZTPqyKksD3JLDwd0pyX3JgD+PyMyzRR1t1ZI
WgufDx7pI+wfZpgyWC4/ZHf7/qaGvgg=
=75s1
-----END PGP SIGNATURE-----

--l6W5gynAvom1fuO+--


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABF61A37E2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 18:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgDIQSy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 12:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgDIQSy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 12:18:54 -0400
Received: from lore-desk-wlan (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7100F21556;
        Thu,  9 Apr 2020 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586449134;
        bh=bmmIwtna1KAdsM69OBkHYhVioMcu6aomrW+CxboBYYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4XHP4mdOkuYHtuEabHkO3EmRefOr/mrK+qLnTJg4MMO6sIXCgZhuQbq/Idx2yFVd
         Rpy6dyRWyg5SeMwjjabmMAKeX9VKOaMfkpWH8Imz2ioUWrxptty13v5AKxf52kAt6h
         ztSAKPDsTuROPbvCttS7wgp4v3tDZNMtFMZUBvFM=
Date:   Thu, 9 Apr 2020 18:18:48 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org,
        Soul Huang <Soul.Huang@mediatek.com>
Subject: Re: [PATCH] mt76: mt7615: rework IRQ handling to prepare for MSI
 support
Message-ID: <20200409161848.GB6385@lore-desk-wlan>
References: <20200409155902.58185-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20200409155902.58185-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> With MSI interrupts, IRQs must not be enabled from within the IRQ handler,
> because that can lead to lost events.
> Defer IRQ processing to a tasklet, which is also responsible for enabling
> IRQs (to avoid race conditions against the handler)
>=20
> Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mmio.c     |  3 +-
>  .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 ++
>  .../net/wireless/mediatek/mt76/mt7615/mmio.c  | 30 +++++++++++++------
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  9 +++---
>  4 files changed, 29 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/wire=
less/mediatek/mt76/mmio.c
> index 7ead6620bb8b..26353b6bce97 100644
> --- a/drivers/net/wireless/mediatek/mt76/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mmio.c
> @@ -73,7 +73,8 @@ void mt76_set_irq_mask(struct mt76_dev *dev, u32 addr,
>  	spin_lock_irqsave(&dev->mmio.irq_lock, flags);
>  	dev->mmio.irqmask &=3D ~clear;
>  	dev->mmio.irqmask |=3D set;
> -	mt76_mmio_wr(dev, addr, dev->mmio.irqmask);
> +	if (addr)
> +		mt76_mmio_wr(dev, addr, dev->mmio.irqmask);
>  	spin_unlock_irqrestore(&dev->mmio.irq_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(mt76_set_irq_mask);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/init.c
> index 96b7c6284833..cb626a2d9197 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -561,5 +561,7 @@ void mt7615_unregister_device(struct mt7615_dev *dev)
>  	spin_unlock_bh(&dev->token_lock);
>  	idr_destroy(&dev->token);
> =20
> +	tasklet_disable(&dev->irq_tasklet);
> +
>  	mt76_free_device(&dev->mt76);
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/mmio.c
> index 3849bb6b49d0..58506dc423ab 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
> @@ -80,30 +80,41 @@ mt7615_rx_poll_complete(struct mt76_dev *mdev, enum m=
t76_rxq_id q)
>  static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
>  {
>  	struct mt7615_dev *dev =3D dev_instance;
> -	u32 intr;
> -
> -	intr =3D mt76_rr(dev, MT_INT_SOURCE_CSR);
> -	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
> =20
>  	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
>  		return IRQ_NONE;
> =20
> -	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
> +	mt76_wr(dev, MT_INT_MASK_CSR, 0);
> +	tasklet_schedule(&dev->irq_tasklet);
> =20
> +	return IRQ_HANDLED;
> +}
> +
> +static void mt7615_irq_tasklet(unsigned long data)
> +{
> +	struct mt7615_dev *dev =3D (struct mt7615_dev *)data;
> +	u32 intr, mask =3D 0;
> +
> +	mt76_wr(dev, MT_INT_MASK_CSR, 0);
> +
> +	intr =3D mt76_rr(dev, MT_INT_SOURCE_CSR);
> +	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
> +
> +	trace_dev_irq(&dev->mt76, intr, dev->mt76.mmio.irqmask);
>  	intr &=3D dev->mt76.mmio.irqmask;
> =20
>  	if (intr & MT_INT_TX_DONE_ALL) {
> -		mt7615_irq_disable(dev, MT_INT_TX_DONE_ALL);
> +		mask |=3D MT_INT_TX_DONE_ALL;
>  		napi_schedule(&dev->mt76.tx_napi);
>  	}
> =20
>  	if (intr & MT_INT_RX_DONE(0)) {
> -		mt7615_irq_disable(dev, MT_INT_RX_DONE(0));
> +		mask |=3D MT_INT_RX_DONE(0);
>  		napi_schedule(&dev->mt76.napi[0]);
>  	}
> =20
>  	if (intr & MT_INT_RX_DONE(1)) {
> -		mt7615_irq_disable(dev, MT_INT_RX_DONE(1));
> +		mask |=3D MT_INT_RX_DONE(1);
>  		napi_schedule(&dev->mt76.napi[1]);
>  	}
> =20
> @@ -117,7 +128,7 @@ static irqreturn_t mt7615_irq_handler(int irq, void *=
dev_instance)
>  		}
>  	}
> =20
> -	return IRQ_HANDLED;
> +	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
>  }
> =20
>  int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
> @@ -154,6 +165,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iom=
em *mem_base,
> =20
>  	dev =3D container_of(mdev, struct mt7615_dev, mt76);
>  	mt76_mmio_init(&dev->mt76, mem_base);
> +	tasklet_init(&dev->irq_tasklet, mt7615_irq_tasklet, (unsigned long)dev);
> =20
>  	dev->reg_map =3D map;
>  	dev->ops =3D ops;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers=
/net/wireless/mediatek/mt76/mt7615/mt7615.h
> index 4f0d29e5e595..10a98d38f77e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
> @@ -229,6 +229,8 @@ struct mt7615_dev {
>  		struct mt76_phy mphy;
>  	};
> =20
> +	struct tasklet_struct irq_tasklet;
> +
>  	struct mt7615_phy phy;
>  	u32 vif_mask;
>  	u32 omac_mask;
> @@ -404,12 +406,9 @@ static inline bool is_mt7663(struct mt76_dev *dev)
> =20
>  static inline void mt7615_irq_enable(struct mt7615_dev *dev, u32 mask)
>  {
> -	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, 0, mask);
> -}
> +	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
> =20
> -static inline void mt7615_irq_disable(struct mt7615_dev *dev, u32 mask)
> -{
> -	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
> +	tasklet_schedule(&dev->irq_tasklet);
>  }
> =20
>  static inline bool mt7615_firmware_offload(struct mt7615_dev *dev)
> --=20
> 2.24.0
>=20

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXo9K5gAKCRA6cBh0uS2t
rHLrAQD8IlJM9fAyhaiTXSl6nycOqOCoLCqWuAO/bl5GN9KsBwEAnFqJwys7XdyT
5iBrhDFa+5fEO8R+vkFsL+XdDdg06g0=
=P+wk
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--

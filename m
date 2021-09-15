Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EE140C646
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhIONWT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 09:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237692AbhIONWS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 09:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631712059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aa9FiGBy/D3+nHBLbwbW+mz7AL2yFPv/Gw+jeR+72Kw=;
        b=ippIrXNW5XTaTjwOVp+m9MVD7vgR28oJMNJIEjn22RmHmbgUTws11Sajs6/O39pfNCACel
        mwtlmVLiGWcynj0sv3B15zsmmEHuuPbGss1IeO3fJvPBqwhUD7NfTtpyOjIsX8DA85eEMG
        npl/c5q80RGfutxVx46+yqOw6Q2LptI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-DLXoNVvUONmmbyA23sL_zA-1; Wed, 15 Sep 2021 09:20:57 -0400
X-MC-Unique: DLXoNVvUONmmbyA23sL_zA-1
Received: by mail-ej1-f71.google.com with SMTP id bo11-20020a170906d04b00b005d477e1e41fso1513004ejb.11
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 06:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aa9FiGBy/D3+nHBLbwbW+mz7AL2yFPv/Gw+jeR+72Kw=;
        b=UHd/48xBu35w2Kz/CDSJ7MOLdkVjRSWuhRTJN+4zzXv49yCyLgHad11OnmewxlJBMG
         /UBH74qDIL9WSScukCEw3w20PTPSZHizx0TjAY8hE7oynfKzTeTh4D788WFCLYfFWoUt
         wkhvi9+g6imDYk4gpjBHizB3IEV73VZdxMLKtTYnbVwG75tCHHTFR83BS/sY0s2xoLtF
         /UZOcfD1SJi+PC28yemeghpKci1bvId8ck1ZVQN8RtgF7YbNsCELykvjM2KoL9RCFAlB
         Jlm9/MLFugkmNZ9MpQNeftKtFLMW8DtJh4UQwgenEGZZgNjhFTl8QGp/7laokAQm5uGF
         0iRw==
X-Gm-Message-State: AOAM53328XgdO+7HqyESS/BXpCXohYJ0Ucq2O39S0/v578pUuspPQmso
        ULa90dsF6LJgqp2edwihc9Q+Li/KvDTU2+5fIktqbbM3POElhgkFcpWlo6GKdW71Ag8dTz6XYcE
        UG5Ne1Sv/9o7HRkejuZzdfq/wT5s=
X-Received: by 2002:a17:906:4c8c:: with SMTP id q12mr25055440eju.254.1631712056366;
        Wed, 15 Sep 2021 06:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPuW/ApqpdN3SHwTWOtxOQtOm1uDVBTBuelf/gF9m/waxJzg6EQFdPf97709RLdh2PPAtmAQ==
X-Received: by 2002:a17:906:4c8c:: with SMTP id q12mr25055405eju.254.1631712055962;
        Wed, 15 Sep 2021 06:20:55 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id ky7sm1255656ejc.75.2021.09.15.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:20:55 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:20:52 +0200
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
Subject: Re: [PATCH v1 07/16] mt76: connac: move sdio utility routines in
 mt76_connac_sdio module
Message-ID: <YUHzNMibE1IVniE7@lore-desk>
References: <cover.1631667941.git.objelf@gmail.com>
 <9933b221edd43802b67b6d8893737db62a3aea60.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4mVMvcy2JhSq7fYf"
Content-Disposition: inline
In-Reply-To: <9933b221edd43802b67b6d8893737db62a3aea60.1631667941.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--4mVMvcy2JhSq7fYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 15, Sean Wang wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> This is a preliminary patch before introduce mt7921s support to hold the
> common sdio utilities between mt7663s and mt7921s in mt76_connac_sdio
> module.
>=20
> mt76/mt76_connac_sdio.c, mt76/mt76_connac_sdio.h and
> mt76/mt76_connac_sdio_txrx.c originate from mt7615/sdio.c, mt7615/sdio.h
> and mt7615/sdio_txrx.c and the patch don't add any logic change.
>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/Kconfig    |   5 +
>  drivers/net/wireless/mediatek/mt76/Makefile   |   2 +
>  .../wireless/mediatek/mt76/mt76_connac_sdio.c | 317 +++++++++++++++++
>  .../wireless/mediatek/mt76/mt76_connac_sdio.h | 137 ++++++++
>  .../mediatek/mt76/mt76_connac_sdio_txrx.c     | 318 ++++++++++++++++++
>  5 files changed, 779 insertions(+)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.h
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_t=
xrx.c
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wir=
eless/mediatek/mt76/Kconfig
> index 9ff43f1fc50d..a6b388bfb563 100644
> --- a/drivers/net/wireless/mediatek/mt76/Kconfig
> +++ b/drivers/net/wireless/mediatek/mt76/Kconfig
> @@ -28,6 +28,11 @@ config MT76_CONNAC_LIB
>  	tristate
>  	select MT76_CORE
> =20
> +config MT76_CONNAC_SDIO
> +	tristate
> +	depends on MMC
> +	select MT76_CONNAC_LIB
> +
>  source "drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig"
>  source "drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig"
>  source "drivers/net/wireless/mediatek/mt76/mt7603/Kconfig"
> diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wi=
reless/mediatek/mt76/Makefile
> index 94efe3c29053..17b2ed93f6a3 100644
> --- a/drivers/net/wireless/mediatek/mt76/Makefile
> +++ b/drivers/net/wireless/mediatek/mt76/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_MT76_SDIO) +=3D mt76-sdio.o
>  obj-$(CONFIG_MT76x02_LIB) +=3D mt76x02-lib.o
>  obj-$(CONFIG_MT76x02_USB) +=3D mt76x02-usb.o
>  obj-$(CONFIG_MT76_CONNAC_LIB) +=3D mt76-connac-lib.o
> +obj-$(CONFIG_MT76_CONNAC_SDIO) +=3D mt76-connac-sdio.o
> =20
>  mt76-y :=3D \
>  	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
> @@ -28,6 +29,7 @@ mt76x02-lib-y :=3D mt76x02_util.o mt76x02_mac.o mt76x02=
_mcu.o \
>  mt76x02-usb-y :=3D mt76x02_usb_mcu.o mt76x02_usb_core.o
> =20
>  mt76-connac-lib-y :=3D mt76_connac_mcu.o mt76_connac_mac.o
> +mt76-connac-sdio-y :=3D mt76_connac_sdio.o mt76_connac_sdio_txrx.o
> =20
>  obj-$(CONFIG_MT76x0_COMMON) +=3D mt76x0/
>  obj-$(CONFIG_MT76x2_COMMON) +=3D mt76x2/
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.c b/driv=
ers/net/wireless/mediatek/mt76/mt76_connac_sdio.c
> new file mode 100644
> index 000000000000..d18a66e5445f
> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.c
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: ISC
> +/* Copyright (C) 2020-2021 MediaTek Inc.
> + *
> + * Author: Felix Fietkau <nbd@nbd.name>
> + *	   Lorenzo Bianconi <lorenzo@kernel.org>
> + *	   Sean Wang <sean.wang@mediatek.com>
> + */
> +
> +#include <linux/iopoll.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/sdio_func.h>
> +
> +#include "mt76.h"
> +#include "mt76_connac_mcu.h"
> +#include "mt76_connac_sdio.h"
> +
> +static u32 mt76_connac_sdio_read_whisr(struct mt76_dev *dev)
> +{
> +	return sdio_readl(dev->sdio.func, MCR_WHISR, NULL);
> +}
> +
> +u32 mt76_connac_sdio_read_pcr(struct mt76_dev *dev)
> +{
> +	struct mt76_sdio *sdio =3D &dev->sdio;
> +
> +	return sdio_readl(sdio->func, MCR_WHLPCR, NULL);
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_read_pcr);
> +
> +u32 mt76_connac_sdio_read_mailbox(struct mt76_dev *dev, u32 offset)
> +{
> +	struct sdio_func *func =3D dev->sdio.func;
> +	u32 val =3D ~0, status;
> +	int err;
> +
> +	sdio_claim_host(func);
> +
> +	sdio_writel(func, offset, MCR_H2DSM0R, &err);
> +	if (err < 0) {
> +		dev_err(dev->dev, "failed setting address [err=3D%d]\n", err);
> +		goto out;
> +	}
> +
> +	sdio_writel(func, H2D_SW_INT_READ, MCR_WSICR, &err);
> +	if (err < 0) {
> +		dev_err(dev->dev, "failed setting read mode [err=3D%d]\n", err);
> +		goto out;
> +	}
> +
> +	err =3D readx_poll_timeout(mt76_connac_sdio_read_whisr, dev, status,
> +				 status & H2D_SW_INT_READ, 0, 1000000);
> +	if (err < 0) {
> +		dev_err(dev->dev, "query whisr timeout\n");
> +		goto out;
> +	}
> +
> +	sdio_writel(func, H2D_SW_INT_READ, MCR_WHISR, &err);
> +	if (err < 0) {
> +		dev_err(dev->dev, "failed setting read mode [err=3D%d]\n", err);
> +		goto out;
> +	}
> +
> +	val =3D sdio_readl(func, MCR_H2DSM0R, &err);
> +	if (err < 0) {
> +		dev_err(dev->dev, "failed reading h2dsm0r [err=3D%d]\n", err);
> +		goto out;
> +	}
> +
> +	if (val !=3D offset) {
> +		dev_err(dev->dev, "register mismatch\n");
> +		val =3D ~0;
> +		goto out;
> +	}
> +
> +	val =3D sdio_readl(func, MCR_D2HRM1R, &err);
> +	if (err < 0)
> +		dev_err(dev->dev, "failed reading d2hrm1r [err=3D%d]\n", err);
> +
> +out:
> +	sdio_release_host(func);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_read_mailbox);
> +
> +void mt76_connac_sdio_write_mailbox(struct mt76_dev *dev, u32 offset, u3=
2 val)
> +{
> +	struct sdio_func *func =3D dev->sdio.func;
> +	u32 status;
> +	int err;
> +
> +	sdio_claim_host(func);
> +
> +	sdio_writel(func, offset, MCR_H2DSM0R, &err);
> +	if (err < 0) {
> +		dev_err(dev->dev, "failed setting address [err=3D%d]\n", err);
> +		goto out;
> +	}
> +
> +	sdio_writel(func, val, MCR_H2DSM1R, &err);
> +	if (err < 0) {
> +		dev_err(dev->dev,
> +			"failed setting write value [err=3D%d]\n", err);
> +		goto out;
> +	}
> +
> +	sdio_writel(func, H2D_SW_INT_WRITE, MCR_WSICR, &err);
> +	if (err < 0) {
> +		dev_err(dev->dev, "failed setting write mode [err=3D%d]\n", err);
> +		goto out;
> +	}
> +
> +	err =3D readx_poll_timeout(mt76_connac_sdio_read_whisr, dev, status,
> +				 status & H2D_SW_INT_WRITE, 0, 1000000);
> +	if (err < 0) {
> +		dev_err(dev->dev, "query whisr timeout\n");
> +		goto out;
> +	}
> +
> +	sdio_writel(func, H2D_SW_INT_WRITE, MCR_WHISR, &err);
> +	if (err < 0) {
> +		dev_err(dev->dev, "failed setting write mode [err=3D%d]\n", err);
> +		goto out;
> +	}
> +
> +	val =3D sdio_readl(func, MCR_H2DSM0R, &err);
> +	if (err < 0) {
> +		dev_err(dev->dev, "failed reading h2dsm0r [err=3D%d]\n", err);
> +		goto out;
> +	}
> +
> +	if (val !=3D offset)
> +		dev_err(dev->dev, "register mismatch\n");
> +
> +out:
> +	sdio_release_host(func);
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_write_mailbox);
> +
> +u32 mt76_connac_sdio_rr(struct mt76_dev *dev, u32 offset)
> +{
> +	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
> +		return mt76_connac_mcu_reg_rr(dev, offset);
> +	else
> +		return mt76_connac_sdio_read_mailbox(dev, offset);
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_rr);
> +
> +void mt76_connac_sdio_wr(struct mt76_dev *dev, u32 offset, u32 val)
> +{
> +	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
> +		mt76_connac_mcu_reg_wr(dev, offset, val);
> +	else
> +		mt76_connac_sdio_write_mailbox(dev, offset, val);
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_wr);
> +
> +u32 mt76_connac_sdio_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32=
 val)
> +{
> +	val |=3D mt76_connac_sdio_rr(dev, offset) & ~mask;
> +	mt76_connac_sdio_wr(dev, offset, val);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_rmw);
> +
> +void mt76_connac_sdio_write_copy(struct mt76_dev *dev, u32 offset,
> +				 const void *data, int len)
> +{
> +	const u32 *val =3D data;
> +	int i;
> +
> +	for (i =3D 0; i < len / sizeof(u32); i++) {
> +		mt76_connac_sdio_wr(dev, offset, val[i]);
> +		offset +=3D sizeof(u32);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_write_copy);
> +
> +void mt76_connac_sdio_read_copy(struct mt76_dev *dev, u32 offset,
> +				void *data, int len)
> +{
> +	u32 *val =3D data;
> +	int i;
> +
> +	for (i =3D 0; i < len / sizeof(u32); i++) {
> +		val[i] =3D mt76_connac_sdio_rr(dev, offset);
> +		offset +=3D sizeof(u32);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_read_copy);
> +
> +int mt76_connac_sdio_wr_rp(struct mt76_dev *dev, u32 base,
> +			   const struct mt76_reg_pair *data,
> +			   int len)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < len; i++) {
> +		mt76_connac_sdio_wr(dev, data->reg, data->value);
> +		data++;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_wr_rp);
> +
> +int mt76_connac_sdio_rd_rp(struct mt76_dev *dev, u32 base,
> +			   struct mt76_reg_pair *data,
> +			   int len)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < len; i++) {
> +		data->value =3D mt76_connac_sdio_rr(dev, data->reg);
> +		data++;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_rd_rp);
> +
> +int mt76_connac_sdio_hw_init(struct mt76_dev *dev, struct sdio_func *fun=
c,
> +			     sdio_irq_handler_t *irq_handler)
> +{
> +	u32 status, ctrl;
> +	int ret;
> +
> +	sdio_claim_host(func);
> +
> +	ret =3D sdio_enable_func(func);
> +	if (ret < 0)
> +		goto release;
> +
> +	/* Get ownership from the device */
> +	sdio_writel(func, WHLPCR_INT_EN_CLR | WHLPCR_FW_OWN_REQ_CLR,
> +		    MCR_WHLPCR, &ret);
> +	if (ret < 0)
> +		goto disable_func;
> +
> +	ret =3D readx_poll_timeout(mt76_connac_sdio_read_pcr, dev, status,
> +				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
> +	if (ret < 0) {
> +		dev_err(dev->dev, "Cannot get ownership from device");
> +		goto disable_func;
> +	}
> +
> +	ret =3D sdio_set_block_size(func, 512);
> +	if (ret < 0)
> +		goto disable_func;
> +
> +	/* Enable interrupt */
> +	sdio_writel(func, WHLPCR_INT_EN_SET, MCR_WHLPCR, &ret);
> +	if (ret < 0)
> +		goto disable_func;
> +
> +	ctrl =3D WHIER_RX0_DONE_INT_EN | WHIER_TX_DONE_INT_EN;
> +	sdio_writel(func, ctrl, MCR_WHIER, &ret);
> +	if (ret < 0)
> +		goto disable_func;
> +
> +	/* set WHISR as read clear and Rx aggregation number as 16 */
> +	ctrl =3D FIELD_PREP(MAX_HIF_RX_LEN_NUM, 16);
> +	sdio_writel(func, ctrl, MCR_WHCR, &ret);
> +	if (ret < 0)
> +		goto disable_func;
> +
> +	ret =3D sdio_claim_irq(func, irq_handler);

The only difference between mt7921s_irq and mt7663s_irq is the RESET check,
right? Maybe we just need to add the same check for mt7663s_irq and move the
routine here?

> +	if (ret < 0)
> +		goto disable_func;
> +
> +	sdio_release_host(func);
> +
> +	return 0;
> +
> +disable_func:
> +	sdio_disable_func(func);
> +release:
> +	sdio_release_host(func);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_hw_init);
> +
> +int mt76_connac_sdio_init(struct mt76_dev *dev,
> +			  void (*txrx_worker)(struct mt76_worker *))
> +{
> +	int i, ret;
> +
> +	dev->sdio.intr_data =3D devm_kmalloc(dev->dev,
> +					   sizeof(struct mt76s_intr),
> +					   GFP_KERNEL);
> +	if (!dev->sdio.intr_data)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dev->sdio.xmit_buf); i++) {
> +		dev->sdio.xmit_buf[i] =3D devm_kmalloc(dev->dev,
> +						     MT76S_XMIT_BUF_SZ,
> +						     GFP_KERNEL);
> +		if (!dev->sdio.xmit_buf[i])
> +			return -ENOMEM;
> +	}
> +
> +	ret =3D mt76_worker_setup(dev->hw, &dev->sdio.txrx_worker, txrx_worker,
> +				"sdio-txrx");

Same here, I guess we can move mt7921s_txrx_worker here and share it with
mt7663s

> +	if (ret)
> +		return ret;
> +
> +	sched_set_fifo_low(dev->sdio.txrx_worker.task);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_init);
> +
> +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.h b/driv=
ers/net/wireless/mediatek/mt76/mt76_connac_sdio.h
> new file mode 100644
> index 000000000000..e176d6e562b2
> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio.h
> @@ -0,0 +1,137 @@
> +/* SPDX-License-Identifier: ISC */
> +/* Copyright (C) 2020-2021 MediaTek Inc.
> + *
> + * Author: Sean Wang <sean.wang@mediatek.com>
> + */
> +
> +#ifndef __MT76_CONNAC_SDIO_H
> +#define __MT76_CONNAC_SDIO_H
> +
> +#define MT_PSE_PAGE_SZ			128
> +
> +#define MCR_WCIR			0x0000
> +#define MCR_WHLPCR			0x0004
> +#define WHLPCR_FW_OWN_REQ_CLR		BIT(9)
> +#define WHLPCR_FW_OWN_REQ_SET		BIT(8)
> +#define WHLPCR_IS_DRIVER_OWN		BIT(8)
> +#define WHLPCR_INT_EN_CLR		BIT(1)
> +#define WHLPCR_INT_EN_SET		BIT(0)
> +
> +#define MCR_WSDIOCSR			0x0008
> +#define MCR_WHCR			0x000C
> +#define W_INT_CLR_CTRL			BIT(1)
> +#define RECV_MAILBOX_RD_CLR_EN		BIT(2)
> +#define MAX_HIF_RX_LEN_NUM		GENMASK(13, 8)
> +#define RX_ENHANCE_MODE			BIT(16)
> +
> +#define MCR_WHISR			0x0010
> +#define MCR_WHIER			0x0014
> +#define WHIER_D2H_SW_INT		GENMASK(31, 8)
> +#define WHIER_FW_OWN_BACK_INT_EN	BIT(7)
> +#define WHIER_ABNORMAL_INT_EN		BIT(6)
> +#define WHIER_RX1_DONE_INT_EN		BIT(2)
> +#define WHIER_RX0_DONE_INT_EN		BIT(1)
> +#define WHIER_TX_DONE_INT_EN		BIT(0)
> +#define WHIER_DEFAULT			(WHIER_RX0_DONE_INT_EN	| \
> +					 WHIER_RX1_DONE_INT_EN	| \
> +					 WHIER_TX_DONE_INT_EN	| \
> +					 WHIER_ABNORMAL_INT_EN	| \
> +					 WHIER_D2H_SW_INT)
> +
> +#define MCR_WASR			0x0020
> +#define MCR_WSICR			0x0024
> +#define MCR_WTSR0			0x0028
> +#define TQ0_CNT				GENMASK(7, 0)
> +#define TQ1_CNT				GENMASK(15, 8)
> +#define TQ2_CNT				GENMASK(23, 16)
> +#define TQ3_CNT				GENMASK(31, 24)
> +
> +#define MCR_WTSR1			0x002c
> +#define TQ4_CNT				GENMASK(7, 0)
> +#define TQ5_CNT				GENMASK(15, 8)
> +#define TQ6_CNT				GENMASK(23, 16)
> +#define TQ7_CNT				GENMASK(31, 24)
> +
> +#define MCR_WTDR1			0x0034
> +#define MCR_WRDR0			0x0050
> +#define MCR_WRDR1			0x0054
> +#define MCR_WRDR(p)			(0x0050 + 4 * (p))
> +#define MCR_H2DSM0R			0x0070
> +#define H2D_SW_INT_READ			BIT(16)
> +#define H2D_SW_INT_WRITE		BIT(17)
> +
> +#define MCR_H2DSM1R			0x0074
> +#define MCR_D2HRM0R			0x0078
> +#define MCR_D2HRM1R			0x007c
> +#define MCR_D2HRM2R			0x0080
> +#define MCR_WRPLR			0x0090
> +#define RX0_PACKET_LENGTH		GENMASK(15, 0)
> +#define RX1_PACKET_LENGTH		GENMASK(31, 16)
> +
> +#define MCR_WTMDR			0x00b0
> +#define MCR_WTMCR			0x00b4
> +#define MCR_WTMDPCR0			0x00b8
> +#define MCR_WTMDPCR1			0x00bc
> +#define MCR_WPLRCR			0x00d4
> +#define MCR_WSR				0x00D8
> +#define MCR_CLKIOCR			0x0100
> +#define MCR_CMDIOCR			0x0104
> +#define MCR_DAT0IOCR			0x0108
> +#define MCR_DAT1IOCR			0x010C
> +#define MCR_DAT2IOCR			0x0110
> +#define MCR_DAT3IOCR			0x0114
> +#define MCR_CLKDLYCR			0x0118
> +#define MCR_CMDDLYCR			0x011C
> +#define MCR_ODATDLYCR			0x0120
> +#define MCR_IDATDLYCR1			0x0124
> +#define MCR_IDATDLYCR2			0x0128
> +#define MCR_ILCHCR			0x012C
> +#define MCR_WTQCR0			0x0130
> +#define MCR_WTQCR1			0x0134
> +#define MCR_WTQCR2			0x0138
> +#define MCR_WTQCR3			0x013C
> +#define MCR_WTQCR4			0x0140
> +#define MCR_WTQCR5			0x0144
> +#define MCR_WTQCR6			0x0148
> +#define MCR_WTQCR7			0x014C
> +#define MCR_WTQCR(x)                   (0x130 + 4 * (x))
> +#define TXQ_CNT_L			GENMASK(15, 0)
> +#define TXQ_CNT_H			GENMASK(31, 16)
> +
> +#define MCR_SWPCDBGR			0x0154
> +
> +struct mt76s_intr {
> +	u32 isr;
> +	struct {
> +		u32 wtqcr[8];
> +	} tx;
> +	struct {
> +		u16 num[2];
> +		u16 len[2][16];
> +	} rx;
> +	u32 rec_mb[2];
> +} __packed;
> +
> +u32 mt76_connac_sdio_read_pcr(struct mt76_dev *dev);
> +u32 mt76_connac_sdio_read_mailbox(struct mt76_dev *dev, u32 offset);
> +void mt76_connac_sdio_write_mailbox(struct mt76_dev *dev, u32 offset, u3=
2 val);
> +u32 mt76_connac_sdio_rr(struct mt76_dev *dev, u32 offset);
> +void mt76_connac_sdio_wr(struct mt76_dev *dev, u32 offset, u32 val);
> +u32 mt76_connac_sdio_rmw(struct mt76_dev *dev, u32 offset, u32 mask, u32=
 val);
> +void mt76_connac_sdio_write_copy(struct mt76_dev *dev, u32 offset,
> +				 const void *data, int len);
> +void mt76_connac_sdio_read_copy(struct mt76_dev *dev, u32 offset,
> +				void *data, int len);
> +int mt76_connac_sdio_wr_rp(struct mt76_dev *dev, u32 base,
> +			   const struct mt76_reg_pair *data,
> +			   int len);
> +int mt76_connac_sdio_rd_rp(struct mt76_dev *dev, u32 base,
> +			   struct mt76_reg_pair *data,
> +			   int len);
> +
> +void mt76_connac_sdio_txrx(struct mt76_dev *dev);
> +int mt76_connac_sdio_hw_init(struct mt76_dev *dev, struct sdio_func *fun=
c,
> +			     sdio_irq_handler_t *irq_handler);
> +int mt76_connac_sdio_init(struct mt76_dev *dev,
> +			  void (*txrx_worker)(struct mt76_worker *));
> +#endif
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c b=
/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c
> new file mode 100644
> index 000000000000..3ef42f90f3f5
> --- /dev/null
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_sdio_txrx.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: ISC
> +/* Copyright (C) 2020-2021 MediaTek Inc.
> + *
> + * Author: Felix Fietkau <nbd@nbd.name>
> + *	   Lorenzo Bianconi <lorenzo@kernel.org>
> + *	   Sean Wang <sean.wang@mediatek.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/sdio_ids.h>
> +#include <linux/mmc/sdio_func.h>
> +
> +#include "trace.h"
> +#include "mt76.h"
> +#include "mt76_connac_sdio.h"
> +
> +static int mt76_connac_sdio_refill_sched_quota(struct mt76_dev *dev, u32=
 *data)
> +{
> +	u32 ple_ac_data_quota[] =3D {
> +		FIELD_GET(TXQ_CNT_L, data[4]), /* VO */
> +		FIELD_GET(TXQ_CNT_H, data[3]), /* VI */
> +		FIELD_GET(TXQ_CNT_L, data[3]), /* BE */
> +		FIELD_GET(TXQ_CNT_H, data[2]), /* BK */
> +	};
> +	u32 pse_ac_data_quota[] =3D {
> +		FIELD_GET(TXQ_CNT_H, data[1]), /* VO */
> +		FIELD_GET(TXQ_CNT_L, data[1]), /* VI */
> +		FIELD_GET(TXQ_CNT_H, data[0]), /* BE */
> +		FIELD_GET(TXQ_CNT_L, data[0]), /* BK */
> +	};
> +	u32 pse_mcu_quota =3D FIELD_GET(TXQ_CNT_L, data[2]);
> +	u32 pse_data_quota =3D 0, ple_data_quota =3D 0;
> +	struct mt76_sdio *sdio =3D &dev->sdio;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pse_ac_data_quota); i++) {
> +		pse_data_quota +=3D pse_ac_data_quota[i];
> +		ple_data_quota +=3D ple_ac_data_quota[i];
> +	}
> +
> +	if (!pse_data_quota && !ple_data_quota && !pse_mcu_quota)
> +		return 0;
> +
> +	sdio->sched.pse_mcu_quota +=3D pse_mcu_quota;
> +	sdio->sched.pse_data_quota +=3D pse_data_quota;
> +	sdio->sched.ple_data_quota +=3D ple_data_quota;
> +
> +	return pse_data_quota + ple_data_quota + pse_mcu_quota;
> +}
> +
> +static struct sk_buff *mt76_connac_sdio_build_rx_skb(void *data, int dat=
a_len,
> +						     int buf_len)
> +{
> +	int len =3D min_t(int, data_len, MT_SKB_HEAD_LEN);
> +	struct sk_buff *skb;
> +
> +	skb =3D alloc_skb(len, GFP_KERNEL);
> +	if (!skb)
> +		return NULL;
> +
> +	skb_put_data(skb, data, len);
> +	if (data_len > len) {
> +		struct page *page;
> +
> +		data +=3D len;
> +		page =3D virt_to_head_page(data);
> +		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> +				page, data - page_address(page),
> +				data_len - len, buf_len);
> +		get_page(page);
> +	}
> +
> +	return skb;
> +}
> +
> +static int mt76_connac_sdio_rx_run_queue(struct mt76_dev *dev,
> +					 enum mt76_rxq_id qid,
> +					 struct mt76s_intr *intr)
> +{
> +	struct mt76_queue *q =3D &dev->q_rx[qid];
> +	struct mt76_sdio *sdio =3D &dev->sdio;
> +	int len =3D 0, err, i;
> +	struct page *page;
> +	u8 *buf;
> +
> +	for (i =3D 0; i < intr->rx.num[qid]; i++)
> +		len +=3D round_up(intr->rx.len[qid][i] + 4, 4);
> +
> +	if (!len)
> +		return 0;
> +
> +	if (len > sdio->func->cur_blksize)
> +		len =3D roundup(len, sdio->func->cur_blksize);
> +
> +	page =3D __dev_alloc_pages(GFP_KERNEL, get_order(len));
> +	if (!page)
> +		return -ENOMEM;
> +
> +	buf =3D page_address(page);
> +
> +	err =3D sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
> +	if (err < 0) {
> +		dev_err(dev->dev, "sdio read data failed:%d\n", err);
> +		put_page(page);
> +		return err;
> +	}
> +
> +	for (i =3D 0; i < intr->rx.num[qid]; i++) {
> +		int index =3D (q->head + i) % q->ndesc;
> +		struct mt76_queue_entry *e =3D &q->entry[index];
> +
> +		len =3D intr->rx.len[qid][i];
> +		e->skb =3D mt76_connac_sdio_build_rx_skb(buf, len,
> +						       round_up(len + 4, 4));
> +		if (!e->skb)
> +			break;
> +
> +		buf +=3D round_up(len + 4, 4);
> +		if (q->queued + i + 1 =3D=3D q->ndesc)
> +			break;
> +	}
> +	put_page(page);
> +
> +	spin_lock_bh(&q->lock);
> +	q->head =3D (q->head + i) % q->ndesc;
> +	q->queued +=3D i;
> +	spin_unlock_bh(&q->lock);
> +
> +	return i;
> +}
> +
> +static int mt76_connac_sdio_rx_handler(struct mt76_dev *dev)
> +{
> +	struct mt76_sdio *sdio =3D &dev->sdio;
> +	struct mt76s_intr *intr =3D sdio->intr_data;
> +	int nframes =3D 0, ret;
> +
> +	ret =3D sdio_readsb(sdio->func, intr, MCR_WHISR, sizeof(*intr));
> +	if (ret < 0)
> +		return ret;
> +
> +	trace_dev_irq(dev, intr->isr, 0);
> +
> +	if (intr->isr & WHIER_RX0_DONE_INT_EN) {
> +		ret =3D mt76_connac_sdio_rx_run_queue(dev, 0, intr);
> +		if (ret > 0) {
> +			mt76_worker_schedule(&sdio->net_worker);
> +			nframes +=3D ret;
> +		}
> +	}
> +
> +	if (intr->isr & WHIER_RX1_DONE_INT_EN) {
> +		ret =3D mt76_connac_sdio_rx_run_queue(dev, 1, intr);
> +		if (ret > 0) {
> +			mt76_worker_schedule(&sdio->net_worker);
> +			nframes +=3D ret;
> +		}
> +	}
> +
> +	nframes +=3D !!mt76_connac_sdio_refill_sched_quota(dev, intr->tx.wtqcr);
> +
> +	return nframes;
> +}
> +
> +static int mt76_connac_sdio_tx_pick_quota(struct mt76_sdio *sdio, bool m=
cu,
> +					  int buf_sz, int *pse_size,
> +					  int *ple_size)
> +{
> +	int pse_sz;
> +
> +	pse_sz =3D DIV_ROUND_UP(buf_sz + sdio->sched.deficit, MT_PSE_PAGE_SZ);
> +
> +	if (mcu) {
> +		if (sdio->sched.pse_mcu_quota < *pse_size + pse_sz)
> +			return -EBUSY;
> +	} else {
> +		if (sdio->sched.pse_data_quota < *pse_size + pse_sz ||
> +		    sdio->sched.ple_data_quota < *ple_size + 1)
> +			return -EBUSY;
> +
> +		*ple_size =3D *ple_size + 1;
> +	}
> +	*pse_size =3D *pse_size + pse_sz;
> +
> +	return 0;
> +}
> +
> +static void mt76_connac_sdio_tx_update_quota(struct mt76_sdio *sdio, boo=
l mcu,
> +					     int pse_size, int ple_size)
> +{
> +	if (mcu) {
> +		sdio->sched.pse_mcu_quota -=3D pse_size;
> +	} else {
> +		sdio->sched.pse_data_quota -=3D pse_size;
> +		sdio->sched.ple_data_quota -=3D ple_size;
> +	}
> +}
> +
> +static int __mt76_connac_sdio_xmit_queue(struct mt76_dev *dev, u8 *data,
> +					 int len)
> +{
> +	struct mt76_sdio *sdio =3D &dev->sdio;
> +	int err;
> +
> +	if (len > sdio->func->cur_blksize)
> +		len =3D roundup(len, sdio->func->cur_blksize);
> +
> +	err =3D sdio_writesb(sdio->func, MCR_WTDR1, data, len);
> +	if (err)
> +		dev_err(dev->dev, "sdio write failed: %d\n", err);
> +
> +	return err;
> +}
> +
> +static int mt76_connac_sdio_tx_run_queue(struct mt76_dev *dev,
> +					 struct mt76_queue *q)
> +{
> +	int qid, err, nframes =3D 0, len =3D 0, pse_sz =3D 0, ple_sz =3D 0;
> +	bool mcu =3D q =3D=3D dev->q_mcu[MT_MCUQ_WM];
> +	struct mt76_sdio *sdio =3D &dev->sdio;
> +	u8 pad;
> +
> +	qid =3D mcu ? ARRAY_SIZE(sdio->xmit_buf) - 1 : q->qid;
> +	while (q->first !=3D q->head) {
> +		struct mt76_queue_entry *e =3D &q->entry[q->first];
> +		struct sk_buff *iter;
> +
> +		smp_rmb();
> +
> +		if (!test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state)) {
> +			__skb_put_zero(e->skb, 4);
> +			err =3D __mt76_connac_sdio_xmit_queue(dev, e->skb->data,
> +							    e->skb->len);
> +			if (err)
> +				return err;
> +
> +			goto next;
> +		}
> +
> +		pad =3D roundup(e->skb->len, 4) - e->skb->len;
> +		if (len + e->skb->len + pad + 4 > MT76S_XMIT_BUF_SZ)
> +			break;
> +
> +		if (mt76_connac_sdio_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
> +						   &ple_sz))
> +			break;
> +
> +		memcpy(sdio->xmit_buf[qid] + len, e->skb->data,
> +		       skb_headlen(e->skb));
> +		len +=3D skb_headlen(e->skb);
> +		nframes++;
> +
> +		skb_walk_frags(e->skb, iter) {
> +			memcpy(sdio->xmit_buf[qid] + len, iter->data,
> +			       iter->len);
> +			len +=3D iter->len;
> +			nframes++;
> +		}
> +
> +		if (unlikely(pad)) {
> +			memset(sdio->xmit_buf[qid] + len, 0, pad);
> +			len +=3D pad;
> +		}
> +next:
> +		q->first =3D (q->first + 1) % q->ndesc;
> +		e->done =3D true;
> +	}
> +
> +	if (nframes) {
> +		memset(sdio->xmit_buf[qid] + len, 0, 4);
> +		err =3D __mt76_connac_sdio_xmit_queue(dev, sdio->xmit_buf[qid], len + =
4);
> +		if (err)
> +			return err;
> +	}
> +	mt76_connac_sdio_tx_update_quota(sdio, mcu, pse_sz, ple_sz);
> +
> +	mt76_worker_schedule(&sdio->status_worker);
> +
> +	return nframes;
> +}
> +
> +void mt76_connac_sdio_txrx(struct mt76_dev *dev)
> +{
> +	struct mt76_sdio *sdio =3D &dev->sdio;
> +	int i, nframes, ret;
> +
> +	/* disable interrupt */
> +	sdio_claim_host(sdio->func);
> +	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
> +
> +	do {
> +		nframes =3D 0;
> +
> +		/* tx */
> +		for (i =3D 0; i <=3D MT_TXQ_PSD; i++) {
> +			ret =3D mt76_connac_sdio_tx_run_queue(dev, dev->phy.q_tx[i]);
> +			if (ret > 0)
> +				nframes +=3D ret;
> +		}
> +		ret =3D mt76_connac_sdio_tx_run_queue(dev, dev->q_mcu[MT_MCUQ_WM]);
> +		if (ret > 0)
> +			nframes +=3D ret;
> +
> +		/* rx */
> +		ret =3D mt76_connac_sdio_rx_handler(dev);
> +		if (ret > 0)
> +			nframes +=3D ret;
> +	} while (nframes > 0);
> +
> +	/* enable interrupt */
> +	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
> +	sdio_release_host(sdio->func);
> +}
> +EXPORT_SYMBOL_GPL(mt76_connac_sdio_txrx);
> --=20
> 2.25.1
>=20

--4mVMvcy2JhSq7fYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUHzMgAKCRA6cBh0uS2t
rJGlAQC/ir+HGL6BKPmBcJgayfL9NyDk55XHRjAYlsa1u5N/XAEAsC8i5XUlQ9SJ
w0zxEDt76Aeg3mcnG05rVewbQfALZww=
=ANSp
-----END PGP SIGNATURE-----

--4mVMvcy2JhSq7fYf--


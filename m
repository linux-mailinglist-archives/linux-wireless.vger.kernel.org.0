Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A0D10D5D3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 13:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfK2Mry (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 07:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfK2Mrx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 07:47:53 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D686B20869;
        Fri, 29 Nov 2019 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575031673;
        bh=8mpzu7dSpAW3zgsLY5HpFRbSi5uXYsx8cRW9lxPm208=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wMyMmqXpyIUeftc/wN04bBCgUHyTfX1d4gxz02XkYEqEKgmnXME13Wnkjpfk16qVh
         kV8008Q4B7zZAwySZbzlmTNeVHl5BWS3LxfOjiJibL0awC3SZIu9nUVa4pPbZiDAzW
         YfYnghIgLDhpZnOGTMKWgjlrhgWWyAlJPtm0vpRk=
Date:   Fri, 29 Nov 2019 14:47:44 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: Re: [PATCH 1/3] mt76: usb: use max packet length for m76u_copy
Message-ID: <20191129124744.GE32696@localhost.localdomain>
References: <1575030748-2218-1-git-send-email-sgruszka@redhat.com>
 <1575030748-2218-2-git-send-email-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <1575030748-2218-2-git-send-email-sgruszka@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> For transferring data over USB the optimal size is endpoint maxpacket.
> For my hardware maxpaket for control endpoint is 64 bytes and changing
> to this value from 128 bytes further shorten TBTT work time from
> 3ms to 1ms.
>=20
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h |  7 +++----
>  drivers/net/wireless/mediatek/mt76/usb.c  | 29 +++++++++++++++++++------=
----
>  2 files changed, 22 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 1981912de1f9..c268c3d76b3d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -381,10 +381,9 @@ enum mt76u_out_ep {
>  #define MCU_RESP_URB_SIZE	1024
>  struct mt76_usb {
>  	struct mutex usb_ctrl_mtx;
> -	union {
> -		u8 data[128];
> -		__le32 reg_val;
> -	};
> +	__le32 reg_val;
> +	u8 *data;
> +	u16 data_len;
> =20
>  	struct tasklet_struct rx_tasklet;
>  	struct workqueue_struct *stat_wq;
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wirel=
ess/mediatek/mt76/usb.c
> index 97b263ce3872..a9ff2bd62fc9 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -163,7 +163,7 @@ static void mt76u_copy(struct mt76_dev *dev, u32 offs=
et,
> =20
>  	mutex_lock(&usb->usb_ctrl_mtx);
>  	while (i < len) {
> -		current_batch_size =3D min_t(int, sizeof(usb->data), len - i);
> +		current_batch_size =3D min_t(int, usb->data_len, len - i);
>  		memcpy(usb->data, val + i, current_batch_size);
>  		ret =3D __mt76u_vendor_request(dev, MT_VEND_MULTI_WRITE,
>  					     USB_DIR_OUT | USB_TYPE_VENDOR,
> @@ -950,6 +950,15 @@ int mt76u_alloc_queues(struct mt76_dev *dev)
>  	.kick =3D mt76u_tx_kick,
>  };
> =20
> +void mt76u_deinit(struct mt76_dev *dev)
> +{
> +	if (dev->usb.stat_wq) {
> +		destroy_workqueue(dev->usb.stat_wq);
> +		dev->usb.stat_wq =3D NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mt76u_deinit);
> +
>  int mt76u_init(struct mt76_dev *dev,
>  	       struct usb_interface *intf)
>  {
> @@ -974,6 +983,15 @@ int mt76u_init(struct mt76_dev *dev,
>  	if (!usb->stat_wq)
>  		return -ENOMEM;
> =20
> +	usb->data_len =3D usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
> +	if (usb->data_len < 32)
> +		usb->data_len =3D 32;

Hi Stanislaw,

	usb->data_len =3D max_t(u16, 32,
			      usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1));

Moreover are you sure using ctrl endpoint 0 is fine for all devices?

Regards,
Lorenzo

> +	usb->data =3D devm_kmalloc(dev->dev, usb->data_len, GFP_KERNEL);
> +	if (!usb->data) {
> +		mt76u_deinit(dev);
> +		return -ENOMEM;
> +	}
> +
>  	mutex_init(&usb->mcu.mutex);
> =20
>  	mutex_init(&usb->usb_ctrl_mtx);
> @@ -988,14 +1006,5 @@ int mt76u_init(struct mt76_dev *dev,
>  }
>  EXPORT_SYMBOL_GPL(mt76u_init);
> =20
> -void mt76u_deinit(struct mt76_dev *dev)
> -{
> -	if (dev->usb.stat_wq) {
> -		destroy_workqueue(dev->usb.stat_wq);
> -		dev->usb.stat_wq =3D NULL;
> -	}
> -}
> -EXPORT_SYMBOL_GPL(mt76u_deinit);
> -
>  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
>  MODULE_LICENSE("Dual BSD/GPL");
> --=20
> 1.9.3
>=20

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXeETbgAKCRA6cBh0uS2t
rBBOAQDNnArWFYTSEu65q/Zotlox8Wshke+eMwDAvZX4jyUo0wEA33SXpGwe0pn4
Nyw6f2d8XhhewZTatTDC2U//vPDEYQw=
=VGtx
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--

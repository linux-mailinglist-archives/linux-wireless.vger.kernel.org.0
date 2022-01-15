Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBB448F372
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jan 2022 01:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiAOAWG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 19:22:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230450AbiAOAWF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 19:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642206124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PQ+jsLhgslb86SxGOTsTLC1mkqty0MFdlpHfF3PjiQs=;
        b=Umps73OZ9PXe2I0xva9Q29xqXfiNridbFGyYP6yGwrjxmUo+vP1eBZTm5ZdPCgkgRFhe4x
        zDEqTT7Bs1/5bJGCgNZx0dLZ0znqz7QXqJslLV65fT9qC0GUU/GIcGDvbEyzbYzQaVmNCX
        EUuD6Hvydt0g2wq6gXMtWzcwhMTXgWs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-12ql0BnSOB6KjitMrKUVBg-1; Fri, 14 Jan 2022 19:22:01 -0500
X-MC-Unique: 12ql0BnSOB6KjitMrKUVBg-1
Received: by mail-ed1-f71.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso9471350edt.20
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 16:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQ+jsLhgslb86SxGOTsTLC1mkqty0MFdlpHfF3PjiQs=;
        b=C8Q0WmTz+LD0YynCGLlylZ9Z5HOFGCaBE70N4rS/TsE41kQ6zedskRxJX8Z/DERUlx
         Ikkof+vrCCyzvarkgdT0XIjG/fE/GUaV8z6LDOtnPxNgbbP4Yn9OKJs66Hs8av+Sn9F/
         QK9GIWdkwZsOOsYVmd/9Y8Q09ox+XFpKIG5dlZpJpjfZpUbCEjEC+077e3V88wA3o4Z3
         zjLxA4WWPJTXitSxaN7fs1hktjyUhXaaM2+Eb+SK8WboFHi6H7B2ISoaSv/WUouyxzSl
         BUoVQT9YAoSnMd2kmbmkUq53fljbS82elrTVKNcI5+giejDg8Tspkv2hMc0HtNafxz61
         RW2Q==
X-Gm-Message-State: AOAM531mR66Uy59XVLv/VQWM/9NdC3JyqITqDuUnw8Ls0wrTqexgZHp+
        1wbY+ZSCWL2MzMb9oKx9YKTi9/3f8MVFOzw9BQJBokP5CZVBgOipcH7KVZfOhrKNA3t1a3+bnvJ
        aD5e8ZoPYewuXgffv4cXhiQW1O/o=
X-Received: by 2002:a50:fd12:: with SMTP id i18mr9672149eds.88.1642206120397;
        Fri, 14 Jan 2022 16:22:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9PIKnZr9zn3NJ3qYK883GYZh9phOeMwKN3HPn5P4Y6dMWSEHUij1yAmPNfqqICEadg3yEuQ==
X-Received: by 2002:a50:fd12:: with SMTP id i18mr9672122eds.88.1642206120167;
        Fri, 14 Jan 2022 16:22:00 -0800 (PST)
Received: from localhost (net-93-146-37-237.cust.vodafonedsl.it. [93.146.37.237])
        by smtp.gmail.com with ESMTPSA id g16sm2798064edz.33.2022.01.14.16.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:21:59 -0800 (PST)
Date:   Sat, 15 Jan 2022 01:21:57 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Mark-YW.Chen@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] mt76: sdio: honor the largest Tx buffer the
 hardware can support
Message-ID: <YeITpQtMvBPgWWhH@lore-desk>
References: <c09673a115c39f7af692efb984a5dc0c75238a64.1642204233.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FyDFronZURlDsQtN"
Content-Disposition: inline
In-Reply-To: <c09673a115c39f7af692efb984a5dc0c75238a64.1642204233.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--FyDFronZURlDsQtN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> We don't have to create a separate sdio.xmit_buf buffer for each queue.
> Instead, we just need to create one, reuse it across all queues to reduce
> memory consumption further.
>=20
> And then we should take it into account the actual the host and the device
> MMC capability to determine what the appropriate xmit_buf_size can be.
>=20
> Both MT7921S and MT7663 can support up to Tx FIFO size of 0x3fe00 which
> means the device can receive 511 blocks of block size 512 in a row from
> the host. So if the driver aggregates the frames as many as possible the
> the device can support, we can merge multiple MMC requests into a single
> one to get rid of the overhead of the handling and synchronizing in those
> unnecessary MMC requests and reduce the SDIO lock contention with the
> Bluetooth concurrent traffic and finally to have the higher bus
> utilization with less idle cycle.
>=20
> With the patch, it is helpful for WiFi to have steady throughput
> performance especially while running Bluetooth concurrently.
>=20
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> ---
> v1 -> v2:
> 1. move buffer allocation in mt76s_init() and remove duplicated
>    code in mt7663/mt7921.
> 2. move mt76s_get_xmit_buf_sz into mt76s_init()
> 3. merge 2/3 and 3/3 in v1
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h       |  5 +++--
>  .../net/wireless/mediatek/mt76/mt7615/sdio.c    | 12 +-----------
>  .../net/wireless/mediatek/mt76/mt7921/sdio.c    | 12 +-----------
>  drivers/net/wireless/mediatek/mt76/sdio.c       | 14 +++++++++++++-
>  drivers/net/wireless/mediatek/mt76/sdio_txrx.c  | 17 +++++++----------
>  5 files changed, 25 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 14f60fcb6a34..43abf0679876 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -497,7 +497,7 @@ struct mt76_usb {
>  	} mcu;
>  };
> =20
> -#define MT76S_XMIT_BUF_SZ	(16 * PAGE_SIZE)
> +#define MT76S_XMIT_BUF_SZ	0x3fe00
>  #define MT76S_NUM_TX_ENTRIES	256
>  #define MT76S_NUM_RX_ENTRIES	512
>  struct mt76_sdio {
> @@ -507,7 +507,8 @@ struct mt76_sdio {
> =20
>  	struct work_struct stat_work;
> =20
> -	u8 *xmit_buf[IEEE80211_NUM_ACS + 2];
> +	u8 *xmit_buf;
> +	u32 xmit_buf_sz;
> =20
>  	struct sdio_func *func;
>  	void *intr_data;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/sdio.c
> index 71162befdae8..49ab3a1f3b9b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
> @@ -101,7 +101,7 @@ static int mt7663s_probe(struct sdio_func *func,
>  	struct ieee80211_ops *ops;
>  	struct mt7615_dev *dev;
>  	struct mt76_dev *mdev;
> -	int i, ret;
> +	int ret;
> =20
>  	ops =3D devm_kmemdup(&func->dev, &mt7615_ops, sizeof(mt7615_ops),
>  			   GFP_KERNEL);
> @@ -140,16 +140,6 @@ static int mt7663s_probe(struct sdio_func *func,
>  		goto error;
>  	}
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(mdev->sdio.xmit_buf); i++) {
> -		mdev->sdio.xmit_buf[i] =3D devm_kmalloc(mdev->dev,
> -						      MT76S_XMIT_BUF_SZ,
> -						      GFP_KERNEL);
> -		if (!mdev->sdio.xmit_buf[i]) {
> -			ret =3D -ENOMEM;
> -			goto error;
> -		}
> -	}
> -
>  	ret =3D mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
>  	if (ret)
>  		goto error;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/sdio.c
> index 743b63f66efa..a6ae29c97e0e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> @@ -121,7 +121,7 @@ static int mt7921s_probe(struct sdio_func *func,
> =20
>  	struct mt7921_dev *dev;
>  	struct mt76_dev *mdev;
> -	int ret, i;
> +	int ret;
> =20
>  	mdev =3D mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
>  				 &drv_ops);
> @@ -154,16 +154,6 @@ static int mt7921s_probe(struct sdio_func *func,
>  		goto error;
>  	}
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(mdev->sdio.xmit_buf); i++) {
> -		mdev->sdio.xmit_buf[i] =3D devm_kmalloc(mdev->dev,
> -						      MT76S_XMIT_BUF_SZ,
> -						      GFP_KERNEL);
> -		if (!mdev->sdio.xmit_buf[i]) {
> -			ret =3D -ENOMEM;
> -			goto error;
> -		}
> -	}
> -
>  	ret =3D mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
>  	if (ret)
>  		goto error;
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wire=
less/mediatek/mt76/sdio.c
> index 54f72d215948..def7f325f5c5 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio.c
> @@ -12,6 +12,8 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mmc/sdio_func.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
>  #include <linux/sched.h>
>  #include <linux/kthread.h>
> =20
> @@ -627,6 +629,7 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_func=
 *func,
>  	       const struct mt76_bus_ops *bus_ops)
>  {
>  	struct mt76_sdio *sdio =3D &dev->sdio;
> +	u32 host_max_cap;
>  	int err;
> =20
>  	err =3D mt76_worker_setup(dev->hw, &sdio->status_worker,
> @@ -648,7 +651,16 @@ int mt76s_init(struct mt76_dev *dev, struct sdio_fun=
c *func,
>  	dev->bus =3D bus_ops;
>  	dev->sdio.func =3D func;
> =20
> -	return 0;
> +	host_max_cap =3D min_t(u32, func->card->host->max_req_size,
> +			     func->cur_blksize *
> +			     func->card->host->max_blk_count);
> +	dev->sdio.xmit_buf_sz =3D min_t(u32, host_max_cap, MT76S_XMIT_BUF_SZ);
> +	dev->sdio.xmit_buf =3D devm_kmalloc(dev->dev, dev->sdio.xmit_buf_sz,
> +					  GFP_KERNEL);
> +	if (!dev->sdio.xmit_buf)
> +		err =3D -ENOMEM;
> +
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(mt76s_init);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net=
/wireless/mediatek/mt76/sdio_txrx.c
> index 488ad7734d85..9fcf507e09bd 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> @@ -229,12 +229,11 @@ static int __mt76s_xmit_queue(struct mt76_dev *dev,=
 u8 *data, int len)
> =20
>  static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
>  {
> -	int qid, err, nframes =3D 0, len =3D 0, pse_sz =3D 0, ple_sz =3D 0;
> +	int err, nframes =3D 0, len =3D 0, pse_sz =3D 0, ple_sz =3D 0;
>  	bool mcu =3D q =3D=3D dev->q_mcu[MT_MCUQ_WM];
>  	struct mt76_sdio *sdio =3D &dev->sdio;
>  	u8 pad;
> =20
> -	qid =3D mcu ? ARRAY_SIZE(sdio->xmit_buf) - 1 : q->qid;
>  	while (q->first !=3D q->head) {
>  		struct mt76_queue_entry *e =3D &q->entry[q->first];
>  		struct sk_buff *iter;
> @@ -255,27 +254,25 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev,=
 struct mt76_queue *q)
>  		}
> =20
>  		pad =3D roundup(e->skb->len, 4) - e->skb->len;
> -		if (len + e->skb->len + pad + 4 > MT76S_XMIT_BUF_SZ)
> +		if (len + e->skb->len + pad + 4 > dev->sdio.xmit_buf_sz)
>  			break;
> =20
>  		if (mt76s_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
>  					&ple_sz))
>  			break;
> =20
> -		memcpy(sdio->xmit_buf[qid] + len, e->skb->data,
> -		       skb_headlen(e->skb));
> +		memcpy(sdio->xmit_buf + len, e->skb->data, skb_headlen(e->skb));
>  		len +=3D skb_headlen(e->skb);
>  		nframes++;
> =20
>  		skb_walk_frags(e->skb, iter) {
> -			memcpy(sdio->xmit_buf[qid] + len, iter->data,
> -			       iter->len);
> +			memcpy(sdio->xmit_buf + len, iter->data, iter->len);
>  			len +=3D iter->len;
>  			nframes++;
>  		}
> =20
>  		if (unlikely(pad)) {
> -			memset(sdio->xmit_buf[qid] + len, 0, pad);
> +			memset(sdio->xmit_buf + len, 0, pad);
>  			len +=3D pad;
>  		}
>  next:
> @@ -284,8 +281,8 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev, s=
truct mt76_queue *q)
>  	}
> =20
>  	if (nframes) {
> -		memset(sdio->xmit_buf[qid] + len, 0, 4);
> -		err =3D __mt76s_xmit_queue(dev, sdio->xmit_buf[qid], len + 4);
> +		memset(sdio->xmit_buf + len, 0, 4);
> +		err =3D __mt76s_xmit_queue(dev, sdio->xmit_buf, len + 4);
>  		if (err)
>  			return err;
>  	}
> --=20
> 2.25.1
>=20

--FyDFronZURlDsQtN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYeITpQAKCRA6cBh0uS2t
rDV4AP9VS+PnLKAiCkX/BFp3fsIh6h3NA3/GL6iNAm0a5VVtsAD/VfDqTDX+8O23
9ythKDVgX0vC2ZjQGGCaCEVZeims0g4=
=GIwz
-----END PGP SIGNATURE-----

--FyDFronZURlDsQtN--


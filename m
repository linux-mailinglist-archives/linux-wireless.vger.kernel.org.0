Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE07548D4C4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiAMJKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 04:10:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229902AbiAMJJ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 04:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642064999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73rtxd1HviwmdX+Fg+f0EBqL1KRigMkO6n8S/v0EwiU=;
        b=GD56jpLh5kd7WJUfpIT5J3/t/HONxofHDFr34I6fe60e0rM5jOq7LXAD2KvfJR/n3Y1M7+
        y4y+bBDGXqljjFG4Kbtu7hhc0LOBJEpBtm3XI1Iuhbv27OFlbVm78wclSF2ZzIe2sr6kH0
        2GKrmMqHJTKIp7Zj51EwLrXbp00b3mc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-KnVH4GmqONGCebmXHhyreg-1; Thu, 13 Jan 2022 04:09:57 -0500
X-MC-Unique: KnVH4GmqONGCebmXHhyreg-1
Received: by mail-wr1-f72.google.com with SMTP id o28-20020adfa11c000000b001a60fd79c21so958720wro.19
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 01:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=73rtxd1HviwmdX+Fg+f0EBqL1KRigMkO6n8S/v0EwiU=;
        b=6wauIs8KxrA70KNq7bGsGEr9G9zTUyoOQndfgg2wn3yE6dJyjootpBkeyEluqxWvHK
         zkwdezx8JSY9uQ7Z5k5RZPQkfZPYqcGjLVDZ42uYtfHZgkXD5a2kgVfLk92KquEC/0l0
         gwT6b1i2J5SzQgjvJDJ9XYzdzFcw5cjjvcYcPFaxaIPEXCjwmNhehPeF+ClkHY0VoEkn
         tKeRTlYlGUSYbMCjXgHz1YXsDjoa109+D4UCr96qEZ19xPr3/tEBcSsBSMJVL8SOe3iD
         Zl0fva0AclpbX6cXarQkH0ZaN7w9EHwDjEd0XOU0kXBHh3o9YI06hCi/KjehTZePfHkp
         lchg==
X-Gm-Message-State: AOAM530ljXZlC1qBRfH//5flOiGNnYKlD9fEdefkaOJEP0pUzbvl2GhB
        w21t/FxyfptiRkbgtL2sVzmwU6ISizXbxSb95RBEABlxCIhHykhHTk6/JUn7c8CTnGWVI/hRS/W
        avNDI9SmoIVLzBbV24QrPLG4+1t4=
X-Received: by 2002:a5d:6c6c:: with SMTP id r12mr3135913wrz.676.1642064996030;
        Thu, 13 Jan 2022 01:09:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfNaoPSl66+Pt3uyK81OJXwGYkX4R/yqwvz/BiyCuY8YiQKGGT585uAYWHwdyAByy1fNaekA==
X-Received: by 2002:a5d:6c6c:: with SMTP id r12mr3135895wrz.676.1642064995796;
        Thu, 13 Jan 2022 01:09:55 -0800 (PST)
Received: from localhost (net-93-146-37-237.cust.vodafonedsl.it. [93.146.37.237])
        by smtp.gmail.com with ESMTPSA id o10sm2228831wmq.31.2022.01.13.01.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:09:55 -0800 (PST)
Date:   Thu, 13 Jan 2022 10:09:53 +0100
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
Subject: Re: [PATCH 2/3] mt76: sdio: honor the largest Tx buffer the hardware
 can support
Message-ID: <Yd/sYYP1XJ3J8RuR@lore-desk>
References: <651a010d8ff888909b5b8363fa4b243aadc62d45.1642061035.git.objelf@gmail.com>
 <557712deb9fc0e78d9a8dd7c68177fe2ae2a38ec.1642061035.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YpJVo9IvTr9JUqYp"
Content-Disposition: inline
In-Reply-To: <557712deb9fc0e78d9a8dd7c68177fe2ae2a38ec.1642061035.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--YpJVo9IvTr9JUqYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> We should take it into account the actual the host and the device MMC
> capability to determine what the appropriate xmit_buf_size can be.
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
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h        |  4 +++-
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c |  3 ++-
>  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c |  3 ++-
>  drivers/net/wireless/mediatek/mt76/sdio.c        | 13 +++++++++++++
>  drivers/net/wireless/mediatek/mt76/sdio_txrx.c   |  2 +-
>  5 files changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 4029a2217397..8703ecd6396f 100644
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
> @@ -508,6 +508,7 @@ struct mt76_sdio {
>  	struct work_struct stat_work;
> =20
>  	u8 *xmit_buf;
> +	u32 xmit_buf_sz;
> =20
>  	struct sdio_func *func;
>  	void *intr_data;
> @@ -1280,6 +1281,7 @@ void mt76u_queues_deinit(struct mt76_dev *dev);
> =20
>  int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
>  	       const struct mt76_bus_ops *bus_ops);
> +u32 mt76s_get_xmit_buf_sz(struct mt76_dev *dev, u32 dev_xmit_sz);
>  int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid);
>  int mt76s_alloc_tx(struct mt76_dev *dev);
>  void mt76s_deinit(struct mt76_dev *dev);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/sdio.c
> index 554160b0ea9a..ed778b635391 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
> @@ -140,7 +140,8 @@ static int mt7663s_probe(struct sdio_func *func,
>  		goto error;
>  	}
> =20
> -	mdev->sdio.xmit_buf =3D devm_kmalloc(mdev->dev, MT76S_XMIT_BUF_SZ,
> +	mdev->sdio.xmit_buf_sz =3D mt76s_get_xmit_buf_sz(mdev, MT76S_XMIT_BUF_S=
Z);
> +	mdev->sdio.xmit_buf =3D devm_kmalloc(mdev->dev, mdev->sdio.xmit_buf_sz,
>  					   GFP_KERNEL);
>  	if (!mdev->sdio.xmit_buf) {
>  		ret =3D -ENOMEM;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/sdio.c
> index c58c14e28430..6e5d9e9459ad 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> @@ -154,7 +154,8 @@ static int mt7921s_probe(struct sdio_func *func,
>  		goto error;
>  	}
> =20
> -	mdev->sdio.xmit_buf =3D devm_kmalloc(mdev->dev, MT76S_XMIT_BUF_SZ,
> +	mdev->sdio.xmit_buf_sz =3D mt76s_get_xmit_buf_sz(mdev, MT76S_XMIT_BUF_S=
Z);
> +	mdev->sdio.xmit_buf =3D devm_kmalloc(mdev->dev, mdev->sdio.xmit_buf_sz,
>  					   GFP_KERNEL);
>  	if (!mdev->sdio.xmit_buf) {
>  		ret =3D -ENOMEM;
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wire=
less/mediatek/mt76/sdio.c
> index 54f72d215948..bd0027152026 100644
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
> @@ -299,6 +301,17 @@ int mt76s_hw_init(struct mt76_dev *dev, struct sdio_=
func *func, int hw_ver)
>  }
>  EXPORT_SYMBOL_GPL(mt76s_hw_init);
> =20
> +u32 mt76s_get_xmit_buf_sz(struct mt76_dev *dev, u32 dev_max_len)
> +{
> +	struct sdio_func *func =3D dev->sdio.func;
> +	u32 host_max_len =3D min_t(u32, func->card->host->max_req_size,
> +				 func->cur_blksize *
> +				 func->card->host->max_blk_count);
> +
> +	return min_t(u32, host_max_len, dev_max_len);
> +}
> +EXPORT_SYMBOL_GPL(mt76s_get_xmit_buf_sz);

I think we can squash this patch with the previous one and move the code ab=
ove
in mt76s_init(). Agree?

Regards,
Lorenzo

> +
>  int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
>  {
>  	struct mt76_queue *q =3D &dev->q_rx[qid];
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net=
/wireless/mediatek/mt76/sdio_txrx.c
> index a04cd2444247..9fcf507e09bd 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> @@ -254,7 +254,7 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev, s=
truct mt76_queue *q)
>  		}
> =20
>  		pad =3D roundup(e->skb->len, 4) - e->skb->len;
> -		if (len + e->skb->len + pad + 4 > MT76S_XMIT_BUF_SZ)
> +		if (len + e->skb->len + pad + 4 > dev->sdio.xmit_buf_sz)
>  			break;
> =20
>  		if (mt76s_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
> --=20
> 2.25.1
>=20

--YpJVo9IvTr9JUqYp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYd/sYQAKCRA6cBh0uS2t
rCjdAQCN1hwThldnbEpvYcvGhZENmpChApdMbqk2X1Nws6z5OAEA69kJvX6xla99
70vZd26qnaF6J/thjUIkOy878qR0vQI=
=/9DO
-----END PGP SIGNATURE-----

--YpJVo9IvTr9JUqYp--


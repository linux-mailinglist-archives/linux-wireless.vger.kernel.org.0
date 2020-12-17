Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969682DD92D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 20:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgLQTLw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 14:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730125AbgLQTLw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 14:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608232225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1JhEQ3kjEdAO3a6W91l4XPxzQ8gzdyyw66DLDsW3J0c=;
        b=Kplxv+DLneOe5+pmXlMNM9FbZ5vLQiY3obUs56SRZwvMI8D3XLgp2D/TugkzioTUyIIk/5
        NqJPSDubne/a+IN0UzUfXjfcEXLQacVxi4lgFEJ9HXqKOA4XTK5pCNYKwgVNbC675dlnu3
        x1kdp2KTKYcC8LyHLce7voA+YpyRGFQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-KlUJozLnMqOrh_pm_YUIWQ-1; Thu, 17 Dec 2020 14:10:22 -0500
X-MC-Unique: KlUJozLnMqOrh_pm_YUIWQ-1
Received: by mail-ej1-f71.google.com with SMTP id n17so9055238eja.23
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 11:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1JhEQ3kjEdAO3a6W91l4XPxzQ8gzdyyw66DLDsW3J0c=;
        b=f3R1Vj0Z7tyrTZoRgHa7JjDo/Ffj9RUtYK8Qj4xjmowpWzDHOFuBMqjmGMiwHGQDPl
         BUPD6Ie5HqYknm8ItDOoZ3OM50HzQS0yAB04STERnQAXfc7depl9aBeBWeZ4Iz+nYQF3
         oCBJdSZhWTtgY6+ZVgldUx3hD4YeMHgmXS7IFfhW+eLkTSVe9RgyODdvdBhf8RfThWWn
         iZNcJavi0cLhw2SLCUp+dc1IjL82rebeZoC5ECyImW/TkiMC87cIcJcuSznZjZWCXcMf
         it4MKpJD1s9vW9QhEUWBme18GNOtsdSTidIQ0KHN3ruTfkIFg4nD+2GsGtq8L1F09TM7
         iZ1w==
X-Gm-Message-State: AOAM532hNBUJQs9xmHOQeqKuYISvpjnru3lOldlEHZRlntK+PPrHjftm
        13jNd17IMkyZmSNgaVTCz4TzzrI0iDs1uK56tZkEiMljejf3dArRxJga/dJcHBb8N+xvEOpznBi
        otcWi5/+dOL2NiEWEU8YtUOsDgZ4=
X-Received: by 2002:a17:906:4c55:: with SMTP id d21mr519189ejw.116.1608232221063;
        Thu, 17 Dec 2020 11:10:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXbvAsiRt9nAZ/LGBiPAC0ggc4XInzQqpQismtM9iEGVv626ifP/J7q9zsnFJJMXMBrtrmCg==
X-Received: by 2002:a17:906:4c55:: with SMTP id d21mr519174ejw.116.1608232220921;
        Thu, 17 Dec 2020 11:10:20 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id p24sm21036461edr.65.2020.12.17.11.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 11:10:20 -0800 (PST)
Date:   Thu, 17 Dec 2020 20:10:17 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     kvalo@codeaurora.org
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] mt76: usb: remove wake logic in mt76u_status_worker
Message-ID: <20201217191017.GG16606@lore-desk>
References: <cover.1607164041.git.lorenzo@kernel.org>
 <00009bf0cfdc9565e4432cad3ed51888c667c25d.1607164041.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline
In-Reply-To: <00009bf0cfdc9565e4432cad3ed51888c667c25d.1607164041.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Similar to mmio code path, remove wake logic in mt76u_status_worker
> handler

Starting from commit '90d494c99a99fa2eb858754345c4a9c851b409a0
("mt76: improve tx queue stop/wake")', the wake queue logic on
the usb status path is no longer necessary since the hw queues
are no longer stopped on the mt76 tx path.

Regards,
Lorenzo

>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/usb.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wirel=
ess/mediatek/mt76/usb.c
> index 81393788f98e..658b36a2281d 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -811,7 +811,6 @@ static void mt76u_status_worker(struct mt76_worker *w)
>  	struct mt76_dev *dev =3D container_of(usb, struct mt76_dev, usb);
>  	struct mt76_queue_entry entry;
>  	struct mt76_queue *q;
> -	bool wake;
>  	int i;
> =20
>  	for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
> @@ -827,10 +826,6 @@ static void mt76u_status_worker(struct mt76_worker *=
w)
>  			mt76_queue_tx_complete(dev, q, &entry);
>  		}
> =20
> -		wake =3D q->stopped && q->queued < q->ndesc - 8;
> -		if (wake)
> -			q->stopped =3D false;
> -
>  		if (!q->queued)
>  			wake_up(&dev->tx_wait);
> =20
> @@ -839,8 +834,6 @@ static void mt76u_status_worker(struct mt76_worker *w)
>  		if (dev->drv->tx_status_data &&
>  		    !test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
>  			queue_work(dev->wq, &dev->usb.stat_work);
> -		if (wake)
> -			ieee80211_wake_queue(dev->hw, i);
>  	}
>  }
> =20
> --=20
> 2.28.0
>=20

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX9utFgAKCRA6cBh0uS2t
rED0AQCKrkvnVaMZZjn6ox0k6DjZeDP7BNMgcwAiNvqXYtFyaAEA8g3cO1f4Njtl
Q0o2wQyE8W1OlrHQXPR3Je2jlwglCAU=
=mQJ6
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1FA4105EA
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Sep 2021 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhIRKRe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Sep 2021 06:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233148AbhIRKRd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Sep 2021 06:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631960169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wM6uic+F1/IRDYaLuFeaUrQpJFPWb8bNYjKi6M7eWmU=;
        b=X0Mk8e07a5Ec9DXF8hmoJsZuYDzO65nBkUiKzHWl90N7/n8adIJZrCpAUaP3nHb9RdWokI
        RRv6sAm8ZqYUeN6JpNqS4UMBV82y9puu6WwPuFnsbUYzAYaYn7EJ7lZ+BplUcC/MOOVVnL
        YZFm3J2zXEMWy4jvSTfQF6VnSsRIR3k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-ghuS-j9mPImefyZuWhtlOw-1; Sat, 18 Sep 2021 06:16:07 -0400
X-MC-Unique: ghuS-j9mPImefyZuWhtlOw-1
Received: by mail-ed1-f69.google.com with SMTP id q17-20020a50c351000000b003d81427d25cso4968574edb.15
        for <linux-wireless@vger.kernel.org>; Sat, 18 Sep 2021 03:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wM6uic+F1/IRDYaLuFeaUrQpJFPWb8bNYjKi6M7eWmU=;
        b=a3CaEL6Ju4Npsp6fgGJTNqL0qeDj3FGifcGSSF3KDwRtV30uMqEk1v4b9IOF1RpJQ6
         Rt3c16ykZzIbvRk6l9tMxGKq2FLMpWOO6hg6qA6+Lc/cMREwEOAruHDYxb2xEXs2qHJh
         jlDOIAXBnCcRcMQW08dPkkyqjHoQTZ6NCMWY/2XPL3uim+6yGt3uNOv3KoswXOTiSbEo
         ZXZEnOuwSPtWgVnOMh5Hy48J4K3hXIR6y/UN2y9cqxbs8lnOSyLyFYBa5V/7KSFgBrg+
         y76C9QA0wt+4JpUo0t6DwbeidBYczT2PNsUWQlCYV0ljxogMnaC6V+PrZYHNOTpK6zC8
         GaZQ==
X-Gm-Message-State: AOAM533ZhMnCT4PXQDiTvXycB4YYO91zdd72M8i7GuzEwEjW+4WdHAhM
        2a8m+BwC3LtFSUqF3dI1ylczAjTQBArvTpYrToLyV10unVpkXzWAtoqE3HBZ4Uw9rGL60tyUUo8
        C/tXWOWynLdIqzAO3nKjwt/Nfl+g=
X-Received: by 2002:a17:907:7613:: with SMTP id jx19mr17917983ejc.453.1631960166524;
        Sat, 18 Sep 2021 03:16:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytssHuzY4z8XOtk4cJkfMT6K57I4C7VESQSmyNO/iQc4RJv8Qj6Z1bwq1Xgt7u6XMXTBxyWQ==
X-Received: by 2002:a17:907:7613:: with SMTP id jx19mr17917961ejc.453.1631960166314;
        Sat, 18 Sep 2021 03:16:06 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id u19sm2709958edr.15.2021.09.18.03.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 03:16:05 -0700 (PDT)
Date:   Sat, 18 Sep 2021 12:16:02 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 08/16] mt76: mt7921: make all event parser reusable
 between mt7921s and mt7921e
Message-ID: <YUW8YqCxSYiKUF9o@lore-desk>
References: <cover.1631918993.git.objelf@gmail.com>
 <a6aebd446a9aa7902397a7e7b87fe427076fc9df.1631918993.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iB/AOOZx2eOqKcCI"
Content-Disposition: inline
In-Reply-To: <a6aebd446a9aa7902397a7e7b87fe427076fc9df.1631918993.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--iB/AOOZx2eOqKcCI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> The longer event such as the event for mcu_get_nic_capability would hold
> the data in paged fragment skb for the SDIO device so we turn the skb to
> be linearized skb before accessing it to reuse the same event parser
> betweem mt7921s and mt7921e.
>=20
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 866b8797f16e..863781895652 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -456,7 +456,14 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *d=
ev, struct sk_buff *skb)
> =20
>  void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
>  {
> -	struct mt7921_mcu_rxd *rxd =3D (struct mt7921_mcu_rxd *)skb->data;
> +	struct mt7921_mcu_rxd *rxd;
> +	int ret;
> +
> +	ret =3D skb_linearize(skb);

nit: we do not need ret variable here:

	if (skb_linearize(skb))
		return;

> +	if (ret)
> +		return;
> +
> +	rxd =3D (struct mt7921_mcu_rxd *)skb->data;
> =20
>  	if (rxd->eid =3D=3D 0x6) {
>  		mt76_mcu_rx_event(&dev->mt76, skb);
> --=20
> 2.25.1
>=20

--iB/AOOZx2eOqKcCI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUW8YAAKCRA6cBh0uS2t
rAr6AQCjszoFDH42lCFqN9Rgq8+TeNT953lr01/bQSjN/UBFiAD+M+t52BYRVxjT
vhExN7QXV8pHqF/sVAPJkx6v7hNrnQo=
=zu93
-----END PGP SIGNATURE-----

--iB/AOOZx2eOqKcCI--


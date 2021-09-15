Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03EC40C655
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 15:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhIONZp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 09:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233395AbhIONZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 09:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631712260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+EQHPW1j/nr8yBB9ckR7pNX7dfQl5K4J9lCzHHL/teg=;
        b=UauaoPYNX66luvSio+g5RSXZ5b2RU/Wo3m9p84p3gxN23jrA0PyPJXE33EFRXPtJmZ7Ql6
        i23x0mFPpnpzXv9h6sYnj+ltoJfayvb2w+aM37dCob+Rp58EdOs3ipyf5q59pke5vzfY6z
        djtUS86zCGiJ2A7zpQsumq1VnvsqLxU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-CUjYet4iM4y28yc1TNWKiw-1; Wed, 15 Sep 2021 09:24:19 -0400
X-MC-Unique: CUjYet4iM4y28yc1TNWKiw-1
Received: by mail-ej1-f71.google.com with SMTP id g4-20020a170906520400b005e7d062772dso1522512ejm.13
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 06:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EQHPW1j/nr8yBB9ckR7pNX7dfQl5K4J9lCzHHL/teg=;
        b=FEox9XXSVubIxeJgF2vez5U2ysRcGJgTcshbRKfodJOejDXYn3au+OD5CyZgp3aigS
         RHUpr2KBaOJLd5l/pUJJvIfEG6SXsIZUJrIG+4yWPSHw6+Of0oFHkS3ru03OAOJdaEdB
         R+yNlpsP/l7dpwLolEs3gAJ2WLkO8KxMOpMtLJ/pYNnlE0oJ4hpn+NaTo68y+DxXpz4s
         sgyVfGzkVpBdKCTgcel+AoPz387ZlrhzMEIiwqoSZO3Ld8UUnom/685vPQgOy6Q4SS8O
         gArgTqzPiZnT7rGh/bCdeZD6836GoqEpS7D28p2DbrmrmADWZYV8iq0uPtFttP+AzPsg
         TgIQ==
X-Gm-Message-State: AOAM5319Cwbo0xtkIUiGdgsNjEdj8UbAT6JvHjK6i6he1NrouBIdjtuQ
        ZdSOIy+tqiznEzdSH8/j8XdPZwQPHOf9EOX3ufeHdoN7KIqr7akBru39bkv96ISsJhEqeZ9JVTu
        RLnXwqcY/3sV3lzm44AOQggtUV+Q=
X-Received: by 2002:a17:906:4482:: with SMTP id y2mr24782917ejo.484.1631712258473;
        Wed, 15 Sep 2021 06:24:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGhhUn9t+zvG660uUbpSHBfnmNPN2Mz5JTmqPiz+EIA/vy6KNBIPqNqgzUtVR7IdJeSClfcg==
X-Received: by 2002:a17:906:4482:: with SMTP id y2mr24782887ejo.484.1631712258259;
        Wed, 15 Sep 2021 06:24:18 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id o15sm6277378ejj.10.2021.09.15.06.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:24:17 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:24:14 +0200
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
Subject: Re: [PATCH v1 09/16] mt76: mt7921: make all event parser resuable
 between mt7921s and mt7921e
Message-ID: <YUHz/gbfzmFszods@lore-desk>
References: <cover.1631667941.git.objelf@gmail.com>
 <764759a9a2befe09000863f04676287665675555.1631667941.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gRsDsI6iq8aKspqC"
Content-Disposition: inline
In-Reply-To: <764759a9a2befe09000863f04676287665675555.1631667941.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--gRsDsI6iq8aKspqC
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
> index f5a8f7fa4244..8e49df20a8cb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -458,7 +458,14 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *d=
ev, struct sk_buff *skb)
> =20
>  void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
>  {
> -	struct mt7921_mcu_rxd *rxd =3D (struct mt7921_mcu_rxd *)skb->data;
> +	struct mt7921_mcu_rxd *rxd;
> +	int ret;
> +
> +	ret =3D skb_linearize(skb);

is it true for sdio only? if so what about doing something like:

if (mt76_is_sdio() && skb_linearize(skb))
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

--gRsDsI6iq8aKspqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUHz/AAKCRA6cBh0uS2t
rOmDAQDa4ZdKxdoFQv8VDOfSAn6PVDgkDaohNhlO8SpBIZjhSwD/cvSbD2ZSHU+V
X1YvOeYxx7Ufgvgqszy80u3QzBjQ5wA=
=6LSj
-----END PGP SIGNATURE-----

--gRsDsI6iq8aKspqC--


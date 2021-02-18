Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31631EB7D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Feb 2021 16:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhBRPYj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Feb 2021 10:24:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231904AbhBRMQZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Feb 2021 07:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613650445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMPBpZME1t5tE5EnXODI2jTTAQWj8QKBprrlHU8JqQE=;
        b=EC5soy9IoR7Mp/VGm6bkh38CWhaG01cDjn+dH4tSlIzAmUrVD6XgnnYDMX6XAj1w4j546G
        SmDamitU0Fca2S4uW0AaB47+pEgtqqIz8n/go0yxj1jUhvuSBqp91IYUjEN3Awo0fYgqT7
        en/vuV1R6D2vSc/4tySOu+U9d4ptygk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-KRn5Yns3NKW2jKi93yOM-g-1; Thu, 18 Feb 2021 07:14:02 -0500
X-MC-Unique: KRn5Yns3NKW2jKi93yOM-g-1
Received: by mail-wm1-f69.google.com with SMTP id z67so1092490wme.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Feb 2021 04:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MMPBpZME1t5tE5EnXODI2jTTAQWj8QKBprrlHU8JqQE=;
        b=h1kRVs/JWnmfFlqjUTCYwC2qDKTc0QRTAAGeebueh6ZJuTmPMQbyuIDFcv+LCcuhMD
         ZAXDR0a7Te/rSC4ZWav2B6y0Ubfo4rflwHl2FwWoWF7uUE2z403CfR4x0C1rupqU+laq
         9kd3hzQczjF+WDgmCNhCC9tpbhhfOpLq/ob4bU6yuTfyxLvbfrUW8dwHx8HB7+0DrMg9
         BWOSjjPQnqh/03D1XSW25JKABDj5JCrb+ClzwuZCiJuC92PqpZKvz2SD0/w7c4H/x8Sp
         wq9mmcaf7ytvvm3q7etB8zfMUXfR//ZEGtwUzR2RFY9wIQdtU1G6Mu0LIz4GmAncj0K1
         cbEg==
X-Gm-Message-State: AOAM532CWHJePWcoWBwNaRsy1vIGr3JZjqqFwXakV1SHVvNa2WRKCxln
        Sjmolzt38Ze8RVJkVrXPr35UW2wEtzoU9x/fstLRrZ/KQ6XZkhlQKGK7WwyzMsT+W0fRowCGRwv
        rmOI/jh32XaAklVDqdDXOCgcZ0B4=
X-Received: by 2002:a7b:c956:: with SMTP id i22mr3455940wml.85.1613650441296;
        Thu, 18 Feb 2021 04:14:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVB889STRI+0pQHvTHBhArsH2WRVsoMeokueejiOuVGEQYWifrmeW4g7v8jdtc6gkuzXnZEQ==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr3455925wml.85.1613650441084;
        Thu, 18 Feb 2021 04:14:01 -0800 (PST)
Received: from localhost ([151.66.54.126])
        by smtp.gmail.com with ESMTPSA id u14sm8617179wro.10.2021.02.18.04.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 04:14:00 -0800 (PST)
Date:   Thu, 18 Feb 2021 13:13:57 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] mt76: mt7615: enable hw rx-amsdu de-aggregation
Message-ID: <YC5aBTfl3Hguglc0@lore-desk>
References: <b7883f5ee09d13f7cbdf5ab1d5fef61ebc79dcc4.1613603857.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w/nz35jDHskm0eYh"
Content-Disposition: inline
In-Reply-To: <b7883f5ee09d13f7cbdf5ab1d5fef61ebc79dcc4.1613603857.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--w/nz35jDHskm0eYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Enable hw rx-amsdu de-aggregation support.
> This is a preliminary patch to enable rx checksum offload.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

For the series:

Tested-by Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c |  3 +--
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 15 ++++++++++++++-
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.h  |  3 +++
>  drivers/net/wireless/mediatek/mt76/mt7615/regs.h |  1 +
>  4 files changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/init.c
> index 571390fa4de7..a97cc723094c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -116,10 +116,9 @@ mt7615_mac_init(struct mt7615_dev *dev)
>  	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_EN);
>  	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0, MT_WF_RMAC_MIB_RXTIME_EN);
> =20
> -	/* disable hdr translation and hw AMSDU */
>  	mt76_wr(dev, MT_DMA_DCR0,
>  		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072) |
> -		MT_DMA_DCR0_RX_VEC_DROP);
> +		MT_DMA_DCR0_RX_VEC_DROP | MT_DMA_DCR0_DAMSDU_EN);
>  	/* disable TDLS filtering */
>  	mt76_clear(dev, MT_WF_PFCR, MT_WF_PFCR_TDLS_EN);
>  	mt76_set(dev, MT_WF_MIB_SCR0, MT_MIB_SCR0_AGG_CNT_RANGE_EN);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mac.c
> index 9bae2f66e1ce..928edd158f64 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -238,7 +238,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev,=
 struct sk_buff *skb)
>  	bool unicast, remove_pad, insert_ccmp_hdr =3D false;
>  	int phy_idx;
>  	int i, idx;
> -	u8 chfreq;
> +	u8 chfreq, amsdu_info;
> =20
>  	memset(status, 0, sizeof(*status));
> =20
> @@ -254,6 +254,9 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev,=
 struct sk_buff *skb)
>  	else
>  		phy_idx =3D -1;
> =20
> +	if (rxd2 & MT_RXD2_NORMAL_AMSDU_ERR)
> +		return -EINVAL;
> +
>  	unicast =3D (rxd1 & MT_RXD1_NORMAL_ADDR_TYPE) =3D=3D MT_RXD1_NORMAL_U2M;
>  	idx =3D FIELD_GET(MT_RXD2_NORMAL_WLAN_IDX, rxd2);
>  	status->wcid =3D mt7615_rx_get_wcid(dev, idx, unicast);
> @@ -446,6 +449,16 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev=
, struct sk_buff *skb)
> =20
>  	skb_pull(skb, (u8 *)rxd - skb->data + 2 * remove_pad);
> =20
> +	amsdu_info =3D FIELD_GET(MT_RXD1_NORMAL_PAYLOAD_FORMAT, rxd1);
> +	status->amsdu =3D !!amsdu_info;
> +	if (status->amsdu) {
> +		status->first_amsdu =3D amsdu_info =3D=3D MT_RXD1_FIRST_AMSDU_FRAME;
> +		status->last_amsdu =3D amsdu_info =3D=3D MT_RXD1_LAST_AMSDU_FRAME;
> +		memmove(skb->data + 2, skb->data,
> +			ieee80211_get_hdrlen_from_skb(skb));
> +		skb_pull(skb, 2);
> +	}
> +
>  	if (insert_ccmp_hdr) {
>  		u8 key_id =3D FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mac.h
> index 169f4e17b5b4..ed009d085a53 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
> @@ -33,6 +33,9 @@ enum rx_pkt_type {
> =20
>  #define MT_RXD1_NORMAL_BSSID		GENMASK(31, 26)
>  #define MT_RXD1_NORMAL_PAYLOAD_FORMAT	GENMASK(25, 24)
> +#define MT_RXD1_FIRST_AMSDU_FRAME	GENMASK(1, 0)
> +#define MT_RXD1_MID_AMSDU_FRAME		BIT(1)
> +#define MT_RXD1_LAST_AMSDU_FRAME	BIT(0)
>  #define MT_RXD1_NORMAL_HDR_TRANS	BIT(23)
>  #define MT_RXD1_NORMAL_HDR_OFFSET	BIT(22)
>  #define MT_RXD1_NORMAL_MAC_HDR_LEN	GENMASK(21, 16)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/n=
et/wireless/mediatek/mt76/mt7615/regs.h
> index 6e5db015b32c..4ebffe52cb8e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
> @@ -368,6 +368,7 @@ enum mt7615_reg_base {
> =20
>  #define MT_DMA_DCR0			MT_WF_DMA(0x000)
>  #define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 2)
> +#define MT_DMA_DCR0_DAMSDU_EN		BIT(16)
>  #define MT_DMA_DCR0_RX_VEC_DROP		BIT(17)
> =20
>  #define MT_DMA_RCFR0(_band)		MT_WF_DMA(0x070 + (_band) * 0x40)
> --=20
> 2.18.0
>=20

--w/nz35jDHskm0eYh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYC5aAgAKCRA6cBh0uS2t
rEi0AP9KwnYBVVtq5ZX2waySM5KsKinIFzXVn90VtiTmNU1LSgEA6szTuyw3/yLX
xPVEzg4gyzj/lkHjxyQOvOvJuzS/Qww=
=sRxR
-----END PGP SIGNATURE-----

--w/nz35jDHskm0eYh--


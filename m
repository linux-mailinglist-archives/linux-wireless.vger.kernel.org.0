Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A7A4AE579
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 00:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbiBHXfE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 18:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiBHXfD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 18:35:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 868A8C061576
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 15:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644363301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+I41qsZkl0PaJEbp3TN1sQ8oZRm8zfem4Tt0Ceohbk=;
        b=ZCkGlvT/bz6ruwXWhYNoYsdKXKUiG172H6CRQnUD/FfBi8dBDrcUICN8sNZCMwq+hkewKB
        OKGZtKF2l8M1NS+rjbNCzXbljTK7yHZ+ANK3r9Vo+a+1ESXudwaKs9d4fgYRaZCF8IoL1O
        TznYcoWzLQdX8LZwKrXGJ1d6nWMXeec=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-SrTZWQ-ePg28xtznaoDgJA-1; Tue, 08 Feb 2022 18:34:58 -0500
X-MC-Unique: SrTZWQ-ePg28xtznaoDgJA-1
Received: by mail-qv1-f72.google.com with SMTP id l3-20020a0ce503000000b0042c0129c766so390507qvm.20
        for <linux-wireless@vger.kernel.org>; Tue, 08 Feb 2022 15:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a+I41qsZkl0PaJEbp3TN1sQ8oZRm8zfem4Tt0Ceohbk=;
        b=E4CvsRnC1bYFrM1VfImJv38XpxXx+4PQzZ6UjXiBgQwPCv10oe/wv7a5xqHXFplkJj
         xgUojlycC3wfVEomNQXqL5nrktqIhg/b+NetO5nkE29GYwUwO8MsjshoQZpRKwrP2eaF
         eYXMXLPsung7d3S+ppHQLkv3HMFdAdSg8xJeL1/ibaMOfsO4BHE0BBNHsufCVtjOe9gW
         eMDPNup1zIQ64Zo+MS62uWpcpeYn/Qs3NTLfpHSgja+wmsXKbR6mW6d76GaFK3GVQ+ri
         FqbZE0pksrIe5DmAvWLM/leLqTURQYVTH23p5mDGsBXfb+v9m1y/0gMI71pt7wdXy1/W
         1VpA==
X-Gm-Message-State: AOAM53188OPyFe34AQRuN+KfS/edrYPqoE1keEmTJUTpzpHySQJUJRPH
        xdA2dx3p15pXLkITybuTRiPo4uSqg607POjT7aD/wK9w8f0B5IIN9X7VX74Hw8Cs8qyg3HeweK5
        zazQbOMSzOayV1rDcXULCcyXqzrg=
X-Received: by 2002:ac8:5c05:: with SMTP id i5mr4804249qti.203.1644363297872;
        Tue, 08 Feb 2022 15:34:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIQOYL6OThcuTnYuatMPZNhHNRL0gGT8+y/VK/tKt8+dlsJWe3UCkvoCzvN8e/9tsEDRQhzQ==
X-Received: by 2002:ac8:5c05:: with SMTP id i5mr4804226qti.203.1644363297626;
        Tue, 08 Feb 2022 15:34:57 -0800 (PST)
Received: from localhost (net-37-182-17-113.cust.vodafonedsl.it. [37.182.17.113])
        by smtp.gmail.com with ESMTPSA id w5sm7643883qko.34.2022.02.08.15.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:34:57 -0800 (PST)
Date:   Wed, 9 Feb 2022 00:34:53 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Deren Wu <Deren.Wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mt76: mt7921s: fix missing fc type/sub-type for 802.11
 pkts
Message-ID: <YgL+HfN/xaiA40yc@lore-desk>
References: <33dd8e4b7f7f72d191e8eca88b33b32dbf2595d2.1644313224.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P2x5gIiIgqgcIJtH"
Content-Disposition: inline
In-Reply-To: <33dd8e4b7f7f72d191e8eca88b33b32dbf2595d2.1644313224.git.deren.wu@mediatek.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--P2x5gIiIgqgcIJtH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> For non-mmio devices, should set fc values to proper txwi config
>=20
> Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
> Co-developed-by: Leon Yen <Leon.Yen@mediatek.com>
> Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 13 ++++++++++---
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.h |  3 +++
>  2 files changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index d17558349a17..e403f0225b77 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -852,6 +852,7 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, _=
_le32 *txwi,
>  	__le16 fc =3D hdr->frame_control;
>  	u8 fc_type, fc_stype;
>  	u32 val;
> +	bool is_mmio =3D mt76_is_mmio(&dev->mt76);
> =20
>  	if (ieee80211_is_action(fc) &&
>  	    mgmt->u.action.category =3D=3D WLAN_CATEGORY_BACK &&
> @@ -912,9 +913,15 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, =
__le32 *txwi,
>  		txwi[3] |=3D cpu_to_le32(val);
>  	}
> =20
> -	val =3D FIELD_PREP(MT_TXD7_TYPE, fc_type) |
> -	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
> -	txwi[7] |=3D cpu_to_le32(val);
> +	if (is_mmio) {

Nit: we do need is_mmio variable since it is used just here.

Regards,
Lorenzo

> +		val =3D FIELD_PREP(MT_TXD7_TYPE, fc_type) |
> +		      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
> +		txwi[7] |=3D cpu_to_le32(val);
> +	} else {
> +		val =3D FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
> +		      FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
> +		txwi[8] |=3D cpu_to_le32(val);
> +	}
>  }
> =20
>  void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.h
> index 544a1c33126a..12e1cf8abe6e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
> @@ -284,6 +284,9 @@ enum tx_mcu_port_q_idx {
>  #define MT_TXD7_HW_AMSDU		BIT(10)
>  #define MT_TXD7_TX_TIME			GENMASK(9, 0)
> =20
> +#define MT_TXD8_L_TYPE			GENMASK(5, 4)
> +#define MT_TXD8_L_SUB_TYPE		GENMASK(3, 0)
> +
>  #define MT_TX_RATE_STBC			BIT(13)
>  #define MT_TX_RATE_NSS			GENMASK(12, 10)
>  #define MT_TX_RATE_MODE			GENMASK(9, 6)
> --=20
> 2.18.0
>=20

--P2x5gIiIgqgcIJtH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYgL+HAAKCRA6cBh0uS2t
rCpMAQDjdD09xNnp1MIirN/vL82VYSpTLDbLqXqkMq7L/KXZNgEA1bXQFBwVuLPz
0u93drRn7ueCcLOpx4HTmDZGqDbjWAw=
=oeMk
-----END PGP SIGNATURE-----

--P2x5gIiIgqgcIJtH--


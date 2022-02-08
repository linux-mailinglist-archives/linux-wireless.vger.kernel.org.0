Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF864AE57F
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 00:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiBHXgC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 18:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237371AbiBHXgB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 18:36:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC792C061577
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 15:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644363359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4gUWiq+74QlIEUtV8k6AMm5Mexy3uHfwzxBHghknuDU=;
        b=fhe/Ya0tUCjBUAj1kZoFKxg+UKrYZcmImR7d9D2OmJRFw8dDhTYg77fVsgBTqiEq6sY/B0
        WV27O9rengJBGhmqgl9JcnJfQ6j2FBtvXhn/4cp6jmvbyUbNTaOOjRzD8pTeI/oC8MSeGu
        WlE/FPHRwZjlMshfjrGhJx2y1cIpq+Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-hi5JV4uIPqyfMx5GZ26yFQ-1; Tue, 08 Feb 2022 18:35:56 -0500
X-MC-Unique: hi5JV4uIPqyfMx5GZ26yFQ-1
Received: by mail-qv1-f69.google.com with SMTP id gg10-20020a056214252a00b0041eeb1c2684so390266qvb.21
        for <linux-wireless@vger.kernel.org>; Tue, 08 Feb 2022 15:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4gUWiq+74QlIEUtV8k6AMm5Mexy3uHfwzxBHghknuDU=;
        b=k6VqFlhyrhX1v/HSqaPmu8g2Cwu/7p420uKXAcqQOEDFfAlmdv5N1K7iWo500cLEps
         sy9tmuzW2AeiGisMO2IDmwTJHNR4aTTb18eekttalXcIcyN2U0X/mblvlbWo/KRx82mR
         /RU+fQFQ6GjgRF26zEMJJNK8A5Qd35r6f7VXqK8hjsDMa7jjlLuMsRHtHm4UFivI0D3a
         KIBmQPA8BuhQxmEjLYfOm0G0ySdUJ/tfgupIyWgrzWlg8Fm/PAnBHeC9hUB57b7WR9nl
         wTI8S68fWyT4lT69/IJ6KyAQu0smzlhm3HF2MfKTCFMqmZV/ud2gnGoSN56xXiY2MN/q
         DhdA==
X-Gm-Message-State: AOAM533qEg6gGgtfWZxZAtmXqSzKPBZy336nAHgZ/tqudJjiq+ezXzIQ
        UPU+eXcPgSL5UJsNRuWsBELABa3NomCDhoyMBX1lKtXcZ0zhNskPPPSZHESe5e++pdVIJjheID8
        dmUkNQNIi4cZR26r7wTyG6aqcjIA=
X-Received: by 2002:ad4:5cae:: with SMTP id q14mr4879606qvh.126.1644363355988;
        Tue, 08 Feb 2022 15:35:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymTkuKZ9jsxgG+GM5tzqj9PrsVW8WIR5EMx5S8AEODNHEcrSqfncfbdu5p2sySdZo+Qrf/lQ==
X-Received: by 2002:ad4:5cae:: with SMTP id q14mr4879592qvh.126.1644363355806;
        Tue, 08 Feb 2022 15:35:55 -0800 (PST)
Received: from localhost (net-37-182-17-113.cust.vodafonedsl.it. [37.182.17.113])
        by smtp.gmail.com with ESMTPSA id u63sm7555887qkh.43.2022.02.08.15.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:35:55 -0800 (PST)
Date:   Wed, 9 Feb 2022 00:35:52 +0100
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
Message-ID: <YgL+WITtN7um1Rlt@lore-desk>
References: <33dd8e4b7f7f72d191e8eca88b33b32dbf2595d2.1644313224.git.deren.wu@mediatek.com>
 <YgL+HfN/xaiA40yc@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FsvhqALiCu0TIavk"
Content-Disposition: inline
In-Reply-To: <YgL+HfN/xaiA40yc@lore-desk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--FsvhqALiCu0TIavk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >=20
> > For non-mmio devices, should set fc values to proper txwi config
> >=20
> > Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
> > Co-developed-by: Leon Yen <Leon.Yen@mediatek.com>
> > Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
> > Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 13 ++++++++++---
> >  drivers/net/wireless/mediatek/mt76/mt7921/mac.h |  3 +++
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/mac.c
> > index d17558349a17..e403f0225b77 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> > @@ -852,6 +852,7 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev,=
 __le32 *txwi,
> >  	__le16 fc =3D hdr->frame_control;
> >  	u8 fc_type, fc_stype;
> >  	u32 val;
> > +	bool is_mmio =3D mt76_is_mmio(&dev->mt76);
> > =20
> >  	if (ieee80211_is_action(fc) &&
> >  	    mgmt->u.action.category =3D=3D WLAN_CATEGORY_BACK &&
> > @@ -912,9 +913,15 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev=
, __le32 *txwi,
> >  		txwi[3] |=3D cpu_to_le32(val);
> >  	}
> > =20
> > -	val =3D FIELD_PREP(MT_TXD7_TYPE, fc_type) |
> > -	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
> > -	txwi[7] |=3D cpu_to_le32(val);
> > +	if (is_mmio) {
>=20
> Nit: we do need is_mmio variable since it is used just here.

s/do need/do not need/

>=20
> Regards,
> Lorenzo
>=20
> > +		val =3D FIELD_PREP(MT_TXD7_TYPE, fc_type) |
> > +		      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
> > +		txwi[7] |=3D cpu_to_le32(val);
> > +	} else {
> > +		val =3D FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
> > +		      FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
> > +		txwi[8] |=3D cpu_to_le32(val);
> > +	}
> >  }
> > =20
> >  void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/=
net/wireless/mediatek/mt76/mt7921/mac.h
> > index 544a1c33126a..12e1cf8abe6e 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
> > @@ -284,6 +284,9 @@ enum tx_mcu_port_q_idx {
> >  #define MT_TXD7_HW_AMSDU		BIT(10)
> >  #define MT_TXD7_TX_TIME			GENMASK(9, 0)
> > =20
> > +#define MT_TXD8_L_TYPE			GENMASK(5, 4)
> > +#define MT_TXD8_L_SUB_TYPE		GENMASK(3, 0)
> > +
> >  #define MT_TX_RATE_STBC			BIT(13)
> >  #define MT_TX_RATE_NSS			GENMASK(12, 10)
> >  #define MT_TX_RATE_MODE			GENMASK(9, 6)
> > --=20
> > 2.18.0
> >=20



--FsvhqALiCu0TIavk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYgL+WAAKCRA6cBh0uS2t
rJd1AQCPuX2XQPFZEKJ9O+QfqtnV7HMWbS3JtgXJCN9E4HTMGQEAlxJO/0yDjJu3
cNFZLPa4lTc5Ii9D7zo9QnsZHgeHogA=
=5SV3
-----END PGP SIGNATURE-----

--FsvhqALiCu0TIavk--


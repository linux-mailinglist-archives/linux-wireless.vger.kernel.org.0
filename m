Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0676B1247EA
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 14:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfLRNSC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 08:18:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37105 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726710AbfLRNSC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 08:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576675081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YsrldomAXlYRR38bWf+2pQGOxv1jAZh1RtUg9JFRjyk=;
        b=Nsr1kk9ulsEVFnfRqQVLfwiXXHLFgiJj3vzXdOUiBz1LgFxL+lk0h7RXjAHU3Wgpjsi+Uq
        Lujl7L9Fsc0Edp9RCtamiS9iTH6/Jp4xnr6L1n1UVVSOJeNvOMC9m8UI+Sk1gYSsgzyCFq
        Ud/Ao43+XY9lrFIjn0PCOVzFXCZCGec=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-O-TqQSQmO-mOfCga8JwPNA-1; Wed, 18 Dec 2019 08:17:57 -0500
X-MC-Unique: O-TqQSQmO-mOfCga8JwPNA-1
Received: by mail-wr1-f70.google.com with SMTP id b13so848936wrx.22
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2019 05:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YsrldomAXlYRR38bWf+2pQGOxv1jAZh1RtUg9JFRjyk=;
        b=GewHZf4Q/lNd3p3W6sEAmNAEH/L+6zicxH0tcElayjWmzSFgxHnLhrACY/+473oWTK
         hRjfJt8hRAganI2xiX/c5p2F3MvC3I65YYKYmayhBfgwy2psCgpiNNU3X3UoPsjyWdDh
         TtUEDRoYdWFcfnG78c4I718Vv0shCNYbWwsWcOKp/PUGDTKbPl03jJuhsVQKEfaYrX3C
         GziOXNF+swYiQacDw7ZKAOQGsu/5zsTkTm9eybOntFWk+lmaS7zd0S26xS3eHjMa6xFH
         cqeqAxk5CQsmSMSymZsl8D17xpoR7ivOINBk0lmQZJthXyd+2JTJOcDIa8oEwyzkUgKC
         HeHQ==
X-Gm-Message-State: APjAAAXDE2SL5GlMv9YPcFhLifHdRIz3oWlLEuG903RPWkNQJIsvdVjZ
        +zRWMyR3ExPef1E33hPu9iyok1YeuYwqrmGlqFs3o6/7cAs93unispcqs5Vk514or1FFTF/Yn34
        DoNJ9y9wOgCG+Xj9MkwlhQjcV9iU=
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr3290848wma.34.1576675076707;
        Wed, 18 Dec 2019 05:17:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJe74eF9nCRnUZ6M7TzSAnpcvo/dbHDzvYPlZBuR1dYSl0YHB/xB//MiAgQR083KPH/FurXw==
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr3290823wma.34.1576675076411;
        Wed, 18 Dec 2019 05:17:56 -0800 (PST)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id x6sm2402756wmi.44.2019.12.18.05.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:17:55 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:17:53 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH v9 4/6] mt76: mt76x02: remove a copy call for usb speedup
Message-ID: <20191218131753.GB13035@localhost.localdomain>
References: <20191126214704.27297-1-markus.theil@tu-ilmenau.de>
 <20191126214704.27297-5-markus.theil@tu-ilmenau.de>
 <20191217094019.GA2567@localhost.localdomain>
 <ed93b477-dc15-8af4-eadc-9ecc5c4509ec@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <ed93b477-dc15-8af4-eadc-9ecc5c4509ec@tu-ilmenau.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 12/17/19 10:40 AM, Lorenzo Bianconi wrote:
> >> This patch removes a mt76_wr_copy call from the beacon path to hw.
> >> The skb which is used in this place gets therefore build with txwi
> >> inside its data. For mt76 usb drivers, this saves one synchronuous
> >> copy call over usb, which lets the beacon work complete faster.
> >>
> >> In mmio case, there is not enough headroom to put the txwi into the
> >> skb, it is therefore using an additional mt76_wr_copy, which is fast
> >> over mmio. Thanks Stanislaw for pointing this out.
> >>
> >> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> >> ---
> >>  .../wireless/mediatek/mt76/mt76x02_beacon.c   | 20 +++++++++++++++----
> >>  1 file changed, 16 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/dri=
vers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> >> index 1c4bdf88f712..68a4f512319e 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> >> @@ -26,15 +26,27 @@ static int
> >>  mt76x02_write_beacon(struct mt76x02_dev *dev, int offset, struct sk_b=
uff *skb)
> >>  {
> >>  	int beacon_len =3D dev->beacon_ops->slot_size;
> >> -	struct mt76x02_txwi txwi;
> >> =20
> >>  	if (WARN_ON_ONCE(beacon_len < skb->len + sizeof(struct mt76x02_txwi)=
))
> >>  		return -ENOSPC;
> >> =20
> >> -	mt76x02_mac_write_txwi(dev, &txwi, skb, NULL, NULL, skb->len);
> >> +	/* USB devices already reserve enough skb headroom for txwi's. This
> >> +	 * helps to save slow copies over USB.
> >> +	 */
> >> +	if (mt76_is_usb(&dev->mt76)) {
> >> +		struct mt76x02_txwi *txwi;
> >> +
> >> +		mt76_insert_hdr_pad(skb);
> > Do we really need mt76_insert_hdr_pad? I think beacon header should be =
4B
> > aligned.

mt76_insert_hdr_pad takes into account just 802.11 header length and it is =
24
or 28 for mgmt frames.

Regards,
Lorenzo

> >
> > Regards,
> > Lorenzo
> I can leave it out of course, but I don't=A0 know, if beacons from
> mac80211 are always 4B aligned.
>=20
> Regards,
> Markus
> >> +		txwi =3D (struct mt76x02_txwi *)(skb->data - sizeof(*txwi));
> >> +		mt76x02_mac_write_txwi(dev, txwi, skb, NULL, NULL, skb->len);
> >> +		skb_push(skb, sizeof(*txwi));
> >> +	} else {
> >> +		struct mt76x02_txwi txwi;
> >> =20
> >> -	mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
> >> -	offset +=3D sizeof(txwi);
> >> +		mt76x02_mac_write_txwi(dev, &txwi, skb, NULL, NULL, skb->len);
> >> +		mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
> >> +		offset +=3D sizeof(txwi);
> >> +	}
> >> =20
> >>  	mt76_wr_copy(dev, offset, skb->data, skb->len);
> >>  	return 0;
> >> --=20
> >> 2.24.0
> >>
>=20

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXfom/gAKCRA6cBh0uS2t
rCOJAQDB596aA11sfGZvPBOYzvdRyHEuZr/iWeG09tyrw1oBswD/UlwvdiyMVKk+
XA7CI/tHNPJsY+NaGyhdOEX7/Pz+lQk=
=+6bK
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--


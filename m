Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA81845CE4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfFNMch (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 08:32:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38840 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfFNMch (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 08:32:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so2153753wmj.3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 05:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uYMNsN5/tkP/4EN4gTdLpKb464bJ0qjMAdWBKZ0re9k=;
        b=mVVsQCzJvi20cJuDAfu0lwTzDJ8XQl9f04LkvgXvvmy3SJNCI/RJ0xy0/OAAqncxHF
         p8JB+88RCwplBg4XkaePbRZcDyhfjVxflg0uZJqaLshNV5KCsuxMV06cthoPuVyFJ0GU
         /OVtbBlAEFmVhslJFvb78ET312n3y7vp/GFrMCOAzJGG48g6uFaXBQ7fJulvY1kYc115
         NLr0ZQsBCJcToJLFIgANkYoNm3dl+/ORcmBw3FiAw3LLB2al7zEuxJAQoq2FZ+Ads3ZT
         dwvjJ4UyMbNUYjIOl09qPkCAWiycFUubHXvq2jQc12+TP7h44pfO5bUWgPuAcAc+lq7N
         lZWw==
X-Gm-Message-State: APjAAAViiayu2RSpWzFXNcq3WsfpujSxx9KCwIuT4toVq1LAwwXdcwtE
        5mZ8gNr3b5Lw74nPugdU1GZ3cg==
X-Google-Smtp-Source: APXvYqxj99LhiNwkJSnv0vgJDIBkPrmau0OF1j7tLjXAzIy3RkXrBgsPpqsX96/J6X0KafmAK9r57A==
X-Received: by 2002:a1c:343:: with SMTP id 64mr8313047wmd.116.1560515555290;
        Fri, 14 Jun 2019 05:32:35 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id t6sm4307128wmb.29.2019.06.14.05.32.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 05:32:34 -0700 (PDT)
Date:   Fri, 14 Jun 2019 14:32:32 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        johannes@sipsolutions.net
Subject: Re: [PATCH v3 wireless-drivers 1/3] mt76: usb: fix rx A-MSDU support
Message-ID: <20190614123230.GC2669@localhost.localdomain>
References: <cover.1560461404.git.lorenzo@kernel.org>
 <66fc02e45fb5ce0d6176395b5ac43acbd53b3e66.1560461404.git.lorenzo@kernel.org>
 <20190614072449.GA3395@redhat.com>
 <20190614101115.GA2669@localhost.localdomain>
 <20190614111414.GB17298@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20190614111414.GB17298@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, Jun 14, 2019 at 12:11:17PM +0200, Lorenzo Bianconi wrote:
> > > On Thu, Jun 13, 2019 at 11:43:11PM +0200, Lorenzo Bianconi wrote:
> > > > Commit f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer s=
izes
> > > > for rx") breaks A-MSDU support. When A-MSDU is enable the device can
> > > > receive frames up to q->buf_size but they will be discarded in
> > > > mt76u_process_rx_entry since there is no enough room for
> > > > skb_shared_info. Fix the issue reallocating the skb and copying in =
the
> > > > linear area the first 128B of the received frames and in the frag_l=
ist
> > > > the remaining part.
> > > >=20
> > > > Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer s=
izes for rx")
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
> > > >  drivers/net/wireless/mediatek/mt76/usb.c  | 49 ++++++++++++++++++-=
----
> > > >  2 files changed, 41 insertions(+), 9 deletions(-)
> > > >=20
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/ne=
t/wireless/mediatek/mt76/mt76.h
> > > > index 8ecbf81a906f..889b76deb703 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> > > > @@ -30,6 +30,7 @@
> > > >  #define MT_TX_RING_SIZE     256
> > > >  #define MT_MCU_RING_SIZE    32
> > > >  #define MT_RX_BUF_SIZE      2048
> > > > +#define MT_SKB_HEAD_LEN     128
> > > > =20
> > > >  struct mt76_dev;
> > > >  struct mt76_wcid;
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net=
/wireless/mediatek/mt76/usb.c
> > > > index bbaa1365bbda..12d60d31cb51 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/usb.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> > > > @@ -429,6 +429,45 @@ static int mt76u_get_rx_entry_len(u8 *data, u3=
2 data_len)
> > > >  	return dma_len;
> > > >  }
> > > > =20
> > > > +static struct sk_buff *
> > > > +mt76u_build_rx_skb(u8 *data, int len, int buf_size)
> > > > +{
> > > > +	struct sk_buff *skb;
> > > > +
> > > > +	if (SKB_WITH_OVERHEAD(buf_size) < MT_DMA_HDR_LEN + len) {
> > > > +		struct page *page;
> > > > +		int offset;
> > > > +
> > > > +		/* slow path, not enough space for data and
> > > > +		 * skb_shared_info
> > > > +		 */
> > > > +		skb =3D alloc_skb(MT_SKB_HEAD_LEN, GFP_ATOMIC);
> > > > +		if (!skb)
> > > > +			return NULL;
> > > > +
> > > > +		skb_put_data(skb, data + MT_DMA_HDR_LEN, MT_SKB_HEAD_LEN);
> > >=20
> > > I looked how rx amsdu is processed in mac80211 and it is decomposed a=
nd
> > > copied into newly allocated individual skb's, see ieee80211_amsdu_to_=
8023s()
> > >=20
> > > So copy L3 & L4 headers doesn't do anything good here, actually seems=
 to
> > > be better to have them in frag as __ieee80211_amsdu_copy_frag() do so=
me
> > > magic to avid copy.
> >=20
> > Looking at __ieee80211_amsdu_copy() now I got why other drivers copy hd=
rlen +
> > 8, thx :)
> > In our case reuse_frag is true in __ieee80211_amsdu_copy, so we will en=
d up
>=20
> I don't think reuse_frag is true in our case since skb->head_frag is
> not set when we use alloc_skb().=20

Oh, right. In this case it is probably better to use netdev_alloc_skb().
I will repost using the approach used in mt7601u since for the moment it wi=
ll
not make any difference to copy more data.

Regards,
Lorenzo

>=20
> Stanislaw

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQOT3AAKCRA6cBh0uS2t
rPAfAP9tZlhPVqj5lRlgzTsyRshJPknJi+UG8yqsU/YDdDoaZAD/U2/0vJpQFgKn
WXrymx/RjXJmmMND85DLZ4KDVhyNUww=
=vXYR
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--

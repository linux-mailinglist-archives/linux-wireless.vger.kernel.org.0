Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813ED45A15
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 12:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfFNKLW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 06:11:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33377 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfFNKLW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 06:11:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so1927286wru.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2019 03:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dd+8bqdPFkLJjWCC0g/EBpCO9m/Q7kHy0TAL2uVEsPQ=;
        b=eHrkDy/iQDkd75GRQ89nKoNyl1pYML9j8T/ld6PUnc0RJf35iLp7Vn4TvBzP7JU840
         LqFf+EnOhrvLpTIpFpUkRQfVwml8mgVSpcUURlSCnIZXbqWPQiVzMU2pQF6mGua6xgZn
         k++SNZP4sUa+s7CdeLjvF2J1E2/8NbGN+JySN/ZFGQaUjvushM2ZbOfy2Yo+H8n3zrHR
         DKJjZx6t2EQMzaGVJKifP0NhJmkyWw9w7qoiti0pt7OTDg+DU2Jhw257l9NGyvApDYOZ
         xyRPPdeDgzPkcMV2df88/arnhrgN52qzz//8ZdTVT42lrSVC7X69lKe4Xk4dO2/F1/X7
         tPew==
X-Gm-Message-State: APjAAAV9mJghE3vAvvL8RnBflBhiTPpGysyzyXvbsqQRdj/Fa0qj/j5m
        P7+//Oknbr8nTRgcWnjnk96SYg==
X-Google-Smtp-Source: APXvYqwcbhReD2W1BWoUeYLRVSK7IuMdlVft/iIsRvI/aPmjOxD3EZw7c5w6z458uiapBSSbxu5FSw==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr48958562wrv.347.1560507080406;
        Fri, 14 Jun 2019 03:11:20 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id d3sm5365836wrf.87.2019.06.14.03.11.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 03:11:19 -0700 (PDT)
Date:   Fri, 14 Jun 2019 12:11:17 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name,
        johannes@sipsolutions.net
Subject: Re: [PATCH v3 wireless-drivers 1/3] mt76: usb: fix rx A-MSDU support
Message-ID: <20190614101115.GA2669@localhost.localdomain>
References: <cover.1560461404.git.lorenzo@kernel.org>
 <66fc02e45fb5ce0d6176395b5ac43acbd53b3e66.1560461404.git.lorenzo@kernel.org>
 <20190614072449.GA3395@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20190614072449.GA3395@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jun 13, 2019 at 11:43:11PM +0200, Lorenzo Bianconi wrote:
> > Commit f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes
> > for rx") breaks A-MSDU support. When A-MSDU is enable the device can
> > receive frames up to q->buf_size but they will be discarded in
> > mt76u_process_rx_entry since there is no enough room for
> > skb_shared_info. Fix the issue reallocating the skb and copying in the
> > linear area the first 128B of the received frames and in the frag_list
> > the remaining part.
> >=20
> > Fixes: f8f527b16db5 ("mt76: usb: use EP max packet aligned buffer sizes=
 for rx")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt76.h |  1 +
> >  drivers/net/wireless/mediatek/mt76/usb.c  | 49 ++++++++++++++++++-----
> >  2 files changed, 41 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wi=
reless/mediatek/mt76/mt76.h
> > index 8ecbf81a906f..889b76deb703 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> > @@ -30,6 +30,7 @@
> >  #define MT_TX_RING_SIZE     256
> >  #define MT_MCU_RING_SIZE    32
> >  #define MT_RX_BUF_SIZE      2048
> > +#define MT_SKB_HEAD_LEN     128
> > =20
> >  struct mt76_dev;
> >  struct mt76_wcid;
> > diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wir=
eless/mediatek/mt76/usb.c
> > index bbaa1365bbda..12d60d31cb51 100644
> > --- a/drivers/net/wireless/mediatek/mt76/usb.c
> > +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> > @@ -429,6 +429,45 @@ static int mt76u_get_rx_entry_len(u8 *data, u32 da=
ta_len)
> >  	return dma_len;
> >  }
> > =20
> > +static struct sk_buff *
> > +mt76u_build_rx_skb(u8 *data, int len, int buf_size)
> > +{
> > +	struct sk_buff *skb;
> > +
> > +	if (SKB_WITH_OVERHEAD(buf_size) < MT_DMA_HDR_LEN + len) {
> > +		struct page *page;
> > +		int offset;
> > +
> > +		/* slow path, not enough space for data and
> > +		 * skb_shared_info
> > +		 */
> > +		skb =3D alloc_skb(MT_SKB_HEAD_LEN, GFP_ATOMIC);
> > +		if (!skb)
> > +			return NULL;
> > +
> > +		skb_put_data(skb, data + MT_DMA_HDR_LEN, MT_SKB_HEAD_LEN);
>=20
> I looked how rx amsdu is processed in mac80211 and it is decomposed and
> copied into newly allocated individual skb's, see ieee80211_amsdu_to_8023=
s()
>=20
> So copy L3 & L4 headers doesn't do anything good here, actually seems to
> be better to have them in frag as __ieee80211_amsdu_copy_frag() do some
> magic to avid copy.

Looking at __ieee80211_amsdu_copy() now I got why other drivers copy hdrlen=
 +
8, thx :)
In our case reuse_frag is true in __ieee80211_amsdu_copy, so we will end up
copying 32B + ether_len. Anyway I think 32 is a little bit too low and we c=
ould get
better performances increasing it a little bit.
A typical use case (e.g IPv6 + TCP):

IPv6 =3D 40B, TCP =3D 32B --> so 72B..I guess 128B is a good value :)
@Felix, Johannes: what do you think?

Regarding the patch I guess let's apply it as it is in order to fix the pen=
ding
issue and then we will figure out how to proceed (copy hdr_len + 3 or incre=
ase
the value in __ieee80211_amsdu_copy)

Regards,
Lorenzo

>=20
> Stanislaw

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQNywQAKCRA6cBh0uS2t
rNzZAPsFH8rrQqIxfBKmdHCQ01bIslM5qv4T19nhY6Xkky0EDQD9HoHe4wLq/zOc
IfzgZmvp9wh+OJrfnK5zZhuM+yna2wo=
=EUQJ
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

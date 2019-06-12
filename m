Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5C242140
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437315AbfFLJp0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 05:45:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39924 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFLJp0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 05:45:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so13496583wrt.6
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2019 02:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4G0qTrNn+C+lfTz9EpnbLNh1Ex6YTIsNzBbOSrulyDQ=;
        b=p8J2vIVv1SXO1Gvm4dhOtlvI3L3qCJvdt2Vr0zs04QRpl+aqC0szu+Dfxo5p6ytExl
         flE7NZh0n4Mrl2JkmsbVVgzJjqb4jm3mC1e36LrFoeS7cRAw/OH8nipDAqtWiAM+JCK6
         qm1KGMKjQ2FaiDdxto5faX0HhZjQ0CUVsEpPhikYnJCZHGo+IpBf97bojCzEl2ouXVsu
         V9JfHRrQRBHUelDpNHUj2icZC9FmNHtb/AgcOHZKT2bC1J8gShr4n2Hkcl/KmHl3iIfU
         FsniUaxPV8AVw1gbrSw+QBWzxl5lX4oh/oyDRBFsBoP1RyNFzUMPxoeW8e9a3uZZoTew
         R9rA==
X-Gm-Message-State: APjAAAVJ1qhZ6Vj2KXm24gQZnqqsrL11+bVfbys3UYJOLOBQZ4PQ2V+C
        jry9Oy0l2QcMggP9xSuPzwFLZQ==
X-Google-Smtp-Source: APXvYqwI9jqu//+9FllAQZzG4XGCqNTcHbbLmvidNozrSmarJSf+Z/4v5ev7nn0+WFuFwsMUvujSzg==
X-Received: by 2002:adf:df91:: with SMTP id z17mr47803825wrl.336.1560332724495;
        Wed, 12 Jun 2019 02:45:24 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id s7sm1782755wmc.2.2019.06.12.02.45.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 02:45:23 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:45:21 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mt76: usb: fix rx A-MSDU support
Message-ID: <20190612094519.GC8107@localhost.localdomain>
References: <cover.1559293385.git.lorenzo@kernel.org>
 <52ea155d9889aa15df44b4910806b74fa2fd9056.1559293385.git.lorenzo@kernel.org>
 <20190612085844.GA2965@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20190612085844.GA2965@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi and sorry for late comment.
>=20

Hi Stanislaw,

> On Fri, May 31, 2019 at 11:38:22AM +0200, Lorenzo Bianconi wrote:
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
> >  drivers/net/wireless/mediatek/mt76/usb.c  | 52 +++++++++++++++++++----
> >  2 files changed, 44 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wi=
reless/mediatek/mt76/mt76.h
> > index 97a1296562d0..74d4edf941d6 100644
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
> > index bbaa1365bbda..2bfc8214c0d8 100644
> > --- a/drivers/net/wireless/mediatek/mt76/usb.c
> > +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> > @@ -429,6 +429,48 @@ static int mt76u_get_rx_entry_len(u8 *data, u32 da=
ta_len)
> >  	return dma_len;
> >  }
> > =20
> > +static struct sk_buff *
> > +mt76u_build_rx_skb(u8 *data, int len, int buf_size,
> > +		   int *nsgs)
> > +{
> > +	int data_len =3D min(len, MT_SKB_HEAD_LEN);
> > +	struct sk_buff *skb;
> > +
> > +	if (SKB_WITH_OVERHEAD(buf_size) >=3D MT_DMA_HDR_LEN + len) {
> > +		/* fast path */
> > +		skb =3D build_skb(data, buf_size);
> > +		if (!skb)
> > +			return NULL;
> > +
> > +		skb_reserve(skb, MT_DMA_HDR_LEN);
> > +		__skb_put(skb, len);
> > +
> > +		return skb;
> > +	}
> > +
> > +	/* slow path, not enough space for data and
> > +	 * skb_shared_info
> > +	 */
> > +	skb =3D alloc_skb(data_len, GFP_ATOMIC);
> > +	if (!skb)
> > +		return NULL;
> > +
> > +	skb_put_data(skb, data + MT_DMA_HDR_LEN, data_len);
> mt7601u and iwlmvm just copy hdrlen + 8 and put the rest
> of the buffer in fragment, which supose to be more efficient,
> see comment in iwl_mvm_pass_packet_to_mac80211().

Right here we copy 128B instead of 32 but I think it is good to have L3 and=
 L4
header in the linear area of the skb since otherwise the stack will need to
align them

> =20
> > +	data +=3D (data_len + MT_DMA_HDR_LEN);
> > +	len -=3D data_len;
> > +	if (len > 0) {
> > +		struct page *page =3D virt_to_head_page(data);
> > +		int offset =3D data - (u8 *)page_address(page);
> u8 cast not needed.
>=20
> > +		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> > +				page, offset, len, buf_size);
> > +	} else {
> > +		*nsgs =3D 0;
> This seems to be not necessary or a bug (use first buffer 2 times).=20

maybe I have been a little bit too paranoid here :)

Regards,
Lorenzo

>=20
> Stanislaw

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQDJrQAKCRA6cBh0uS2t
rB4KAQCr59RUB5bYyhhEooz+eF/YYbmqykMLt2omDXqOWBATLwEAgbc1fNJak68D
MSgjyfEBwifUVRLQmpAXOk59GDtE5QY=
=1PGn
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--

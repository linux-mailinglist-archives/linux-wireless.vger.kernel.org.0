Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54626542E0
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 15:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiLVO02 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 09:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiLVO01 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 09:26:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69773101CB
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 06:26:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC49761BA9
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 14:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1103C433D2;
        Thu, 22 Dec 2022 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671719185;
        bh=6Rx5qtPbPsw64zlpiFnEQiqYr3mhLpmASHHL4uB97Y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhp2KtbMmvkhSndtg96PC010gJOyGegwAoIm5RdvFEDjvuxFDu+zYSxpwUgClwx04
         mHiSmtG5sCU48UML8e8Dpl+47aex6Fa3IOL710o7KNOLBc+rvq9H2I5RsF3J9w9pWy
         T/Mb5Iaa5s1QgZkI3O8E74qXxzyB5jm3Ri5yIo0J29lwkV28eCQ5UsmQo3nHGU8hpZ
         cVErbTfZtE9HJIzZQGxMsBPOH/HtOblgs0Anf160VhTTgEuWVzd2LGkb6lCzD/+WCC
         damidIk6R24eduxZOGQotHFDBVqij9m1AQouzapMUJmbdx96UlnrUvZUy/Cly3yBp7
         c+iHF38UGSVHQ==
Date:   Thu, 22 Dec 2022 15:26:21 +0100
From:   "lorenzo@kernel.org" <lorenzo@kernel.org>
To:     Sujuan Chen =?utf-8?B?KOmZiOe0oOWonyk=?= 
        <Sujuan.Chen@mediatek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Shayne Chen =?utf-8?B?KOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        Bo Jiao =?utf-8?B?KOeEpuazoik=?= <Bo.Jiao@mediatek.com>,
        Evelyn Tsai =?utf-8?B?KOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: fix potential memory leakage
Message-ID: <Y6RpDbebkzXltTZj@lore-desk>
References: <3940cc5ccb4b17d51b5176e722daef0d1af66d6a.camel@mediatek.com>
 <B2689D6F-E04E-4E9B-9244-4E5069DC464D@nbd.name>
 <Y6NKHY7euhifm0kI@lore-desk>
 <6de89564e1deb0b641b2a5039b23909f4647425e.camel@mediatek.com>
 <Y6QnFkJCWPsRgSQD@lore-desk>
 <5162a6ab00c3d90e4401e8753f4a79d9232640eb.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ku8RCL0uEh38JqAd"
Content-Disposition: inline
In-Reply-To: <5162a6ab00c3d90e4401e8753f4a79d9232640eb.camel@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Ku8RCL0uEh38JqAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 2022-12-22 at 10:44 +0100, lorenzo@kernel.org wrote:
> > > On Wed, 2022-12-21 at 19:02 +0100, Lorenzo Bianconi wrote:
> > > > On Dec 21, Felix Fietkau wrote:
> > > > > Hi Sujuan,
> > > > >=20
> > > > > > Yes, it is so expensive, but if no memcopy, it will casue
> > > > > > memory
> > > > > > fragmentation (we hit this issue in internal SQC).
> > > > > >=20
> > > > > > as we know, wed needs to exchange rx pkt(belongs to wed rx
> > > > > > buffer
> > > > > > manager) with wifi driver(dma rx data queue) by exchanging
> > > > > > wfdma
> > > > > > dmad
> > > > > > to ensure the free wed rx buffer.
> > > > > >=20
> > > > > > it is possiable that a large number of buffer has been
> > > > > > exchanged
> > > > > > to wed
> > > > > > and can not come back to wlan driver. So, the memory from the
> > > > > > same 32K
> > > > > > page cache is unable to be released, and it will be failed at
> > > > > > page_frag_alloc in mt76_dma_rx_fill.
> > > > > >=20
> > > > > > Any ideas but memcopy?
> > > > >=20
> > > > > A simple solution would be to simply allocate single pages, or
> > > > > half-page fragments.
> > > > >=20
> > > > > - Felix
> > > > >=20
> > > >=20
> > > > A simple approach would be allocating a single page for each rx
> > > > buffer.
> > > >=20
> > > > @Sujuan: can you please double check if it is ok from performance
> > > > and
> > > > memory
> > > > 	 fragmentation point of view? If not I guess we can try to
> > > > optimize it
> > > > 	 and allocate multiple buffers in the same page tweeking page
> > > > refcount.
> > > >=20
> > > > (this patch must be applied on top of Felix's dma fix).
> > > >=20
> > >=20
> > > Allocating single page for each rx buffer avoids memory
> > > fragmentation,
> > > but it always uses 4K for one rx pkt which only needs 2K, right?
> >=20
> > correct, we can optimize it allocating multiple buffers (in this case
> > 2,
> > assuming 4K pages) in a single page and recycling the page.
> >=20
> > >=20
> > > I guess performance would be worse without page cache.
> >=20
> > I think it is a trade-off
> >=20
> > > We have tested on the mtk private driver, 7% drop in throughput
> > > when
> > > setting the 4K page cache compared to the 32K page cache.
> > > and 10% drop when use slab to allocate buffer.
> >=20
> > IIUC you tested with PAGE_FRAG_CACHE_MAX_SIZE set to 4K (or with a
> > private
> > page_frag_alloc() implementation) and you avoided memory allocation
> > failures due to fragmentation but you got ~ 7% drop in throughput,
> > correct?
> > I think this is quite expected since we need to refill ~ 8 times more
> > the
> > page cache.
> >=20
> > Not considering memory fragmentation, have you measured the impact of
> > the
> > memcpy of a full buffer?
> >=20
>=20
> well, for pure sw path, it maybe ~300M drop (not sure) when using
> memcpy(5G/HE80/4*4).
> but we do memcpy only when wed on, atfer a few unbinding pkts, then all
> flows are offloaded by hw. it is also a trade-off~

I guess we have quite a big impact if we enable wed and we do not actually
offload any flow (or we do not enable hw flowtable in netfilter), dont' we?

Regards,
Lorenzo

>=20
> Regards,
> Sujuan
>=20
> > >=20
> > > A single page per rx buffer may cause a throughput drop of over 7%
> > > and
> > > waste memory, what do you think?
> >=20
> > Implementing the page recycles as it is done in page_frag_alloc() we
> > should get
> > the same results you got with PAGE_FRAG_CACHE_MAX_SIZE set to 4K.
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > Regards,
> > > Sujuan
> > >=20
> > > > Regards,
> > > > Lorenzo
> > > >=20
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/dma.c
> > > > b/drivers/net/wireless/mediatek/mt76/dma.c
> > > > index 28a7fe064313..1d9e580977fc 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/dma.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> > > > @@ -580,6 +580,20 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev,
> > > > struct mt76_queue *q,
> > > >  	return ret;
> > > >  }
> > > > =20
> > > > +static void *
> > > > +mt76_dma_get_rx_buf(struct mt76_queue *q)
> > > > +{
> > > > +	if ((q->flags & MT_QFLAG_WED) &&
> > > > +	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) =3D=3D MT76_WED_Q_RX) {
> > > > +		/* WED RX queue */
> > > > +		struct page *page =3D dev_alloc_page();
> > > > +
> > > > +		return page ? page_address(page) : NULL;
> > > > +	}
> > > > +
> > > > +	return page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
> > > > +}
> > > > +
> > > >  static int
> > > >  mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
> > > >  {
> > > > @@ -596,7 +610,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct
> > > > mt76_queue *q)
> > > >  		struct mt76_queue_buf qbuf;
> > > >  		void *buf =3D NULL;
> > > > =20
> > > > -		buf =3D page_frag_alloc(&q->rx_page, q->buf_size,
> > > > GFP_ATOMIC);
> > > > +		buf =3D mt76_dma_get_rx_buf(q);
> > > >  		if (!buf)
> > > >  			break;
> > > > =20
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> > > > b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> > > > index 1a2e4df8d1b5..2924e71e4fbe 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> > > > @@ -594,13 +594,9 @@ static void
> > > > mt7915_mmio_wed_offload_disable(struct mtk_wed_device *wed)
> > > >  static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device
> > > > *wed)
> > > >  {
> > > >  	struct mt7915_dev *dev;
> > > > -	u32 length;
> > > >  	int i;
> > > > =20
> > > >  	dev =3D container_of(wed, struct mt7915_dev, mt76.mmio.wed);
> > > > -	length =3D SKB_DATA_ALIGN(NET_SKB_PAD + wed->wlan.rx_size +
> > > > -				sizeof(struct skb_shared_info));
> > > > -
> > > >  	for (i =3D 0; i < dev->mt76.rx_token_size; i++) {
> > > >  		struct mt76_txwi_cache *t;
> > > > =20
> > > > @@ -610,7 +606,7 @@ static void
> > > > mt7915_mmio_wed_release_rx_buf(struct
> > > > mtk_wed_device *wed)
> > > > =20
> > > >  		dma_unmap_single(dev->mt76.dma_dev, t->dma_addr,
> > > >  				 wed->wlan.rx_size, DMA_FROM_DEVICE);
> > > > -		__free_pages(virt_to_page(t->ptr), get_order(length));
> > > > +		free_page(virt_to_page(t->ptr));
> > > >  		t->ptr =3D NULL;
> > > > =20
> > > >  		mt76_put_rxwi(&dev->mt76, t);
> > > > @@ -621,13 +617,9 @@ static u32
> > > > mt7915_mmio_wed_init_rx_buf(struct
> > > > mtk_wed_device *wed, int size)
> > > >  {
> > > >  	struct mtk_rxbm_desc *desc =3D wed->rx_buf_ring.desc;
> > > >  	struct mt7915_dev *dev;
> > > > -	u32 length;
> > > >  	int i;
> > > > =20
> > > >  	dev =3D container_of(wed, struct mt7915_dev, mt76.mmio.wed);
> > > > -	length =3D SKB_DATA_ALIGN(NET_SKB_PAD + wed->wlan.rx_size +
> > > > -				sizeof(struct skb_shared_info));
> > > > -
> > > >  	for (i =3D 0; i < size; i++) {
> > > >  		struct mt76_txwi_cache *t =3D mt76_get_rxwi(&dev->mt76);
> > > >  		dma_addr_t phy_addr;
> > > > @@ -635,7 +627,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct
> > > > mtk_wed_device *wed, int size)
> > > >  		int token;
> > > >  		void *ptr;
> > > > =20
> > > > -		page =3D __dev_alloc_pages(GFP_KERNEL,
> > > > get_order(length));
> > > > +		page =3D __dev_alloc_page(GFP_KERNEL);
> > > >  		if (!page)
> > > >  			goto unmap;
> > > > =20
> > > > @@ -644,7 +636,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct
> > > > mtk_wed_device *wed, int size)
> > > >  					  wed->wlan.rx_size,
> > > >  					  DMA_TO_DEVICE);
> > > >  		if (unlikely(dma_mapping_error(dev->mt76.dev,
> > > > phy_addr))) {
> > > > -			__free_pages(page, get_order(length));
> > > > +			free_page(page);
> > > >  			goto unmap;
> > > >  		}
> > > > =20
> > > > @@ -653,7 +645,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct
> > > > mtk_wed_device *wed, int size)
> > > >  		if (token < 0) {
> > > >  			dma_unmap_single(dev->mt76.dma_dev, phy_addr,
> > > >  					 wed->wlan.rx_size,
> > > > DMA_TO_DEVICE);
> > > > -			__free_pages(page, get_order(length));
> > > > +			free_page(page);
> > > >  			goto unmap;
> > > >  		}
> > > > =20

--Ku8RCL0uEh38JqAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY6RpDQAKCRA6cBh0uS2t
rD7xAQDxo4rjmWXP+aL4SzZP6eL9ODe1xySGqeuArFMx2rnfGAD+LJ2506lPvWBH
K6IYSPjH9l0XJnDxVBjPnzbKfFwFmgU=
=kHxV
-----END PGP SIGNATURE-----

--Ku8RCL0uEh38JqAd--

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C806535C8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 19:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiLUSCR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 13:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiLUSCN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 13:02:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8660F5F4E
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 10:02:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BAA3B81BEC
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 18:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926F9C433F0;
        Wed, 21 Dec 2022 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671645728;
        bh=81wb8Tm4c9sknjs/oWLDbzB9PjV1Ld1y5kElRHCy6gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAX5fFEZ1SfndL0gR0oaVd8jcbJGRt4CXoNMqFvaLrd6R8QjOJoU4gA+rLTPaHkf6
         4ZtbRTYIrx+UJIlfZiBEMq4PCACqA4d1ho1aMpWoKDHvJtrNlckzD3tpMxvOZQcUk4
         hIWvMloQewawGHAd7tdjd1gfVL6htiWGac+rnL9M8xfIzFpF1tqk1mgr4wmlT50CnE
         I/b1m7Dx+1y8LQjqu59BmtjWIYTtnmfEq3fmS5SdmHI38TLTuWo3qMWOZ1ybKkSGoZ
         fmKJqC/Wka0gXEFAAMcy8iyoq9Uf4koB2r6CFl2h08jaKZ4vInD6NSBqDNjW0cLT4F
         SfxT1HQo7/oCA==
Date:   Wed, 21 Dec 2022 19:02:05 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Sujuan Chen <sujuan.chen@mediatek.com>,
        linux-wireless@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] wifi: mt76: fix potential memory leakage
Message-ID: <Y6NKHY7euhifm0kI@lore-desk>
References: <3940cc5ccb4b17d51b5176e722daef0d1af66d6a.camel@mediatek.com>
 <B2689D6F-E04E-4E9B-9244-4E5069DC464D@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5oF2i/7lQUbEiyQz"
Content-Disposition: inline
In-Reply-To: <B2689D6F-E04E-4E9B-9244-4E5069DC464D@nbd.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--5oF2i/7lQUbEiyQz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 21, Felix Fietkau wrote:
> Hi Sujuan,
>=20
> > Yes, it is so expensive, but if no memcopy, it will casue memory
> > fragmentation (we hit this issue in internal SQC).
> >=20
> > as we know, wed needs to exchange rx pkt(belongs to wed rx buffer
> > manager) with wifi driver(dma rx data queue) by exchanging wfdma dmad
> > to ensure the free wed rx buffer.
> >=20
> > it is possiable that a large number of buffer has been exchanged to wed
> > and can not come back to wlan driver. So, the memory from the same 32K
> > page cache is unable to be released, and it will be failed at
> > page_frag_alloc in mt76_dma_rx_fill.
> >=20
> > Any ideas but memcopy?
> A simple solution would be to simply allocate single pages, or half-page =
fragments.
>=20
> - Felix
>=20

A simple approach would be allocating a single page for each rx buffer.

@Sujuan: can you please double check if it is ok from performance and memory
	 fragmentation point of view? If not I guess we can try to optimize it
	 and allocate multiple buffers in the same page tweeking page refcount.

(this patch must be applied on top of Felix's dma fix).

Regards,
Lorenzo

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireles=
s/mediatek/mt76/dma.c
index 28a7fe064313..1d9e580977fc 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -580,6 +580,20 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt7=
6_queue *q,
 	return ret;
 }
=20
+static void *
+mt76_dma_get_rx_buf(struct mt76_queue *q)
+{
+	if ((q->flags & MT_QFLAG_WED) &&
+	    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) =3D=3D MT76_WED_Q_RX) {
+		/* WED RX queue */
+		struct page *page =3D dev_alloc_page();
+
+		return page ? page_address(page) : NULL;
+	}
+
+	return page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
+}
+
 static int
 mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 {
@@ -596,7 +610,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queu=
e *q)
 		struct mt76_queue_buf qbuf;
 		void *buf =3D NULL;
=20
-		buf =3D page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
+		buf =3D mt76_dma_get_rx_buf(q);
 		if (!buf)
 			break;
=20
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net=
/wireless/mediatek/mt76/mt7915/mmio.c
index 1a2e4df8d1b5..2924e71e4fbe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -594,13 +594,9 @@ static void mt7915_mmio_wed_offload_disable(struct mtk=
_wed_device *wed)
 static void mt7915_mmio_wed_release_rx_buf(struct mtk_wed_device *wed)
 {
 	struct mt7915_dev *dev;
-	u32 length;
 	int i;
=20
 	dev =3D container_of(wed, struct mt7915_dev, mt76.mmio.wed);
-	length =3D SKB_DATA_ALIGN(NET_SKB_PAD + wed->wlan.rx_size +
-				sizeof(struct skb_shared_info));
-
 	for (i =3D 0; i < dev->mt76.rx_token_size; i++) {
 		struct mt76_txwi_cache *t;
=20
@@ -610,7 +606,7 @@ static void mt7915_mmio_wed_release_rx_buf(struct mtk_w=
ed_device *wed)
=20
 		dma_unmap_single(dev->mt76.dma_dev, t->dma_addr,
 				 wed->wlan.rx_size, DMA_FROM_DEVICE);
-		__free_pages(virt_to_page(t->ptr), get_order(length));
+		free_page(virt_to_page(t->ptr));
 		t->ptr =3D NULL;
=20
 		mt76_put_rxwi(&dev->mt76, t);
@@ -621,13 +617,9 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_=
device *wed, int size)
 {
 	struct mtk_rxbm_desc *desc =3D wed->rx_buf_ring.desc;
 	struct mt7915_dev *dev;
-	u32 length;
 	int i;
=20
 	dev =3D container_of(wed, struct mt7915_dev, mt76.mmio.wed);
-	length =3D SKB_DATA_ALIGN(NET_SKB_PAD + wed->wlan.rx_size +
-				sizeof(struct skb_shared_info));
-
 	for (i =3D 0; i < size; i++) {
 		struct mt76_txwi_cache *t =3D mt76_get_rxwi(&dev->mt76);
 		dma_addr_t phy_addr;
@@ -635,7 +627,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_d=
evice *wed, int size)
 		int token;
 		void *ptr;
=20
-		page =3D __dev_alloc_pages(GFP_KERNEL, get_order(length));
+		page =3D __dev_alloc_page(GFP_KERNEL);
 		if (!page)
 			goto unmap;
=20
@@ -644,7 +636,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_d=
evice *wed, int size)
 					  wed->wlan.rx_size,
 					  DMA_TO_DEVICE);
 		if (unlikely(dma_mapping_error(dev->mt76.dev, phy_addr))) {
-			__free_pages(page, get_order(length));
+			free_page(page);
 			goto unmap;
 		}
=20
@@ -653,7 +645,7 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_wed_d=
evice *wed, int size)
 		if (token < 0) {
 			dma_unmap_single(dev->mt76.dma_dev, phy_addr,
 					 wed->wlan.rx_size, DMA_TO_DEVICE);
-			__free_pages(page, get_order(length));
+			free_page(page);
 			goto unmap;
 		}
=20
--=20
2.38.1


--5oF2i/7lQUbEiyQz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY6NKHQAKCRA6cBh0uS2t
rKh7AP4mbPhGTTG7ixhoWsfwXtMKByRy1JrdUuTSmvp1/vtw6wD8Cmg9K6muauHk
v9kB2Fg8cFXRLMpUs1gsNewe/nBClA4=
=nVh0
-----END PGP SIGNATURE-----

--5oF2i/7lQUbEiyQz--

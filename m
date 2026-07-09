Return-Path: <linux-wireless+bounces-38813-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N64AEUlbT2pifAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38813-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 10:26:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670F72E411
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 10:26:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HIJq9V7B;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38813-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38813-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D35BE3020549
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 08:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882544315F;
	Thu,  9 Jul 2026 08:19:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65333B4EA1
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 08:19:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585170; cv=none; b=WpdGy6pGZPu6N5VDSVYdDr4rVavrZB3DpGaAiyd/892I0BXBGU2Losc6oc0DtKQqhY2+GZOsQNIN4KcXAkJVZjtkLa8O2R9P63LxRhnQFs2uAfAr7ZwQfvgFGgEVKsw6SD93bx7pvzYaW5XULBgVf/colQiRhNS+ONIMZqdk+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585170; c=relaxed/simple;
	bh=Nb3X8XXyedLFQuHttQ/1HNsb2UtcxCchriKUmJuv35Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG/+B5a3uThqMpBrzIL1sO9cRJXGYOE06mVIr9vd+kv28UDQS6uC2HKBigt+Rs2i/8VvyOHYiyNNCBq1B2x2UAbsCELzt/YpAhpmsgpmLEwHqo9CXGN5AbGArZig+l0kwIq30WD2MyxN2YyFa8A+sgxfZID8PY7HolRSSPotVbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIJq9V7B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE341F00A3A;
	Thu,  9 Jul 2026 08:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783585168;
	bh=ZxDmTe0sj+JIlkFBQZfmMlzPCqsUQtZirHhOjh2bpf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HIJq9V7BnK21MVgAkwO+zX9MLH4tp9avGFdxxEtFw5qY8w7ubrRLiAyb3uG4jH3e2
	 nUQP32Dn36p5BK8poRCU1V/lBdpCGplg0xwn6wjLebZJaTYhf4InerOc+FaqVqSHgI
	 //azNbL/3EOkGO6StZQfUQ285yKYZO4W4yUc5nx2gnP2nJnyPnM9EOGlp3EjHskthi
	 HoKUIRX7lqmIfmVA8afwFI89YQ1rs6qRWrGdO5ODxAcWIzNgU7d/ttvIvF2JyRDUhq
	 AEZSU5EHhi3gIp+FKoqVjfIQ50oBHnUfdmZik7PDB6iYuiplXjUssjhOrz/aNQzI5+
	 d+X9X0nbqbfGg==
Date: Thu, 9 Jul 2026 10:19:26 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Eason Lai <eason.lai@mediatek.com>
Cc: nbd@nbd.name, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org, Yf.Luo@mediatek.com,
	kun.wu@mediatek.com, deren.wu@mediatek.com, sean.wang@mediatek.com,
	quan.zhou@mediatek.com, ryder.lee@mediatek.com,
	leon.yen@mediatek.com, litien.chang@mediatek.com,
	jb.tsai@mediatek.com
Subject: Re: [PATCH 1/3] wifi: mt76: Separate skb and page_pool_buf pointers
 in mt76_txwi_cache
Message-ID: <ak9Zjm-czxVIjrhX@lore-desk>
References: <20260709075558.1654164-1-eason.lai@mediatek.com>
 <20260709075558.1654164-2-eason.lai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F68GQNVjJ1S6xrZo"
Content-Disposition: inline
In-Reply-To: <20260709075558.1654164-2-eason.lai@mediatek.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:eason.lai@mediatek.com,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Yf.Luo@mediatek.com,m:kun.wu@mediatek.com,m:deren.wu@mediatek.com,m:sean.wang@mediatek.com,m:quan.zhou@mediatek.com,m:ryder.lee@mediatek.com,m:leon.yen@mediatek.com,m:litien.chang@mediatek.com,m:jb.tsai@mediatek.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38813-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mediatek.com:email,lore-desk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2670F72E411

--F68GQNVjJ1S6xrZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Eason Lai <Eason.Lai@mediatek.com>
>=20
> Refactor mt76_txwi_cache structure to use separate skb and page_pool_buf
> fields instead of a union with ptr. This improves type safety and makes
> the code more explicit about which pointer type is being used in
> different contexts.
>=20
> Also add skip_unmap flag to tx_info.buf to handle cases where DMA
> unmapping should be skipped.
>=20
> Signed-off-by: Eason Lai <Eason.Lai@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/dma.c      | 29 ++++++++++++-------
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  4 +--
>  .../net/wireless/mediatek/mt76/mt7996/mac.c   | 10 +++----
>  drivers/net/wireless/mediatek/mt76/tx.c       |  2 +-
>  drivers/net/wireless/mediatek/mt76/wed.c      |  6 ++--
>  5 files changed, 28 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirel=
ess/mediatek/mt76/dma.c
> index f8c2fe5f2f58..2716278788bd 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -43,7 +43,8 @@ mt76_alloc_rxwi(struct mt76_dev *dev)
>  	if (!t)
>  		return NULL;
> =20
> -	t->ptr =3D NULL;
> +	t->skb =3D NULL;
> +	t->page_pool_buf =3D NULL;
>  	return t;
>  }
> =20
> @@ -84,8 +85,11 @@ mt76_get_txwi(struct mt76_dev *dev)
>  {
>  	struct mt76_txwi_cache *t =3D __mt76_get_txwi(dev);
> =20
> -	if (t)
> +	if (t) {
> +		t->skb =3D NULL;
> +		t->page_pool_buf =3D NULL;
>  		return t;
> +	}
> =20
>  	return mt76_alloc_txwi(dev);
>  }
> @@ -147,8 +151,8 @@ mt76_free_pending_rxwi(struct mt76_dev *dev)
> =20
>  	local_bh_disable();
>  	while ((t =3D __mt76_get_rxwi(dev)) !=3D NULL) {
> -		if (t->ptr)
> -			mt76_put_page_pool_buf(t->ptr, false);
> +		if (t->page_pool_buf)
> +			mt76_put_page_pool_buf(t->page_pool_buf, false);
>  		kfree(t);
>  	}
>  	local_bh_enable();
> @@ -475,14 +479,14 @@ mt76_dma_get_rxdmad_c_buf(struct mt76_dev *dev, str=
uct mt76_queue *q,
>  	if (more)
>  		*more =3D !FIELD_GET(RRO_RXDMAD_DATA1_LS_MASK, data1);
> =20
> -	buf =3D t->ptr;
> +	buf =3D t->page_pool_buf;
>  	ind_reason =3D FIELD_GET(RRO_RXDMAD_DATA2_IND_REASON_MASK, data2);
>  	if (ind_reason =3D=3D MT_DMA_WED_IND_REASON_REPEAT ||
>  	    ind_reason =3D=3D MT_DMA_WED_IND_REASON_OLDPKT) {
>  		mt76_put_page_pool_buf(buf, false);
>  		buf =3D ERR_PTR(-EAGAIN);
>  	}
> -	t->ptr =3D NULL;
> +	t->page_pool_buf =3D NULL;
>  	t->dma_addr =3D 0;
> =20
>  	mt76_put_rxwi(dev, t);
> @@ -529,9 +533,9 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_qu=
eue *q, int idx,
>  				SKB_WITH_OVERHEAD(q->buf_size),
>  				page_pool_get_dma_dir(q->page_pool));
> =20
> -		buf =3D t->ptr;
> +		buf =3D t->page_pool_buf;
>  		t->dma_addr =3D 0;
> -		t->ptr =3D NULL;
> +		t->page_pool_buf =3D NULL;
> =20
>  		mt76_put_rxwi(dev, t);
>  		if (drop)
> @@ -694,6 +698,7 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt=
76_queue *q,
>  			goto unmap;
> =20
>  		tx_info.buf[n].addr =3D addr;
> +		tx_info.buf[n].skip_unmap =3D false;
>  		tx_info.buf[n++].len =3D iter->len;
>  	}
>  	tx_info.nbuf =3D n;
> @@ -718,9 +723,11 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct m=
t76_queue *q,
>  				tx_info.info, tx_info.skb, t);
> =20
>  unmap:
> -	for (n--; n > 0; n--)
> -		dma_unmap_single(dev->dma_dev, tx_info.buf[n].addr,
> -				 tx_info.buf[n].len, DMA_TO_DEVICE);
> +	for (n--; n > 0; n--) {
> +		if (!tx_info.buf[n].skip_unmap)
> +			dma_unmap_single(dev->dma_dev, tx_info.buf[n].addr,
> +					 tx_info.buf[n].len, DMA_TO_DEVICE);
> +	}
> =20
>  free:
>  #ifdef CONFIG_NL80211_TESTMODE
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 527bef97e122..927c21536f4e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -445,10 +445,8 @@ struct mt76_txwi_cache {
>  	struct list_head list;
>  	dma_addr_t dma_addr;
> =20
> -	union {
>  		struct sk_buff *skb;
> -		void *ptr;
> -	};
> +	void *page_pool_buf;

if you do not rename the pointer here, the patch would be much less intrusi=
ve.

Regards,
Lorenzo

> =20
>  	u8 qid;
>  	u8 phy_idx;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index e2a83da3a09c..924b0dc0ff1e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -1775,12 +1775,12 @@ static void mt7996_rx_token_put(struct mt7996_dev=
 *dev)
>  		struct mt76_txwi_cache *t;
> =20
>  		t =3D mt76_rx_token_release(&dev->mt76, i);
> -		if (!t || !t->ptr)
> +		if (!t || !t->page_pool_buf)
>  			continue;
> =20
> -		mt76_put_page_pool_buf(t->ptr, false);
> +		mt76_put_page_pool_buf(t->page_pool_buf, false);
>  		t->dma_addr =3D 0;
> -		t->ptr =3D NULL;
> +		t->page_pool_buf =3D NULL;
> =20
>  		mt76_put_rxwi(&dev->mt76, t);
>  	}
> @@ -1928,14 +1928,14 @@ void mt7996_rro_rx_process(struct mt76_dev *mdev,=
 void *data)
>  				goto next_page;
> =20
>  			qid =3D t->qid;
> -			buf =3D t->ptr;
> +			buf =3D t->page_pool_buf;
>  			q =3D &mdev->q_rx[qid];
>  			dma_sync_single_for_cpu(mdev->dma_dev, t->dma_addr,
>  						SKB_WITH_OVERHEAD(q->buf_size),
>  						page_pool_get_dma_dir(q->page_pool));
> =20
>  			t->dma_addr =3D 0;
> -			t->ptr =3D NULL;
> +			t->page_pool_buf =3D NULL;
>  			mt76_put_rxwi(mdev, t);
>  			if (!buf)
>  				goto next_page;
> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wirele=
ss/mediatek/mt76/tx.c
> index 22f9690634c9..665156a7ea65 100644
> --- a/drivers/net/wireless/mediatek/mt76/tx.c
> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> @@ -899,7 +899,7 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void =
*ptr,
>  	token =3D idr_alloc(&dev->rx_token, t, 0, dev->rx_token_size,
>  			  GFP_ATOMIC);
>  	if (token >=3D 0) {
> -		t->ptr =3D ptr;
> +		t->page_pool_buf =3D ptr;
>  		t->dma_addr =3D phys;
>  	}
>  	spin_unlock_bh(&dev->rx_token_lock);
> diff --git a/drivers/net/wireless/mediatek/mt76/wed.c b/drivers/net/wirel=
ess/mediatek/mt76/wed.c
> index ed657d952de2..e1cf81d722b8 100644
> --- a/drivers/net/wireless/mediatek/mt76/wed.c
> +++ b/drivers/net/wireless/mediatek/mt76/wed.c
> @@ -15,11 +15,11 @@ void mt76_wed_release_rx_buf(struct mtk_wed_device *w=
ed)
>  		struct mt76_txwi_cache *t;
> =20
>  		t =3D mt76_rx_token_release(dev, i);
> -		if (!t || !t->ptr)
> +		if (!t || !t->page_pool_buf)
>  			continue;
> =20
> -		mt76_put_page_pool_buf(t->ptr, false);
> -		t->ptr =3D NULL;
> +		mt76_put_page_pool_buf(t->page_pool_buf, false);
> +		t->page_pool_buf =3D NULL;
> =20
>  		mt76_put_rxwi(dev, t);
>  	}
> --=20
> 2.45.2
>=20

--F68GQNVjJ1S6xrZo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCak9ZjgAKCRA6cBh0uS2t
rA/nAQD/fVPT9UqPvUKf8fMd0wox/0BGNj2sq8OEfIb1UTE28QD7BnTiNsxjz1As
CJtPdLwjdRIS6/v5zcVQnm2nOqVqKA4=
=7j30
-----END PGP SIGNATURE-----

--F68GQNVjJ1S6xrZo--


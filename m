Return-Path: <linux-wireless+bounces-37799-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZKlGKFOdL2o8DQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37799-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 08:36:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D64A683DE7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 08:36:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eyClCGXO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37799-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37799-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AEC33003812
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 06:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B42BE639;
	Mon, 15 Jun 2026 06:36:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E812FF144
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 06:35:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505360; cv=none; b=CsMz0C5vyy02F3Jx3xxxlHdnpKJN+aGxb4xaeqaH5W0ohyvaCqTZlcvDT7awxetCr/EVi3eReAADNp81MEOktVmIwNVDuP8danM7COs5gClm5rUnpK47ej2wl3ld6twrAVMGRfOSKq8A0hov9IrT4tcama7osC4OPbLt8+6XhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505360; c=relaxed/simple;
	bh=MSnSTqvB769VmYJteIyk/5s1C4h7nI4IIaBwr3enmBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG9Fd1Ats16PVtQ42ULEuUAl2G3LsL71GGbvbS8Z2MYUw5+PDBucTQ3MYn8VQnxCVprjGsGu8osGoAcolfWcenQeyi6pLxbwPNeD7Nqb3ZNDzWC7emtUv3MpFLHPLoVZetCuiSFB0pcBrwle3ATqWuTXM0raS+rLL90PuuJ/aXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyClCGXO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499AA1F000E9;
	Mon, 15 Jun 2026 06:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781505359;
	bh=HhL9nmQvXU1aByFhbMPlJuNGIORTEGdF12RyDzmFaJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eyClCGXO8ML6BZyvM2iRMPGwLxqV+WMoBnqDgvz+3sjBWSsXm8iU9bNRPvzK48908
	 fzm9uY6p1NBTAvmCsahbcnNshI1augW3kGJJ5Xpb/JIkj2qtH0tGZZT8YFsK2Qy4q3
	 DbGUwdPdpNafUq730d6uFnRfVlMmzcNtlqQkHuTfEKrJKwGtibX6+woFtS3ivIWNUJ
	 DgzVjayxNEcH0t1C8kGf1ghU3iS8Y3xOcVh3pEqH284x7nFE7ZAlcU9SnRMSuyGzId
	 VlFlDM3t9//a20hMygqK79klk2SJ8sBJvdTSqqwe13Qb+pLa7NRRNVT2ohLDdIt6jy
	 8zV60l3g8YUTg==
Date: Mon, 15 Jun 2026 08:35:54 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 2/5] wifi: mt76: usb: support out-of-order RX URB
 completion
Message-ID: <ai-dSgeYkT64NDob@lore-rh-laptop>
References: <20260613224655.2405686-1-sean.wang@kernel.org>
 <20260613224655.2405686-3-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fd1lP9OuahfIifWz"
Content-Disposition: inline
In-Reply-To: <20260613224655.2405686-3-sean.wang@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@kernel.org,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37799-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lore-rh-laptop:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D64A683DE7


--Fd1lP9OuahfIifWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Keep per-URB RX queue context and complete entries by their real queue
> position instead of assuming the completed URB is always at q->head.
>=20
> USB RX URBs can complete out of order, and advancing q->head too early
> can corrupt RX queue accounting and process buffers in the wrong order.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h |  5 ++
>  drivers/net/wireless/mediatek/mt76/usb.c  | 77 ++++++++++++++++-------
>  2 files changed, 61 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 122e77a5f2f4..81740aa7df71 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -655,6 +655,11 @@ struct mt76_mcu {
>  	wait_queue_head_t wait;
>  };
> =20
> +struct mt76u_rx_entry {
> +	struct mt76_queue_entry *e;
> +	struct mt76_queue *q;
> +};
> +
>  #define MT_TX_SG_MAX_SIZE	8
>  #define MT_RX_SG_MAX_SIZE	4
>  #define MT_NUM_TX_ENTRIES	256
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wirel=
ess/mediatek/mt76/usb.c
> index ce68e1d0c786..cab36630c978 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -397,11 +397,25 @@ mt76u_urb_alloc(struct mt76_dev *dev, struct mt76_q=
ueue_entry *e,
>  	return 0;
>  }
> =20
> +static void mt76u_urb_free(struct urb *urb)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < urb->num_sgs; i++)
> +		mt76_put_page_pool_buf(sg_virt(&urb->sg[i]), false);
> +
> +	if (urb->transfer_buffer)
> +		mt76_put_page_pool_buf(urb->transfer_buffer, false);
> +
> +	usb_free_urb(urb);
> +}
> +
>  static int
>  mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt76_queue *q,
>  		   struct mt76_queue_entry *e)
>  {
>  	enum mt76_rxq_id qid =3D q - &dev->q_rx[MT_RXQ_MAIN];
> +	struct mt76u_rx_entry *rxe;
>  	int err, sg_size;
> =20
>  	sg_size =3D qid =3D=3D MT_RXQ_MAIN ? MT_RX_SG_MAX_SIZE : 0;
> @@ -409,20 +423,25 @@ mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt7=
6_queue *q,
>  	if (err)
>  		return err;
> =20
> -	return mt76u_refill_rx(dev, q, e->urb, sg_size);
> -}
> -
> -static void mt76u_urb_free(struct urb *urb)
> -{
> -	int i;
> +	rxe =3D kzalloc_obj(*rxe, GFP_KERNEL);

I guess you can move it at the beginning of mt76u_rx_urb_alloc(), right?

> +	if (!rxe) {
> +		usb_free_urb(e->urb);

IIRC, if mt76u_rx_urb_alloc() fails, mt76u_free_rx_queue() will run so we do
not need to run usb_free_urb() manually here, right?

> +		e->urb =3D NULL;
> +		return -ENOMEM;
> +	}
> =20
> -	for (i =3D 0; i < urb->num_sgs; i++)
> -		mt76_put_page_pool_buf(sg_virt(&urb->sg[i]), false);
> +	rxe->e =3D e;
> +	rxe->q =3D q;
> +	e->urb->context =3D rxe;
> =20
> -	if (urb->transfer_buffer)
> -		mt76_put_page_pool_buf(urb->transfer_buffer, false);
> +	err =3D mt76u_refill_rx(dev, q, e->urb, sg_size);
> +	if (err) {
> +		kfree(rxe);
> +		mt76u_urb_free(e->urb);
> +		e->urb =3D NULL;
> +	}
> =20
> -	usb_free_urb(urb);
> +	return err;
>  }
> =20
>  static void
> @@ -566,8 +585,12 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct =
urb *urb,
>  static void mt76u_complete_rx(struct urb *urb)
>  {
>  	struct mt76_dev *dev =3D dev_get_drvdata(&urb->dev->dev);
> -	struct mt76_queue *q =3D urb->context;
> +	struct mt76u_rx_entry *rxe =3D urb->context;
> +	struct mt76_queue_entry *e =3D rxe->e;
> +	unsigned int idx, pending, pos;
> +	struct mt76_queue *q =3D rxe->q;
>  	unsigned long flags;
> +	bool wake =3D false;
> =20
>  	trace_rx_urb(dev, urb);
> =20
> @@ -586,18 +609,28 @@ static void mt76u_complete_rx(struct urb *urb)
>  	}
> =20
>  	spin_lock_irqsave(&q->lock, flags);
> -	if (WARN_ONCE(q->entry[q->head].urb !=3D urb, "rx urb mismatch"))
> +	idx =3D e - q->entry;
> +	pending =3D q->ndesc - q->queued;
> +	pos =3D (idx + q->ndesc - q->head) % q->ndesc;
> +	if (WARN_ONCE(idx >=3D q->ndesc || pos >=3D pending, "rx urb mismatch"))

can idx be >=3D of q->ndesc?

>  		goto out;
> =20
> -	q->head =3D (q->head + 1) % q->ndesc;
> -	q->queued++;
> -
> -	if (q =3D=3D &dev->q_rx[MT_RXQ_MAIN])
> -		napi_schedule(&dev->napi[MT_RXQ_MAIN]);
> -	else
> -		mt76_worker_schedule(&dev->usb.rx_worker);
> +	e->done =3D true;
> +	while (q->entry[q->head].done) {
> +		q->entry[q->head].done =3D false;
> +		q->head =3D (q->head + 1) % q->ndesc;
> +		q->queued++;
> +		wake =3D true;

This seems a fix to me since theoretically we could have the same issue in
the current codebase, right?

Regards,
Lorenzo

> +	}
>  out:
>  	spin_unlock_irqrestore(&q->lock, flags);
> +
> +	if (wake) {
> +		if (q =3D=3D &dev->q_rx[MT_RXQ_MAIN])
> +			napi_schedule(&dev->napi[MT_RXQ_MAIN]);
> +		else
> +			mt76_worker_schedule(&dev->usb.rx_worker);
> +	}
>  }
> =20
>  static int
> @@ -607,7 +640,7 @@ mt76u_submit_rx_buf(struct mt76_dev *dev, enum mt76_r=
xq_id qid,
>  	int ep =3D qid =3D=3D MT_RXQ_MAIN ? MT_EP_IN_PKT_RX : MT_EP_IN_CMD_RESP;
> =20
>  	mt76u_fill_bulk_urb(dev, USB_DIR_IN, ep, urb,
> -			    mt76u_complete_rx, &dev->q_rx[qid]);
> +			    mt76u_complete_rx, urb->context);
>  	trace_submit_urb(dev, urb);
> =20
>  	return usb_submit_urb(urb, GFP_ATOMIC);
> @@ -678,6 +711,7 @@ mt76u_submit_rx_buffers(struct mt76_dev *dev, enum mt=
76_rxq_id qid)
> =20
>  	spin_lock_irqsave(&q->lock, flags);
>  	for (i =3D 0; i < q->ndesc; i++) {
> +		q->entry[i].done =3D false;
>  		err =3D mt76u_submit_rx_buf(dev, qid, q->entry[i].urb);
>  		if (err < 0)
>  			break;
> @@ -733,6 +767,7 @@ mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76=
_queue *q)
>  		if (!q->entry[i].urb)
>  			continue;
> =20
> +		kfree(q->entry[i].urb->context);
>  		mt76u_urb_free(q->entry[i].urb);
>  		q->entry[i].urb =3D NULL;
>  	}
> --=20
> 2.43.0
>=20

--Fd1lP9OuahfIifWz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCai+dRwAKCRA6cBh0uS2t
rDcBAP4sMx7VIlH48U3ZB0uNBRm7tKsxUOlwBFPEKmvcPwS3tQEA/iwFt5imZTX1
x3cWEuHiav/vn6fxJ0aQLvf7zpfgVAA=
=oOKo
-----END PGP SIGNATURE-----

--Fd1lP9OuahfIifWz--


Return-Path: <linux-wireless+bounces-28601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB6C35443
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 11:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D75A4F137A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605226ED3F;
	Wed,  5 Nov 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP7QuCam"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618032E8B8A
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340262; cv=none; b=sp4EHsO8NN2CifGoT2NppVazY/Khk+lHiFGoUIehYn5KURqOXLI5aPz85Js17AkHprnz9f/3sZFe4NinQlQ/GOCnqt62AfSoRfbBY/SwaOOECT3oq/Sp9JvrXJXq4jQmfVszNnYrF1RYsJqsheLE9+clvh3y+W8byWlloS4P2zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340262; c=relaxed/simple;
	bh=3I8GbCHt5nTmU/JAMrsYsToDtzFmmsTntkvfOBdvXZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVJrPIwcWsuKrBffKAEGMGnaj/0E8m4bAK0tDMrVs2VnD4L3goe6EYuWo2cxW3ENk3wtdJaW8lfmrMWHtrYAhv1JbvVM5IPFeYYBeuSjjCzM0IOY6EcvaeqiZGZ2jj7cgYwxtIcAZpVqG5M5xj50sqW7znHidNd7YK8Cu3LNC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP7QuCam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E36AC4CEF8;
	Wed,  5 Nov 2025 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762340261;
	bh=3I8GbCHt5nTmU/JAMrsYsToDtzFmmsTntkvfOBdvXZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VP7QuCamQd/tRJxLVttNOyNtOVZ8NvC2zDj9rhj1GkzET5vT4/hWC1/BbDLPr8WmU
	 Qrt92K5Jarf2QwW23HEPNQFJ9jlxKsCguyumeqZF48q2wRpgIILuRYbyRhvi7hrMBZ
	 jTbfTHg1/IuY2fwdgjJrRR1Csw11ZexAMypLrDZLhQappW9gwYEv1mWNk3X5aVXkmo
	 2scjSbAqCe55130pTdTLdIn0pAjq27gfBJ5PZ+6BmgF+RMFCdqWuKHmCPWs3s8a7iL
	 RP+hDzW/DdhznqWIvRfNwrZJNJ3zW4UXzzIdi7+AhZReq10uo4tpYPDKHGnUAQZ8G9
	 PPsTh9zV4J5gA==
Date: Wed, 5 Nov 2025 11:57:39 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	Rex Lu <rex.lu@mediatek.com>
Subject: Re: [PATCH mt76 12/12] wifi: mt76: mt7996: fix EMI rings for RRO
Message-ID: <aQstowRMsLD-6A-z@lore-desk>
References: <20251105093100.541408-1-shayne.chen@mediatek.com>
 <20251105093100.541408-12-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DwZumMumnql1tOgs"
Content-Disposition: inline
In-Reply-To: <20251105093100.541408-12-shayne.chen@mediatek.com>


--DwZumMumnql1tOgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 05, Shayne Chen wrote:
> The RRO EMI rings only need to be allocated when WED is not active.
> This patch fixes command timeout issue for the setting of WED off and
> RRO on.
>=20
> Fixes: 3a29164425e9 ("wifi: mt76: mt7996: Add SW path for HW-RRO v3.1")
> Co-developed-by: Rex Lu <rex.lu@mediatek.com>
> Signed-off-by: Rex Lu <rex.lu@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  .../net/wireless/mediatek/mt76/mt7996/dma.c   | 15 +++++++++------
>  .../net/wireless/mediatek/mt76/mt7996/init.c  | 19 ++++++++++++++++---
>  2 files changed, 25 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/dma.c
> index 7ac4defca29d..274b273df1ee 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
> @@ -515,12 +515,15 @@ int mt7996_dma_rro_init(struct mt7996_dev *dev)
>  		if (ret)
>  			return ret;
> =20
> -		/* We need to set cpu idx pointer before resetting the EMI
> -		 * queues.
> -		 */
> -		mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].emi_cpu_idx =3D
> -			&dev->wed_rro.emi_rings_cpu.ptr->ring[0].idx;
> -		mt76_queue_reset(dev, &mdev->q_rx[MT_RXQ_RRO_RXDMAD_C], true);
> +		if (!mtk_wed_device_active(&mdev->mmio.wed)) {
> +			/* We need to set cpu idx pointer before resetting the
> +			 * EMI queues.
> +			 */
> +			mdev->q_rx[MT_RXQ_RRO_RXDMAD_C].emi_cpu_idx =3D
> +				&dev->wed_rro.emi_rings_cpu.ptr->ring[0].idx;
> +			mt76_queue_reset(dev, &mdev->q_rx[MT_RXQ_RRO_RXDMAD_C],
> +					 true);
> +		}
>  		goto start_hw_rro;
>  	}
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/init.c
> index bd7b720c64c5..00a8286bd136 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
> @@ -960,9 +960,10 @@ static int mt7996_wed_rro_init(struct mt7996_dev *de=
v)
>  		       MT7996_RRO_MSDU_PG_SIZE_PER_CR);
>  	}
> =20
> -	if (dev->mt76.hwrro_mode =3D=3D MT76_HWRRO_V3_1) {
> +	if (!mtk_wed_device_active(&dev->mt76.mmio.wed) &&
> +	    dev->mt76.hwrro_mode =3D=3D MT76_HWRRO_V3_1) {
>  		ptr =3D dmam_alloc_coherent(dev->mt76.dma_dev,
> -					  sizeof(dev->wed_rro.emi_rings_cpu.ptr),
> +					  sizeof(*dev->wed_rro.emi_rings_cpu.ptr),
>  					  &dev->wed_rro.emi_rings_cpu.phy_addr,
>  					  GFP_KERNEL);
>  		if (!ptr)
> @@ -971,7 +972,7 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
>  		dev->wed_rro.emi_rings_cpu.ptr =3D ptr;
> =20
>  		ptr =3D dmam_alloc_coherent(dev->mt76.dma_dev,
> -					  sizeof(dev->wed_rro.emi_rings_dma.ptr),
> +					  sizeof(*dev->wed_rro.emi_rings_dma.ptr),
>  					  &dev->wed_rro.emi_rings_dma.phy_addr,
>  					  GFP_KERNEL);
>  		if (!ptr)
> @@ -1037,6 +1038,18 @@ static void mt7996_wed_rro_free(struct mt7996_dev =
*dev)
>  				   dev->wed_rro.msdu_pg[i].phy_addr);
>  	}
> =20
> +	if (dev->wed_rro.emi_rings_cpu.ptr)
> +		dmam_free_coherent(dev->mt76.dma_dev,
> +				   sizeof(*dev->wed_rro.emi_rings_cpu.ptr),
> +				   dev->wed_rro.emi_rings_cpu.ptr,
> +				   dev->wed_rro.emi_rings_cpu.phy_addr);
> +
> +	if (dev->wed_rro.emi_rings_dma.ptr)
> +		dmam_free_coherent(dev->mt76.dma_dev,
> +				   sizeof(*dev->wed_rro.emi_rings_dma.ptr),
> +				   dev->wed_rro.emi_rings_dma.ptr,
> +				   dev->wed_rro.emi_rings_dma.phy_addr);
> +
>  	if (!dev->wed_rro.session.ptr)
>  		return;
> =20
> --=20
> 2.51.0
>=20

--DwZumMumnql1tOgs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaQstowAKCRA6cBh0uS2t
rMQnAP9Wh3rDrj6yxrdedGGUlehqj9A1BUSgXjH6lWCmX23F2AEAixqZfaNIXbCa
UCSL3uJgQAO5MzaJyaFCn/tVm92hJgY=
=2gfS
-----END PGP SIGNATURE-----

--DwZumMumnql1tOgs--


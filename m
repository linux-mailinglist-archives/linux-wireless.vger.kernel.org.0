Return-Path: <linux-wireless+bounces-29594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A99F7CAD813
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 15:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1B3730210F1
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C014328275;
	Mon,  8 Dec 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iugpJget"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1022E336F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203516; cv=none; b=aiyhxMkRPw9FmTWTKTrsfkoCZ33W2LjTYnhhl0JjFedfId4ZHivpowADqYavjk8eG2uGktAU4BlNZpDGCowT/PgmOyQMvv+gG1VqMIV6v81F5Fx6iFsEIo1ufGcwcaVRGkvp0kd1ophFJPkQkqhE4D16lNn78vWDFneUmt8mvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203516; c=relaxed/simple;
	bh=SjQTmjRaxoAZEdS9VaHUthT3W5NWzBYP22Q6Yz5xYTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4NI4ZmvEwOZrOQu0GJhOX9XcD6J+I+h9zBccuBwfjAEIVR/xYj6CVbjZGXC7DVuZrrwvcPDZHd8ARx5qYRBThG3o0YiOFa2aFCl8m8qPl0Nq72vfw/FSE5tbkvUZ3Lu5ULUiAVv8GnXdr0j8mTLC7b9g6fvm70BmMqqaEHIeVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iugpJget; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FCCC113D0;
	Mon,  8 Dec 2025 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765203516;
	bh=SjQTmjRaxoAZEdS9VaHUthT3W5NWzBYP22Q6Yz5xYTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iugpJget+ITa0hSKukq/g6oTbAbGtomuNJqpaE9VStyQu/aM2dsgFkFqwoukGrqxL
	 7//6qOSL1aB2OrHcbUgjc5OTk85gEFsNvy+CVjpJlwdfasSxCZpAInaq8udDl1Btmn
	 pRsXpoE9Qn1YoxiynN9BlfOhO9bX85YlpLiUEGEhxDR1F4Jvd+E2WwLJ6J8GVYNCsi
	 Alajq+EwL9OO3UZcgRok7bhAPIAUZngyOzPOu2wahc1+ds/+hhjqXydNa2THRsbMJW
	 VQLyzMrX2Lk4g75BX7oba+Zdo/wEJ9nT6QqnzH1Le/xboKfgUhsWqInJpk0KxA9hto
	 SZAJtYQ9w6hMg==
Date: Mon, 8 Dec 2025 15:18:33 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Chad Monroe <chad@monroe.io>
Cc: Felix Fietkau <nbd@nbd.name>, Johannes Berg <johannes.berg@intel.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Evelyn Tsai <evelyn.tsai@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7996: reset device after MCU message timeout
Message-ID: <aTbeOResfSpMk6hZ@lore-desk>
References: <27bebda195599b55d097f4586a034dddce5d2cc0.1765202889.git.chad@monroe.io>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZgBOj1SGc4qFoWQM"
Content-Disposition: inline
In-Reply-To: <27bebda195599b55d097f4586a034dddce5d2cc0.1765202889.git.chad@monroe.io>


--ZgBOj1SGc4qFoWQM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Trigger a full reset after MCU message timeout.
>=20
> Signed-off-by: Chad Monroe <chad@monroe.io>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 5 +++++
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 9 +++++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index 2560e2f46e89..07b0a694c1bb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -2736,6 +2736,11 @@ void mt7996_reset(struct mt7996_dev *dev)
>  		return;
>  	}
> =20
> +	if ((READ_ONCE(dev->recovery.state) & MT_MCU_CMD_STOP_DMA)) {

nit: you do not need double brackets here.

Regards,
Lorenzo

> +		set_bit(MT76_MCU_RESET, &dev->mphy.state);
> +		wake_up(&dev->mt76.mcu.wait);
> +	}
> +
>  	queue_work(dev->mt76.wq, &dev->reset_work);
>  	wake_up(&dev->reset_wait);
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.c
> index 14a88ef79b6c..40ebda9a3f12 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -209,6 +209,7 @@ static int
>  mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
>  			  struct sk_buff *skb, int seq)
>  {
> +	struct mt7996_dev *dev =3D container_of(mdev, struct mt7996_dev, mt76);
>  	struct mt7996_mcu_rxd *rxd;
>  	struct mt7996_mcu_uni_event *event;
>  	int mcu_cmd =3D FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
> @@ -217,6 +218,14 @@ mt7996_mcu_parse_response(struct mt76_dev *mdev, int=
 cmd,
>  	if (!skb) {
>  		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
>  			cmd, seq);
> +
> +		if (!test_and_set_bit(MT76_MCU_RESET, &dev->mphy.state)) {
> +			dev->recovery.restart =3D true;
> +			wake_up(&dev->mt76.mcu.wait);
> +			queue_work(dev->mt76.wq, &dev->reset_work);
> +			wake_up(&dev->reset_wait);
> +		}
> +
>  		return -ETIMEDOUT;
>  	}
> =20
> --=20
> 2.47.3
>=20
>=20
>=20

--ZgBOj1SGc4qFoWQM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaTbeOQAKCRA6cBh0uS2t
rBRdAQDpgmkK6Zsh1t0kzKkUl6bsh9G75hBe3VMQu7d4a3Og3wD9EPrcYUfL8DOz
xSiHjYwGb+3+Gg59nWWN757fWR6jAg8=
=LKrR
-----END PGP SIGNATURE-----

--ZgBOj1SGc4qFoWQM--


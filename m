Return-Path: <linux-wireless+bounces-20675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA04DA6BEC0
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 16:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DBA7A5A83
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF6216E01;
	Fri, 21 Mar 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/MQddbm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918081F150E;
	Fri, 21 Mar 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572359; cv=none; b=roqsUc7HC9ABxuXxctdq1Y1ObHCUz8Llwoz+YFJN/J5wUk1dbo+A5+3b2we6aH+E/4FvWEXdKNxYBKuCpJXfhpUuPn76/ZStZoLP3pb8XhCbKpdj0yI3XyatavhIxtaEiKQ5fWQLkAoe9Va5rP6kCVbZl2CQKzkPNveOa30dddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572359; c=relaxed/simple;
	bh=aeT+zeWm5jrgZt8DkAFo7mZSthufAM7MHXrkbF6C8sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7BnbxAwRjWEM9zxQw4bMwtd/GPiVU93QAGVpdztAvbiCv+xSDINJMx+v5rGbcwyAx8WuhESBk91YyiD/N5xJ8Lb561OlzeScKJYj2a4SjTddCrmeL0bnAcsp5I0Ve/GV8PObEzdclimNrjpLpaDfG7UHPcwWRyUgJsc884YY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/MQddbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45AEC4CEE3;
	Fri, 21 Mar 2025 15:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742572359;
	bh=aeT+zeWm5jrgZt8DkAFo7mZSthufAM7MHXrkbF6C8sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/MQddbmitNGpDQe4XEcNSY1zRtCllgV3IqfjF4T9B8KJj7J0xtemZkjDS8iVnuex
	 HWn1A6bUWJDVuQLcDtOFSz36KEZ98qOpkwhG283VT6NgKRs3XqPBnHP3p+dRgMOUNi
	 KBOxZJftX4vGpllF73+5ldrSO0sXLZQCzPMxRG0ATXYgnvBW0SVKTIJ1eaJoSbBKQU
	 ICAPo/lVWAYuNNzVgiwqa/ZJ0mI/uJRJPAHWeo17WzIk8vf7MBSdHdBazvfUHTYxNN
	 J+eLbuos/Ap6o5+lYkYbVBUkiZ0s2qKvxkk5w3dZPgn7NTnIChDFH3he9W7afjIBqo
	 Nkp+FkkBX6CKw==
Date: Fri, 21 Mar 2025 16:52:36 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shayne Chen <shayne.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	Howard Hsu <howard-yh.hsu@mediatek.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7996: remove duplicate check in
 mt7996_mcu_sta_mld_setup_tlv()
Message-ID: <Z92LRBMxyz4pS7my@lore-desk>
References: <fde7246b-08a2-4c2f-b2dc-c3fd0e6b300b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Her0ThDAq1KdRV1x"
Content-Disposition: inline
In-Reply-To: <fde7246b-08a2-4c2f-b2dc-c3fd0e6b300b@stanley.mountain>


--Her0ThDAq1KdRV1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The "msta_link" pointer has two NULL checks.  Delete the second check.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mcu.c
> index ddd555942c73..03539e20f5c5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> @@ -2242,9 +2242,6 @@ mt7996_mcu_sta_mld_setup_tlv(struct mt7996_dev *dev=
, struct sk_buff *skb,
>  		if (!link)
>  			continue;
> =20
> -		if (!msta_link)
> -			continue;
> -
>  		mld_setup_link->wcid =3D cpu_to_le16(msta_link->wcid.idx);
>  		mld_setup_link->bss_idx =3D link->mt76.idx;
>  		mld_setup_link++;
> --=20
> 2.47.2
>=20

--Her0ThDAq1KdRV1x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ92LRAAKCRA6cBh0uS2t
rAFkAQC83L5e/zLFrvnAgbWpDtlXGRVM8ylbCJX2fob5kYoqKAEA8J5Y+3FQYsGq
Hs5nRCUHXyiZQ44fs7zXOIdYRSjk1As=
=DzY1
-----END PGP SIGNATURE-----

--Her0ThDAq1KdRV1x--


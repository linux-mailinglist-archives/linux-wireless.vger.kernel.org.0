Return-Path: <linux-wireless+bounces-28870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54CCC5273A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 14:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A525E421DAB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548B0303CB0;
	Wed, 12 Nov 2025 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jmrSyyQg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B503191D7
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953124; cv=none; b=uys8jGLtBQ5rRw753eYP3RVxdnyO6PKxpHZnAyv0SWbi3dvms1zmXxyQa8My8IFCv5serRVxiBSEH2WY6w6UWoOGsVhwpSBVyDxi83VE1gQ4IMXlPg8iaUGd96MiHIKiD0lp9RyBbpg4rer1fR8kXJggrIG99hkXnNzKAm2hDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953124; c=relaxed/simple;
	bh=XFBSIaDKgK1etc+LO4PVpPRx1vgVLuVelHAaQqwehuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKh+sujJ2BUz0VG5u7/lyqXA6b6HPd1B6zsJj3pkXcdqXZ0kQ1AcB1vM8zYRe2CA7qG2wTPr0oYleFkzIVa+H5mGU39WxeXsCkK8sV9WY3Ip+VFIwXzjHaEliSANB2VANwVivl7ENhpcPdGnHuSV23OOVor/kCU/E4R1A3Wvl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jmrSyyQg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=80u5Q8E0TPmRoqalv+o/MQopZxjc4bnoLVsOrhzJHZc=;
	t=1762953122; x=1764162722; b=jmrSyyQgeTldd3OfF5INBmS2DwEZ9lVhK3GRc3DFQnfYLI2
	ALN4QCIcR3gxTZRr7MMdCC4hBF/afPpeP4GAFcBmsJaoJV7QeUtjER5F45dmGH1m0n3iu4F3+vZnJ
	ICr3djKO9Z8cKDFCDlIkbw3j7jeW29jp0kcBC23YAg/dr0Z8mXZwcUZhlHSvxipetEHyPYiCVwjmJ
	AOEmhrYMr/go8b4TqVQ+Abf0l1wTyexndHa0/cAoBDMpzW53q9aWJQx02s88sHXiA1UL4hK86o//D
	YCAuRc2mTWoXpliBrPi1JamXteT9svMoqcQltQMwEk3sYup5FWxlcGXoiluQBmAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vJAdj-00000001SIS-2aMY;
	Wed, 12 Nov 2025 14:11:59 +0100
Message-ID: <8fc455467e9f510e70816df1e676e297defd49b7.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/5] wifi: mac80211: fix CMAC functions not handling
 errors
From: Johannes Berg <johannes@sipsolutions.net>
To: Chien Wong <m@xv97.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 12 Nov 2025 14:11:58 +0100
In-Reply-To: <20251111145759.111691-2-m@xv97.com>
References: <20251111145759.111691-1-m@xv97.com>
	 <20251111145759.111691-2-m@xv97.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-11-11 at 22:57 +0800, Chien Wong wrote:
>=20
> -void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
> -			const u8 *data, size_t data_len, u8 *mic)
> +int ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
> +		       const u8 *data, size_t data_len, u8 *mic)
>  {
> +	int err;
>  	SHASH_DESC_ON_STACK(desc, tfm);
>  	u8 out[AES_BLOCK_SIZE];
>  	const __le16 *fc;
> =20
>  	desc->tfm =3D tfm;
> =20
> -	crypto_shash_init(desc);
> -	crypto_shash_update(desc, aad, AAD_LEN);
> +	err =3D crypto_shash_init(desc);
> +	if (err)
> +		goto out;
> +	err =3D crypto_shash_update(desc, aad, AAD_LEN);
> +	if (err)
> +		goto out;


Not sure all the 'goto', without

> +out:
> +	return err;

anything other than a return is really better than just returning early?
It's not like this code will change soon again and need more error
handling ;-)

johannes


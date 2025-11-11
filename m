Return-Path: <linux-wireless+bounces-28835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB1C4D098
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 11:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7974A169F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5033B97A;
	Tue, 11 Nov 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wejKrlIu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4992338599
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855793; cv=none; b=d9XXHO9+C3sJnnmUNktxMFF/Y6/Mk9zZkxQNwdA3iYgrXWXKTrK1hfoDyg8WOsbPqUF4gkdLEeGKTSwS0Dz8zFyceGzRC68qvB51aJvopFYZfNSHlJo4EPrhxiO8X59933nfwIDq4HR8v0PsLvyrPEzRrGmihMOTTWS2716uLSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855793; c=relaxed/simple;
	bh=vX1cFr3xfjgqLKJpGuHbJl8JOoyQqvyeGMu1k1f8WtQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rI3rupY3ZXhu7xrowRc+E5gcs/KOTh2scNqsRF3PjsHspWXEOJzJPqXtNP7zijGCRM5sLOwjoTSs3NLbyEUuGd+pgj6x0c6oS1oTPv8J3Bv31ERQPN1tY6prAR36XJqWaxii5C/Zz7XRvgcLDj5wqEVKp/kvXKS9xhmjRxKeA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wejKrlIu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cclXwDNCs07QdTsEFzXsl2X8VAkTe9HZ1Y1WomxpE7s=;
	t=1762855791; x=1764065391; b=wejKrlIuaz1M3FLPnrzwF7dQA2vExVFQ9yTBvFUClxuL0Pq
	5yYMsFHFDDlekqW7TEjHCi3O0WSIExNU8N8i+JeeSOqdOYHFmSJlqk626EjlsYeSOOhiMXgeC/goV
	0GtSH7RVQQRM+hHJnS8XdS1/saPt6Tuy7tOwt5sNCZXHIPav2BzI+zXZ4sh0kGK8Xx2U2Yw4PUgFe
	b3GhKpzX9VZut5lr4GsbRFYHxu1V4MGbkO6h6wNK7hudRLiBKxzS3cO4a1C2U+yvYeHf+27g2ekvi
	OUmVl2/3lsQ1ai3NhTc5RKHZO7pXDPjcvCULPyq41hPL+PS0FHsxPOzA2L4APtZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIlJt-0000000FO9c-1r3U;
	Tue, 11 Nov 2025 11:09:49 +0100
Message-ID: <ca0cce1b2d4d3d5c920d4d9d300ab175c6691ab6.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/6] wifi: mac80211: remove an unnecessary copy
From: Johannes Berg <johannes@sipsolutions.net>
To: Chien Wong <m@xv97.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 11 Nov 2025 11:09:48 +0100
In-Reply-To: <20251110144545.15149-2-m@xv97.com>
References: <20251110144545.15149-1-m@xv97.com>
	 <20251110144545.15149-2-m@xv97.com>
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

On Mon, 2025-11-10 at 22:45 +0800, Chien Wong wrote:
> Using a temporary buffer for saving the CMAC result is useless.
> With the patch, ieee80211_aes_cmac() just resembles
> ieee80211_aes_cmac_256().

I guess I could've looked more closely at v1 ...

> +++ b/net/mac80211/aes_cmac.c
> @@ -26,7 +26,6 @@ void ieee80211_aes_cmac(struct crypto_shash *tfm, const=
 u8 *aad,
>  			const u8 *data, size_t data_len, u8 *mic)
>  {
>  	SHASH_DESC_ON_STACK(desc, tfm);
> -	u8 out[AES_BLOCK_SIZE];
>  	const __le16 *fc;
> =20
>  	desc->tfm =3D tfm;
> @@ -41,9 +40,7 @@ void ieee80211_aes_cmac(struct crypto_shash *tfm, const=
 u8 *aad,
>  	} else {
>  		crypto_shash_update(desc, data, data_len - CMAC_TLEN);
>  	}
> -	crypto_shash_finup(desc, zero, CMAC_TLEN, out);
> -
> -	memcpy(mic, out, CMAC_TLEN);
> +	crypto_shash_finup(desc, zero, CMAC_TLEN, mic);

This seems very wrong, it writes 16 bytes when 'mic' will only have
space for CMAC_TLEN=3D=3D8. AFAICT, the CMAC_TLEN in the function call is
the input length (of 'zero'), not the output length.

johannes


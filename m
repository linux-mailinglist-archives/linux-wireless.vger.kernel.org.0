Return-Path: <linux-wireless+bounces-13953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62D099DF8D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 09:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD421F23B59
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5251AC887;
	Tue, 15 Oct 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UPwW5lIj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69D1C7281;
	Tue, 15 Oct 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978360; cv=none; b=ri41/Bj6TPVau/3RjXOcgc+0hfA1sgHyxmMxnaNBavh5a/YVt/+TQf2UBuAKsRBFrYlXHzaoOeGclKxj+3HnkQVb+l0dU4kCZiSnFrw8st9gIzrZvEZCm6Htlf3f8AeOlTD7UhGSHCHEWxt4LXfn8RbLGnR3m2HtgKGcKJq0K/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978360; c=relaxed/simple;
	bh=68o0MAYZDrDBEZE9DvxoPMJRr2QuYTv4b1qFFkh3PE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hq4ANCCgRLdGMb8FveoI5rrDlI/ubUpu/rttmrTv517RmX9qznmvTACDthGWPS3VpcRZt0JJ+gHUCkywjcYQufwEgLPXH4ghmlOwwDb26GMFOeApirZbC1X/XAg3OE1O4Mpj1bisS/YmHgLp7yCTVJBh7dxQTQuXirW57ZcLOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UPwW5lIj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A8lUn75d1mQuFiPjxQ2YMJNzhP4Qt8/UmJebob7x1Og=;
	t=1728978358; x=1730187958; b=UPwW5lIjZrQViDfqVWVQHT3X3XNfywBfrtuWjZiU5wuIvOP
	qrsAPwoT9wJtWqLsXdBPdlQyV4k+CaZlRZFjDOwEfZxwWpe/G0L6avyc8dC4ZyuUIT7ys1H+LOx+x
	eOM8+Y5wyvU6rcWU643o884fI4ov2R9hfhO+R3z+yzjax5S2t3a0ln9iaXf62ecgBJHW7kRDrgIEm
	CW8vnWwbXRQ4g2FPu8SVR2pzuV9q59vRLfwSJ/kktyPnl/WmZ2unVAY+iIIdCXktap/WXswS2oLDN
	se6KNyf0N3v1qdLQrZK24hePoKWPX836fADjGFEl2n3F/Y10eMXaJvXdaBp25t2w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t0cFf-0000000Ba3u-3RTt;
	Tue, 15 Oct 2024 09:45:55 +0200
Message-ID: <a5c6a210cb6b83c7523b0e86b306a7cfa7e573fd.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ipw2x00/lib80211: select ARC4 helper
From: Johannes Berg <johannes@sipsolutions.net>
To: Arnd Bergmann <arnd@kernel.org>, Stanislav Yakovlev
	 <stas.yakovlev@gmail.com>, Kalle Valo <kvalo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 15 Oct 2024 09:45:55 +0200
In-Reply-To: <20241015073216.9443-1-arnd@kernel.org>
References: <20241015073216.9443-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-10-15 at 07:32 +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The lib80211 code uses arc4 crypto helpers that can be
> disabled:
>=20
> ERROR: modpost: "arc4_setkey" [drivers/net/wireless/intel/ipw2x00/libipw.=
ko] undefined!
> ERROR: modpost: "arc4_crypt" [drivers/net/wireless/intel/ipw2x00/libipw.k=
o] undefined!
>=20
> Select the library from Kconfig to ensure this can be called.
>=20
> Fixes: 02f220b52670 ("wifi: ipw2x00/lib80211: move remaining lib80211 int=
o libipw")

Right, sorry. I sent a similar one before:

https://lore.kernel.org/linux-wireless/20241011115820.070c468b271d.Iac76e81=
b5cd9a5b949b8c154381128e8131d581d@changeid/

> +++ b/drivers/net/wireless/intel/ipw2x00/Kconfig
> @@ -6,6 +6,7 @@
>  config IPW2100
>  	tristate "Intel PRO/Wireless 2100 Network Connection"
>  	depends on PCI && CFG80211
> +	select CRYPTO_LIB_ARC4
>=20
I think this got to the wrong place?

johannes


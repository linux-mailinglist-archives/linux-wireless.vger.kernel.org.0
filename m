Return-Path: <linux-wireless+bounces-28871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4509C52731
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 14:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE03B9101
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7881830C364;
	Wed, 12 Nov 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tCWCFAAP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9A30C34A
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953177; cv=none; b=huz7fHSkUXX2rFjexnUArHbR3krEzl/kvf8CVymkn0D6SVKwnwYgCAEdMPT8gPP2epEmv/rvkxaT0mLCRk7z3oKlMy1YSp5Awj1iWzcn8XgT0czk7WcDLZuwWoI9rKX7zuMeZ3NFvd3fwFNhshb2UnWsgWOnnWzud/VKQfX84ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953177; c=relaxed/simple;
	bh=zmB9L1Rn1Gu4kDXrkAmY6yUR2L7r3HDrzjTWsAtJ0Co=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tESYUnK+YThNCutpf5IXPfncOWivDryBKVnGvwbek3k9/IrnYqLu09h8PFrgdSL+dBWkF/Vfbtmqr4ihI9K6hAbLHGcDw2DIInDsAyQ8NKOzH8jlNGfnGBh8zv/plORTyuxzm0uEFoGA8Ds4aYxDpdNZu1CM0LhRNNAj+DpJyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tCWCFAAP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=meeoR9XP+UkCTUv4Gn+s1Zao+xexEbwiCnsTGwFsN3Y=;
	t=1762953176; x=1764162776; b=tCWCFAAPoMfX5PDxn7izNJ/xPpg3OtR6Cb1Q398wParH6+c
	7bc3c6zGTGkbaKtZopKRKEbgYjYx4UMeSszKBRlQcdI7DowZTXTr9kcpC5hbEPA7NRnRbBr06ncFW
	3AUY/+NSML4p+iTNhNlb5a4h/1lYEhNZAPzKVuwKK+XUrjQ3gwG1pEZtIEWqcAWaRmMn9+eQNKk3Y
	KsC50oShEfEosjojPNpuO2r/isnB7RMu1sLpZt0pqLL4P9S/wuBVL/ulCHxd8pnwJ07AXSHaO9AxU
	0rTtWIWBwpkfEGL0YpkZe0YerLVsPVT6fCMya/9uuBQpTatA6glDGTm837EfzIqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vJAeb-00000001SSh-3Qym;
	Wed, 12 Nov 2025 14:12:54 +0100
Message-ID: <0704cd8f81e8cc2bde7957b8134c1bf1fdbaed29.camel@sipsolutions.net>
Subject: Re: [PATCH v3 3/5] wifi: mac80211: utilize the newly defined CMAC
 constants
From: Johannes Berg <johannes@sipsolutions.net>
To: Chien Wong <m@xv97.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 12 Nov 2025 14:12:53 +0100
In-Reply-To: <20251111145759.111691-4-m@xv97.com>
References: <20251111145759.111691-1-m@xv97.com>
	 <20251111145759.111691-4-m@xv97.com>
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
> Make use of the added constants to reduce duplication.
>=20
> Signed-off-by: Chien Wong <m@xv97.com>
> ---
>  net/mac80211/aes_cmac.c | 4 ++--
>  net/mac80211/aes_gmac.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
> index adce68ea0981..01fb8b6c5dfb 100644
> --- a/net/mac80211/aes_cmac.c
> +++ b/net/mac80211/aes_cmac.c
> @@ -16,8 +16,8 @@
>  #include "key.h"
>  #include "aes_cmac.h"
> =20
> -#define CMAC_TLEN 8 /* CMAC TLen =3D 64 bits (8 octets) */
> -#define CMAC_TLEN_256 16 /* CMAC TLen =3D 128 bits (16 octets) */
> +#define CMAC_TLEN IEEE80211_CMAC_128_MIC_LEN
> +#define CMAC_TLEN_256 IEEE80211_CMAC_256_MIC_LEN
>  #define AAD_LEN 20
> =20
>  static const u8 zero[CMAC_TLEN_256];
> diff --git a/net/mac80211/aes_gmac.h b/net/mac80211/aes_gmac.h
> index c739356bae2a..09378e52c7a6 100644
> --- a/net/mac80211/aes_gmac.h
> +++ b/net/mac80211/aes_gmac.h
> @@ -9,7 +9,7 @@
>  #include <linux/crypto.h>
> =20
>  #define GMAC_AAD_LEN	20
> -#define GMAC_MIC_LEN	16
> +#define GMAC_MIC_LEN	IEEE80211_GMAC_MIC_LEN

Might really be better to just switch the code to the new ones?

johannes


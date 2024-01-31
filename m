Return-Path: <linux-wireless+bounces-2885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9FD843EDE
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 12:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41F61F30434
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455E869DFD;
	Wed, 31 Jan 2024 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="l1Ykhj0o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F6878B41
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702030; cv=none; b=JnnwD2IgBzB3PrVrABTyVHIUjXMhHxBGoAlOnaGWNtTgz+eTCmBOvCJTIjslccS6QrFwcfoFWV7MirkyuDZJEkDrQY+Pg+fte2D++scMrmF40DvFGlGipO8/OcBXqYEAczEYpSSMaNaLUmE+XSjU6DMJ/Ojm71AL/DYaNVpnYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702030; c=relaxed/simple;
	bh=AkU8zFhAqppk8iKmwA5JC1TjONPB4HHobccuj1i/AMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/5T4mc+YSKP2lrnqvnwrcRBQC4m+KhqwBxK1kl4tEgLbeIFtYm5J3OA9ZZgL4cVwybKATMfTETju0jOX2ZLlIKAygJusor+pqTqhR9yWuDGZgzxIZDIbGmQbyYRaBJ70nmCbD1IDyPw5C1tlWh3+RB5xOFOaDcRjvN/sHDQv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=l1Ykhj0o; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zfNhjamhHRL6ih1Ytm4d02lUdIlDQjYRi1jklcKXvSg=;
	t=1706702026; x=1707911626; b=l1Ykhj0oe+Ib/A8bnyfDT2ujngRaeczWJ/d/DRPVUVgCqwF
	8YnwdMKJGsQ/cg/cZm5i22uFM4QPOfydbVtJuaCa79HleaBAzEiLtoRWzCpPN9HvBgKKoyw4h94nv
	TvdMA3zivjl/teG2PIYf4sJvWXU/1rAsxejCkzQgmseRnXFO2f0Rrtj1mHDpr9VJrMGuhBqDz6GMN
	ifVcnR87N/rDY3PMjWyWtR1VahN7C4Q2plE1U9fGVcu0cLuhEcbSr/6HGkQHmVq9qqZfMGli9Pkzj
	yc9CdCVadXJiOwPs7oLAeEsD+Z4djc2/nKRkJVoJDubzaWr9yPseRo6ayq5BWNew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rV99z-00000007CeX-1u8n;
	Wed, 31 Jan 2024 12:53:43 +0100
Message-ID: <7c2721f79c1d6c0aa914db4f4d6148c8efce4b85.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211:  Ensure bss-coloring is always configured
From: Johannes Berg <johannes@sipsolutions.net>
To: greearb@candelatech.com, linux-wireless@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 31 Jan 2024 12:53:42 +0100
In-Reply-To: <20240130180848.776867-1-greearb@candelatech.com>
References: <20240130180848.776867-1-greearb@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 10:08 -0800, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
>=20
> Old code would not set it to disabled, just assumed that driver
> would default to disabled.  Change this to explicitly request
> bss color be flushed on initial driver configuration.

Arguably, the current behaviour is in line with the documentation of
BSS_CHANGED_HE_BSS_COLOR ... but I would tend to agree that
enabling/disabling coloring should be covered by it as well. Lorenzo?

> And I think the beacon-change logic was slightly wrong, so adjust
> that as well.

That's not a great thing for a commit message to say ...

> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  net/mac80211/cfg.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 1c7fb0959cfd..1a6c6c764cbc 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1331,8 +1331,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, =
struct net_device *dev,
>  			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
>  		changed |=3D BSS_CHANGED_HE_OBSS_PD;
> =20
> -		if (params->beacon.he_bss_color.enabled)
> -			changed |=3D BSS_CHANGED_HE_BSS_COLOR;
> +		changed |=3D BSS_CHANGED_HE_BSS_COLOR;
>  	}
> =20
>  	if (params->he_cap) {
> @@ -1512,6 +1511,7 @@ static int ieee80211_change_beacon(struct wiphy *wi=
phy, struct net_device *dev,
>  	int err;
>  	struct ieee80211_bss_conf *link_conf;
>  	u64 changed =3D 0;
> +	bool color_en;
> =20
>  	lockdep_assert_wiphy(wiphy);
> =20
> @@ -1549,9 +1549,9 @@ static int ieee80211_change_beacon(struct wiphy *wi=
phy, struct net_device *dev,
>  		return err;
>  	changed |=3D err;
> =20
> -	if (beacon->he_bss_color_valid &&
> -	    beacon->he_bss_color.enabled !=3D link_conf->he_bss_color.enabled) =
{
> -		link_conf->he_bss_color.enabled =3D beacon->he_bss_color.enabled;
> +	color_en =3D beacon->he_bss_color.enabled && beacon->he_bss_color_valid=
;
> +	if (color_en !=3D link_conf->he_bss_color.enabled) {
> +		link_conf->he_bss_color.enabled =3D color_en;
>  		changed |=3D BSS_CHANGED_HE_BSS_COLOR;
>  	}
>=20

Not sure how this isn't updating the color itself, Lorenzo?

johannes


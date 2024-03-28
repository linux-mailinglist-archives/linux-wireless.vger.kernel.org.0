Return-Path: <linux-wireless+bounces-5456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4665B89001D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 14:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B0DB22968
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1463C7EEF0;
	Thu, 28 Mar 2024 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jMefUahZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D1864CE1
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632170; cv=none; b=ZN7LGgZrJYA3c557t1k0ifngs7SYIeoQ3NkZwdrmxl0DF2z8osdjQsMFJRVOxF/NJtnaCFLBBhuEt09Ger2H9g2TxA77DLAjWQXp9I439l0OcK8d+DkFJgLxRPnWEXkRbA0XTvS0eMjL+Sn0Tgv65w4FKVBwtCoNwTbzP0Qv9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632170; c=relaxed/simple;
	bh=QBQiopUtOeTguZk9p12E2FJ8Vm/HB1rh0lsntrw8x6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8C3v3BfFHI5xWeaWNG8g8cBeKueqi8Xv9wzkczlXF6NsijVqOElP1LcXvz9dVmAQ07xbDw20f1SKvuXrkA/r2fKpdN0pvS6ZriAf2F+9gNcPzSVlk6rMhKVzJjeCIya5TYmT5Tca8l6AlGQH/OZAhySuhqcaD/qdEq27DgP3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jMefUahZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hBJJ0NlroRwEUwROKMDVanfjub6GNe9fdXa0RuT5jrE=;
	t=1711632167; x=1712841767; b=jMefUahZs8Q1ptFscYG5ZW2EL3sGlN4zAz44aA9W3uXBjU9
	mMWSjpYnJhmbNZLg02UsY6+wTXdk6hbQj6hugbEhqIl2IMEFn3RcINuJa9smftMulxjPFC3FpqFqn
	adasjAsRf8UQ9zZE1mAKVm8oHH5WC+ITbgRrEo5BH2yXAs0JK7pkTtxzv3E6Ge6zAAALafpAnqMYJ
	L+gVhE7OLyesiPSJO3wla/f1VVxDgBVLIXk+XqGibhBPQHFtqn1wPFY+ahuIMz7cTRgPuGznJmXbl
	VvbCfCHI/qZZ3f3LrFVHuayfLF3bvv36MJj/23YnUDGx4zw0GQwhBgjQiQFS3wBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rppiO-00000000zsp-22tR;
	Thu, 28 Mar 2024 14:22:44 +0100
Message-ID: <8e1d403251a8c8e5c9fe34d9dea51b8ea60b6b6b.camel@sipsolutions.net>
Subject: Re: [PATCH 04/13] wifi: cfg80211/mac80211: extend iface comb
 advertisement for multi-hardware dev
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>
Date: Thu, 28 Mar 2024 14:22:43 +0100
In-Reply-To: <20240328072916.1164195-5-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-5-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Not sure why this is a combined cfg/mac patch, there doesn't seem to be
all that much need for that? I'd probably rather see this and patch 6
squashed, but cfg/mac kept separate.


On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:

>=20
> +static int
> +ieee80211_check_per_hw_iface_comb(struct ieee80211_local *local,
> +				  const struct ieee80211_iface_combination *c)
> +{
> +	int hw_idx, lmt_idx;
> +	u32 hw_idx_bm =3D 0;

lmt_idx? (also that's only needed in the loop)
bm?

> +	if (!local->hw.wiphy->num_hw)
> +		return -EINVAL;
> +
> +	if (local->emulate_chanctx)
> +		return -EINVAL;
> +
> +	for (hw_idx =3D 0; hw_idx < c->n_hw_list; hw_idx++) {
> +		const struct ieee80211_iface_per_hw *hl;

hl?

Could have a bit more evocative names :)

I'd rather see 'i' for some iteration thingie  than "lmt_idx" which
means nothing on first reading either, but you start thinking it should
mean something ...

> +static bool
> +cfg80211_hw_chans_includes_dfs(const struct ieee80211_chans_per_hw *chan=
s)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < chans->n_chans; i++) {
> +		if (chans->chans[i].band =3D=3D NL80211_BAND_5GHZ &&
> +		    ((chans->chans[i].center_freq >=3D 5250 &&
> +		     chans->chans[i].center_freq <=3D 5340) ||
> +		    (chans->chans[i].center_freq >=3D 5480 &&
> +		     chans->chans[i].center_freq <=3D 5720)))

???

That's not how this works upstream.

> +		if (WARN_ON(hl->max_interfaces < 2 &&
> +			    (!comb->radar_detect_widths ||
> +			     !(cfg80211_hw_chans_includes_dfs(chans)))))

No need for extra parentheses.

> @@ -701,6 +786,13 @@ static int wiphy_verify_combinations(struct wiphy *w=
iphy)
>  		/* You can't even choose that many! */
>  		if (WARN_ON(cnt < c->max_interfaces))
>  			return -EINVAL;
> +
> +		/* Do similar validations on the freq range specific interface
> +		 * combinations when advertised.
> +		 */
> +		if (WARN_ON(c->n_hw_list &&
> +			    wiphy_verify_comb_per_hw(wiphy, c)))

Don't need the n_hw_list check here, the function just does nothing if
it's 0 anyway.

johannes


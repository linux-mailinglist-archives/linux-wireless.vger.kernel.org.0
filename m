Return-Path: <linux-wireless+bounces-20425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5FA6437B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 08:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07E13AF3B1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 07:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D7821A45E;
	Mon, 17 Mar 2025 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="M/5BFDYv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2206E21ADD6;
	Mon, 17 Mar 2025 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196354; cv=none; b=C0SDv60B2tXL0Wou47UmlFHC4qvLPbYGjAXnhKuQ7U4mAwiC+kDZlkON/b5cWziIyDLWduQqMue7hbTvrd+hsVibGuMZNYSniS4+V/3dWY62Gkux37Tar96MTGJGwj90xQXUITI8afL76SoB5ZS/RbgavRGyXanqz5j9LwoCCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196354; c=relaxed/simple;
	bh=CzLh11DqZtf8IqGapJ5m66ohkDySA4nKLkHEabqVZw4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UoNR6XC8q+2+HLytWgVrQa1osqHF0+vQjSeISS5qjnA0VGS4Ldj7cgDJ6doa2irT2JsKYFZC6y48fl5GFpeUfnY3dUobXjWADYIcYwXHwuySs8ZdPM8jSnm8jWfS/6D85VxbGNx8dLv4ZfgqIdnouF7hddq7eqMoFqPjc/FpfQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=M/5BFDYv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p3UTVc3ZDCRlY1xT6AkALtD92EQfzIhzYvG7PR0/6IQ=;
	t=1742196352; x=1743405952; b=M/5BFDYvElKT0++0pL0u0/TxtUyh1/AlNYy2PvVMpyBketL
	oLgONyjVWkkqdoCTzbdfxxF8JncQosdg89AeLsHUSOWZcSyDmCiPcDlsGLB7LiNrqg6kviQLMaJaX
	r8MRiF2VYYmxQOZ05NQae0RL7SNRQdTDrCVSDD7+oTkk1GZxrQ+gHA+AM7yR5zn6uJtjyi3NDWBez
	udCkDeNKElvQZVF9Myw2gqk7Bc6MH1iyBz5mFNK8cLxGyZcrJA0K7uKlAbtDetEDuwu0uH40oNlhT
	PNXqQXBOlM+QY55zU8nX5irdoxzWU6FOlPtfXQfcK7O4Cewgn7Hk/pCo9PosupjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tu4r4-0000000E1Gl-3Vkg;
	Mon, 17 Mar 2025 08:25:47 +0100
Message-ID: <a383d25de302699592bc99867dbf481cb2ab875b.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: mac80211: check basic rates validity in
 sta_link_apply_parameters
From: Johannes Berg <johannes@sipsolutions.net>
To: Mikhail Lobanov <m.lobanov@rosa.ru>
Cc: Shaul Triebitz <shaul.triebitz@intel.com>, Christophe Jaillet
	 <christophe.jaillet@wanadoo.fr>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Date: Mon, 17 Mar 2025 08:25:43 +0100
In-Reply-To: <20250315161253.19399-1-m.lobanov@rosa.ru>
References: <20250315161253.19399-1-m.lobanov@rosa.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2025-03-15 at 19:12 +0300, Mikhail Lobanov wrote:
> When userspace sets supported rates for a new station via
> NL80211_CMD_NEW_STATION, it might send a list that's empty
> or contains only invalid values. Currently, we process these
> values in sta_link_apply_parameters() without checking the result of
> ieee80211_parse_bitrates(), which can lead to an empty rates bitmap.
>=20
> A similar issue was addressed for NL80211_CMD_SET_BSS in commit
> ce04abc3fcc6 ("wifi: mac80211: check basic rates validity").
> This patch applies the same approach in sta_link_apply_parameters()
> for NL80211_CMD_NEW_STATION, ensuring there is at least one valid
> rate by inspecting the result of ieee80211_parse_bitrates().
>=20
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>=20
> Fixes: b95eb7f0eee4 ("wifi: cfg80211/mac80211: separate link params from =
station params")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
> ---
> v2: Fixed the patch subject to provide a complete description.
> v3: added the missing if as Christophe Jaillet (christophe.jaillet@wanado=
o.fr) noticed.
>=20
>  net/mac80211/cfg.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 9351c64608a9..b4d18172da16 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1909,10 +1909,11 @@ static int sta_link_apply_parameters(struct ieee8=
0211_local *local,
> =20
>  	if (params->supported_rates &&
>  	    params->supported_rates_len) {
> -		ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
> -					 sband, params->supported_rates,
> -					 params->supported_rates_len,
> -					 &link_sta->pub->supp_rates[sband->band]);
> +		if (!ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
> +					      sband, params->supported_rates,
> +					      params->supported_rates_len,
> +					      &link_sta->pub->supp_rates[sband->band]))
> +			return -EINVAL;
>  	}

Seems you could remove the braces, and put it all into a single if
statement?

 if (... && ... && !parse(...))
     return -EINVAL;

I think?

johannes


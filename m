Return-Path: <linux-wireless+bounces-15891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD89E3E6D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 16:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96742843A6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7068B1B87C6;
	Wed,  4 Dec 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ChIseoEu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53820B816
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326559; cv=none; b=oRGoclNSgXWby93vbyewTzNGcn9qM3WUAKXdQkxuItn2KQUpQNm1TFB8E6HNsTb08zJvSdRt855q/IUvPg6aROFRreRoYVviJ1wOA2pweJX3+wqbHEU5OGIA3solQBO1Q9gl0BNoUnaqvC/FYATeHn+roHcGpJIBB5ulV9lzPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326559; c=relaxed/simple;
	bh=3X52+hgrpU3zglle4WWr39Ph7ZouLUAjtD00mop/n4A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbQxm4esmM1F/Y2XZSQX53zxzkj9rww7SiAKtHQzeUdqL6kpSu4CJpq+yTNQtFt1GUl14DAcXBIzTBDG6FiQ2+W66G1MpLhOpAxYGKN0n3tsdosP9beEmBtO7/sbH9wDaY9uH4VyGWilKmY7er0byNwrOhIYy8P67SmW9QQkIBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ChIseoEu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=udwzpl60/Y7Zpu+pqgUTc4BExYxEc5MCVhQyr38EDWk=;
	t=1733326557; x=1734536157; b=ChIseoEuIpcrFr2mFU3vUNwVbZEH2ls/abSYN7eKKCGd/kz
	OLX/19laV513Z/1fGqmLngHtJVDFaQkh2Z88mZxaMZ5+hQXPWWBjT0nRNV5MEijWzLu3sNP8fueMb
	Z+DVTJWWPzlZzSdmmEuqt6VwPMnxqJ7fY+nioMGer17wCgw+hrI4eRtV4cOF8zRsgi83av20vAvLR
	Aht2nl7RUpx/WSrwW3dv1rAQcnynqe43PTDnLLjPvF7k0DOIPPru6VEaAYFW+CSLv33qW393BV1ml
	EbEaYsXEanhl5d3L2hPysOKN39cGG1KLMGj6iNBLM4NP6ExpbSUBZy4cNxnMBHyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIrPu-00000006vgK-1TqO;
	Wed, 04 Dec 2024 16:35:54 +0100
Message-ID: <cc95ac5eb124ff46484a44beb0e2ec300d1d6392.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: cfg80211: skip regulatory checks when the
 channel is punctured
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <quic_kkavita@quicinc.com>
Cc: linux-wireless@vger.kernel.org, quic_mpaluri@quicinc.com
Date: Wed, 04 Dec 2024 16:35:53 +0100
In-Reply-To: <20241125051624.29085-1-quic_kkavita@quicinc.com>
References: <20241125051624.29085-1-quic_kkavita@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

The subject is a bit misleading IMHO - you don't skip all checks when
there's puncturing ...

maybe just say "wifi: cfg80211: skip regulatory for punctured
subchannels"

> However, these checks are also performed on frequencies that
> have been punctured, which should not be examined as they are
> not in use.

I'd argue subchannels are punctured (or really disabled, the whole
channel is punctured ... but we mix that up already), not frequencies

>  static void cfg80211_set_chans_dfs_state(struct wiphy *wiphy, u32 center=
_freq,
> -					 u32 bandwidth,
> +					 u32 bandwidth, u16 punctured,
>  					 enum nl80211_dfs_state dfs_state)
>  {
>  	struct ieee80211_channel *c;
>  	u32 freq;
> +	int subchan =3D 0;
> =20
>  	for (freq =3D center_freq - bandwidth/2 + 10;
>  	     freq <=3D center_freq + bandwidth/2 - 10;
>  	     freq +=3D 20) {
> +		if (punctured & BIT(subchan))
> +			continue;
> +		subchan++;
>=20

You never tested this code properly, it's clearly broken.

but anyway - for_each_subchan()?

> +#define for_each_subchan(wiphy, center_freq, bandwidth, punctured,	\
> +			       subchan)						\

I feel like we really should make this work on a chandef, not all these
arguments ... and cover both center_freq1 and center_freq2, because we
have all these duplicate calls like cfg80211_chandef_dfs_cac_time().

> +	for (subchan =3D ieee80211_next_subchan(wiphy, center_freq, bandwidth,	=
\
> +					      punctured, NULL);			\

It should be especially easy if you're pulling it out into iterator
functions? Worst case, keep some extra state in the loop, like

for (u32 punctured =3D chandef->punctured,
     freq =3D cfg80211_get_start_freq(chandef, 1),
     _cf =3D 1;
     freq =3D _cf =3D=3D 1 ? 20, punctured >>=3D 1;
     ...)
  if (!(punctured & 1))


I don't really mind a bit more complexity here, if it means we can get
rid of all the functions like cfg80211_get_chans_dfs_required() that get
called twice ...

johannes


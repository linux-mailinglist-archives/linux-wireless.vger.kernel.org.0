Return-Path: <linux-wireless+bounces-3438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63A8510D2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 11:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832DB1F218A7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A438FBA;
	Mon, 12 Feb 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CivHLGlV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063E38DFC
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733593; cv=none; b=OwO4RiGKgWrQPbjQIwJjzRfDZt/uA2FruJi/PSB46aBuJnQ8dCzPJrbfK66dxBD3qCb9LS+C7WFHl4x3abzUWsEg0Dqyl0K9R9XPTgO863H1gkfuA/TsFa2K9fphgUuucpTRAYIiiB/G0/IbPj4YEnqpp36oNg8IIgEk7jezSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733593; c=relaxed/simple;
	bh=4FNVS1qGyBjxeGIE4xqPVGMLququGXycxo3UDdXEasE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XDwgWphea+lIxGfQQ90QfKC1Oif5wHlJAebyrrBtDMJR4WZf0JU9Zd0quhmtvygrD4UdnzgbVkWYpJ8cUpMcV48JQNn8RcxrbyIcorCZWo7Ko01Y4y0eOHEdhFBDaa5zTloqO0GO8fLjr+T/n8YnK9YZRjRvwgl3jCcVByxpZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CivHLGlV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RhwfpEU2Ig9j82sG9kWNwF+otrag0MwEY9yk+loXwoo=;
	t=1707733589; x=1708943189; b=CivHLGlVkW9LqfnZhD3ECHecjN05g1cSUARpTVJqqI2G37u
	+KsrOF32+a3yGz5ZA2NGJlo7CD/OFZbDrJTxzlC/j6bfvnai3khGU47IkvorFxpePzA/di40iPBVr
	tZMMEBo7Yywo36nXsYkyQAy2rkTk8PNcDQ/SedgYYyQkXxpcWnNBv57kg7XFPLCBdS49WCgN0P0rN
	+wdIrbQbC6imZf6Flv2zPMGrfZVnuMCI7jI1NKFqWuBJ5Dm5sqcDoiIXyKIjEkK6v7dlMP4/hY1N9
	bTrOOU0dEhoptAqh0oor7m0M2SDuceg0CWoxbSLWx/YuptMp/Uny9lKptgg7Drng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZTW6-00000005y0q-0yiu;
	Mon, 12 Feb 2024 11:26:26 +0100
Message-ID: <66bddf2f6362c9f39f06e06c0c35b6900917b9bf.camel@sipsolutions.net>
Subject: Re: [RFC] mac80211: add AQL support for broadcast packets
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>,
 linux-wireless@vger.kernel.org
Date: Mon, 12 Feb 2024 11:26:25 +0100
In-Reply-To: <960efcac-0995-4a42-b90c-3e66c0f56762@nbd.name>
References: <20240209184730.69589-1-nbd@nbd.name> <87plx4s71y.fsf@toke.dk>
	 <960efcac-0995-4a42-b90c-3e66c0f56762@nbd.name>
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

On Sat, 2024-02-10 at 17:18 +0100, Felix Fietkau wrote:
>=20
> > > +++ b/include/net/cfg80211.h
> > > @@ -3385,6 +3385,7 @@ enum wiphy_params_flags {
> > >  /* The per TXQ device queue limit in airtime */
> > >  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	5000
> > >  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	12000
> > > +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_BC	50000
> >=20
> > How did you arrive at the 50 ms figure for the limit on broadcast
> > traffic? Seems like quite a lot? Did you experiment with different
> > values?
>=20
> Whenever a client is connected and in powersave mode, all multicast=20
> packets are buffered and sent after the beacon. Because of that I=20
> decided to use half of a default beacon interval.

That makes some sense, I guess.

It does have me wondering though if we should also consider multicast
for airtime fairness in some way?

johannes


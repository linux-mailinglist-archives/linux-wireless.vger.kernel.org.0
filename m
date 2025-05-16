Return-Path: <linux-wireless+bounces-23059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A557BAB970B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4253A35AD
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C250225A35;
	Fri, 16 May 2025 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NckPpyb9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49320B807;
	Fri, 16 May 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382479; cv=none; b=FoKFV2Q77hFqR9yd+VFjHMgfFRXaBduUFIhy88fGwHgmSgjAriy/LzbJ5hU3WyVKY1778lMWOEZ28saCf/+Xmlmx1EjLJCIDxzyvIcZ6/HifmmA9XugG4054CYv2f1Bdd/HXGa8HhGoJzN3wKjt4noLjHxNP3mgdPyfTFdbL/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382479; c=relaxed/simple;
	bh=wIjTiwi1RCwoRNBe09BLJXxzhYLSf+aCXPd/oQh3fI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U+hJtlG0MCPCXt4hRTSKZb//QS3/z61GkCTed6On+OBd/hklpzSoyHJyZ4oRduDM217RF0muAsUBKcQR3AmUsyMbuBtKpF0EdgW8WUnNuGGiYSv/YpTrwd0ySLcl/22HtF6Pf2tAz1hnJc78SRMvdcgVsYSEisAzlF7ongLT+Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NckPpyb9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=X1HXctmWs4+Ph3l5TlPhcon/Scqg6QqLW4qi06AARVA=;
	t=1747382477; x=1748592077; b=NckPpyb9AnoSGYjUTsdxMl2Wx52BUVz7npBhjgQs+hRJA9k
	uXvLNAIeoYE0XPPT6RNkPUkL0Ww0hxmuhdL1r7G4h5VWx9g7kx5JV9OzjGVeyP12Ho0aiZBt9RKN8
	hcChsB0I/B5A7W3SZIbuXOmWshJjvfDgHYPxbKHuwhPZo6C1uzQ+L5bs+YLvn4TV7iBsnOn8fFLxJ
	miF2tHdz6LbQ8V8lgzhOizDJ9Wkkqtk0MpCc0JWiMcNpkZXXk+/aM52oF2KrS4rv4ineZAECRx/fn
	ZyxjgPB7lY+XmtczTQOtRIG4lTuR4ltQd2Q66qhpL7/5jo2f65d5hXr1mesdOwzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFq0G-0000000E1g6-0yF3;
	Fri, 16 May 2025 10:01:12 +0200
Message-ID: <d23e55879c6d8b6cabcc8357f153ae0622a4c53a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 2/3] wifi: mac80211: Allow scan on a radio
 while operating on DFS on another radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 16 May 2025 10:01:11 +0200
In-Reply-To: <20250514-mlo-dfs-acs-v1-2-74e42a5583c6@quicinc.com>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
	 <20250514-mlo-dfs-acs-v1-2-74e42a5583c6@quicinc.com>
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

On Wed, 2025-05-14 at 16:58 +0530, Raj Kumar Bhagat wrote:
> Currently, in multi-radio wiphy cases, if one radio is operating on a DFS
> channel, -EBUSY is returned even when a scan is requested on a different
> radio. Because of this, an MLD AP with one radio (link) on a DFS channel
> and Automatic Channel Selection (ACS) on another radio (link) cannot be
> brought up.
>=20
> In multi-radio wiphy cases, multiple radios are grouped under a single
> wiphy. Hence, if a radio is operating on a DFS channel and a scan is
> requested on a different radio of the same wiphy, the scan can be allowed
> simultaneously without impacting the DFS operations.
>=20
> Add logic to check the underlying radio used for the requested scan. If t=
he
> radio on which DFS is already running is not being used, allow the scan
> operation; otherwise, return -EBUSY.

So while I agree in principle, I think this needs to be more carefully
constructed because it relies on an unstated (?) assumption that each
radio is going to ever be used for scanning on a certain band. That
seems to make sense, and a radio will certainly only ever be able to
_operate_ on the frequencies listed for it (due to chanctx etc.), but is
it really true that it will never be able to operate at all on other
frequencies?

I'm not sure I find the notion of e.g. having a 5 and 6 GHz radio that
are used for operating on those bands, but being able to scan 5 GHz
channels using the 6 GHz radio completely unimaginable? Maybe it is
though and I'm just overly paranoid?

We could also just leave that up to the drivers, of course, but then I
think we should _state_ this assumption somewhere in the docs/header
file(s)?

> +bool ieee80211_is_radio_idx_in_scan_req(struct wiphy *wiphy,
> +					struct cfg80211_scan_request *scan_req,
> +					int radio_idx)
> +{
> +	struct ieee80211_channel *chan;
> +	int i, chan_radio_idx;
> +
> +	if (!scan_req)
> +		return false;

That seems overly paranoid, or maybe it should be WARN_ON()? I mean,
asking something about a scan request and then not giving one is just
the wrong thing to do in the first place, no?

And if you're going to be paranoid then this probably shouldn't be
called with an invalid/negative radio_idx either :)


> +	for (i =3D 0; i < scan_req->n_channels; i++) {
> +		chan =3D scan_req->channels[i];
> +		chan_radio_idx =3D cfg80211_get_radio_idx_by_chan(wiphy, chan);
> +		/*
> +		 * Skip channels with an invalid radio index and continue
> +		 * checking. If any channel in the scan request matches the
> +		 * given radio index, return true.
> +		 */
> +		if (chan_radio_idx < 0)
> +			continue;

This seems ... wrong? If there's a channel in the scan request that
didn't map to _any_ radio then how are we even scanning there? And the
comment seems even stranger, why would we _want_ to ignore it (which it
conveniently doesn't answer)?

johannes


Return-Path: <linux-wireless+bounces-37055-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMecIon6F2oWXwgAu9opvQ
	(envelope-from <linux-wireless+bounces-37055-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 10:19:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E208B5EE70A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 10:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9579730177A9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 08:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C7D368D42;
	Thu, 28 May 2026 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FW7u2jNj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E22367F51
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955954; cv=none; b=K7cG6FKrfi9i6vg0IaVdUlnaS+7uqyYk7FasHw35iK8RLlmezIJLBWPx89icWAQRZzM8fghOv0IeUxym2zoNzqmW/q+w5QE0y2da+2DSTmPGyv0yaK1v912YLwR4a1c1tPVfap71Roei6oBWXwgVIsscc1pYc1KP7mX7gjnhGPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955954; c=relaxed/simple;
	bh=8GXk2KyIbZzZwXtmRHM/I2cKVJ8Mri/ZzvHAvPOs0RA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eApOmKwRYTbrlsHjDHGPOZli/Cj9h1dS0Fu/gcC0GK4KVsCEQYE7qkRFgnftNNFACuIFdWEdEipi7xSz92Z2XkIBreTof76cclZmq5mQcF2BAiVZk83pnYwXxiY3WXNhHMbjuJbDJkIaVpfUjb9Rd3ScgWmioFHs95kwDucvCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FW7u2jNj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hisHGOVJN8X50Mwuttzl2mfaiguBa40Sox4stmMR/Xo=;
	t=1779955952; x=1781165552; b=FW7u2jNj+Td1wBkAyEmvY0TLowX5kn8zSYIu8GY7fZcv0Dr
	rexF2zCCUYfg8G0OvcuIhayF1wBPClg4gtf7IZVvD+sMqoknh4ECd1liWgJl/UJ1SNtQ8/jHbVY/o
	YZB9vlVsfG+C2MDOvJD0C/iS8cs1pltsKZUXeLNnwksD7o/htXcBVd9GJUO4aSJ4tDjwgL/F0sBYn
	XmSlo63TBl7/3aidxyCOqYLyWuXDXF3E/TCqPDHE4B37Qn6hWqw2vViLodLMIhupPFiKPLo2IUNYR
	VDvzL2zeV3t2oHb/ZPNjtdX6qIxOG7Vh71WyCMkoD8kGwXgYEsVZbLpRHk7EPflg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSVqv-00000007C6I-39w7;
	Thu, 28 May 2026 10:12:29 +0200
Message-ID: <244b27052cbfd1f922132f2f3c5a16d6b25b0450.camel@sipsolutions.net>
Subject: Re: [PATCH v8 6/6] wifi: mac80211: Fix PERR frame processing
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>, linux-wireless@vger.kernel.org
Date: Thu, 28 May 2026 10:12:28 +0200
In-Reply-To: <20260521225842.31815-6-masashi.honma@gmail.com> (sfid-20260522_005901_891083_9CB68DC2)
References: <20260521225842.31815-1-masashi.honma@gmail.com>
	 <20260521225842.31815-6-masashi.honma@gmail.com>
	 (sfid-20260522_005901_891083_9CB68DC2)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37055-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E208B5EE70A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-22 at 07:58 +0900, Masashi Honma wrote:
>=20
> +/* IEEE Std 802.11-2016 9.4.2.115 PERR element */
> +static inline bool ieee80211_mesh_perr_size_ok(const u8 *pos, u8 elen)
> +{
> +	struct ieee80211_mesh_hwmp_perr *perr_elem =3D (void *)pos;
> +	u8 number_of_dst;
> +	u8 needed;
> +	const u8 *start;
> +	int i;
> +
> +	start =3D pos;
> +	needed =3D sizeof(struct ieee80211_mesh_hwmp_perr);
> +	pos +=3D sizeof(struct ieee80211_mesh_hwmp_perr);
> +
> +	/* Check if the element contains number of dst */
> +	if (elen < needed)
> +		return false;
> +
> +	number_of_dst =3D perr_elem->number_of_dst;
> +	if (number_of_dst < 1 || number_of_dst > 19)
> +		return false;

Same here, though I didn't double-check this one; if we just go to 'int'
or 'unsigned int' for 'needed', it's not necessary to even have this.

> +
> +	for (i =3D 0; i < number_of_dst; i++) {
> +		struct ieee80211_mesh_hwmp_perr_dst *perr_dst =3D
> +			&perr_elem->dsts[i];
> +		u8 dst_len;
> +
> +		/* Check if the element contains flags */
> +		if (elen < pos - start + 1)
> +			return false;

that comment seems a bit misleading. I figured out what you mean, but
IMHO it'd be more obvious if you wrote it as

	for (...) {
		struct _perr_dst *perr_dst;
		u8 dst_len;

		if (elen < pos - start + sizeof(*perr_dst))
			return false;

> +		dst_len =3D sizeof(struct ieee80211_mesh_hwmp_perr_dst) +
> +			  ((perr_dst->flags & AE_F) ? ETH_ALEN : 0)
> +			  /* Destination External Address */ +
> +			  2 /* Reason Code */;
> +		needed +=3D dst_len;
> +		pos +=3D dst_len;

and technically that pos+=3D could be UB, so it should be

		if (elen < pos - start + dst_len)
			return false;
		pos +=3D dst_len;

> +		/* Right now we do not support AE (Address Extension) */
> +		for (i =3D 0; i < perr_elem->number_of_dst; i++)
> +			if (perr_elem->dsts[i].flags & AE_F)
> +				goto free;

This code will need to change based on what I commented on patch 3 wrt.
the variable members, although we only really use [0] and allow for a
single entry anyway ...

Probably should have an inline that returns struct
ieee80211_mesh_hwmp_perr_dst based on the index, and then have
ieee80211_mesh_hwmp_perr_get_rcode() work on that pointer instead of the
element and index.


Thanks for sticking with this, it already looks really nice!

johannes


Return-Path: <linux-wireless+bounces-36696-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCWOBp6XDWoMzwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36696-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:14:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE5458C2CE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B276E301E54F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47903DA7F1;
	Wed, 20 May 2026 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ncYfzMqm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370043D9DAC
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275674; cv=none; b=e1/S7MQki4NcM9tz4KrUJjoXTrC0OOAoj4qSmq5CvVI+YxMECuIQp+UCDQ6/LiXGYnN6d0wQbXeQ3KIGKcvuOg/Jh7qrne75BDajC+IivwvWjS07EKnwemmMs6Ei5VVvzplx2Znoo4AFd8BDnp3QTfC2yB/E0Enqtn3OLvinHJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275674; c=relaxed/simple;
	bh=4I+Abemj884ib6u5t+PbV1c5FJZ63AG0Zdo+LOsSGXY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fX3+ea9cQFNlsuFf3/owbwooEy1wGbyeRtrPi6mDSrePkeoPUlQ9OSyNVSOQpR4guECewaGflm40Txda2O1xVt9BihxwGmxEkEeTsFgvlmD4FGbx3DVsKxttldE2kgmVCHzclMcYE6x2w+S47TqzG6pMqvuxuAHOjxymiHRWqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ncYfzMqm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eOWD3bNAAYu8Izj9vswt9iRCSIMqEZgxNZXQprtklmY=;
	t=1779275673; x=1780485273; b=ncYfzMqm1rJINIoIamPz1CbjxmNJ8gRnF8u30IC9FhR2tL9
	x4UZbx+4gZBIxLDbEv8Pd3hakVe8gXRgOgLrj2EaM0HmpmomlI/gYRQx4JwiReXX9BEH1PoEaCqy2
	ooqcg51HGKXFUQBORGt2el2z8ro/W69e2Q8tV1mA7G2OvyUnMoADWINBrL460+4gFMef2bfgK255s
	aBQGhw/9w32qo8cTHfWoYhKTHfP7j8X/LJzAO3XDPcteEfX4IbtuAfIP6SHdnyMMaMdEgQd0hj1b0
	0VSLsHnKhWQSAovYidx/wgjzwRwCB/5nOtwhZFcDMZxQAim/heDdbZ3n7Zelwayg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wPesg-0000000AKSN-3ZzU;
	Wed, 20 May 2026 13:14:31 +0200
Message-ID: <965eff7ec3b928f093f7891e4307ec4e4a080ac4.camel@sipsolutions.net>
Subject: Re: [PATCH v6 1/6] wifi: mac80211: Use struct instead of macro for
 PREQ frame
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>, linux-wireless@vger.kernel.org
Date: Wed, 20 May 2026 13:14:30 +0200
In-Reply-To: <20260515233839.86829-1-masashi.honma@gmail.com>
References: <20260515233839.86829-1-masashi.honma@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-36696-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CEE5458C2CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

So I was tempted to just take this, but I did have a couple of nit
comments and questions, so maybe let's iterate once more.

On Sat, 2026-05-16 at 08:38 +0900, Masashi Honma wrote:
> Signed-off-by: Masashi Honma <masashi.honma@gmail.com>

It would be nice to have a bit more commit message, but yeah, it doesn't
do that much ...

I'd definitely reformat this:

> +static inline struct ieee80211_mesh_hwmp_preq_bottom *
> +	ieee80211_mesh_hwmp_preq_get_bottom(const u8 *ie)

to not have that tab there, and

> +{
> +	struct ieee80211_mesh_hwmp_preq_top *top =3D
> +		(struct ieee80211_mesh_hwmp_preq_top *)ie;
> +	return (struct ieee80211_mesh_hwmp_preq_bottom *)

to have a blank line between the var declaration and the code.

In this case I'd also be tempted to just use (void *) casts to make it
much shorter, since the other types are implied by the variable/return
types.

> +		struct ieee80211_mesh_hwmp_preq_top *preq_elem_top =3D
> +			(struct ieee80211_mesh_hwmp_preq_top *)hwmp_ie;
> +		struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =3D
> +			ieee80211_mesh_hwmp_preq_get_bottom(hwmp_ie);

same here, perhaps.

> +		orig_addr =3D preq_elem_top->orig_addr;
> +		orig_sn =3D get_unaligned_le32(&preq_elem_top->orig_sn);
> +		orig_lifetime =3D get_unaligned_le32(&preq_elem_bottom->lifetime);
> +		orig_metric =3D get_unaligned_le32(&preq_elem_bottom->metric);

Ok, oops, I just realized my other thought on this was wrong - the
previous PREQ_IE_LIFETIME() was u32_field_get() which loaded an entirely
u32 from there using get_unaligned_le32().

However, another comment: You don't need get_unaligned_le32() here since
the struct is __packed, so you can simplify all of these to just

	orig_sn =3D le32_to_cpu(preq_elem_top->orig_sn);

etc.

> +	target_sn =3D get_unaligned_le32(&target[0].sn);
> +	orig_sn =3D get_unaligned_le32(&preq_elem_top->orig_sn);

same throughout wherever you access through a __packed struct. This also
applies to the other patches.

johannes


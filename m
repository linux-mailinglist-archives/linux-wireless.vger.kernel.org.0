Return-Path: <linux-wireless+bounces-37053-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD2XC6r3F2oWXwgAu9opvQ
	(envelope-from <linux-wireless+bounces-37053-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 10:07:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5CE5EE3F7
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 10:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E340930B836E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93239361DD9;
	Thu, 28 May 2026 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Q4CXvIWT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A334B682
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955213; cv=none; b=CsUTAZEOqDfhBNk5qDgqm5NpU7j8qmQo2N8qcePZ/uWIG0eQB7yPivQXl1KJIw2eJfO4NwaC1BtmTJE7W5ar4grGINtJothbeBFKi1gbDiP8ELX1wwCRXm4OxvIHUuT5b7wsDOBMowQBKWxUc0o1NP2CSVn+hxPS7RSzTX+UzhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955213; c=relaxed/simple;
	bh=vdD1iMtaeScVS5bAVIqmo0pHksz7J1y2+dRp41eEurg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PDIb+loafAE6ZwOCRLpD5OfFRaMhejwxyDLebZbKXKGv15TPK0X2ILLyoK8N92TZhafhUXvn+iPnJjCupSzPWfXVfCVw67BSnTJ/06GiGb+EG/4OeTMCH8eanNU6uhqC7zKTbaQInArVemGNP86sxZVuXdwLoCJO6LVD6YqSTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Q4CXvIWT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lDSl9EZsl0NyqwyslQeB9GOD1vPBvRt/mUNpeSC8pqM=;
	t=1779955211; x=1781164811; b=Q4CXvIWTt3LlS+4IBbkBd15gA7iLfGkApGjaY88IaE7l2as
	wii7uavw/lUq/TDtt2AKIM1Bu3eQt+3occ/hYEYUXfCXi6kdDSdb+Oh3KG7xkd38n3wPIC6oUF/MD
	zMET8Fx4UiTURPHIOGQkCYSeE0ieZSUD7qw2DzRxloEzgNl6wmmW5U3501/a1rNlHCe0ifERh/u8e
	myDHjHH2m2JL3xzWAIe1ctCJ7UfDm0rfM38QvudBoBLtat+SiQk2l0WlToMblBBhiGfIKRCteLONY
	pXCBDUoK3QUXvwmT3F/Cdfrh57fPyH+6otsgNJB5GWOf0War8Mq8JBK1eSp+dNog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSVey-00000007BRX-3dQO;
	Thu, 28 May 2026 10:00:09 +0200
Message-ID: <8ab957b3c31dec7be844ea9e1ac2fbb2fdcd8278.camel@sipsolutions.net>
Subject: Re: [PATCH v8 3/6] wifi: mac80211: Use struct instead of macro for
 PERR frame
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>, linux-wireless@vger.kernel.org
Date: Thu, 28 May 2026 10:00:08 +0200
In-Reply-To: <20260521225842.31815-3-masashi.honma@gmail.com> (sfid-20260522_005855_718104_C5CA026D)
References: <20260521225842.31815-1-masashi.honma@gmail.com>
	 <20260521225842.31815-3-masashi.honma@gmail.com>
	 (sfid-20260522_005855_718104_C5CA026D)
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
	TAGGED_FROM(0.00)[bounces-37053-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 8D5CE5EE3F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

So I was just about to apply this set, but now I'm thinking about this:


> +struct ieee80211_mesh_hwmp_perr_dst {
> +	u8 flags;
> +	u8 addr[ETH_ALEN];
> +	__le32 sn;
> +	/* optional Destination External Address */
> +	u8 variable[];
> +} __packed;

This has a variable member, and the presence of the address in
'variable' depends on the flags (AE_F set there.)

> +struct ieee80211_mesh_hwmp_perr {
> +	u8 ttl;
> +	u8 number_of_dst;
> +	struct ieee80211_mesh_hwmp_perr_dst dsts[];
> +} __packed;

However this declares an array of these, and that doesn't really seem
right. It effectively puts non-variable fields (e.g. dsts[1].ttl) after
the variable field dsts[0].variable. I _think_ some compilers (versions)
will also (rightfully) complain about this.

It seems like this should just be

struct ... {
	u8 ttl;
	u8 number_of_dst;

	/* list of variably sized struct ieee80211_mesh_hwmp_perr_dst
*/
	u8 dsts[];
} __packed;

> +static inline u16
> +ieee80211_mesh_hwmp_perr_get_rcode(const u8 *ie, u8 dst_idx)
> +{
> +	struct ieee80211_mesh_hwmp_perr *perr_ie =3D (void *)ie;
> +	struct ieee80211_mesh_hwmp_perr_dst *dst =3D
> +		&perr_ie->dsts[dst_idx];

And especially this indexing doesn't seem like it could work - you have
to walk through all of them to see if each has the AE_F set and skip
sizeof() + optional ETH_ALEN.

> +
> +	return get_unaligned_le16(&dst->variable[
> +		(dst->flags & AE_F) ? ETH_ALEN : 0]);

This looks like the comment above should be

	/* optional Destination External Address, rcode */
	u8 variable[];
=09
or so?

> +	target_rcode =3D ieee80211_mesh_hwmp_perr_get_rcode(perr_elem, 0);

but evidently, this doesn't really matter right now if only one
destination entry is ever read.

Still, please fix that, if only to avoid the compiler warnings I'm
imagining will happen.

johannes


Return-Path: <linux-wireless+bounces-35235-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLMaL2A86WmEWQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35235-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 23:23:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737D44AE23
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 23:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFC763058671
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 21:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D89331A56;
	Wed, 22 Apr 2026 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gJhk3phD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85D3644DE
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776893020; cv=none; b=jX5yonKQ8D1qXw+LUwT3utBY1diq1Y6esiJfQnNe80D0YKo+QSkzNc9KbYQFSEmIhzPOvHA90I5MFjiaFsUMGLxVUKbQkMYygyRy8WGSmjrbgNk8K+jzja3tMhPrmFlmrYo8TBMTKkdPTBGecEUrUFyAxK6T8ahf3V0fbPEKNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776893020; c=relaxed/simple;
	bh=wscpt9vUs7pQWBzoRAO2Sn+JLhFUpqWC9zWOdRoZD/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fv71W7TXsMzIvAvI7w6LSHxg6KR8Jqmg3VOWk91nRbTv+0gQd9X5aU5BpyM3eQyrSGqJu59ep6RWwPupu2+WUMCJ/EuP261FiolwdcaWOsnQsIEfDhHH6/5O7KPo2olq5l3cUJOALzB2+S14wbCEg6x7vzl/WzjjHh2XcK95umU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gJhk3phD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=J5j2a5id8Z8xnDz7Z9+MfER4F4g6Ty9EvKzWS/bldMY=;
	t=1776893019; x=1778102619; b=gJhk3phDgESyJpT5OXBXgknxZLxPnc6YVY9/CoRSShWN0SK
	WAyOHhioogTkzxChNTS/sybz+MFwYHlgX205w+RgbVpBOIYIpg/KgQ8RlUIDBvuIevWUlSrbN/Q1U
	waWV/MxZrV6P4HRrO3tRFdbQ0VNiKW7lbqoWlny+rg4+ac9UodgZ0ukj9NDFdg2RssPtnZeu4MW+m
	/byN+WgqsCnFuvpJJoEqNYrmmIj1Ut/RPWYUvfj+HdyaRpriAH7U7FM03IYhNQ+xGhiRmjGXd/IAa
	qYuJ05YoD4TYeYp+zD06ZwEEOqAxNrecDs/hDjSE6x2ef+ef+cyayyC294dV/Lvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wFf2k-00000006WHc-3nM9;
	Wed, 22 Apr 2026 23:23:35 +0200
Message-ID: <12e43b5e8b8db797fa43f4a2cc8b8e5e489c4397.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] wifi: libertas: fix OOB read from firmware
 pkt_ptr offset in RX path
From: Johannes Berg <johannes@sipsolutions.net>
To: Tristan Madani <tristmd@gmail.com>
Cc: libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org, 
 Tristan Madani <tristan@talencesecurity.com>
Date: Wed, 22 Apr 2026 23:23:33 +0200
In-Reply-To: <20260421135027.357622-2-tristmd@gmail.com>
References: <20260421135027.357622-1-tristmd@gmail.com>
	 <20260421135027.357622-2-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35235-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3737D44AE23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-21 at 13:50 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> lbs_process_rxed_packet() uses the firmware-supplied pkt_ptr as an
> offset into the skb data without validating that it falls within the
> skb buffer bounds. A malicious pkt_ptr value causes out-of-bounds
> memory access when the function subsequently reads ethernet header
> fields from p_rx_pkt.
>=20
> Add a bounds check to ensure pkt_ptr plus the minimum packet header
> size does not exceed skb->len.

Please generally put a bit more thought into your patches.

> Fixes: e45d8e534b67 ("libertas: add support for Marvell SD8688 chip")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

I'll also note again that I don't find any tool/LLM disclosure
improbably, nobody really cares about these rivers any more?

>  	p_rx_pd =3D (struct rxpd *) skb->data;
> +
> +	if (le32_to_cpu(p_rx_pd->pkt_ptr) + sizeof(struct rxpackethdr) >
> +	    skb->len) {
>=20

At this point you don't even know yet that the skb is long enough to
access p_r x_pd->pkt_ptr *itself*, so this can't be right.

There's a length check later that checks for

        if (skb->len < (ETH_HLEN + 8 + sizeof(struct rxpd))) {

which probably needs to be moved up _and_ improved, but you're not
actually checking things correctly.

How is it that whatever tool you're using to find these isn't
complaining about the fix??

johannes


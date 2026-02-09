Return-Path: <linux-wireless+bounces-31665-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB1lJ4HViWklCAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31665-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 13:39:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045410ED1E
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 13:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6984D3004617
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2237105C;
	Mon,  9 Feb 2026 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dKeEQjKx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D798371056
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640764; cv=none; b=jGbVqvaUsnKrhpgYWGernYcdG2Dgs0TdGDwk3mR1oJa9ldzyGSEIdVzznloDUNiQM73jtHalzLjpW0Zip0Be1MVx+DgP5KReR6NgGaT5kbAOyhEps6zc42mosUZcdAkNMbjlG3vbkofyjjISlkRy5kqYSclbKd9Ed72CNWFx2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640764; c=relaxed/simple;
	bh=2bCPM38C7Np+nAC0eqTpZsLQf7MOvX9x/v5o+cI7ht8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HG6X066JL2KvZ36GvKrnsxbRZO+0vRcTuPMrxElphnlLswGj2gqL42wlzfvP+LAbiGBLt9g1k84I27KfYa3zffsm2UVbdOAe7dG+jurUc6+loKQEt86F4KTDJtgZq1kLNAjMJLQvpwUYPQQsAviqAeA8toL6/LdfxxxAoBqQqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dKeEQjKx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2bCPM38C7Np+nAC0eqTpZsLQf7MOvX9x/v5o+cI7ht8=;
	t=1770640764; x=1771850364; b=dKeEQjKx/Sdh+vDQeJTEGP+cYVcCOPNm4vXvJ85bS7ovp+w
	NNSOwk7gNFGnyAWiKKevC8yn5pZd0kl3uQ8ER3h2VD/QGJ1Hht/g1typAdOl+wXZ0ZRzC9j72twI7
	hgwlTRZ/eyhJ5zc5QKqBRFyzgd6zCH/deo898nR6w+8DigdiyToeBDp207aqWKgurP0VLOuXK4pn0
	Ca6BWG4/0Gmvz3TYxLYfNHexkyRjjDivW4JfatxATTjehNRao5EgRh7YCXpXap042OHkhixtEIuU/
	L5qbypGk1eK//4e0LqLe6thquGhoJOeG7IR3oiFIoZKcE1fA4nAi+N7kGKCrYfVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vpQXy-00000002tlx-0YRD;
	Mon, 09 Feb 2026 13:39:22 +0100
Message-ID: <03ec65239dfce3885313364bde7fcaebc5bcb030.camel@sipsolutions.net>
Subject: Re: [PATCH] mesh: don't incorrectly use const
From: Johannes Berg <johannes@sipsolutions.net>
To: Rudi Heitbaum <rudi@heitbaum.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 09 Feb 2026 13:39:21 +0100
In-Reply-To: <aYh28AFauAnhkzee@c1ec8b16bbaa>
References: <aYh28AFauAnhkzee@c1ec8b16bbaa>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-31665-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 0045410ED1E
X-Rspamd-Action: no action

On Sun, 2026-02-08 at 11:45 +0000, Rudi Heitbaum wrote:
>=20
> --- a/mesh.c
> +++ b/mesh.c

What's this for? Maybe 'iw'? Please use (also) that for subject prefix
if so.

johannes


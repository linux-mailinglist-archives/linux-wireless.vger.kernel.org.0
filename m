Return-Path: <linux-wireless+bounces-34091-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HrhLnmdxmnrMQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34091-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 16:08:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2573467B8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 16:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C96363003369
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780930EF84;
	Fri, 27 Mar 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JxcbS/my"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0630EF6F
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624118; cv=none; b=dVz1G2pIgOOkRnXp5lBBUVPQ9X1XcXWlcz+rqVq7cfu9TifObLTdoWz9WiRbDe6lAh+RKBjmU2ZHH+GDwWvEf4u7LsGqBb9NovSKqWMbMnu7fHBhHg/Mad1HTJ3uo9/WW0UgzSmjdzdFKCBJBIiz89T2+6LYkdYeSo/58pzM0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624118; c=relaxed/simple;
	bh=NvLS/gs9GqCH2sPrNtYF2Z4xm25/kb4mLDb5c3IEvtw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DE+/+5Q2kEhp2PIVKDhCF3OKRAR7X2secv7xruqEh946KDbY1N4JYFgVXJzWc/7Pj+9YB1NAqC7Q8uhi0ubmCUNP453QAtnIG+N8MX+/u6NyslvNNhnblefE6/n7lTPdVPjV0WGqWRvIndxaLKGGNxKt986TbR8OY3zDaoB7tCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JxcbS/my; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NvLS/gs9GqCH2sPrNtYF2Z4xm25/kb4mLDb5c3IEvtw=;
	t=1774624115; x=1775833715; b=JxcbS/my6BEBJcIze+adAYAJpog/fwQ5YqaY/u678TgPwwa
	F0MLySsTf9uzLYduAFQal56nK5/sHgVoqLjriqiQU4WmarZZZU4SDnJchUndQk8H76oa+aNK4qneE
	H3p7WBeYZ/X3CbhJErj22hb58M1YfsYBV1EeGzIX0zcKanxXo8+OWfIN3cAxOJQ+7r7RMtk4pbRAs
	26XGM1/x7Kb93mL1PFcOmzd6NCOqIRiF5JiCk9uSCnH5HG0duOF1YEpiD1dzlCaYH9LJU7uTVmcsU
	Mpnc/R01zDMiAh1VmZej9ICT8diN3wJgqHYOlPj79qyZWu6Diqe1AsBNpEgx6ixA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w68nV-0000000EMNz-3nOs;
	Fri, 27 Mar 2026 16:08:30 +0100
Message-ID: <ff90035f97d3ae180171172ad6624fcc7c6c9d8a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 08/19] wifi: mac80211: clean up STA NSS handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MG <pmartin-gomez@freebox.fr>, linux-wireless@vger.kernel.org
Date: Fri, 27 Mar 2026 16:08:29 +0100
In-Reply-To: <8aa10ce1ed9da7409ade68d376a61f5e14c70219.camel@sipsolutions.net>
References: <20260327093659.711584-21-johannes@sipsolutions.net>
		 <20260327103659.5296c2f3a949.I97fb93ccc1b366110ab23de58fcd73676cdd85d6@changeid>
		 <79228bab-aa6c-4fda-97c9-768b158dfa3a@freebox.fr>
		 (sfid-20260327_132444_673524_537A049C) <8aa10ce1ed9da7409ade68d376a61f5e14c70219.camel@sipsolutions.net>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34091-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 5F2573467B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-27 at 15:50 +0100, Johannes Berg wrote:
> On Fri, 2026-03-27 at 13:24 +0100, Pablo MG wrote:
> > If we are doing some cleanup, let's go full on it.

> No? You're sounding a lot like an LLM that really likes to comment on
> code that's only moved...

OK, that was a cheap shot, sorry.

We can debate the merits of doing some cleanup on the code separately,
but "let's go full" doesn't really ever make sense, even if a patch is
already doing some specific cleanup in some area, it's always better to
do other/unrelated cleanups separately.

So please don't suggest that code that's only (explicitly!) being moved
get cleanups "along the way", doing that would be actively harmful to
understanding the changes being made. The key point in this patch isn't
even that the code moves, it's that the callers move around. Maybe I
shouldn't even move the code at the same time.

Of course, if there are cleanups related to actual modifications, sure,
that's good to review.

Also, of course you're more than welcome to suggest cleanups to the code
as patches yourself, but you could do that _better_ by reading the
_code_ rather than by looking at the changes someone else is doing is
doing to it. And less chances of conflicting along the way.

The part that the review LLMs do all the time is suggest that context or
code being moved is also changed, and that's really not how "small,
individual commits" work. Even the Sashiko folks are actually trying to
get it to do _less_ of that, nobody is saying this is a good thing.

johannes


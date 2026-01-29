Return-Path: <linux-wireless+bounces-31329-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB4AJsxse2mMEgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31329-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 15:21:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 003CCB0DBF
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 15:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0FB2300BDBD
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9315205E02;
	Thu, 29 Jan 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CIsui4J0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5F1DFDE;
	Thu, 29 Jan 2026 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696457; cv=none; b=XrErJR6KIsl/NB61FpYw2FE5XGkYnCeRfgpelsMtviVlM22t/M91kuUXiU9mSpJbRI7X8Xa9uWYDplyP19PENq+4jstjjWsqG8WgSEvcPgOfo5FS7wKZG5zpwFHlM71DtS567SjI6wCxbX6aKT8Nq6dqR5aDDVOJLo04l7U6yuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696457; c=relaxed/simple;
	bh=RB4TzDBjSi27EKccQ9FoTOntKnZMUn5eWRRZlIXfbXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XQQzRG4luZ6ZrgZhzQNxcE53+SEXK8gzsa1JetVvZjIoM7gprJ2WQqkTprwG2C+8xL7I/Pvo6/Ks/yTRdrxzLiPLcc+DulvOZDsUUD/5vW4YQj0KB/Ew1hEL4kzqD8icHBnvDLYChKXbRH/ofxrotkQY256P9/TtStsP/Ex89Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CIsui4J0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=q4nVSXpVhqc4kGfdQfMCVyGeMoG1k1+ADW3pvdsOZ3Q=;
	t=1769696456; x=1770906056; b=CIsui4J0FOZFim3pP9lGpdTkwalKbBvevCIvYdbGu/zy3Z2
	vBOzmHtERp1IdWgkRBJ4QvoZaAymYZjp7dAJ3SaLUFOZWsTu6Mqx+0HcO6mVx76m0wU092ZX80GGW
	4p/O8dpb5LY4s+1mwV+lIkl6yai70iUMorg+khd5pGIX0jd8Ce35x15QZzYMQQpEOB2Jw5kP/2OaE
	rQDq/ko4tAeuPHgCOPjZjXqm5xaUPjFugXYqko3zkuOG11KGiPWMm6gnQTNguRjFRcAx5a8UxqOyC
	MBm5PlFNQ4/J2L486aCPjRtbeLiUCev/ajmZE2P5JEAq2vqWr+hiZA7GMQIraScQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlStC-00000006tt6-073T;
	Thu, 29 Jan 2026 15:20:54 +0100
Message-ID: <f20c64ea4f4a2d3567ab707d98a5164457b02735.camel@sipsolutions.net>
Subject: Re: [GIT PULL] wireless-next-2026-01-29
From: Johannes Berg <johannes@sipsolutions.net>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 29 Jan 2026 15:20:53 +0100
In-Reply-To: <b0d6887f-7946-46b6-986a-bf410b832d66@redhat.com> (sfid-20260129_150854_647905_46B9C6EC)
References: <20260129110136.176980-39-johannes@sipsolutions.net>
	 <b0d6887f-7946-46b6-986a-bf410b832d66@redhat.com>
	 (sfid-20260129_150854_647905_46B9C6EC)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
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
	TAGGED_FROM(0.00)[bounces-31329-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 003CCB0DBF
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 15:08 +0100, Paolo Abeni wrote:
> On 1/29/26 11:58 AM, Johannes Berg wrote:
> > Here's another set of changes for net-next. Two things to note:
> >=20
> >  1) This introduces a couple of new sparse warnings, because it
> >     cannot deal with guard(spinlock_bh)() which the drivers are
> >     now using. I previously fixed sparse for that for RCU, but
> >     given the context tracking work will remove this validation
> >     from sparse entirely, I haven't bothered trying to keep up.

> The CI also report a 32bit build failure, but with a dangling link to
> the actual build results:
>=20
> https://patchwork.kernel.org/project/netdevbpf/patch/20260129110136.17698=
0-39-johannes@sipsolutions.net/
>=20
> so it could be a CI flake, but could you please have a look?

Hmm. My instance didn't report anything at all [1], not even the sparse
warnings (oddly enough), although it had reported the new sparse
warnings due to guard() for the ath PR [2], but not on 32-bit.

[1] https://patchwork.kernel.org/project/linux-wireless/patch/2026012911013=
6.176980-39-johannes@sipsolutions.net/
[2] https://patchwork.kernel.org/project/linux-wireless/patch/65b400ca-8526=
-4184-ae0b-5e24e41dab9c@oss.qualcomm.com/


I just did a 32-bit build manually, and only see some warnings like
this:
drivers/net/wireless/realtek/rtw89/util.c:43:45: warning: decimal
constant 2238721139 is between LONG_MAX and ULONG_MAX. For C99 that
means long long, C90 compilers are very likely to produce unsigned long
(and a warning) here

but that's old, this file hasn't been changed in ~11 months. We can get
that fixed, but it's not something the CI should have flagged as "new
warnings".

Sorry, not sure what's going on.

johannes


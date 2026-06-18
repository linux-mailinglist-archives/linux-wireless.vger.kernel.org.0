Return-Path: <linux-wireless+bounces-37899-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7keMDJjbM2pGHQYAu9opvQ
	(envelope-from <linux-wireless+bounces-37899-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 13:50:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2138869FD2C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 13:50:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=uFDeHl0E;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37899-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37899-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32C9B30060A9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946B3B7B66;
	Thu, 18 Jun 2026 11:50:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C235202A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 11:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783442; cv=none; b=BjORuH1uMf4OH/3Q7u4Gu4NEXNDWF5eAuyJqrD7xPddAbxW8Gl1PfsPJ2nGV9O1vgXnxFkMq4qgy/XPK18AWoAQo6T6pen3Q4+j74E/Ki09YXF5S51etK4RQRvRC9+/ht3GHXrsvTWEK9H95xvWknM04+qFF35UiKmKX0upZ260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783442; c=relaxed/simple;
	bh=3n4pPEK8x3b7TxxwKLyUN1EFRjki2e7BzuSfUjcFR4Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cbaaZpEhbjQY387olIIEuyrPF4lTl8yOcoD8pDuSUD/8u9ZWMHuEOzGFg59jONFliRX8fz85ESObigE3fn5EatAvskzIX4sOgJwvStA6jo6E015QA/jnzO6ZW9roRP/2q7kRMSN+jbxzuhtlBKE89i59CRXBw1FFFLSToruYzXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uFDeHl0E; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3n4pPEK8x3b7TxxwKLyUN1EFRjki2e7BzuSfUjcFR4Q=;
	t=1781783440; x=1782993040; b=uFDeHl0ESy0EpTaPdSFXlPbg1Hy3dBQorMd4MlBEvgcXI7p
	2ML+X86ZPtdcCl9PAvLzbFPhkkbmTOZaeV4DBJvTN4s4Y5LpXis4o3J/SVPN0GmccIfb6AH3I7lhN
	gJUzYxVh6YGTVeCKyYTkZiiCHlSdiW+n3DmRPMVxoHASt8TDoG0kcAVikuJaNgUhyDPx9aYAt031H
	eV4JATKNUZhUce+GmddvmN8gV6G++nTDCbq2XRMofecS0AwLI2NePBElIW4HFioPGfBRuyl3wV9Gj
	VKMN1O5q4bKV23f38KafIp4eS4C/9D9Mxcs0LGcgybUFmiMFvxrbj2WaEVsXGBWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1waBGX-00000004UvF-15Cl
	for linux-wireless@vger.kernel.org;
	Thu, 18 Jun 2026 13:50:37 +0200
Message-ID: <8f08a690242483a0c1026e7b006f48c9c01c6f30.camel@sipsolutions.net>
Subject: Re: NIPA/wifibot disappeared
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Thu, 18 Jun 2026 13:50:36 +0200
In-Reply-To: <a5615f2658fe31a32836d02aa0f2d69027782bea.camel@sipsolutions.net>
References: 
	<a5615f2658fe31a32836d02aa0f2d69027782bea.camel@sipsolutions.net>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37899-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2138869FD2C

On Wed, 2026-05-27 at 12:52 +0200, Johannes Berg wrote:
> Hi,
>=20
> Due to a mistake, the machine that was running our checks was
> decommissioned and redeployed about two days ago.
>=20
> I'd been planning to move the service to the servers that we have at the
> netdev foundation for NIPA, but hadn't actually started doing that
> because I've just been too busy with other things.

Good news :-)

Thanks to Matthieu (who did all the hard work) and the Netdev Foundation
(sponsoring the work and the server time), the bot has been back for
about a day or so, running on Netdev Foundation infrastructure (rather
than an Intel server I had to maintain personally.)

It's on the netdev config, so perhaps a little pickier than it used to
be.

johannes


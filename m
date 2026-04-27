Return-Path: <linux-wireless+bounces-35369-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDosJ/VE72kx/gAAu9opvQ
	(envelope-from <linux-wireless+bounces-35369-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 13:13:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43804471859
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 13:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E7063004633
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 11:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7268384244;
	Mon, 27 Apr 2026 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Pjm02/rY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC437B03E
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777288434; cv=none; b=gGdXPS+zwzUEdFAxLTCOV/hGkwZoKoCnzD5UH8MN+q4Aa0cexb8Bpk7gJaZ4iVDd+/uiyVxch1X5jF1F4wvRwvXAcePYf3ts7Py9lakKLxm+rTSb0NaCcg2gmO0m7qYTiGHEmOV9u+bd3eG3s0rs/zYizX00Ei3oNdmbGBWLdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777288434; c=relaxed/simple;
	bh=9/XOAW8tVEgYBdouLZ4UoFjLC+YVw6tpsvYwyP4F+cI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcv5tT1sYJpJz3lKyI2r+/nTWCKiBd7VRPb+P5sNBd7kxiCr+ZBKEsGPdpqPKkFY7oEcRNh9wcU4+ppOolIOf58VXF2gLkHFQ6kZy0pLsdzOppKs9NN+zklJ7svLdD0AvQVoXzfjy+SRA2yfDyAgGUE0h0IiJRFTJY0giYaowHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Pjm02/rY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9/XOAW8tVEgYBdouLZ4UoFjLC+YVw6tpsvYwyP4F+cI=;
	t=1777288433; x=1778498033; b=Pjm02/rYwhOxdxJntdeCJnaAt3tviK5iTWZXXN3bkUF5xd/
	O5eQAqrWUvq5cBEGEm6SlOL04BCqLTCjJnAxAziDxbwaWepWh9Y9/M4qPNKQv8VCtAWivnDpZodTO
	6enf3EFn6VI7bM1kQ1ZXch0aN4J62WS4VuoE7BP5bTKZPegyZgejd1Pc3/VWCTxPArngyLL8knXyi
	95POxQNSuqxyNv2ZgGHXEMCFaGBZt5+/2KxDWFevihCAYhSYUg27I1qQe0t3USzYDkNjMb5NlcamS
	KKJ+fVT11C+/G6jVT9xfkfWwuVyeZXhCax7hssh7c8OgYAl7RjFsI7mu1g7FPTtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1wHJuP-0000000Erbt-3YBF;
	Mon, 27 Apr 2026 13:13:50 +0200
Message-ID: <640192308052e60589455505d31732cf2e00b1aa.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 0/8] Adding NO_STA flag and reworking RX link
 resolution
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org, Jouni Malinen
 <jouni.malinen@oss.qualcomm.com>
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 13:13:49 +0200
In-Reply-To: <01295135-6bcf-4567-869b-75597649d11c@oss.qualcomm.com>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
	 <01295135-6bcf-4567-869b-75597649d11c@oss.qualcomm.com>
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
X-Rspamd-Queue-Id: 43804471859
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35369-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi,

On Mon, 2026-04-27 at 15:32 +0530, Ramasamy Kaliappan wrote:
> [SNIP]
> The hostapd changes were made and validated against the relevant test
> cases. During testing, we observed some complexities in specific=20
> scenarios particularly when a Non=E2=80=91AP STA first associates as L1 (=
M1)
> and then reappears as L1 (M2) during the authentication/association phase=
.
> In this case, on the RX path, when an authentication frame for L1 (M2 in=
=20
> the ML IE) is received, the driver finds the existing STA L1 (M1) and
> therefore does not add the NO_STA attribute.

Yes, the address will be translated in that case.

> As a result, the complexity of handling authentication and association=
=20
> frames increases within the user=E2=80=91space hostapd application. While=
=20
> processing the authentication frame, hostapd parses the ML IE
> but fails to create a new STA entry for L1 (M2) in the driver,=20
> especially in scenarios involving different MLD addresses.
>=20
> To simplify this handling, we would like to explore an alternative=20
> approach that avoids address translation for management frames=20
> (authentication, association, and reassociation),
> regardless of whether the STA already exists.

I am not sure why that would be easier. Also, my hunch is that it makes
sense to translate the address in particular with encrypted association
frames.

hostapd receives the link ID that the frame was received on. So when
the address was translated (no NO_STA flag), hostapd can use the MLD
Address + Link ID to do a lookup in its own station database and use
that to look up the SA address that was used to TX the frame. So you
should be able to emulate the suggested mac80211 behaviour inside
hostapd.

Note that when a STA that first used L1 (M1) reappears using L1 (M2),
then hostapd cannot create a STA entry in mac80211. So the existing M1
address should be used to TX the SA Query to the old station, while an
explicit TX to L1 with the NO_STA flag needs to be done for the
comeback frame.

I believe that hostapd will need a bit of refactoring, including
improved tracking to know whether a STA has been inserted into the
driver and whether to TX the AUTH frames using the link address and
NO_STA flag or using the MLD Address.

> However, this approach may introduce backward compatibility concerns=20
> when either the driver or hostapd is not updated.
> To address this, we propose introducing a capability indication=20
> mechanism between the driver and user space (driver =E2=86=94 hostapd).
> Based on the advertised capabilities, mac80211 can then skip=20
> management=E2=80=91frame address translation accordingly.
>=20
> Benjamin and Jouni, Could you please help share your thoughts on this?

Right, I would like to avoid introducing a new capability mechanism
unless it is a real improvement for the hostapd implementation. It
could well be that I am missing something, but right now I do not see
that this is the case.

If you are still unsure, then I guess we should probably go back to the
list of scenarios we had and check for each one how it can be detected
and how it should be handled.

Benjamin


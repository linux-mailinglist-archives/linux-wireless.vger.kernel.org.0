Return-Path: <linux-wireless+bounces-34003-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOYBBydtxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-34003-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:30:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A77DE33925C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 184F03010B75
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0AF41C2FC;
	Thu, 26 Mar 2026 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gC6GIeVi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071041C2FA;
	Thu, 26 Mar 2026 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546211; cv=none; b=Ok3Xr713/MlOkNxGPaDhXTOiZg7kx6tJHEVknxkVTZjomPVBqtd5loKxSM0D1vhwppurBmyq7Wbggcj0mdD7LulkfI8tyfoyF2YTNop8jwhZkaI7GdPVmiEIwiDlNPHwQsSkpXgqn7EszePFMsUFwh5rC5dstzZJgWP44MBQKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546211; c=relaxed/simple;
	bh=DAU4SfHW0Z5kEwZHRmCMRMCWV+k23xpMa0Jz8WSqOAo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GzaNcdB1Mk3SKEamuLhshkDOJltMwq5rht69D/1dXem1IV9uwvtjwE8Xg02kBYdFI37919l2Aa/xpT9FC0U53jbzbC9PMpJ7Pjziprm4luSwV7a4ROTB6ShRAC3MagZgbvSWJ7gDlQ0MS7Vq70Zn2B8gAyW2tWrfDx8Kgdc9vaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gC6GIeVi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DAU4SfHW0Z5kEwZHRmCMRMCWV+k23xpMa0Jz8WSqOAo=;
	t=1774546209; x=1775755809; b=gC6GIeViZW3fLFFg5mAaSYcqYAKvfMGdtHJgdRpWjUcB5et
	uNXYm74tceWA716adlEAtH/uqzBgGiTKyEO70t8YCZvoSwC4zcQLoV36svU7DGCSqQuJWH4l5ehel
	N+a0oaHD4G3qj7QmDP02NOgadmOQKsSSvImnfJG4iybHvqlA89LmTcSgErvlcrD5pKfIHrA9Wdyn1
	j2dlD5mYLH0XnNOtRpX/v1NdJ7fFzrLK9XIy36f+PihgOvC2IeBGgpAyDyopo5PNWQ6irQ5knu06H
	rmdhcRzKwgGOrbsAtbmoefWnCGzFQsErh05cwmIHQIsYSQXbx6KE40hF+4yTFTQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w5oWu-0000000DDEs-0Q9U;
	Thu, 26 Mar 2026 18:30:00 +0100
Message-ID: <94dad6848516ffb71967c2832c923f153d14e5d5.camel@sipsolutions.net>
Subject: Re: [GIT PULL] wireless-2026-03-26
From: Johannes Berg <johannes@sipsolutions.net>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 26 Mar 2026 18:29:59 +0100
In-Reply-To: <936e4100-5e3e-4c3a-8598-6724d904deac@redhat.com>
References: <20260326093329.77815-3-johannes@sipsolutions.net>
	 <936e4100-5e3e-4c3a-8598-6724d904deac@redhat.com>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34003-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A77DE33925C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-26 at 18:24 +0100, Paolo Abeni wrote:
> On 3/26/26 10:31 AM, Johannes Berg wrote:
> > And ... more fixes from drivers came in, notably iwlwifi with
> > a bunch of things (their maintainer had been on vacation).
> >=20
> > I'm going to be on vacation next week, but I'm also not aware
> > of anything missing from drivers etc. right now, so we'll see.
> > I doubt this is the _last_ pull request for 7.0, but I think
> > not much more will come in.
> >=20
> > Please pull and let us know if there's any problem.
>=20
> Blame on me, I left this one out of my bag, and it missed today net PR
> for Linus.

No worries, I just wanted to get it out before I go mostly offline for
the next week, so it's not stuck on me :)

johannes


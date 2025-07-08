Return-Path: <linux-wireless+bounces-24950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B6AFCD64
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C29B561B6C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3774E2E0409;
	Tue,  8 Jul 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LIpXS8fx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787C12DAFCC
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984526; cv=none; b=F55vfthYcbZyO8zWAXpXR2EC2NCEj/dptKcCo1oU/aMUpsJ4aAMJ80pHXkM5CUFI7MdVAqECvu9L7dHr//d8s2IrFuWA+LuoZ0mXzizvsQoY7Z9sos0p5h1NHIt163nRfMx1tQQx3+EDKXjOSzF0f9r7xWMyci+l4HwAn74D7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984526; c=relaxed/simple;
	bh=C+95LPywiw45iM6Thec0WTc2/fU/rkYza6vGTNAvk1A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AezFFYFbfVWqrTCxurT4kZwEyFPO+n8Qtfn58qy4n7yaHlNmsbk4WS1h1D6WgHh5hh3VsoscrOnPyFozlevJuX/ucOfJ31ZKZrscmqWLqScGE9w9PlW7klmNRNC087OJrkm9NfAOTtBoC0+H/D7S+LkSp5ODnJybUJCizZHP1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LIpXS8fx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ErwCCaExMVh1L/n507cnMbkB5QL59KkKizjQ7vHrDOo=;
	t=1751984524; x=1753194124; b=LIpXS8fxw8eufbjbxpGqfxAU8LIDcUIrJwk61njqFDPUr8q
	MCeY/Lui2m33gkb88B/ds8md8uqZEBnVgLzLuKKjpWs0Xme81WROLoN7i5kVphQHI7GINnemOhM4/
	YVF8s4CnfNKmHQ/9r3zWWYBlbJkAxv/xGQLyc6MSa8Y4srWcOzOioN9BXzrUCqpHrGrmvRZvl/TUe
	tbktlHrJfVKXLOiHUxWi0DEjHzk7S94CHA+1i+zl/lMX0RH9M+R+UKcYuxt1F/Tgut+Kftuj362sC
	AsNiMcR3RR5wFDon0JGZCW1JppgQNYBFad+mM/hOhbAtCD0718cu0atd0wUBNWhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ9Co-0000000ByiU-3JVL;
	Tue, 08 Jul 2025 16:22:01 +0200
Message-ID: <dfc23d5813928b138ff531734f75d7190d7450db.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/3] wifi: mac80211: Assign tx-stats to the proper
 link.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless@vger.kernel.org
Date: Tue, 08 Jul 2025 16:21:57 +0200
In-Reply-To: <de881905-a708-4f96-b3dc-16d950322218@candelatech.com>
References: <20241218232519.3156080-1-greearb@candelatech.com>
	 <54ede5f58c3abc7de58010e492283c7930a2495f.camel@sipsolutions.net>
	 <de881905-a708-4f96-b3dc-16d950322218@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-07-08 at 06:58 -0700, Ben Greear wrote:
> On 7/8/25 05:31, Johannes Berg wrote:
> > On Wed, 2024-12-18 at 15:25 -0800, greearb@candelatech.com wrote:
> > > From: Ben Greear <greearb@candelatech.com>
> > >=20
> > > For drivers that can report the tx link-id, account tx
> > > stats against that link.  If we cannot determine tx link,
> > > then use deflink.
> >=20
> > According to all the RX stats discussion [1] you need some changes here=
,
> > so I'd appreciate if you could take a look and rebase/resend.
> >=20
> > [1] https://lore.kernel.org/linux-wireless/c22a9e7e-d0f7-477b-b732-c245=
4a0ac904@quicinc.com/
> >=20
> >=20
> > And please, as I very frequently keep asking you, don't mix different
> > things into a single patch (such as 'rep_packets'/'rep_bytes' in this
> > patch). By insisting on not splitting your patches properly before
> > submitting them you're effectively saying your time is more important
> > than mine, and I don't appreciate that. All that achieves is that I
> > don't even want to look at your patches.
>=20
> As far as I can tell, I split them properly.  I added new counters in one
> patch you reference above, and I named them as I think they should be nam=
ed.
> In another patch, I renamed existing variables with a commit message as t=
o why.

This patch said:

> For drivers that can report the tx link-id, account tx
> stats against that link.  If we cannot determine tx link,
> then use deflink.

which I think we can agree should be only a refactoring/fix of the link
that the counters go on?

But you also have

> +		/* Packets and bytes reported transmitted (per link) */
> +		u64 rep_packets;
> +		u64 rep_bytes;

which was probably meant to be in the third patch?

johannes


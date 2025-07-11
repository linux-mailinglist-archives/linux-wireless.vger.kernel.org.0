Return-Path: <linux-wireless+bounces-25250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA27B013D4
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 08:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9912B42401
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 06:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA91DFD84;
	Fri, 11 Jul 2025 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Od/xmrYd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF651DF270;
	Fri, 11 Jul 2025 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216101; cv=none; b=Bal1LrWTOrX0wdbRptGaB/1R/eCBzaCpIBALGYZKt5qHJN1B3jJ/BUu11or8AaAoMNe/xwj79bQBICO1aXGsw3hXVCetPxI8Szl+KjOmJhwSvGj63FtrIAaDERHvTfu7QMiKq0Guf4LGOW3svvlwpjQvBrsfmBVyaFvs8ZiJWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216101; c=relaxed/simple;
	bh=MuoVHYxiP3CguwhcMuD93jn4Hic03nlYbsEZIRVuPlM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aEve9uNNcP3/N7pffIkN8WP0Yb5so9Gmb8FkApIN/3D/O3PoHy+JrYZCxJExS5M+lREkqbbcgDbMytU1r3KHNVsRdYPrTQboTZ5rzdnOwGi0OKSWqWUqeJPQTgSAgqe5AzVfn9+OrjeEaLS0hApLOIdJ4msutHzoTOpRAxpSbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Od/xmrYd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MuoVHYxiP3CguwhcMuD93jn4Hic03nlYbsEZIRVuPlM=;
	t=1752216099; x=1753425699; b=Od/xmrYdCJeWKW4TGBjrOVk2ytC+LZDxF6lcqxijIatr3nQ
	AVWRLQXLL5+20H/ILB27lXRQK/8JlvzSklXs0UHPLVNLEUlbygx4EGmEUBYybxbxYhgBBDMqPO8Et
	5F7W4ADxVlE46sUzOqB9fdvJ7IDgdwU2ZBBh470PIlODDHf8m/1bIQcI/DbO/Ipr/hFuvklfIUT54
	qWAktE9/rrjFNg7MQ5oLJn/oyn3LZUJ759Ym7Ndl2lDlT5T5nhNdDyIH+e/ndrIMgttU5QL5y8yk7
	3/lB8DqBxlwnCx/9UHX7MFOSZsQg1EAHLQOZXk5b+KI8ElNKtYWspJHv5K89u/Og==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ua7Rt-0000000Fw63-0CV4;
	Fri, 11 Jul 2025 08:41:34 +0200
Message-ID: <934e5e1e253ee3025f617cc38ce6fc15e0619d6c.camel@sipsolutions.net>
Subject: Re: [GIT PULL] wireless-2025-07-10
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Fri, 11 Jul 2025 08:41:28 +0200
In-Reply-To: <20250710172352.3ccd34ec@kernel.org>
References: <20250710122212.24272-3-johannes@sipsolutions.net>
	 <20250710172352.3ccd34ec@kernel.org>
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

On Thu, 2025-07-10 at 17:23 -0700, Jakub Kicinski wrote:
> On Thu, 10 Jul 2025 14:21:06 +0200 Johannes Berg wrote:
> > So I have more fixes than I'd like at this point, but a few
> > were under discussion for a while, mt76 fixes were just not
> > forthcoming until now, and all of them really don't seem
> > wrong to put into the tree at this point...
> >=20
> > Please pull and let us know if there's any problem.
>=20
> Some good news and some bad news. Bad news is that this missed today's
> PR. Good news is that we shipped a bug to Linus which is likely to
> break nl80211 users:
> https://lore.kernel.org/all/20250711001121.3649033-1-kuba@kernel.org/
> so I'm gonna send a second PR tomorrow, with the netlink fix and I'll
> include your fixes in it. I suppose you may want to wait with the fast
> forward until then.=20
> Now that I typed this I guess it may be two pieces of bad news..

No worries, and thanks for the heads-up, I can wait. I actually really
hope this was the last pull request for the current -rc cycle anyway,
but of course now that I said it someone's going to come out of the
woodwork with a fix ;)

Re the size problem, nl80211 can indeed create and fill really big SKBs
if userspace gives a big buffer, which it often does. Looking at it now,
I'm not sure why we set the rcvbuf to 8KiB in iw? That seems ... odd. It
looks like I originally did that to _increase_ it, but that seems
completely off, and my first fix didn't even do anything. Then we fixed
the call but ...

Looks like the problem is entirely self-made there, but I guess we still
have to live with stupid userspace, sorry about that. I can take a
closer look at it all and try to fix things there, if you think it's
worth it?

johannes


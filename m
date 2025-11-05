Return-Path: <linux-wireless+bounces-28630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F077C36F48
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 18:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3043C681AC6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E83336ED7;
	Wed,  5 Nov 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="B9KZKD/f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537A346E56
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359318; cv=none; b=Kmghr/BZKIHciQOGO11mcDFKbylEfVfm0Cn4+pYCFNbH05q3aL/rS90qiAyeJJKLGgPW3eGAD6gd+lFbcaWvwgzpqiULnjiH7G8QE+GgWP9bXvUJhejebyxmeD5IzYX7qD6rTAxJdkLNLTt3IbXXBemtnve9y2DOFB1nTYhyqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359318; c=relaxed/simple;
	bh=F9ROTuBhmSaJElDlJEkZvV7cmlqgNJpfNWHLJ9QLuHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODxZutFbEy2V2kBTtq/8nkanMJlKHH6v4ylfkmOs9mILME/6gTDm6Fw0WS3CegsdfQ06JyAB/6Fxxke9+WRl+ZI8Ow8moHGSs/jR5saKkoL+oo5hMaQzJMeaheyc5O4dlhvnapwhrkwW6lIrTpWfz1kudV2WWQ7w2rnNphut+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=B9KZKD/f; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=F9ROTuBhmSaJElDlJEkZvV7cmlqgNJpfNWHLJ9QLuHQ=;
	t=1762359316; x=1763568916; b=B9KZKD/fmPrpoumOcsTa2za4kd0Xxn1tO69mdmF1I7mB3nN
	FA+Ek3SGI2Z6N2tO9o2/tYRx9OcjSgsHVIlSQbA01G5KUqSDgXG/07hzfiqf9O1fJahMXhHChYEv3
	TwJ8nPNAcjW/wO44O+vQqsl+UHhzpLbZTmfF2omPcgtCnzObhsX1A5YPGX3GRK/tkR+30fAOiAw0n
	3ca11NO7fHXKTR8GB5Vus48n6vmV5PDgNg9rbXVLMDb9bwo4tu+Cfq8fIoWxIofW+a5LqQVfjZFTQ
	ejx6wB7+GOZEtnxzCPzcXDzxwPCsgaN19OsGS2Y9N5QaPvyzpSL118ffWlbC9I3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGgAD-0000000FPNT-1bWB;
	Wed, 05 Nov 2025 17:15:13 +0100
Message-ID: <e10958bc500acbf514ef664387d1df61a065a70d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 00/57] wifi: inffmac: introducing a driver
 for Infineon's new generation chipsets
From: Johannes Berg <johannes@sipsolutions.net>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: linux-wireless@vger.kernel.org, wlan-kernel-dev-list@infineon.com, 
 Carter Chen <Carter.Chen@infineon.com>, Owen Huang
 <Owen.Huang@infineon.com>, Ian Lin <Ian.Lin@infineon.com>,  JasonHuang
 <Jason.Huang2@infineon.com>, Shelley Yang <Shelley.Yang@infineon.com>,
 avishad verma	 <avishad.verma@infineon.com>
Date: Wed, 05 Nov 2025 17:15:12 +0100
In-Reply-To: <aQr1eO-5Gmg7JSf2@ISCN5CG14747PP.infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
	 <4d46dfb13927a878f5684e9e8cfc51673e8df4b8.camel@sipsolutions.net>
	 <aMqm-soAc5tzHQFf@ISCN5CG14747PP.infineon.com>
	 <3cb0e7a95fdba1ee1003c10606fd58e7b9071c58.camel@sipsolutions.net>
	 <dc5017d0e4eed59905597f000a11887e9e264eb9.camel@sipsolutions.net>
	 <aQr1eO-5Gmg7JSf2@ISCN5CG14747PP.infineon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-11-05 at 12:28 +0530, Gokul Sivakumar wrote:
>=20
> In V1 INFFMAC patchset, we already skipped including few other Infineon c=
hanges,
> to avoid overwhelming the reviewers. Even still V1 turned out to be bigge=
r
> than the expected size for code review.

Well, the patchset isn't even self-contained, with random cfg80211
changes thrown in. You cannot bury such changes in "this is my new
driver" patchsets, I'm not sure why you even considered this acceptable
before posting it. If this was the first time you're showing up to the
list I'd simply ignore it _completely_ (like the weird new Android
driver that showed up recently.)

> Not including those other Infineon
> changes in V1, would have given a misleading impression that both brcmfma=
c and
> inffmac are similar.

I'm not sure I'd call it "misleading" when it's >50% identical code?

> But they are quite different and it is not feasible to
> add all the Infineon new generation chipset specific changes to the exist=
ing
> brcmfmac driver without severly impacting the existing users.

Sorry, but no. You don't get to give us the spiel about users. _That_
problem is entirely of your own making, because you decided to go out-
of-tree for a significant amount of time and not discuss with the
community about how to approach this. Then you gave that non-upstream
version to the users and now you think somehow that entitles you to dump
it on the community as well. No. I have no sympathy for that all, you
don't get to make that upstream's problem, own it like the problem of
your own making that it is.


But look, I get it, you don't want to be tied to the "Broadcom legacy"
forever. And that even makes sense. But from what I can tell you've
basically taken brcmfmac and bolted on random changes. And you worry
doing that to brcmfmac would break others, that's not too far-fetched -
welcome to working with the community I guess?

And while I'm sympathetic to that, just like NXP with mwifiex/nxpwifi
you don't get to pretend that an ancient brcmfmac driver with bolted on
Infineon changes is "state of the art" in any way. You'd need to show
that you've actually done some homework on this new driver.

We know from the long discussion about the p2p device crash for example
that the way brcmfmac grew did definitely _not_ end up with a well-
designed system. With a new driver you should be able to re-architect
things to fix these issues more cleanly, such as improving the dynamic
vif handling etc., but ... it doesn't even look like you ported *your
own* bugfix for that to inffmac!

And as we discussed with NXP, things have changed since all of these old
drivers like mwifiex or brcmfmac were integrated - their current state
is definitely not something reasonable today any more, just nobody has
really maintained them and we keep them (vaguely) alive. Your code feels
to me like you think copying brcmfmac makes a good driver, but in case
it wasn't clear yet: it doesn't. There's a lot of new infrastructure
like wiphy locking and wiphy work in particular that I think a new
driver should be using or have very good, documented, reasons for not
doing so. Copying an old driver doesn't really cut it in that respect.

> We are currently working on V2 INFFMAC patchset to remove some more featu=
res
> to reduce the codebase size for easier review, as you suggested earlier.

And then the next step is to take a close look at the architecture, I'm
especially interested in the locking architecture, as I mentioned above.

johannes


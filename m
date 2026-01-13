Return-Path: <linux-wireless+bounces-30737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3EDD173EF
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E1630142CF
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9737C11D;
	Tue, 13 Jan 2026 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BD+W3o0z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F736BCEE
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292319; cv=none; b=brDqxbfuoY9nFrwrvYFsoU0I1lIthcqz0ejHLbzmj9cCp/jFV7IxUHjDdM/wOYAGN/tipDm3GVFvbpfrRT8KOu3hYiaO5DKJ0ss1M4xarHeWfVt3dFkHKxUMLUFVTDWmSjLT7kl1r5oSZ8C6HgJMWZju8XqPZ4HIc3+gNOCKFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292319; c=relaxed/simple;
	bh=Cf3dMf3PjJTG+VTIJBoBWP5Cbo00hozBy5WosqZ0ce8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDe9dJdbwJg7DQIToVpzWxZhjWuPylCiUDZDI39z6hW0lpRbfcnQr/hsS6dWu4A3Z31aTGgQR48vnVGVw23CvccJJlP0X7TH5J+6ay5mmDhyD5BoXzRLArDwy5DrDiOOQZIVRwp5e5axjZpduHzyhDeVpc55CO9d0RK3XiynLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BD+W3o0z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s0zFsOTJ2A+bokYjIBoAIHrUqnyo2pW0Aan5pUbqA5s=;
	t=1768292318; x=1769501918; b=BD+W3o0zGRAgdyURjyIIOjimfGcy2vpZW9pIeJy20aZoVz5
	/BPtRUUplfQJ6VAFq3O8tYierIgM09MxCgF3wdBIA7SJ9AnJELJ1gMfQxHyrOqed5b9T9vdTosMFG
	4qiGnBvN5SbiXSK+hE6QEM0uMZUYuZAqwGDoWd/3xGFHRz+RUdTM4iisH7w3i6+4ACJtzIYWjG8ON
	HRHsz27aevm0JUHMykr6vwRi8Maz/SGPbfieuJu4miRZzbtJJB8wGEWyYDPpszoL91TfPQW0ZnKxd
	aL36r6eK2gQHhVW11nA+DRFWyrdy+r/jb11sQ+Dx6yvCMXf3hXoBiPwxm58wJpZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfZbo-0000000AfiI-0FJj;
	Tue, 13 Jan 2026 09:18:36 +0100
Message-ID: <14bc5d3362b071c7c7a6a64724d5b354c173a501.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: cfg80211: don't apply HT flags to
 S1G channels
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Tue, 13 Jan 2026 09:18:35 +0100
In-Reply-To: <csqd3cp5twlhfsrkrppe25q2xby6wb37fhtxfrzgffjzoww2hw@xcixpwzlxzmi> (sfid-20260113_045629_499851_3DEE4B54)
References: <20260113030934.18726-1-lachlan.hodges@morsemicro.com>
	 <csqd3cp5twlhfsrkrppe25q2xby6wb37fhtxfrzgffjzoww2hw@xcixpwzlxzmi>
	 (sfid-20260113_045629_499851_3DEE4B54)
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

On Tue, 2026-01-13 at 14:56 +1100, Lachlan Hodges wrote:
> > 925.500 MHz (Band: 900 MHz, Channel 47) [NO_HT40+, NO_HT40-, NO_16MHZ]
> > 926.500 MHz (Band: 900 MHz, Channel 49) [NO_HT40+, NO_HT40-, NO_16MHZ]
> > 927.500 MHz (Band: 900 MHz, Channel 51) [NO_HT40+, NO_HT40-, NO_16MHZ, =
NO_PRIMARY]
>=20
> So something we have been thinking about while we test the implementation
> against usermode software such as OpenWRT, and not just hostapd,
> is that we don't have an equivalent to the [HT40+/-] flags. Now while S1G
> obviously isn't HT and while this doesn't affect the actual regulatory be=
haviour
> as mentioned in this patch, the information conveyed is still very useful
> to usermode as usermode itself can restrict what's allowed.
>=20
> However looking at the regdb, it appears that the notion of HT40-/+ is mo=
re
> or less a "cfg80211 specific" regulatory componenet where the adjacent 20=
 MHz
> channels are validated to check if bonding in that direction is allowed (=
please
> do correct me if I'm wrong)

You're not strictly wrong, but it is additionally possible for self-
managed regulatory devices to have these flags, and I believe it was
used for early Intel devices in some cases where the firmware doesn't
"like" non-standard HT40 configurations.

>  which is more or less equivalent to what's done
> for wider VHT channels and S1G channels as per this comment aswell:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* TODO: What if the=
re are only certain 80/160/80+80 MHz channels
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*       allowed by =
the driver, or only certain combinations?

Yes we've basically ignored this, in part because drivers tend to
support non-standard configurations too. For 6 GHz we've restricted this
to only standard configurations, see cfg80211_valid_center_freq(), and
then we don't really need the flags...

So overall we don't really need the flags - 2.4 GHz has the HT40 flags,
5 GHz doesn't typically matter in practice, and 6 GHz we just always
limit to the channelisation the spec says.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*       For 40 MHz =
the driver can set the NO_HT40 flags, but for
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*       80/160 MHz =
and in particular 80+80 MHz this isn't really
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*       feasible an=
d we only have NO_80MHZ/NO_160MHZ so far but
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*       no way to c=
over 80+80 MHz or more complex restrictions.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*       Note that s=
uch restrictions also need to be advertised to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*       userspace, =
for example for P2P channel selection.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>=20
> (13 years ago!! :-))

:)

> Playing around with some 5 GHz configurations in OpenWRT it appears that =
only
> so much information can be conveyed and indeed there are configurations t=
hat
> will be rejected by cfg80211 (or maybe hostapd in some cases, not sure).

Really? Got an example, perhaps even with hostapd log to see how it's
rejected? That clearly contradicts what I wrote above which I really did
believe to be true until this moment ;-)

> I
> suppose what I'm asking is - how much do we need to protect usermode from
> this? Do you feel it's worth including a flag that somewhat emulates
> NOHT40+/-? I know much of that logic is quite old and S1G is "modern" ...=
 ?

It's always nice to have userspace be aware of things, but I guess if
it's a configuration that's statically known to be invalid, it wouldn't
matter so much? But I don't think I've understood the S1G angle - are
you talking about primary 1 MHz? Primary 2 MHz?

> --
>=20
> Now on an unrelated note while I'm sending this email, we've sent a few a=
dditional
> fixups / cleanups over the last 2 months as we hope to have a driver subm=
itted
> for review in the coming weeks. There's still 2 small fixes that need to =
be
> done within hwsim before we can send up our hostapd patchset but I will
> wait until we have at least kicked of the driver review process before se=
nding
> them.

Very cool! :)

We just posted a lot of hwsim changes for NAN - better send yours sooner
rather than later ;-)

johannes


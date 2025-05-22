Return-Path: <linux-wireless+bounces-23298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB915AC0944
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 12:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BDA3AB7B7
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D98288C22;
	Thu, 22 May 2025 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mY7VQbDM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEF1C3C04
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908098; cv=none; b=e0EROnahC2lsW1KAx3tR0zHRDQx4tAwq5t/Z/iPLT1uYu+oSbZyj3o2vw8cd2vY2znSYQFtD4r2PXFYpz2wc/d+za/u52lx6kyrQL2fvSQXOq/iUsuihsuRCc2HKqtEKH21F11dBzgdF4hkArDbiEshfJlJgfZdx9/6Fm2fEbw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908098; c=relaxed/simple;
	bh=TVHQtMb8LNCnKKtdelQvIbUnVfSLPYWx5INMM+zZtAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g4uT12djdkW+sFWfH2zLHwbH4M6OME97WIqLzTPCoVOkddsP5CIHS2r2e9d6FA7AxZiW6cJiZyo/d4Jmh3LqzpeaWf+anlWwV3+RJs5BLpT7M1BCkK0vz2ZJNy/fL5a6y6ab31HD3zrdJsodYI5T4leBSkanuuZLxKUq2BBvFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mY7VQbDM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TVHQtMb8LNCnKKtdelQvIbUnVfSLPYWx5INMM+zZtAQ=;
	t=1747908096; x=1749117696; b=mY7VQbDMINrpjZf9hbOqOgsnOxRp6/ATgktUQirYWWBOUyt
	bmmOxPlRT0bXzf8K1P0iCgqsf1DbcM6yMmkk3sBH2mUEwmqV9FywSvMooSLKAE6B807W6+tjGir0G
	/rxwr/gAZzltpGIV346B3/BLhUBdVtHamZhoZhgZzewaJPI9Ij0ZLkj9TxolHrQuO+Z0mGF0W2vzz
	ytt0ttq3i9H4dUSLLAF95y819a/yioghFNMpWGyFoC2NGx3JElI142Pc9Yb4S4aPxdHtiyHJzvAAy
	AbykB6rOSqciUY7IeVKqxQh+xV1CjJLCf7+eCSkGle8WTvhmBxwHP7Q6d3onp5lw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uI2k1-0000000Gcrj-18b0;
	Thu, 22 May 2025 12:01:33 +0200
Message-ID: <5ead0c2ac031ecf225011ac4bceba755387fc918.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 03/10] wifi: cfg80211: extend to embed
 link level statistics in NL message
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 22 May 2025 12:01:32 +0200
In-Reply-To: <472f06ef-104c-44f9-be8f-5b077c958f43@quicinc.com>
References: <20250522085601.2741458-1-quic_sarishar@quicinc.com>
	 <20250522085601.2741458-4-quic_sarishar@quicinc.com>
	 <9be5a453-730f-4ed9-b9fc-1e703f38f9f0@quicinc.com>
	 <c8a6f706bc0aec46f7619ba3eb373f13d0c94969.camel@sipsolutions.net>
	 <472f06ef-104c-44f9-be8f-5b077c958f43@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-05-22 at 15:27 +0530, Sarika Sharma wrote:
> >=20
> > Probably not, though maybe we do want the link addresses in the station
> > delete message to userspace?
>=20
> Then may be reporting station data will work here?( already happening)
> As overall station is getting removed, not just any of links.
>=20
> If really a use case then can allocate memory for link_sinfo as well=20
> during the station delete?

I don't know if it's needed, we can always add it later if so?

And maybe we'll rework the allocation anyway so it's on-demand.

>=20
> > But the warning was just an inconsistency issue - why should users set
> > the valid bits for a link but then not have any link data? That seems
> > wrong?
>=20
> It's not exactly incorrect, since there's a scenario where memory isn't=
=20
> allocated for link_station (such as during station deletion).
> Perhaps we could add a comment to clarify this behavior?
>=20
> Then either way, if really link_sinfo required to be reported(for link=
=20
> address), then need to allocate memory during station delete for links.
>=20
> or if need to add WARN_ON_ONCE(), can reset valid_links during station=
=20
> delete?

I guess I disagree and still think it is incorrect, it means something
(mac80211?) set up the valid links bitmap but wasn't able to fill in the
data. Why would that make sense?

OK, maybe there's a conceptual difference here. I'm reading the
"valid_links" as "for this specific statistics structure, these are the
valid links".

If you read it as "for this station, these are the valid links" then it
makes some sense to have the valid links filled, but no statistics.

But I'd argue that latter interpretation doesn't make much sense since
to userspace they look exactly the same. If we had say the link address
outside and then the link address would be there even in the absence of
statistics, it'd make more sense, but that's not how it works?

johannes


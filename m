Return-Path: <linux-wireless+bounces-23217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2ADABF07D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82247A1366
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5D235BFB;
	Wed, 21 May 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fleSEZsG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0F259C8B
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821138; cv=none; b=bhSMs1C5qDhbrfzzKbolLOrNknCDjE6wJNLjr3+MS85qw+mYKLmbLAS1QCT8avd5mSJ4B8AFfSONLTii5tqlczbb8x2O7QP1/O78wRcWqKu9z5Kpi0CdQMWsBm0pmNMpdVg8lfZw3n5WXUcSysUDZIuasxB9Gh2WiTcne0tveGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821138; c=relaxed/simple;
	bh=1pnUL06rAFyf2JWJ78uECPPyY/BP0DJEO3WPpqLjwmw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDNa2glI4qLqrwa/BORm4HykqYaVI6hH9N68NJc25L0YJolxmSmxHhiUX8FDYA0Uq3naWzTss6wRcoBTdlcRbXlPc6UL9oGeYFoOToJ4zvrRgohwn+JqUN22p2QxLGoH6JlPDz3K8I+TB7golyWqe+O+7LwvmzryKl3E7KE61nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fleSEZsG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1pnUL06rAFyf2JWJ78uECPPyY/BP0DJEO3WPpqLjwmw=;
	t=1747821137; x=1749030737; b=fleSEZsGvw8do8B6utPqqAqzpe1dZ42AUNlHekB3OfS38dr
	jp+ZPHg+frzsgtddGvfmuJ54XzECNfi/kl0h2Ny3bj9+FkHKZ6bLbWwgkfDsjoKwrBQ1kEUBA3LP1
	64LJClWkghMN65IjYv1fDnCEhf0EB6EgTcbE2B3pOLKHjK6gUktzFzq382PxkKPDUvMzMXDenFnFs
	vnRlwjub3OZNkCvEL/dvM5uXtXemuFnrwqt26KXtnOcrvn1gZ1SfZGE9ucsYpWt+7EtZCSraFDXdW
	sZmn1gx5qnmJah/zoxCmkocxZjAIrXYDb+uYdWjxSIh+37h8lnor/bj6xoIhDYSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uHg7S-0000000EDF1-0HI5;
	Wed, 21 May 2025 11:52:14 +0200
Message-ID: <4825b1cf6d59570d9bb3f03b500023bc2574c19d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 21 May 2025 11:52:13 +0200
In-Reply-To: <beae7cfb-03cf-496d-94b8-45425b1aa44c@quicinc.com>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
	 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
	 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
	 <3850d61a-8c6d-4cb5-b56b-d53a4a8afd32@quicinc.com>
	 <6ae5c6bd10fd7eade50bba846a701ba5846bf811.camel@sipsolutions.net>
	 <6c4fd852-c70a-4d7e-ac34-3a7f375b98ab@quicinc.com>
	 <78e46648e8bbaec139df2a3d11a2408fe5973afb.camel@sipsolutions.net>
	 <694e3a16-c2d9-41b1-8f6f-033c6b1ef0f3@quicinc.com>
	 <157dd058a06a2f111c52459610b0de7057a5d557.camel@sipsolutions.net>
	 <c2c54fbf-c9d5-4a4c-982c-dfcd5b6d9624@quicinc.com>
	 <4c9a74c436bd14b49fc9a15e7f9c68cb446baa84.camel@sipsolutions.net>
	 <5ea169b9-8f63-46b7-8f48-40d8caf97ac4@quicinc.com>
	 <6341cc8198b7054f9242821d8a7db2d2f12b92eb.camel@sipsolutions.net>
	 <beae7cfb-03cf-496d-94b8-45425b1aa44c@quicinc.com>
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

On Wed, 2025-05-21 at 15:03 +0530, Roopni Devanathan wrote:
> >=20
> > The internal "all radios" (and otherwise invalid) value is _never_ part
> > of the API. Quoting myself:
> >=20
> > > In the userspace API we have an attribute that can be in [0, n_radios=
-1]
> > > or unspecified if no specific radio is intended, which is how it'll w=
ork
> > > with existing userspace anyway.
> >=20
> > So no, regardless of the value (and I still think -1 is better), this
> > define simply doesn't belong to the nl80211 API.
> >=20
> I am not sure where to define NL80211_WIPHY_RADIO_ID_DEFAULT other than i=
n nl80211.
> Can you point out to your expectation?

There are different APIs involved, right? Externally, nl80211, which
doesn't know about this. Internally, cfg80211 and mac80211, though it
stands to reason that since they're necessarily layered, mac80211 API
can (and does) use cfg80211 definitions a lot - but of course not the
other way around.

I'm not even sure we really _need_ such a define, we probably have a lot
of places that just hardcode -1 (e.g. invalid link), but if you want
one, given the above, it would live in cfg80211, right?

johannes


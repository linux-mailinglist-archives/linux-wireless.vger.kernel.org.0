Return-Path: <linux-wireless+bounces-16587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C18E79F79FA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC8016B092
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BF9223332;
	Thu, 19 Dec 2024 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="emUhmYKe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF2223E6E
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734605991; cv=none; b=FAg4PN+sq4vz8Nkoen93T/hTBli2cZEEt/gvKC4x8zuGiMnF5ukTUE3csITv3SU3d8u4MxIuLzHYSOT6HC6fJit6E7d8QmXVfxRzzZdbVzdB3t1BgZd7+8koiMjQCckuLtABdyrI8JumWvxgi/M7PvfZTUln9WnrJoNWu+xMLAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734605991; c=relaxed/simple;
	bh=gKCoMIfFk1pC61s2rY1HMSVIRLVAIIyt6HraRcu653o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rvJnrZZmhoA3CbU6uhVujXnNYQXc5uneccES9ZFNGhlsQ6AsHtdYElMT34AkjTTATeK/cWhCMqRlDTKXLoBsSv9XeXArnCyTbMXxUacvoYdqlCa+rBbxebwUOTqteiNQvqJcs1G3BREOpWOoXjPDw/Q/bZnJBAkBcIjb1QqLh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=emUhmYKe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gKCoMIfFk1pC61s2rY1HMSVIRLVAIIyt6HraRcu653o=;
	t=1734605990; x=1735815590; b=emUhmYKeN6gzKQlSS32pJZ2zXZBR/ZC6Xr/aBP2bATMmlOj
	Uo9H21ctIq9drBxjDx0qI96Dsm4zI437G1A+j5FJu7QroPe3wMSC0c0qazrDy0LLAczvjOB3zNgYg
	n4guPnaxCKBXISJfzvxRwEL6nIg8amD7EZprJwnfhv2KSIUzckYG65WBfpM6eATR/wBZK1mf2kFjw
	zorDMuyRBALN732qjhUAUOfjykWOBZdKXdR3j9/cRHSA/eG2ItD3af4Y2Br9QyYu1vZsS26rEFHJ8
	RyLbJZENS05hYxkGI3ZDRc5iFIi8tMR/qJobsgcInKeRPXh4bUhuOOxL29aKwN1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tOEFu-00000004EV3-2gx8;
	Thu, 19 Dec 2024 11:59:46 +0100
Message-ID: <91fc1c1717646a8562ac2a74c4e2d9928a145171.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: cfg80211: skip regulatory checks when the
 channel is punctured
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <quic_kkavita@quicinc.com>
Cc: linux-wireless@vger.kernel.org, quic_mpaluri@quicinc.com
Date: Thu, 19 Dec 2024 11:59:46 +0100
In-Reply-To: <bfe298e3-c096-4426-a948-c4a67a5b8db0@quicinc.com>
References: <20241125051624.29085-1-quic_kkavita@quicinc.com>
	 <cc95ac5eb124ff46484a44beb0e2ec300d1d6392.camel@sipsolutions.net>
	 <b4c7a1b1-86cf-4c06-b7ee-21f2f6333dec@quicinc.com>
	 <81f864e1fcc1c226763273dec915e43f1fe14f5f.camel@sipsolutions.net>
	 <bfe298e3-c096-4426-a948-c4a67a5b8db0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-12-19 at 16:27 +0530, Kavita Kavita wrote:
>=20
> On 12/19/2024 2:31 PM, Johannes Berg wrote:
> > On Thu, 2024-12-19 at 11:35 +0530, Kavita Kavita wrote:
> > >=20
> > > The for_each_subchan() macro will not work for this. When sub channel=
 is
> > > null, it will terminate the loop, but in this case, we should continu=
e
> > > checking other sub channels.
> >=20
> > Wait, I'm confused by what you're saying here. The for_each_subchan()
> > macro should iterate over all enabled (not punctured) subchannels, so
> > why would it not be applicable here?
> >=20
>=20
> So, In the following regulatory checks: cfg80211_get_chans_dfs_required,=
=20
> cfg80211_get_chans_dfs_usable, cfg80211_get_chans_dfs_available, and so o=
n.
>=20
> When iterating over primary or secondary bandwidth, if we encounter any=
=20
> null subchannel,

What do you mean by "null subchannel"?

In all of these cases, if you have e.g. the following 320 MHz channel,
where "x" indicates removed by puncturing:

| | | | | | | | | | | | |x|x| | |

then of course it should iterate over all the non-removed 14
subchannels, not just the first 12?

> the loop will terminate, and we will not check the=20
> remaining subchannels.

As you write it here, that seems wrong for all cases?

johannes


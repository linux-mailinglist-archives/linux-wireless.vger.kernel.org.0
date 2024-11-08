Return-Path: <linux-wireless+bounces-15134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78DE9C1878
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 09:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22D9B214CF
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 08:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F391494D4;
	Fri,  8 Nov 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xJVx9OTX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3605D1D2239
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056009; cv=none; b=emuuxvf1VjuZdneBs/7UYltDTwaychnhq4s3tyOoBP2DjzxdnOx9vt5nKgTyfjYO53X82E8WOHzP2n5TYR/tZZW/FDQay8Vw0d7L3RQkYPIW9K3585o5US5sskYOWIcKD5I0+VZoLx5aCUn6A3Q9CnF+YafZmsXSmXRzjHiu3Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056009; c=relaxed/simple;
	bh=6lPfrBc8+nFDbY5JWYJv3Gk+TLsNIXQIlMw46crNHUc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duDi41DEYzvxoIkdbm0h2WPMRPu4UzBIaJIIpdkWd7uOAL2uUk0neVXS7+T51jqw23tKnjh3NDJM1/9A4Yc2H9uqOI2DdJHuopFkzVe01o7xS2mDEXLVeYQ2tXDtkJLRnF9rozwdRVe45zJigNc6jqB0iShPslTfM9+wu4IA9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xJVx9OTX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6lPfrBc8+nFDbY5JWYJv3Gk+TLsNIXQIlMw46crNHUc=;
	t=1731056008; x=1732265608; b=xJVx9OTXIHrDXKRyI/JUHN0VMN4eh2/gy/NuYKvFwDrcvEA
	BR1i1hx7LSxMSAjfIpxPX1s95VmqgwzlR64qnX87Qvo2DtdvRb2rnJyMeFjBwVdanB2gIKCMQX129
	m/RXX/28XKYT3AZCPEg1LsPq7qmxQsXFJ2VKHEq6HxMehU8tmD8kP8C3HNpun0yhbbNZCntiWIiba
	Q1oFh/fn0wP+5HPBalilwDCmDhvgoOfb6++maX3WPsS6gM0XQ8QanQ153g5cMuvB/Tj0QbblKZgsp
	tF3mGOw8DOvUn9E/kANsG1YIN6DWKcbdS+eXuB3rjXKJrZ8UIIuSdSKljwD2cifg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t9Kk8-0000000HBLx-3ii0;
	Fri, 08 Nov 2024 09:53:25 +0100
Message-ID: <ebee86ca2fb1e4a2b166dd98f8762218a468918c.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: nl80211: allow MBSSID Tx VAP bringup without
 MBSSID Elements
From: Johannes Berg <johannes@sipsolutions.net>
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Fri, 08 Nov 2024 09:53:24 +0100
In-Reply-To: <20240731122201.2635010-1-quic_ssreeela@quicinc.com>
References: <20240731122201.2635010-1-quic_ssreeela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-07-31 at 17:52 +0530, Sowmiya Sree Elavalagan wrote:
> From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
>=20
> Current implementation of MBSSID configuration parsing mandates
> MBSSID elements for Tx BSS (index 0). However with ML link addition
> it is possible that Non-Tx BSS'es can be added at a later point in
> time after Tx BSS is brought up. Hence allow bring up of MBSSID Tx
> BSS even if no Non-Tx BSS are present at that time when EMA is
> disabled. Later when new Non-TX BSS are added TX BSS beacon can be
> updated with MBSSID Elements.

So ... I've been deliberating on this for a while, because I really
couldn't convince myself quickly that it's correct.

And now that I look at it again, I'm again unsure whether or not it's
correct, because now you can have MBSSID w/o params->beacon.mbssid_ies
set, which has certain consequences, one of them being not setting
link_conf->bssid_indicator in mac80211.

This might not matter too much, depending on the driver, but it feels a
bit inconsistent? Also I worry about something expecting the pointer, I
guess.

(There might also be a bug in mac80211? The bssid_indicator isn't
updated when MBSSID disappears entirely?)

I feel the MBSSID code here is probably too fragile overall, maybe you
can find some time to go over it.

That said, I was discussing it with Benjamin briefly, and he realized
that you could just include an empty MBSSID element, or I think in fact
zero-length element data in the nl80211 API. That way, your code also
works with older versions, because you have num_elems, just that the
data in the elems is 3 bytes (empty MBSSID element) or 0 bytes (none at
all).

johannes


Return-Path: <linux-wireless+bounces-16605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B99F7AEC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 13:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAA0165833
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC1A222567;
	Thu, 19 Dec 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EVJ20Y+b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404622145D
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609923; cv=none; b=F5Eb5jv9QMWsQXh8gnpw9SXksqDeWhLIkRI7Z1KYYZSudy5MWr6BUw4Bo9c0Tb0EWEQmf+8EwzNo7+aM+BV8qV0MBDLoKYrSn2FqTgsD5DC2VcAsKxs3Ms9uCMYq9sTzgyiKYZtAg4cWDJcenp76b7nxLbcZqGcLbPUziRlswbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609923; c=relaxed/simple;
	bh=oiO9UORFm/R6qhEkRP1PmbzhWs4VOrRjIcvyqi4oWs4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eicDkYYh4YMw5g/L2QwPhpXWxslkZWv1yRqP+YDUyXZREBVoUv1dC0DNHdBW5R/xn0ZOZ4js2Nd8kEItDXyPcu9VAZbZvtshJsVr+GvlZo/6/KHVHuT2MgROtHz5SQNQXeFnOf1V127GLraslfAcSb8ya3YoofwYEUGKH4gKutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EVJ20Y+b; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=l5eymMEiXnEMlh9XK3WXJSh+gzXj8GaNbGL39TEzDJU=;
	t=1734609922; x=1735819522; b=EVJ20Y+bqPDjhy/JRW2ewMbYgkh8h3N02cG3YxdNm3JnvMq
	8IH+Z5MRolq4+COVyCSfWDyba/DAOjhdhXqIM6KaU8lXvc1VcO4iG8oZDUcAXqIN4h3z1C0PG0RFy
	7EnaAUxcBf8dwXgs+Ao7hpfG8/ehaQ/If9ADTsewS39ZaHQAIh/CDq+KbjW9Cc30bmGyU4fc1Uuxe
	9EijiBGhGFvpJ+7i4xRd7y+NaxKjZqC1W74oiH9XIcrQHMUsvRrFRkQPAlajJagGX9K5JiYpVLoLi
	gw6nh0Xxn8zHde0Dx79IkD2xC5/V3uhTdfe6i7xhciiFc4trHlTfv5gVTa7SQ05g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tOFHK-00000004GhZ-0oiW;
	Thu, 19 Dec 2024 13:05:18 +0100
Message-ID: <b368631e95d8171df90daa31b357e09d54294fcb.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: cfg80211: skip regulatory checks when the
 channel is punctured
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <quic_kkavita@quicinc.com>
Cc: linux-wireless@vger.kernel.org, quic_mpaluri@quicinc.com
Date: Thu, 19 Dec 2024 13:05:17 +0100
In-Reply-To: <19e73db4-921a-4ccb-8f31-0c9a960933af@quicinc.com>
References: <20241125051624.29085-1-quic_kkavita@quicinc.com>
	 <cc95ac5eb124ff46484a44beb0e2ec300d1d6392.camel@sipsolutions.net>
	 <b4c7a1b1-86cf-4c06-b7ee-21f2f6333dec@quicinc.com>
	 <81f864e1fcc1c226763273dec915e43f1fe14f5f.camel@sipsolutions.net>
	 <bfe298e3-c096-4426-a948-c4a67a5b8db0@quicinc.com>
	 <91fc1c1717646a8562ac2a74c4e2d9928a145171.camel@sipsolutions.net>
	 <19e73db4-921a-4ccb-8f31-0c9a960933af@quicinc.com>
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

On Thu, 2024-12-19 at 17:29 +0530, Kavita Kavita wrote:
>=20
> For example,
>=20
> Please refer below Implementation of cfg80211_get_chans_dfs_required:
>=20
> for (freq =3D start_freq; freq <=3D end_freq; freq +=3D MHZ_TO_KHZ(20)) {
> 	c =3D ieee80211_get_channel_khz(wiphy, freq);
> 	if (!c)
> 		return -EINVAL;
>=20
> I handled this above "if" case within the macro itself, so when this=20
> case occurs, the loop terminates and does not check further subchannels.

Oh. Hmm. I'd be surprised if we don't have anything that checks for this
elsewhere and we even _need_ this check, but I suppose it's possible and
then the macro should actually just have a NULL channel pointer for one
of the iterations so the user can check?

johannes



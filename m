Return-Path: <linux-wireless+bounces-8029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDAB8CD895
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 18:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E821C21683
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE311804A;
	Thu, 23 May 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nRZ+CIAV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D12C6B6
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482516; cv=none; b=PkW40Vv9EePUp09MfFy4k2tnn3qQGDHMPsuRCB9ng0vogtjJ4QjJKF10/KaDlVYz0bjzFyzwjGy0GZkxQXsVc0R+MG6+TlFk4mQttTmR8gOS1RonungglJ2K9M8Omyfs84xl4AWcoCIc3hWDKG+dT8uWFVp6z0TzZaV/PS+rO0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482516; c=relaxed/simple;
	bh=dUNMhSfcsZzZ+4SrDEiidjrks5CH3D/PEvNzaiYNfWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugzbnrMA88pv0i5hsg96AWUqEejxQYqJa9EDr9WgW2iEJfgNyyEhG0h/L0JYc3OCalpkql66jf7vW+M+8SJTySSwhq1fHbWWjd3C33dt9wDvuvz92SnqeXUcDsjZnfRD9dS+x9B7Ayr0WrCipWidMRMxyZbFl5uZLKzVDD3AfV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nRZ+CIAV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dUNMhSfcsZzZ+4SrDEiidjrks5CH3D/PEvNzaiYNfWI=;
	t=1716482513; x=1717692113; b=nRZ+CIAVoHlO3H0n4C+41u6i2FowEZ+tnAQbDOICfYk6LG+
	gA7k71UcJrUyUBZYFLKzO5GzCqtIXPfRUDUJTnUGLdDuuLI57q7ccBAa5YnOUz3E1dqe2kpBWBZOm
	6KbKf6CwL2i0fqz+zIFnFREYSx/fGLFWmOYTy3aMjpar7yVOSS1TNR6PU8OGK1TUNi1IIWuj5PHws
	fEtR0Iu49YJrzMdIYf19gqaxoM1JFeMi7OhkVmLu7R8RHDG4sltfv3VvVK6sbQ9OI/ZhfPaSfUXQk
	CYFlA+mkVgbYbw8Iy2fYbX41ZZbpVAxnvk/7Lc9gKNZPgNNppNi6OUjDEZgovGvA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sABVf-00000006iDn-4BmH;
	Thu, 23 May 2024 18:41:44 +0200
Message-ID: <d86fc714375c8adf772ddc83ab4de514273034bd.camel@sipsolutions.net>
Subject: Re: [PATCH 00/13] wifi: Add multi physical hardware iface
 combination support
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, Karthikeyan Periyasamy
	 <quic_periyasa@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 23 May 2024 18:41:43 +0200
In-Reply-To: <0dcc9afc-98ed-4f58-a368-79a5242a5bec@nbd.name>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <0dcc9afc-98ed-4f58-a368-79a5242a5bec@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-05-22 at 16:55 +0200, Felix Fietkau wrote:
>=20
> The key differences are:
> - Only band bitmask and optionally frequency ranges are provided, so no=
=20
> per-radio channel list
> This is easier to track and vastly reduces the amount of data sent to=20
> user space in the wiphy dump

That makes sense, though in your RFC I'd probably remove the band bitmap
thing, and make the frequency range not be optional. Perhaps in the
kernel it could be filled in by cfg80211 via a band enum (taking
lowest/highest frequency in the band's channels that are there), but I
don't know if I'd want to have to check with this all optional
throughout the kernel and the userspace advertising API.

> - No integration with ifcomb. I don't really see the need for that one=
=20
> at this point. It can easily be added later if it's actually needed.

I mean, sure? But I think that's being lazy, I think everyone else
thinks it's actually needed. I just got a question about interface
combinations being broken on iwlwifi because we advertise AP interface
type in a combination with two channels, which can't be right. I'm
fixing that, but actually it _would_ be good to know for hardware that
actually does physically have the capability to operate on two channels,
and then have the bands etc.

So I do think (some) integration with interface combinations is needed.

> - Validation happens in mac80211 instead of cfg80211, because that=20
> removes a lot of complexity

Sure, that's an internal thing. I don't really _like_ that too much, but
I also don't like the approach of building a huge list here. Perhaps a
reasonable compromise would be for mac80211 to pass some 'iterate' and
'getinfo' callbacks or something to a validation function, instead of
having to pre-build. Then the iteration can be in mac80211, but the
validation can be in mac80211, and IMHO that makes the separation and
how validation happens also easier to understand.

> The radio id is tracked per chanctx and only one chanctx per radio is=20
> allowed.

I may be misunderstanding this, but as phrased this seems completely
wrong? We absolutely support two channel contexts on a single radio
today, with e.g. a regular BSS connection and a P2P-client interface. So
not sure what you mean here, but I think it needs to be captured by the
driver what it actually supports here, and that's basically interface
combinations today for a single radio.

johannes


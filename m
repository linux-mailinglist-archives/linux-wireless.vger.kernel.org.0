Return-Path: <linux-wireless+bounces-22098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB0A9D965
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 10:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E191BC13F0
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 08:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA2221D8E;
	Sat, 26 Apr 2025 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EGGjLGhy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66B1D63E6;
	Sat, 26 Apr 2025 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745656669; cv=none; b=RGhE6Xdlj9jDccVPxv/pw1uFsAgm8Q03NzPKrkzznYz2AY6cnXXGbFn24rCySxn4tA6mnUdw7i4bHmu91zZEeLJvrMeoDU9BnJkDjsXioxbSemB3l+U5Zf/X437C8svjXxOtSSrv9TSHDTPvMg9hjab9RtD22NubRsiWbZBy+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745656669; c=relaxed/simple;
	bh=w3lmN7gNQOrl6aqJorV1yf/gqK7fDGbwt69VvaM2dpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3izOgDgmgRSKhFzlxp6vfkma0bseXCU8LAS6B1ooMxwdl/S+FEHARRAo04MeP2uKVfUWMRFkD2RtblMR0TGHA0WMBf33muK3wlBpZg9PxQoqF05ONcMbRWGOIKowaq3mbSZoG4HkRiEPmRb9glwmPf00dKLclrt5IJbacC/Tv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EGGjLGhy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w3lmN7gNQOrl6aqJorV1yf/gqK7fDGbwt69VvaM2dpc=;
	t=1745656668; x=1746866268; b=EGGjLGhyo5XPVciz78PHE5ZJ8ItEqgrcbaB5Ihsvg+lUid0
	8Tw+oLKNKd8IkwsJUqhv6QPDXK0ZVCydKBIvmN3g21m36Yg5RBcVFGg5qDW09evxmLqWtGZUjriph
	0+i6KHB5NsYiZg099MsJiPcQhmhUP2ntpotBVEzWDKczA3AEvoOTRImGlOtx4+joDlIuDOB0CHHWf
	qF0KDZXaTWxJEPyt+Um/FVJhb9Bl156J61bE0Sv5TwiYB0G8TMNpZsB8ODCmxO32pzFZJk1zJczz7
	kQ5dct+Dzt/daWPkRypyxFPeLPYXmeq26YHgt6ogGIfuEGI1lx/yGZLeVJG9GzWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u8b2e-00000003lJF-1xzU;
	Sat, 26 Apr 2025 10:37:44 +0200
Message-ID: <09f9a8700163a509846418354235bd3b84e8d532.camel@sipsolutions.net>
Subject: Re: [PATCH] brcmfmac: support AP isolation to restrict reachability
 between stations
From: Johannes Berg <johannes@sipsolutions.net>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>, Arend van Spriel
	 <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	wlan-kernel-dev-list@infineon.com
Date: Sat, 26 Apr 2025 10:37:43 +0200
In-Reply-To: <aAyQma_qLrH_7S2a@ISCN5CG14747PP.infineon.com>
References: <20250423175125.7233-1-gokulkumar.sivakumar@infineon.com>
	 <b6a11804b93df6052d61a7069d7ed0bd74a972ad.camel@sipsolutions.net>
	 <4a9c8323-5598-4783-90b2-ace84db22088@broadcom.com>
	 <9e6febe76a55053972049b13b254474a82b26571.camel@sipsolutions.net>
	 <2a6f7d20-2901-46d6-a16a-b977ff0a3724@broadcom.com>
	 <29fa5ea7f4cc177bed823ec3489d610e1d69a08f.camel@sipsolutions.net>
	 <c4b1d809-59fc-4d65-a840-d35598e8dfe5@broadcom.com>
	 <aAyQma_qLrH_7S2a@ISCN5CG14747PP.infineon.com>
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

On Sat, 2025-04-26 at 13:21 +0530, Gokul Sivakumar wrote:
> IMHO, In CFG80211, if we introduce a bitmap to track which BSS Parameter
> is changed by the userspace in the SET_BSS operation and then used this
> bitmap while handling the request, then the WLAN Driver would reject the
> operation with "EOPTNOTSUPP", instead of doing AP Isolation, because it
> does not support setting the other BSS params in the request.

Not necessarily?

> For Example, considering hostapd (iwd doesn't support SET BSS operation)
> if the user only enabled the config file param "ap_isolate", but didn't
> explicitly set "preamble", hostapd would implicitly set default value
> (0 - LONG_PREAMBLE) in the preamble param while sending the SET_BSS
> operation request to CFG80211.

But presumably that's still the default value in the driver too?

Hostapd could also be fixed too, to not change it if not requested.

> CFG80211 would then mark the bit corresponding to the SHORT_PREAMBLE BSS
> param as "changed" in the bitmap. WLAN Driver on receiving this SET_BSS
> request, would then have to reject the entire operation without enabling
> the user requested "ap_isolation" param, because of the preamble param
> that is not even explicitly requested by the user.

Or the driver can accept short-preamble setting, and reject it only if
it's set to short-preamble, rather than long-preamble.

> However, for other AP BSS Parammeters, we don't have the corresponding
> NL80211 feature flags.

Uh such a long time ago :) I don't remember why we had these. Given the
above do we need new ones? We can I guess, but I'm not sure it's needed
even if we change hostapd - if we do change it then it can just set only
the ones that were set in the config file?

johannes


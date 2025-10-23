Return-Path: <linux-wireless+bounces-28196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAF7C021FD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 17:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EA03AE78D
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Oct 2025 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB7337BB1;
	Thu, 23 Oct 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pN81CW0V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D122333441
	for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233091; cv=none; b=n8fY4w5g9qdXzoIyIu8KJWDijppQnTJE0l4SyOIyFMAeJBpqtSc4Ggi65hPoNxCPY3gpwcTCmIq/6ohZdaRpenIiCk8GfGMijLiw2b5zPspuY+wr4lY5rJHhuKaLEbnpf0SKwFwmWGkLCrr0EZ/H1ANUu0ewGCiJtyzZyTbxhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233091; c=relaxed/simple;
	bh=1XEeTVOQCclEbMP3aPRKsu84UhnVY/8X+gDzLp20v5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K+kTtJY99/Bj+xj1mF8C/ysyyQsBYGf5viwl6Seo1q4PR8ckAwxfXd0TXlV83QwAt6ueTI98kUHraIQrK/xoFh4OvxpfABR1Yc9bHMCKqni71nxjf8UhS+/hHunHayX0Tm4/iJ1+qWi8AL4zB0KyaPhv67hIRGw5Nrl+DwBi6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pN81CW0V; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1XEeTVOQCclEbMP3aPRKsu84UhnVY/8X+gDzLp20v5U=;
	t=1761233089; x=1762442689; b=pN81CW0VKVzi5KXqNb4n6nkWR4ClD6p/rUTwnZMq8hCjM9O
	+fiA98yfEDQU1gSoeMsDzETqaKjpav0IKp9x41oNSDYDCLJvYvSZaOq0YrvnRSmXqXMEgVEecZIvK
	T5qH0mk1iTijNDkFbFGDmzFTNZDjCrZacR0VKGUylq3fUvP2LH9YAQyW/Z3BvFcYtTqI15Lj5wrFP
	Zrg8Ijn0GYlBVQY+xU93KXb7MehVFZAxxUVLN8HhQSSIvV49pkQL0fI1mnoYUk+XkSCQ6fzuLsMBr
	xkxlj7DA+LU+6sWHIgzu55d9jvkAQ0fdgeUYDh+Tkga+BRqT+og3HJZFw+tGjx/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vBxB7-00000000C6D-2V6Q;
	Thu, 23 Oct 2025 17:24:37 +0200
Message-ID: <1062167f6dfed8384d36f8f9f1d61a46c4b04c61.camel@sipsolutions.net>
Subject: Re: Extended Capabilities bit values overwritten by the kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, 
	linux-wireless@vger.kernel.org, "hostap@lists.infradead.org"
	 <hostap@lists.infradead.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 17:24:36 +0200
In-Reply-To: <cd2ec7dc-1987-4f8b-8c5a-1f420a2de3c7@freebox.fr> (sfid-20251023_151356_177071_BFFF1AFB)
References: <cd2ec7dc-1987-4f8b-8c5a-1f420a2de3c7@freebox.fr>
	 (sfid-20251023_151356_177071_BFFF1AFB)
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

On Thu, 2025-10-23 at 15:13 +0200, Pablo MARTIN-GOMEZ wrote:
> Hello all,
>=20
> I've encountered an issue with an ath12k & hostapd based AP: whatever=20
> value I put in `he_twt_responder` and `he_twt_responder` in the hostapd=
=20
> config, I always have the bit `TWT Responder Support` set to 1 in the=20
> Extended Capabilities IE. This happens because hostapd overwrites all=20
> the bit values of the Extended Capabilities bitmap set in the config=20
> with the values coming from the kernel (ext_capa_mask) since commit=20
> 8cd6b7bce8b8f1fe2803bc17ddf0f51bd07330b1 (hostapd), and in the case of=
=20
> the ath12k (and also ath11k), the driver sets=20
> WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT in ext_capa_mask. I'm unsure on=20
> how to fix this: should hostapd be change so the kernel values can be=20
> overwritten by the config, or are the kernel values an invariant that=20
> shall not be overwritten and therefore ath12k should be modified=20
> so=C2=A0WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT is only set in the user spa=
ce=20
> or elsewhere in the driver dynamically. I'm taking the example with TWT=
=20
> Responder and ath12k, but I believe other drivers are concerned (e.g.=20
> TWT Requester Support and iwlwifi).

You're probably the only/first person to ever want to _remove_
capabilities that the driver has :)

The original intent (and note the age of that commit) was that we'd have
some capabilities that are implemented by the kernel (mac80211 sets some
such as WLAN_EXT_CAPA8_OPMODE_NOTIF) or device (driver sets some such as
the TWT ones you're looking at) and in that case they're exported to
wpa_s/hostapd to use in the association request/response (respectively);
other capabilities are implemented by hostapd and wpa_supplicant (such
as WNM sleep mode or BSS transition) and then hostapd/wpa_s set the bits
appropriately.

This way, you can add new features purely in the kernel without updating
wpa_supplicant to match, or add some in wpa_supplicant without updating
the kernel, and it all still works.

For mixed features that need both mac80211/driver/device and hostapd or
wpa_s involvement we typically would add an nl80211 extended feature
flag (rather than 802.11 extended capability), and then hostapd/wpa_s
would set the extended capability bit. This, for example, is the case
for FTM responder with NL80211_EXT_FEATURE_ENABLE_FTM_RESPONDER (as well
as some others working slightly differently, e.g. QoS mapping.)

Somehow it appears that we never considered the case of a capability
that's _completely_ implemented in mac80211/driver/device but someone
explicitly does _not_ want to advertise it.

I'm not sure I know what the right solution is ... Obviously not
advertising some features could easily be done in hostapd/wpa_s by just
clearing the bits you don't want, but that wouldn't actually disable the
feature in the lower level. So it'd probably work for TWT responder, but
not for TWT requester maybe, if the request would be triggered by
something in lower levels?

johannes


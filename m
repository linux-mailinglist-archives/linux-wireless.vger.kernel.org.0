Return-Path: <linux-wireless+bounces-28217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E91C04B4B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 09:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846B71B83BC1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 07:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DBE2C3768;
	Fri, 24 Oct 2025 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mFFvdExg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077429B8DC
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290670; cv=none; b=YjwlxYHsXJmbYjLeDAMevI+XkF+iNJWaWSHmrE9JWL+/Npzo/GEJQupxyTabSzuqIRC48zsPAzujfBlbxoCr58+ZZmsKXdjGewzSKIY8Un4LpvMRmEh/DEkXpiLc9YhnjyWZEjEiHZQS+yg8g+5vgNCl6GtI9nXRRbChZW+wJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290670; c=relaxed/simple;
	bh=3aoWQFARcmdS0w2MGOWZyPEo2/7izNP34oRYWVPdXXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDlo8j1TiLYdDGHHO9R+cs5GO6G2BHjDB0ooqT3H9IHEGwfsKhQ2b/DgDstvLbA1YQZve4vDZWJrdgiq9ad9C/aD7bJocHPcjVmY/AGNd5fyLfwEWIzznU/w/xosn/l+ukcmU4IHIKTXugQzKeUSUQY2A5xpmrz1Hm0kupYphuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mFFvdExg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3aoWQFARcmdS0w2MGOWZyPEo2/7izNP34oRYWVPdXXs=;
	t=1761290669; x=1762500269; b=mFFvdExgyrxdfol1+L6/rfyDf5n8yj79YUENBAxe+NN/lyC
	0ttzo92fK9pQpq51EkmEaSxwr6vqMpLm0PY28CvKaOittFnzyBV6CueCIcLS45fFc/xehRxZQjw5z
	/2zkgJq/rTux2sO1Nfjan06WzbcL842bUtfGPbkG1xthskISloIEguDMFffv33FPRL1PW7KYvXy1q
	47kGgzPf0R8m1Q0g3rcrtyQ5iFOfziQQBX7M5+X58cUOLzDtP03ytrX4nBS3Lq8fydr91O+jR5wEA
	I2sB3BpUEHaDfcl5TMSAUaYVz6YagabOm39hsmrAFhvWlnN7uxNVCgCWR6+RtbIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vCC9w-00000002HBe-0ezH;
	Fri, 24 Oct 2025 09:24:24 +0200
Message-ID: <39eb10812729ababf68b67079fff7e7d0e44ac00.camel@sipsolutions.net>
Subject: Re: Extended Capabilities bit values overwritten by the kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, 
	linux-wireless@vger.kernel.org, "hostap@lists.infradead.org"
	 <hostap@lists.infradead.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 09:24:23 +0200
In-Reply-To: <189e59d4-95c4-4580-82b6-d6e952e87807@freebox.fr> (sfid-20251023_182320_238434_CB62BF74)
References: <cd2ec7dc-1987-4f8b-8c5a-1f420a2de3c7@freebox.fr>
	 <1062167f6dfed8384d36f8f9f1d61a46c4b04c61.camel@sipsolutions.net>
	 <189e59d4-95c4-4580-82b6-d6e952e87807@freebox.fr>
	 (sfid-20251023_182320_238434_CB62BF74)
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

On Thu, 2025-10-23 at 18:23 +0200, Pablo MARTIN-GOMEZ wrote:
>=20
> > You're probably the only/first person to ever want to _remove_
> > capabilities that the driver has :)

> It is more a question of testing a capability and its performance's=20
> impact than to remove it completely :)

Well, OK, fair :)

> > Somehow it appears that we never considered the case of a capability
> > that's _completely_ implemented in mac80211/driver/device but someone
> > explicitly does _not_ want to advertise it.

> It's bit more complicated than that, at least in the case of TWT=20
> Responder in ath12k.=C2=A0 When we don't set NL80211_ATTR_TWT_RESPONDER f=
lag=20
> in hostapd, the ath12k driver sends a command to the device to disable=
=20
> TWT, so we end up in a situation where the device does not support the=
=20
> feature anymore but we are still advertising its support in the=20
> capabilities IE.

Huh, right. Then really this should've been handled like FTM responder
where we have a separate nl80211 feature flag, and userspace is
responsible for setting up both NL80211_ATTR_TWT_RESPONDER and the
extended capability flag together...

Not sure it's too late for that now? Jeff? Could/should we do
https://p.sipsolutions.net/d8d7eb632e66bfeb.txt with a corresponding
hostapd patch? Seems like the cleaner/better way to do it given that now
we end up in a situation where TWT responder is advertised but not
supported on older hostapd/hostapd with it not configured? And
apparently you already have this internally with
QCA_WLAN_VENDOR_FEATURE_HT_VHT_TWT_RESPONDER ...

> > I'm not sure I know what the right solution is ... Obviously not
> > advertising some features could easily be done in hostapd/wpa_s by just
> > clearing the bits you don't want, but that wouldn't actually disable th=
e
> > feature in the lower level. So it'd probably work for TWT responder, bu=
t
> > not for TWT requester maybe, if the request would be triggered by
> > something in lower levels?
> Ok, so for my case, I just need to clear the bit, the feature is already=
=20
> disabled in the lower levels. If I go for that solution in=20
> hostapd/wpa_s, the issue is going to be can it break another driver?
>=20

I don't think there's really any other driver using it.

johannes


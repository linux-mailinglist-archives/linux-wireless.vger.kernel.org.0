Return-Path: <linux-wireless+bounces-26975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B16CBB4244E
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 17:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB9D1BA7813
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D293126CA;
	Wed,  3 Sep 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NUENcLMu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C51B983F
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911734; cv=none; b=gkmkPmVcJNKTaO8WNKq9HDOaDSu0vIIHA5IQl248IbY1Ubp+3qFLm9/mnMnoGWJ0hdHmWDkDS2qRn2myXEfxo/lsDg5xK83++kq1hIfRymWJd3P9qc0YrkFsJ4yjb+v8FrKmtn9OZssNMG9QU0ZT0T9tnA3kTLkNxSkb8iPaHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911734; c=relaxed/simple;
	bh=DYCmeMnnX+M2eScoDueVCcQYbeMQQyajHKkoe8+VEzY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XU9p8v1Z8gb/VcblsIgNKfOvdIsleXLtomyoBDK1YhhtJQBqhrxyYufJfzNMb+IPW9GmEBXNKxl1Hx7OwtK36xnYOW2aDkOwd3UpwiWbjvkLmjpvMwquCrCFWpzAtoTueKngTodq1pVZCtJxdpuAE5OfssnwMFSmRXur/Is+btE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NUENcLMu; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YyidPvuLhBb9wg+3uNhmjh3CKgjRrX2DJmjptkYrPYs=;
	t=1756911732; x=1758121332; b=NUENcLMuxl1BRPDy9gSin45H1wamgjvu2n4cNyOcgmQXjWS
	EpRW+ACbUaz9rfsbXd5Sb4vY5Ry76Fs885NpHU+Njm/tqQFHeHR1sP+rPImjYQ5wSvQCR3dgGs5e6
	T9F/xV3LdF4Fsy6wMYZpKt2WqAo3Ep9uSFo96BNaHpf41MeRY3NIddskyHNXS5S4yIYVI9V82ED0W
	F8FzygPbKO1fvhDXAE01sbQtzrmxKOOg1ml8lIjxcFPSod+t8qUL2lK0WMaoOc3GUpH6B/I2KoTIN
	3VEHVlPW8QjFIwfq/ksYSVk2Jowjc88N0v/GRN4YKHsZcBEAyiBVT4xJ9gLkQ5kw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1utozw-0000000C1Cu-276f;
	Wed, 03 Sep 2025 17:02:08 +0200
Message-ID: <430174f005c3819f10c540b9198be833b584ce1e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 2/2] wifi: mac80211: reduce the scope of
 rts_threshold
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Wed, 03 Sep 2025 17:02:07 +0200
In-Reply-To: <a9b0bdf6-f445-4937-bd17-91880438ce01@oss.qualcomm.com>
References: <20250903083904.1972284-1-miriam.rachel.korenblit@intel.com>
	 <20250903083904.1972284-3-miriam.rachel.korenblit@intel.com>
	 <a9b0bdf6-f445-4937-bd17-91880438ce01@oss.qualcomm.com>
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

On Wed, 2025-09-03 at 07:30 -0700, Jeff Johnson wrote:
> On 9/3/2025 1:39 AM, Miri Korenblit wrote:
> > This is only needed within the 'if' scope, not in the function scope.
> >=20
> > Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> > ---
> >  net/mac80211/util.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> > index 32f1bc5908c5..b56941a70754 100644
> > --- a/net/mac80211/util.c
> > +++ b/net/mac80211/util.c
> > @@ -1756,7 +1756,6 @@ int ieee80211_reconfig(struct ieee80211_local *lo=
cal)
> >  	bool sched_scan_stopped =3D false;
> >  	bool suspended =3D local->suspended;
> >  	bool in_reconfig =3D false;
> > -	u32 rts_threshold;
> > =20
> >  	lockdep_assert_wiphy(local->hw.wiphy);
> > =20
> > @@ -1832,7 +1831,9 @@ int ieee80211_reconfig(struct ieee80211_local *lo=
cal)
> >  	/* setup RTS threshold */
> >  	if (hw->wiphy->n_radio > 0) {
> >  		for (i =3D 0; i < hw->wiphy->n_radio; i++) {
> > -			rts_threshold =3D hw->wiphy->radio_cfg[i].rts_threshold;
> > +			u32 rts_threshold =3D
> > +				hw->wiphy->radio_cfg[i].rts_threshold;
> > +
> >  			drv_set_rts_threshold(local, i, rts_threshold);
> >  		}
> >  	} else {
>=20
> Johannes, is this your preference for wireless?

I'm actually not sure where this came from, and I don't know why Miri
made this change now. I don't really have a strong preference either
way.

> Kalle had a preference for defining all local variables at the beginning =
of
> functions,

That almost sounds like it was a misunderstanding, since the kernel
coding style says it should be at the beginning of the _scope_? I don't
know where that came from either, unless Kalle had some personal
preference, but I can't remember him ever stating that (to me.)

>  so that is a position I've been continuing even though my
> preference is to limit the scope.

I'd tend to agree that limiting the scope can make things nicer. So
let's just drop Kalle's invention I guess? :)

johannes


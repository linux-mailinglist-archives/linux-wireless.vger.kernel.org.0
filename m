Return-Path: <linux-wireless+bounces-29585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F125ACAC802
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 09:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32CEF302AB9B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 08:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443E727F18F;
	Mon,  8 Dec 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hZpRu4AG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C51DF49;
	Mon,  8 Dec 2025 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765182601; cv=none; b=bpkq5BVrL5FB59Q5EuEwaRBdovoIaFaEzxPddFqq7sJEs7hSwfRf8uwPuMfi0hGgqP9w6mQ9pUaY95Mc7Sns+AmlnVWI+NdFrbmnuya41d47pup4kpBRdO6ULo416n3KaKggzmoj4PdDLOkzIKUqfhXtVm7gipxLlvBVHMRkJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765182601; c=relaxed/simple;
	bh=e9b7wf3Ir7+k+5R5L6d75R/rP2RhawBQHrhVpCCTiAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNSKk1zUjxVv8fGhGDFYqhNl+htznuVGMxIbZRRQKFMhsl2CMzhmTyJr+QAqRaK26FEZq5mjL/ksgDIlaTm0y7d1p9XFBWuXdxRqtxJDIv4JSEvxgM7GZNzM6uGV3acx6gbSk6cbIHjnZz8rYr6ktVErej2buPOD01Im7I5BOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hZpRu4AG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GcBrJwFl/Giz+wimFGY0BD3vbbK0qO2anUfNKsviw14=;
	t=1765182599; x=1766392199; b=hZpRu4AGr1Eyi4POP1vyr0u9neWblHPQSQGagdmaVTxxEft
	nMfiz5yzQjdXXYBEua1upT9SuJWpawV114YxGO8QS0pX1Ns4QPdmW6ZSzXZBpam5RtgEzQ5ei3NjM
	bEclw2+0kFPYGyD4w03So4987IzXIKSCXJ3f2t9GTQ//XJJOwJoYlRXipgTceyBptuAZ+EB6KIDfL
	yXCkz2T2TCpx2L7FwzYLiqOCwMr+qhfXplFLM0eQJJMUgfMi0MLm2KvQqb3eon6OQC95f+CEp2h56
	pQecLS0lBBzyVQnhEuAJIxmc3hYvqBA8DoyW3a/9vwch3bVavQhWaD9WU5bYF5fA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vSWd1-00000002ohS-26OF;
	Mon, 08 Dec 2025 09:29:55 +0100
Message-ID: <3012de51f1dd363d1ba8f34bd1252add2977f608.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211_hwsim: fix divide error in
 mac80211_hwsim_link_info_changed
From: Johannes Berg <johannes@sipsolutions.net>
To: Deepakkumar Karn <dkarn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	shaul.triebitz@intel.com, 
	syzbot+5bb5f06f99924ea0cf86@syzkaller.appspotmail.com
Date: Mon, 08 Dec 2025 09:29:54 +0100
In-Reply-To: <20251206173345.356068-1-dkarn@redhat.com>
References: 
	<6cc422bb9525be529c6b0d2d25f9869ca41ec77d.camel@sipsolutions.net>
	 <20251206173345.356068-1-dkarn@redhat.com>
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

On Sat, 2025-12-06 at 23:03 +0530, Deepakkumar Karn wrote:
>=20
>=20
> Thank you for your response Johannes. cfg80211 already have validation=
=20
> in cfg80211_validate_beacon_int().

Oh OK.

> The problem seems to occur in=20
> case of interface shutdown which calls ieee80211_do_stop() that makes=20
> beacon_int =3D 0 or set_tsf which causes divides by zero.

Why would that call set_tsf()?

And yeah that should make beacon_int=3D0, but not have beaconing enabled.

> What if we:
> 1. Handle off-channel operation:

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (test_and_clear_bit(SDATA_STATE_OFFCHANNEL_BEACO=
N_STOPPED,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0&sdata->state)) {
> -                       sdata->vif.bss_conf.enable_beacon =3D true;
> -                       ieee80211_link_info_change_notify(
> -                               sdata, &sdata->deflink,
> -                               BSS_CHANGED_BEACON_ENABLED);
> +                       if (sdata->vif.bss_conf.beacon_int) {
> +                               sdata->vif.bss_conf.enable_beacon =3D tru=
e;
> +                               ieee80211_link_info_change_notify(
> +                                       sdata, &sdata->deflink,
> +                                       BSS_CHANGED_BEACON_ENABLED);
> +                       }

don't follow, that only does it when beacon was actually stopped ...
maybe do_stop() needs to clear that bit if there's a possibility of this
happening in the wrong order, but I don't see how there could be a race
since off-channel must also be stopped at that point anyway, unless that
is in the wrong order.

> 2. Handle case where debugfs is written after shutdown or any race condit=
ion during disable beaconing:
>=20
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/=
wireless/virtual/mac80211_hwsim.c
> index 551f5eb4e747..8363cdd17a97 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c

first of all, I really do think you should *not* (need to) modify hwsim
at all

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0conf =3D link_conf_derefe=
rence_protected(vif, data->link_data[0].link_id);
> -       if (conf && !conf->enable_beacon)
> +       if ((conf && !conf->enable_beacon) || !bcn_int)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;

But this also makes no sense, it shouldn't be possible to have beacon
enabled and beacon interval =3D=3D 0.

johannes


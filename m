Return-Path: <linux-wireless+bounces-24437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB585AE6BA1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 17:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D776C3AF400
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2588F274B56;
	Tue, 24 Jun 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qjJTou0k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58548274B4D
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779993; cv=none; b=JQQudqUIYropQO6YN0jwBjsiXObSKPGF2oDKeeY34JvEZLpEvDc1QecJEd2A5FsAI1r+LQ0I8LPEiBgtN0FGKofUNFlKx1xTQk3XQVnEHnAJNVjX1u0xHR9XnpNoac7Iwww5RL9MybfsLZjYzx9xK0fivveFlLscz+r4iZZ1snw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779993; c=relaxed/simple;
	bh=uzUmPA6E90AM7qNY9iCssjYYk/Y/Aiwvi2bipz626K0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OsMsfSi87JI25b/wt9THIYlU5PjMscjNgYi4JNOQ1ZZRNoRQpnMtaLCBsdBsLrfYZYLJm02vJ83wLXRBiriUi547PUE9gH6x4qOsUuJ3ZkhmWsFYX/1TP+T8zXlD3hHFsZqsCVn9fZAv+H0Dif7QuNTi3hD40xP3DQ2LPuOG3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qjJTou0k; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qxGTGHvcbMqMyBlnwMBbsvL/gWZJNL4uuEWUBIhzr1E=;
	t=1750779991; x=1751989591; b=qjJTou0kyisGC9dP9tTK9QuLsd5y5s9jy39KscVF4G44DvP
	Udt/2sMdmqNfsfM38Y1Nd0Cgch/jmBN8LSeLXy9nngiLys3rWnix5Kcu1mGKwcu2q1/gGQCDcPTEa
	MklrRI/H++sm2LDm2GHB94HTtCJ92ASYzEp5BaMQ0rudBHbQ5tIWfGvRixMwmDZ8XZ0OyUOWSB+Yp
	2pAUNh7yvYPXfEecYH9laBMvzVWlIch3LyAJFicrgOEu76Gk0/ZPUY9Xrq26fGg34zrKcHNIH62uh
	HIYiom/8EYLXDsqwldy3JKnhj8idHeRRL8ZvHG7i1HW98Zp2l1mi64qC/WuhgGBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU5qt-00000008wqW-4AdJ;
	Tue, 24 Jun 2025 17:46:28 +0200
Message-ID: <292dd6c29502868b0397e66eb3cb450dfa0e71df.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/2] wifi: mac80211: extend beacon
 monitoring for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 24 Jun 2025 17:46:27 +0200
In-Reply-To: <20250609070319.1033874-2-maharaja.kennadyrajan@oss.qualcomm.com> (sfid-20250609_090408_884192_0116D561)
References: 
	<20250609070319.1033874-1-maharaja.kennadyrajan@oss.qualcomm.com>
	 <20250609070319.1033874-2-maharaja.kennadyrajan@oss.qualcomm.com>
	 (sfid-20250609_090408_884192_0116D561)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-06-09 at 12:33 +0530, Maharaja Kennadyrajan wrote:
>=20
> +++ b/net/mac80211/mlme.c
> @@ -2439,6 +2439,19 @@ static void ieee80211_csa_switch_work(struct wiphy=
 *wiphy,
>  		}
>  	}
> =20
> +	/* It is not necessary to reset these timers if any link does not

nit: I think we should start/continue using normal "non-networking"
comment style. I even removed the special style from the networking
style guide, and it was never a good idea (IMHO) to start with ... but I
know we've not been super consistent either way.

Anyway that wasn't why I was commenting, rather:


> +	for_each_link_data(sdata, link) {
> +		if (!(link->conf && link->conf->csa_active))

That condition, and other code later, really seemed confusing to me, and
when I carefully thought about it I realised that you were afraid that
link->conf would be NULL? However, it can't, that just doesn't make any
sense.

Now then I thought _further_ about it and sent/applied this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commi=
t/?id=3Dd87c3ca0f8f1ca4c25f2ed819e954952f4d8d709

but that's not even relevant for your changes since you have full wiphy
lock held, not just RCU protection.

So please let's not be overly paranoid with this, and remove the
unnecessary "link->conf !=3D NULL" checks.

> +static bool
> +ieee80211_is_csa_in_progress(struct ieee80211_sub_if_data *sdata)
> +{
> +	/* In MLO, check the CSA flags 'active' and 'waiting_bcn' for all
> +	 * the links.
> +	 */
> +	unsigned int link_id;
> +
> +	guard(rcu)();
> +	for (link_id =3D 0; link_id < ARRAY_SIZE(sdata->link);
> +	     link_id++) {

maybe add a blank line there, the guard is pretty hidden this way

> +		struct ieee80211_link_data *link =3D
> +			rcu_dereference(sdata->link[link_id]);
> +
> +		if (!link)
> +			continue;
> +
> +		if (!(link->conf && link->conf->csa_active &&
> +		      !link->u.mgd.csa.waiting_bcn))
> +			return false;

here, technically, it _is_ just with RCU, and I guess we can wait until
I merge the other patch, but it's pretty unlikely to get into any issues
even without it.

johannes


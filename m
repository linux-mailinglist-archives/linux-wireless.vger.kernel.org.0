Return-Path: <linux-wireless+bounces-30947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B50D3A280
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 10:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0617D3006454
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F51B33C1BD;
	Mon, 19 Jan 2026 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UZSxr+7f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45CB33ADB9
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813899; cv=none; b=gZU7Sxa/8VAWG0Z+qIZPr4litFWncaa1AGIPLdEHStzKrmHmkxJZfVfEtc3AP4xTy3m4U60mdK4/E8uw6Ha/kh/JFcQrcdcEaQLfMb42wJbbJgaRHnIYqHGYfKfDEyAduYq64ubYGTNt6FsUw/LqcaH5evrBbwKVybINK1u44fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813899; c=relaxed/simple;
	bh=xgf1dbOueHHUyoMuTDp368lyaXA77yDT7djvCGc6adk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HmXZahIqj9t4L5pMZvpcjmuGzL0YYc+7kS95y+fvzx49FWpbvsDepYm2BO+cMilYFAPp5/yKpYnNyOOQqNuq/VVfASvowBDDlBnWLSf8qdKMS90V99/6Sf12tpX6qi8d+baijS8CWBiLC3EN39ueLPAp2sekcSgI+fzQl8wyQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UZSxr+7f; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=620rEfFb00bddjZNFT+G2L0Y/ogIzGSW2hx/gr5/r9g=;
	t=1768813897; x=1770023497; b=UZSxr+7fwWQvgsymHA9M7YJDUPQnONJVTTHDhkbgEFQNaoQ
	VdU/jIQXmbEkh6rIWbvQ9MhZ/IvE6cU/D/Ht3X9NsqHCLwkwRZYrWivEPKE5FUzYv6tqT1VQgLzpC
	Y2dzH6tsVA0to2sxzyfXGvOAF5WS3gAvFgdvapyipYQnQgXxxnnOI2VFfsRw6H62rvi/kSSZyeuP/
	huhYev07lOX8BbZBRkcylsIQz7usZ+FgHNWp3gDE0aa8EI36sMIsjc0EPHw81cGY4dRNeosYpaB1g
	7qEWH2763TYtF+8AhCaGYroJ+s1lH6Gx4LtNZ8JS4J/nVibKJAgPVt7mt7wY6Kug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vhlIN-0000000Fp3m-0qnk;
	Mon, 19 Jan 2026 10:11:35 +0100
Message-ID: <b408ac23d51bec80048c35055199176bd0377879.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: wlcore: avoid oops when reading tsf from debugfs
From: Johannes Berg <johannes@sipsolutions.net>
To: Peter =?ISO-8859-1?Q?=C5strand?= <astrand@lysator.liu.se>, 
	linux-wireless@vger.kernel.org
Date: Mon, 19 Jan 2026 10:11:34 +0100
In-Reply-To: <ac98f15b-4f6e-95c4-534d-583419068ce0@lysator.liu.se> (sfid-20260116_163710_192579_DC8B9783)
References: <ac98f15b-4f6e-95c4-534d-583419068ce0@lysator.liu.se>
	 (sfid-20260116_163710_192579_DC8B9783)
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

On Fri, 2026-01-16 at 16:31 +0100, Peter =C3=85strand wrote:
> In this case, read lock on dev_base_lock is active so calling pm_runtime_=
resume_and_get
> or wl12xx_acx_tsf_info will cause Oops like:
>=20
> [  182.282540] BUG: scheduling while atomic: cat/269/0x00000002

I guess I get what you're trying to do, but ...

> @@ -4988,6 +4989,10 @@ static u64 wl1271_op_get_tsf(struct ieee80211_hw *=
hw,
> =20
>  	wl1271_debug(DEBUG_MAC80211, "mac80211 get tsf");
> =20
> +	/* Return cached value to debugfs */
> +	if (!preemptible())
> +		return wlvif->debug_tsf;


No. We're not going to merge such a thing.

I'm not sure I see how _debugfs_ actually could trigger this, since
mac80211 doesn't enter any atomic context? It even documents "The
callback can sleep", so under which circumstances would it not be able
to?

johannes


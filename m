Return-Path: <linux-wireless+bounces-10544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBA093D134
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 12:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D103D1C20A5E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD03C14277;
	Fri, 26 Jul 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kM4SMsPg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C517838A
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989808; cv=none; b=fd1HNhO92ggCjD5CD3e027CuxXGdpQjyBBlQEJmgM14hQB7+07v0/UL6eo+3J2idvZfqvKAmbYItUWx3cqHyaBeXaJlvfRs+9Ni+ljV05bJCGLh4ZWtz1jenHp7tZfUQ3lSjv3OP5ZHDZlLdukgKAeqQ9Nisq5kLw3zyHkhsHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989808; c=relaxed/simple;
	bh=S4EraJ0gz7aJxvg4Dj+tcVe+O+pCtjnposgoFCAnbws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHK+T28Nv/MaHGLjHYpJbjW2OoAw4/YdbgmkiP+dWAZBC31yUQdCGxC9WGe1bLmVdqd/EBLipUsJgVbVmKSG1Cg9JsU41iwqOPBeUukbExkmD8uRkcTEe/DFaXbO6II+TGxt6wFAFfP1rMagPIE9/DboydBGqNlwiZr3bZ6K8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kM4SMsPg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=u94D9r50ayZrrAHSAkZ56RgXy7gMX46ml6UAqxiHh1Y=;
	t=1721989805; x=1723199405; b=kM4SMsPgOVX+58H39ZpcmwGzTFGthIeJJVqPzaRBpC+doJi
	XnvYdFtqvwD6YvLGyFwXddoIRBxnGCP5YWbORARzbi7d8GrpizE3CSbQJzUtQHnuKMMPfFyZ4yPRL
	PbsGdnEoJu0j4FZL/g3WlaEDaeDh9B0coX6cZJZZA6vlKb90qRrn5WttyCUqyl3ZbevzVv1uW65H/
	zZsYJ7pct1VJ67eTRqmkfCsEt5W31cU8Uemt9kX8HrFTrvxES5Zt6T1NEw0m562BDJConeMkzvLQO
	m/DA7aAeYjSKld367XsbtPc09G6Y/Q5+v1LiexdBqHbUMEenb/ZUaCq9T8YjYLVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sXID3-00000000N3Y-0gsz;
	Fri, 26 Jul 2024 12:30:01 +0200
Message-ID: <6ab2dc9c3afe753ca6fdcdd1421e7a1f47e87b84.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: avoid warning of no supported legacy
 rate if empty rate mask for rate control
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 26 Jul 2024 12:30:00 +0200
In-Reply-To: <20240726031520.7616-1-pkshih@realtek.com>
References: <20240726031520.7616-1-pkshih@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi PK,

Thanks for taking a lot at the syzbot report! It's been on my list for a
while, but didn't get to it.

> The commit 9df66d5b9f45 ("cfg80211: fix default HE tx bitrate mask in 2G
> band") correct bitmask of HE MCS, and settings of empty legacy rate plus
> HE MCS rate are correctly recognized instead of returning -EINVAL,
> so empty legacy rate propagates to __rate_control_send_low() and warn
> no supported rate.
>=20
> Since the rate_mask is intentionally set to empty via nl80211,=C2=A0

That's all true, however,

> change logic
> to avoid warning no supported rate if rate_mask is empty.

I don't necessarily think this follows.

> diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
> index 4dc1def69548..5787cb20de42 100644
> --- a/net/mac80211/rate.c
> +++ b/net/mac80211/rate.c
> @@ -377,7 +377,7 @@ static void __rate_control_send_low(struct ieee80211_=
hw *hw,
>  		info->control.rates[0].idx =3D i;
>  		break;
>  	}
> -	WARN_ONCE(i =3D=3D sband->n_bitrates,
> +	WARN_ONCE(i =3D=3D sband->n_bitrates && rate_mask,
>  		  "no supported rates for sta %pM (0x%x, band %d) in rate_mask 0x%x wi=
th flags 0x%x\n",
>  		  sta ? sta->addr : NULL,
>  		  sta ? sta->deflink.supp_rates[sband->band] : -1,

The warning is still valid - we're trying to pick a low rate with a NULL
station (i.e. we don't even really know where to send the frame), but we
don't have any rates to do so with.

Obviously this will remove the warning in this case, but I think the
underlying issue is that we're actually using the rate mask, intended
for the connection on the interface, for offchannel TX (looking at the
stack dump).

We had this precise discussion previously for scanning, and just like
there, fixed in ab9177d83c04 ("wifi: mac80211: don't use rate mask for
scanning"), I feel the right way to approach this issue here would be to
similarly not use the rate mask for offchannel TX, which is I think
pretty much the same situation, you could have a rate mask set for only
2.4 GHz where the connection is (and empty for other bands), which is
accepted by cfg80211 and mac80211, but then do offchannel TX on 5 GHz
anyway.

So I think the right way to approach this would be to do something like=20

diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 28d03196ef75..33361b4d9acf 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -830,6 +830,8 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wirel=
ess_dev *wdev,
 		flags =3D IEEE80211_TX_INTFL_NL80211_FRAME_TX |
 			IEEE80211_TX_CTL_REQ_TX_STATUS;
=20
+	flags |=3D IEEE80211_TX_CTRL_SCAN_TX;
+
 	if (params->no_cck)
 		flags |=3D IEEE80211_TX_CTL_NO_CCK_RATE;
=20

though at that point we need to rename that flag too, I guess.


johannes


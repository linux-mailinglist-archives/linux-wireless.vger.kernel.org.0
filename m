Return-Path: <linux-wireless+bounces-9529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738219166C7
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 14:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CD21C2097B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492C644C9E;
	Tue, 25 Jun 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LRgA3Ci/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC06A039
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316850; cv=none; b=cpyA5lGugobVAkB3Yj1goV3lqcLzj2m9SZxs0quwEHUPDpUcpAruI6hQdQ4N3a29DIHMh56xWVHNDwxZXRjd07VyUkKs0agEQExWropewBjtV4LL06Y2sfm/zqTvIzjwE42vyBMUk23krGpWXXkFCcu904jfZDRFLRA+MKDmAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316850; c=relaxed/simple;
	bh=ornJZfnVe5qMVemUriFFCO6khfr1su5wPIXf7yDm2/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LkjokzLq3F8uGKHAmXfEN4Un5Z7zdaRa/TO7BEFEW8eZBqN7jHy+WZNwSiuZWQRkhD19puMNLC+s2+glE6VedjdzwM6XwM3tqxo5Bff8Kj61QuXDO7rxCJ55UDAyKLSSgDwezYGudyHFsRl4/GMvNOLU7iYJjfhSBBaXDRdvZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LRgA3Ci/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xg0U7GdB0uUfj5/AEfEiDKumzaDBl7TWw7BrFuuJKW0=;
	t=1719316847; x=1720526447; b=LRgA3Ci/A4ndHNJvaqiP+RxuEqYaL5r5IZl1AXbbWdQgYoU
	zWUVLByzXkJyDzfxSW49wdJe4/unJokwECzcNko+5XQhgCMKdk8g+hn5buryrioRj8uAmZh6Z7LYs
	RS9OiI666Vn28JqPG+To67IQaMhp5iJi1Zz42GTLGRQBPzetRtjSicGO3KBkIrjxBJo7RnecVg262
	M8G9Ku6EQnrnu3iPbMuE8UTDjd61tMdKbwCF6WBpDIGVS+yhYbqg8hzoLGWJPSQXfZ9YESPmbae1P
	xTqy1fD8wSN9LEiHDkTLsCyL5y/eLR1NXhIXZh4MLCvZlpYx0KraoctaCTlvnS2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sM4qq-00000000fgI-0zBE;
	Tue, 25 Jun 2024 14:00:44 +0200
Message-ID: <b419cf92eb34ad9f19260baf2a3e728dea52d4f0.camel@sipsolutions.net>
Subject: Re: [PATCH 6/9] wifi: mac80211: fix label name in
 ieee80211_start_radar_detection()
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 25 Jun 2024 14:00:43 +0200
In-Reply-To: <20240619040959.1457547-7-quic_adisi@quicinc.com>
References: <20240619040959.1457547-1-quic_adisi@quicinc.com>
	 <20240619040959.1457547-7-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-19 at 09:39 +0530, Aditya Kumar Singh wrote:
> After locks rework [1], ieee80211_start_radar_detection() function is no
> longer acquiring any lock as such explicitly. Hence, it is not unlocking
> anything as well. However, label "out_unlock" is still used which creates
> confusion.
>=20
> Rename the label to "return_err".

Probably better to get rid of it entirely?
>=20
> [1]: https://lore.kernel.org/all/20230828135928.b1c6efffe9ad.I4aec875e25a=
bc9ef0b5ad1e70b5747fd483fbd3c@changeid/

I _think_ people were suggesting to drop the ":" from that?

> @@ -3477,7 +3477,7 @@ static int ieee80211_start_radar_detection(struct w=
iphy *wiphy,
> =20
>  	if (!list_empty(&local->roc_list) || local->scanning) {
>  		err =3D -EBUSY;
> -		goto out_unlock;
> +		goto return_err;

can drop braces, "return -EBUSY;"

> @@ -3487,12 +3487,12 @@ static int ieee80211_start_radar_detection(struct=
 wiphy *wiphy,
>  	err =3D ieee80211_link_use_channel(&sdata->deflink, &chanreq,
>  					 IEEE80211_CHANCTX_SHARED);
>  	if (err)
> -		goto out_unlock;
> +		goto return_err;

return err;
=20
>  	wiphy_delayed_work_queue(wiphy, &sdata->deflink.dfs_cac_timer_work,
>  				 msecs_to_jiffies(cac_time_ms));
> =20
> - out_unlock:
> + return_err:
>  	return err;
>=20

and that can then become "return 0" which is much nicer anyway

Cf. also
https://staticthinking.wordpress.com/2024/02/28/return-0-is-better-than-ret=
urn-ret/

johannes


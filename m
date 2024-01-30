Return-Path: <linux-wireless+bounces-2790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1E8420FC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B34B1F21C53
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A235BAD8;
	Tue, 30 Jan 2024 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wvm5Kv6S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04B605AD
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609859; cv=none; b=BZ4VrUkBCHrdqjCWTwYas5W3k18czF+yewT2LOtpcitETF0VvTkIDOtoWpJ874XkDwZb2qz4waU/fZGymj9fzV9DTUGCzNDZ7ByL/BgMVILXU2CzLJNG8hnt9QvTHc1vhlOJoW7oBdeJpnq62FPhDAxsPdnVWSR4cQ0DiS+XoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609859; c=relaxed/simple;
	bh=toH3+1YZykHJLfJV2UH7BPWRN1hJ+R/6H9ZYYF1JgM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCVC1u13mR2Q3byUx5WhjMviwoYa3fNgXRN3w7rpZg/v/eR3SolRm3xsPggJ1v+dIi2XUTSxy341+7s+CqWr7EHIscedkYHKrpL0fNcpz+1XUIVBO2eKTaNnM7UCbsEz2SW+Gpb8aSywA2y4B9Kj8O5Z1x6Ykvap4wIAbS28nfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wvm5Kv6S; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=R58WjFyvD4feLQKU+9qOOB7Fzl8JJEv13qjx4szFxwY=;
	t=1706609857; x=1707819457; b=wvm5Kv6SMJqBOJWUyyt4gqf5meBK7iXVXKDubFdQmBjOl/R
	Qng8qtY/94hQn36EDIQoqblk6+LL+ymSt3ZY4T97Q8O0FJVjYlMZabSXpqP1a0o5ND+fcwEnuuO6C
	rDbeAmTTQg4ySXtLy8wdnGBKcK9xnMNyyM2HC3F40+twXrtwAzeztXKMYeqrTLhVUTa+6gPE15611
	ZylD+xyWBfDbLeWSfIk38IaAepuBTvJ5XG6vrFVoYI5WmFV7vm/SgnL6cC2QHlXfK8dRD01uNOCRc
	ooyyeplXM2Hq/foB0q3AtA9BoTWbuyMssdd56afSB8c7gWwpL/ETeW2/tcozK9eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUlBO-00000005ypb-1Kk8;
	Tue, 30 Jan 2024 11:17:34 +0100
Message-ID: <1e73c061653abf8e5f1671ae026e0905b2fb4ded.camel@sipsolutions.net>
Subject: Re: [PATCH v7 3/5] wifi: mac80211: handle set csa/after_csa beacon
 on per link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 30 Jan 2024 11:17:33 +0100
In-Reply-To: <20240130043225.942202-4-quic_adisi@quicinc.com>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
	 <20240130043225.942202-4-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 10:02 +0530, Aditya Kumar Singh wrote:
> In order to support CSA with MLO, there is a need to handle the functions
> ieee80211_set_csa_beacon() and ieee80211_set_after_csa_beacon() on per
> link basis.

nit: "on a per link"

> Add changes for the same.

Is that some cultural thing?

I always find this phrasing with "for the same" very odd, and would
rather say something useful such as "Implement this by passing the
correct link data"... but I see this a lot, hence the question.

> @@ -3658,7 +3659,7 @@ static int __ieee80211_csa_finalize(struct ieee8021=
1_link_data *link_data)
> =20
>  	sdata->vif.bss_conf.csa_active =3D false;
> =20
> -	err =3D ieee80211_set_after_csa_beacon(sdata, &changed);
> +	err =3D ieee80211_set_after_csa_beacon(&sdata->deflink, &changed);

weren't you just saying deflink shouldn't be used?

> @@ -3928,7 +3930,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, str=
uct net_device *dev,
>  	if (sdata->vif.bss_conf.color_change_active)
>  		ieee80211_color_change_abort(sdata);
> =20
> -	err =3D ieee80211_set_csa_beacon(sdata, params, &changed);
> +	err =3D ieee80211_set_csa_beacon(&sdata->deflink, params, &changed);

dito

johannes


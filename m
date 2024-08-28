Return-Path: <linux-wireless+bounces-12161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D826896268A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A481F22A59
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC8116C867;
	Wed, 28 Aug 2024 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OG24Jbld"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B316BE34
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846789; cv=none; b=K6pG4dkfmVrLtqAefVRu4PbG2nDVvA54p/csPRbvFhLqPOvGyB+BiMnu3SWhjT0S2EGg04K4n+EzNMKIViY9DcEsYi0Nkb7j5W1W7Nxd1MD+0FHSmJtgZufh8sEnaJ+bYn4FQWzTh6WtBsJ/wGE6oG9C39ah8aZjlDbNFnUNsm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846789; c=relaxed/simple;
	bh=WGGwRJvwEhkvHVVtP308563siHAKvr4aRsdt4mUvuWQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mk83Z1+zQffDOZgwtvO02e89TUHZLsDPKMZaE0b2ZeH+XFY05coPrminZEHvMhRhaRPoX8ONOFKApoxRsuYP4JzW2FXNmCrHlY7nwg8Sad2VMF7tYDwVxXlHGjIubeyvwlYkWt1usD78ZxfXYFmnfRuMT/5Qza0BdSvxwuw+Y4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OG24Jbld; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WTRHGN93Vi55qqShezByy37mlFlKPLFTgcV6qlQvL3g=;
	t=1724846788; x=1726056388; b=OG24JbldudWal5sR8afs2Su68Tsklg1pNeQ5hhn73RH3/rh
	traftQVKWxa9UratYv3OSPJ25/K/vaqR+qEEZWhfhRgaNOwW+lVAbU55iZOXdoEd8B1Sq7M8QVsqI
	j4g+gI8QtJPBlf18hC+FQfcDp4BZp6WyQGlL/QCiEKhj1Tjz/ViGKZj+DR6MGTPGgCWQTOl9HkL1z
	IyJSoUzVXm1eM+OQtCt5PIkJ+XYHHdPacZqeYRoFuLjbuhhHSCzOyDy72gCzv5hxUcoOnhM+0zj3O
	myzi7G2tZvIBhNHlqC2Ivp0VgH7KW8vCGZyb+ztRHk8mmtHgaQUDGSOIqChABCmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjHRQ-000000075Hr-3dSz;
	Wed, 28 Aug 2024 14:06:25 +0200
Message-ID: <f340bcec6b6a0cb4d970c8961cc6b21cf9e8691e.camel@sipsolutions.net>
Subject: Re: [PATCH v3 8/8] wifi: mac80211: handle
 ieee80211_radar_detected() for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 28 Aug 2024 14:06:23 +0200
In-Reply-To: <20240711035147.1896538-9-quic_adisi@quicinc.com>
References: <20240711035147.1896538-1-quic_adisi@quicinc.com>
	 <20240711035147.1896538-9-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Btw,

> +{
> +	struct ieee80211_chanctx *ctx =3D
> +		container_of(chanctx_conf, struct ieee80211_chanctx,
> +			     conf);
> +	struct ieee80211_chanctx_conf *itr_data =3D
> +		(struct ieee80211_chanctx_conf *)data;
> +
> +	if (ctx->replace_state =3D=3D IEEE80211_CHANCTX_REPLACES_OTHER)
> +		return;
> +
> +	if (itr_data) {
> +		if (itr_data =3D=3D chanctx_conf)
> +			chanctx_conf->radar_detected =3D true;
> +		return;
> +	}
> +
> +	chanctx_conf->radar_detected =3D true;

It might be better to write the end of this function as

 if (itr_data && &ctx->conf !=3D itr_data)
    return;

 ctx->radar_detected =3D true;


to avoid the double setting.

johannes



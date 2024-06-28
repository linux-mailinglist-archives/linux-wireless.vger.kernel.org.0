Return-Path: <linux-wireless+bounces-9683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B4C91B9A6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 10:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32C228333A
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12E65024E;
	Fri, 28 Jun 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QLN//UBq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753E79D1
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562595; cv=none; b=D3xIQhcAW+YhCffc97GDg9CGYQoLvh8UY5uvohKm4gB0CBMsgn/gBPN9VookIQFJYFAx2XAHkbopRj1cfVMl3mMTxV3AAvt7a2VhfWaEX4M0LMVigLb/BLaGMokrLytHxc587sjPbuwBMwhzc5bD1caae81FqQCGCblvDu3BPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562595; c=relaxed/simple;
	bh=jkbcDfApoc3a6kTQRVt67Wi83hbaduOJIrtK6PDrWIU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0nLqZDN6gwFx3zNB8oiVTZCXYDhJDj7QKeEnl3GZw2s946y4SO9ujTGrnV0wPNfYj2Q42AYlsNZrx3rS1gsGODOyh3QM/mq0tZkDzhP21op+uLvv3hC0L6ZReAwcVNB2hRbdy06RxLIAjFLJV9Du3mTBbOXy0TBUqrIeMB0ygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QLN//UBq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9nmE9a3gJXPwiVvhVnNyIAtbt7fKAiKt89PIciBVLNw=;
	t=1719562593; x=1720772193; b=QLN//UBqJoy9Kv7Hh9LM6Gb4YUIun24/FHU6CbOOtcKVgU7
	KJlZvsL0XWUynRkuCUZQv/zqnjGQc+P0M9kibUsD4eMF/QHtBkV3/9o0pjylpWd1sxd8eRAi0ZI8s
	lvQqdNwwGPBXsG4FhFEyk00jgYuc3XE819SkAiMbV/DnoTzR6rYRMTtElAzjPM/+phOruOiFwzwNo
	XLl4FH2Cn2XvceeThV124KNWVwGGcr2VH96uGySnupV+erz2g4kEz4Cs2MdEroPeLcFASIMuAJdFv
	SZ1x7IbGPgWjNVEHLP0LdFHlxn1/sPyPRzDO/O9q6L3AmH6eqisPN5deAvVBsNdw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN6mR-00000009VCd-0ngL;
	Fri, 28 Jun 2024 10:16:27 +0200
Message-ID: <ba67b440b18876ca4e296a66a5197c2be81921d8.camel@sipsolutions.net>
Subject: Re: [PATCH 03/10] wifi: cfg80211: extend interface combination
 check for multi-radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Fri, 28 Jun 2024 10:16:26 +0200
In-Reply-To: <47e02b920cce18ed56e3fa7c93537124ce10024a.1718881762.git-series.nbd@nbd.name>
References: 
	<cover.a7730420cfba0f204a60e4c30e6b0e07b441ff6b.1718881762.git-series.nbd@nbd.name>
	 <47e02b920cce18ed56e3fa7c93537124ce10024a.1718881762.git-series.nbd@nbd.name>
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

On Thu, 2024-06-20 at 13:11 +0200, Felix Fietkau wrote:
>=20
> +static inline u32
> +rdev_get_radio_mask(struct cfg80211_registered_device *rdev,
> +		    struct net_device *dev)
> +{
> +	struct wiphy *wiphy =3D &rdev->wiphy;
> +	u32 ret;
> +
> +	if (!rdev->ops->get_radio_mask)
> +		return 0;
> +
> +	trace_rdev_get_radio_mask(wiphy, dev);
> +	ret =3D rdev->ops->get_radio_mask(wiphy, dev);
> +	trace_rdev_return_int(wiphy, ret);

I'd tend to prefer tracing even if it's not implemented, so we see
what's going on? Though personally I guess in this case I don't even
care much since mac80211 will unconditionally implement it ...

> @@ -2366,14 +2374,19 @@ int cfg80211_iter_combinations(struct wiphy *wiph=
y,
>  					    void *data),
>  			       void *data)
>  {
> +	const struct wiphy_radio *radio =3D NULL;
> +	const struct ieee80211_iface_combination *c, *cs;
>  	const struct ieee80211_regdomain *regdom;
>  	enum nl80211_dfs_regions region =3D 0;
> -	int i, j, iftype;
> +	int i, j, n, iftype;
>  	int num_interfaces =3D 0;
>  	u32 used_iftypes =3D 0;
>  	u32 beacon_int_gcd;
>  	bool beacon_int_different;
> =20
> +	if (params->radio_idx >=3D 0)
> +		radio =3D &wiphy->radio[params->radio_idx];

Maybe we should have a sanity bounds check?

Or even really just __counted_by() annotations in struct wiphy_radio, so
we can run with UBSAN in testing (which would be a comment for patch 2,
but I'm not going to send it there again ;-) ).

johannes



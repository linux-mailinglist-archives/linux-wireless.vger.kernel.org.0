Return-Path: <linux-wireless+bounces-3648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1E6856E02
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7AC1F2636F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09C1386BC;
	Thu, 15 Feb 2024 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="c2I7/qgB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7C41A81
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026501; cv=none; b=NbksvQ8DlwKdwuiHLjTWbqVzx3VYA6vRE1QFE/OG8c9ERmJMYhWaWC3XG9AL+3+MsgX5GKtj1zNY4+rebvsNTJaArtwz0p6WvxKb7TlXpqQB1SqEE5hKj6IgTYqmtrMyp3Px5qCcpdBFB2iI0DKmWbAgTrhIHtW3/qIbtjFGl50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026501; c=relaxed/simple;
	bh=eLbnxbnJcgr8tLDJOMC5yB5Uur1Rhi4U1TD5e2fthDs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8+4/hu5t0kF6kgsHPl5nMWbHIpd1qI1t8K+6MjkE4g+ksGyvkwOti/nR6mTZEzCXLZzXfruATQakvfdwc3EQE1yWi6tIUhIIhld6fqI2cyWHzPuyUGhuXFNCU/59lAWtxfvp73Ub6ceZpi5PT923YrZiE4eDAyyqDPO0Bwnml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=c2I7/qgB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qTMIj5Xju7s3iPo1QndBgRckeUp0gN1roTcBCYI+bLk=;
	t=1708026498; x=1709236098; b=c2I7/qgBTfgiEFsas2bs6z5cqbK8weOvmcwrX3IytYgewDb
	KdNI8SW7ULNHVO7qfDadeM2GKPhX6xFijh7s84CPsHHLUsA97tkteCCx0zcmI7cTOamYngh//zaS/
	Bdldjaa535OkfZpT3CECD7OCyjyaJMHF67mwGg9JI6Vl7gCd854ao/efujEtVmx1wPIC7pbM6r/xi
	gHX4MyuujL378QRQQXJjUmY2k3k+p4+sdLG7Qz5kjcVEQJBiPatxSkA3+73UqX/jVqoHhcqPF2j9i
	mdmPKf2RUp8Bd+mE4Eo4nc8R93+oGKXa2ET+bGt0OgsIq65Zyr9V+0dyv38U88AA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rahiK-0000000BCZa-3g2a;
	Thu, 15 Feb 2024 20:48:09 +0100
Message-ID: <189c5d80de6b640686030eef00a1c82f191e5cac.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: check beacon countdown is complete
 on per link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 Feb 2024 20:48:07 +0100
In-Reply-To: <20240215162811.506065-2-quic_adisi@quicinc.com>
References: <20240215162811.506065-1-quic_adisi@quicinc.com>
	 <20240215162811.506065-2-quic_adisi@quicinc.com>
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


> -bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif)
> +bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
> +					 unsigned int link_id)
>  {
>  	struct ieee80211_sub_if_data *sdata =3D vif_to_sdata(vif);
> +	struct ieee80211_link_data *link;
>  	struct beacon_data *beacon =3D NULL;
>  	u8 *beacon_data;
>  	size_t beacon_data_len;
> @@ -5106,9 +5108,17 @@ bool ieee80211_beacon_cntdwn_is_complete(struct ie=
ee80211_vif *vif)
>  	if (!ieee80211_sdata_running(sdata))
>  		return false;
> =20
> +	if (WARN_ON(link_id >=3D IEEE80211_MLD_MAX_NUM_LINKS))
> +		return 0;
> +
>  	rcu_read_lock();
> +
> +	link =3D rcu_dereference(sdata->link[link_id]);
> +	if (!link)
> +		goto out;
>=20

Maybe that should be a warning too? Not sure I see any case where the
driver can/should call it with a link that's not even there?

Oh ... and maybe it should check if the link is active? We had the
sdata_running() check before, but that doesn't mean much for MLO?

Though then again we have the check below anyway:

>  	if (vif->type =3D=3D NL80211_IFTYPE_AP) {
> -		beacon =3D rcu_dereference(sdata->deflink.u.ap.beacon);
> +		beacon =3D rcu_dereference(link->u.ap.beacon);
>  		if (WARN_ON(!beacon || !beacon->tail))
>  			goto out;
>=20

So that will just be NULL if it's not active... so I guess that's fine.

johannes


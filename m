Return-Path: <linux-wireless+bounces-21933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A55A99589
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039669239D1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE9267F45;
	Wed, 23 Apr 2025 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZhUzAPlo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E9288C8A
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426132; cv=none; b=ZsWF3IX4BsTA6iVGCBqq6MxWt9jy5SUpfWbqdjeVIiY6+4+bxsF453mqGvbX+ASiYDzH2J4P3hg6jrtcLmAzuGFw1M95VgodI7iuPxRhcnSocR5RjiJ7DsOfZYUpQ5NlUR3YkNJ6bYIUbHkINBussDaZcNjUCRu44FMLfkK/RvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426132; c=relaxed/simple;
	bh=RD9ieeiN1Kjul8bwiNjdrFbb75FihL1uw+QFk14WRCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qFZrJsMc852KiXtvooEsyliiaIQN9A0o1nCtaX+P0bpdGWoCivnvVjOvBfRfJMD9oJmQ6waFCSKTYUcdFrcelJ8yuztTxy0ip7TAXH4YCkvJu4xbQVilGjJtclLt5J2DL6YlzhluEAlFb4d3+zMme7+oeqNTCYsLotX4zrtrCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZhUzAPlo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I2DJOp4Vl6I/kLhLMoE5SiWMe7apQTIR8KD81E6UK9A=;
	t=1745426130; x=1746635730; b=ZhUzAPlodOgfvpz9xrOEFxsy3WTDNJ978c8HD/5q+WsUtPH
	QitaPJvHQlF9W2jZFEana/6I6H4kcYTfXoCAUgTJB6TcqsFr9ELX1l5y3NMYyzK1Jc1raH6UpX+YP
	siPxoaHDk6hN1hRMAjxtkzchLLF2p7ONG9dVb/OHIj91F18TWz1abIZq+LDB6ZZtIPZIV0llYnXJT
	q/1do1O3feX+/IiEzLF5yLOYcmMia102djaCVjDHv6VPhizceFdh4kgTuyBoYD/Te3AxOnPmQN9vv
	CtOsCgUUt3jedkL+7lqJYFKpF3KH4BTyY8tVoLG7WBTKyL36G6lfZmTUri4KuRgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7d4J-0000000Es4T-0Ygi;
	Wed, 23 Apr 2025 18:35:27 +0200
Message-ID: <253c8d56425a7549386fd6f0072293f608cb89eb.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 01/11] wifi: mac80211: add support
 towards MLO handling of station statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 23 Apr 2025 18:35:26 +0200
In-Reply-To: <20250415042030.1246187-2-quic_sarishar@quicinc.com>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
	 <20250415042030.1246187-2-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:


> -int ieee80211_ave_rssi(struct ieee80211_vif *vif)
> +int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id)
>  {
>  	struct ieee80211_sub_if_data *sdata =3D vif_to_sdata(vif);
> +	struct ieee80211_link_data *link_data;
> =20
>  	if (WARN_ON_ONCE(sdata->vif.type !=3D NL80211_IFTYPE_STATION))
>  		return 0;
> =20
> -	return -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal=
);
> +	if (link_id < 0)
> +		link_data =3D &sdata->deflink;
> +	else
> +		link_data =3D wiphy_dereference(sdata->local->hw.wiphy,
> +					      sdata->link[link_id]);
> +
> +	if (WARN_ON(!link_data))
> +		return -99;
>=20

nit: _ONCE? Not that important.

johannes


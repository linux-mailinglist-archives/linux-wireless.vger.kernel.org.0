Return-Path: <linux-wireless+bounces-5210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF4088AAE4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EAF1F3D842
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0332013D63A;
	Mon, 25 Mar 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UKAPQrXF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E913B5B1
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381424; cv=none; b=dGXZ3HT4xHq6N7YFpBy+p95xaVkn8/yKWVUjhsHrlRUpPr0gtG8jI4Oa4Uf+vEHbhlL/0RJuF4pc9sIYKxjt9NLXA7bFLFl8IMpL7XG3I1y5iFee6x2siI+pu+oHzylhv+dhj1E6x/ElFrMwDUTmYHTdEirmQXR50Bwa28j35z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381424; c=relaxed/simple;
	bh=xwa2f3nknM75qBmMc0nEUshQMPONb3axZRAIcOphsWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vs3W+Y0Pj5EIjr9QtNHs+N3ne7wJLu1jfj7VvlTalRHnd+F4S6h4EzQEHe/rIP9afxyEFlETN0mqXvK9HhvcgchrRmVo/QbTiZufEnfXYUuvw9jHUHfLJvSccf0jqVcrk6SYBE++M0P18+uyKEVfleUVic1sR+eP8zo2JZMld+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UKAPQrXF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Sy4fjWaAdBKAu/EG3F3ubpkpdvObIYk8CjnS0nfnncU=;
	t=1711381423; x=1712591023; b=UKAPQrXF8UFFB0qqu1I1uVYXF3oPCENDQOcumVDpZXpxtff
	yAAxi51PZXAi9Sjkyzvijl9ZlkL10FWG2u3mpApaZiRgyKz6SacMQs+k4UY8keuktabhiylqq+KST
	NiPq3SScYvfd1qehES2yE1dNOAWhu5rwxLydEmSfBHPcOTk0COq+Gw08O6Lu848Is7mUSrtmdOm/9
	oG/KHOCfZppu00cpdMj4alsoVIq8Q3vp/0kB3SzyYj80IYPizDJZNIgvXk5mua8vDm6lGEcnjMdzp
	eYAAGySou0MSNgzM0Sf6isjchoBdGGJfX5+DoxJBmvDnROTC4tU3iqRih/6YyUsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1romU8-0000000Dv5M-1Ce1;
	Mon, 25 Mar 2024 16:43:40 +0100
Message-ID: <d364e872eb29f03236630bab49a3243e2118ab22.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: Add support to rx retry
 stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Hari Chandrakanthan <quic_haric@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Mon, 25 Mar 2024 16:43:39 +0100
In-Reply-To: <20240319134522.4021062-2-quic_haric@quicinc.com>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
	 <20240319134522.4021062-2-quic_haric@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-19 at 19:15 +0530, Hari Chandrakanthan wrote:
> Add support to count station level rx retries.

Should the subject say "for ... stats"?

> +++ b/net/mac80211/sta_info.c
> @@ -2653,6 +2653,11 @@ void sta_set_sinfo(struct sta_info *sta, struct st=
ation_info *sinfo,
>  		sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
>  	}
> =20
> +	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_RETRIES))) {
> +		sinfo->rx_retries =3D sta->deflink.rx_stats.rx_retries;
> +		sinfo->filled |=3D BIT_ULL(NL80211_STA_INFO_RX_RETRIES);
> +	}

The use of deflink here seems ... questionable?

I know we've not really done any stats properly here for link STA
(patches welcome), but I guess this could be a first one that at least
sums up all the links like all of these should, and then find a way to
expose per-link as well?

Although possibly we should just expose per-link to cfg80211, and then
have cfg80211 sum up for the MLD representation...


Either way, seems odd to add something now that absolutely cannot work
for MLO?


johannes


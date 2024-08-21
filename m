Return-Path: <linux-wireless+bounces-11743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C39B959B46
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 14:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527391F225B0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 12:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D5914B979;
	Wed, 21 Aug 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lL7c/10f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7621D1305;
	Wed, 21 Aug 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242132; cv=none; b=WQJUyVPbN4VcaYl458gjEypZtmzyEQAKtdC+maaW7zOHiX//prvMiUwHb+S+4nce/LsC8ar/QjmV+dci1fgYES3dOzkHr7RB1h9XGgHjnV/OHPrpueuU4O3OTRWtyLJzv6CVrA1oWmO5SVxc7KEEUa3vBmSCKCinVrGhObw7WHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242132; c=relaxed/simple;
	bh=dbe4R2RH0+1sKJgg7eyP6A1jmv60YMmn98/QNoWzjVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEn45CizjVQJURp2RAemy7j/J/nfHrfMXL46LKYDleMHolFfF8EtvNcPjQkjonNnXInVPTxLRAmw9Wuv+wFzr7hKZu8z/1FTv025C9vGkrbDsLgANlNEJHeGilwwsVSTFyzKwlHde86zFzwER8DlxDKMD7RpJvGwk7yV0D+glT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lL7c/10f; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id gk8rsJdOxbNNsgk8rslcHN; Wed, 21 Aug 2024 14:08:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724242128;
	bh=8d0PHFEsYGqdYcAk4Zd+FDA5jBt+ta/EhSh+bgONbM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lL7c/10fbRpVHzqiq3ccePD1+sBQ+u0AjUfgzfq+XD11F0fKwDwKnuoX9Xwmd4vIS
	 hiUEg725rc6Dgb1xlGcpCjHFDbfP0MzkZt4L7AZNnKurA2ZKpPDuwUIyJ1k4G/oRTE
	 OZiwDFrvoXywlTpKs9hngJa+hgwMkcRue+1Hv2+vJsYiTJsqWAR1r7ZxMrDxNUuZ4+
	 TVwS7t8HhkVPcwp2hcuqNd6OOr43YrQMEnC+rQehK2DSktBvQ60QZ7Dg+x+iP6/Hkj
	 yQAJpL3RmkyRpJFPqBUQaJkhvgLv0Rrea/KNCHU4CyHsUreFHvSW2RQDM/WIzzbNPD
	 pGkJ4Ov0RvILg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 21 Aug 2024 14:08:48 +0200
X-ME-IP: 90.11.132.44
Message-ID: <9a5de847-0913-420d-8cb0-35d95376ae5b@wanadoo.fr>
Date: Wed, 21 Aug 2024 14:08:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: cfg80211: Use kmemdup_array instead of kmemdup
 for multiple allocation
To: Yu Jiaoliang <yujiaoliang@vivo.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240821111250.591558-1-yujiaoliang@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240821111250.591558-1-yujiaoliang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 13:12, Yu Jiaoliang a écrit :
> Let the kememdup_array() take care about multiplication and possible
> overflows.
> 
> v2:
> -Change sizeof(limits[0]) to sizeof(*limits)
> -Fix title prefix

Hi,

this kind of information about differences between versions is usually 
below the ---.

> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

It is not because someone makes a comment on a patch that you should 
automatically add a R-b tag.

> Reviewed-by: Kalle Valo <kvalo@kernel.org>
> ---
>   net/wireless/util.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/wireless/util.c b/net/wireless/util.c
> index 9a7c3adc8a3b..e7c1ac2a0f2d 100644
> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -2435,8 +2435,8 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
>   		if (params->num_different_channels > c->num_different_channels)
>   			continue;
>   
> -		limits = kmemdup(c->limits, sizeof(limits[0]) * c->n_limits,
> -				 GFP_KERNEL);
> +		limits = kmemdup_array(c->limits, c->n_limits, sizeof(*limits),
> +				       GFP_KERNEL);
>   		if (!limits)
>   			return -ENOMEM;
>   

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Now you can add my R-b :).

CJ


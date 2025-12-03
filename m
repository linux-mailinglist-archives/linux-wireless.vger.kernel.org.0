Return-Path: <linux-wireless+bounces-29477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5F4CA0B17
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 18:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA50F30022B3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2702532ED3B;
	Wed,  3 Dec 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=rolf.reintjes@web.de header.b="vSlt/Zf0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447C3074AA;
	Wed,  3 Dec 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784671; cv=none; b=aWn8Ic+Fp054Wx3nRwEwjZ3rBmNBdqTzmlKDmca3sE8OKiymu0AuyV/i4aHk25h9BB9WTwky323EbDB4SXj+37pqzZt4tsF9n9NmNYKfHI/Eh1O27ji33YoDjtjR7m1QC2AbqKFZN75BO1VITIuSI91gZm1C9C95rCmuOVy4ov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784671; c=relaxed/simple;
	bh=X1OSOWOFVJCki8b/Hei0b1WQPdBVrwZG7Jx4oalEfCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKoGvfAYmZv7Tq+nbfpL5Nn7UUeMJUsLdXNm3KxgGQOH1/CrCaJVy72GUzkobHHoqaF6gFfcRTfIXovlJ52iOzLFWovCyLgDEqlXMX1SUOthxQTdWek7T8P/oOiwUwWF7+hk2smkqEDgJwgB4vilqXt+GWcYrd4oqDiGv3TNjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=rolf.reintjes@web.de header.b=vSlt/Zf0; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764784661; x=1765389461; i=rolf.reintjes@web.de;
	bh=OM53+Ni+UBk3+g8JiNhNXxz32Fx+ZFG6wNLxJ1ENG5I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vSlt/Zf05X2MHc6B+1Oy4i6BudlEh85pYNM2F31IwUPt7XxbZSRfZpVGjgD+tzHc
	 iq/Ylnoj7/lxBPbBuaoCT1cr6BPunJQfwyeVUrFivMv7B5HOVX7zadLk/R7SgcWNy
	 1dSOFF2PasQu6cT3spcpPZ6g6PLTWyM/eD1sq0jqAK3tHmeMuD21g03AvvvwRShVG
	 6fat3cT/Xf8y0nIroKqTJVVNqtWgVsT9gv4mOPbbCj3rXyxpoiW/0nPPM6Ci+pEIm
	 6nnb4bEOv4zom0fO9QLzuypBib0IceuOKLkAfxmKwkNHvgmJqc7kh43zhBG/kmS7i
	 oQQzaPGSHSTzo2NUdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.188.20] ([94.31.68.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxHYK-1wFUon1AFM-014eXN; Wed, 03
 Dec 2025 18:57:41 +0100
Message-ID: <3204ebc0-4432-467c-81fe-9f09427b1671@web.de>
Date: Wed, 3 Dec 2025 18:57:42 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: sme: store capped length in
 __cfg80211_connect_result()
To: Dan Carpenter <dan.carpenter@linaro.org>, qgeniecore@qualcomm.com
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aTAbp5RleyH_lnZE@stanley.mountain>
From: Rolf Reintjes <rolf.reintjes@web.de>
In-Reply-To: <aTAbp5RleyH_lnZE@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ULe0Ehm38uUVNXqaBQ25r2SKlMO5jYZ5qAz9CQieZ/l//PHEsS
 0Hw4GWDoWKBwzsRNx0/1fj7YVQAImQ2WT7KzGTbT9CNVcH30ok1Pc5eG1sf4WYimdmOm0ws
 XE57uJ55HVRguhtQbGlOQhqYsQZOBJ+qu2HN9etxyTk1mtjNlf/P/QhcvaAx9un5ad8edU/
 xACi+gfoP5YCzn2fFLzNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AOAoNnvEVSE=;Psfcvy7vzScXF51qDR/zJ8BbqU3
 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

Hello Dan,

Am 03.12.2025 um 12:14 schrieb Dan Carpenter:
> The QGenie AI code review tool

Could you tell us more about this tool? Is there a web page of this=20
tool, how do you use this tool?

I found https://qgenie.ai/ but this is not a code review tool.

Rolf

> says we should store the capped length to
> wdev->u.client.ssid_len.  The AI is correct.
>=20
> Fixes: 62b635dcd69c ("wifi: cfg80211: sme: cap SSID length in __cfg80211=
_connect_result()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   net/wireless/sme.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/wireless/sme.c b/net/wireless/sme.c
> index 3a028ff287fb..4e629ca305bc 100644
> --- a/net/wireless/sme.c
> +++ b/net/wireless/sme.c
> @@ -910,7 +910,7 @@ void __cfg80211_connect_result(struct net_device *de=
v,
>  =20
>   			ssid_len =3D min(ssid->datalen, IEEE80211_MAX_SSID_LEN);
>   			memcpy(wdev->u.client.ssid, ssid->data, ssid_len);
> -			wdev->u.client.ssid_len =3D ssid->datalen;
> +			wdev->u.client.ssid_len =3D ssid_len;
>   			break;
>   		}
>   		rcu_read_unlock();



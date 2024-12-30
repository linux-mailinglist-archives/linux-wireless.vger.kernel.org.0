Return-Path: <linux-wireless+bounces-16906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06B29FEA2A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F3F1616BF
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 18:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEE195962;
	Mon, 30 Dec 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Xy9buY5u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2F3183CA9
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735585144; cv=none; b=VgUU8qi1AB+xz/8A/Xft7ZnWuYCY+oYjMxLWBaKocVa0g5kxsjLlpklbZhDKldj6m3vei2zMKr/7+ZKxQtyBPtkXnt9yzerAbpu4BFgDQC1kBiP1w/6tm1dYoeG3758glfLtItDqyumn/6+XDq3u67W3edc1byj00eX+00HwfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735585144; c=relaxed/simple;
	bh=2Vu4MKNp+EqWpbPDcDz8D3xOs/5yZJnCrwCRxpg8TCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLPSVkY4IxiLKZWiX2A9BjNTxrFvBQAMvDtR8vBx+JOEh1JyowRdipkJJtB+H8fVojPwyBWlrqb+hps1IrXbFNVxgGd+b4OesObKXgIBwa7twIX8O0i9DN18EMuWrnERlycIFtH7e0sYrK1u8QP6i77VFsttjwcpqx0Qm0ghUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Xy9buY5u; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id SKZstDqNYrKrbSKydtnmOl; Mon, 30 Dec 2024 18:58:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id SKyctZDRY8PtxSKyctb7R8; Mon, 30 Dec 2024 18:58:54 +0000
X-Authority-Analysis: v=2.4 cv=Fegxxo+6 c=1 sm=1 tr=0 ts=6772ed6e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=HzknnYLZR2HJs7vUogPF2w==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=stkexhm8AAAA:8 a=vaJtXVxTAAAA:8 a=Q7eAwv5LbReZNifcBNAA:9 a=QEXdDO2ut3YA:10
 a=pIW3pCRaVxJDc-hWtpF8:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g4Qk/pyUxqrvA95lxwblBKetiWLPbZbxyCsJ+ygo2qY=; b=Xy9buY5umY7QKpl+31r1v4/b4N
	dZChiohxE51VeO26sEFnPPOAeVPNwK0GeMrook8d0H/FeWA24ehS9fff4fqP7t5MzT2kqk/2c1Cb5
	IMKLg15hOHJWIZIlWymIDRqCyg8HMAM67qZ45hS7h2XPGMuNwB0Ejhae4FOJ8mRJn+CCnGySi8lQ6
	HojFAsydXm9+Mse8OW+E9Tz9KXPRn0bnwkl1r23esYeGilEv5kMdqpd9OxLKEM9zSDU8e8eK1vB4n
	32IT6sxWEyZvPg8o5p0rQD4BKA28Pjqp6s1Jcn742uwTJBUkWSt3eyuKDglJoD7JddA2+qfZGvC/a
	MQ8w72tQ==;
Received: from [177.238.20.5] (port=1078 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tSKyb-002wXA-1h;
	Mon, 30 Dec 2024 12:58:53 -0600
Message-ID: <68b4d078-f275-4e42-8eba-e6002bd3db59@embeddedor.com>
Date: Mon, 30 Dec 2024 12:58:46 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: Move cfg80211_scan_req_add_chan()
 n_channels increment earlier
To: Kees Cook <kees@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: John Rowley <lkml@johnrowley.me>, Dmitry Antipov <dmantipov@yandex.ru>,
 Nathan Chancellor <nathan@kernel.org>, linux-wireless@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241230183610.work.680-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241230183610.work.680-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.20.5
X-Source-L: No
X-Exim-ID: 1tSKyb-002wXA-1h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.20.5]:1078
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOPFqvzMpbFqLDJiABJZBbADSnmZ6BO2YqLb43EvK1cSo17/plBHD2tfSmcqTrXuREDOUlk3ibXKBBex9Ey+OxPRpLp7YZHntG4wsDddLth8Hd2hC5MA
 cZhLskVsfxvduOym4iJmsCXwoqtYz/dE+8UKxR6mvVjuqLOzLyFNbJf34gyXiUMeqvGQy7yw9Hiic87Yofq//4VRscFt0OJrd9guCkZAUCP1/WTTqdR5GU9y



On 30/12/24 12:36, Kees Cook wrote:
> Since adding __counted_by(n_channels) to struct cfg80211_scan_request,
> anything adding to the channels array must increment n_channels first.
> Move n_channels increment earlier.
> 
> Reported-by: John Rowley <lkml@johnrowley.me>
> Closes: https://lore.kernel.org/stable/1815535c709ba9d9.156c6a5c9cdf6e59.b249b6b6a5ee4634@localhost.localdomain/
> Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

-Gustavo

> ---
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> ---
>   net/wireless/scan.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/wireless/scan.c b/net/wireless/scan.c
> index 1c6fd45aa809..ccdbeb604639 100644
> --- a/net/wireless/scan.c
> +++ b/net/wireless/scan.c
> @@ -763,12 +763,11 @@ static  void cfg80211_scan_req_add_chan(struct cfg80211_scan_request *request,
>   		}
>   	}
>   
> +	request->n_channels++;
>   	request->channels[n_channels] = chan;
>   	if (add_to_6ghz)
>   		request->scan_6ghz_params[request->n_6ghz_params].channel_idx =
>   			n_channels;
> -
> -	request->n_channels++;
>   }
>   
>   static bool cfg80211_find_ssid_match(struct cfg80211_colocated_ap *ap,



Return-Path: <linux-wireless+bounces-14619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CC39B3E0F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 23:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF3F282D93
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 22:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DFF1EE012;
	Mon, 28 Oct 2024 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="KDqEgtJV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB91D6DA9
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156100; cv=none; b=rPL+giDtCmvwQ+M6Mxvfmr7oNeDpT7VjX8vHIRj5M3/Vr5UM15vSCSrg3YUkpjfy09EzNs2JiHOlE2O64+TX5iFcVqjuSILB0n+9jmG0Wb3Fwg0MPcTHIQ7Qgkj9u8HkNz23IuZFvbgJ2+hHAQTksE4QsWOo5bI+7hkjHu99wF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156100; c=relaxed/simple;
	bh=yCSV5oA6Zi5vy42jcUGIoaYVg/PwX8oKXab/9iKXXoY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=szElKYYsKxSdGciHL/RiU8B/MzgmMIda+iZ+dgrBQz1CjZGYtxmFTZB7eUKhkBlaYcW8UNM3rqZO947qdoMUHFKhIkSJjqKRrHP2FysCvFCK5SsSv+iA5AA+WXrrP3uMFQM+Ky8YhHKKsjklS1mZul+kSWKaFJkji3LQI9xx4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=KDqEgtJV; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id 5SZFtVN83vH7l5YdPtRAnq; Mon, 28 Oct 2024 22:54:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 5YdOtDPIa65gF5YdOtYIks; Mon, 28 Oct 2024 22:54:50 +0000
X-Authority-Analysis: v=2.4 cv=Z58nH2RA c=1 sm=1 tr=0 ts=6720163a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=yWXUFX9rlBBmrxmJ-CsA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N8rh8UccSxfCAXceDRttLBK5ahWGQ9o21o6gNEaCm0Y=; b=KDqEgtJV7zN7iVPqJkOfiiJTPJ
	Ixt3jsBW4jTJliPioPnjQAJGwtN7+WbvP9JN7shJuJoS6q9fiFHKKjK18t+e15JdAliudCx7UA5gO
	MnHCCKkLIx5Xq+2TKdrGuo5WSPYqsEyx9hsRVJwaZfOn/YMvuE4DOWht/dlR5HcfZTY6Yr/2gwSRK
	rVSWALkg4r6/z1dCIMlK5gckNoHaihRpBq+22XiKktqzm2R4wYkFQhbxgC7ssJNHGkum0C31eqBgR
	TTqYQce+pafPZXrEaJck8bWnTXEA7w+JIvE7uaJXp+HjzH/26Bw4eEuCFjlOWUS7s2iKhPwcKRrXf
	1Y+1CUzw==;
Received: from [201.172.173.7] (port=37892 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t5YdN-003EpK-2M;
	Mon, 28 Oct 2024 17:54:49 -0500
Message-ID: <bf27a7bf-04ce-4720-a13c-f19e0069541a@embeddedor.com>
Date: Mon, 28 Oct 2024 16:54:43 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
To: vvvvvv@google.com, Johannes Berg <johannes@sipsolutions.net>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com>
Content-Language: en-US
In-Reply-To: <20241028-nl80211_parse_sched_scan-bounds-checker-fix-v1-1-bb640be0ebb7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t5YdN-003EpK-2M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:37892
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPVEq3sphMgn4gGJmPcVDNQl+RrAi4d9RoyNt3iHD2wTkGOGMJc6I9aF5F11oSMkY/N1834x5PFF/5Xm/IzeQ63jCoY78gh44CJFJmgleNgeMtsL5etw
 T9lmEoIwk2kY1PMhhn1nZxemu6w9Mxr3ARsZjpHSTb1oz3OmOljvwqUpuAu4Z5OFQOLf3nTIJh0ZG9+32nXf7qW7pZUZcr7RcmGMwtLcWNQ+Cef6AQKIFsF8



On 28/10/24 16:18, Aleksei Vetrov via B4 Relay wrote:
> From: Aleksei Vetrov <vvvvvv@google.com>
> 
> The channels array in the cfg80211_scan_request has a __counted_by
> attribute attached to it, which points to the n_channels variable. This
> attribute is used in bounds checking, and if it is not set before the
> array is filled, then the bounds sanitizer will issue a warning or a
> kernel panic if CONFIG_UBSAN_TRAP is set.
> 
> This patch sets the size of allocated memory as the initial value for
> n_channels. It is updated with the actual number of added elements after
> the array is filled.
> 

This should include the following tag (and probably CC stable):

Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")

Thanks
--
Gustavo

> Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
> ---
>   net/wireless/nl80211.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index d7d099f7118ab5d5c745905abdea85d246c2b7b2..9b1b9dc5a7eb2a864da7b0212bc6a156b7757a9d 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -9776,6 +9776,7 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
>   	request = kzalloc(size, GFP_KERNEL);
>   	if (!request)
>   		return ERR_PTR(-ENOMEM);
> +	request->n_channels = n_channels;
>   
>   	if (n_ssids)
>   		request->ssids = (void *)request +
> 
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241028-nl80211_parse_sched_scan-bounds-checker-fix-c5842f41b863
> 
> Best regards,



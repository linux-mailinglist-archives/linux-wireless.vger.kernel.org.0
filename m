Return-Path: <linux-wireless+bounces-15692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FBC9D8AA0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 17:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11572282125
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582A1AD418;
	Mon, 25 Nov 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Ju4U8z5U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25F2500CB
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 16:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553428; cv=none; b=JpvTS/VltNIiVeBSqUPkLDAeKspe9NknHD/aZm+PfWL/RhQyE04x5UzoTU45Rzib9zAIL3OJIMjk1mpMEiDhm9D02Asg8Y7ZquIykVfmbPrp57aO59/QEY/u7PlJHTc3o+9ruRG1a/O+b84hSlKQB34gqWkTRjpNhHQ3+BjVM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553428; c=relaxed/simple;
	bh=Yu/+NP9AobvJs93H8yUtukZ0L4/B3zu9Nh3of63N92U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLkCjEgOpdMNbmpJL/DoPnomLsJvevsMeB1vYUzo5TWDYWxN3UGlwp6O4C7aqKFKnBQX1MA9Zf2p0PDP1q+H7em1sbB1tN3LaoRzBypFVRxD1fN1mugfhxgnMjm3X+5isT+rLyKHe7T+WXtoWwpkMzClV9hZgfVVEWJ9KS3T8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Ju4U8z5U; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id FaQ3tQI6vumtXFcGYtSvqm; Mon, 25 Nov 2024 16:48:50 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id FcGXtJ0Wwbs9MFcGYtB2Qj; Mon, 25 Nov 2024 16:48:50 +0000
X-Authority-Analysis: v=2.4 cv=FY0xxo+6 c=1 sm=1 tr=0 ts=6744aa72
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=12PADHrDYx-1QOupR7YA:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=79KlrPkTs4rK20YKrDZnRsbA4oeLIskWUIi7/e1prQk=; b=Ju4U8z5UJHz+7Qa/ohUdgaRyQp
	2MLPpMcTkQiq2skf1Wbftz3mSFhn/U+7KxOh3QIlX3GzcFMlSenMxBmS+gNyq1uEa99b9s1jZTwBG
	A0uA6eWUy8AR3W/HZXxMMcuWUCaThjjqEiDRqSJlGRetRmCn++3BibgERjHfvMzz3WzfihZDx9e17
	ftmYBlYa+foAnbcE4nHmFdO9Uo2FA+szyKQe+lWvzWrwBCZbyehyuTwhwp+XZwaHqmk22xDgesiyq
	rSeQu7AE/WNOSGI7B+HCovz5UEsT5ZLlvWWhIe4TF3xgvZXi06UdJk+YiEB4KLZpW6ngvhOfc8AkS
	BtA2e6rA==;
Received: from [177.238.21.80] (port=33066 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tFcGX-000OdC-11;
	Mon, 25 Nov 2024 10:48:49 -0600
Message-ID: <aefe4a2a-7adb-49b0-9d8a-32d129ad918d@embeddedor.com>
Date: Mon, 25 Nov 2024 10:48:41 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mac80211: cfg: Initialize cnt before accessing elem
To: Haoyu Li <lihaoyu499@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva"
 <gustavoars@kernel.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20241123170848.309264-1-lihaoyu499@gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241123170848.309264-1-lihaoyu499@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tFcGX-000OdC-11
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:33066
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLA96kqo8BC7Ah7ANRxpYdB54O8cqJH4DPm7A4S95htIy4SUsiauYuzYuGTLVwHausTfozQiImlcTtuYOfujy+9uUv06u5JBhgphKDAkm9nkcZhpzxOt
 KH/Xvpep+zXFMMmc0bD9KggISLvd4yXo3Uu5Uci5g3idmdHsKfzzh2vh12WEx1DmS+TsFU5R4ZhVj8c9XX86SFOI5Voc4ddMRTcuY3I6gMCuIkEp9WUZ5hju



On 23/11/24 11:08, Haoyu Li wrote:
> With the new __counted_by annocation in cfg80211_rnr_elems, the "cnt"
> struct member must be set before accessing the "elem" array. Failing to
> do so will trigger a runtime warning when enabling CONFIG_UBSAN_BOUNDS
> and CONFIG_FORTIFY_SOURCE.
> 

Nice catch. :)

> Fixes: 7b6d7087031b ("wifi: cfg80211: Annotate struct cfg80211_rnr_elems with __counted_by")

This should be Cc'd to stable:

Cc: stable@vger.kernel.org

> Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   net/mac80211/cfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 61a824ec33da..6936b1303e81 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1105,13 +1105,13 @@ ieee80211_copy_rnr_beacon(u8 *pos, struct cfg80211_rnr_elems *dst,
>   {
>   	int i, offset = 0;
>   
> +	dst->cnt = src->cnt;
>   	for (i = 0; i < src->cnt; i++) {
>   		memcpy(pos + offset, src->elem[i].data, src->elem[i].len);
>   		dst->elem[i].len = src->elem[i].len;
>   		dst->elem[i].data = pos + offset;
>   		offset += dst->elem[i].len;
>   	}
> -	dst->cnt = src->cnt;
>   
>   	return offset;
>   }



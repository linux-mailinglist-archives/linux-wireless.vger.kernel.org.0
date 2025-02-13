Return-Path: <linux-wireless+bounces-18944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D8DA34F41
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 21:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4759316DDF8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 20:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228C324A077;
	Thu, 13 Feb 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="FvwzSAB9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F81207644
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477872; cv=none; b=Vr2OpOKcs2WjdtaRken+9AT7AGpmvTKPwI1HkpHgyl+0/JjLoTS8Z+AuakTEA1nmG4iOHz/1x7y1TpNHpmvGYO/Wo4uq9wXUEvSiwZGbcENd6Pt5rGGMcX0v7ck7/3wtMQtS+83dJRPdeSiABILDAqlgUckLaMwced7v++PF0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477872; c=relaxed/simple;
	bh=eC1VWI5r8buZru3ijs68Snpb8KODJYPuJ1AjeGbvIkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG2Bk4KJYoRkwG9gUy+RoXTmawNwCM8uBggH0VwwIL2nIQ5yv0VT7nn/S7felxDqy8/ukngRlsj5NoOO9aQ4E3qYCd2evPnZC2YZgxz+IvsnN3w1bqL6om4QOWgfw1xfvvZKqwbfxertONPmCXq/S0s62VQRMul0y/mAXSe+FHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FvwzSAB9; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1E0515044CB
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 20:17:49 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1E3F22C0064;
	Thu, 13 Feb 2025 20:17:40 +0000 (UTC)
Received: from [10.20.38.246] (hirgnt03.hicv.net [173.197.107.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id BFB8613C2B0;
	Thu, 13 Feb 2025 12:17:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BFB8613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1739477859;
	bh=eC1VWI5r8buZru3ijs68Snpb8KODJYPuJ1AjeGbvIkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FvwzSAB9BVEaZbDB5ZChn8Jz6XjxfmcnCsLFXKe39y+UOmUTXvlrQifk3OxWIAM4r
	 C8Bis6Pb7sHvkfSzXwLTd/p7QoBfLxmpN42OgXFmOjuEob8onCNcFMW2WNDWH6+sZn
	 FIVywXR3Gduc5gxnM4CsOsSwbS5sVXlCH5s5gIe0=
Message-ID: <26f57f33-459d-4563-b0a5-2c5c287e1d55@candelatech.com>
Date: Thu, 13 Feb 2025 12:17:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] wifi: mac80211: correct RX stats packet increment
 for multi-link
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net
References: <20250213173206.1665731-1-quic_sarishar@quicinc.com>
 <20250213173206.1665731-2-quic_sarishar@quicinc.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20250213173206.1665731-2-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1739477861-srSMj0ZTYEjx
X-MDID-O:
 us5;at1;1739477861;srSMj0ZTYEjx;<greearb@candelatech.com>;be06782f8752dab23be3bebda63580b2
X-PPE-TRUSTED: V=1;DIR=OUT;

On 2/13/25 9:32 AM, Sarika Sharma wrote:
> Currently, RX stats packets are incremented for deflink member for
> non-ML and multi-link(ML) station case. However, for ML station,
> packets should be incremented based on the specific link.
> 
> Therefore, if a valid link_id is present, fetch the corresponding
> link station information and increment the RX packets for that link.
> For non-MLO stations, the deflink will still be used.
> 
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> ---
>   net/mac80211/rx.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 1e28efe4203c..eb3e2d550c8f 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -231,8 +231,19 @@ static void __ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,
>   
>   	skb_queue_tail(&sdata->skb_queue, skb);
>   	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
> -	if (sta)
> -		sta->deflink.rx_stats.packets++;
> +	if (sta) {
> +		struct link_sta_info *link_sta_info;
> +
> +		if (link_id >= 0) {
> +			link_sta_info = rcu_dereference(sta->link[link_id]);
> +			if (!link_sta_info)
> +				return;

I think if you cannot find the link_sta_info here, you should just use deflink
so the packet is still counted?

Thanks,
Ben

> +		} else {
> +			link_sta_info = &sta->deflink;
> +		}
> +
> +		link_sta_info->rx_stats.packets++;
> +	}
>   }
>   
>   static void ieee80211_queue_skb_to_iface(struct ieee80211_sub_if_data *sdata,


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


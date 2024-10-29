Return-Path: <linux-wireless+bounces-14649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 144079B4EB1
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE4EB2420A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1CC196446;
	Tue, 29 Oct 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU5Ie/kf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EFC192B69;
	Tue, 29 Oct 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217462; cv=none; b=og0f4TZUdGZMYmmLn1e2soBh2QsoP3iuEz/+6OrBfp6eiTg23l1rKA2q/w9waehWB74Q5IFAVRTs9E7n/gGmpzy/LdRfu2Ytbx9qyG7n8rQEMi/T5ebjB0juOzyOeD/L2GcaJ+CdKUEoiqZSmkwJftYf2UZcofmu8dZR60cyKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217462; c=relaxed/simple;
	bh=WnydxeLoY1HzmU7NTXVNXw9fogpReYyE1cqLe0DpYdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAQeOpePEFQxV2YZG7LwBqVQgjbTG0KWELCTCKK2bXg1WqVBQqo/H4ubRKv924wMth01xUeWfsiQ1jxo1OOsRgqoT7aAWhjRaQVdxJaJBUqE4d1QhE9Pk8nbVNgYI382d3AGYeDxabAolMUHGrHRJZH7n5+TOe9i2qZconEaeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU5Ie/kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9732C4CECD;
	Tue, 29 Oct 2024 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730217462;
	bh=WnydxeLoY1HzmU7NTXVNXw9fogpReYyE1cqLe0DpYdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LU5Ie/kfKNpYzOj7Pw/+kDJsGvCUzmkBL1vtctc5RSjup85m/MTCu/sxjVvQS5CmX
	 B3Pc/KYtJC0Vd1ZKbYMm1e/rIAZ23wMdw1bm/i804XCfJjhNZKHuZPB24GhhVFmAUR
	 9mTwLIuxXS5qfsYaj2WJFHgFTJmv8vx2XpH0hH2tLsFx5atI4w91QE90RwFlwGHxw1
	 QOwkY+UiholmAa1mG4kfrYgqXbzLu0J1kYF+qC7SqNs208DcFgNQ2kLyiG4Ec60HF0
	 cDCKXpxwpjtYMyXQ6BC4yOHzGzaV7WYyFBBlWUDSsI38EGqbwiwLY1Vf26BwzgX05d
	 2AI0h22T7Pmnw==
Date: Tue, 29 Oct 2024 08:57:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Johannes Berg
 <johannes.berg@intel.com>
Subject: Re: [RFC PATCH 2/2] net: convert to nla_get_*_default()
Message-ID: <20241029085740.55888e95@kernel.org>
In-Reply-To: <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
References: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
	<20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 13:18:07 +0200 Johannes Berg wrote:
> diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
> index 79ba9dc70254..7a10bb159113 100644
> --- a/net/sched/sch_gred.c
> +++ b/net/sched/sch_gred.c
> @@ -750,11 +750,8 @@ static int gred_init(struct Qdisc *sch, struct nlattr *opt,
>  		return -EINVAL;
>  	}
>  
> -	if (tb[TCA_GRED_LIMIT])
> -		sch->limit = nla_get_u32(tb[TCA_GRED_LIMIT]);
> -	else
> -		sch->limit = qdisc_dev(sch)->tx_queue_len
> -		             * psched_mtu(qdisc_dev(sch));
> +	sch->limit = nla_get_u32_default(tb[TCA_GRED_LIMIT],
> +					 qdisc_dev(sch)->tx_queue_len * psched_mtu(qdisc_dev(sch)));

> @@ -7578,10 +7569,8 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
>  			dev->ieee80211_ptr->iftype == NL80211_IFTYPE_P2P_GO;
>  	}
>  
> -	if (info->attrs[NL80211_ATTR_PEER_AID])
> -		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_PEER_AID]);
> -	else
> -		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_STA_AID]);
> +	params.aid = nla_get_u16_default(info->attrs[NL80211_ATTR_PEER_AID],
> +					 nla_get_u16(info->attrs[NL80211_ATTR_STA_AID]));

I'd limit the conversions only to cases where the default is a constant.
In the two cases quoted here it seems like the conversion results in net
loss of readability.


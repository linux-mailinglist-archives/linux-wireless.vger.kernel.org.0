Return-Path: <linux-wireless+bounces-24930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DE2AFC98C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662EE16549C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFB2F9E8;
	Tue,  8 Jul 2025 11:26:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A04800
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974007; cv=none; b=CnQJsy5Au4KQVcHalPhioYZMnLBTTqZdSET7UY0TvEWuwkpqbBp05PnWQ5tnjVXube7bXgnqYG/maAPIOzZc9/uxIUMn+vXV36qguZ7CEhK8xzgtDo1mQt7C+6Yhp74EuWdV4t0bv3P+yD/TbF+BDMOlBYCUn6mGDPjcVP4RlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974007; c=relaxed/simple;
	bh=3VKto6sIXCseKLT51WzC7hmn1kmzglXbc5sR6ckdeiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9+yxFk2xRa9xV9u4hGdHbwtex1l3L+SD2wko3HtqI/Qm5ajoxVVAKEqZVkvv/hDzCLVEhLwx5mVjyRW0zgP/RYqVLA3KxWnJ3IGhOLbz65TSepV+GjMP1jEjp2rY14WkdOEKYw7kXFQm4cgIjcpEhAKxITHVm+7/8iLz0Ca2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AADFC61E64844;
	Tue, 08 Jul 2025 13:26:20 +0200 (CEST)
Message-ID: <00a86131-3258-4a96-b223-4be0d020a126@molgen.mpg.de>
Date: Tue, 8 Jul 2025 13:26:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: make VHT opmode NSS ignore a debug
 message
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
References: <20250708105849.22448-2-johannes@sipsolutions.net>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250708105849.22448-2-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Johannes,


Thank you for your patch, and sorry for not replying in the other thread.

Am 08.07.25 um 12:58 schrieb Johannes Berg:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There's no need to always print it, it's only useful for
> debugging specific client issues. Make it a debug message.

Excuse my ignorance, but I wonder if it’s a firmware bug (of the access 
point), if this situation occurs?

Also, I do have a problem with that Telekom Speedport 3, that sometimes 
– despite still connected Wi-Fi – no network connection is possible, and 
re-connecting fixes it. It happens much later to the message, so I 
assume it’s unrelated, but no warnings would give me more confidence 
into the Telekom router.

> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/linux-wireless/20250529070922.3467-1-pmenzel@molgen.mpg.de/
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   net/mac80211/vht.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
> index c5c5d16ed6c8..b099d79e8fbb 100644
> --- a/net/mac80211/vht.c
> +++ b/net/mac80211/vht.c
> @@ -672,8 +672,9 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
>   				sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
>   			}
>   		} else {
> -			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Notification from %pM with invalid nss %d",
> -					    link_sta->pub->addr, nss);
> +			sdata_dbg(sdata,
> +				  "Ignore NSS change to invalid %d in VHT opmode notif from %pM",
> +				  nss, link_sta->pub->addr);

As with my original patch, would printing the current “NSS value” be 
useful? At least for me, who does not know how to get that value from a 
running system.

>   		}
>   	}
>   


Kind regards,

Paul


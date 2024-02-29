Return-Path: <linux-wireless+bounces-4269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A786D648
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 22:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AB31C213EA
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE82A16FF5F;
	Thu, 29 Feb 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="NUs0z4I+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70016FF55
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242883; cv=none; b=YWxpXXJIseAgY3ugbzthlerzAXTCoSenuQOEn7UvXXCtqaifrg47o9aFtr6kJYKjZZio3YUq0Uu7YsntqmICZ6E1duNtohMRyYYavfiGLG4T1imugvBcS2A0z48KetDWXnv1QnAxhVXEIy9atKh12Cdv9r7fupNPVLa+I4RHamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242883; c=relaxed/simple;
	bh=EhbcuSKq8y+2E2bB0nlxahgVHUaekcZbxEO609CUz38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFoEwuZJIhsKgQgrkmjAWU0621l1VOlGDbMgSpl83Aqiafi46UHE6hy6z2jWeVe70/aoNeN+s16STTfIO1pExzaJElUo9uLbiaovkZfzLu0cuz91MXq9w9FxUNv14NyUc6bU3TawPxMLFesA5bZTMDgOZoIB55kK+mJRMK30zHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=NUs0z4I+; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9EB05B80074;
	Thu, 29 Feb 2024 21:41:18 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0F33713C2B0;
	Thu, 29 Feb 2024 13:41:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0F33713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709242878;
	bh=EhbcuSKq8y+2E2bB0nlxahgVHUaekcZbxEO609CUz38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NUs0z4I+RcdvpnNe6+N7xTtw9M+wzT0O30SoHsQTpaQcB9hsPRpthkszXb2bY9Xmf
	 mF3K6H05H8xZH+GjaaEAplbDSzC64djNmFdhyujPre2kiq793btmJa8qrCY1wUt77f
	 2ZdFXrCKeuuPmiu1Tb0auofWimd3kzDrDJ7PS+fw=
Message-ID: <b502cc28-865c-4f00-9f09-76851d6629ba@candelatech.com>
Date: Thu, 29 Feb 2024 13:41:17 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 11/13] wifi: mac80211: fix advertised TTLM scheduling
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Ayala Beker <ayala.beker@intel.com>,
 Johannes Berg <johannes.berg@intel.com>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
 <20231220133549.15079c34e5c8.I0dd50bcceff5953080cdd7aee5118b72c78c6507@changeid>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20231220133549.15079c34e5c8.I0dd50bcceff5953080cdd7aee5118b72c78c6507@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709242879-MGWjFhk3naCu
X-MDID-O:
 us5;ut7;1709242879;MGWjFhk3naCu;<greearb@candelatech.com>;b05461388c2da5bcf30b05c690d525a5

On 12/20/23 03:41, Miri Korenblit wrote:
> From: Ayala Beker <ayala.beker@intel.com>
> 
> Handle a case of time overflow, where the switch time might
> be smaller than the partial TSF in the beacon.
> Additionally, apply advertised TTLM earlier in order to be
> ready on time on the newly activated links.
> 
> Fixes: 702e80470a33 ("wifi: mac80211: support handling of advertised TID-to-link mapping")
> Signed-off-by: Ayala Beker <ayala.beker@intel.com>
> Reviewed-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

While rebasing my 6.7 tree on 6.8, I notice this patch applied, which I think means
it was not applied to 6.8 upstream.  Was that on purpose?

Thanks,
Ben

> ---
> v2: Fix wrong email addresses
> ---
>   net/mac80211/mlme.c | 49 ++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index fe0be3e5731b..b526ce589d4d 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -43,6 +43,9 @@
>   #define IEEE80211_ASSOC_TIMEOUT_SHORT	(HZ / 10)
>   #define IEEE80211_ASSOC_MAX_TRIES	3
>   
> +#define IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS msecs_to_jiffies(100)
> +#define IEEE80211_ADV_TTLM_ST_UNDERFLOW 0xff00
> +
>   static int max_nullfunc_tries = 2;
>   module_param(max_nullfunc_tries, int, 0644);
>   MODULE_PARM_DESC(max_nullfunc_tries,
> @@ -5965,6 +5968,13 @@ ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
>   	pos++;
>   
>   	ttlm_info->switch_time = get_unaligned_le16(pos);
> +
> +	/* Since ttlm_info->switch_time == 0 means no switch time, bump it
> +	 * by 1.
> +	 */
> +	if (!ttlm_info->switch_time)
> +		ttlm_info->switch_time = 1;
> +
>   	pos += 2;
>   
>   	if (control & IEEE80211_TTLM_CONTROL_EXPECTED_DUR_PRESENT) {
> @@ -6059,25 +6069,46 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
>   		}
>   
>   		if (ttlm_info.switch_time) {
> -			u32 st_us, delay = 0;
> -			u32 ts_l26 = beacon_ts & GENMASK(25, 0);
> +			u16 beacon_ts_tu, st_tu, delay;
> +			u32 delay_jiffies;
> +			u64 mask;
>   
>   			/* The t2l map switch time is indicated with a partial
> -			 * TSF value, convert it to TSF and calc the delay
> -			 * to the start time.
> +			 * TSF value (bits 10 to 25), get the partial beacon TS
> +			 * as well, and calc the delay to the start time.
> +			 */
> +			mask = GENMASK_ULL(25, 10);
> +			beacon_ts_tu = (beacon_ts & mask) >> 10;
> +			st_tu = ttlm_info.switch_time;
> +			delay = st_tu - beacon_ts_tu;
> +
> +			/*
> +			 * If the switch time is far in the future, then it
> +			 * could also be the previous switch still being
> +			 * announced.
> +			 * We can simply ignore it for now, if it is a future
> +			 * switch the AP will continue to announce it anyway.
> +			 */
> +			if (delay > IEEE80211_ADV_TTLM_ST_UNDERFLOW)
> +				return;
> +
> +			delay_jiffies = TU_TO_JIFFIES(delay);
> +
> +			/* Link switching can take time, so schedule it
> +			 * 100ms before to be ready on time
>   			 */
> -			st_us = ieee80211_tu_to_usec(ttlm_info.switch_time);
> -			if (st_us > ts_l26)
> -				delay = st_us - ts_l26;
> +			if (delay_jiffies > IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS)
> +				delay_jiffies -=
> +					IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS;
>   			else
> -				continue;
> +				delay_jiffies = 0;
>   
>   			sdata->u.mgd.ttlm_info = ttlm_info;
>   			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
>   						  &sdata->u.mgd.ttlm_work);
>   			wiphy_delayed_work_queue(sdata->local->hw.wiphy,
>   						 &sdata->u.mgd.ttlm_work,
> -						 usecs_to_jiffies(delay));
> +						 delay_jiffies);
>   			return;
>   		}
>   	}

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com




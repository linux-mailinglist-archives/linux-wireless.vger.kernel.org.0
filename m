Return-Path: <linux-wireless+bounces-12541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E996E09C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF01C283C9B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 16:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402281A0705;
	Thu,  5 Sep 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYc98lcn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57E19DFB8
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555513; cv=none; b=m0q353qBnVSJP+fxXRs/Aa+M3qKamIncnYYdV0NRC95szviJ6BlsIUFFyHJZJOBbKGGuYuUbwRCninh33m+KsS1dq6WIuhGViSnMZxFXcjJzJX94A0crMd/HBjDhXYUOV4XvdOSGDLcOcBKiwJY0qIfKB3iX1aL/tYdnAJ6tk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555513; c=relaxed/simple;
	bh=h1QSlJ3PIWCP6HZnmIIWnR/RuJh0VXMkl/Tv3e4WziY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cSa2oL1kUf2CpDGyKdjv5ypClM/1o2jSaCd1BHQ77v9aVeqABza+GkCrlenCvM5Zv3JHMq/2qmj5iC2770rJhWOyXcWbvqI4SXMsDw3CVusXgrQW7ZjLbk4Hc+ZLfDPQgwzCMOAdh3+GIUbqqQY7zzLCVBaNos1qSucf5qxZqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYc98lcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D798BC4CEC3;
	Thu,  5 Sep 2024 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725555512;
	bh=h1QSlJ3PIWCP6HZnmIIWnR/RuJh0VXMkl/Tv3e4WziY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dYc98lcn7hZ2jXro3bcyVG+m2LnKLA44Hm1RtpJVw3SRXTjlPs2PrJ1wbJ94NKZ8c
	 LrH1r0BBV4oEer7m7Re/HGRImgzSp1TOzqOTxd8P+/5fdnSC/la7geo2u+x79+MjW+
	 ilqQX+yiHcskOVtiF95KOFPSdwgPomEKRKaOkTZ6Xzw+RFrlqlDpqC5G5rGOobYyBm
	 n8YEbZHIrVAi5/saD+A9UocjzzZYmZLiYWsRNdrfVYmMRaBgbcJAdWNme0h7xG4Xg2
	 s3mlc6yT7/JZonSlDVhhio9gJwrdAawQErRsrE6F8AUsMb80ZpOS4CQ9f0/sXgunW0
	 N0xxwG/Tf33gw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH RFC 4/4] wifi: ath12k: convert struct
 ath12k_sta::update_wk to use struct wiphy_work
References: <20240821153728.2121600-1-kvalo@kernel.org>
	<20240821153728.2121600-5-kvalo@kernel.org>
	<7717fa70-38f0-44e9-bf3b-26ce71389707@quicinc.com>
Date: Thu, 05 Sep 2024 19:58:29 +0300
In-Reply-To: <7717fa70-38f0-44e9-bf3b-26ce71389707@quicinc.com> (Baochen
	Qiang's message of "Thu, 22 Aug 2024 14:19:20 +0800")
Message-ID: <87h6auhway.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 8/21/2024 11:37 PM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> As ath12k is now converted to use wiphy lock we can convert
>> ath12k_sta_rc_update_wk() to use wiphy_work_queue(). This is just for
>> consistency.
>> 
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/core.h |  2 +-
>>  drivers/net/wireless/ath/ath12k/mac.c  | 17 +++++++++--------
>>  2 files changed, 10 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
>> index 7fad2150d9bd..cc28185be650 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -445,7 +445,7 @@ struct ath12k_sta {
>>  	u32 smps;
>>  	enum hal_pn_type pn_type;
>>  
>> -	struct work_struct update_wk;
>> +	struct wiphy_work update_wk;
>>  	struct rate_info txrate;
>>  	struct rate_info last_txrate;
>>  	u64 rx_duration;
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 80db9004cdd7..8bf7b026f8e4 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -4258,9 +4258,9 @@ static int ath12k_station_disassoc(struct ath12k *ar,
>>  	return 0;
>>  }
>>  
>> -static void ath12k_sta_rc_update_wk(struct work_struct *wk)
>> +static void ath12k_sta_rc_update_wk(struct wiphy *wiphy, struct wiphy_work *work)
>>  {
>> -	struct ath12k *ar;
>> +	struct ath12k *ar = wiphy_priv(wiphy);
>
> wiphy_priv() returns pointer to ieee80211_local, not ath12k.

Yikes! Great find, thanks for the thorough review. Will fix in v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


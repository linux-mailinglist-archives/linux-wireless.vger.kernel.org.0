Return-Path: <linux-wireless+bounces-10552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB58993DC81
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 02:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DDE2817D8
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 00:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8F139F;
	Sat, 27 Jul 2024 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ZDCHeys5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51B195
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722039826; cv=none; b=pZcAC/EZkAMKSqj3PK/4nEIVjDD1J9KyXSw7uHdD2sKECDZ9FalzFNEUV5O69KSh38gPSJNOsRygYOvw/Ai1obbITM7aNamsFldEvbU+lBjEQKm82zTD/4rmAMU+xRLd2+s8xuZ2J25efO1I72HQHg5oTQ+iaxesN5TYu5YDV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722039826; c=relaxed/simple;
	bh=cnPsn611UjJ02M558mWmVyCwR6qA++WjYS1aQhoNmkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuqTaMa4hP1eMWcGXONgvFxhxPBgzOXz6g3n7mfadXgYPGDnFim4oAd3PzAZJ5nDak/nUDhGF0bwyoA6leGFzs+ZfEgm4FDLn6W79E3bLRJEzh8NooaPmEFXozXDb9M90IxJ3XnS+HbBvufFUO3CYTzOzFos17JMa75gEeyCYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ZDCHeys5; arc=none smtp.client-ip=17.58.23.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722039823;
	bh=OF//PZdzhsZCrVIwn37lsY6lbpixHa5B2D3Ug9HdfCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=ZDCHeys5+W4QQC0BTyKvSy4P/1nCb4GcXZBMDblyCu+9u9jFBSGd8uAFvEtW0EbCu
	 MrJEmo4OyMXZVjRro0mt1zPU5CXYBltrq8XqdzHbmXlryfy72yM+t/5ebCeqSastgA
	 541zfKMDZ3JYGmVJwkmIkh+U0TgL8LPAezFpn+SOhdW2XlanxKG619byAoRgIba8qw
	 eF7GupEiBV3WmlIJJ6kLFnAN2JW5EYml1uGrHUsgEFdejt9B0DEqXGbQuFmahvN2bQ
	 MXW4kqtfyqm9U46fldIa3JeBoVp50hRryOjqvziAWKb+Q9gzzAUXD98G7H9pA5gE/v
	 F7OORGHhIpmUg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 5BE2D357AE22;
	Sat, 27 Jul 2024 00:23:39 +0000 (UTC)
Message-ID: <d1267639-c885-4a27-ac15-b4199e38ec99@icloud.com>
Date: Sat, 27 Jul 2024 08:23:35 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rfkill: Correct parameter type for
 rfkill_set_hw_state_reason()
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240715-rfkill_fix-v1-1-a9f2d56b4716@quicinc.com>
 <dcd0d83a-af37-4ef5-8351-a435ab115ed0@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <dcd0d83a-af37-4ef5-8351-a435ab115ed0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: s-IoaBAszZJHQ0P83u8KIpUXIsGDRpc7
X-Proofpoint-ORIG-GUID: s-IoaBAszZJHQ0P83u8KIpUXIsGDRpc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_14,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407270001

On 2024/7/27 06:51, Jeff Johnson wrote:
> On 7/15/2024 6:39 AM, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Change type of parameter @reason to enum rfkill_hard_block_reasons for
>> API rfkill_set_hw_state_reason() according to its comments.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  include/linux/rfkill.h | 5 ++---
>>  net/rfkill/core.c      | 7 +------
>>  2 files changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
>> index 373003ace639..4f7558267541 100644
>> --- a/include/linux/rfkill.h
>> +++ b/include/linux/rfkill.h
>> @@ -147,7 +147,7 @@ void rfkill_destroy(struct rfkill *rfkill);
>>   * Prefer to use rfkill_set_hw_state if you don't need any special reason.
>>   */
>>  bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
>> -				bool blocked, unsigned long reason);
>> +		bool blocked, enum rfkill_hard_block_reasons reason);
> 
> function parameters should align on (
> 
will correct it for v2
>>  /**
>>   * rfkill_set_hw_state - Set the internal rfkill hardware block state
>>   * @rfkill: pointer to the rfkill class to modify.
>> @@ -279,8 +279,7 @@ static inline void rfkill_destroy(struct rfkill *rfkill)
>>  }
>>  
>>  static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
>> -					      bool blocked,
>> -					      unsigned long reason)
>> +		bool blocked, enum rfkill_hard_block_reasons reason)
> 
> function parameters should align on (
> 

will correct it for v2
>>  {
>>  	return blocked;
>>  }
>> diff --git a/net/rfkill/core.c b/net/rfkill/core.c
>> index 7a5367628c05..f8ed6431b2f5 100644
>> --- a/net/rfkill/core.c
>> +++ b/net/rfkill/core.c
>> @@ -539,18 +539,13 @@ bool rfkill_get_global_sw_state(const enum rfkill_type type)
>>  #endif
>>  
>>  bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
>> -				bool blocked, unsigned long reason)
>> +		bool blocked, enum rfkill_hard_block_reasons reason)
> 
> function parameters should align on (
> 
will correct it for v2
>>  {
>>  	unsigned long flags;
>>  	bool ret, prev;
>>  
>>  	BUG_ON(!rfkill);
>>  
>> -	if (WARN(reason & ~(RFKILL_HARD_BLOCK_SIGNAL |
>> -			    RFKILL_HARD_BLOCK_NOT_OWNER),
>> -		 "hw_state reason not supported: 0x%lx", reason))
>> -		return rfkill_blocked(rfkill);
>> -
> 
> did you validate that all callers are actually passing a valid enum?
> that is something you should describe in your commit since this is a change
> beyond just changing the prototype
> 
yes. actually, ALL callers within kernel tree only use enum for the API.
will add that description within v2.
thanks
>>  	spin_lock_irqsave(&rfkill->lock, flags);
>>  	prev = !!(rfkill->hard_block_reasons & reason);
>>  	if (blocked) {
>>
>> ---
>> base-commit: 338a93cf4a18c2036b567e9f613367f7a52f2511
>> change-id: 20240715-rfkill_fix-335afa2e88ca
>>
>> Best regards,
> 



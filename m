Return-Path: <linux-wireless+bounces-14651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BC09B4EC8
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF0F1C225E9
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC78192B69;
	Tue, 29 Oct 2024 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6PR3Lft"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FE802
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217736; cv=none; b=jzRkjtNJAtiT0/ORDXofSWd2i0NJIfcyWCfT6SG6slmTRbjAIXvR7r2WD72tTl/RRSKqdlVCsS4kw4f8EH3EDqHxpWu7qOTvNsntBCZ1s2QhSFmRCs1/g3R14K8AmqtqobKfE768soo8XCuB1y2w+7CVJL5015pyXYeZ1bT7efw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217736; c=relaxed/simple;
	bh=5RnZNa0gGv94StUKJ60e3iVKJyhd1vTLQVj1lPWxRdU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KgITVj0O6LYoOFt4yg6N8xgxVHzPpbLghPgubfj45MT4U85Wo9g0IIu/ykZsUdSbQhG7FdUlJbhZp4kPgHW50xQ14gjN6vL+2EjF5DLse3pq095tzLay0Co/rSu9x0TuS/4MxVn7Uugtj0BvIDRRL0+WAveZ1kYOcBw/9yHIRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6PR3Lft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E944CC4CECD;
	Tue, 29 Oct 2024 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730217735;
	bh=5RnZNa0gGv94StUKJ60e3iVKJyhd1vTLQVj1lPWxRdU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=D6PR3LftX6EZiwwOnRQVfHO0REuSUf8N0SxpFl0XevwoBiUhPXIrn/RHiB4LpWH2G
	 fUWbhsSXvCqSbUUYxnuIcS2mN9865NFIr+cjr0QfWGIZBiU1VE9+eK5wGbzgZYmvvI
	 +2hDXm6sVy4gT1se4iHN/cDvuiRTAfI8y88qfbtwdfA6Kljx3DvQfifiq6LdamQ9E5
	 gwEpbJCztXYN98rQgZjqSw4Q4pgjXnSyhGKxlymZmgUhdL+ovq5xWmCyVo6PbJK4Ju
	 EoifKsAPhJcYvZSKqpPPX5+b6jpb3nbDbjZCCUyQU1etgz9BmoTYybSHhltGOhsoXN
	 InkeqQClLhumA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 7/8] wifi: ath12k: add helper to find multi-link station
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-8-kvalo@kernel.org>
	<05f2ef12-5176-4742-adb7-04da614995fc@quicinc.com>
Date: Tue, 29 Oct 2024 18:02:13 +0200
In-Reply-To: <05f2ef12-5176-4742-adb7-04da614995fc@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 09:01:01 -0700")
Message-ID: <87seseganu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/23/2024 6:30 AM, Kalle Valo wrote:
>
>> --- a/drivers/net/wireless/ath/ath12k/dp.h
>> +++ b/drivers/net/wireless/ath/ath12k/dp.h
>> @@ -1796,6 +1796,8 @@ static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
>>  	memcpy(addr + 4, &addr_h16, ETH_ALEN - 4);
>>  }
>>  
>> +#define ATH12K_ML_PEER_ID_VALID         BIT(13)
>> +
>
> this seems to be randomly placed without any context

Yeah, it is. I'll try to find a better place for it.

>> @@ -87,6 +101,9 @@ struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
>>  
>>  	lockdep_assert_held(&ab->base_lock);
>>  
>> +	if (peer_id & ATH12K_ML_PEER_ID_VALID)
>
> where is code that sets the bit?

That will come later in patch 'wifi: ath12k: Add support for HTT MLO peer map and unmap event'.

> does other code elsewhere need to mask this bit off to have the "true" peer_id?

I'll investigate this.

> the commit text for this patch seems to need a lot more description

Will fix.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


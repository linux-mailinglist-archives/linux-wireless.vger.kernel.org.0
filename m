Return-Path: <linux-wireless+bounces-14645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472819B4E44
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03E31F2161C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A818191F7C;
	Tue, 29 Oct 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj1agXJq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363712BAF9
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216476; cv=none; b=saOTxOn3n+xH0TbPD+cCnBDulik8KQ81eOqu2CEg7ePhWYTPrWTCwz0tHZ3MHGKzWre4HcJiXX/lbb1f/A1k5IQrousJioNoBj0ZnOnMxONGXm68Fqfm52P7qhVWptqGQ2OkfMruHwoiI1HFdARSjPl8dFKQgCpAwBj1GD6DSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216476; c=relaxed/simple;
	bh=pdPLci/43bBcZPIhgqIrydqtHIVkbRa2w7Xlr/vW8Jc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=R8YaMhuMjFE4EcaXxWXs4DrrnP613yazSN7vz9LA1drth4u9YuMJ3cwxEqw2jeWCyzUuPAcNqLh2eEq8ki4t74LLt4azBcEK2/cGb6xCcDdXEJ8l0mhIho2FV9l5J0AnPEO+6DiGIj9c215cBYzEBa0chJezXoFWFGQ834wX0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj1agXJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F312FC4CECD;
	Tue, 29 Oct 2024 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730216475;
	bh=pdPLci/43bBcZPIhgqIrydqtHIVkbRa2w7Xlr/vW8Jc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kj1agXJq4u3wR4mn25WZaEULb+HKWcNdakwp0AbFP02sYZSQA5A/vLyHC+TiDhU7C
	 BMsNQx0IwJL5KkzgYPQRD3ozhkiflT10OUEKr8rjBCTSoSlS0ioEQeI7KkSbUGhvjq
	 tGCa9Mf6pvpGze0aWIaB49AYC5ZJmYPcMD6PV/TojCNxTLYs/K1RLHeKv2Xfvu3T1r
	 ZD4LY4XD3PvESIfx7RodW0wRTWn4LDS0u/8/hJr7SGA5kFhsQ6xevDBDet6rW4ytrj
	 YnK4ss3ddcoXNJ7OOdGZ/OrHKAJqXH4dnS6cnZK8insFn7OXfRuJHNB6fAb4mK7+o/
	 bfJTNxzjGiAdQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/8] wifi: ath12k: introduce ath12k_hw_warn()
References: <20241023133004.2253830-1-kvalo@kernel.org>
	<20241023133004.2253830-5-kvalo@kernel.org>
	<b989b83c-f911-4d67-b703-1ac3ee219559@quicinc.com>
Date: Tue, 29 Oct 2024 17:41:12 +0200
In-Reply-To: <b989b83c-f911-4d67-b703-1ac3ee219559@quicinc.com> (Jeff
	Johnson's message of "Wed, 23 Oct 2024 08:38:32 -0700")
Message-ID: <871pzyhq7b.fsf@kernel.org>
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
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> In the following patch we need to use ath12k_warn() but don't easily have
>> access to struct ath12k_base (ab) but do have access to struct ath12k_hw (ah).
>> So add a new warning helper ath12_hw_warn() which takes the latter but the log
>> output is still identical but uses the struct device pointer stored to struct
>> ath12k_hw.
>> 
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/core.h  | 2 ++
>>  drivers/net/wireless/ath/ath12k/debug.c | 4 ++--
>
> Qualcomm Innovation Center copyright missing 2024

Will fix.

>> --- a/drivers/net/wireless/ath/ath12k/debug.h
>> +++ b/drivers/net/wireless/ath/ath12k/debug.h
>> @@ -31,7 +31,10 @@ enum ath12k_debug_mask {
>>  
>>  __printf(2, 3) void ath12k_info(struct ath12k_base *ab, const char *fmt, ...);
>>  __printf(2, 3) void ath12k_err(struct ath12k_base *ab, const char *fmt, ...);
>> -__printf(2, 3) void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...);
>> +__printf(2, 3) void __ath12k_warn(struct device *dev, const char *fmt, ...);
>> +
>> +#define ath12k_warn(ab, fmt, ...) __ath12k_warn((ab)->dev, fmt, ##__VA_ARGS__)
>> +#define ath12k_hw_warn(ah, fmt, ...) __ath12k_warn((ah)->dev, fmt, ##__VA_ARGS__)
>
> for consistency should we do this for the other log levels as well?
>
> are there places where we currently retrieve ab just for logging where we
> already have ah, and hence could avoid the extra dereference?

That's a good idea but IMHO the cleanup can wait after MLO has landed.
Right now there should not be many places where we have to use the
ath12k_hw_warn() variant.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-wireless+bounces-4227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9286BFC0
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 05:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79FB1C21030
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 04:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179338396;
	Thu, 29 Feb 2024 04:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="QPmun4xh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94758381D9
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709179539; cv=none; b=fCHCKthVqA0sC70v9Y5wQKO8vI5qjUJyzPq9mTchrvDE4+0tQlpUi8ApTyb0DWCU/HOng1XrnezKrDLOEHMQAaGQALUbgVWkw+hC2gwQXecm+k8Ncct1pOd3XQV9j4S8ZWV0ulhIlreIrchwGu1rN/g+mmitiWWKMl1B7pfnBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709179539; c=relaxed/simple;
	bh=RlZrw9YMEMldm7rl5qY5lQIo3gDi8jh9efWEZkJNERE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ev4ew1jKwGbXqEYFoHsq86+XgW8URlex+KjscfR+QVOcIb6HbMXAQSJeisqZ1vRwQaZJzXEn0hZxznJ2mFzgLQtTHqjty67RFX0ZkxOoZJ5wPOPk879R7nOHgWmZJpFFi2Tpp2wQXgD9s22s25IUY+2X4555fgz/ZLp6djbY2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=QPmun4xh; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5EC7560005E;
	Thu, 29 Feb 2024 04:05:30 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.35.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 6FD0613C2B0;
	Wed, 28 Feb 2024 20:05:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6FD0613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709179529;
	bh=RlZrw9YMEMldm7rl5qY5lQIo3gDi8jh9efWEZkJNERE=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=QPmun4xh8IvKpdnmdnUaBVz0xQ74o6sA+mBoxTnFSz+2hidALm4Uq1lbficae1s0i
	 +keofDugIVmTMTqq4iOQWiDpQ9tkOPhtzcMuCBVG7YfokRWWoYyfzaHREwat1uyFI6
	 dTwmmtA7QfZ89Q5zovMjW7Lqet0hJ0Sg078/4oa8=
Message-ID: <48cb4fab-a905-4793-8bfe-58157061e0f7@candelatech.com>
Date: Wed, 28 Feb 2024 20:05:28 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
 <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
 <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
 <0f8a0451e547f318febcbe36823e1f9914cc684b.camel@sipsolutions.net>
 <33cc22b8-5852-42ae-9e80-8c3c58c36b6d@candelatech.com>
 <4a3edd404b84da53b56bb0a391cb42d00f42f4c5.camel@sipsolutions.net>
 <492a290b-752f-48c3-be16-59bdf7914487@candelatech.com>
 <366ed520b5f4b3cd603be11124f9b51e32ce8106.camel@sipsolutions.net>
 <f2aec39d67cdb20cf813b575231ab95b409e315d.camel@sipsolutions.net>
Content-Language: en-MW
Cc: Madhan Sai <madhan.singaraju@candelatech.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <f2aec39d67cdb20cf813b575231ab95b409e315d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709179531-0nBIxv8zTyoc
X-MDID-O:
 us5;ut7;1709179531;0nBIxv8zTyoc;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 2/27/24 08:13, Johannes Berg wrote:
> On Tue, 2024-02-27 at 15:58 +0100, Johannes Berg wrote:
>>
>> Which, btw, ignoring comments, braces, whitespace - then really just
>> removes the line you're getting stuck on.
>>
>> So actually no ... invert the test?
>>
>>   if (refcount_dec_and_test(...))
>>     return;
>>
>> If it hit zero here, there's guaranteed to be no user, so we can return.
>>
>> If it's not zero yet, we might yet go into a new cancellation, so we
>> need the rest of the function.
>>
> 
> This is what I wrote now:
> 
> 
> Subject: [PATCH] debugfs: fix wait/cancellation handling during remove

We are no longer able to reproduce a lockup, so please feel free to add:

Tested-by: Madhan Sai <madhan.singaraju@candelatech.com>

Thanks,
Ben

> 
> Ben Greear further reports deadlocks during concurrent debugfs
> remove while files are being accessed, even though the code in
> question now uses debugfs cancellations. Turns out that despite
> all the review on the locking, we missed completely that the
> logic is wrong: if the refcount hits zero we can finish (and
> need not wait for the completion), but if it doesn't we have
> to trigger all the cancellations. As written, we can _never_
> get into the loop triggering the cancellations. Fix this, and
> explain it better while at it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8c88a474357e ("debugfs: add API to allow debugfs operations cancellation")
> Reported-by: Ben Greear <greearb@candelatech.com>
> Closes: https://lore.kernel.org/r/1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com
> Change-Id: I6c7aeff8c9d6628a8bc1ddcf332205a49d801f17
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   fs/debugfs/inode.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 034a617cb1a5..a40da0065433 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -751,13 +751,28 @@ static void __debugfs_file_removed(struct dentry *dentry)
>   	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
>   		return;
>   
> -	/* if we hit zero, just wait for all to finish */
> -	if (!refcount_dec_and_test(&fsd->active_users)) {
> -		wait_for_completion(&fsd->active_users_drained);
> +	/* if this was the last reference, we're done */
> +	if (refcount_dec_and_test(&fsd->active_users))
>   		return;
> -	}
>   
> -	/* if we didn't hit zero, try to cancel any we can */
> +	/*
> +	 * If there's still a reference, the code that obtained it can
> +	 * be in different states:
> +	 *  - The common case of not using cancellations, or already
> +	 *    after debugfs_leave_cancellation(), where we just need
> +	 *    to wait for debugfs_file_put() which signals the completion;
> +	 *  - inside a cancellation section, i.e. between
> +	 *    debugfs_enter_cancellation() and debugfs_leave_cancellation(),
> +	 *    in which case we need to trigger the ->cancel() function,
> +	 *    and then wait for debugfs_file_put() just like in the
> +	 *    previous case;
> +	 *  - before debugfs_enter_cancellation() (but obviously after
> +	 *    debugfs_file_get()), in which case we may not see the
> +	 *    cancellation in the list on the first round of the loop,
> +	 *    but debugfs_enter_cancellation() signals the completion
> +	 *    after adding it, so this code gets woken up to call the
> +	 *    ->cancel() function.
> +	 */
>   	while (refcount_read(&fsd->active_users)) {
>   		struct debugfs_cancellation *c;
>   
> 
> 
> Can you test it and let me know if that works?
> 
> Same as what we discussed, FWIW, other than the comments.
> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



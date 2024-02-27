Return-Path: <linux-wireless+bounces-4108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A046869D99
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 18:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C651F2161D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2384DA11;
	Tue, 27 Feb 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Hwex8Hpk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA014C5AE
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054707; cv=none; b=YdWximaVw+kPFhWFFeN2q+Ks0bhA1GKxPVgNbMIhgNU50z6zvAikMdWbzV0OmeOpx4zspWp0OJBA+F7CH2QtHbWmO2byFw7eNNalVXcqwxEKiQOKY4sLuoc04AlmRjzm2sySnqLnezDgrRmaTmXCB7UF7gSS2112kfSvgggfgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054707; c=relaxed/simple;
	bh=MoHnidf2hQOTkA00I04VmJjVUcxuzCQNqo83NuUqMNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VDv3MB/B0WKfa8b1hTy896X0DFXI+55tWnlo1Uj7YbHYZVOTg+KvBhCml0SdmwFI3LImS+J0CLyZ1ZokqXsp+tjxNST/iViMPYSrVT1iQaUNt0y9zJpXCMK/meFH0PJAR/Cn5CYcvKzIsnB9AVgzfUlKD7tvUadgdDcGWfAUOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Hwex8Hpk; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5260DB0005C;
	Tue, 27 Feb 2024 17:25:03 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id D7A3513C2B0;
	Tue, 27 Feb 2024 09:25:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D7A3513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709054702;
	bh=MoHnidf2hQOTkA00I04VmJjVUcxuzCQNqo83NuUqMNQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Hwex8HpkxroAvQD1T+afVrMkdedkgzLtIQdid/t0Hd0mKGNliQ+EUr38SiW9O63r8
	 /a94aRZj+dEmgSzYEUCeSn1/eYLQs9OiqN5xqXtiPhfV4n2kxt+vJPUDYjE4LLSJGQ
	 y6U0D2Kq/idWXvcUUGNGdQbf06fdhjL0ToVKW4/g=
Message-ID: <70e92b03-1566-7eff-ba28-18ef69785205@candelatech.com>
Date: Tue, 27 Feb 2024 09:25:02 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
Content-Language: en-US
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
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <f2aec39d67cdb20cf813b575231ab95b409e315d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709054704-1CQUaOvFqoeA
X-MDID-O:
 us5;ut7;1709054704;1CQUaOvFqoeA;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

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

Thanks for the patch, I'm adding it to our kernel now and we'll start testing it.

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com




Return-Path: <linux-wireless+bounces-4093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82238696EA
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7E91C229A7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EFF78B61;
	Tue, 27 Feb 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="YiJTWW2c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4845613A26F
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043396; cv=none; b=mHv9Ipg090CALuDWRQOcCDUpJd+/cG1y5lWCOWbxaXfL9jmLbtDGVl5b/40Q5qsfnVbUSlFI4rhgv/hPdWv3Q6DvfkaT6pxgixvC9Q+nwlRwjQA/ej3Yut2baNr64CND3rD16gMmchjEefgfAIs6qtFM5pUJnSdslKpEHO6suJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043396; c=relaxed/simple;
	bh=uCr0TVQhqrgqjgzzERfeYooyjKDJid0tWcUuIqgJz5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p8xw6jVSpoYa28qY3RSrxG0ifH977X2gQrWBhhOkiRYIYKpyx4pRmo9UErRJS1pdeGwWa/sSZI/WlnonpWSaJO8edhhyunOg/0/7dOgMa5fp3/mRDd5s14FD3lN5VMxIpB6x2L3ss5Z7lyUqG7ARxemEBotM/tkX3MSuMLWGKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=YiJTWW2c; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6071E2C11FF
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 13:51:31 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3AE60340067;
	Tue, 27 Feb 2024 13:51:24 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.112.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id CA9C813C2B0;
	Tue, 27 Feb 2024 05:51:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CA9C813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709041882;
	bh=uCr0TVQhqrgqjgzzERfeYooyjKDJid0tWcUuIqgJz5U=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YiJTWW2c50NiXPtFXXSLln2tbExim3lWulsOsk3BaK+l8DepZZKi3dFkVOq7hAp6V
	 BpTY19Ifue77eHV7SsNQllZsz6kARsUIxvfAnO6rRgAixelG9i4nDEykA1LvLeCe0n
	 Zz+7XSk0uHbNcKoexOiOyUfP4YojwgmciAwoD0pA=
Message-ID: <6be142ea-6e35-4f1e-8763-6f4455f51135@candelatech.com>
Date: Tue, 27 Feb 2024 05:51:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
Content-Language: en-MW
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
 <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
 <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
 <0f8a0451e547f318febcbe36823e1f9914cc684b.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <0f8a0451e547f318febcbe36823e1f9914cc684b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709041884-9x7f-qZ8qf11
X-MDID-O:
 us5;ut7;1709041884;9x7f-qZ8qf11;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 2/27/24 05:47, Johannes Berg wrote:
> 
>> Feb 26 06:01:45 ct523c-0b0b kernel: task:ip              state:D stack:0     pid:28125 tgid:28125 ppid:3604   flags:0x00004002
>> Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
>> Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
>> Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
>> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
>> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_timeout+0x19c/0x1b0
>> Feb 26 06:01:45 ct523c-0b0b kernel:  ? mark_held_locks+0x49/0x70
>> Feb 26 06:01:45 ct523c-0b0b kernel:  __wait_for_common+0xba/0x1d0
>> Feb 26 06:01:45 ct523c-0b0b kernel:  ? usleep_range_state+0xb0/0xb0
>> Feb 26 06:01:45 ct523c-0b0b kernel:  remove_one+0x6b/0x100
> 
> Can you say where this remove_one+0x6b is?
> 
> I feel it's probably this:
> 
>         if (!refcount_dec_and_test(&fsd->active_users)) {
>                 wait_for_completion(&fsd->active_users_drained);
> 
> which ... looking at it, seems wrong?


(gdb) l *(remove_one+0x6b)
0xffffffff815c257b is in remove_one (/home/greearb/git/linux-6.7.dev.y/fs/debugfs/inode.c:757).
752			return;
753	
754		/* if we hit zero, just wait for all to finish */
755		if (!refcount_dec_and_test(&fsd->active_users)) {
756			wait_for_completion(&fsd->active_users_drained);
757			return;
758		}
759	
760		/* if we didn't hit zero, try to cancel any we can */
761		while (refcount_read(&fsd->active_users)) {
(gdb)

> 
> _Completely_ untested:

We can test it.

Thanks,
Ben

> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 034a617cb1a5..fb636478c54d 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -751,13 +751,19 @@ static void __debugfs_file_removed(struct dentry *dentry)
>   	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
>   		return;
>   
> -	/* if we hit zero, just wait for all to finish */
> -	if (!refcount_dec_and_test(&fsd->active_users)) {
> -		wait_for_completion(&fsd->active_users_drained);
> -		return;
> -	}
> +	/*
> +	 * Now that debugfs_file_get() no longer sees a valid entry,
> +	 * decrement the refcount to remove the initial reference.
> +	 */
> +	refcount_dec(&fsd->active_users);
>   
> -	/* if we didn't hit zero, try to cancel any we can */
> +	/*
> +	 * As long as it's not zero, try to cancel any cancellations,
> +	 * new incoming ones will wake up the completion as we might
> +	 * have raced: debugfs_file_get() had already been done, but
> +	 * debugfs_enter_cancellation() hadn't, by the time we got
> +	 * to this point here.
> +	 */
>   	while (refcount_read(&fsd->active_users)) {
>   		struct debugfs_cancellation *c;
>   
> 
> 
> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



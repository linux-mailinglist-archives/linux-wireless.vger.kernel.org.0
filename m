Return-Path: <linux-wireless+bounces-4097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D9986990F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C8D1C23962
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424DF5427E;
	Tue, 27 Feb 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="WjMXMzB+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD361420B3
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045493; cv=none; b=YMzssfpNfm1CNNg+ampNSyFHi+X9b08p/LSYF9QgQsUJc4NWNqvf/ibhN7jYzsK92GhLEht8n7+70fuGv8Xu603fLN5akw6xRUzaNNW+ljMZk5SDa/AX6kVQgfVGO4tareDxYKz2iOA/vhl1K/pBZQP11IPvM17dnLKsPnJjOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045493; c=relaxed/simple;
	bh=07QptczXMHRpMR5HGVOTbEeEh8Oj/f3z0Lx5HPHD2NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SKPG9NXtiSOhiDUmg1iN3JBapaQO6Ke8HMhBWBkyOKEv6jjqvXqtNRahhvHna6CkZGKVjb3XAAWoA6LBE88dzBDH/pZWxBdK6bJKbO2vSrktzdWh/qJn0ThlrLkvSt5b5fE3r60SZ8ZJ+hm8f4kD2XkDkKEmb2LTnEKSB/i+kgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=WjMXMzB+; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CC1E728006D;
	Tue, 27 Feb 2024 14:51:28 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.112.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3DB8A13C2B0;
	Tue, 27 Feb 2024 06:51:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3DB8A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709045488;
	bh=07QptczXMHRpMR5HGVOTbEeEh8Oj/f3z0Lx5HPHD2NU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WjMXMzB+91w4yL9JdLZw2f4Fu2+wtZK+edNzquBlaMnqrcoBfCOK9cnzL3hADxehO
	 8bbgdwp/+FZ+NUepxSwR3CDM/Czediv+5nt52f+ozOU7sIy76CBg5YZ9ea/tP/qi/A
	 /2MHg4E+s7/MW+aCdMF1/f0esUgUnywfubmhhjw0=
Message-ID: <492a290b-752f-48c3-be16-59bdf7914487@candelatech.com>
Date: Tue, 27 Feb 2024 06:51:27 -0800
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
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <4a3edd404b84da53b56bb0a391cb42d00f42f4c5.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709045489-V0iTIow36OUn
X-MDID-O:
 us5;ut7;1709045489;V0iTIow36OUn;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 2/27/24 06:32, Johannes Berg wrote:
> On Tue, 2024-02-27 at 06:29 -0800, Ben Greear wrote:
>>> --- a/fs/debugfs/inode.c
>>> +++ b/fs/debugfs/inode.c
>>> @@ -751,13 +751,19 @@ static void __debugfs_file_removed(struct dentry *dentry)
>>>    	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
>>>    		return;
>>>    
>>> -	/* if we hit zero, just wait for all to finish */
>>> -	if (!refcount_dec_and_test(&fsd->active_users)) {
>>> -		wait_for_completion(&fsd->active_users_drained);
>>> -		return;
>>> -	}
>>> +	/*
>>> +	 * Now that debugfs_file_get() no longer sees a valid entry,
>>> +	 * decrement the refcount to remove the initial reference.
>>> +	 */
>>> +	refcount_dec(&fsd->active_users);
> 
>>
>> [   94.576688] ------------[ cut here ]------------
>> [   94.576699] refcount_t: decrement hit 0; leaking memory.
>>
> 
> Ah ... right, refcount_dec() doesn't like to hit 0, it's not meant for
> this path.
> 
> I guess we can
> 
> if (refcount_dec_and_test(...))
>     return;
> 
> while (refcount_read(...)) { ... }
> 
> johannes
> 

Like this?

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 034a617cb1a5..166053095610 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -751,13 +751,20 @@ static void __debugfs_file_removed(struct dentry *dentry)
         if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
                 return;

-       /* if we hit zero, just wait for all to finish */
-       if (!refcount_dec_and_test(&fsd->active_users)) {
-               wait_for_completion(&fsd->active_users_drained);
+       /*
+        * Now that debugfs_file_get() no longer sees a valid entry,
+        * decrement the refcount to remove the initial reference.
+        */
+       if (!refcount_dec_and_test(&fsd->active_users))
                 return;
-       }

-       /* if we didn't hit zero, try to cancel any we can */
+       /*
+        * As long as it's not zero, try to cancel any cancellations,
+        * new incoming ones will wake up the completion as we might
+        * have raced: debugfs_file_get() had already been done, but
+        * debugfs_enter_cancellation() hadn't, by the time we got
+        * to this point here.
+        */
         while (refcount_read(&fsd->active_users)) {
                 struct debugfs_cancellation *c;


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9132C7E5C92
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 18:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjKHRoW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 12:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHRoW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 12:44:22 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C391FE4
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 09:44:20 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EC2BAC4006A;
        Wed,  8 Nov 2023 17:44:17 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3026E13C2B0;
        Wed,  8 Nov 2023 09:44:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3026E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699465456;
        bh=0EXGZf6IDZjUYiwHNYQlEx8Fqm1x2qyWmcuS4jo+xc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=czVg8sptCKWwcZqZQcJu1gA3qXONbErAfgkEv59CbYJg7PAsNsCZZEsqt2Cdyw1LS
         I8uB8udujNXsjTcMdBBh+PYXw9Q/+JdNlbCcpMPOMmsFXQkdCctqgjuS+nNRepBLSr
         Fd/f9jfwyWCnVVCtPEn2pJef9JHTS4YjXDa2Fmhs=
Message-ID: <21a4b983-1d5c-8c76-0994-d8a43285b19d@candelatech.com>
Date:   Wed, 8 Nov 2023 09:44:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Nicolai Stange <nicstange@gmail.com>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
 <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
 <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
 <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
 <dd6c7cf2-1955-4c70-fd2f-ffe2915111f4@candelatech.com>
 <0cfd8ae0577e52fe8db41dbfb37ee5197a1857d6.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <0cfd8ae0577e52fe8db41dbfb37ee5197a1857d6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1699465458-WUI3_xWOx5qT
X-MDID-O: us5;ut7;1699465458;WUI3_xWOx5qT;<greearb@candelatech.com>;ea9bd3aeb2d9945ea56a779a64e478e9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/23 08:07, Johannes Berg wrote:
> On Wed, 2023-11-08 at 07:55 -0800, Ben Greear wrote:
>> On 11/8/23 7:44 AM, Johannes Berg wrote:
>>> On Wed, 2023-11-08 at 07:07 -0800, Ben Greear wrote:
>>>> On 11/8/23 2:31 AM, Johannes Berg wrote:
>>>>> On Tue, 2023-11-07 at 14:08 -0800, Ben Greear wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I think this lockup is because iw is holding rtnl and wiphy mutex,
>>>>>> and is blocked waiting for debugfs to be closed.  Another 'cat'
>>>>>> program has debugfs file open, and is blocking on trying to acquire
>>>>>> wiphy mutex.
>>>>>>
>>>>>> I think we must not acquire wiphy mutex in debugfs methods, somehow,
>>>>>> to resolve this deadlock.  I do not know a safe way to do that.
>>>>>
>>>>> Hmm. I almost want to say "don't do that then", but I guess you're just
>>>>> randomly accessing debugfs files.
>>>>>
>>>>> I guess we can at least make the mutex acquisition in debugfs killable
>>>>> (or interruptible), so you can recover from this.
>>>>
>>>> If we can detect that the phy is going away in debugfs, then we could
>>>> return early before attempting the lock?  That would catch most things,
>>>> I guess,
>>>>
>>>
>>> I don't think it would, it would still get locked on the mutex first.
>>>
>>>>    but still a potential race since I guess we'd have to do that check
>>>> w/out locks.  Can we do a try-mutex-lock, if not acquired, return if wiphy-going-away,
>>>> else sleep a bit, try again?
>>>
>>> That's kind of awful though? And it's not just the wiphy going away, a
>>> lot of the debugfs files can go away individually (per station, per
>>> link, per key even!).
>>
>>   From the backtrace in the removal logic, it seems that something waits
>> for a debugfs file to be closed.
> 
> Yes, debugfs remove waits for it to no longer have active users, but
> that cannot succeed because the users are blocked on acquiring the
> mutex.
> 
>> Maybe the logic attempting to get the
>> mutex in debugfs can check if file is waiting to be deleted,
>> combined with a try-mutex-lock logic, and bail out that way?
> 
> I don't know if there's a way to check that, but I'm also not sure how
> you'd even implement that?

This code is new to me, but we have a file object in debugfs callbacks,
and this method appears to get dentry from a file object:

static inline struct dentry *file_dentry(const struct file *file)
{
	return d_real(file->f_path.dentry, file_inode(file));
}


In the delete path, we have a dentry object:

void debugfs_remove(struct dentry *dentry)
{
	if (IS_ERR_OR_NULL(dentry))
		return;

	simple_pin_fs(&debug_fs_type, &debugfs_mount, &debugfs_mount_count);
	simple_recursive_removal(dentry, remove_one);
	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
}
EXPORT_SYMBOL_GPL(debugfs_remove);


We could add a wiphy_trylock method, similar to this:

static inline void wiphy_lock(struct wiphy *wiphy)
         __acquires(&wiphy->mtx)
{
         mutex_lock(&wiphy->mtx);
         __acquire(&wiphy->mtx);
}


But using mutex_trylock instead.


This method appears to actually set a S_DEAD flag in the dentry, so maybe
we just check that flag in the mutex_trylock failed to acquire path
in the debugfs read?

void simple_recursive_removal(struct dentry *dentry,
                               void (*callback)(struct dentry *))
{
	struct dentry *this = dget(dentry);
	while (true) {
		struct dentry *victim = NULL, *child;
		struct inode *inode = this->d_inode;

		inode_lock(inode);
		if (d_is_dir(this))
			inode->i_flags |= S_DEAD;


Let me know what you think on that...

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



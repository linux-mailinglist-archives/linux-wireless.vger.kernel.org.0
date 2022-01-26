Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0E49D1FD
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 19:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiAZSqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jan 2022 13:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244174AbiAZSqY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jan 2022 13:46:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824DC06161C
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jan 2022 10:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=opclA0DUStE1PMARiQDjpZxRyQ7aFawaQ00oXcShzZk=; b=Z0v3fh/ueBBudugfuorxBfLBlO
        33yvNu8fYtTvjXXc9Q1uEVCmwjhAt/0kzT7BHyusIYENdgxSbGVohTqxcvdLot1R7E9EQCFCsObs9
        E77Q7uQ0/8Sub2C82QdoRVmcpKHX36pk3e6Kx2LLS7vP27MZ0Df2VMU2wVxd3o3c2RVGuNVu76fmc
        yFWHQSianVgoCu0hM2R5cI8DxVGZ6qB6BvGRSZdN4dQgGfQ0WDqPBex0J8mn3GCL0xxuGcMHDNetB
        Yajvvm4s4R2HOIOBhMM2qLs0aMqW/XLTi2ZnB9M7EctYMf9/G7iEmTA7nxtKtKCwrrLJAnbBumFAU
        tJdZO7Xg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCnJF-004Klo-Gf; Wed, 26 Jan 2022 18:46:22 +0000
Message-ID: <fcf1735d-909f-8b2d-cb0f-ca397047b8a8@infradead.org>
Date:   Wed, 26 Jan 2022 10:46:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: iwlwifi problems, maybe firmware related?
Content-Language: en-US
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        greearb <greearb@candelatech.com>
Cc:     "Ben Ami, Golan" <golan.ben.ami@intel.com>
References: <92b00b94-aff6-8108-06d1-932b77f9d218@infradead.org>
 <04761964-e3b3-b2f7-78a4-bbc3507ad676@candelatech.com>
 <0ee64c55-1326-addb-7c9c-c922373f78c0@infradead.org>
 <cb3e4991c19659ab73cc0d9c12e8b7dbba9d652d.camel@intel.com>
 <aa666e92-6c8b-5689-1a9a-6e61d68b096d@infradead.org>
 <dc56d6a7b2e0f2b76d6a584fb62fb235e691d9ff.camel@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <dc56d6a7b2e0f2b76d6a584fb62fb235e691d9ff.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 1/26/22 10:36, Coelho, Luciano wrote:
> On Wed, 2022-01-26 at 10:32 -0800, Randy Dunlap wrote:
>> Hi--
>>
>> On 1/25/22 23:12, Coelho, Luciano wrote:
>>> Hi,
>>>
>>> Adding Golan to the thread.
>>>
>>> On Tue, 2022-01-25 at 18:20 -0800, Randy Dunlap wrote:
>>>>
>>>> On 1/25/22 15:58, Ben Greear wrote:
>>>>> On 1/25/22 3:08 PM, Randy Dunlap wrote:
>>>>>> Hi,
>>>>>>
>>>>>> When I boot 5.16 or 5.17-rc1, I get messages like:
>>>>>>
>>>>>> iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
>>>>>> iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
>>>>>> iwlwifi 0000:00:14.3: loaded firmware version 67.8f59b80b.0 QuZ-a0-hr-b0-67.ucode op_mode iwlmvm
>>>>>
>>>>> We see nothing but crashes with the version 67 firmware.  Remove that
>>>>> from your /lib/firmware/ dir (and make sure version 66 or lower is there),
>>>>> and reboot and it should work again.
>>>>
>>>> Well. Yes, that does make things work for me.
>>>>
>>>> It's odd, though, that openSUSE Tumbleweed with kernel "Linux version 5.16.1-1-default"
>>>> (whatever that is) also works with no problems.
>>>>
>>>> Thanks for your help.
>>>
>>> This is because of broadcast filtering.  This feature hasn't been
>>> supported for quite a while and now the firmware rejects the command we
>>> send to it.
>>>
>>> The easy fix is to compile iwlwifi without
>>> CONFIG_IWLWIFI_BCAST_FILTERING (which should not be enabled by
>>> default).
>>
>> Just confirming that kernel 5.16 without broadcast filtering works
>> with firmware v67.
> 
> Great, thanks for the confirmation!
> 
> Just out of curiosity.  How did you end up with broadcast filtering
> enabled? Is it a default configuration from some distro?
> 

Nope.  I didn't know that it was not supported so I enabled it.

> 
>>> I have removed this option from the driver now and will send the patch
>>> to 5.17-rc* as a fix.
>>
>> Yes, please.
> 
> Will do.
> 
> --
> Cheers,
> Luca.

-- 
~Randy

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D3D26021A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 19:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgIGRTH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 13:19:07 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:53920 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbgIGRTB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 13:19:01 -0400
Received: from [192.168.254.6] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3432A13C2B4;
        Mon,  7 Sep 2020 10:18:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3432A13C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1599499136;
        bh=n1wE2uxDMw2GakTonFckMb81Mk/JyNm3M/mB1szOXf4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MhlBbc6dYG1k3Wd1XYYwbtAL8u2A2kyi5s3I/IudS0NMdyAoILUZcQZGCxyp/odor
         TYVTsDqCTHuQN1nzNyJwE0esa5cDOGVEc+IoKfcaYPweZ/IAz3johm6oge8Kn6tNO0
         BHphOswlkpFZk7DvtsTNc8O3+8ZDt7Dq6hGFYo0o=
Subject: Re: [RFC] ath10k: change to do napi_enable and napi_disable when
 insmod and rmmod for sdio
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
References: <20200214035555.24762-1-wgong@codeaurora.org>
 <878se9iup3.fsf@codeaurora.org>
 <CABPxzYK4kYvBAvYxk6rs-PHM==vBaHQTm3dCCh_+Z+KOB+c6qA@mail.gmail.com>
 <b7e0e8dfe9a4ee0cb92c6c0f153c7bc2@codeaurora.org>
 <CABPxzYK6wd8FGaM9tb_PYroARJ8RCjJ0Y-nVxY3AoubrfSbZ4w@mail.gmail.com>
 <dcc45384935dca14ac6ab31ec1123414@codeaurora.org>
 <CABPxzYLu_81h+aWWeNKRyH=CJ=+waB3zmT41BTZ9Mo733PqErQ@mail.gmail.com>
 <acb2bd58-2f95-e09c-9575-b45c0e2aeb70@candelatech.com>
 <CABPxzY+tPos8ByT76hU1ngoxwYcBHaRpFMCKGQJcc_ssoqGNSw@mail.gmail.com>
 <47c1b1e0-afc4-b9b4-5fc0-4636d8b3b981@candelatech.com>
 <CABPxzYLD-M5wpWF6r=K=8YTosSfjctmaaBPCyBP72q-mY0PTcw@mail.gmail.com>
 <CABPxzYLOZf9Fu5O3Rt_mVcXeFLuuFAsqyvd7jiCVvJ0x2BN-+g@mail.gmail.com>
 <dd8cb5db-f164-c235-1f39-cd78ea97f8be@candelatech.com>
 <CABPxzY+uyy_Yc0mHb7sJGxxUE5__Z8SpywodAv2YCM8D89waHw@mail.gmail.com>
 <c69abe52-ccd1-ac73-8691-d87f5ed8be76@candelatech.com>
 <0101017469521b96-b069f805-537a-479e-bd91-a53357035e68-000000@us-west-2.amazonses.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <d9877653-1ec6-0c43-5983-85fd705a515e@candelatech.com>
Date:   Mon, 7 Sep 2020 10:18:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0101017469521b96-b069f805-537a-479e-bd91-a53357035e68-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/7/20 9:07 AM, Kalle Valo wrote:
> Ben Greear <greearb@candelatech.com> writes:
> 
>>>>>>> Here is my original patch to fix this, it is not complex.
>>>>>>>
>>>>>>> https://patchwork.kernel.org/patch/10249363/
>>>>>> Sure, I have shared your patch above :).
>>>>> Sent a bit early, any idea why this wasn't upstreamed earlier?
>>>>
>>>> No, one comment from Michal indicated maybe there were more problems lurking
>>>> in this area, but he seemed to be OK with the patch over all.  After that,
>>>> it was just ignored.
>>>>
>>> Now might be a good time to push for it :)
>>>
>>
>> It is generally a waste of time in my experience.  Kalle is the maintainer and should
>> be seeing any of this he cares to see.  If he likes the patch, he can apply it or
>> something similar.  If you have a reproducible test case, see if the patch fixes
>> things, that might help it be accepted.
> 
> The problem with yours (Ben's) patches is that you have your own set of
> patches for ath10k and your own firmware. So I cannot know at all if
> your patches work with upstream ath10k and upstream firmware, and would
> need to test the patches myself. But nowadays I just can't find the time
> for testing. So if someone else can do the testing and provide a
> Tested-on tag it would it increase my confidence level for the patches.

Surely codeaura could get a few entry level engineers to run basic testing against
your target platforms on a regular basis?  The several years of time this bug was
known (to me at least, and to whoever saw my original patch) and the time wasted
by codeaura to rediscover and re-fix the bug would have much better been spent just
testing and review my patch to begin with.  And not just my patches either, this
pattern is far and wide in ath10k.

Also, my driver is often tested against various upstream QCA firmware and chipsets in openwrt,
so while bugs are always possible, there is some test coverage.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

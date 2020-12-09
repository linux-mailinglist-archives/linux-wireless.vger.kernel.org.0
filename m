Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A0E2D4517
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgLIPHN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:07:13 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:44896 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgLIPHN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:07:13 -0500
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2020 10:07:13 EST
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E61F313C2B0;
        Wed,  9 Dec 2020 07:00:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E61F313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1607526053;
        bh=OR648aOCXhz2Gq/9MQpsWe6Djt9POxXU4ZKniX/RKyw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CvkNkQRri8oIpzYBXdMvXR0uG2joRtgx9nJ6EjOoWNKHy0Vky956pLg8X+cMBA5EO
         SoRpXs29tNK4YO22CPIdJteFUqFHvbB7sevFr+VHBKfhvnd8kVrz/rcYekOmDZ5Xmp
         3H2lJMpQLBx2P/xoqjM2nwi2B7ofBV6lR/4cmyD8=
Subject: Re: [PATCH v3] ath10k: add flag to protect napi operation to avoid
 dead loop hang
To:     Kalle Valo <kvalo@codeaurora.org>, Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <1598617348-2325-1-git-send-email-wgong@codeaurora.org>
 <87d02x1rqb.fsf@codeaurora.org>
 <010101746bd17881-819242de-7cbb-4df3-93e2-59473d281155-000000@us-west-2.amazonses.com>
 <87r1nzbadn.fsf@codeaurora.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <8a97f5ba-8eba-d61b-4c92-bdfd08d388ee@candelatech.com>
Date:   Wed, 9 Dec 2020 07:00:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1nzbadn.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/9/20 1:24 AM, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> On 2020-09-08 00:22, Kalle Valo wrote:
>>
>>> Just like with the recent firmware restart patch, isn't
>>> ar->napi_enabled
>>> racy? Wouldn't test_and_set_bit() and test_and_clear_bit() be safer?
>>>
>>> Or are we holding a lock? But then that should be documented with
>>> lockdep_assert_held().
>>
>> yes, ath10k_hif_start is only called from ath10k_core_start, it has
>> "lockdep_assert_held(&ar->conf_mutex)", and ath10k_hif_stop is only
>> called from ath10k_core_stop, it also has
>> "lockdep_assert_held(&ar->conf_mutex)". then it will not 2 thread both
>> enter ath10k_hif_start/ath10k_hif_stop meanwhile.
> 
> Ok, but every function depending on a lock being held should still call
> lockdep_assert_held(), that way we can catch the bug if locking changes
> later. So it's not enough that ath10k_core_stop() has
> lockdep_assert_held(), also these napi functions should have it.
> 
> I actually decided to switch using ATH10K_FLAG_NAPI_ENABLED with
> set_bit() & co, simpler locking that way and no lockdep_assert_held()
> needed anymore. Please check my changes in the pending branch, I have
> only compile tested them:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=e0a466d296bd862080f7796b41349f9f586272c9
> 

Why do you not need locking?  You can't just check a bit is set and then do work and set
it later without locking, two concurrent CPU threads can pass the first check and both get into
the logic below it?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

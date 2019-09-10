Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71988AEB55
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2019 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfIJNTh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Sep 2019 09:19:37 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:47282 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfIJNTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Sep 2019 09:19:36 -0400
Received: from [192.168.1.47] (unknown [50.34.216.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E33D8104F;
        Tue, 10 Sep 2019 06:19:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E33D8104F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1568121576;
        bh=JA0ADspSHp+Rb9ZUh6KL1eOvy9wEnd+GKRwLsN5l5tU=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=hAkZVrtNED9+nz1OQPG0JOHHxBFuSA6fVubMJWh75oUuUf5016A4jDgBc+jy80Lj7
         VCFCAJowTW0CCgUea42EpvdETf1sT6ySXqAEz8GxHEu03kvL3Hxtd5Rg/sqBPZRhGP
         oYsqZK3uBbR3Vx+wVqrDJvX+c7ZO1ZSHylS03mMw=
Subject: Re: [PATCH] ath10k: Free beacon buf later in vdev teardown.
To:     Kalle Valo <kvalo@codeaurora.org>
References: <20190227162756.13048-1-greearb@candelatech.com>
 <20190910131244.267AF602F2@smtp.codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <89712e32-1fb2-f002-15ed-046871c161ce@candelatech.com>
Date:   Tue, 10 Sep 2019 06:19:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190910131244.267AF602F2@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 09/10/2019 06:12 AM, Kalle Valo wrote:
> greearb@candelatech.com wrote:
>
>> My wave-1 firmware often crashes when I am bringing down
>> AP vdevs, and sometimes at least some machines lockup hard
>> after spewing IOMMU errors.
>>
>> I don't see the same issue in STA mode, so I suspect beacons
>> are the issue.
>>
>> Moving the beacon buf deletion to later in the vdev teardown
>> logic appears to help this problem.  Firmware still crashes
>> often, but several iterations did not show IOMMU errors and
>> machine didn't hang.
>
> I'm not really fond of fixing issues just by luck but after a quick look at the
> code I can't see any harm in this change either. So I guess it's ok.
>
> But can you provide the exact hardware and firmware you used for testing, I'll
> add it to the commit log. I want to document that in every commit:

I used Compex WLE900VX hardware, and the firmware was ath10k-ct something or other,
it has been a long time, so I don't recall the exact firmware version.

The real fix for this is to have the firmware do proper beacon tx completion
logic so that the driver can know when it can safely free buffers.  I implemented
this in my ath10k-ct firmware/driver, but unless you want to start accepting patches for my
firmware, then that will not help upstream ath10k.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

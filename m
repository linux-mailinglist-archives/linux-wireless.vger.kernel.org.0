Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BC41BC553
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgD1Qf7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 12:35:59 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:33970 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgD1Qf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 12:35:59 -0400
Received: from [192.168.254.4] (unknown [50.34.219.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4AEB613C283;
        Tue, 28 Apr 2020 09:35:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4AEB613C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1588091758;
        bh=ZYghGw0vlBWMqmUCZUGpGwpq9saVPWcv8y4CKBdZoMc=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=L9r3WdnCfxqlZ4Vut1ZyN4syYB+DSGQWf5dnd2Z73IGksNcmCJtIJ2ILJtj6WpkSN
         xIqZbi+HjpbC9alvKk0op63SVOT7YXrcPQAI+5tY2c0TM7wOuF8mrnPlDZaKBKY5Jg
         9pcKk21ce0CwktDmhapOTeCTuUXMK11UVd1qGGJY=
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     Dave Taht <dave.taht@gmail.com>,
        Steve deRosier <derosier@gmail.com>
References: <20200427145435.13151-1-greearb@candelatech.com>
 <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com>
 <CAA93jw5tcptB64B8nGH0hqr4xC9G2SXNjp2tPf3YK5R7t6ZjXw@mail.gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <ae5587d1-f910-5fbe-42ab-3c4d722b259b@candelatech.com>
Date:   Tue, 28 Apr 2020 09:35:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAA93jw5tcptB64B8nGH0hqr4xC9G2SXNjp2tPf3YK5R7t6ZjXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 04/28/2020 09:27 AM, Dave Taht wrote:
> On Tue, Apr 28, 2020 at 7:56 AM Steve deRosier <derosier@gmail.com> wrote:
>>
>> On Mon, Apr 27, 2020 at 7:54 AM <greearb@candelatech.com> wrote:
>>>
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> While running tcp upload + download tests with ~200
>>> concurrent TCP streams, 1-2 processes, and 30 station
>>> vdevs, I noticed that the __ieee80211_stop_queue was taking
>>> around 20% of the CPU according to perf-top, which other locking
>>> taking an additional ~15%.
>>>
>>> I believe the issue is that the ath10k driver would unlock the
>>> txqueue when a single frame could be transmitted, instead of
>>> waiting for a low water mark.
>>>
>>> So, this patch adds a low-water mark that is 1/4 of the total
>>> tx buffers allowed.
>>>
>>> This appears to resolve the performance problem that I saw.
>>>
>>> Tested with recent wave-1 ath10k-ct firmware.
>>>
>>
>> Hey Ben,
>>
>> Did you do any testing with this patch around latency?  The nature of
>> the thing that you fixed makes me wonder if it was intentional with
>> respect to making WiFi fast - ie getting rid of buffers as much as
>> possible.  Obviously the CPU impact is likely to be an unintended
>> consequence. In any case, I don't know anything for sure, it was just
>> a thought that went through my head when reading this.
>
> I note that I'd prefer a BQL-like high/low watermark approach in
> general... bytes, not packets, or better, perceived
> airtime in a revision of AQL...
>
> ... but we'll try this patch, thx!

Is there a nice diagram somewhere that shows where the various
buffer-bloat technologies sit in the stack?  I suspect such should
be above the txqueue start/stop logic in the driver that I mucked
with, and certainly the old behaviour has no obvious tie-in with
any higher-level algorithms.

I doubt my patch will change much except in pathological cases where
the system is transmitting frames fast enough to fully fill the tx buffers
and also loaded in such a way that it can process just a few tx frames
at a time to keep bouncing to full and not full over and over.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

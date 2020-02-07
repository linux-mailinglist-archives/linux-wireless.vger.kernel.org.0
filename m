Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE551155F81
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 21:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgBGUXO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 15:23:14 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:35162 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGUXO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 15:23:14 -0500
Received: from [10.0.0.63] (unknown [118.127.122.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id EDAFB137584;
        Fri,  7 Feb 2020 12:23:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EDAFB137584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1581106993;
        bh=9t4zsUFWW+0lmvPDywrAFsaf3/D0zeaKB9mxwRa8aeU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=XNlKLiaGq27eCLYimKrs5aWgBPoHr8Hp3o/dLA9zd4W0ympDYLbtAAIkfB8nIq713
         E3vD1SQcfvw6U9VPAftAMDyjxGOVhMVrOyyyk64m3x072pPAXy8zzmlR1FPd5Rjd+9
         0sOkb5g15pUX70BEucagZhSFZjQsdhO3y0igCIlE=
Message-ID: <5E3DC72E.1050403@candelatech.com>
Date:   Fri, 07 Feb 2020 12:23:10 -0800
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] mac80211: Fix setting txpower to zero.
References: <20191217183057.24586-1-greearb@candelatech.com>                 (sfid-20191217_193103_026347_235EB2CE) <27b64bd26e7d8c13d22a3a9b950eb3db16b630a2.camel@sipsolutions.net>         <5E3DA498.20505@candelatech.com> <3c6bdd85a2d476d9ca7268803c03d0ae417a7560.camel@sipsolutions.net>
In-Reply-To: <3c6bdd85a2d476d9ca7268803c03d0ae417a7560.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 02/07/2020 11:19 AM, Johannes Berg wrote:
> On Fri, 2020-02-07 at 09:55 -0800, Ben Greear wrote:
>> On 02/07/2020 04:03 AM, Johannes Berg wrote:
>>> On Tue, 2019-12-17 at 10:30 -0800, greearb@candelatech.com wrote:
>>>>    drivers/net/wireless/ath/ath10k/mac.c | 3 ++-
>>>>    drivers/net/wireless/ath/ath9k/main.c | 3 +++
>>>>    drivers/net/wireless/ath/ath9k/xmit.c | 7 +++++--
>>>
>>> All these driver changes worry me a bit - wouldn't that affect other
>>> drivers as well?
>
>> The goal was to NOT adversely affect the drivers when the default (not-set)
>> value changed.
>
> Right.
>
>> I changed the name of the variable and then touched every driver that used it
>> as a way of making sure that I found everything in the tree.
>>
>> Hopefully that found everything...  I did not specifically test ath9k, only ath10k
>> driver with this change.
>>
>> (I then changed the variable name back before submitting the patch).
>
> OK, great, thanks :)

Come to think of it, I did not do an 'all mod config' build, so possibly I missed some
things.  I think my kernel compiles most of the drivers though.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


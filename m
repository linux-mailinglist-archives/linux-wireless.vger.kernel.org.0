Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5F4291A9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 16:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbhJKOYQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 10:24:16 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:58468 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238126AbhJKOXA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 10:23:00 -0400
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 10:23:00 EDT
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1D1B0226157
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 14:12:48 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.177])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 26EF41A006C;
        Mon, 11 Oct 2021 14:12:44 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DAA40680017;
        Mon, 11 Oct 2021 14:12:43 +0000 (UTC)
Received: from [192.168.1.115] (unknown [206.214.224.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 27EE713C2B0;
        Mon, 11 Oct 2021 07:12:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 27EE713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1633961546;
        bh=GoJnhjzl+/RzwgltKNAs/NgVXCHQ3prpK60tN6Zsq2I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZkpYyjzzzKFlxDTz+k28G6xfpND3BJTwn9AZVVfdJFxGaNbhARhrgzeL2II4hUIB9
         WmweXJkbOKLFk0fkLfZbDBP4JDK9Uzau/LoePFVr18qpfCeZoEtH4sXh+4m8kwinBI
         1sBMmnvdjbhLWc/nr2XbehVqsVAAuy3ivBm9xuS4=
Subject: Re: [PATCH v5 05/11] mt76: mt7915: debugfs hook to enable TXS for
 NO_SKB pkt-ids
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <20210804134505.3208-1-greearb@candelatech.com>
 <20210804134505.3208-5-greearb@candelatech.com>
 <87mtpda079.fsf@tynnyri.adurom.net>
 <093b94ea-b6db-aca8-26c4-6981e57e8ff4@candelatech.com>
 <87ily352s4.fsf@codeaurora.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <0894595c-cea8-6ced-2082-9c7abc9f88d3@candelatech.com>
Date:   Mon, 11 Oct 2021 07:12:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87ily352s4.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1633961564-3JT5r9KMCoxz
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/11/21 2:28 AM, Kalle Valo wrote:
> Ben Greear <greearb@candelatech.com> writes:
> 
>> On 8/19/21 9:06 AM, Kalle Valo wrote:
>>> greearb@candelatech.com writes:
>>>
>>>> From: Ben Greear <greearb@candelatech.com>
>>>>
>>>> This lets user turn on/off this feature.  Enabling gives better
>>>> tx-rate related stats, but will cause extra driver and (maybe)
>>>> firmware work.  Not sure if it actually affects performance or
>>>> not.
>>>>
>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>
>>> This is grey area, debugfs is not really meant to be used for users
>>> enabling driver features.
>>>
>>
>> What method do you suggest?  Surely not trying to drive something down through
>> netlink for something this chipset specific?
> 
> I think a module parameter would be a good choise for enabling this kind
> of feature.
> 
> Of course the downside of a module parater is that when it's not
> possible to configure this per device, only per driver. Like discussed
> many times in the past, we would really need some kind more advanced
> module parameters which can be per device.

Enabling/disabling via debugfs is way more useful than a module parameter.
It is per-device and also changeable at run-time.  Maybe you want to enable
detailed stats for a bit of time for some reason, and then go back to lower
overhead approach.

You are asking for a worse technical solution than debugfs implementation.

For the per-device module parameters, I implemented something similar for
ath10k using a 'fwcfg' file that is loaded with device options sort of like
a board file.  That worked well enough for that sort of thing.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

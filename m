Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8661E48DCB2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiAMRMU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 12:12:20 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:52938 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229943AbiAMRMU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 12:12:20 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.128])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B21521A0085;
        Thu, 13 Jan 2022 17:12:18 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7EB3B780082;
        Thu, 13 Jan 2022 17:12:18 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.67.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id F06C313C2B0;
        Thu, 13 Jan 2022 09:12:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F06C313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1642093938;
        bh=nZGDcJEZ24/j/i8GbDGMRXUvTp6XWAkn4ZU4+JS2/9c=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=q+BkB+FCBZ27RuwItewFpJMs61utGsHzIgSkN1ARUZypnZjJu87W6aS2XF85V4B6t
         GVoFRkCcAtaN4FYm5xoI9GFgtBKyJsInkV7GqavXegjJJmm9qF/5vPz7B6gUz2gZzp
         PVnXngCokI62N2RxQPYPl3/T7MHl+NlgOMo/jWIk=
Subject: Re: iwlwifi: AX201 not using 2 receive streams
To:     Brandon Nielsen <nielsenb@jetfuse.net>,
        linux-wireless@vger.kernel.org
References: <3cb11500-6828-6ded-bebc-cdb6e1f97bc0@jetfuse.net>
 <521b0dba-5866-ff34-da5a-479bc95cc9d9@candelatech.com>
 <60724ae6-e8e2-183d-575a-0186e45c3fae@jetfuse.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <679864d0-25da-b3c7-b1da-c77deb52fd3a@candelatech.com>
Date:   Thu, 13 Jan 2022 09:12:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <60724ae6-e8e2-183d-575a-0186e45c3fae@jetfuse.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-MDID: 1642093939-slmrbq4UF753
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/11/22 11:46 AM, Brandon Nielsen wrote:
> On 1/8/22 3:22 PM, Ben Greear wrote:
>> On 1/8/22 12:50 PM, Brandon Nielsen wrote:
>>> I have a system with Intel AX201 not using 2 spatial streams in the RX (download) direction. TX (upload) functions as expected. I'm seeing similar behavior 
>>> with an AX200 system. I'm seeing the same behavior on 5.15.12 as I am with 5.16.0-rc8 so I didn't mark it as a regression. Windows works as expected.
>>>
>>> I have opened bug 215465[0] with some more detail.
>>>
>>> [0] - https://bugzilla.kernel.org/show_bug.cgi?id=215465
>>>
>>
>> We saw something similar with ax210, but only on 6E, in kernel 5.15.7+. On 5Ghz, it worked 2x2 as expected.
>> On a 5.15.0-rc something, it worked OK for us.
>>
>> We verified same firmware is used in both cases, but have not fully bisected the problem yet but we are
>> working on it.  In case you find the problem patch before us, please let me know!
>>
>> Thanks,
>> Ben
>>
> 
> I'm still seeing this as far back as 5.11.12, so I'm not convinced this is a regression. At least for the 5 GHz / 802.11ac case.
> 

Our engineer Chuck Rekierre bisected the problem we saw to a patch that came in as part of a stable patch.

Please see his revert patch: [PATCH] Revert "iwlwifi: mvm: disable RX-diversity in powersave"
posted yesterday, and if you get a chance to test this, please let us know the results.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

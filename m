Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5436348EF2F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 18:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiANRWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 12:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiANRW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 12:22:28 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21BC061574
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 09:22:28 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w9so13052422iol.13
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 09:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetfuse-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Fq31q8wmdY2OacnMW0Oj3DALk0FyHgPKkSL7n9KCYDs=;
        b=uy3t2eIujb2ZvBT0vmrelksEeNmjQ0+flSdAIyHvWRAFhFwp5lKXtu9mt/j8A6Hn1e
         hlfDoxiwtPGCOs1ngEFT6nUTAqSFM/QCnME5uRRC6rNSWESXoK+vyWb0f1mrVlhFxssj
         eJuWxwC8A5tdY8uQMp1e7tuuSytN8vH6R8Z0Ngxlv0P2AGN3mOjor40r295UzXw3gp1y
         MsQqgs9fVkbG88QlXNMCrWVuLdFBBGHQvj2ByIGmnr3exT8LlfME1QnP6ayPGtDj15F0
         y3/kBZwTlcJPQHRymOnAFKjYyzwVHQemoX/PfKpmd3pHL5uM18ZpE9QfTaIWi4ye09+n
         upzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fq31q8wmdY2OacnMW0Oj3DALk0FyHgPKkSL7n9KCYDs=;
        b=hK1Y4qSoRkmb6wFlssdhktmVsmQq2+4HqdqP9KLelIfw4QNlPzST2nzQBSVEpFpzn/
         VbUsQ+O+0PEJMqdqgOYsA1zXjVyp1lLMr0lJ79ICx8njN2VsN+vfKJ+cXP1iuGhvDQpN
         aWNXZyzUxx6LgBTgPG86mBMbWg4kinQ9ZyqYlAKV3Z+ANv727Hm2CvVc3Tc/r8rl3Fu1
         la8lLKSozpmQlAOG9mQsyRqspEQcGU4h9SKtYAj3oRxKVjbCud1AcVCev0XOPe8PgwhX
         cdzXKSCkNAKgCBIbgesktJA2Xrdy1pEcyprlFGhe7EABEdR3vb1zRRy+45F7erO9arhZ
         1uOw==
X-Gm-Message-State: AOAM5301tqZQUF4QevmH78AmN/dk08S4l4I2AUe6HH0j91Ob9oxFWYr9
        rRpq+/IDFOhDxSdLyAfIRkBRO5qpJTYB+g==
X-Google-Smtp-Source: ABdhPJwRGTZ/GRNfLvaeKXhhC+LIUyaQHfdWbHalG0Hh+1HCXWxugYERMwsCAZ43zqsp6XxEj9oKWw==
X-Received: by 2002:a05:6602:13c9:: with SMTP id o9mr4914872iov.171.1642180947784;
        Fri, 14 Jan 2022 09:22:27 -0800 (PST)
Received: from [192.168.1.15] (174-082-179-210.res.spectrum.com. [174.82.179.210])
        by smtp.gmail.com with ESMTPSA id a16sm1634956ilf.79.2022.01.14.09.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 09:22:27 -0800 (PST)
Message-ID: <dab1abfd-572f-3b4d-4abb-499f61fc91ee@jetfuse.net>
Date:   Fri, 14 Jan 2022 11:22:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: iwlwifi: AX201 not using 2 receive streams
Content-Language: en-US
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
References: <3cb11500-6828-6ded-bebc-cdb6e1f97bc0@jetfuse.net>
 <521b0dba-5866-ff34-da5a-479bc95cc9d9@candelatech.com>
 <60724ae6-e8e2-183d-575a-0186e45c3fae@jetfuse.net>
 <679864d0-25da-b3c7-b1da-c77deb52fd3a@candelatech.com>
From:   Brandon Nielsen <nielsenb@jetfuse.net>
In-Reply-To: <679864d0-25da-b3c7-b1da-c77deb52fd3a@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/13/22 11:12 AM, Ben Greear wrote:
> On 1/11/22 11:46 AM, Brandon Nielsen wrote:
>> On 1/8/22 3:22 PM, Ben Greear wrote:
>>> On 1/8/22 12:50 PM, Brandon Nielsen wrote:
>>>> I have a system with Intel AX201 not using 2 spatial streams in the 
>>>> RX (download) direction. TX (upload) functions as expected. I'm 
>>>> seeing similar behavior with an AX200 system. I'm seeing the same 
>>>> behavior on 5.15.12 as I am with 5.16.0-rc8 so I didn't mark it as a 
>>>> regression. Windows works as expected.
>>>>
>>>> I have opened bug 215465[0] with some more detail.
>>>>
>>>> [0] - https://bugzilla.kernel.org/show_bug.cgi?id=215465
>>>>
>>>
>>> We saw something similar with ax210, but only on 6E, in kernel 
>>> 5.15.7+. On 5Ghz, it worked 2x2 as expected.
>>> On a 5.15.0-rc something, it worked OK for us.
>>>
>>> We verified same firmware is used in both cases, but have not fully 
>>> bisected the problem yet but we are
>>> working on it.  In case you find the problem patch before us, please 
>>> let me know!
>>>
>>> Thanks,
>>> Ben
>>>
>>
>> I'm still seeing this as far back as 5.11.12, so I'm not convinced 
>> this is a regression. At least for the 5 GHz / 802.11ac case.
>>
> 
> Our engineer Chuck Rekierre bisected the problem we saw to a patch that 
> came in as part of a stable patch.
> 
> Please see his revert patch: [PATCH] Revert "iwlwifi: mvm: disable 
> RX-diversity in powersave"
> posted yesterday, and if you get a chance to test this, please let us 
> know the results.
> 
> Thanks,
> Ben
> 

Just tried it on one of the AX200 systems exhibiting the issue. No 
change. Rock solid MCS 9, but no engagement of the second RX stream.

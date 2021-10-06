Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02312424697
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 21:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhJFTUK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 15:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhJFTUK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 15:20:10 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC865C061746
        for <linux-wireless@vger.kernel.org>; Wed,  6 Oct 2021 12:18:17 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HPkkZ2XR6zQkBf;
        Wed,  6 Oct 2021 21:18:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1633547892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JR3sxSadwbqy6GXWUkD+q3LL05/UAfpJRSr0hVWMI8=;
        b=RJ1JAPnVOqmW60n2EQna5LJ50JGMl7A/KnTSmxOr9Z3RL/3csUBybi5WnFrl/K2rwLUokK
        yv2OCs+JuTmWU6i4bDW5jDIM4/Tg81cQ0Yl8EAmjlcIONTC2wcrWBZmhsce7ERFIw175n3
        MTDHOHbV8zP84rxtDQ5BYkhe+hyZlW3fDK47l8w6GkuTfo2iddigYulcosLMCHKHWE13MM
        NidZ39iVIDdlUfhrKJfFCiQU4PUivI0nhQRk5ucGmpO+jVwbAHInpX168YeaVv218h+15h
        Rzg6jhc74yxcUHklOENSP1ez1ScC/ZW7Rc9UjXVfxd6KguOu0kr9WnHbXUls3Q==
Message-ID: <a4cb97fc-de32-4d15-47a5-a7ad26bd32ab@gorani.run>
Date:   Thu, 7 Oct 2021 04:18:01 +0900
MIME-Version: 1.0
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for South Korea
 (KR)
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20210929172728.7512-1-mans0n@gorani.run>
 <YV2tukujds7PodAf@ubuntu-x1>
From:   Sungbo Eo <mans0n@gorani.run>
In-Reply-To: <YV2tukujds7PodAf@ubuntu-x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EA7E4188F
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-06 23:07, Seth Forshee wrote:
> On Thu, Sep 30, 2021 at 02:27:28AM +0900, Sungbo Eo wrote:
>> This patch is based on MSIT Public Notification 2020-113 ("Unlicensed Radio
>> Equipment Established Without Notice"), officially announced on 2021-01-06.
>>
>> Extend the last 5 GHz frequency range to 5850 MHz.
>>
>> WiFi 6E is now allowed with the following restrictions:
>> * Indoor: the full 1.2 GHz range, up to 160 MHz bandwidth and 250mW EIRP
>> * Outdoor: the lower 500 MHz range, up to 160 MHz bandwidth and 25mW EIRP
>> Here only the former entry is added.
>>
>> And also update the regulatory source links.
>>
>> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
>> ---
>> I have two questions.
>>
>> The regulation has one more restriction:
>>    The TX power should not exceed 2.5 mW/MHz
>>    when the frequency range includes the whole or a part of 5230-5250 MHz
>>    and the bandwidth is equal to or less than 40 MHz.
>> That leads to the followings:
>>    5230-5250 @ 20 -> 17 dBm
>>    5210-5250 @ 40 -> 20 dBm
>>    5170-5250 @ 80 -> 23 dBm
>> Is it possible to add this rule without lowering the TX power for 80 MHz bandwidth?
> 
> I've tried to look at the documents, but much of the information appears
> to be in images where machine translation doesn't work, and I haven't
> been able to find English versions.

Oops, sorry. I should have prepared it in more convertible format.
There's no English version of it, but at least I could find a HWP 
document file [1] that contains regular tables instead of images. (The 
URL is from the "attached files" tab in the source link.)

You can open it with a dedicated viewer [2] or an online viewer [3]. But 
those free viewers do not offer conversion to DOC or HTML. (It seems the 
dedicated one has "print to PDF" feature, though.)

I also tried an online convert tool but it failed due to the long 
processing time... I can send you converted versions myself if you prefer.

[1] https://www.law.go.kr/LSW//flDownload.do?flSeq=93728653
[2] https://www.hancom.com/cs_center/csDownload.do
[3] https://hwp.polarisoffice.com/

> 
> Taking the above at face value, I actually get slightly lower EIRP
> values for a PSD of 2.5 mW/MHz (EIRP = PSD + 10 * log(bandwidth)): 16
> dBm for 20 MHz and 19 dBm for 40 MHz.

I thought log(2.5) equals 0.4? We also have 2.5 mW/MHz * 40 MHz = 100 mW.

> We don't currently have any way to
> express PSD limits in the database nor a way to express different power
> limits for different bandwidths, so it's not possible to comply with the
> PSD limits for 20/40 MHz without also lowering the EIRP for 80 MHz.

Too bad. :( I'll prepare v2 soon.

> 
>> And do we need AUTO-BW for 6E channels? I thought it is for merging adjacent frequency ranges.
> 
> That is correct. Since there are no adjacent rules, AUTO-BW doesn't make
> sense.

Okay, thanks!

Regards,
Sungbo

> 
> Thanks,
> Seth
> 

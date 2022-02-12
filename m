Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C1E4B36BE
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 18:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiBLRFG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 12:05:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiBLRFF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 12:05:05 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF540240A4
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 09:05:00 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4JwxgC6SlSz9sQv;
        Sat, 12 Feb 2022 18:04:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1644685493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anMkyDU83H0cP6q78rzpCnNAbKIGFvp3ArJhC6EayYE=;
        b=lSCO+L2+melbUcW8Wc7jKkGtyyCpBOUyXiVG2PQbzVxJcw5jNWU0+mpTH1GiczdNdTiMER
        21aROD10pUijkwkp3wRYqvYD9+f+5OalivoGxg7gNYeSwQ5RlBPeA/xX1gc0FexS6pAWFL
        kf2YBeaP/OKNqYVzLZ2f9thRdw/yIBvB/jdMoE1pCZWdbsr/bANKVRNzsNKOgl/tF/JMsV
        8GaRjalO5+XcwhUNKsFZAVO6/P62dv5z3XkexSwQhTD5aw/50Pgh+zltbWfIkqpnPE7+Kc
        o94/M+jKVJ9e23sHOaALCtJbKQEVIriiSlTl5yzKwL1Cs7iNHnfq8FqpgPIgLQ==
Message-ID: <6b4d9cbc-6f73-0a9f-6198-37ded06c7d32@gorani.run>
Date:   Sun, 13 Feb 2022 02:04:42 +0900
MIME-Version: 1.0
Subject: Re: [PATCH v4] wireless-regdb: Update regulatory rules for South
 Korea (KR)
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20211212152050.25962-1-mans0n@gorani.run>
 <20220130124907.39224-1-mans0n@gorani.run> <Ygff0yenjQMS64BP@ubuntu-x1>
From:   Sungbo Eo <mans0n@gorani.run>
In-Reply-To: <Ygff0yenjQMS64BP@ubuntu-x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-02-13 01:26, Seth Forshee wrote:
> On Sun, Jan 30, 2022 at 09:49:07PM +0900, Sungbo Eo wrote:
>> This patch is based on MSIT Public Notification 2021-86 ("Unlicensed Radio
>> Equipment Established Without Notice"), officially announced on 2021-11-29.
>>
>> The PSD must not exceed 2.5 mW/MHz if the frequency range includes all or
>> part of 5230-5250 MHz and the bandwidth is equal to or less than 40 MHz.
>> This leads to the following:
>> * 5230-5250 @ 20 -> 17 dBm
>> * 5210-5250 @ 40 -> 20 dBm
>> Here the power limit for >20 MHz bandwidth is also lowered to 17 dBm, as
>> it's not possible to set different power limits for different bandwidths
>> at the moment.
>>
>> Extend the last 5 GHz frequency range to 5850 MHz.
>>
>> Wi-Fi 6E is now allowed with the following restrictions:
>> * Indoor: the full 1.2 GHz range, up to 160 MHz bandwidth and 2 dBm/MHz PSD
>> * Outdoor: the lower 500 MHz range, up to 160 MHz bandwidth and 25 mW EIRP
>> Here only the former entry is added.
>>
>> And also update the regulatory source links.
>>
>> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
>> ---
>> v4:
>> * merge 5210-5230 MHz band rule
>> * revert back to "indoor only" 6E rule as its power limit is higher
>>
>> v3:
>> * update regulatory source to newer revision
>> * replace "indoor only" 6E rule with "both indoor and outdoor" rule
>>    as "indoor only" rule limits PSD instead of EIRP
>>
>> v2:
>> * split 5150-5250 MHz band rule to accommodate the PSD limit
>> * remove AUTO-BW flag from 6 GHz band rule
>> ---
>>   db.txt | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/db.txt b/db.txt
>> index b898799..9b02a2c 100644
>> --- a/db.txt
>> +++ b/db.txt
>> @@ -862,15 +862,21 @@ country KP: DFS-JP
>>   	(5490 - 5630 @ 20), (30), DFS
>>   	(5735 - 5815 @ 20), (30)
>>   
>> +# Source:
>> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000205195
>> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000205187
>> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000206568
>>   country KR: DFS-JP
>> -	# ref: https://www.rra.go.kr
>>   	(2400 - 2483.5 @ 40), (23)
>> -	(5150 - 5250 @ 80), (23), AUTO-BW
>> +	(5150 - 5230 @ 40), (23), AUTO-BW
>> +	# max. PSD 2.5 mW/MHz in 5230-5250 MHz frequency range
>> +	(5230 - 5250 @ 20), (17), AUTO-BW
>>   	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
>>   	(5470 - 5725 @ 160), (20), DFS
>> -	(5725 - 5835 @ 80), (23)
>> -	# 60 GHz band channels 1-4,
>> -	# ref: http://www.law.go.kr/%ED%96%89%EC%A0%95%EA%B7%9C%EC%B9%99/%EB%AC%B4%EC%84%A0%EC%84%A4%EB%B9%84%EA%B7%9C%EC%B9%99
>> +	(5725 - 5850 @ 80), (23)
>> +	# 6 GHz band
>> +	(5925 - 7125 @ 160), (15), NO-OUTDOOR
> 
> I'm curious about this power limit. In v1/v2 it was 24 dBm, then in v3
> you lowered it for indoor/outdoor. Now you've chaned it back to indoor
> only, but the limit is 15 dBm rather than the 24 you had in v1/v2. Why
> the change?

24 dBm in v1/v2 was from max EIRP for 160 MHz, but I realized I should 
use PSD instead of EIRP, and I got 2 dBm/MHz * 20 MHz = 15 dBm (to fit 
the smallest bandwidth).

Regards,
Sungbo

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D955440017
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 18:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhJ2QOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Oct 2021 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ2QOw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Oct 2021 12:14:52 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7400CC061570
        for <linux-wireless@vger.kernel.org>; Fri, 29 Oct 2021 09:12:23 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HgnWR6g4HzQk3D;
        Fri, 29 Oct 2021 18:12:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gorani.run; s=MBO0001;
        t=1635523937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrTr7iAE5y/6CxbfZPHFyuf25ZCrwzbSs0K6vtW9jw8=;
        b=dmeoeU4/baC+9bsxZHwJ29RHJzwHK2cUhrMYQQ7q8PoINZcOR8fv1OHDxebn8mJENgo9AO
        jY3Nh/UVA1EqwtBdvqmaXPIxNfBpulgMBos/IJe2RaiZifZWHCMZiTGrpKvvdNpBsdSZp+
        yCp3KjpaKKg3rv9UiDatAojmDTlxVt49nnG7UJnrBc12C9Q08b7Rtf1+aI1pK6cEY2P/mc
        zS4R4Xz0EWZ1gasdv3gAklKSXmOmPllN9wqzcAZtQHxjhmFD4Y2CMZYQ7TMYzVGwLypX6L
        ms1rS2/DbYBvc2qDt5+P0ESR/tG5OjMbyPP6r1CbvMubfJUNIVjRNkYVpVGFSQ==
Message-ID: <4f05b6b1-084d-9046-4c63-6975c25d7615@gorani.run>
Date:   Sat, 30 Oct 2021 01:12:08 +0900
MIME-Version: 1.0
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory rules for South
 Korea (KR)
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20210929172728.7512-1-mans0n@gorani.run>
 <20211024113821.51538-1-mans0n@gorani.run> <YXmVLUzVEgrAMLwL@ubuntu-x1>
From:   Sungbo Eo <mans0n@gorani.run>
In-Reply-To: <YXmVLUzVEgrAMLwL@ubuntu-x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E92317FC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-28 03:06, Seth Forshee wrote:
> On Sun, Oct 24, 2021 at 08:38:21PM +0900, Sungbo Eo wrote:
>> This patch is based on MSIT Public Notification 2020-113 ("Unlicensed Radio
>> Equipment Established Without Notice"), officially announced on 2021-01-06.
>>
>> The PSD must not exceed 2.5 mW/MHz if the frequency range includes all or
>> part of 5230-5250 MHz and the bandwidth is equal to or less than 40 MHz.
>> This leads to the following:
>> * 5230-5250 @ 20 -> 17 dBm
>> * 5210-5250 @ 40 -> 20 dBm
>> Here the power limits for 80/160 MHz bandwidth are also lowered to 17 dBm,
>> as it's not possible to set different power limits for different bandwidths
>> at the moment.
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
>> v2:
>> * split 5150-5250 MHz band rule to accommodate the PSD limit
>> * remove AUTO-BW flag from 6 GHz band rule
>> ---
>>   db.txt | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/db.txt b/db.txt
>> index 6e8dbef..387ac93 100644
>> --- a/db.txt
>> +++ b/db.txt
>> @@ -862,15 +862,22 @@ country KP: DFS-JP
>>   	(5490 - 5630 @ 20), (30), DFS
>>   	(5735 - 5815 @ 20), (30)
>>   
>> +# Source:
>> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196972
>> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196973
>> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196974
>>   country KR: DFS-JP
>> -	# ref: https://www.rra.go.kr
>>   	(2400 - 2483.5 @ 40), (23)
>> -	(5150 - 5250 @ 80), (23), AUTO-BW
>> +	(5150 - 5210 @ 40), (23), AUTO-BW
>> +	# max. PSD 2.5 mW/MHz in 5230-5250 MHz frequency range
>> +	(5210 - 5230 @ 20), (20), AUTO-BW
>> +	(5230 - 5250 @ 20), (17), AUTO-BW
> 
> Even with 5210-5230 split out like this, 5210-5250 @ 40 still gets
> limited to 17 dBm by the 5230-5250 rule. So why do we need to split out
> 5210-5230 separate from 5150-5210?

I did some tests with regdb and I found out that the rule to be applied 
depends on the main 20 MHz channel. With the rules above, if I select 
channel 48 (5230-5250) and enable VHT40, then the TX power is set to 17 
dBm. OTOH if I select channel 44 (5210–5230) and enable VHT40, then the 
TX power is set to 20 dBm. I'm not sure whether my result is really 
correct, though.

Regards,
Sungbo

> 
> Thanks,
> Seth
> 
>>   	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
>>   	(5470 - 5725 @ 160), (20), DFS
>> -	(5725 - 5835 @ 80), (23)
>> -	# 60 GHz band channels 1-4,
>> -	# ref: http://www.law.go.kr/%ED%96%89%EC%A0%95%EA%B7%9C%EC%B9%99/%EB%AC%B4%EC%84%A0%EC%84%A4%EB%B9%84%EA%B7%9C%EC%B9%99
>> +	(5725 - 5850 @ 80), (23)
>> +	# 6 GHz band
>> +	(5925 - 7125 @ 160), (24), NO-OUTDOOR
>> +	# 60 GHz band channels 1-4
>>   	(57000 - 66000 @ 2160), (43)
>>   
>>   country KW: DFS-ETSI
>> -- 
>> 2.33.1
>>

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA4D6DE3F9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDKSew (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDKSev (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 14:34:51 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0338448D
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 11:34:50 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C6F76340080;
        Tue, 11 Apr 2023 18:34:46 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 13EEA13C2B0;
        Tue, 11 Apr 2023 11:34:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 13EEA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1681238086;
        bh=bh6X+D5qN3WwKTXSd6v2q1K2nqphkUlLtNfS2J4nezM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JUaGMz4yI21vYYloQFXYDTf3WIU71bPciiRqtxU9chjYkRlWPZ6vYA5wTwmUlsx00
         4dJ6l0+mf5EBLDwmOizikmLKbbD4g2UwLUxrThWfJVw5EJ1Q1u5MpCjHjYYoJEC+8K
         PgSGDI/1q9sMYtprergu8y0NiHaBv44NZ6eupyO8=
Message-ID: <3b69f7f8-ff7f-aad3-e344-db4e69b85331@candelatech.com>
Date:   Tue, 11 Apr 2023 11:34:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: ax200 reliable crash in 100Mbps bi-directional traffic test.
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     amol.jawale@candelatech.com,
        Gregory Greenman <gregory.greenman@intel.com>
References: <0ec935a0-175c-38ae-cf3c-c001989a3334@candelatech.com>
 <14dacce8ccf2f6b69fbeb49b92f864de9bdd216d.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <14dacce8ccf2f6b69fbeb49b92f864de9bdd216d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1681238087-jAndV8gAY5SY
X-MDID-O: us5;at1;1681238087;jAndV8gAY5SY;<greearb@candelatech.com>;21a4e426aab50b16d8e6565b1650ef6d
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/11/23 11:00, Johannes Berg wrote:
> On Tue, 2023-04-11 at 10:09 -0700, Ben Greear wrote:
>> Hello,
>>
>> Our test team reports that they get reliable firmware crashes on ax200 radios against multiple
>> APs when running 100Mbps UL + DL traffic (100Mbps in both directions).
>>
>> This happens on 5.19-ish kernels as well as 6.2.9+.
>> ax210 radios in same setup are much more stable.
>>
>> Please let us know if you would like additional debug information, including binary
>> crash dump files from the radio....
>>
>> [19241.588542] sta0001: Limiting TX power to 27 (30 - 3) dBm as advertised by 28:80:88:f3:b2:00
>> 4[19245.998099] iwlwifi 0000:12:00.0: Microcode SW error detected. Restarting 0x0.
>> 5[19246.004160] iwlwifi 0000:12:00.0: Start IWL Error Log Dump:
>> 6[19246.008457] iwlwifi 0000:12:00.0: Transport status: 0x0000004B, valid: 6
>> 7[19246.013867] iwlwifi 0000:12:00.0: Loaded firmware version: 72.daa05125.0 cc-a0-72.ucode
>> 8[19246.020573] iwlwifi 0000:12:00.0: 0x000022CE | ADVANCED_SYSASSERT
>>
> 
> Pretty sure this means that the RX was faster than the CPU was
> processing, but why would that happen at 100 Mbps?

The system should not be overly stressed in this case, and the hardware in general can run
at multi-gig speeds.  But, the CPU could be slowed down periodically for some other reason,
and possibly there were several other radios in the system.  We'll provide some better details
on the hardware setup.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



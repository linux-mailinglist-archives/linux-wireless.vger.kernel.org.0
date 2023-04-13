Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3C6E141B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDMSZz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjDMSZu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:25:50 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A9729B
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:25:25 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CC728400011;
        Thu, 13 Apr 2023 18:25:18 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 066EA13C2B0;
        Thu, 13 Apr 2023 11:25:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 066EA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1681410318;
        bh=rIGlYf7C6Hgo3/mAnbuUZodrQbs02FsiOB0TRcndRpY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=SEyoLJHPWCc372pq9iVh+M59dHWMydtSuv686fHEC3C5wyF0mExTYAZ1UpbS+2Q6i
         FGPk7l+8ZIwA+6dW5SMrQm/WiDtbYnp8nYsx9R/sdTxdDB+U79mMA5zyhXxONCVDhF
         fGXTNdg0sqEXmYbiET7lQlwWTuUkSXyqPFp9SGW0=
Message-ID: <ef8e2f76-b720-7cc4-4e0a-8e43836af8f6@candelatech.com>
Date:   Thu, 13 Apr 2023 11:25:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: ax200 reliable crash in 100Mbps bi-directional traffic test.
Content-Language: en-US
From:   Ben Greear <greearb@candelatech.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     amol.jawale@candelatech.com,
        Gregory Greenman <gregory.greenman@intel.com>
References: <0ec935a0-175c-38ae-cf3c-c001989a3334@candelatech.com>
 <14dacce8ccf2f6b69fbeb49b92f864de9bdd216d.camel@sipsolutions.net>
 <3b69f7f8-ff7f-aad3-e344-db4e69b85331@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <3b69f7f8-ff7f-aad3-e344-db4e69b85331@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1681410319-M9UoeqaojZ7u
X-MDID-O: us5;ut7;1681410319;M9UoeqaojZ7u;<greearb@candelatech.com>;21a4e426aab50b16d8e6565b1650ef6d
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/11/23 11:34, Ben Greear wrote:
> On 4/11/23 11:00, Johannes Berg wrote:
>> On Tue, 2023-04-11 at 10:09 -0700, Ben Greear wrote:
>>> Hello,
>>>
>>> Our test team reports that they get reliable firmware crashes on ax200 radios against multiple
>>> APs when running 100Mbps UL + DL traffic (100Mbps in both directions).
>>>
>>> This happens on 5.19-ish kernels as well as 6.2.9+.
>>> ax210 radios in same setup are much more stable.
>>>
>>> Please let us know if you would like additional debug information, including binary
>>> crash dump files from the radio....
>>>
>>> [19241.588542] sta0001: Limiting TX power to 27 (30 - 3) dBm as advertised by 28:80:88:f3:b2:00
>>> 4[19245.998099] iwlwifi 0000:12:00.0: Microcode SW error detected. Restarting 0x0.
>>> 5[19246.004160] iwlwifi 0000:12:00.0: Start IWL Error Log Dump:
>>> 6[19246.008457] iwlwifi 0000:12:00.0: Transport status: 0x0000004B, valid: 6
>>> 7[19246.013867] iwlwifi 0000:12:00.0: Loaded firmware version: 72.daa05125.0 cc-a0-72.ucode
>>> 8[19246.020573] iwlwifi 0000:12:00.0: 0x000022CE | ADVANCED_SYSASSERT
>>>
>>
>> Pretty sure this means that the RX was faster than the CPU was
>> processing, but why would that happen at 100 Mbps?
> 
> The system should not be overly stressed in this case, and the hardware in general can run
> at multi-gig speeds.  But, the CPU could be slowed down periodically for some other reason,
> and possibly there were several other radios in the system.  We'll provide some better details
> on the hardware setup.

Our tester reports that the system has one ath10k wave-1 card, one ath9k card, and 6 ax200 radios,
all installed in 4-slot pcie -> mini-pcie adapter cards (and for ax200, it has additional mpcie -> m.2
adapter card).  Typically we do not have issues with this kind of setup.

In the crashing test case, he can see the ax200 crash when all other radios are idle and a single
ax200 card is active with a STA vdev on it.

Please let me know if there is some other debugging we can do to assist.

Thanks,
Ben



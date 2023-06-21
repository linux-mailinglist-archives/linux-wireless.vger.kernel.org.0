Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FD6738884
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 17:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjFUPL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 11:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjFUPLh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 11:11:37 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C8159C7
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 08:07:05 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3808B5C43F2
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 14:48:51 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8D1D024005D;
        Wed, 21 Jun 2023 14:48:39 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7A7BE13C2B0;
        Wed, 21 Jun 2023 07:48:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7A7BE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1687358918;
        bh=SzAlpnHZecZa3N2uhe/a8AbUZuAh1g1+ys6diEISfn8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CsJD1QcLHhgGEG36ngd3J6EWh/uXOtISwsMlwStvFXu9LLSS4Pm+XSI2qdcb90H9P
         X4aIZSxKFLLGnDYJU0JbYEVmKAidKV7oslMURH1gi7B9uTdjGlA1hNZmeqWLDWQUHS
         um2v2brkFQOOpS2fnVguimQ0Kmk/vxI9YDuaqGaw=
Subject: Re: [PATCH 10/19] wifi: iwlwifi: limit EHT capabilities based on PCIe
 link speed
To:     Johannes Berg <johannes@sipsolutions.net>,
        gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org
References: <20230620100405.45117-1-gregory.greenman@intel.com>
 <20230620125813.b77a1574a0a7.Id4120c161fb7df6dedc70d5f3e3829e9117b8cb1@changeid>
 <d220c5b6-7c8f-19cd-12d0-ceb484e29e48@candelatech.com>
 <53612acba151d031f636626db20c1c60db09fdd0.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <9f4c589a-2160-cedb-d79a-1f57ea5244da@candelatech.com>
Date:   Wed, 21 Jun 2023 07:48:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <53612acba151d031f636626db20c1c60db09fdd0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1687358920-6ZfSgWMvdibv
X-MDID-O: us5;at1;1687358920;6ZfSgWMvdibv;<greearb@candelatech.com>;21a4e426aab50b16d8e6565b1650ef6d
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/21/23 4:57 AM, Johannes Berg wrote:
> On Tue, 2023-06-20 at 06:19 -0700, Ben Greear wrote:
>> On 6/20/23 3:03 AM, gregory.greenman@intel.com wrote:
>>> From: Johannes Berg <johannes.berg@intel.com>
>>>
>>> If a discrete NIC is connected to a PCIe link hat isn't at least
>>> Gen3 (8.0 GT/s), then we cannot sustain 320 MHz traffic, so remove
>>> that from EHT capabilities in that case.
>>>
>>> While at it, also move setting 320 MHz beamformee to the right
>>> place in the code so it's not set while not supporting 320 MHz.
>>
>> Is there not an advantage to allowing 320Mhz for longer distance connections
>> where signal is relatively weak, so over-all tput would easily fit in lesser
>> pcie bus?  Especially on 6E band where the US regdom allows more over-all power
>> when using wider bandwidths?
>>
> 
> I actually don't know. This surely isn't ideal, but it's the only way to
> really force the AP to not send too much than the NIC can pass out, and
> it gets unhappy if it can't.

So this is to work around hardware/firmware bug in NIC?  If so, that should
be mentioned.

I have heard in the past that higher bandwidth works better than higher NSS
in a lot of cases, so if HW/FW can be made to deal with floods in unlikely
case that the RF is perfect enough to saturate the PCI bus, then I think you
should allow 320Mhz even on slower PCI bus configurations.

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB325E068
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Sep 2020 18:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIDQ5g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Sep 2020 12:57:36 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:60562 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgIDQ5f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Sep 2020 12:57:35 -0400
Received: from [192.168.254.6] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 92F9013C2B0;
        Fri,  4 Sep 2020 09:57:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 92F9013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1599238653;
        bh=SyhC3/UZAlngc5dpNJUq1jy/e6JfB2N1qquj3+kbosw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HycsRQs0q0OwFgtYWA1MHxeieDwYf2Y1NfdYYEuPcm9JZQP5+RADtxaje9ybtH2SR
         AjGbf03P0u9hEDxU2o9mWleFwNgmyIejp3QnsW/0EocHfEeosh+9I7LKeQHaU0JeGv
         4cPDI0XJCovrzrE2VUJmVcWcZy9BShWkWbHNxd28=
Subject: Re: [PATCH] ath11k: Allow debugfs to work with 2+ radios installed.
To:     akolli@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
References: <20200903172359.29199-1-greearb@candelatech.com>
 <0101017459a1d409-4d95a8e1-d404-4fba-a25d-b2e3075947e0-000000@us-west-2.amazonses.com>
 <d450eb2d-5c2d-c432-2cd5-b3121c7d27d4@candelatech.com>
 <010101745a05a2fb-24c8bde9-c898-4d53-9416-b48a764f907b-000000@us-west-2.amazonses.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <b6e833c1-dc07-c29e-7111-b5c915fc6567@candelatech.com>
Date:   Fri, 4 Sep 2020 09:57:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <010101745a05a2fb-24c8bde9-c898-4d53-9416-b48a764f907b-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/4/20 9:49 AM, akolli@codeaurora.org wrote:
> On 2020-09-04 21:04, Ben Greear wrote:
>> On 9/4/20 8:00 AM, akolli@codeaurora.org wrote:
>>> On 2020-09-03 22:53, greearb@candelatech.com wrote:
>>>> From: Ben Greear <greearb@candelatech.com>
>>>>
>>>> The code is trying to create an ath11k directory on debugfs
>>>> root, but that fails when there is a second radio (and thus
>>>> second instance of the driver).
>>>>
>>>
>>> Hi Ben,
>>>
>>> IPQ8074 is soc and it does not need second debugfs entry, its on AHB.
>>> QCA6390 is a pci card and multiple debug entries are needed if multiple cards are available,
>>> I am planning to post a patch with bus specific abstraction function which creates single debugfs for soc based radios and multiple entries for PCI based 
>>> radios.
>>>
>>> AHB:
>>> debugfs/ath11k/IPQ8074/
>>>
>>> PCI
>>> debugfs/ath11k/QCA6390_0001:01:00.0/
>>> debugfs/ath11k/QCA6390_0000:01:00.0/
>>
>> I appreciate your feedback on this!
>>
>> Why not just stick with the way ath10k does, having the ath11k debugfs entry be
>> under the phy debugfs directory?
>>
>> Maybe there is a high-level design document for the ath11k driver somewhere that
>> explains how and why it is architected with the ath11k base object
>> holding multiple
>> phy objects?
>>
> 
> The initial ath11k driver was supporting IPQ8074, its an SOC and has 3-radios under wifi0,
> - few entries in debugfs are common for SOC,all these are under
>        debugfs/ath11k/IPQ8074/
>            "simulate_fw_crash"
>            "soc_dp_stats"

Ok, so one 8074 firmware instance is handling multiple radios, and if firmware crashes, then
it would take down every radio at once?

> - few entries are per radio, these are under
>        debugfs/ath11k/IPQ8074/mac0/
>              "ext_tx_stats"
>              "ext_rx_stats"
>              "pktlog_filter"
>        debugfs/ath11k/IPQ8074/mac1
>              "ext_tx_stats"
>              "ext_rx_stats"
>              "pktlog_filter"
>        debugfs/ath11k/IPQ8074/mac2
>              "ext_tx_stats"
>              "ext_rx_stats"
>              "pktlog_filter"
> 
>> And, very curious to know if you are able to get multiple QCA6390 NICs
>> running on the
>> same system, I'm seeing all sort of problems including NICs not always
>> showing up in lspci
>> and such.
>>
> I am not aware of this, like to understand the output of, qrtr-lookup cmd

Based on my testing with debugs, whatever driver I pulled down from the ath tree had zero
chance of working due to immediate crash.  So, have you been able to test multiple
6390 radios yet?

How do I do this qrtr-lookup command?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

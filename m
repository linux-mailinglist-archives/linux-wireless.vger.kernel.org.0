Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F525E126
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Sep 2020 19:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgIDRpJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Sep 2020 13:45:09 -0400
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:32864
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727889AbgIDRpI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Sep 2020 13:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599241507;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=JNvCtTm12UpXi9qdc7a7XW5ziZdW3QpXVEadnjgAQLA=;
        b=M7zJxOm9HYae3S8pTa5HM4fDMd7eswm7F1D1M9PMT0U7giFCwMx/Ts4zd3WhTcmo
        pc0+HagdubdgwmmAofK7Y75sJnH1zVhhNObV0Cdi2ZYbf7c3Ey3It+LHSPeA5QpO3jl
        bPFu6zA7oGq+A9WEKn+6DkXgrEwD1vLclymk8b8Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599241507;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=JNvCtTm12UpXi9qdc7a7XW5ziZdW3QpXVEadnjgAQLA=;
        b=jzylNLxR+seYcxXxJU5zlsuczvXDuuD1ZUA54fhgHYrlVyxqRj6K8JnXDHF5xzE8
        ftePH4e8EoV9wmD50mp8DlVPJjusaDb4/KT5+j2PV4Sy1ORclmFCGL1ZP3utHjX/Xyx
        2/ue7EqXq9AEik5mUAdj7WeF4SWa4n2iP+mZbn5Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 4 Sep 2020 17:45:07 +0000
From:   akolli@codeaurora.org
To:     Ben Greear <greearb@candelatech.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH] ath11k: Allow debugfs to work with 2+ radios installed.
In-Reply-To: <b6e833c1-dc07-c29e-7111-b5c915fc6567@candelatech.com>
References: <20200903172359.29199-1-greearb@candelatech.com>
 <0101017459a1d409-4d95a8e1-d404-4fba-a25d-b2e3075947e0-000000@us-west-2.amazonses.com>
 <d450eb2d-5c2d-c432-2cd5-b3121c7d27d4@candelatech.com>
 <010101745a05a2fb-24c8bde9-c898-4d53-9416-b48a764f907b-000000@us-west-2.amazonses.com>
 <b6e833c1-dc07-c29e-7111-b5c915fc6567@candelatech.com>
Message-ID: <010101745a38d225-f5e691d5-e7b2-4a41-8769-e5cbf1fd3bd3-000000@us-west-2.amazonses.com>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.04-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-04 22:27, Ben Greear wrote:
> On 9/4/20 9:49 AM, akolli@codeaurora.org wrote:
>> On 2020-09-04 21:04, Ben Greear wrote:
>>> On 9/4/20 8:00 AM, akolli@codeaurora.org wrote:
>>>> On 2020-09-03 22:53, greearb@candelatech.com wrote:
>>>>> From: Ben Greear <greearb@candelatech.com>
>>>>> 
>>>>> The code is trying to create an ath11k directory on debugfs
>>>>> root, but that fails when there is a second radio (and thus
>>>>> second instance of the driver).
>>>>> 
>>>> 
>>>> Hi Ben,
>>>> 
>>>> IPQ8074 is soc and it does not need second debugfs entry, its on 
>>>> AHB.
>>>> QCA6390 is a pci card and multiple debug entries are needed if 
>>>> multiple cards are available,
>>>> I am planning to post a patch with bus specific abstraction function 
>>>> which creates single debugfs for soc based radios and multiple 
>>>> entries for PCI based radios.
>>>> 
>>>> AHB:
>>>> debugfs/ath11k/IPQ8074/
>>>> 
>>>> PCI
>>>> debugfs/ath11k/QCA6390_0001:01:00.0/
>>>> debugfs/ath11k/QCA6390_0000:01:00.0/
>>> 
>>> I appreciate your feedback on this!
>>> 
>>> Why not just stick with the way ath10k does, having the ath11k 
>>> debugfs entry be
>>> under the phy debugfs directory?
>>> 
>>> Maybe there is a high-level design document for the ath11k driver 
>>> somewhere that
>>> explains how and why it is architected with the ath11k base object
>>> holding multiple
>>> phy objects?
>>> 
>> 
>> The initial ath11k driver was supporting IPQ8074, its an SOC and has 
>> 3-radios under wifi0,
>> - few entries in debugfs are common for SOC,all these are under
>>        debugfs/ath11k/IPQ8074/
>>            "simulate_fw_crash"
>>            "soc_dp_stats"
> 
> Ok, so one 8074 firmware instance is handling multiple radios, and if
> firmware crashes, then
> it would take down every radio at once?
> 
>> - few entries are per radio, these are under
>>        debugfs/ath11k/IPQ8074/mac0/
>>              "ext_tx_stats"
>>              "ext_rx_stats"
>>              "pktlog_filter"
>>        debugfs/ath11k/IPQ8074/mac1
>>              "ext_tx_stats"
>>              "ext_rx_stats"
>>              "pktlog_filter"
>>        debugfs/ath11k/IPQ8074/mac2
>>              "ext_tx_stats"
>>              "ext_rx_stats"
>>              "pktlog_filter"
>> 
>>> And, very curious to know if you are able to get multiple QCA6390 
>>> NICs
>>> running on the
>>> same system, I'm seeing all sort of problems including NICs not 
>>> always
>>> showing up in lspci
>>> and such.
>>> 
>> I am not aware of this, like to understand the output of, qrtr-lookup 
>> cmd
> 
> Based on my testing with debugs, whatever driver I pulled down from
> the ath tree had zero
> chance of working due to immediate crash.  So, have you been able to
> test multiple
> 6390 radios yet?
> 
I am not working on 6390.

> How do I do this qrtr-lookup command?
> 
https://github.com/andersson/qrtr, this has the tools.

Also please share the dmesg | grep ath11k log with both radios.
I understand its crashing, please share the ath11k boot logs.

Thanks
Anil

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E63AB5E3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 16:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhFQO13 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhFQO1Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 10:27:25 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C592DC061574
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1QUkzX4Z1TwoqhkSc5yGTVJ26jjr0w0+Y4pJTOVmg9o=; b=tvPvHSwmxq16j4bJvqiwxsJTCE
        PKHHB/TNErty/AZqZH3jqp99P5ApqstdBUAu4xy49u/4whcJbbM5wJ68hKpv827pcEYsyh7F3f4xD
        AU91DLtKAz9iNVTr6qg9WZutuxQN36JniqrYFq6M9nwh+A0Kg1f8JXgqs2mLKNaYNBU0=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ltsxI-0000Cj-2O; Thu, 17 Jun 2021 16:25:16 +0200
Subject: Re: pull request: mt76 2021-06-10
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <7e509477-cb3d-9d18-7386-d989cbeeb178@nbd.name>
 <871r90k2y7.fsf@codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <be0c7e31-562a-fc18-5f77-925e3d6568b5@nbd.name>
Date:   Thu, 17 Jun 2021 16:25:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <871r90k2y7.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-06-17 15:58, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> Hi Kalle,
>>
>> here's my first pull request for 5.14
>>
>> - Felix
>>
>> The following changes since commit 080f9c10c773df39ccebe8dc414179d9179005a9:
>>
>>   ipw2x00: Minor documentation update (2021-06-03 12:33:55 +0300)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-06-10
>>
>> for you to fetch changes up to c3dfa83c3e625e111874295076557b7dddadda13:
>>
>>   mt76: mt7915: drop the use of repeater entries for station interfaces (2021-06-10 13:39:41 +0200)
>>
>> ----------------------------------------------------------------
>> mt76 patches for 5.14
>>
>> * mt7915 MSI support
>> * disable ASPM on mt7915
>> * mt7915 tx status reporting
>> * mt7921 decap offload
>> * driver fixes
>> * cleanups
>> * mt7921 runtime power management improvements
>> * testmode improvements/fixes
>>
>> ----------------------------------------------------------------
> 
> I updated wireless-drivers-next this morning to latest net-next and
> there are now few conflicts:
> 
> $ git pull https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-06-10
> From https://github.com/nbd168/wireless
>  * tag                         mt76-for-kvalo-2021-06-10 -> FETCH_HEAD
> Auto-merging drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> CONFLICT (content): Merge conflict in drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> Auto-merging drivers/net/wireless/mediatek/mt76/mt7921/main.c
> Auto-merging drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> Auto-merging drivers/net/wireless/mediatek/mt76/mt7921/init.c
> CONFLICT (content): Merge conflict in drivers/net/wireless/mediatek/mt76/mt7921/init.c
> Auto-merging drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
> Auto-merging drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> Auto-merging drivers/net/wireless/mediatek/mt76/mt7615/init.c
> Auto-merging drivers/net/wireless/mediatek/mt76/mac80211.c
> 
> I can fix those but having instructions how to solve them will help.
> 
> With GCC 11.1 I see a new warning:
> 
> drivers/net/wireless/mediatek/mt76/mt7915/init.c: In function 'mt7915_thermal_init':
> drivers/net/wireless/mediatek/mt76/mt7915/init.c:138:17: warning: ignoring return value of 'sysfs_create_link' declared with attribute 'warn_unused_result' [-Wunused-result]
>   138 |                 sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   139 |                                   "cooling_device");
>       |                                   ~~~~~~~~~~~~~~~~~
> 
> Also two problems with commit logs:
> 
> In commit
> 
>   a4777798a401 ("mt76: connac: fix WoW with disconnetion and bitmap pattern")
> 
> Fixes tag
> 
>   Fixes: ffa1bf97425 ("mt76: mt7921: introduce PM support")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
> 
> Commit
> 
>   34bd6f5f1e24 ("mt76: move mt76_rates in mt76 module")
> 
> is missing a Signed-off-by from its committer.
Sorry about that. I will rebase and send a new one.

- Felix

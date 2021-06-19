Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F983AD868
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 09:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhFSHa1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 03:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhFSHa1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 03:30:27 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A38C061574
        for <linux-wireless@vger.kernel.org>; Sat, 19 Jun 2021 00:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nxWkAGHkEOEzKaXi4jkRDCVL6EkRhryXKn567oEGzGo=; b=f22mMU9kG6wvY27gxYUSUgkVmp
        HufNfk+w7Oyv+L72vDGH5eqePN3yoTr0aQUDcm26Vc2PXxXXXMEMCGk79iU7+j6i9it4nqLhcZHZS
        TwuP0ld3qsH6og4cKVbtjEvs/9gXrRGlRy6yu9NFL0TR+meJATaOn1Gzkf5OvFm9HIBk=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1luVOo-0000hO-GG; Sat, 19 Jun 2021 09:28:14 +0200
Subject: Re: pull request: mt76 2021-06-18 v2
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <771ad327-c637-ddaa-494c-bde1832eefec@nbd.name>
 <87im2aic1j.fsf@codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <aa6b2a81-4e52-4a5f-4253-8a54470e5270@nbd.name>
Date:   Sat, 19 Jun 2021 09:28:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87im2aic1j.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-06-19 08:49, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> Hi Kalle,
>>
>> here's an updated version of my first pull request for 5.14
>>
>> - Felix
>>
>> The following changes since commit 0c33795231bff5df410bd405b569c66851e92d4b:
>>
>>   Merge tag 'wireless-drivers-next-2021-06-16' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-06-16 12:59:42 -0700)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-06-18
>>
>> for you to fetch changes up to a7818339958c7d7940a102ccf88cf73260074344:
>>
>>   mt76: mt7921: allow chip reset during device restart (2021-06-18 19:22:10 +0200)
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
>> * runtime PM improvements
>>
>> ----------------------------------------------------------------
> 
> Almost there :) But one commit is missing your s-o-b:
> 
> ----------------------------------------------------------------------
> Commit
> 
>   7c649aa4de81 ("mt76: move mt76_rates in mt76 module")
> 
> is missing a Signed-off-by from its committer.
Sorry about that, I did take care of this in my local tree, but
apparently accidentally got rid of it in another rebase.
Will send v3 right away.

> ----------------------------------------------------------------------
> 
> I think it's faster if you can test the commits yourself before sending
> the pull request. I'm using Stephen's scripts but I don't remember
> anymore where I got them. But Greg has his script available and I assume
> they test the same stuff:
> 
> https://github.com/gregkh/gregkh-linux/tree/master/work
I tried using those scripts, but they didn't work on my machine for some
reason and I didn't have time to investigate yet. I'll try to make some
time for it soon.

- Felix

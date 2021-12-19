Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CA747A08E
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 14:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhLSNFm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 08:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbhLSNFm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 08:05:42 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E37C061574
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 05:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6pLK9DY/FDsRx8ucQLh5LmSqg1dqzMG5s3vnpt18LEQ=; b=kBD5IE8dnWoVkVjLm/sKw99EyX
        0zwvKClEAReiVvjOM6K3lmf5YuHQrwrkIXLMpeyzehu1KzhP27q75p0VvKU671QWoi4CA3GR2RPcq
        RGqUi1qwgRpMBAvhvTt08pq+MlZ0zC9uih9DooINoJNrdH7RRMa3ntNaNTZuHQun3YMM=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1myvsh-0002Qw-QL; Sun, 19 Dec 2021 14:05:39 +0100
Message-ID: <5ecced88-a760-5468-6723-0ec03596f9b7@nbd.name>
Date:   Sun, 19 Dec 2021 14:05:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: pull request: mt76 2021-12-18
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <de61c750-8580-c453-4c33-c1b71d818a71@nbd.name>
 <87a6gwbvqb.fsf@codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <87a6gwbvqb.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-12-19 13:54, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> Hi Kalle,
>>
>> here's my updated pull request for 5.17
>>
>> - Felix
>>
>> The following changes since commit f75c1d55ecbadce027fd650d3ca79e357afae0d9:
>>
>>   Merge tag 'wireless-drivers-next-2021-12-17' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-12-17 07:30:07 -0800)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-12-18
>>
>> for you to fetch changes up to a2a218b674cdbab132be5ed99cc2af06c4ff8cb8:
>>
>>   mt76: mt7921s: fix cmd timeout in throughput test (2021-12-18 11:48:02 +0100)
>>
>> ----------------------------------------------------------------
>> mt76 patches for 5.17
>>
>> * decap offload fixes
>> * mt7915 fixes
>> * mt7921 fixes
>> * eeprom fixes
>> * powersave handling fixes
>> * SAR support
>> * code cleanups
>>
>> ----------------------------------------------------------------
> 
> This fails to build:
> 
> drivers/net/wireless/mediatek/mt76/debugfs.c: In function 'mt76_rx_queues_read':
> drivers/net/wireless/mediatek/mt76/debugfs.c:84:31: error: 'queued' undeclared (first use in this function)
>     84 |                            i, queued, q->head, q->tail);
>        |                               ^~~~~~
Oh, it seems that got broken by the commit that for some reason got 
picked up in net-next directly. I'll make an updated PR that fixes it.

- Felix

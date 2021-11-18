Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107AE45616F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 18:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhKRR3n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 12:29:43 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:39178 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231745AbhKRR3m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 12:29:42 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.202])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7440A2006C;
        Thu, 18 Nov 2021 17:26:40 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 498F480061;
        Thu, 18 Nov 2021 17:26:40 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 52A9813C2B0;
        Thu, 18 Nov 2021 09:26:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 52A9813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637256399;
        bh=WMkfpRQv9qLoBgJahFO3BysEGBUj9A3Gw/8eqFGxkaQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=noeSWg5FOVoTWWTaMUMtfFir8GTqNKpeeE25zcVsvoSvBBHqYajcVkBXo+yfrkufq
         GNfwmL4QOXzzRpdUdfgZO7x66Lkv1EP5FpVaifAJVE5r87MCVx3Jaku6sFW75rcJrD
         iKqw/34bEIIqKL6JyPWFHsd1L4bTqcAAUxlhZnfM=
Subject: Re: [PATCH 6/8] mt76: mt7915: report tx-retries
To:     Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org
References: <20211118164549.3863-1-greearb@candelatech.com>
 <20211118164549.3863-6-greearb@candelatech.com>
 <d058fd943d7522104beeee626f3295f13f6439b7.camel@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <95e53374-3819-15b1-3bd9-9adc8c5c9dcf@candelatech.com>
Date:   Thu, 18 Nov 2021 09:26:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d058fd943d7522104beeee626f3295f13f6439b7.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1637256400-5LSbKyHE2m7K
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/18/21 9:19 AM, Ryder Lee wrote:
> On Thu, 2021-11-18 at 08:45 -0800, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> mac80211 stack will only report tx-status for skb claiming to be
>> ampdu heads,
>> so lie a bit in mt7915 and set the flag so that mac80211 will record
>> status
>> for each skb.
>>
>> mt7915 appears to report retry status on an individual per-skb
>> manner,
>> so that method above seems to work.
>>
>> Re-constitute the txinfo status rate info so that the rix and flags
>> is also at least close to correct.  No direct way to report HE
>> rates that way, so mac80211 might could use some tweaking in
>> the ieee80211_tx_status_ext to take both info and status->rate
>> into account.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>

>> +			rate->flags |= IEEE80211_TX_RC_VHT_MCS;
>> +			rate->idx = (wcid->rate.nss << 4) | wcid-
>>> rate.mcs;
>> +		} else if (wcid->rate.flags & RATE_INFO_FLAGS_HE_MCS) {
>> +			rate->idx = (wcid->rate.nss << 4) | wcid-
>>> rate.mcs;
> 
> Can ieee80211_tx_rate tell HE rate apart now?
Upstream code cannot, but it has other ways of dealing with HE
rates, and this patch does not break that as far as I can tell.

Thanks,
Ben

> 
> Ryder
> 
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


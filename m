Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC25B3F1D9F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 18:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhHSQRo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 12:17:44 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:31363 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhHSQRn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 12:17:43 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.168])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 76B5A20064;
        Thu, 19 Aug 2021 16:17:05 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 381FB88008C;
        Thu, 19 Aug 2021 16:17:05 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0DFAB13C2B1;
        Thu, 19 Aug 2021 09:16:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0DFAB13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629389807;
        bh=jr/OkHoLYzIiEmet7FuWA0OVjnZBXgvyFrDX5Uc2L1k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Afbsjuu7yectojDbkSvN2GUczN+QG+i45soemof7EwSWezDeHh3dtTkv7SyMAt32+
         I0Lw/zwFBVyhHbIXZPylRUDMp43UJ8O43H0qW/ueiZWYvorYA8PL/8gdqJqU5kto5t
         3GPsp3DaMH0ZNhBf3SrQRWnCno+0dFmakDXznpKc=
Subject: Re: [PATCH v5 07/11] mt76: mt7915: add support for tx-overrides
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <20210804134505.3208-1-greearb@candelatech.com>
 <20210804134505.3208-7-greearb@candelatech.com>
 <875yw1bhgu.fsf@tynnyri.adurom.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <52135b51-1a5f-1ff9-5c81-cd970cb4b311@candelatech.com>
Date:   Thu, 19 Aug 2021 09:16:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <875yw1bhgu.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1629389826-4gy-CZzlGs88
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/19/21 8:08 AM, Kalle Valo wrote:
> greearb@candelatech.com writes:
> 
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Allow setting fix rate on transmit without using full testmode
>> logic.
> 
> Why?

I use it for testing purposes, so I can send specific frame encodings
to see if peer can receive it or not (receiver sensitivity testing).

Others may be interested in similar API to test that their system transmits
specific MCS frames at proper txpower or other regulatory-related stuff.

And to some degree, the underlying logic gives clever people a way to do driver-defined
per-skb rate-control instead of depending on the firmware.  I hacked similar thing
into my ath10k and at least one person attempted that as I recall.

> 
>> txpower, dynbw, retry count is not currently supported.
>> And, probably later need additional logic to not apply this
>> txo to non-data frames and to smaller frames, to allow
>> ARP and such to go through while also forcing test data frames
>> to arbitrary tx-rates (rates which very well may not be
>> received by peer.)
> 
> Please include an example how to use the debugfs file.

It is in the patch:

+	const char buf[] =
+		"This allows specify specif tx rate parameters for all DATA"
+		" frames on a vdev\n"
+		"To set a value, you specify the dev-name and key-value pairs:\n"
+		"tpc=10 sgi=1 mcs=x nss=x pream=x retries=x dynbw=0|1 bw=x enable=0|1\n"
+		"pream: 0=cck, 1=ofdm, 2=HT, 3=VHT, 4=HE_SU\n"
+		"cck-mcs: 0=1Mbps, 1=2Mbps, 3=5.5Mbps, 3=11Mbps\n"
+		"ofdm-mcs: 0=6Mbps, 1=9Mbps, 2=12Mbps, 3=18Mbps, 4=24Mbps, 5=36Mbps,"
+		" 6=48Mbps, 7=54Mbps\n"
+		"tpc is not implemented currently, bw is 0-3 for 20-160\n"
+		" For example, wlan0:\n"
+		"echo \"wlan0 tpc=255 sgi=1 mcs=0 nss=1 pream=3 retries=1 dynbw=0 bw=0"
+		" active=1\" > ...mt76/set_rate_override\n";

> 
> IIRC there was a similar rtw88 patch adding a debugfs to force setting
> the tx rate. So what's the consensus, are we going to allow each driver
> have their own custom interfaces setting tx rates? In my opinion this
> should go via a generic nl80211 command, but if people think having
> custom tx rate interfaces is ok I guess I need to reconsider.
> 
> As this patch needs more discussion, please separate it from rest of the
> series so that it can be applied separately.

Ok, will do.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


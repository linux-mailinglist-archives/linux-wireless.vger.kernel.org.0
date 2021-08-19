Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6FB3F1D7D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhHSQJ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 12:09:29 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:54170 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234038AbhHSQJ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 12:09:29 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.48.61])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B367F2A0073;
        Thu, 19 Aug 2021 16:08:51 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 77A3EC0082;
        Thu, 19 Aug 2021 16:08:51 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 07D3113C2B3;
        Thu, 19 Aug 2021 09:08:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 07D3113C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629389331;
        bh=hpLKnXE5QeqxEPLSjRLFnhjtBGlXw/02JU1GmMyaps8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iHv4yXtsO5XEb43br46YPGlz/3PipJuo5dfBpplwbFF8LG9evi5EmiOoBz7TtWQkf
         0YCwFu5FEOPCdWVIXMtHNUm02Dm9RpfvEYPhY9xyNBBQ6XcdoFWDY9nnRUOfAu+bk1
         jPi5g3BwxPkoA0YLenWpgWgdeTlUJ+CNYA4xIop8=
Subject: Re: [PATCH v5 05/11] mt76: mt7915: debugfs hook to enable TXS for
 NO_SKB pkt-ids
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <20210804134505.3208-1-greearb@candelatech.com>
 <20210804134505.3208-5-greearb@candelatech.com>
 <87mtpda079.fsf@tynnyri.adurom.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <093b94ea-b6db-aca8-26c4-6981e57e8ff4@candelatech.com>
Date:   Thu, 19 Aug 2021 09:08:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87mtpda079.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1629389332-4J614gciiyGM
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/19/21 9:06 AM, Kalle Valo wrote:
> greearb@candelatech.com writes:
> 
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This lets user turn on/off this feature.  Enabling gives better
>> tx-rate related stats, but will cause extra driver and (maybe)
>> firmware work.  Not sure if it actually affects performance or
>> not.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
> 
> This is grey area, debugfs is not really meant to be used for users
> enabling driver features.
> 

What method do you suggest?  Surely not trying to drive something down through
netlink for something this chipset specific?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


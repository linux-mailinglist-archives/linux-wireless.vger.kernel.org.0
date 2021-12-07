Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EC846BF64
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhLGPhA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 10:37:00 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:37790 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhLGPg7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 10:36:59 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.164])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 400802A0070;
        Tue,  7 Dec 2021 15:33:28 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 77ACBB0008C;
        Tue,  7 Dec 2021 15:33:27 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.71.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3DBB613C2B0;
        Tue,  7 Dec 2021 07:33:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3DBB613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1638891207;
        bh=YDQa2OJN7nV9hEolGlq1UYeF9tA7KtmMdZ/FpojLsso=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CYezbsUXYJ8FRrxakOwxE6mXVfrJCD6uAM+zX0IyVKa7VPs9W0yZ1vOpuzqrrQMgk
         uXxiFxxGtbKzI4kGjb8sO8EwycsnzcZfjC/wziH4ff2SsAMU3hrRr0BdMNmf6mk+QF
         WjkEc0FisZll4lEhGLjeOwAb5ZE1AcEbOZoTRBEM=
Subject: Re: [PATCH] mt76: mt7915: add mu-mimo and ofdma debugfs knobs
To:     meichia chiu <meichia.chiu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20211206141006.29632-1-MeiChia.Chiu@mediatek.com>
 <7158a937-57f3-2bd8-591e-124a18d2d8e8@candelatech.com>
 <72ca4f5fe3c351ec56dee4935b28c7b7f26188c2.camel@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <e4a8301c-53a1-9ca0-7e1d-fd235a22ccd6@candelatech.com>
Date:   Tue, 7 Dec 2021 07:33:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <72ca4f5fe3c351ec56dee4935b28c7b7f26188c2.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1638891208-clVzOPXvi6wc
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/6/21 11:25 PM, meichia chiu wrote:
> On Mon, 2021-12-06 at 08:43 -0800, Ben Greear wrote:
>> On 12/6/21 6:10 AM, MeiChia Chiu wrote:
>>> From: MeiChia Chiu <meichia.chiu@mediatek.com>
>>>
>>> Add mu-mimo and ofdma packet counters statistics.
>>
>> Hello,
>>
>> Are these stats clear-on-read in the firmware?  If so, then we need
>> to accumulate
>> them in the driver.
>>
>> Is there any significant downside to enabling the stats?  For
>> instance, a performance
>> degradation in the firmware/hardware?
>>
>> Thanks,
>> Ben
> 
> Hi Ben,
> 
> Yes, the current design is clear-on-read and its sole purpose is for
> debugging only. If you need statistics, this may have to be done in
> another way.

So we could poll these stats in the other logic that polls firmware stats and accumulate
them in the driver and display with debugfs and/or ethtool.  If you don't want
to do the accumulation, and lease add a comment to your patch about the
values being clear-on-read and someone else can add the accumulation logic
later.

> Yes, a performance degradation is expected since enabling this debug
> function would burden MCU with more calculation.

Have you done any testing to verify this?  If it is just bumping a few
counters, it may not matter.  But I don't know how the firmware is actually
implementing this, so maybe it is a lot more expensive than expected?

Thanks,
Ben

> 
> Thanks,
> Meichia
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

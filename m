Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79649BAFC
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jan 2022 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244355AbiAYSJN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 13:09:13 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:59302 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244334AbiAYSJI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 13:09:08 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.121])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0CE441C0063;
        Tue, 25 Jan 2022 18:09:04 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A83864C0096;
        Tue, 25 Jan 2022 18:09:01 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B057713C2B0;
        Tue, 25 Jan 2022 10:09:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B057713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1643134141;
        bh=otoWo9j8xyBa09sRi2gr02yQo5F4EfMnx4l/bFAHyXM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fZIoQfo2714iVzfBd+ymI0HlF9mYQ8k/IgndPA1vfUMHQ1w1bil5aFzsn4XuOF92g
         Zj4kZ0LEKJVlTtoYhgDfAEQIyzEKWKQqCVLFWWd9P02EMQ8ydu/c7Dr2MNfpKiKCZI
         aTjqhpOZu+fqmY/40S+08V4hu1BrJ76YLK6CBPxM=
Subject: Re: [PATCH] mt76: mt7921e: fix possible probe failure after reboot
To:     Mike Lothian <mike@fireburn.co.uk>, khalid@gonehiking.org
Cc:     Deren.Wu@mediatek.com, Eddie.Chen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Eric.Liang@mediatek.com,
        Leon.Yen@mediatek.com, Mark-YW.Chen@mediatek.com,
        Soul.Huang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, YN.Chen@mediatek.com,
        abhishekpandit@google.com, ch.yeh@mediatek.com,
        frankgor@google.com, jemele@google.com, jenhao.yang@mediatek.com,
        jsiuda@google.com, km.lin@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, nbd@nbd.name, posh.sun@mediatek.com,
        robin.chiu@mediatek.com, sean.wang@mediatek.com,
        shawnku@google.com, steve.lee@mediatek.com, ted.huang@mediatek.com
References: <d291f592-d84a-2ffe-7f75-df77890efce8@gonehiking.org>
 <20220120095622.1938-1-mike@fireburn.co.uk>
 <CAHbf0-HLCcgZfbKdWQ-kX+QbRGJsEHCEDnG=NZ5QF71aTeDMGg@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <9d692dc9-4b24-44b0-cbe0-dfc33f3d5f03@candelatech.com>
Date:   Tue, 25 Jan 2022 10:09:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHbf0-HLCcgZfbKdWQ-kX+QbRGJsEHCEDnG=NZ5QF71aTeDMGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1643134144-oz9bPHkJQZpX
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/25/22 6:16 AM, Mike Lothian wrote:
> On Thu, 20 Jan 2022 at 09:56, Mike Lothian <mike@fireburn.co.uk> wrote:
>>
>> Hi
>>
>> I get a BUG and the kernel resuses to boot with this patch when mt76 is compiled into the kernel
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=214557
>>
>> I don't see this issue when mt76 is compiled as a module
>>
>> My .config is at https://github.com/FireBurn/KernelStuff/blob/master/dot_config_tip
>>
>> Let me know if you'd like any more info
>>
>> Cheers
>>
>> Mike
> 
> The bug I was hitting was due to a different change introduced in rc1,
> with that reverted your patches work great

What patch did you revert?

Thanks,
Ben

> 
> Though I am seeing lots of these messages from the bluetooth device:
> 
> Bluetooth: hci0: unexpected event 0xff length: 5 > 0
> 
> I'll bisect that next
> 
> Thanks
> 
> Mike
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


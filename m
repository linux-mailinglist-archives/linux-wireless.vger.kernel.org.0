Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6FD1C26B1
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2020 17:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgEBP4M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 May 2020 11:56:12 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:57882 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgEBP4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 May 2020 11:56:11 -0400
Received: from [192.168.254.4] (unknown [50.34.219.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7F35613C2B0;
        Sat,  2 May 2020 08:56:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7F35613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1588434971;
        bh=8xsX1r8NRVw6HTzqJK90fsdwZlHJtEH5xreyNJ2NNiw=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=Feh6wI3+ChSQxukIrO+9oyxbR49Z+kz12koIYTzPyDkdtIzehcMYG8qFoZk8JHtga
         bcxU6ciPsarPBu9S0UQybm64UXUBwUCXGJLcfE8DYjxnm4HHIi6g+s2Qg83b63QXEn
         sWfsrbbBOvFnLvDOw+HYa2c2JwzZD3gGJQVBVRRE=
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     John Deere <24601deerej@gmail.com>, Mark Baker <mark@e-bakers.com>
References: <20200427145435.13151-1-greearb@candelatech.com>
 <87h7x3v1tn.fsf@toke.dk>
 <d72dbba0-409f-93d7-5364-bc7ac50288b9@candelatech.com>
 <87a72vuyyn.fsf@toke.dk> <e49a3413-5d5e-cef7-bd31-c3a124a3bb86@gmail.com>
 <1108576c-3bf1-fde0-8266-f8e4c4a477bf@candelatech.com>
 <61bd26ed-93cb-01d9-6912-cc683d09560a@gmail.com>
 <D8BAA006-A2CD-410D-8B37-08FF28A28B04@e-bakers.com>
 <11e39934-c28b-44ea-ad4e-69ff6471d177@gmail.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <0454fedb-3112-74fe-3d44-65d71ab8df35@candelatech.com>
Date:   Sat, 2 May 2020 08:56:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <11e39934-c28b-44ea-ad4e-69ff6471d177@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 05/01/2020 10:49 PM, John Deere wrote:
>

>>>>> I've also tried the standalone patch by Ben and it seems to have reduced the latencies on top of AQL by another 5 ms.
>>>> Hello,
>>>> Did you notice any throughput changes or system load changes in the test that you did with my patch?
>
> Hi Ben,
>
> I've ran some basic throughput tests with iperf and it seems that there was also slight hit in throughput, but only by 5-20 mbps or so.

If you are using smaller buffers anyway, maybe the 1/4 restart limit is too low.  I'm running closer to 2000 tx buffers,
so my restart level would be at around 500 buffers.  I did not see any drop in tput in my test case, but rather saw
improvement.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

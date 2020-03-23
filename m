Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3319017B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 00:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgCWXBA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 19:01:00 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:58160 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWXA7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 19:00:59 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B68CB13C34C;
        Mon, 23 Mar 2020 16:00:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B68CB13C34C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1585004456;
        bh=Vx7Sy0GHD+c2JFL/Gtv4TWuJBPY8nT/Hi1riLf5rYDw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HgcvxFibocj1AqcVeaxSAzLE5lRnltWusZKg3NmR/qU78gGYwioFyJcubQZ6QMA9E
         L79zrREOVh5X/s+JG2Jkf7cII9DApL7IjhbfXR65hPysDTYKZcrt+zP1Bxg3EoT6+a
         /DcnzICTHg09qi0FYHpgp09/RmE10T0k3pMgWd1k=
Subject: Re: Firmware Crashed
To:     Ming Chen <Ming.Chen@watchguard.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Joe Qiao <Joe.Qiao@watchguard.com>
References: <BN7PR10MB2737FC3E7028D66FE34351C09AF20@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLLe2nssX3fz=xtPvM8ZQKwGpC4g=YOyUUkaniX_KB8QA@mail.gmail.com>
 <BN7PR10MB27370353B542954AD795D77E9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLvQUKCORmdJCqTz8JVoeo2-TYxkvj5p2RzoLNetKY8Vg@mail.gmail.com>
 <BN7PR10MB2737794DBC285DD90E17536D9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <2e7adba4-7a4b-f306-b216-99b64d2f42ea@candelatech.com>
Date:   Mon, 23 Mar 2020 16:00:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <BN7PR10MB2737794DBC285DD90E17536D9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/23/20 3:53 PM, Ming Chen wrote:
>>> No, it will be very difficult for us to upgrade the kernel.
>>> This module(QCA9986 PCIe) is from the a third party company. They are
>>> using the QCA driver and it works well. We are trying to integrate
>>> this module to our own device(PPC-64 + Kernel 4.14.83). We don't want
>>> to upgrade the kernel, since it will be a huge challenge work for us.
>>>
>>>
>>> Thanks
>>> Ming Chen
>>>
>>>> -----Original Message-----
>>>> From: Tom Psyborg <pozega.tomislav@gmail.com>
>>>> Sent: Saturday, March 21, 2020 11:16 PM
>>>> To: Ming Chen <Ming.Chen@watchguard.com>
>>>> Cc: linux-wireless <linux-wireless@vger.kernel.org>
>>>> Subject: Re: Firmware Crashed
>>>>
>>>> can you try to boot it in another device and using some distro that
>>>> has 4.19 or later kernel without backports?
>>>
>>
>> My suggestion is to try it in x86_64 PC. Then you can just use live linux distro
>> with different kernel versions. If it does not work with any of these you may
>> have ran into a hw bug sample. If it does work then you don't need to update
>> your PPC64 kernel but find an architecture/device speific bug that prevents it
>> from loading.
> 
> [Ming Chen]
> Thanks for the suggestion. I don't have a PC with PCIe socket on my hand, but it's indeed worth to have a try. I will try to find a one.

In case you want to try the ath10k-ct firmware for your chip, you can send me the firmware crash output and maybe
I can understand why it is crashing.

http://www.candelatech.com/ath10k.php

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


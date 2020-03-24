Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 995831903C9
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 04:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCXDJT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 23:09:19 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:35558 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgCXDJT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 23:09:19 -0400
Received: from [192.168.254.4] (unknown [50.34.189.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 655AB13C343;
        Mon, 23 Mar 2020 20:09:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 655AB13C343
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1585019358;
        bh=g7iZSuqsWijf+RyBywhj3cze7l+F1fNWmZyw40UJUdQ=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=N3In85iLSIYOjNWWb22owPkVGuERvgMLRbiw8Im/E5vTioMoaJ9EBxoDvEBfVaWB+
         snLd44UF0h/hZ12RVRFNqSOaPH9elLcUK7kJAtFmxK+4l+ioRtWJnkhK+cmXdVCNyp
         pgIeeF1sWT18YnCnnAzCPbEfAymsDikSxHcYFSe0=
Subject: Re: Firmware Crashed
To:     Ming Chen <Ming.Chen@watchguard.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>
References: <BN7PR10MB2737FC3E7028D66FE34351C09AF20@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLLe2nssX3fz=xtPvM8ZQKwGpC4g=YOyUUkaniX_KB8QA@mail.gmail.com>
 <BN7PR10MB27370353B542954AD795D77E9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
 <CAKR_QVLvQUKCORmdJCqTz8JVoeo2-TYxkvj5p2RzoLNetKY8Vg@mail.gmail.com>
 <BN7PR10MB2737794DBC285DD90E17536D9AF00@BN7PR10MB2737.namprd10.prod.outlook.com>
 <2e7adba4-7a4b-f306-b216-99b64d2f42ea@candelatech.com>
 <BN7PR10MB2737E8FB25C5D7738DAE917C9AF10@BN7PR10MB2737.namprd10.prod.outlook.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Joe Qiao <Joe.Qiao@watchguard.com>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <7bea9719-76a0-2be2-ab6f-f3425b57dee9@candelatech.com>
Date:   Mon, 23 Mar 2020 20:09:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <BN7PR10MB2737E8FB25C5D7738DAE917C9AF10@BN7PR10MB2737.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 03/23/2020 07:58 PM, Ming Chen wrote:
>>>>> No, it will be very difficult for us to upgrade the kernel.
>>>>> This module(QCA9986 PCIe) is from the a third party company. They
>>>>> are using the QCA driver and it works well. We are trying to
>>>>> integrate this module to our own device(PPC-64 + Kernel 4.14.83). We
>>>>> don't want to upgrade the kernel, since it will be a huge challenge work for
>> us.
>>>>>
>>>>>
>>>>> Thanks
>>>>> Ming Chen
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Tom Psyborg <pozega.tomislav@gmail.com>
>>>>>> Sent: Saturday, March 21, 2020 11:16 PM
>>>>>> To: Ming Chen <Ming.Chen@watchguard.com>
>>>>>> Cc: linux-wireless <linux-wireless@vger.kernel.org>
>>>>>> Subject: Re: Firmware Crashed
>>>>>>
>>>>>> can you try to boot it in another device and using some distro that
>>>>>> has 4.19 or later kernel without backports?
>>>>>
>>>>
>>>> My suggestion is to try it in x86_64 PC. Then you can just use live
>>>> linux distro with different kernel versions. If it does not work with
>>>> any of these you may have ran into a hw bug sample. If it does work
>>>> then you don't need to update your PPC64 kernel but find an
>>>> architecture/device speific bug that prevents it from loading.
>>>
>>> [Ming Chen]
>>> Thanks for the suggestion. I don't have a PC with PCIe socket on my hand, but
>> it's indeed worth to have a try. I will try to find a one.
>>
>> In case you want to try the ath10k-ct firmware for your chip, you can send me
>> the firmware crash output and maybe I can understand why it is crashing.
>>
>> http://www.candelatech.com/ath10k.php
>>
>> Thanks,
>> Ben
>>
>> --
>> Ben Greear <greearb@candelatech.com>
>> Candela Technologies Inc  http://www.candelatech.com
> [Ming Chen]
> Thanks for reminding. I just realized that the functionality of board-2.bin in ath10k driver was commented out by someone of my company, and now I restored this functionality in ath10k driver. But, firmware is still crashed, and it seems like it is caused by failing to fetch board data. That is said, the driver failed to find a matched (bus=pci,bmi-chip-id=0,bmi-board-id=11) board data from board-2.bin.
>
> Does that mean the vendor of this wireless module has not committed their board data to upstream and build to board-2.bin file?
>
> The below is the piece of BMI log,
> [ 9217.343233] ath10k_pci 0000:01:00.0: boot upload otp to 0x1234 len 8999 for board id
> [ 9217.343239] ath10k_pci 0000:01:00.0: bmi fast download address 0x1234 buffer 0x800000000018a084 length 8999
> [ 9217.343242] ath10k_pci 0000:01:00.0: bmi lz stream start address 0x1234
> [ 9217.343828] ath10k_pci 0000:01:00.0: bmi lz data buffer 0x800000000018a084 length 8996
> [ 9217.372561] ath10k_pci 0000:01:00.0: bmi lz data buffer 0xc00000007584fa50 length 4
> [ 9217.372782] ath10k_pci 0000:01:00.0: bmi lz stream start address 0x0
> [ 9217.372831] ath10k_pci 0000:01:00.0: bmi execute address 0x1234 param 0x10
> [ 9218.783383] ath10k_pci 0000:01:00.0: bmi cmd took 353 jiffies hz 250 ret 0
> [ 9218.783396] ath10k_pci 0000:01:00.0: bmi execute result 0x2c00
> [ 9218.783401] ath10k_pci 0000:01:00.0: boot get otp board id result 0x00002c00 board_id 11 chip_id 0 ext_bid_support 0
> [ 9218.783405] ath10k_pci 0000:01:00.0: SMBIOS bdf variant name not set.
> [ 9218.783409] ath10k_pci 0000:01:00.0: DT bdf variant name not set.
> [ 9218.783415] ath10k_pci 0000:01:00.0: boot using board name 'bus=pci,bmi-chip-id=0,bmi-board-id=11'
> [ 9218.783420] ath10k_pci 0000:01:00.0: boot using board name 'bus=pci,bmi-chip-id=0,bmi-board-id=11'
> [ 9218.783916] ath10k_pci 0000:01:00.0: boot fw request 'ath10k/QCA9984/hw1.0/board-2.bin': 0

This is about a wave-2 9984 NIC.  You sure yours is 9886 chipset?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

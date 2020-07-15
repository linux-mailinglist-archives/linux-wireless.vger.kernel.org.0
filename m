Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43F8221565
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 21:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGOTre (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 15:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgGOTrc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 15:47:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC86FC061755
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2020 12:47:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so4020530ljn.4
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2020 12:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exuvo-se.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vTjCZmY+AwnjLFD5jOpO/EvsJ570L+2vynaHO5qhWFw=;
        b=K5qK3OuxyG45rvDHCLPnxZs8EUVHf/X++dgMT9TgFPHZuXVBuk1q5C18vfXUYUXdCE
         YYrH6wwT5l4uFnAdAs+KhvC3ZHz0C5mrFkEIaw3X/nSDtK5aLLzZcwdGKg1WRRTBRNk4
         PxLz/Mpr0vSKgZ7ZKOYYWNCbXqKEYL9qGPJDUA/OzCLHviuCudZIBcwhdLGqJLBjHhQj
         jnpF/TgHaT/uNq3XlkpG4Q3ybCwyjZJOjSdnN58qdxnro+FAE/M+42VzV9yf5gHt5jT2
         Vl8ykBp9YMSHrJ92R+RHU6xr5UUgYe2CTaFPtJdZFXJ6//vL2jMzr7/4aqU4HqA7J5K/
         Fjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vTjCZmY+AwnjLFD5jOpO/EvsJ570L+2vynaHO5qhWFw=;
        b=LZN+cRBet1ucoYE/Abf0UePA7RnwTex9WVfTfVdS0itbPHcVMQ6teMLizj4Oqo5Qpf
         7BePKdeTFYfI5jXiLfGsZcB6gvmdjzhsJIPVmli6RuMSwu/zHVpffLOL24P05VBjNj/c
         BVgAShgczs3b/pyR2HnZYnvwjtQqdBWgkRA7wsw04PTy+WrzPAq70FMI851BFKFzErEI
         l5SO7HHgaZBbjD0cPvVQzy5Aa8J349zuF+pqKGHDDvv2MaQuEz6dhHqGoHmvLp6uXvg6
         T4sxep1mVljCI3Tm2DI1fLTzyG0k+Ya9WzqnUoXzQyJMXpEdMTpTAITPqJiNWOyD2SXg
         0wwA==
X-Gm-Message-State: AOAM530GdP8vm7ubWFKqAGyfesT2OCHHeRJj+jSAGA/J7K1nhF4xHWq4
        7UIwp3pefCU9aubazNqruowdpg==
X-Google-Smtp-Source: ABdhPJwbqx+IczTaBY2N7ZsDWh9nPsg1jUM1pRkt4DfKOBw+YIYhaXe7FUcxKYxg4IGGM2OY4hqKHw==
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr331957ljp.266.1594842450173;
        Wed, 15 Jul 2020 12:47:30 -0700 (PDT)
Received: from [192.168.1.30] (c-cb95205c.06-131-73766c1.bbcust.telenor.se. [92.32.149.203])
        by smtp.gmail.com with ESMTPSA id m25sm615137ljj.128.2020.07.15.12.47.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 12:47:29 -0700 (PDT)
Subject: Re: rt2x00 regression
From:   Anton Olsson <exuvo@exuvo.se>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>
References: <bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se>
 <20190927080303.GA7667@redhat.com>
 <CA+GwT0B5SyRZnGLqwqOeuJK4CWMVc=dKaWre9VN8KQC6kBzKGw@mail.gmail.com>
 <20191203075736.GA701@redhat.com>
 <d74dab51-3a84-9035-d89e-ea8f63e89198@exuvo.se>
 <a8eeb0bc-95da-291a-7fb9-5d15d1174c27@exuvo.se>
Message-ID: <c22673af-40e0-3af2-5ab7-69b23fc03598@exuvo.se>
Date:   Wed, 15 Jul 2020 21:47:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <a8eeb0bc-95da-291a-7fb9-5d15d1174c27@exuvo.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I added a dump_stack() call below the printk to help to narrow it down more.
Whole dump_stack part from boot http://exuvo.se/f/kernel-5.7.8-wifi-dumpstack

Excerps:
2020-07-15T19:16:02.121091+0000 kernel: status -71 num_proto_errs 1
2020-07-15T19:16:02.121214+0000 kernel: CPU: 3 PID: 700 Comm: ip Tainted: G          I       5.7.8-arch1-1-custom #1
2020-07-15T19:16:02.121276+0000 kernel: Hardware name: MSI MS-7994/H110M ECO (MS-7994), BIOS 2.00 11/26/2015
2020-07-15T19:16:02.121385+0000 kernel: Call Trace:
2020-07-15T19:16:02.121461+0000 kernel:  dump_stack+0x64/0x88
2020-07-15T19:16:02.121548+0000 kernel:  rt2x00usb_vendor_request.cold+0x2b/0x69 [rt2x00usb]
2020-07-15T19:16:02.121633+0000 kernel:  rt2x00usb_vendor_req_buff_lock+0xa6/0x230 [rt2x00usb]
2020-07-15T19:16:02.121685+0000 kernel:  rt2x00usb_register_write_lock+0x37/0x60 [rt2800usb]
2020-07-15T19:16:02.121767+0000 kernel:  rt2800_mcu_request+0x100/0x110 [rt2800lib]
2020-07-15T19:16:02.121823+0000 kernel:  rt2800_load_firmware+0x1a9/0x390 [rt2800lib]
2020-07-15T19:16:02.121873+0000 kernel:  rt2x00lib_load_firmware+0x52/0xd0 [rt2x00lib]
2020-07-15T19:16:02.121984+0000 kernel:  rt2x00lib_start+0x12/0xc0 [rt2x00lib]
2020-07-15T19:16:02.122084+0000 kernel:  drv_start+0x3e/0x130 [mac80211]

load_firmware continues until errr 509

2020-07-15T19:16:10.954842+0000 kernel: status -71 num_proto_errs 508
2020-07-15T19:16:10.954861+0000 kernel: CPU: 2 PID: 723 Comm: hostapd Tainted: G          I       5.7.8-arch1-1-custom #1
2020-07-15T19:16:10.954880+0000 kernel: Hardware name: MSI MS-7994/H110M ECO (MS-7994), BIOS 2.00 11/26/2015
2020-07-15T19:16:10.954894+0000 kernel: Call Trace:
2020-07-15T19:16:10.954908+0000 kernel:  dump_stack+0x64/0x88
2020-07-15T19:16:10.954926+0000 kernel:  rt2x00usb_vendor_request.cold+0x2b/0x69 [rt2x00usb]
2020-07-15T19:16:10.954947+0000 kernel:  rt2x00usb_vendor_req_buff_lock+0xa6/0x230 [rt2x00usb]
2020-07-15T19:16:10.954966+0000 kernel:  rt2x00usb_register_write_lock+0x37/0x60 [rt2800usb]
2020-07-15T19:16:10.954980+0000 kernel:  rt2800_mcu_request+0x100/0x110 [rt2800lib]
2020-07-15T19:16:10.954998+0000 kernel:  rt2800_load_firmware+0x1a9/0x390 [rt2800lib]
2020-07-15T19:16:10.955013+0000 kernel:  rt2x00lib_load_firmware+0x52/0xd0 [rt2x00lib]
2020-07-15T19:16:10.955026+0000 kernel:  rt2x00lib_start+0x12/0xc0 [rt2x00lib]
2020-07-15T19:16:10.955040+0000 kernel:  drv_start+0x3e/0x130 [mac80211]

2020-07-15T19:16:10.955378+0000 kernel: status -71 num_proto_errs 509
2020-07-15T19:16:10.955404+0000 kernel: CPU: 1 PID: 723 Comm: hostapd Tainted: G          I       5.7.8-arch1-1-custom #1
2020-07-15T19:16:10.956581+0000 kernel: Hardware name: MSI MS-7994/H110M ECO (MS-7994), BIOS 2.00 11/26/2015
2020-07-15T19:16:10.956602+0000 kernel: Call Trace:
2020-07-15T19:16:10.956620+0000 kernel:  dump_stack+0x64/0x88
2020-07-15T19:16:10.956635+0000 kernel:  rt2x00usb_vendor_request.cold+0x2b/0x69 [rt2x00usb]
2020-07-15T19:16:10.956649+0000 kernel:  rt2x00usb_vendor_req_buff_lock+0xa6/0x230 [rt2x00usb]
2020-07-15T19:16:10.956663+0000 kernel:  rt2x00usb_register_write_lock+0x37/0x60 [rt2800usb]
2020-07-15T19:16:10.956677+0000 kernel:  rt2800_mcu_request+0x100/0x110 [rt2800lib]
2020-07-15T19:16:10.956696+0000 kernel:  rt2800_enable_radio+0xb6/0x2d36 [rt2800lib]
2020-07-15T19:16:10.956712+0000 kernel:  rt2800usb_set_device_state+0xbd/0x18b [rt2800usb]
2020-07-15T19:16:10.956735+0000 kernel:  rt2x00lib_enable_radio+0x3e/0xa0 [rt2x00lib]
2020-07-15T19:16:10.956754+0000 kernel:  rt2x00lib_start+0x7c/0xc0 [rt2x00lib]
2020-07-15T19:16:10.956778+0000 kernel:  drv_start+0x3e/0x130 [mac80211]

and 509 is the last error, so it seems like it is the load_firmware process that is giving all the errors.

As clarification device works after this with no further errors when using.

Anton 'exuvo' Olsson
  +46732193727
  http://exuvo.se

On 2020-04-05 06:58, Anton Olsson wrote:
> So i got around to this again:
>
> Changes to linux-5.6.0 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c were:
>
> static bool rt2x00usb_check_usb_error(struct rt2x00_dev *rt2x00dev, int status)
> {
>   if (status == -ENODEV || status == -ENOENT)
>     return true;
>
>   if (status == -EPROTO || status == -ETIMEDOUT) {
>     rt2x00dev->num_proto_errs++;
> +    printk("status %d num_proto_errs %u\n", status, rt2x00dev->num_proto_errs);
>   } else
>     rt2x00dev->num_proto_errs = 0;
>
> - if (rt2x00dev->num_proto_errs > 8)
> -    return true;
>
>   return false;
> }
>
> Relevant dmesg of boot:
> [   37.342405] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070, rev 0201 detected
> [   37.353368] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
> [   37.353679] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> [   37.355695] usbcore: registered new interface driver rt2800usb
> [   37.357728] rt2800usb 1-3:1.0 wifi: renamed from wlan0
> [   72.631902] ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading firmware file 'rt2870.bin'
> [   72.702655] ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware detected - version: 0.36
> [   72.728619] status -71 num_proto_errs 1
> [   72.728733] status -71 num_proto_errs 2
> [   72.728847] status -71 num_proto_errs 3
> --same error with nothing else between--
> [   72.827518] status -71 num_proto_errs 883
> [   72.827520] ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor Request 0x06 failed for offset 0x0404 with error -71
> [   72.908595] status -71 num_proto_errs 884
> --same error with nothing else between except ip-table firewall drops--
> [   74.651391] status -71 num_proto_errs 935
> [   80.098903] IPv6: ADDRCONF(NETDEV_CHANGE): wifi: link becomes ready
> -- No more errors after this even when using device in AP mode--
>
> As the error count is very high at the start but no more errors after that i assume some part of the initialization is not supported by my device, any suggestions how to figure out what exactly? Device works fine afterwards, but i have not done any serious connection testing beyond simple transfer test, getting 3MB/s sustained transfer rate both ways which is enough for me.
>
> Anton 'exuvo' Olsson
>   +46732193727
>   http://exuvo.se
>
> On 2019-12-03 19:50, Anton Olsson wrote:
>> | So, revert of that commit makes the problem gone ?
>>
>> No I have not yet tested that. Have had too much stuff going on and this is kinda low priority for me right now as it currently works on the old kernel.
>>
>> On 2019-12-03 08:57, Stanislaw Gruszka wrote:
>>> On Mon, Dec 02, 2019 at 05:40:20PM +0100, Exuvo wrote:
>>>> Sorry for the late reply
>>>>
>>>> The patch for increasing the amount did not work, i'll get around to
>>>> testing with the commit reverted.
>>> So, revert of that commit makes the problem gone ?
>>>
>>>> As an aside what function can i call at that point in the code to print the
>>>> value in num_proto_errs? I assume some kernel special printf?
>>> It's printk. You can add line like this to print values:
>>>
>>> printk("status %d num_proto_errs %u\n", status, rt2x00dev->num_proto_errs);
>>>
>>> Stanislaw
>>>
>>>
>>>> On Fri, 27 Sep 2019, 10:03 Stanislaw Gruszka, <sgruszka@redhat.com> wrote:
>>>>
>>>>> On Thu, Sep 26, 2019 at 06:32:23PM +0200, Anton Olsson wrote:
>>>>>> Hello I have a USB based ID 148f:3070 Ralink Technology, Corp.
>>>>> RT2870/RT3070 Wireless Adapter, that stops working with recent kernels. It
>>>>> works on kernel 5.1.15 and does not work with 5.2.7 or 5.3.1 (I have not
>>>>> tested other versions). I use it in AP mode.
>>>>>> I found this similar bug report
>>>>> https://marc.info/?l=linux-wireless&m=156630037103575&w=2 but that did
>>>>> not have related error messages so I assume this is different?
>>>>>> Logs of working kernel 5.1.15-arch1-1-ARCH.
>>>>>> [   78.680555] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070,
>>>>> rev 0201 detected
>>>>>> [   78.690992] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005
>>>>> detected
>>>>>> [   78.799625] ieee80211 phy0: Selected rate control algorithm
>>>>> 'minstrel_ht'
>>>>>> sep 26 17:13:03 kernel: usbcore: registered new interface driver
>>>>> rt2800usb
>>>>>> sep 26 17:13:03 systemd[1]: Found device RT2870/RT3070 Wireless Adapter.
>>>>>> [  113.812454] ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>>>> Loading firmware file 'rt2870.bin'
>>>>>> [  113.905279] ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>>>> Firmware detected - version: 0.36
>>>>>> [  114.028703] ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor
>>>>> Request 0x06 failed for offset 0x0404 with error -71
>>>>>> The last error there does not seem to affect the operation of the device.
>>>>>>
>>>>>> Logs of not working with kernel 5.3.1, 5.2.7 has similar output.
>>>>>> sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rt: Info - RT chipset
>>>>> 3070, rev 0201 detected
>>>>>> sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chipset
>>>>> 0005 detected
>>>>>> sep 26 17:06:12 kernel: ieee80211 phy0: Selected rate control algorithm
>>>>> 'minstrel_ht'
>>>>>> sep 26 17:06:12 kernel: usbcore: registered new interface driver
>>>>> rt2800usb
>>>>>> sep 26 17:06:12 systemd[1]: Found device RT2870/RT3070 Wireless Adapter.
>>>>>> sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>>>> Loading firmware file 'rt2870.bin'
>>>>>> sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>>>> Firmware detected - version: 0.36
>>>>>> sep 26 17:06:21 ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor
>>>>> Request 0x06 failed for offset 0x0404 with>
>>>>>> sep 26 17:06:22 ieee80211 phy0: rt2800_wait_csr_ready: Error - Unstable
>>>>> hardware
>>>>>> sep 26 17:06:22 ieee80211 phy0: rt2800usb_set_device_state: Error -
>>>>> Device failed to enter state 4 (-5)
>>>>>> Unable to bring up the network interface here.
>>>>> This most likely is the problem introduced by commit:
>>>>>
>>>>> commit e383c70474db32b9d4a3de6dfbd08784d19e6751
>>>>> Author: Stanislaw Gruszka <sgruszka@redhat.com>
>>>>> Date:   Tue Mar 12 10:51:42 2019 +0100
>>>>>
>>>>>     rt2x00: check number of EPROTO errors
>>>>>
>>>>> Plase check below patch that increase number of EPROTO checks
>>>>> before marking device removed. If it does not help, plese
>>>>> check if reverting above commits helps.
>>>>>
>>>>> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>>>> b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>>>> index bc2dfef0de22..215c3f092306 100644
>>>>> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>>>> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>>>> @@ -30,7 +30,7 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_dev
>>>>> *rt2x00dev, int status)
>>>>>         else
>>>>>                 rt2x00dev->num_proto_errs = 0;
>>>>>
>>>>> -       if (rt2x00dev->num_proto_errs > 3)
>>>>> +       if (rt2x00dev->num_proto_errs > 8)
>>>>>                 return true;
>>>>>
>>>>>         return false;
>>>>>

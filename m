Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB42A110482
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 19:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLCSvC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 13:51:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42085 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfLCSvC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 13:51:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id e28so5003587ljo.9
        for <linux-wireless@vger.kernel.org>; Tue, 03 Dec 2019 10:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exuvo-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UYPlN66v5ahPTXZiNDsjBLQKRwIqq+g+Z3gPWOZSC/g=;
        b=FN2dVNseiHfq195zFy9LIyolnr2up5UXLvn3Q3FHJrQCKlcb1itNRoAhI5Wl2CjJA7
         I+dMSG0z0EUAIb3L+sksnb1/m6IGvueMJCKF80RTOlB+RCzTHDkH9xbKfW2AzaD6Wr2Z
         icq5fvmgORfldxZTqZZYVlx5PF5tN4+OiHI/PApEQeY8NEGbHUnZRJcRBkWubKWnOaSQ
         t+6VMjmgGDLO/G0CTg2OwaLg5ImyRUeS4FJX/oOnFC0bZR3OQh43HJv/zlUCChvUf9oA
         pXLd7ig+cCtIRGL+OeiTbAJrScduCqjWyUUb/5eECLX5zcjOHEFhXnX9rzH79ZgWs5NK
         S0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UYPlN66v5ahPTXZiNDsjBLQKRwIqq+g+Z3gPWOZSC/g=;
        b=mZqMfX7vVI4hnYFMT0UYOTUBgKmaGAfkMsp2RmPBuq5VHzGGjXAD/zkWRoQMV9F/W6
         3K/yBuGcVnCuzs3FfjgfD6m2lzcqhzWg2Hzta/Skuxdii51uiJUmk8QIJxsP5s6CKP4M
         VBut7fYO0SzEukT6BlROHXf509fMnrff9hijQVreZ13ZzG/yCwXW5mgBKmgpuylH/XuH
         eJuQ9sltPaWSGN+c7q3+3nWjs4yxCeZQQg/5BtcpB5skpsvYlNw/16Fwqh/BbnHGwrye
         bapeOrT4zK6ZdF1O1ieZa6HjGJTRgJg+2Obm1iiRty6lWgNbULpqU7x0UWkyx3toJBYv
         8acA==
X-Gm-Message-State: APjAAAUiZiBlDd7RBvFOU7O0TcY55I7NXhsg5UYeiKH5JAaVJskSl84s
        88oCN4tArkyz6fl9Vh2RPw7SPg==
X-Google-Smtp-Source: APXvYqzYUt4jaoITjh2SooNhJuXURVi7Q9EBtl2MzF4z/F7tGYwaqBbMMXf2Y4SuZK8wSqBXbQKlrA==
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr3079299ljk.30.1575399058578;
        Tue, 03 Dec 2019 10:50:58 -0800 (PST)
Received: from [192.168.1.30] (c-eea3205c.06-131-73766c1.bbcust.telenor.se. [92.32.163.238])
        by smtp.gmail.com with ESMTPSA id c12sm1787935ljk.77.2019.12.03.10.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 10:50:57 -0800 (PST)
Subject: Re: rt2x00 regression
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        Helmut Schaa <helmut.schaa@googlemail.com>
References: <bff7d309-a816-6a75-51b6-5928ef4f7a8c@exuvo.se>
 <20190927080303.GA7667@redhat.com>
 <CA+GwT0B5SyRZnGLqwqOeuJK4CWMVc=dKaWre9VN8KQC6kBzKGw@mail.gmail.com>
 <20191203075736.GA701@redhat.com>
From:   Anton Olsson <exuvo@exuvo.se>
Message-ID: <d74dab51-3a84-9035-d89e-ea8f63e89198@exuvo.se>
Date:   Tue, 3 Dec 2019 19:50:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20191203075736.GA701@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

| So, revert of that commit makes the problem gone ?

No I have not yet tested that. Have had too much stuff going on and this is kinda low priority for me right now as it currently works on the old kernel.

On 2019-12-03 08:57, Stanislaw Gruszka wrote:
> On Mon, Dec 02, 2019 at 05:40:20PM +0100, Exuvo wrote:
>> Sorry for the late reply
>>
>> The patch for increasing the amount did not work, i'll get around to
>> testing with the commit reverted.
> So, revert of that commit makes the problem gone ?
>
>> As an aside what function can i call at that point in the code to print the
>> value in num_proto_errs? I assume some kernel special printf?
> It's printk. You can add line like this to print values:
>
> printk("status %d num_proto_errs %u\n", status, rt2x00dev->num_proto_errs);
>
> Stanislaw
>
>
>> On Fri, 27 Sep 2019, 10:03 Stanislaw Gruszka, <sgruszka@redhat.com> wrote:
>>
>>> On Thu, Sep 26, 2019 at 06:32:23PM +0200, Anton Olsson wrote:
>>>> Hello I have a USB based ID 148f:3070 Ralink Technology, Corp.
>>> RT2870/RT3070 Wireless Adapter, that stops working with recent kernels. It
>>> works on kernel 5.1.15 and does not work with 5.2.7 or 5.3.1 (I have not
>>> tested other versions). I use it in AP mode.
>>>> I found this similar bug report
>>> https://marc.info/?l=linux-wireless&m=156630037103575&w=2 but that did
>>> not have related error messages so I assume this is different?
>>>> Logs of working kernel 5.1.15-arch1-1-ARCH.
>>>> [   78.680555] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070,
>>> rev 0201 detected
>>>> [   78.690992] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005
>>> detected
>>>> [   78.799625] ieee80211 phy0: Selected rate control algorithm
>>> 'minstrel_ht'
>>>> sep 26 17:13:03 kernel: usbcore: registered new interface driver
>>> rt2800usb
>>>> sep 26 17:13:03 systemd[1]: Found device RT2870/RT3070 Wireless Adapter.
>>>> [  113.812454] ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>> Loading firmware file 'rt2870.bin'
>>>> [  113.905279] ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>> Firmware detected - version: 0.36
>>>> [  114.028703] ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor
>>> Request 0x06 failed for offset 0x0404 with error -71
>>>> The last error there does not seem to affect the operation of the device.
>>>>
>>>> Logs of not working with kernel 5.3.1, 5.2.7 has similar output.
>>>> sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rt: Info - RT chipset
>>> 3070, rev 0201 detected
>>>> sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chipset
>>> 0005 detected
>>>> sep 26 17:06:12 kernel: ieee80211 phy0: Selected rate control algorithm
>>> 'minstrel_ht'
>>>> sep 26 17:06:12 kernel: usbcore: registered new interface driver
>>> rt2800usb
>>>> sep 26 17:06:12 systemd[1]: Found device RT2870/RT3070 Wireless Adapter.
>>>> sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>> Loading firmware file 'rt2870.bin'
>>>> sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>> Firmware detected - version: 0.36
>>>> sep 26 17:06:21 ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor
>>> Request 0x06 failed for offset 0x0404 with>
>>>> sep 26 17:06:22 ieee80211 phy0: rt2800_wait_csr_ready: Error - Unstable
>>> hardware
>>>> sep 26 17:06:22 ieee80211 phy0: rt2800usb_set_device_state: Error -
>>> Device failed to enter state 4 (-5)
>>>> Unable to bring up the network interface here.
>>> This most likely is the problem introduced by commit:
>>>
>>> commit e383c70474db32b9d4a3de6dfbd08784d19e6751
>>> Author: Stanislaw Gruszka <sgruszka@redhat.com>
>>> Date:   Tue Mar 12 10:51:42 2019 +0100
>>>
>>>     rt2x00: check number of EPROTO errors
>>>
>>> Plase check below patch that increase number of EPROTO checks
>>> before marking device removed. If it does not help, plese
>>> check if reverting above commits helps.
>>>
>>> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>> b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>> index bc2dfef0de22..215c3f092306 100644
>>> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>> @@ -30,7 +30,7 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_dev
>>> *rt2x00dev, int status)
>>>         else
>>>                 rt2x00dev->num_proto_errs = 0;
>>>
>>> -       if (rt2x00dev->num_proto_errs > 3)
>>> +       if (rt2x00dev->num_proto_errs > 8)
>>>                 return true;
>>>
>>>         return false;
>>>

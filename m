Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4640A19E972
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2020 06:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDEE6Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Apr 2020 00:58:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39155 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgDEE6Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Apr 2020 00:58:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id i20so11059056ljn.6
        for <linux-wireless@vger.kernel.org>; Sat, 04 Apr 2020 21:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exuvo-se.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XB97kVayjC+EPzcq/ncVx2+BILxvtvvDhScfC9QJGNM=;
        b=qQwk2R5KUKKEicpIyFZ87U6rS+F3XMLC8PCFZ5nArmN3tIlYwnebxyOFZdh718lmUR
         sjRCHTGLoWy77vbDNvKD8wxgCQ2LK4Qw8tij/Ve++NzjCOsRhcEUYHU2y5SIx1Lt4c0+
         tckqbE7Ji0COpFXAc57RBLWaoUlXLrFyiYkDHmzxy5AlZPZk5eClq0QduvhwX5+O7Hp+
         mwg8qMhpOIqa7KD/ez0AYZSNbajpjjKxolXp51hq35EiO0GETi569FoHgNisEWG3c2Xg
         MI4aTlhTcEAMKQwI/WCJqmq0t+c0Thmaa4vhhoS9plmeCuXmHHVbVVoYUwSBKAoauhPx
         MVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XB97kVayjC+EPzcq/ncVx2+BILxvtvvDhScfC9QJGNM=;
        b=BeGfU+imo2At6FqdHbGUjyuqAIlnFh3Sms8r+El/RkJQglXCsAmHR8phddo99zEpt4
         /oahPHnaKwgdMd+66Hz0T2UvBPkHizHS8op+NCzksmyccBHjAWstKtug92eg3YiVzQ2/
         5vFI9eeXBwBipEt3p+/ojzlw1MUazhFGrdQA4JUDglq563INe2s6IvGx2+p9duuVBmvA
         6fa1Tt81Px9rxwLuCH2cIGoOCvYzO0jZFn8MoBVkX2k52kBAvYO9XWWnj0MiD8iUnbxY
         8fl8yg6DIyz7hVZJY8FsweOtNqEKHF46ECcGpybAAr8KFCsk9X/Uz1jay1rHGkVTRnnM
         z5gA==
X-Gm-Message-State: AGi0PuYhNIHCD0QgMntWOzH8EggMd5GtKFvb7F7emr+vq9iKx0PMvpeZ
        9YpdS3wyoprkvFOqicLgTNke3w==
X-Google-Smtp-Source: APiQypLdhyn96Sr25+vQcYsCFLgkCEkVLaArECpfLRk/qWrylRXSIRqP6g6VU2P2oZVbKWQ6mD9Whw==
X-Received: by 2002:a2e:b4e7:: with SMTP id s7mr8536112ljm.184.1586062701474;
        Sat, 04 Apr 2020 21:58:21 -0700 (PDT)
Received: from [192.168.1.30] (c-fa9b205c.06-131-73766c1.bbcust.telenor.se. [92.32.155.250])
        by smtp.gmail.com with ESMTPSA id n22sm8607850lfe.8.2020.04.04.21.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 21:58:20 -0700 (PDT)
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
Message-ID: <a8eeb0bc-95da-291a-7fb9-5d15d1174c27@exuvo.se>
Date:   Sun, 5 Apr 2020 06:58:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <d74dab51-3a84-9035-d89e-ea8f63e89198@exuvo.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

So i got around to this again:

Changes to linux-5.6.0 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c were:

static bool rt2x00usb_check_usb_error(struct rt2x00_dev *rt2x00dev, int status)
{
  if (status == -ENODEV || status == -ENOENT)
    return true;

  if (status == -EPROTO || status == -ETIMEDOUT) {
    rt2x00dev->num_proto_errs++;
+    printk("status %d num_proto_errs %u\n", status, rt2x00dev->num_proto_errs);
  } else
    rt2x00dev->num_proto_errs = 0;

- if (rt2x00dev->num_proto_errs > 8)
-    return true;

  return false;
}

Relevant dmesg of boot:
[   37.342405] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070, rev 0201 detected
[   37.353368] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005 detected
[   37.353679] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   37.355695] usbcore: registered new interface driver rt2800usb
[   37.357728] rt2800usb 1-3:1.0 wifi: renamed from wlan0
[   72.631902] ieee80211 phy0: rt2x00lib_request_firmware: Info - Loading firmware file 'rt2870.bin'
[   72.702655] ieee80211 phy0: rt2x00lib_request_firmware: Info - Firmware detected - version: 0.36
[   72.728619] status -71 num_proto_errs 1
[   72.728733] status -71 num_proto_errs 2
[   72.728847] status -71 num_proto_errs 3
--same error with nothing else between--
[   72.827518] status -71 num_proto_errs 883
[   72.827520] ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor Request 0x06 failed for offset 0x0404 with error -71
[   72.908595] status -71 num_proto_errs 884
--same error with nothing else between except ip-table firewall drops--
[   74.651391] status -71 num_proto_errs 935
[   80.098903] IPv6: ADDRCONF(NETDEV_CHANGE): wifi: link becomes ready
-- No more errors after this even when using device in AP mode--

As the error count is very high at the start but no more errors after that i assume some part of the initialization is not supported by my device, any suggestions how to figure out what exactly? Device works fine afterwards, but i have not done any serious connection testing beyond simple transfer test, getting 3MB/s sustained transfer rate both ways which is enough for me.

Anton 'exuvo' Olsson
  +46732193727
  http://exuvo.se

On 2019-12-03 19:50, Anton Olsson wrote:
> | So, revert of that commit makes the problem gone ?
>
> No I have not yet tested that. Have had too much stuff going on and this is kinda low priority for me right now as it currently works on the old kernel.
>
> On 2019-12-03 08:57, Stanislaw Gruszka wrote:
>> On Mon, Dec 02, 2019 at 05:40:20PM +0100, Exuvo wrote:
>>> Sorry for the late reply
>>>
>>> The patch for increasing the amount did not work, i'll get around to
>>> testing with the commit reverted.
>> So, revert of that commit makes the problem gone ?
>>
>>> As an aside what function can i call at that point in the code to print the
>>> value in num_proto_errs? I assume some kernel special printf?
>> It's printk. You can add line like this to print values:
>>
>> printk("status %d num_proto_errs %u\n", status, rt2x00dev->num_proto_errs);
>>
>> Stanislaw
>>
>>
>>> On Fri, 27 Sep 2019, 10:03 Stanislaw Gruszka, <sgruszka@redhat.com> wrote:
>>>
>>>> On Thu, Sep 26, 2019 at 06:32:23PM +0200, Anton Olsson wrote:
>>>>> Hello I have a USB based ID 148f:3070 Ralink Technology, Corp.
>>>> RT2870/RT3070 Wireless Adapter, that stops working with recent kernels. It
>>>> works on kernel 5.1.15 and does not work with 5.2.7 or 5.3.1 (I have not
>>>> tested other versions). I use it in AP mode.
>>>>> I found this similar bug report
>>>> https://marc.info/?l=linux-wireless&m=156630037103575&w=2 but that did
>>>> not have related error messages so I assume this is different?
>>>>> Logs of working kernel 5.1.15-arch1-1-ARCH.
>>>>> [   78.680555] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3070,
>>>> rev 0201 detected
>>>>> [   78.690992] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0005
>>>> detected
>>>>> [   78.799625] ieee80211 phy0: Selected rate control algorithm
>>>> 'minstrel_ht'
>>>>> sep 26 17:13:03 kernel: usbcore: registered new interface driver
>>>> rt2800usb
>>>>> sep 26 17:13:03 systemd[1]: Found device RT2870/RT3070 Wireless Adapter.
>>>>> [  113.812454] ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>>> Loading firmware file 'rt2870.bin'
>>>>> [  113.905279] ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>>> Firmware detected - version: 0.36
>>>>> [  114.028703] ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor
>>>> Request 0x06 failed for offset 0x0404 with error -71
>>>>> The last error there does not seem to affect the operation of the device.
>>>>>
>>>>> Logs of not working with kernel 5.3.1, 5.2.7 has similar output.
>>>>> sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rt: Info - RT chipset
>>>> 3070, rev 0201 detected
>>>>> sep 26 17:06:12 kernel: ieee80211 phy0: rt2x00_set_rf: Info - RF chipset
>>>> 0005 detected
>>>>> sep 26 17:06:12 kernel: ieee80211 phy0: Selected rate control algorithm
>>>> 'minstrel_ht'
>>>>> sep 26 17:06:12 kernel: usbcore: registered new interface driver
>>>> rt2800usb
>>>>> sep 26 17:06:12 systemd[1]: Found device RT2870/RT3070 Wireless Adapter.
>>>>> sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>>> Loading firmware file 'rt2870.bin'
>>>>> sep 26 17:06:21 ieee80211 phy0: rt2x00lib_request_firmware: Info -
>>>> Firmware detected - version: 0.36
>>>>> sep 26 17:06:21 ieee80211 phy0: rt2x00usb_vendor_request: Error - Vendor
>>>> Request 0x06 failed for offset 0x0404 with>
>>>>> sep 26 17:06:22 ieee80211 phy0: rt2800_wait_csr_ready: Error - Unstable
>>>> hardware
>>>>> sep 26 17:06:22 ieee80211 phy0: rt2800usb_set_device_state: Error -
>>>> Device failed to enter state 4 (-5)
>>>>> Unable to bring up the network interface here.
>>>> This most likely is the problem introduced by commit:
>>>>
>>>> commit e383c70474db32b9d4a3de6dfbd08784d19e6751
>>>> Author: Stanislaw Gruszka <sgruszka@redhat.com>
>>>> Date:   Tue Mar 12 10:51:42 2019 +0100
>>>>
>>>>     rt2x00: check number of EPROTO errors
>>>>
>>>> Plase check below patch that increase number of EPROTO checks
>>>> before marking device removed. If it does not help, plese
>>>> check if reverting above commits helps.
>>>>
>>>> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>>> b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>>> index bc2dfef0de22..215c3f092306 100644
>>>> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>>> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00usb.c
>>>> @@ -30,7 +30,7 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_dev
>>>> *rt2x00dev, int status)
>>>>         else
>>>>                 rt2x00dev->num_proto_errs = 0;
>>>>
>>>> -       if (rt2x00dev->num_proto_errs > 3)
>>>> +       if (rt2x00dev->num_proto_errs > 8)
>>>>                 return true;
>>>>
>>>>         return false;
>>>>

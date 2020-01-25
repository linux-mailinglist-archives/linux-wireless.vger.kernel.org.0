Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42695149569
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2020 13:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgAYMEv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jan 2020 07:04:51 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38177 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAYMEu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jan 2020 07:04:50 -0500
Received: by mail-io1-f68.google.com with SMTP id s24so3313076iog.5
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2020 04:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4WJnT9vmmc6p/wJCIxx6aOEOfuBwmOhS7rxx6pWw/kw=;
        b=Mxxd6CBxXTUlqB0Ke5ONYNoxE6oewlbBISn0DHnofWSDgEMw1R1jUf+r5/Rlo1yTAk
         VbwIJY8VDS3b7VGYqYAeYoMZt92IFPYXl6FL2OKpWNIoeTafP/NM7U6QjlvvwqWDKcNk
         P5I2LSbmkK1BEo+JqllF3JXUlOERXbn1xRuS41mHZdBqrRC9rvkzSWnzgna10j01O/gj
         drCrCtli8xXW+cPZ8HGWp6mZGk6fGPiIZZuLGl5yU/XaLVBWyfvDJZIVA1Aq7inQ1Guj
         FOFCeh+7pC8GX+SwuGaFK5+izxAj6JgF1v0ovY4Habp3xmFz39T/IfzS0WEWSISHMbph
         fSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4WJnT9vmmc6p/wJCIxx6aOEOfuBwmOhS7rxx6pWw/kw=;
        b=GeF8klplhV/35RVRkJxeKOkD0c/kzraWtSR1+L6KXCEcNAxAS2fN9zyE7deRtmQvat
         uFTBrgo7WYJkd6zyzUUEPWUJO8rUaqRw864XqTE23Jz1tX2oNR23F0x5WnnwKsjzEcQ7
         AAXueWFtRkQ710Ymgoq/H9bywuLSPjPU1yqgvKbloUyjpUSIuPfrQdl6kcPxIsOeLI8k
         xo1NMods2oFnYHCEfMow1+5u9inHvGqw7mN0LflktyR4e2qOvjPM56QvS6qmDtFT02ab
         Cbcx2UBE51hwSBGsXYZzK3hv1mqwOjS1d0lNVYLATYm2K8xMlDCwEd7rb1z45/23Wb52
         sCAQ==
X-Gm-Message-State: APjAAAWW8OH9suufXWZfeje6kQia1SE+e95UJ0Dd+rJGNRsYxufToSHi
        AVrupjkStLyaMdvvt5o/1ZAYAOGp16w7Mc8XQwfO6MfQ
X-Google-Smtp-Source: APXvYqyMjk9mG6XuLB4cf7R5DeKMEIqjWofDYgE7Sj7uzaBuzWoD5DlLs2+1LZErkfL6tvTfo7ssVuJ71d4pSFV6dt4=
X-Received: by 2002:a6b:d912:: with SMTP id r18mr5606846ioc.306.1579953889713;
 Sat, 25 Jan 2020 04:04:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5d0d:0:0:0:0:0 with HTTP; Sat, 25 Jan 2020 04:04:49
 -0800 (PST)
In-Reply-To: <CAMrEMU-vbFZD0XmuWX9JZCe6Nj_c6TaQNRLJNOz_HYX+AHwusg@mail.gmail.com>
References: <CAA=hcWTouQAnc+uZjj2fb44Z3=T0gSqjwcW9CiRpOJJxGcx=Hg@mail.gmail.com>
 <CAMrEMU-vbFZD0XmuWX9JZCe6Nj_c6TaQNRLJNOz_HYX+AHwusg@mail.gmail.com>
From:   JH <jupiter.hce@gmail.com>
Date:   Sat, 25 Jan 2020 23:04:49 +1100
Message-ID: <CAA=hcWQ1Khi5Qsv11UO6iJL43qni9BjDC0D5RCL0EV7=XVFD0g@mail.gmail.com>
Subject: Re: Why the mwifiex_sdio frequently disconnected and connected?
To:     Justin Capella <justincapella@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ofono <ofono@ofono.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Justin,

Thanks for the response.

On 1/25/20, Justin Capella <justincapella@gmail.com> wrote:
> I am not familiar with this device or its source, but the negative
> numbers correspond to errors EPROTO and ENODEV, the 34:08:03 seems to
> be off-by-one from the BSSID you connect to...

Right, but I can see the drivers:

# ls -l /dev/ttyUSB*
crw-rw----    1 root     dialout   188,   0 Jan 25 09:06 /dev/ttyUSB0
crw-rw----    1 root     dialout   188,   1 Jan 25 09:06 /dev/ttyUSB1

> It would be helpful to know the kernel version, and model/versions of
> the hardware and firmware-- likely you can get the info by grepping
> dmesg/kmsg for qmi and mwifi. lspci and lsusb -vt might also be useful
> info.

Kernel 4.19.75

# lsusb -vt
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ci_hdrc/1p, 480M
    |__ Port 1: Dev 4, If 0, Class=Vendor Specific Class, Driver=option, 480M
    |__ Port 1: Dev 4, If 1, Class=Vendor Specific Class, Driver=, 480M
    |__ Port 1: Dev 4, If 2, Class=Vendor Specific Class, Driver=option, 480M
    |__ Port 1: Dev 4, If 3, Class=Vendor Specific Class, Driver=qmi_wwan, 480M

> Seems like the modem is a subsystem of the 1-1:1.0 device that is though.
>
> I have a qmi modem and it changes bConfigurationValue parameter which
> causes it to reset and present different interfaces (qmi vs mbim if i
> recall correctly), perhaps something is making that change...
> ModemManager?
>
> Have a look in /sys/kernel/modules/ there should be some sort of
> *qmi*/parameters/ where you can maybe change the debug flag
> (alternatively you could modinfo qmi_wwan, assuming that is the right
> module, and rmmod it, and modprobe the_qmi-module
> the_debug_parameter=0xfffffff)

I don't have /sys/kernel/modules/ in the Yocto built file system, nor
can I find in my Ubuntu 18 laptop, my system is different from yours.

> Sorry this is sort of a generic response, and I know not the most
> useful, but others would likely benefit from additional info too, and
> time allowing I'll poke around in the code to try and come up with
> some ideas

I changed to connect 5V DC power from a DC power supply, at first, the
error messages continually displayed, then it got more stable. As I
also stopped some applications, not quite sure which one make the
difference. Will have to spend more time to check it.

Thank you.

Kind regards,

- jh

>
> On Fri, Jan 24, 2020 at 5:10 PM JH <jupiter.hce@gmail.com> wrote:
>>
>> Hi,
>>
>> I have been running mwifiex_sdio for a uBlox 4G LTE SARA-R4  and Lily
>> WiFi module, it seems that WiFi connection is stable, but the LTE
>> connection is often connected and disconnected.
>>
>> Looking into the kernel messages, there were many messages to
>> disconnect and connect it again every half of an hour. The device did
>> not set IPv6 which is understandably that IPv6: ADDRCONF(NETDEV_UP)
>> link is not ready, but why it often doing mwifiex_sdio mmc0:0001:1:
>> info: successfully disconnected from 34:08:03 and what that means?
>>
>> root@solar:/var/backups# [ 2045.955013] mwifiex_sdio mmc0:0001:1:
>> CMD_RESP: cmd 0x23f error, result=0x2
>>
>> root@solar:/var/backups# [ 2250.000008] mwifiex_sdio mmc0:0001:1:
>> info: successfully disconnected from 34:08:03
>> [ 2250.081497] IPv6: ADDRCONF(NETDEV_UP): mlan0: link is not ready
>> [ 2250.206977] IPv6: ADDRCONF(NETDEV_UP): wwan0: link is not ready
>> [ 2251.417295] mwifiex_sdio mmc0:0001:1: info: trying to associate to
>> 'JupiterIoT' bssid 34:08:04:12:b1:a2
>> [ 2251.521866] mwifiex_sdio mmc0:0001:1: info: associated to bssid
>> 34:08:04:12:b1:a2 successfully
>> [ 2251.666834] IPv6: ADDRCONF(NETDEV_CHANGE): mlan0: link becomes ready
>> [ 2251.743352] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error,
>> result=0x2
>>
>>
>> Also, the 4G LTE SARA-R4 uses USB interface and protocol, but it seems
>> to me that mwifiex_sdio managers both LTE and WiFi connections, right?
>>
>> I am currently debugging the LTE connection stability issues, it
>> ofoten connected to LTE, then in half hours or hours randomly, lose
>> the LTE connection. I try to narrow down the cause, whether the USB
>> interface or from mwifiex_sdio caused LTE connection stability. When
>> the LTE lost connection there were following errors which I am not
>> clear if related to the mwifiex_sdio  or not. Appreciate your advise
>> and comments to diagnostic the issue and to fix the LTE connection
>> problems.
>>
>>  1019.130834] option 1-1:1.0: device disconnected
>> [ 1019.142012] qmi_wwan 1-1:1.3: nonzero urb status received: -71
>> [ 1019.147909] qmi_wwan 1-1:1.3: wdm_int_callback - 0 bytes
>> [ 1019.153254] qmi_wwan 1-1:1.3: wdm_int_callback - usb_submit_urb
>> failed with result -19
>> [ 1019.228197] option1 ttyUSB1: GSM modem (1-port) converter now
>> disconnected from ttyUSB1
>>
>> Thank you.
>>
>> Kind regards,
>>
>> - jh
>

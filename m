Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C091493CC
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2020 07:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgAYGcl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jan 2020 01:32:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44996 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAYGcl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jan 2020 01:32:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so1761882oia.11
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2020 22:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rgy6rlf2XKN9w745u3IT9aFUHmFaHZYdIybF8fu1LA=;
        b=obBs189+09t5EsvwBib4JzB7YUSULse7XmwtPjqX7ABw4/VyJzL7Qg6dQ/h0jzNsOT
         qpdOhyRdCILTj9Znh7y1ljcudtDSoujb6oRGwvEX0QB4/VRpGDOHPV8YcCIivz5ImQwf
         Jwy483mvXCkfg9Pg96YpKWdDukOvyUeI3WU51jmsH/GvS22IfjkWIX2eH/hP+wOdsNur
         92k/C6yo5pehBnMpXCGL3yJYJm4U6SCWV2BgwRfoORZ3ZX/RZxHJ0boKgZULXg5lJ8ve
         d2VBslKbPKHrX7OSkC7a1rGrg3/obX8T6fVTEys/Gh0wU2m2Vk19JJWTcqHf38JnqPL/
         3Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rgy6rlf2XKN9w745u3IT9aFUHmFaHZYdIybF8fu1LA=;
        b=MOHkH36RzlL3rWAxyBp7h9CRroXh1d3i9FXgoDavy5hRpTJhCu8PMsZ6WxoRN5/L+K
         RwUitGImFlC9IWuHCcVGbKuQJF3OakTXlYvWSabqgKFCo1BHiUo+pdvTJVeOZtqUYDav
         37Bg152ocCkzWVqzsCAhFeDWORea5lMBFtPpKZsRoh/EyB5QHH6UMWAwGqmluBKfZucz
         tppnA197BAorPyxSex+0Vl9XNiuquCbMML0QsQon7uj5ntchwV2pQkoX8L3U06XTD4RB
         YKcxBU5NYsFUtttRXuQ7zEjaV+tF2c9FhB0QCP5Rfb5LzlRb1dOUERDKrLg8yFk7tzGc
         hyFA==
X-Gm-Message-State: APjAAAXapkQzvXr2DgMOQqCmq1A9WszYfFXM1exYuPZSpHMwqZdwhjT5
        Da87hxuRy3QFnXD5CyHR0MMYoWFjqlS6wLMj9Bc=
X-Google-Smtp-Source: APXvYqwwVSVmD/hweuFJlF1tvnXaJYYuyodwuRFy7v1QxAnFbreYp2fzyrZ6ebzRawi4HCcvdqP3O0kkdpyirEAuJOo=
X-Received: by 2002:a05:6808:8e5:: with SMTP id d5mr1592415oic.154.1579933960181;
 Fri, 24 Jan 2020 22:32:40 -0800 (PST)
MIME-Version: 1.0
References: <CAA=hcWTouQAnc+uZjj2fb44Z3=T0gSqjwcW9CiRpOJJxGcx=Hg@mail.gmail.com>
In-Reply-To: <CAA=hcWTouQAnc+uZjj2fb44Z3=T0gSqjwcW9CiRpOJJxGcx=Hg@mail.gmail.com>
From:   Justin Capella <justincapella@gmail.com>
Date:   Fri, 24 Jan 2020 22:32:27 -0800
Message-ID: <CAMrEMU-vbFZD0XmuWX9JZCe6Nj_c6TaQNRLJNOz_HYX+AHwusg@mail.gmail.com>
Subject: Re: Why the mwifiex_sdio frequently disconnected and connected?
To:     JH <jupiter.hce@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I am not familiar with this device or its source, but the negative
numbers correspond to errors EPROTO and ENODEV, the 34:08:03 seems to
be off-by-one from the BSSID you connect to...

It would be helpful to know the kernel version, and model/versions of
the hardware and firmware-- likely you can get the info by grepping
dmesg/kmsg for qmi and mwifi. lspci and lsusb -vt might also be useful
info.

Seems like the modem is a subsystem of the 1-1:1.0 device that is though.

I have a qmi modem and it changes bConfigurationValue parameter which
causes it to reset and present different interfaces (qmi vs mbim if i
recall correctly), perhaps something is making that change...
ModemManager?

Have a look in /sys/kernel/modules/ there should be some sort of
*qmi*/parameters/ where you can maybe change the debug flag
(alternatively you could modinfo qmi_wwan, assuming that is the right
module, and rmmod it, and modprobe the_qmi-module
the_debug_parameter=0xfffffff)

Sorry this is sort of a generic response, and I know not the most
useful, but others would likely benefit from additional info too, and
time allowing I'll poke around in the code to try and come up with
some ideas


On Fri, Jan 24, 2020 at 5:10 PM JH <jupiter.hce@gmail.com> wrote:
>
> Hi,
>
> I have been running mwifiex_sdio for a uBlox 4G LTE SARA-R4  and Lily
> WiFi module, it seems that WiFi connection is stable, but the LTE
> connection is often connected and disconnected.
>
> Looking into the kernel messages, there were many messages to
> disconnect and connect it again every half of an hour. The device did
> not set IPv6 which is understandably that IPv6: ADDRCONF(NETDEV_UP)
> link is not ready, but why it often doing mwifiex_sdio mmc0:0001:1:
> info: successfully disconnected from 34:08:03 and what that means?
>
> root@solar:/var/backups# [ 2045.955013] mwifiex_sdio mmc0:0001:1:
> CMD_RESP: cmd 0x23f error, result=0x2
>
> root@solar:/var/backups# [ 2250.000008] mwifiex_sdio mmc0:0001:1:
> info: successfully disconnected from 34:08:03
> [ 2250.081497] IPv6: ADDRCONF(NETDEV_UP): mlan0: link is not ready
> [ 2250.206977] IPv6: ADDRCONF(NETDEV_UP): wwan0: link is not ready
> [ 2251.417295] mwifiex_sdio mmc0:0001:1: info: trying to associate to
> 'JupiterIoT' bssid 34:08:04:12:b1:a2
> [ 2251.521866] mwifiex_sdio mmc0:0001:1: info: associated to bssid
> 34:08:04:12:b1:a2 successfully
> [ 2251.666834] IPv6: ADDRCONF(NETDEV_CHANGE): mlan0: link becomes ready
> [ 2251.743352] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2
>
>
> Also, the 4G LTE SARA-R4 uses USB interface and protocol, but it seems
> to me that mwifiex_sdio managers both LTE and WiFi connections, right?
>
> I am currently debugging the LTE connection stability issues, it
> ofoten connected to LTE, then in half hours or hours randomly, lose
> the LTE connection. I try to narrow down the cause, whether the USB
> interface or from mwifiex_sdio caused LTE connection stability. When
> the LTE lost connection there were following errors which I am not
> clear if related to the mwifiex_sdio  or not. Appreciate your advise
> and comments to diagnostic the issue and to fix the LTE connection
> problems.
>
>  1019.130834] option 1-1:1.0: device disconnected
> [ 1019.142012] qmi_wwan 1-1:1.3: nonzero urb status received: -71
> [ 1019.147909] qmi_wwan 1-1:1.3: wdm_int_callback - 0 bytes
> [ 1019.153254] qmi_wwan 1-1:1.3: wdm_int_callback - usb_submit_urb
> failed with result -19
> [ 1019.228197] option1 ttyUSB1: GSM modem (1-port) converter now
> disconnected from ttyUSB1
>
> Thank you.
>
> Kind regards,
>
> - jh

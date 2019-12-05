Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478DF1146F1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 19:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfLESeh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 13:34:37 -0500
Received: from wp063.webpack.hosteurope.de ([80.237.132.70]:38224 "EHLO
        wp063.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfLESeh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 13:34:37 -0500
Received: from processor.work ([89.163.132.190] helo=webmail.richenhagen.gl); authenticated
        by wp063.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1icvxR-0002s0-R5; Thu, 05 Dec 2019 19:34:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Dec 2019 19:34:33 +0100
From:   <linux@jusic.net>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Tony Chuang <yhchuang@realtek.com>, linux-wireless@vger.kernel.org
Subject: Re: RTL8822CE IPv6 autoconfiguration not working
In-Reply-To: <0101016ed53008cc-fedb047e-381d-46da-b972-ac7bc84056a3-000000@us-west-2.amazonses.com>
References: <f0aac1e559c2a3fa1e7eb8398ed58d46@jusic.net>
 <e58983606ddb4d3c81f4d8bb27171da8@realtek.com>
 <0101016ed53008cc-fedb047e-381d-46da-b972-ac7bc84056a3-000000@us-west-2.amazonses.com>
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <7c0fc01aff5ad6bc7d65eeea50709a73@jusic.net>
X-Sender: linux@jusic.net
X-bounce-key: webpack.hosteurope.de;linux@jusic.net;1575570875;6896fd7b;
X-HE-SMSGID: 1icvxR-0002s0-R5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 2019-12-05 09:32, schrieb Kalle Valo:
> Tony Chuang <yhchuang@realtek.com> writes:
> 
>>> Subject: RTL8822CE IPv6 autoconfiguration not working
>>> 
>>> Hello,
>>> 
>>> I just bought a new laptop with an Realtek RTL8822CE wireless card
>>> buildin. I'm using NetworkManager with its internal DHCP client. I 
>>> have
>>> working IPv6 autoconfiguration support in my home network with 7 
>>> devices
>>> with different operating systems. When I plug a USB network card into
>>> the laptop IPv6 is configured sucessfully. But with the wireless card
>>> IPv6 autoconfiguration doesn't work. When I manually add an IPv6 with
>>> "sudo ip -6 addr add <address>/64 dev wlp1s0" I can ping IPv6 
>>> targets.
>>> So there seems to be an bug either in the driver or maybe in
>>> NetworkManager which prevents autoconfiguration from working, can
>>> sombody look into this? I'm glad to help and provide further
>>> informations or test things out.
>>> 
>>> Kind Regards
>>> Joshua
>>> 
>>> 
>>> ip addr
>>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state
>>> UNKNOWN
>>> group default qlen 1000
>>>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>>>      inet 127.0.0.1/8 scope host lo
>>>         valid_lft forever preferred_lft forever
>>>      inet6 ::1/128 scope host
>>>         valid_lft forever preferred_lft forever
>>> 2: wlp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
>>> state UP
>>> group default qlen 1000
>>>      link/ether 40:5b:d8:1a:7a:a9 brd ff:ff:ff:ff:ff:ff
>>>      inet 192.168.178.25/24 brd 192.168.178.255 scope global dynamic
>>> noprefixroute wlp1s0
>>>         valid_lft 863798sec preferred_lft 863798sec
>>>      inet6 fe80::1b8b:8c3a:b569:a882/64 scope link noprefixroute
>>>         valid_lft forever preferred_lft forever
>>> 
>>> lspci -v
>>> 01:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device 
>>> c822
>>> 	Subsystem: Electronics & Telecommunications RSH Device 1e25
>>> 	Flags: bus master, fast devsel, latency 0, IRQ 71
>>> 	I/O ports at 2000 [size=256]
>>> 	Memory at c0700000 (64-bit, non-prefetchable) [size=64K]
>>> 	Capabilities: <access denied>
>>> 	Kernel driver in use: rtw_pci
>>> 	Kernel modules: rtwpci
>>> 
>> 
>> I am not sure if this is driver-related problem, but I think you can 
>> try to
>> tcpdump and see where the autoconfiguration failed.
>> And I am not an expert of IPv6, but if there is any issue with the 
>> driver I
>> can help you.
> 
> My first guess would be some kind of multicast problem with power save
> mode. I would first try disabling the power save mode on the driver and
> see if that helps.

Disable power save with iw:

iw dev wlp1s0 get power_save
Power save: off

or in tlp:

# WiFi power saving mode: on=enable, off=disable; not supported by all 
adapters.
# Default: <none>
WIFI_PWR_ON_AC=off
WIFI_PWR_ON_BAT=off

or  on NetworkManager:

# File to be place under /etc/NetworkManager/conf.d
[connection]
# Values are 0 (use default), 1 (ignore/don't touch), 2 (disable) or 3 
(enable).
wifi.powersave = 2

Did not help, where else could this be configured?

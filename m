Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F6E113D0C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 09:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfLEIcH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 03:32:07 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:56284
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbfLEIcG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 03:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575534725;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=6SX9HSoHu/NJqDNPkvwsWAkZdSlmaMvxEZBuiIuHwxs=;
        b=dBdbjR7+sguzMh4APUYH9iWjMAE4+iIq/JWM60LK4eMOzGatMbna2XK2XBNFKEM7
        axuFHqPaQUs3PFLqMS5mZTRQZvbSltM4b465WT6+LYeehdGo+HSrt215pYfkUm6chKv
        j1zEdwGNYW+GCq/PIyPW9FTuwco70O7KOdbOXJtg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575534725;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=6SX9HSoHu/NJqDNPkvwsWAkZdSlmaMvxEZBuiIuHwxs=;
        b=A6a9XrXiMPaBcBNiePf+yWQr7VqRt7wOyupzI8/SCBq+39+Ec3vuMRyaZ0/aTHos
        MOEwxhYlfEJD7KaFtFn5tREdjGWdyPxwrfhPSemCa7dWiLWjeWS8Jul+0rrhNyUdDBM
        sWwC90hHV0DPGrBVlTzYQu+s/uyn+J1O4WSfEccw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B765DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "linux\@jusic.net" <linux@jusic.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: RTL8822CE IPv6 autoconfiguration not working
References: <f0aac1e559c2a3fa1e7eb8398ed58d46@jusic.net>
        <e58983606ddb4d3c81f4d8bb27171da8@realtek.com>
Date:   Thu, 5 Dec 2019 08:32:05 +0000
In-Reply-To: <e58983606ddb4d3c81f4d8bb27171da8@realtek.com> (Tony Chuang's
        message of "Thu, 5 Dec 2019 03:36:18 +0000")
Message-ID: <0101016ed53009ce-6e91b0d5-9ead-44ac-8b91-ae71e22fe275-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.05-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> Subject: RTL8822CE IPv6 autoconfiguration not working
>> 
>> Hello,
>> 
>> I just bought a new laptop with an Realtek RTL8822CE wireless card
>> buildin. I'm using NetworkManager with its internal DHCP client. I have
>> working IPv6 autoconfiguration support in my home network with 7 devices
>> with different operating systems. When I plug a USB network card into
>> the laptop IPv6 is configured sucessfully. But with the wireless card
>> IPv6 autoconfiguration doesn't work. When I manually add an IPv6 with
>> "sudo ip -6 addr add <address>/64 dev wlp1s0" I can ping IPv6 targets.
>> So there seems to be an bug either in the driver or maybe in
>> NetworkManager which prevents autoconfiguration from working, can
>> sombody look into this? I'm glad to help and provide further
>> informations or test things out.
>> 
>> Kind Regards
>> Joshua
>> 
>> 
>> ip addr
>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state
>> UNKNOWN
>> group default qlen 1000
>>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>>      inet 127.0.0.1/8 scope host lo
>>         valid_lft forever preferred_lft forever
>>      inet6 ::1/128 scope host
>>         valid_lft forever preferred_lft forever
>> 2: wlp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq
>> state UP
>> group default qlen 1000
>>      link/ether 40:5b:d8:1a:7a:a9 brd ff:ff:ff:ff:ff:ff
>>      inet 192.168.178.25/24 brd 192.168.178.255 scope global dynamic
>> noprefixroute wlp1s0
>>         valid_lft 863798sec preferred_lft 863798sec
>>      inet6 fe80::1b8b:8c3a:b569:a882/64 scope link noprefixroute
>>         valid_lft forever preferred_lft forever
>> 
>> lspci -v
>> 01:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device c822
>> 	Subsystem: Electronics & Telecommunications RSH Device 1e25
>> 	Flags: bus master, fast devsel, latency 0, IRQ 71
>> 	I/O ports at 2000 [size=256]
>> 	Memory at c0700000 (64-bit, non-prefetchable) [size=64K]
>> 	Capabilities: <access denied>
>> 	Kernel driver in use: rtw_pci
>> 	Kernel modules: rtwpci
>> 
>
> I am not sure if this is driver-related problem, but I think you can try to
> tcpdump and see where the autoconfiguration failed.
> And I am not an expert of IPv6, but if there is any issue with the driver I
> can help you.

My first guess would be some kind of multicast problem with power save
mode. I would first try disabling the power save mode on the driver and
see if that helps.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

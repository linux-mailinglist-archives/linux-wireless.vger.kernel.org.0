Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED681939B8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 08:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgCZHnU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 03:43:20 -0400
Received: from mail.neratec.com ([46.140.151.2]:29907 "EHLO mail.neratec.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCZHnU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 03:43:20 -0400
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 03:43:19 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.neratec.com (Postfix) with ESMTP id 4E789CE039A;
        Thu, 26 Mar 2020 08:33:58 +0100 (CET)
Received: from mail.neratec.com ([127.0.0.1])
        by localhost (mail.neratec.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PUBkgJRXTotx; Thu, 26 Mar 2020 08:33:58 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.neratec.com (Postfix) with ESMTP id 3353DCE03CE;
        Thu, 26 Mar 2020 08:33:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at neratec.com
Received: from mail.neratec.com ([127.0.0.1])
        by localhost (mail.neratec.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ao0a75Un2hVa; Thu, 26 Mar 2020 08:33:58 +0100 (CET)
Received: from [10.0.11.179] (asterix.lan.neratec.com [172.29.100.2])
        by mail.neratec.com (Postfix) with ESMTPSA id 0BCC6CE039A;
        Thu, 26 Mar 2020 08:33:58 +0100 (CET)
Subject: Re: Geoffroy LETOURNEUR: Samsung AX200 system integration on Nvidia
 Nano.
To:     Geoffroy Letourneur <g.letourneur@samsung.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
Cc:     Gilles Mazars <g.mazars@samsung.com>,
        Martin Bourreau <m.bourreau@samsung.com>
References: <CGME20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba@uscas1p1.samsung.com>
 <8096A04E-8692-4DC3-A8D0-8F85FF972799@samsung.com>
From:   Matthias May <matthias.may@neratec.com>
Message-ID: <04b77faf-2862-22a4-c7e1-1163219e76e9@neratec.com>
Date:   Thu, 26 Mar 2020 08:33:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8096A04E-8692-4DC3-A8D0-8F85FF972799@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/03/2020 16:54, Geoffroy Letourneur wrote:
> 
> Hello,
> 
> I am working on Jetson Nano boards. I would like to connect two boards together with AX200 wifi module.
> One is configured in hostspot mode and the other one is the client connected to the hostspot.
> 
> Kernel Version: 4.9.140-tegra aarch64
> Ubuntu distribution: Bionic
> The idea is to used hostapd and wpasupplicant daemon to set up the module and connect the card together.
> Wpa_supplicant and hostapd version V2.6.
> 
> I install all the drivers from intel and follow this tuto. https://wifi.hypergeek.net/you-too-can-have-a-sub-200-11ax-client/
> So I can see the wlan phy with ifconfig command line.
> When I try to launch hostapd in ax mode with your module I have the following mistake.
> ACS: Possibly channel configuration is invalid, please report this along with your config file. ACS: Failed to start wlan0: AP-DISABLED hostapd_free_hapd_data: Interface wlan0 wasn't started
> 
> Could you help to set up correctly hostapd ?
> 
> Best Regards
> 
> --
> Geoffroy LETOURNEUR
> Embedded Software Engineer,
> SSIC, Paris
> 
> Email: g.letourneur@samsung.com<mailto:g.letourneur@samsung.com>
> Tel: +33 6 45 14 24 32
> 
> 
> 


Hi

As far as i know the AX200 is not intended/can not be used as AP.

If you type "iw list" you should get a list of the capabilities of your
card.

On an ath9k based card this looks something like this:
valid interface combinations:
* #{ managed } <= 2048, #{ AP, mesh point } <= 8, #{ P2P-client, P2P-GO
} <= 1, #{ IBSS } <= 1,
total <= 2048, #channels <= 1, STA/AP BI must match, radar detect
widths: { 20 MHz (no HT), 20 MHz, 40 MHz }

BR
Matthias

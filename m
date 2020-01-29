Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A510C14C886
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 11:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgA2KJz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 05:09:55 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:6889 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgA2KJz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 05:09:55 -0500
X-Greylist: delayed 2545 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2020 05:09:54 EST
Received: from bsmtp2.bon.at (unknown [192.168.181.102])
        by bsmtp3.bon.at (Postfix) with ESMTPS id 486ynF4Q2Sz5tyv
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2020 10:27:29 +0100 (CET)
Received: from [192.168.100.138] (unknown [188.20.71.254])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 486ynD1lBfz5tl9;
        Wed, 29 Jan 2020 10:27:27 +0100 (CET)
Subject: Re: Strange inconsistant WiFi network behaviour
To:     JH <jupiter.hce@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        connman <connman@lists.01.org>
References: <CAA=hcWTEnYraPy5Un7a7ryeDBJmf0KoCU2VoJjr5LJWtbc9j_g@mail.gmail.com>
From:   Emil Petersky <emil.petersky@streamunlimited.com>
Message-ID: <5E314FFF.8040602@streamunlimited.com>
Date:   Wed, 29 Jan 2020 10:27:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <CAA=hcWTEnYraPy5Un7a7ryeDBJmf0KoCU2VoJjr5LJWtbc9j_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Try to increase distance from router or other WiFi device.

Best regards,

Emil

On 29.01.2020 10:21, JH wrote:
> Hi,
>
> I have 2 iMX6 devices running uBlox Lily WiFi, mrvl firmware
> sd8801_uapsta.bin in kernel 4.19.75. In my office, a WiFi router is
> just 1 meter away, the WiFi signal should not be a problem. One device
> could connect to the WiFi router well and stably, one could not, here
> were error messages:
>
> [  408.990029] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
> Invalid Sched_scan parameters
> .....................
>
> [56.986414] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
> Invalid Sched_scan parameter
>
> connmand[13469]:
> ../connman-1.35/src/service.c:preferred_tech_add_by_type() type 5
> service 0x119120 Telstra
> connmand[13469]: ../connman-1.35/src/service.c:auto_connect_service()
> preferred 1 sessions 0 reason auto
> connmand[13469]: ../connman-1.35/src/ntp.c:send_timeout() send timeout
> 2 (retries 0)
> connmand[13469]:
> ../connman-1.35/plugins/ofono.c:netreg_update_strength() /ubloxqmi_2
> Strength 80
> connmand[13469]: ../connman-1.35/src/ntp.c:send_timeout() send timeout
> 4 (retries 1)
> connmand[13469]: ../connman-1.35/plugins/wifi.c:throw_wifi_scan()
> device 0x118da8 0x116c78
> connmand[13469]:
> ../connman-1.35/src/device.c:connman_device_ref_debug() 0x118da8 ref 4
> by ../connman-1.35/plugins/wifi.c:1214:throw_wifi_scan()
> connmand[13469]:
> ../connman-1.35/src/device.c:connman_device_set_scanning() device
> 0x118da8 scanning 1
> connmand[13469]:
> ../connman-1.35/src/technology.c:__connman_technology_scan_started()
> device 0x118da8
> connmand[13469]: ../connman-1.35/plugins/wifi.c:autoscan_timeout() interval 27
> connmand[13469]: ../connman-1.35/plugins/wifi.c:interface_state() wifi
> 0x11a7c8 interface state 4
> connmand[13469]: ../connman-1.35/plugins/wifi.c:scan_started()
> connmand[13469]: ../connman-1.35/src/rtnl.c:rtnl_message() NEWLINK len
> 56 type 16 flags 0x0000 seq 0 pid 0
> connmand[13469]: ../connman-1.35/plugins/wifi.c:scan_finished()
> connmand[13469]: ../connman-1.35/plugins/wifi.c:interface_state() wifi
> 0x11a7c8 interface state 3
>
> Both devices were installed the same firmware and software, if it was
> firmware / software issues, both would not be able to connect to WiFi,
> as one device could connect to the office WiFi router well, it could
> not the WiFi router problem either.
>
> If I move the faulty one to my home, it could connect to my home WiFi,
> so the device does not have WiFi problem, that is really confusing,
> what could cause that kind problem and how to debug and fix it?
>
> Thank you.
>
> Kind regards,
>
> - jh
>

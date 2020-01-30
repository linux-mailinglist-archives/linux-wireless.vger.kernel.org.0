Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3834514D77C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 09:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgA3I23 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 03:28:29 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:43272 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgA3I22 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 03:28:28 -0500
Received: from [10.1.14.125] (vpn.streamunlimited.com [91.114.0.140])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 487YQf5mqMz5tlP;
        Thu, 30 Jan 2020 09:28:25 +0100 (CET)
Subject: Re: Strange inconsistant WiFi network behaviour
To:     JH <jupiter.hce@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        connman <connman@lists.01.org>
References: <CAA=hcWTEnYraPy5Un7a7ryeDBJmf0KoCU2VoJjr5LJWtbc9j_g@mail.gmail.com>
 <c76ff8bb50164eeb86feeb2eba76beac@bshg.com>
 <CAA=hcWT=RQBxB1-FT11awQz1SYK0qWp0PnvTSFrX9+V-nEgUnA@mail.gmail.com>
 <CAA=hcWRee3AeZatORMhvRTUwPVKPOnXwidu0cK4cbjwHw_opDw@mail.gmail.com>
From:   Emil Petersky <emil.petersky@streamunlimited.com>
Message-ID: <4f69d497-8887-b609-584d-200724ca9679@streamunlimited.com>
Date:   Thu, 30 Jan 2020 09:28:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAA=hcWRee3AeZatORMhvRTUwPVKPOnXwidu0cK4cbjwHw_opDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/01/2020 02:33, JH wrote:
> On 1/30/20, JH <jupiter.hce@gmail.com> wrote:
>> Thanks Emil and Jan,
>>
>> On 1/29/20, Ryll, Jan (GED-SDD2) <Jan.Ryll@bshg.com> wrote:
>>> Try to increase distance from router or other WiFi device.
>> Tried, but no avail.
> Sorry Emil, I had spoken too soon, it is connected now. Why that
> means, RF noise or interference from another device?

Hi, yes, maybe the RF input stage is saturated by very strong signal coming
from AP / 2nd device. I have seen this on many devices/APs, when they
are in (sub-) meter distance. Exact distance when devices starts to work
properly may vary with spread / tolerances of used RF parts...

And of course, some RF input stages are less sensitive (better designed)
as the others (across various APs / devices)

Best regards,

Emil

>>> there are WiFi routers like AVM which are implement the WiFi Stack in a
>>> stricter way than other routers or other WiFi chips-firmware.
>>> I mention this cause weh ad some issue with a cypress wifi firmware which
>>> leads to "sometimes" disconnect from routers. And we figured out that
>>> this
>>> was mostly the case with AVM. We are in contact with AVM in it turns out
>>> that the AVM router work proberly. The issues was with the cypress
>>> chipset
>>> firmware. Now we are in contact with cypress and they accepted the issue.
>>> So it is not always a connman problem :-) .
>> That really worries me, my WiFi router is TP-Link AC1200 dual band
>> router, it should have no problem for my device to connect it as I
>> mentioned I have two devices one could connected without any issues.
>> that definitely won't be my WiFi chip uBlox Lily issues, if it was,
>> the another unit would not be possible to connect to my WiFi router in
>> office.
>>
>> I am not saying it is connman problem or mwifiex problem or kernel
>> problem, what I like is to get  helps and clues from open source
>> communities to help me to debug and to find issues, it could be my
>> contributions as well if there could be potential open source bugs to
>> be found from my test, debug and report :-).
>>
>> Thank you.
>>
>> Kind regards,
>>
>> - jh
>>> -----Original Message-----
>>> From: JH <jupiter.hce@gmail.com>
>>> Sent: Wednesday, January 29, 2020 10:22 AM
>>> To: linux-wireless <linux-wireless@vger.kernel.org>; connman
>>> <connman@lists.01.org>
>>> Subject: Strange inconsistant WiFi network behaviour
>>>
>>> Hi,
>>>
>>> I have 2 iMX6 devices running uBlox Lily WiFi, mrvl firmware
>>> sd8801_uapsta.bin in kernel 4.19.75. In my office, a WiFi router is just
>>> 1
>>> meter away, the WiFi signal should not be a problem. One device could
>>> connect to the WiFi router well and stably, one could not, here were
>>> error
>>> messages:
>>>
>>> [  408.990029] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
>>> Invalid Sched_scan parameters
>>> .....................
>>>
>>> [56.986414] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
>>> Invalid Sched_scan parameter
>>>
>>> connmand[13469]:
>>> ../connman-1.35/src/service.c:preferred_tech_add_by_type() type 5 service
>>> 0x119120 Telstra
>>> connmand[13469]: ../connman-1.35/src/service.c:auto_connect_service()
>>> preferred 1 sessions 0 reason auto
>>> connmand[13469]: ../connman-1.35/src/ntp.c:send_timeout() send timeout
>>> 2 (retries 0)
>>> connmand[13469]:
>>> ../connman-1.35/plugins/ofono.c:netreg_update_strength() /ubloxqmi_2
>>> Strength 80
>>> connmand[13469]: ../connman-1.35/src/ntp.c:send_timeout() send timeout
>>> 4 (retries 1)
>>> connmand[13469]: ../connman-1.35/plugins/wifi.c:throw_wifi_scan()
>>> device 0x118da8 0x116c78
>>> connmand[13469]:
>>> ../connman-1.35/src/device.c:connman_device_ref_debug() 0x118da8 ref 4 by
>>> ../connman-1.35/plugins/wifi.c:1214:throw_wifi_scan()
>>> connmand[13469]:
>>> ../connman-1.35/src/device.c:connman_device_set_scanning() device
>>> 0x118da8 scanning 1
>>> connmand[13469]:
>>> ../connman-1.35/src/technology.c:__connman_technology_scan_started()
>>> device 0x118da8
>>> connmand[13469]: ../connman-1.35/plugins/wifi.c:autoscan_timeout()
>>> interval
>>> 27
>>> connmand[13469]: ../connman-1.35/plugins/wifi.c:interface_state() wifi
>>> 0x11a7c8 interface state 4
>>> connmand[13469]: ../connman-1.35/plugins/wifi.c:scan_started()
>>> connmand[13469]: ../connman-1.35/src/rtnl.c:rtnl_message() NEWLINK len
>>> 56 type 16 flags 0x0000 seq 0 pid 0
>>> connmand[13469]: ../connman-1.35/plugins/wifi.c:scan_finished()
>>> connmand[13469]: ../connman-1.35/plugins/wifi.c:interface_state() wifi
>>> 0x11a7c8 interface state 3
>>>
>>> Both devices were installed the same firmware and software, if it was
>>> firmware / software issues, both would not be able to connect to WiFi, as
>>> one device could connect to the office WiFi router well, it could not the
>>> WiFi router problem either.
>>>
>>> If I move the faulty one to my home, it could connect to my home WiFi, so
>>> the device does not have WiFi problem, that is really confusing, what
>>> could
>>> cause that kind problem and how to debug and fix it?
>>>
>>> Thank you.
>>>
>>> Kind regards,
>>>
>>> - jh
>>> _______________________________________________
>>> connman mailing list -- connman@lists.01.org To unsubscribe send an email
>>> to
>>> connman-leave@lists.01.org
>>>


-- 
Emil Petersky

________________________________________________________________________

StreamUnlimited Engineering GmbH
High Tech Campus Vienna, Gutheil-Schoder-Gasse 10, 1100 Vienna, Austria
Office: +43 1 667 2002 4679 Fax: +43 1 667 2002 4401
Mail to: emil.petersky@streamunlimited.com
Visit us: www.streamunlimited.com

Meet us at:
ISE - Amsterdam, 11 - 14 February, booth 7-X195
The Bristol Show - Bristol, 21 - 23 February
Embedded World - Nuremberg, 25 - 27 February, booth 3-501
Light & Building - Frankfurt, 8 - 13 March


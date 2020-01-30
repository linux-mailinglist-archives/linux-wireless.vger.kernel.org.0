Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5D14D500
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 02:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgA3Bd4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 20:33:56 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:46567 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgA3Bdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 20:33:55 -0500
Received: by mail-il1-f180.google.com with SMTP id t17so1622909ilm.13
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2020 17:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sjF8MV5jlD8RIuFH7pAzwYs9QIC1dgT4aNfCCOonikA=;
        b=YWbxjYbG+W0FyfW2W5V6qX6TsFWvQjtp5FkpLrWdYBeHIvXdxpeUuGdzCGhkgTSLU5
         6xMnDxGwn1P0g15vMIze/YlexpV4ZjiXvCLZ+1X2PHC/fae9lfKjiXeQBrpsyAMmzkRo
         exthNyGAknw7TftP7jpeAvqLMI/+jTyGP1u0ahmK4iMGEV8omcRfazhUTtpP94Ic46ko
         +xTLDP6qS6WJm6tpjNjxMWc3DbAaI7Va/4xG2S4nyNe15yIrdr7ILyu2HkHTOmIUfd3X
         z66muruXLUtG1yQ6urrWjBd6wl7ly3a3o+hXK/4l5OA8fWRx1Xw1ciYbduLavGicEa3U
         TMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sjF8MV5jlD8RIuFH7pAzwYs9QIC1dgT4aNfCCOonikA=;
        b=G4GopB4b4HUw6qFIAEucXs8qvkMTmfK4PJS7HB0nh7X0Tqoc1J2+bDryvsDcZ9+c5j
         kJjyiY3Z4TuKHKdtRVViTbt8W3FdFqqf9ojlM4GkZIzXMtksXE+as2OI/q/EpRQteEaO
         Avbz1ZZdGUvfRZgbY7V0/hnh+9igctz/LEntCOcuWYlaMKpK1DrGF4xmkAtiB5MYbMs3
         XYPnvv8wZ+OjihHoMNFl/nriOBj+T2ltZbuBO+7624hBoOrLdtw6uv69eTqsZL1ygmCv
         GcP/owVAUxn2w3mkr16u9IGhORt2NOSPYQSeAVtc4Ga+k9zfmWIfaE2BT9oC0W0gare/
         16dg==
X-Gm-Message-State: APjAAAXvs5pb2ljLGhPnky6dZ26YeLONm57Xkin8MGnm+czta9P/mZlD
        +/CPXGQIPLPLbbkKU5t1PuuLDOdsdc37C6zjSaQLwE72
X-Google-Smtp-Source: APXvYqwtNdsAiXRJeabku7g674X6KUktdtFAMHSSiRuOHQ2whlBUBmXlYauqNV3ypvXDdEALiA13e4hkolOjB0uIQnI=
X-Received: by 2002:a92:390d:: with SMTP id g13mr2112636ila.53.1580348034923;
 Wed, 29 Jan 2020 17:33:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5d0d:0:0:0:0:0 with HTTP; Wed, 29 Jan 2020 17:33:54
 -0800 (PST)
In-Reply-To: <CAA=hcWT=RQBxB1-FT11awQz1SYK0qWp0PnvTSFrX9+V-nEgUnA@mail.gmail.com>
References: <CAA=hcWTEnYraPy5Un7a7ryeDBJmf0KoCU2VoJjr5LJWtbc9j_g@mail.gmail.com>
 <c76ff8bb50164eeb86feeb2eba76beac@bshg.com> <CAA=hcWT=RQBxB1-FT11awQz1SYK0qWp0PnvTSFrX9+V-nEgUnA@mail.gmail.com>
From:   JH <jupiter.hce@gmail.com>
Date:   Thu, 30 Jan 2020 12:33:54 +1100
Message-ID: <CAA=hcWRee3AeZatORMhvRTUwPVKPOnXwidu0cK4cbjwHw_opDw@mail.gmail.com>
Subject: Re: Strange inconsistant WiFi network behaviour
To:     Emil Petersky <emil.petersky@streamunlimited.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        connman <connman@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/30/20, JH <jupiter.hce@gmail.com> wrote:
> Thanks Emil and Jan,
>
> On 1/29/20, Ryll, Jan (GED-SDD2) <Jan.Ryll@bshg.com> wrote:
>> Try to increase distance from router or other WiFi device.
>
> Tried, but no avail.

Sorry Emil, I had spoken too soon, it is connected now. Why that
means, RF noise or interference from another device?

>> there are WiFi routers like AVM which are implement the WiFi Stack in a
>> stricter way than other routers or other WiFi chips-firmware.
>> I mention this cause weh ad some issue with a cypress wifi firmware which
>> leads to "sometimes" disconnect from routers. And we figured out that
>> this
>> was mostly the case with AVM. We are in contact with AVM in it turns out
>> that the AVM router work proberly. The issues was with the cypress
>> chipset
>> firmware. Now we are in contact with cypress and they accepted the issue.
>> So it is not always a connman problem :-) .
>
> That really worries me, my WiFi router is TP-Link AC1200 dual band
> router, it should have no problem for my device to connect it as I
> mentioned I have two devices one could connected without any issues.
> that definitely won't be my WiFi chip uBlox Lily issues, if it was,
> the another unit would not be possible to connect to my WiFi router in
> office.
>
> I am not saying it is connman problem or mwifiex problem or kernel
> problem, what I like is to get  helps and clues from open source
> communities to help me to debug and to find issues, it could be my
> contributions as well if there could be potential open source bugs to
> be found from my test, debug and report :-).
>
> Thank you.
>
> Kind regards,
>
> - jh
>>
>> -----Original Message-----
>> From: JH <jupiter.hce@gmail.com>
>> Sent: Wednesday, January 29, 2020 10:22 AM
>> To: linux-wireless <linux-wireless@vger.kernel.org>; connman
>> <connman@lists.01.org>
>> Subject: Strange inconsistant WiFi network behaviour
>>
>> Hi,
>>
>> I have 2 iMX6 devices running uBlox Lily WiFi, mrvl firmware
>> sd8801_uapsta.bin in kernel 4.19.75. In my office, a WiFi router is just
>> 1
>> meter away, the WiFi signal should not be a problem. One device could
>> connect to the WiFi router well and stably, one could not, here were
>> error
>> messages:
>>
>> [  408.990029] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
>> Invalid Sched_scan parameters
>> .....................
>>
>> [56.986414] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
>> Invalid Sched_scan parameter
>>
>> connmand[13469]:
>> ../connman-1.35/src/service.c:preferred_tech_add_by_type() type 5 service
>> 0x119120 Telstra
>> connmand[13469]: ../connman-1.35/src/service.c:auto_connect_service()
>> preferred 1 sessions 0 reason auto
>> connmand[13469]: ../connman-1.35/src/ntp.c:send_timeout() send timeout
>> 2 (retries 0)
>> connmand[13469]:
>> ../connman-1.35/plugins/ofono.c:netreg_update_strength() /ubloxqmi_2
>> Strength 80
>> connmand[13469]: ../connman-1.35/src/ntp.c:send_timeout() send timeout
>> 4 (retries 1)
>> connmand[13469]: ../connman-1.35/plugins/wifi.c:throw_wifi_scan()
>> device 0x118da8 0x116c78
>> connmand[13469]:
>> ../connman-1.35/src/device.c:connman_device_ref_debug() 0x118da8 ref 4 by
>> ../connman-1.35/plugins/wifi.c:1214:throw_wifi_scan()
>> connmand[13469]:
>> ../connman-1.35/src/device.c:connman_device_set_scanning() device
>> 0x118da8 scanning 1
>> connmand[13469]:
>> ../connman-1.35/src/technology.c:__connman_technology_scan_started()
>> device 0x118da8
>> connmand[13469]: ../connman-1.35/plugins/wifi.c:autoscan_timeout()
>> interval
>> 27
>> connmand[13469]: ../connman-1.35/plugins/wifi.c:interface_state() wifi
>> 0x11a7c8 interface state 4
>> connmand[13469]: ../connman-1.35/plugins/wifi.c:scan_started()
>> connmand[13469]: ../connman-1.35/src/rtnl.c:rtnl_message() NEWLINK len
>> 56 type 16 flags 0x0000 seq 0 pid 0
>> connmand[13469]: ../connman-1.35/plugins/wifi.c:scan_finished()
>> connmand[13469]: ../connman-1.35/plugins/wifi.c:interface_state() wifi
>> 0x11a7c8 interface state 3
>>
>> Both devices were installed the same firmware and software, if it was
>> firmware / software issues, both would not be able to connect to WiFi, as
>> one device could connect to the office WiFi router well, it could not the
>> WiFi router problem either.
>>
>> If I move the faulty one to my home, it could connect to my home WiFi, so
>> the device does not have WiFi problem, that is really confusing, what
>> could
>> cause that kind problem and how to debug and fix it?
>>
>> Thank you.
>>
>> Kind regards,
>>
>> - jh
>> _______________________________________________
>> connman mailing list -- connman@lists.01.org To unsubscribe send an email
>> to
>> connman-leave@lists.01.org
>>
>

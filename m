Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91B14D445
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 01:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgA3AEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 19:04:08 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:40013 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgA3AEI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 19:04:08 -0500
Received: by mail-io1-f46.google.com with SMTP id x1so1892818iop.7
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2020 16:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N2HzLYaUkJlpq5f346L/ENXDmRQREL1ljiVLi5Ox/KE=;
        b=JIcXa8F1blkSxO5MSs5K5V7CFwdg8IGE8OqgX0/vfbiH4jRPFAH6KaYKPmZ5xCGXmw
         hcmysqm8iWwnJOCiA6XLqYuG1+aGswHwubf6lA/JvRZ7N3dTttq/uCitJSVlfUMBG4gN
         uuP90ix05+EdQQVJQb9PJXMz11x7JQMAOHH+Fs5cENmj6b5QqcGPWc+3hZbpabTdNqeC
         Vb/Xv7U1PPP4qWqFteVodPAa4YRw9SN0CIRMGQNXeYS+bzmBWwH6klmUR7S9qdC2ijVd
         zJzhKhjDK1QWDiFSF+m9Ex6SxOQSoAJMq2RFa6R8WZBzP2ztUk+AIKwokG2DM++cHi+D
         9Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N2HzLYaUkJlpq5f346L/ENXDmRQREL1ljiVLi5Ox/KE=;
        b=pPpW5+2vLF7ZPFn/3SOQeTJWwXxfC8twEXH8V/mAL8jtQDyAsUDa+aAkqtrKqi2KQA
         shnlsyH0H3oBhOlAaP0TWxFHumu2N8Va+ZxVPd+qiFF6CS9Ve2OsjRBGQIi7SyFaZ0Ju
         zedvpQvD+mwmivIZ21tooZjw5jLKKHm9O6zyyTvc5Sc8s7A+jMbhjgwV1HDNWxtogHSN
         6m4zCDoGMTqfN9VUotXETmbM9E0msjHmIWeObM2xmU2Uz0gvFRYio8lqaiW9jHt4hd+Z
         KvEJGQUPXLJBn47BICHSWaGAqs/vZH8NQtWPQsBHQxxw8ToOuv8NgLXTaC8LumEJXuWQ
         UOgQ==
X-Gm-Message-State: APjAAAW4n1AbUfu2u7UNCWvT/gzBNHLRfeY6XEvSyY90x81opG8m9TjF
        GlIKVBi6xmtu3CbwA0TckhGr8QKdIrk+esf+2Qm0dFIk
X-Google-Smtp-Source: APXvYqzSbWdXQlNr5II+49EBfZMHJvX3TKNxljXYqp3wUPoHgFPx1nlmL2ZlTPttmwjRcK9iGiIf0fDF7Vy/yNR50lk=
X-Received: by 2002:a5d:8043:: with SMTP id b3mr1906789ior.192.1580342647004;
 Wed, 29 Jan 2020 16:04:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5d0d:0:0:0:0:0 with HTTP; Wed, 29 Jan 2020 16:04:06
 -0800 (PST)
In-Reply-To: <c76ff8bb50164eeb86feeb2eba76beac@bshg.com>
References: <CAA=hcWTEnYraPy5Un7a7ryeDBJmf0KoCU2VoJjr5LJWtbc9j_g@mail.gmail.com>
 <c76ff8bb50164eeb86feeb2eba76beac@bshg.com>
From:   JH <jupiter.hce@gmail.com>
Date:   Thu, 30 Jan 2020 11:04:06 +1100
Message-ID: <CAA=hcWT=RQBxB1-FT11awQz1SYK0qWp0PnvTSFrX9+V-nEgUnA@mail.gmail.com>
Subject: Re: Strange inconsistant WiFi network behaviour
To:     "Ryll, Jan (GED-SDD2)" <Jan.Ryll@bshg.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        connman <connman@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks Emil and Jan,

On 1/29/20, Ryll, Jan (GED-SDD2) <Jan.Ryll@bshg.com> wrote:
> Try to increase distance from router or other WiFi device.

Tried, but no avail.

> there are WiFi routers like AVM which are implement the WiFi Stack in a
> stricter way than other routers or other WiFi chips-firmware.
> I mention this cause weh ad some issue with a cypress wifi firmware which
> leads to "sometimes" disconnect from routers. And we figured out that this
> was mostly the case with AVM. We are in contact with AVM in it turns out
> that the AVM router work proberly. The issues was with the cypress chipset
> firmware. Now we are in contact with cypress and they accepted the issue.
> So it is not always a connman problem :-) .

That really worries me, my WiFi router is TP-Link AC1200 dual band
router, it should have no problem for my device to connect it as I
mentioned I have two devices one could connected without any issues.
that definitely won't be my WiFi chip uBlox Lily issues, if it was,
the another unit would not be possible to connect to my WiFi router in
office.

I am not saying it is connman problem or mwifiex problem or kernel
problem, what I like is to get  helps and clues from open source
communities to help me to debug and to find issues, it could be my
contributions as well if there could be potential open source bugs to
be found from my test, debug and report :-).

Thank you.

Kind regards,

- jh
>
> -----Original Message-----
> From: JH <jupiter.hce@gmail.com>
> Sent: Wednesday, January 29, 2020 10:22 AM
> To: linux-wireless <linux-wireless@vger.kernel.org>; connman
> <connman@lists.01.org>
> Subject: Strange inconsistant WiFi network behaviour
>
> Hi,
>
> I have 2 iMX6 devices running uBlox Lily WiFi, mrvl firmware
> sd8801_uapsta.bin in kernel 4.19.75. In my office, a WiFi router is just 1
> meter away, the WiFi signal should not be a problem. One device could
> connect to the WiFi router well and stably, one could not, here were error
> messages:
>
> [  408.990029] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
> Invalid Sched_scan parameters
> .....................
>
> [56.986414] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
> Invalid Sched_scan parameter
>
> connmand[13469]:
> ../connman-1.35/src/service.c:preferred_tech_add_by_type() type 5 service
> 0x119120 Telstra
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
> ../connman-1.35/src/device.c:connman_device_ref_debug() 0x118da8 ref 4 by
> ../connman-1.35/plugins/wifi.c:1214:throw_wifi_scan()
> connmand[13469]:
> ../connman-1.35/src/device.c:connman_device_set_scanning() device
> 0x118da8 scanning 1
> connmand[13469]:
> ../connman-1.35/src/technology.c:__connman_technology_scan_started()
> device 0x118da8
> connmand[13469]: ../connman-1.35/plugins/wifi.c:autoscan_timeout() interval
> 27
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
> firmware / software issues, both would not be able to connect to WiFi, as
> one device could connect to the office WiFi router well, it could not the
> WiFi router problem either.
>
> If I move the faulty one to my home, it could connect to my home WiFi, so
> the device does not have WiFi problem, that is really confusing, what could
> cause that kind problem and how to debug and fix it?
>
> Thank you.
>
> Kind regards,
>
> - jh
> _______________________________________________
> connman mailing list -- connman@lists.01.org To unsubscribe send an email to
> connman-leave@lists.01.org
>

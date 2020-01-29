Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A056614C7F6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 10:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgA2JVe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 04:21:34 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:38167 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgA2JVe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 04:21:34 -0500
Received: by mail-io1-f51.google.com with SMTP id s24so16253820iog.5
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2020 01:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5tcVQVGb+XudIjTVD8K0YOqj3inPAiJRCq9yYTrXUNk=;
        b=H0lY4OjgU+tFa3xpo5SOGlbYe0r6tTgBLaHUiQWhfl/FSbaVDsJf8wmuNcb7m/3Qlo
         F/GuFVZgFl/q1ijWLUKR/PlBc8DaHZE3+3Sz7gu9q4e1OYLAfImN6boLI3WnWZqHal9X
         gcAhUBd0tomgw3a+8kEMdhcTMh3V/JaKLYa7rS2cIMHjALBVDT+MNM9ja9Q5el50G4B0
         E/hSLAOBn9b2qMI+yulfr3QJFXNMXXr5GCfD+UDy/MPAZ2S9wrpYO2k1OWSHayIi2DWC
         dEm2gG1hOh4A0Yt27P+l5MfnooIoUqbz7Evm6yih6I83uItc63h8ixK6+E84AAIMGsIY
         W8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5tcVQVGb+XudIjTVD8K0YOqj3inPAiJRCq9yYTrXUNk=;
        b=YbsVgVjNsOC4HhyjEuR9OnkNnUMJeRQDyYQ7WnJqWlZvbAP5uUPfIYt4QR9Q5sDfd3
         JMURxMQKo3+l25tUS0JVk5hgM2Myv6PXhUq800mnjgbEh6u7FJoJPpSzvlkpWkio4p9+
         hrL/MgfnTzJvMrDY7F5kw0aQ9EBKq2A2jQs3Y9tK6cPRBiwQHmfjCPvNsBJUHh44eXmK
         zCDZpEl9JeINQXOfU+SkNlnmxIbsxBlwLNODAZDAmCaWOLI1kdXGIpRy6Ts7puILztAs
         0fwUaF2taRfSKydm57hC9PhYGrvCC85EEHONo6rtVmXyvvox0lSBLbzqjaYfeS7wVK29
         IrCQ==
X-Gm-Message-State: APjAAAXOHjao9GvRIhjROi9S5bQj9+APsOwI1N5cK2NIr5iKAXShWizH
        GUsUInSs6BJdZPPNrPgadX4h0pEGOcGRsC+u53rwITDXQno=
X-Google-Smtp-Source: APXvYqxZ+0TC4AaJcZUbIGe96FUbTYMPSBtMW2ZVqgaSqRq1C+zhqNKzHib6iZuFtLdJ1WuWycm4O9WiE0r3+mNQjdg=
X-Received: by 2002:a6b:d912:: with SMTP id r18mr19544315ioc.306.1580289693257;
 Wed, 29 Jan 2020 01:21:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5d0d:0:0:0:0:0 with HTTP; Wed, 29 Jan 2020 01:21:32
 -0800 (PST)
From:   JH <jupiter.hce@gmail.com>
Date:   Wed, 29 Jan 2020 20:21:32 +1100
Message-ID: <CAA=hcWTEnYraPy5Un7a7ryeDBJmf0KoCU2VoJjr5LJWtbc9j_g@mail.gmail.com>
Subject: Strange inconsistant WiFi network behaviour
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        connman <connman@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have 2 iMX6 devices running uBlox Lily WiFi, mrvl firmware
sd8801_uapsta.bin in kernel 4.19.75. In my office, a WiFi router is
just 1 meter away, the WiFi signal should not be a problem. One device
could connect to the WiFi router well and stably, one could not, here
were error messages:

[  408.990029] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameters
.....................

[56.986414] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
Invalid Sched_scan parameter

connmand[13469]:
../connman-1.35/src/service.c:preferred_tech_add_by_type() type 5
service 0x119120 Telstra
connmand[13469]: ../connman-1.35/src/service.c:auto_connect_service()
preferred 1 sessions 0 reason auto
connmand[13469]: ../connman-1.35/src/ntp.c:send_timeout() send timeout
2 (retries 0)
connmand[13469]:
../connman-1.35/plugins/ofono.c:netreg_update_strength() /ubloxqmi_2
Strength 80
connmand[13469]: ../connman-1.35/src/ntp.c:send_timeout() send timeout
4 (retries 1)
connmand[13469]: ../connman-1.35/plugins/wifi.c:throw_wifi_scan()
device 0x118da8 0x116c78
connmand[13469]:
../connman-1.35/src/device.c:connman_device_ref_debug() 0x118da8 ref 4
by ../connman-1.35/plugins/wifi.c:1214:throw_wifi_scan()
connmand[13469]:
../connman-1.35/src/device.c:connman_device_set_scanning() device
0x118da8 scanning 1
connmand[13469]:
../connman-1.35/src/technology.c:__connman_technology_scan_started()
device 0x118da8
connmand[13469]: ../connman-1.35/plugins/wifi.c:autoscan_timeout() interval 27
connmand[13469]: ../connman-1.35/plugins/wifi.c:interface_state() wifi
0x11a7c8 interface state 4
connmand[13469]: ../connman-1.35/plugins/wifi.c:scan_started()
connmand[13469]: ../connman-1.35/src/rtnl.c:rtnl_message() NEWLINK len
56 type 16 flags 0x0000 seq 0 pid 0
connmand[13469]: ../connman-1.35/plugins/wifi.c:scan_finished()
connmand[13469]: ../connman-1.35/plugins/wifi.c:interface_state() wifi
0x11a7c8 interface state 3

Both devices were installed the same firmware and software, if it was
firmware / software issues, both would not be able to connect to WiFi,
as one device could connect to the office WiFi router well, it could
not the WiFi router problem either.

If I move the faulty one to my home, it could connect to my home WiFi,
so the device does not have WiFi problem, that is really confusing,
what could cause that kind problem and how to debug and fix it?

Thank you.

Kind regards,

- jh

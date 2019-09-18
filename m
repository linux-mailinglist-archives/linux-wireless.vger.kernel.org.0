Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F4BB58D4
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 02:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfIRAEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 20:04:08 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:38652 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfIRAEI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 20:04:08 -0400
Received: by mail-io1-f41.google.com with SMTP id k5so11934067iol.5
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 17:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzlsa+dU6pIx0UVCy2B0sV6TKqvzDjjEVTiUvh+8dck=;
        b=UXoDq+OMxI1FLrpk6W22aBN2H1ZeHMd2K/4ZKUtoIgsSkTfusrLB8lwI696QBd/eLF
         lmciLzguBjtk0E9mXg5uxfti4+LylpbtpqNwmlWingX35jlB0kaSmYvXozQ0dMVUeKo/
         niJdoy2hZLakIyd8XLIc/Wkg4zPakVGV7sZnzUtcBP4lu0erRQ8rg2mQn65/kT+eoDTk
         Uc80dZBO97joEpkUCmHF4CTuRVKsLnQBQR7X/VdTmf3o9ophN5BNVO86DoOCKYu0bcG3
         MKyCQoHb51Yd0uBW4sielpJw1q64IZ1qMl93U/hwHtFBTW+5EML2FSfpmd4+tJYo0nI5
         zzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzlsa+dU6pIx0UVCy2B0sV6TKqvzDjjEVTiUvh+8dck=;
        b=kL96rnr4LkaCydzIRqithrGBiuUVS2rntFaVNUlaibVSgMgqCq8PblvQXjR8sK+Zx1
         0VVdag1eJ93nLLyMlbkVEgQmB9lXZsPI3bV4ZSr2qfQSp6bLln1H16BdQLJ556tBzPow
         /khc2/NW5X9WIxrFTD9LdlvgTDTuIvgUo6Z5LUGlqQxWkXYC3yvuS2qMwX+/IJMBurSI
         aO/uoJ2ljbHQdTS2Z0Tuilwj5Tih/8CtOsI/X+ULXt8gF6Aol55r3i6ZnCuwY29jG17V
         Ol15ATHmGZ4SGSwhsrElJ3GgYDEU3WI+G6UC2OzAgIevKmRdckCOoP937agBPvtASaIg
         h1XA==
X-Gm-Message-State: APjAAAUpvxXsiJaqVy3yf7JVfwESCHJqelRTtsQVjl2erGjsWFXGwBvp
        VSlOxoL9RDFqpTqNes9LfYUDVPOWcjdc04pbAGtBMqMcjyE=
X-Google-Smtp-Source: APXvYqwUgV+SILkJXBwafn/CN5HD2ON6Nl1rTEZZkaEYb3gIszguvX/Ch1Aajzu6uwZkplEsvTpn9ub8kmpBzF7dl9E=
X-Received: by 2002:a05:6638:a19:: with SMTP id 25mr1680736jan.27.1568765041834;
 Tue, 17 Sep 2019 17:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKzd-8jgQWTO2w589gMVJm3CaU-15wUER+fsqpYJJSeZL4RPg@mail.gmail.com>
 <CALLGbRKUZmZzBh9=YpJ+r_ts8aY+HXy159oviihSgqMEofOCRQ@mail.gmail.com>
 <CAKKzd-8aRFtdkK+E4-sXBid9jP_sAr0bGbdLYJ=sjb4iCsTAcw@mail.gmail.com> <7158fc76fe5ec091633b36b3218a8586960c19e2.camel@redhat.com>
In-Reply-To: <7158fc76fe5ec091633b36b3218a8586960c19e2.camel@redhat.com>
From:   David Ho <davidkwho@gmail.com>
Date:   Tue, 17 Sep 2019 17:03:35 -0700
Message-ID: <CAKKzd-9zK0ZKWksyp7S+myGrtbc3s4npEhy02SS-wfLCS0tKSw@mail.gmail.com>
Subject: Re: Linux wireless times out at Google Starbucks location
To:     Dan Williams <dcbw@redhat.com>
Cc:     Steve deRosier <derosier@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 17, 2019 at 2:01 PM Dan Williams <dcbw@redhat.com> wrote:
>
> If you're able to get the wpa_supplicant logs, that would be useful as
> well.
>

I captured 2 minutes of log in /var/log/syslog, based on my crude
judgment of where the connection request began.

I appreciate if someone can update me on this issue; I hope my effort
is not going to waste (I'm just an ML researcher trying to make Ubuntu
work at my favorite coffee shop =)

Thanks, David

Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: Already scanning -
Reschedule the incoming scan req
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: Setting scan
request: 1.000000 sec
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: RTM_NEWLINK: ifi_index=3
ifname=wlo1 wext ifi_family=0 ifi_flags=0x1003 ([UP])
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: nl80211: Drv Event 34
(NL80211_CMD_NEW_SCAN_RESULTS) received for wlo1
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: nl80211: New scan
results available
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: nl80211: Scan probed for SSID ''
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: nl80211: Scan included
frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462
2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540
5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_RESULTS
(3) received
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: Scan completed in
3.488974 seconds
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: nl80211: Received scan
results (15 BSSes)
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: BSS: Start scan
result update 7
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 43
BSSID 9c:3d:cf:16:4c:1f SSID 'Nova nails' freq 2412
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/43'
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 44
BSSID 38:2c:4a:5d:32:90 SSID 'Best_2-4' freq 2437
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/44'
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 45
BSSID 8a:15:04:3d:a6:d3 SSID
'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00' freq 2457
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/45'
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 46
BSSID 6c:ca:08:0e:c9:90 SSID 'ATT6N5A5d2' freq 2412
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/46'
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: BSS: 60:fe:20:7d:fd:46
changed freq 2412 --> 2437
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: BSS: Remove id 36
BSSID f8:f5:32:35:cb:80 SSID 'VTA' due to no match in scan
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus: Unregister BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/36'
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: BSS: Remove id 8
BSSID 10:93:97:58:5c:b0 SSID 'ATTpdSDEa2' due to no match in scan
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus: Unregister BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/8'
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: BSS: Remove id 10
BSSID 10:93:97:4f:c0:33 SSID '' due to no match in scan
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus: Unregister BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/10'
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: BSS: last_scan_res_used=15/32
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: Scan-only results received
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: message repeated 5
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1: Radio work
'scan'@0x55b76d514430 done in 3.988132 seconds
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('scan'@0x55b76d514430: num_active_works --> 0
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/0
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/1
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/6
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/5
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/7
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/11
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/9
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/15
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/39
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/40
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/35
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/43) [s]
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/44) [s]
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/45) [s]
Sep 17 16:40:53 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/46) [s]
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: wlo1: State:
DISCONNECTED -> SCANNING
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: wlo1: Starting AP scan
for wildcard SSID
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: 1568763654.073043: Scan
SSID - hexdump_ascii(len=16):
Sep 17 16:40:54 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: 1568763654.073414:
nl80211: Scan SSID - hexdump_ascii(len=16):
Sep 17 16:40:54 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: 1568763654.073437:
nl80211: Scan SSID - hexdump_ascii(len=0): [NULL]
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: wlo1: Add radio work
'scan'@0x55b76d523030
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: wlo1: First radio work
item in the queue - schedule start immediately
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: wlo1: Starting radio
work 'scan'@0x55b76d523030 after 0.000036 second wait
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: wlo1: nl80211: scan request
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: nl80211: Scan extra IEs
- hexdump(len=10): 7f 08 00 00 00 00 00 00 00 40
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: Scan requested (ret=0) -
scan timeout 30 seconds
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: nl80211: Drv Event 33
(NL80211_CMD_TRIGGER_SCAN) received for wlo1
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: wlo1: nl80211: Scan trigger
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_STARTED
(48) received
Sep 17 16:40:54 mumble15 wpa_supplicant[892]: wlo1: Own scan request
started a scan in 0.000425 seconds
Sep 17 16:40:54 mumble15 NetworkManager[3656]: <info>
[1568763654.5758] device (wlo1): supplicant interface state: ready ->
scanning
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Drv Event 34
(NL80211_CMD_NEW_SCAN_RESULTS) received for wlo1
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: nl80211: New scan
results available
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Scan probed for
SSID 'Google Starbucks'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Scan probed for SSID ''
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Scan included
frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462
2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540
5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_RESULTS
(3) received
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Scan completed in
3.484502 seconds
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Received scan
results (25 BSSes)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: BSS: Start scan
result update 8
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 47
BSSID 24:de:c6:cb:2a:d9 SSID '' freq 5765
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/47'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 48
BSSID fa:f5:32:35:cb:81 SSID 'VTA Guest' freq 2412
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/48'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 49
BSSID 8a:15:04:3d:a6:d4 SSID
'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00' freq 2457
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/49'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 50
BSSID 8a:15:04:3d:a6:d1 SSID '\x00\x00\x00\x00\x00\x00\x00' freq 2457
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/50'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 51
BSSID 14:59:c0:ab:a2:20 SSID 'NETGEAR36' freq 2462
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/51'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 52
BSSID f4:6b:ef:23:a9:3e SSID 'MySpectrumWiFi38-2G' freq 2462
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/52'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: BSS: Remove id 41
BSSID 10:93:97:4f:c0:30 SSID 'NCFC' due to no match in scan
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus: Unregister BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/41'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: BSS: Remove id 42
BSSID e8:ed:05:6a:83:d0 SSID 'Quick Wok SD' due to no match in scan
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus: Unregister BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/42'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: BSS: Remove id 33
BSSID c8:d7:19:1f:c2:bc SSID 'PureMotion' due to no match in scan
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus: Unregister BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/33'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: BSS: last_scan_res_used=25/32
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: New scan results
available (own=1 ext=0)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: message repeated 3
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: 1568763658.064449:   *
SSID - hexdump_ascii(len=16):
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP
9c:3d:cf:16:4c:1f type 0 added
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP
38:2c:4a:5d:32:90 type 0 added
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: message repeated 2
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP
06:93:97:4f:c0:33 type 0 added
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP
e8:ed:05:6a:83:d5 type 0 added
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP
88:71:b1:5e:c9:f0 type 0 added
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: message repeated 2
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP
e6:f5:32:35:cb:83 type 0 added
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP
6c:ca:08:0e:c9:90 type 0 added
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP
14:59:c0:ab:a2:20 type 0 added
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP[0]
9c:3d:cf:16:4c:1f type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP[1]
38:2c:4a:5d:32:90 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP[2]
06:93:97:4f:c0:33 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP[3]
e8:ed:05:6a:83:d5 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP[4]
88:71:b1:5e:c9:f0 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP[5]
e6:f5:32:35:cb:83 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP[6]
6c:ca:08:0e:c9:90 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: AP[7]
14:59:c0:ab:a2:20 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Radio work
'scan'@0x55b76d523030 done in 3.989617 seconds
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('scan'@0x55b76d523030: num_active_works --> 0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Selecting BSS from
priority group 0
Sep 17 16:40:58 mumble15 kernel: [24580.730341] wlo1: authenticate
with 24:de:c6:cb:2a:d8
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 0:
c6:c3:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1111 level=-59 freq=5745
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 1:
c4:b3:01:de:59:c3 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1111
level=-62 freq=5745
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 2:
24:de:c6:cb:2a:d9 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-40 freq=5765
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 3:
24:de:c6:cb:2a:da ssid='notes' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-40 freq=5765
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 4:
c6:c2:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1511 level=-53 freq=2437
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 5:
c4:b3:01:de:59:c2 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1511
level=-53 freq=2437
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 6:
00:1d:d5:56:90:70 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0xc11
level=-61 freq=2462
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 7:
9c:d6:43:2c:72:98 ssid='Ecenter' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-78 freq=5180
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 8:
9c:3d:cf:16:4c:1f ssid='Nova nails' wpa_ie_len=0 rsn_ie_len=20
caps=0x411 level=-74 freq=2412  wps
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 9:
38:2c:4a:5d:32:90 ssid='Best_2-4' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-77 freq=2437  wps
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 10:
8a:15:04:3d:a6:d3 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-77 freq=2457
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 11:
06:93:97:4f:c0:33 ssid='NCFC' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-85 freq=5180  wps
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 12:
f8:f5:32:35:cb:83 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-85 freq=5745
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 13:
e8:ed:05:6a:83:d5 ssid='Quick Wok SD-5G' wpa_ie_len=0 rsn_ie_len=20
caps=0x831 level=-82 freq=5220  wps
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 14:
88:71:b1:5e:c9:f0 ssid='ATTg6YdfPi' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-75 freq=2412  wps
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 15:
fa:f5:32:35:cb:81 ssid='VTA Guest' wpa_ie_len=26 rsn_ie_len=24
caps=0x1411 level=-78 freq=2412
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 16:
8a:15:04:3d:a6:d4 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-79 freq=2457
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 17:
e6:f5:32:35:cb:83 ssid='VTA' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-87 freq=5745  wps
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 18:
6c:ca:08:0e:c9:90 ssid='ATT6N5A5d2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2412  wps
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 19:
8a:15:04:3d:a6:d1 ssid='\x00\x00\x00\x00\x00\x00\x00' wpa_ie_len=26
rsn_ie_len=24 caps=0x1431 level=-80 freq=2457
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 20:
60:fe:20:7d:fd:46 ssid='ATT913' wpa_ie_len=28 rsn_ie_len=24 caps=0x411
level=-84 freq=2437
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 21:
14:59:c0:ab:a2:20 ssid='NETGEAR36' wpa_ie_len=0 rsn_ie_len=26
caps=0x1511 level=-86 freq=2462  wps
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 22:
f4:6b:ef:23:a9:3e ssid='MySpectrumWiFi38-2G' wpa_ie_len=0
rsn_ie_len=20 caps=0x431 level=-91 freq=2462
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: 23:
24:de:c6:cb:2a:d8 ssid='Google Starbucks' wpa_ie_len=0 rsn_ie_len=0
caps=0x501 level=-41 freq=5765
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    allow in non-WPA/WPA2
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:    selected BSS
24:de:c6:cb:2a:d8 ssid='Google Starbucks'
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Considering
connect request: reassociate: 1  selected: 24:de:c6:cb:2a:d8  bssid:
00:00:00:00:00:00  pending: 00:00:00:00:00:00  wpa_state: SCANNING
ssid=0x55b76d53e670  current_ssid=0x55b76d53e670
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Request
association with 24:de:c6:cb:2a:d8
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: TDLS: TDLS is allowed in
the target BSS
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: TDLS: TDLS channel
switch allowed in the target BSS
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Add radio work
'sme-connect'@0x55b76d4fe5e0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: First radio work
item in the queue - schedule start immediately
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Starting radio
work 'sme-connect'@0x55b76d4fe5e0 after 0.000031 second wait
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Automatic auth_alg
selection: 0x1
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing AP WPA IE
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing AP RSN IE
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing own WPA/RSN IE
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: FT: Stored MDIE and FTIE
from (Re)Association Response - hexdump(len=0):
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: RRM: Determining whether
RRM can be used - device support: 0x10
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: RRM: No RRM in network
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Cancelling scan request
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: SME: Trying to
authenticate with 24:de:c6:cb:2a:d8 (SSID='Google Starbucks' freq=5765
MHz)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: State: SCANNING ->
AUTHENTICATING
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: EAPOL: External
notification - EAP success=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: EAPOL: External
notification - EAP fail=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portControl=ForceAuthorized
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Determining shared
radio frequencies (max len 1)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Shared frequencies
(len=0): completed iteration
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Authenticate (ifindex=3)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * bssid=24:de:c6:cb:2a:d8
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * freq=5765
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * IEs - hexdump(len=0): [NULL]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * Auth Type 0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Authentication
request send successfully
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: RTM_NEWLINK: ifi_index=3
ifname=wlo1 wext ifi_family=0 ifi_flags=0x1003 ([UP])
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/47) [s]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:40:58 mumble15 NetworkManager[3656]: <info>
[1568763658.5641] device (wlo1): supplicant interface state: scanning
-> authenticating
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/48) [s]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/49) [s]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/50) [s]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/51) [s]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/52) [s]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Drv Event 19
(NL80211_CMD_NEW_STATION) received for wlo1
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: New station
24:de:c6:cb:2a:d8
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Drv Event 37
(NL80211_CMD_AUTHENTICATE) received for wlo1
Sep 17 16:40:58 mumble15 kernel: [24581.228343] wlo1: send auth to
24:de:c6:cb:2a:d8 (try 1/3)
Sep 17 16:40:58 mumble15 kernel: [24581.232134] wlo1: authenticated
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: MLME event 37
(NL80211_CMD_AUTHENTICATE) on wlo1(48:5f:99:bc:ab:b9)
A1=48:5f:99:bc:ab:b9 A2=24:de:c6:cb:2a:d8
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: 1568763658.566628:   *
SSID - hexdump_ascii(len=16):
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: MLME event
frame - hexdump(len=30): b0 08 3c 00 48 5f 99 bc ab b9 24 de c6 cb 2a
d8 24 de c6 cb 2a d8 90 e5 00 00 02 00 00 00
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Authenticate event
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Event AUTH (11) received
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: SME:
Authentication response: peer=24:de:c6:cb:2a:d8 auth_type=0
auth_transaction=2 status_code=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: SME: Authentication
response IEs - hexdump(len=0): [NULL]
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: set_disable_max_amsdu: -1
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: set_ampdu_factor: -1
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: set_ampdu_density: -1
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: set_disable_ht40: 0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: set_disable_sgi: 0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: set_disable_ldpc: 0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Trying to
associate with 24:de:c6:cb:2a:d8 (SSID='Google Starbucks' freq=5765
MHz)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: State:
AUTHENTICATING -> ASSOCIATING
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Set wlo1
operstate 0->0 (DORMANT)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: netlink: Operstate:
ifindex=3 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing own WPA/RSN IE
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Associate (ifindex=3)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * bssid=24:de:c6:cb:2a:d8
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * freq=5765
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * IEs -
hexdump(len=10): 7f 08 00 00 00 00 00 00 00 40
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * htcaps -
hexdump(len=26): 63 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * htcaps_mask -
hexdump(len=26): 63 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * vhtcaps -
hexdump(len=12): 00 00 00 00 00 00 00 00 00 00 00 00
Sep 17 16:40:58 mumble15 wpa_supplicant[892]:   * vhtcaps_mask -
hexdump(len=12): 00 00 00 00 00 00 00 00 00 00 00 00
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Association
request send successfully
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:40:58 mumble15 kernel: [24581.236321] wlo1: associate with
24:de:c6:cb:2a:d8 (try 1/3)
Sep 17 16:40:58 mumble15 NetworkManager[3656]: <info>
[1568763658.5827] device (wlo1): supplicant interface state:
authenticating -> associating
Sep 17 16:40:58 mumble15 kernel: [24581.340611] wlo1: associate with
24:de:c6:cb:2a:d8 (try 2/3)
Sep 17 16:40:58 mumble15 kernel: [24581.444622] wlo1: associate with
24:de:c6:cb:2a:d8 (try 3/3)
Sep 17 16:40:58 mumble15 kernel: [24581.548641] wlo1: association with
24:de:c6:cb:2a:d8 timed out
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Drv Event 20
(NL80211_CMD_DEL_STATION) received for wlo1
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Delete station
24:de:c6:cb:2a:d8
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Drv Event 38
(NL80211_CMD_ASSOCIATE) received for wlo1
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: MLME event 38;
timeout with 24:de:c6:cb:2a:d8
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Event
ASSOC_TIMED_OUT (15) received
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: SME: Association timed out
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Radio work
'sme-connect'@0x55b76d4fe5e0 done in 0.839130 seconds
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('sme-connect'@0x55b76d4fe5e0: num_active_works --> 0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: Added BSSID
24:de:c6:cb:2a:d8 into blacklist
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Blacklist count 1
--> request scan in 100 ms
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: Setting scan
request: 0.100000 sec
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: wlo1: State: ASSOCIATING
-> DISCONNECTED
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: nl80211: Set wlo1
operstate 0->0 (DORMANT)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: netlink: Operstate:
ifindex=3 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portEnabled=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portValid=0
Sep 17 16:40:58 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:40:58 mumble15 NetworkManager[3656]: <info>
[1568763658.9102] device (wlo1): supplicant interface state:
associating -> disconnected
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: wlo1: State:
DISCONNECTED -> SCANNING
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: wlo1: Starting AP scan
for wildcard SSID
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: 1568763659.004088: Scan
SSID - hexdump_ascii(len=16):
Sep 17 16:40:59 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: 1568763659.004474:
nl80211: Scan SSID - hexdump_ascii(len=16):
Sep 17 16:40:59 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: 1568763659.004501:
nl80211: Scan SSID - hexdump_ascii(len=0): [NULL]
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: wlo1: Add radio work
'scan'@0x55b76d523030
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: wlo1: First radio work
item in the queue - schedule start immediately
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: wlo1: Starting radio
work 'scan'@0x55b76d523030 after 0.000049 second wait
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: wlo1: nl80211: scan request
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: nl80211: Scan extra IEs
- hexdump(len=10): 7f 08 00 00 00 00 00 00 00 40
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: Scan requested (ret=0) -
scan timeout 30 seconds
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: nl80211: Drv Event 33
(NL80211_CMD_TRIGGER_SCAN) received for wlo1
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: wlo1: nl80211: Scan trigger
Sep 17 16:40:59 mumble15 NetworkManager[3656]: <info>
[1568763659.5036] device (wlo1): supplicant interface state:
disconnected -> scanning
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_STARTED
(48) received
Sep 17 16:40:59 mumble15 wpa_supplicant[892]: wlo1: Own scan request
started a scan in 0.000334 seconds
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: RTM_NEWLINK: ifi_index=3
ifname=wlo1 wext ifi_family=0 ifi_flags=0x1003 ([UP])
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: nl80211: Drv Event 34
(NL80211_CMD_NEW_SCAN_RESULTS) received for wlo1
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: nl80211: New scan
results available
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: nl80211: Scan probed for
SSID 'Google Starbucks'
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: nl80211: Scan probed for SSID ''
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: nl80211: Scan included
frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462
2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540
5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_RESULTS
(3) received
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: Scan completed in
3.488439 seconds
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: nl80211: Received scan
results (26 BSSes)
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: BSS: Start scan
result update 9
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 53
BSSID f8:f5:32:ba:1e:50 SSID 'ATTzFzuzCI' freq 2457
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/53'
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: BSS: last_scan_res_used=26/32
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: New scan results
available (own=1 ext=0)
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: message repeated 11
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: AP
f8:f5:32:ba:1e:50 type 0 added
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: AP[0]
9c:3d:cf:16:4c:1f type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: AP[1]
38:2c:4a:5d:32:90 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: AP[2]
06:93:97:4f:c0:33 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: AP[3]
e8:ed:05:6a:83:d5 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: AP[4]
88:71:b1:5e:c9:f0 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: AP[5]
e6:f5:32:35:cb:83 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: AP[6]
6c:ca:08:0e:c9:90 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: AP[7]
14:59:c0:ab:a2:20 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: 1568763662.995929:   *
SSID - hexdump_ascii(len=16):
Sep 17 16:41:02 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: WPS: AP[8]
f8:f5:32:ba:1e:50 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: Radio work
'scan'@0x55b76d523030 done in 3.988852 seconds
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('scan'@0x55b76d523030: num_active_works --> 0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: Selecting BSS from
priority group 0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 0:
c4:b3:01:de:59:c3 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1111
level=-57 freq=5745
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 1:
c6:c3:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1111 level=-58 freq=5745
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 2:
24:de:c6:cb:2a:d9 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-40 freq=5765
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 3:
24:de:c6:cb:2a:da ssid='notes' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-42 freq=5765
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 4:
00:1d:d5:56:90:70 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0xc11
level=-56 freq=2462
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 5:
c6:c2:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1511 level=-57 freq=2437
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 6:
c4:b3:01:de:59:c2 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1511
level=-59 freq=2437
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 7:
9c:d6:43:2c:72:98 ssid='Ecenter' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-77 freq=5180
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 8:
9c:3d:cf:16:4c:1f ssid='Nova nails' wpa_ie_len=0 rsn_ie_len=20
caps=0x411 level=-74 freq=2412  wps
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 9:
88:71:b1:5e:c9:f0 ssid='ATTg6YdfPi' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-75 freq=2412  wps
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 10:
e6:f5:32:35:cb:83 ssid='VTA' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-83 freq=5745  wps
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 11:
06:93:97:4f:c0:33 ssid='NCFC' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-84 freq=5180  wps
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 12:
38:2c:4a:5d:32:90 ssid='Best_2-4' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-77 freq=2437  wps
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 13:
8a:15:04:3d:a6:d3 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-77 freq=2457
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 14:
f8:f5:32:35:cb:83 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-85 freq=5745
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 15:
fa:f5:32:35:cb:81 ssid='VTA Guest' wpa_ie_len=26 rsn_ie_len=24
caps=0x1411 level=-78 freq=2412
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 16:
e8:ed:05:6a:83:d5 ssid='Quick Wok SD-5G' wpa_ie_len=0 rsn_ie_len=20
caps=0x831 level=-86 freq=5220  wps
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 17:
8a:15:04:3d:a6:d4 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-79 freq=2457
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 18:
6c:ca:08:0e:c9:90 ssid='ATT6N5A5d2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2412  wps
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 19:
8a:15:04:3d:a6:d1 ssid='\x00\x00\x00\x00\x00\x00\x00' wpa_ie_len=26
rsn_ie_len=24 caps=0x1431 level=-80 freq=2457
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 20:
f8:f5:32:ba:1e:50 ssid='ATTzFzuzCI' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2457  wps
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 kernel: [24585.661716] wlo1: authenticate
with 24:de:c6:cb:2a:d8
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 21:
60:fe:20:7d:fd:46 ssid='ATT913' wpa_ie_len=28 rsn_ie_len=24 caps=0x411
level=-84 freq=2437
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 22:
14:59:c0:ab:a2:20 ssid='NETGEAR36' wpa_ie_len=0 rsn_ie_len=26
caps=0x1511 level=-86 freq=2462  wps
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 23:
f4:6b:ef:23:a9:3e ssid='MySpectrumWiFi38-2G' wpa_ie_len=0
rsn_ie_len=20 caps=0x431 level=-91 freq=2462
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 24:
24:de:c6:cb:2a:d8 ssid='Google Starbucks' wpa_ie_len=0 rsn_ie_len=0
caps=0x501 level=-42 freq=5765
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip -
blacklisted (count=1 limit=0)
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 25:
9c:d6:43:2c:72:90 ssid='' wpa_ie_len=0 rsn_ie_len=0 caps=0x421
level=-63 freq=2462
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: No APs found -
clear blacklist and try again
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: Removed BSSID
24:de:c6:cb:2a:d8 from blacklist (clear)
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: Selecting BSS from
priority group 0
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 0:
c4:b3:01:de:59:c3 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1111
level=-57 freq=5745
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 1:
c6:c3:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1111 level=-58 freq=5745
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 2:
24:de:c6:cb:2a:d9 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-40 freq=5765
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 3:
24:de:c6:cb:2a:da ssid='notes' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-42 freq=5765
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 4:
00:1d:d5:56:90:70 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0xc11
level=-56 freq=2462
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 5:
c6:c2:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1511 level=-57 freq=2437
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 6:
c4:b3:01:de:59:c2 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1511
level=-59 freq=2437
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 7:
9c:d6:43:2c:72:98 ssid='Ecenter' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-77 freq=5180
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1: 8:
9c:3d:cf:16:4c:1f ssid='Nova nails' wpa_ie_len=0 rsn_ie_len=20
caps=0x411 level=-74 freq=2412  wps
Sep 17 16:41:02 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 9:
88:71:b1:5e:c9:f0 ssid='ATTg6YdfPi' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-75 freq=2412  wps
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 10:
e6:f5:32:35:cb:83 ssid='VTA' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-83 freq=5745  wps
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 11:
06:93:97:4f:c0:33 ssid='NCFC' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-84 freq=5180  wps
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 12:
38:2c:4a:5d:32:90 ssid='Best_2-4' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-77 freq=2437  wps
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 13:
8a:15:04:3d:a6:d3 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-77 freq=2457
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 14:
f8:f5:32:35:cb:83 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-85 freq=5745
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 15:
fa:f5:32:35:cb:81 ssid='VTA Guest' wpa_ie_len=26 rsn_ie_len=24
caps=0x1411 level=-78 freq=2412
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 16:
e8:ed:05:6a:83:d5 ssid='Quick Wok SD-5G' wpa_ie_len=0 rsn_ie_len=20
caps=0x831 level=-86 freq=5220  wps
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 17:
8a:15:04:3d:a6:d4 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-79 freq=2457
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 18:
6c:ca:08:0e:c9:90 ssid='ATT6N5A5d2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2412  wps
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 19:
8a:15:04:3d:a6:d1 ssid='\x00\x00\x00\x00\x00\x00\x00' wpa_ie_len=26
rsn_ie_len=24 caps=0x1431 level=-80 freq=2457
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 20:
f8:f5:32:ba:1e:50 ssid='ATTzFzuzCI' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2457  wps
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 21:
60:fe:20:7d:fd:46 ssid='ATT913' wpa_ie_len=28 rsn_ie_len=24 caps=0x411
level=-84 freq=2437
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 22:
14:59:c0:ab:a2:20 ssid='NETGEAR36' wpa_ie_len=0 rsn_ie_len=26
caps=0x1511 level=-86 freq=2462  wps
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 23:
f4:6b:ef:23:a9:3e ssid='MySpectrumWiFi38-2G' wpa_ie_len=0
rsn_ie_len=20 caps=0x431 level=-91 freq=2462
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: 24:
24:de:c6:cb:2a:d8 ssid='Google Starbucks' wpa_ie_len=0 rsn_ie_len=0
caps=0x501 level=-42 freq=5765
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    allow in non-WPA/WPA2
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:    selected BSS
24:de:c6:cb:2a:d8 ssid='Google Starbucks'
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Considering
connect request: reassociate: 0  selected: 24:de:c6:cb:2a:d8  bssid:
00:00:00:00:00:00  pending: 00:00:00:00:00:00  wpa_state: SCANNING
ssid=0x55b76d53e670  current_ssid=(nil)
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Request
association with 24:de:c6:cb:2a:d8
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Re-association to
the same ESS
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: TDLS: TDLS is allowed in
the target BSS
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: TDLS: TDLS channel
switch allowed in the target BSS
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Add radio work
'sme-connect'@0x55b76d4e1a40
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: First radio work
item in the queue - schedule start immediately
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Starting radio
work 'sme-connect'@0x55b76d4e1a40 after 0.000030 second wait
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Automatic auth_alg
selection: 0x1
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing AP WPA IE
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing AP RSN IE
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing own WPA/RSN IE
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: FT: Stored MDIE and FTIE
from (Re)Association Response - hexdump(len=0):
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: RRM: Determining whether
RRM can be used - device support: 0x10
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: RRM: No RRM in network
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Cancelling scan request
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: SME: Trying to
authenticate with 24:de:c6:cb:2a:d8 (SSID='Google Starbucks' freq=5765
MHz)
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: State: SCANNING ->
AUTHENTICATING
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: EAPOL: External
notification - EAP success=0
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: EAPOL: External
notification - EAP fail=0
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portControl=ForceAuthorized
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Determining shared
radio frequencies (max len 1)
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Shared frequencies
(len=0): completed iteration
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: Authenticate (ifindex=3)
Sep 17 16:41:03 mumble15 wpa_supplicant[892]:   * bssid=24:de:c6:cb:2a:d8
Sep 17 16:41:03 mumble15 wpa_supplicant[892]:   * freq=5765
Sep 17 16:41:03 mumble15 wpa_supplicant[892]:   * IEs - hexdump(len=0): [NULL]
Sep 17 16:41:03 mumble15 wpa_supplicant[892]:   * Auth Type 0
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: Authentication
request send successfully
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/53) [s]
Sep 17 16:41:03 mumble15 NetworkManager[3656]: <info>
[1568763663.4962] device (wlo1): supplicant interface state: scanning
-> authenticating
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: Drv Event 19
(NL80211_CMD_NEW_STATION) received for wlo1
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: New station
24:de:c6:cb:2a:d8
Sep 17 16:41:03 mumble15 kernel: [24586.160254] wlo1: send auth to
24:de:c6:cb:2a:d8 (try 1/3)
Sep 17 16:41:03 mumble15 kernel: [24586.264448] wlo1: send auth to
24:de:c6:cb:2a:d8 (try 2/3)
Sep 17 16:41:03 mumble15 kernel: [24586.368496] wlo1: send auth to
24:de:c6:cb:2a:d8 (try 3/3)
Sep 17 16:41:03 mumble15 kernel: [24586.472440] wlo1: authentication
with 24:de:c6:cb:2a:d8 timed out
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: Drv Event 20
(NL80211_CMD_DEL_STATION) received for wlo1
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: Delete station
24:de:c6:cb:2a:d8
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: Drv Event 37
(NL80211_CMD_AUTHENTICATE) received for wlo1
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: MLME event 37;
timeout with 24:de:c6:cb:2a:d8
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Event
AUTH_TIMED_OUT (14) received
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: SME:
Authentication timed out
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Radio work
'sme-connect'@0x55b76d4e1a40 done in 0.827605 seconds
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('sme-connect'@0x55b76d4e1a40: num_active_works --> 0
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: Added BSSID
24:de:c6:cb:2a:d8 into blacklist
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Blacklist count 2
--> request scan in 500 ms
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: Setting scan
request: 0.500000 sec
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: wlo1: State:
AUTHENTICATING -> DISCONNECTED
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: nl80211: Set wlo1
operstate 0->0 (DORMANT)
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: netlink: Operstate:
ifindex=3 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portEnabled=0
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portValid=0
Sep 17 16:41:03 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:03 mumble15 NetworkManager[3656]: <info>
[1568763663.8299] device (wlo1): supplicant interface state:
authenticating -> disconnected
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: wlo1: State:
DISCONNECTED -> SCANNING
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: wlo1: Starting AP scan
for wildcard SSID
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: 1568763664.324155: Scan
SSID - hexdump_ascii(len=16):
Sep 17 16:41:04 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: 1568763664.324386:
nl80211: Scan SSID - hexdump_ascii(len=16):
Sep 17 16:41:04 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: 1568763664.324407:
nl80211: Scan SSID - hexdump_ascii(len=0): [NULL]
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: wlo1: Add radio work
'scan'@0x55b76d523030
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: wlo1: First radio work
item in the queue - schedule start immediately
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: wlo1: Starting radio
work 'scan'@0x55b76d523030 after 0.000038 second wait
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: wlo1: nl80211: scan request
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: nl80211: Scan extra IEs
- hexdump(len=10): 7f 08 00 00 00 00 00 00 00 40
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: Scan requested (ret=0) -
scan timeout 30 seconds
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: nl80211: Drv Event 33
(NL80211_CMD_TRIGGER_SCAN) received for wlo1
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: wlo1: nl80211: Scan trigger
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_STARTED
(48) received
Sep 17 16:41:04 mumble15 wpa_supplicant[892]: wlo1: Own scan request
started a scan in 0.000280 seconds
Sep 17 16:41:04 mumble15 NetworkManager[3656]: <info>
[1568763664.8234] device (wlo1): supplicant interface state:
disconnected -> scanning
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: RTM_NEWLINK: ifi_index=3
ifname=wlo1 wext ifi_family=0 ifi_flags=0x1003 ([UP])
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: Drv Event 34
(NL80211_CMD_NEW_SCAN_RESULTS) received for wlo1
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: nl80211: New scan
results available
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: Scan probed for
SSID 'Google Starbucks'
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: Scan probed for SSID ''
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: Scan included
frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462
2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540
5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_RESULTS
(3) received
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Scan completed in
3.484866 seconds
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: Received scan
results (31 BSSes)
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: BSS: Start scan
result update 10
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 54
BSSID 10:93:97:58:5c:b0 SSID 'ATTpdSDEa2' freq 2412
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/54'
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 55
BSSID 12:93:97:4f:c0:31 SSID 'NCFC Guest' freq 2462
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/55'
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 56
BSSID b0:ee:7b:6b:ca:5f SSID 'DIRECT-roku-762-2D2B31' freq 2412
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/56'
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 57
BSSID e8:ed:05:6a:83:d0 SSID 'Quick Wok SD' freq 2462
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/57'
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 58
BSSID f8:f5:32:35:cb:80 SSID 'VTA' freq 2412
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/58'
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: BSS: last_scan_res_used=31/32
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: New scan results
available (own=1 ext=0)
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: message repeated 5
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP
10:93:97:58:5c:b0 type 0 added
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: message repeated 5
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP
b0:ee:7b:6b:ca:5f type 0 added
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP
e8:ed:05:6a:83:d0 type 0 added
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP
f8:f5:32:35:cb:80 type 0 added
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[0]
9c:3d:cf:16:4c:1f type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[1]
38:2c:4a:5d:32:90 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[2]
06:93:97:4f:c0:33 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[3]
e8:ed:05:6a:83:d5 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[4]
88:71:b1:5e:c9:f0 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[5]
e6:f5:32:35:cb:83 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[6]
6c:ca:08:0e:c9:90 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[7]
14:59:c0:ab:a2:20 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[8]
f8:f5:32:ba:1e:50 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[9]
10:93:97:58:5c:b0 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[10]
b0:ee:7b:6b:ca:5f type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[11]
e8:ed:05:6a:83:d0 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: WPS: AP[12]
f8:f5:32:35:cb:80 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Radio work
'scan'@0x55b76d523030 done in 3.986302 seconds
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('scan'@0x55b76d523030: num_active_works --> 0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Selecting BSS from
priority group 0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 0:
c6:c3:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1111 level=-57 freq=5745
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 1:
c4:b3:01:de:59:c3 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1111
level=-59 freq=5745
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 2:
24:de:c6:cb:2a:d9 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-38 freq=5765
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: 1568763668.314044:   *
SSID - hexdump_ascii(len=16):
Sep 17 16:41:08 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 3:
24:de:c6:cb:2a:da ssid='notes' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-38 freq=5765
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 4:
c4:b3:01:de:59:c2 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1511
level=-51 freq=2437
Sep 17 16:41:08 mumble15 kernel: [24590.979733] wlo1: authenticate
with 24:de:c6:cb:2a:d8
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 5:
c6:c2:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1511 level=-57 freq=2437
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 6:
00:1d:d5:56:90:70 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0xc11
level=-60 freq=2462
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 7:
9c:d6:43:2c:72:98 ssid='Ecenter' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-77 freq=5180
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 8:
10:93:97:58:5c:b0 ssid='ATTpdSDEa2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-72 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 9:
f8:f5:32:35:cb:83 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-82 freq=5745
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 10:
88:71:b1:5e:c9:f0 ssid='ATTg6YdfPi' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-75 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 11:
9c:3d:cf:16:4c:1f ssid='Nova nails' wpa_ie_len=0 rsn_ie_len=20
caps=0x411 level=-75 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 12:
06:93:97:4f:c0:33 ssid='NCFC' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-83 freq=5180  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 13:
e6:f5:32:35:cb:83 ssid='VTA' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-84 freq=5745  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 14:
e8:ed:05:6a:83:d5 ssid='Quick Wok SD-5G' wpa_ie_len=0 rsn_ie_len=20
caps=0x831 level=-83 freq=5220  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 15:
38:2c:4a:5d:32:90 ssid='Best_2-4' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-77 freq=2437  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 16:
8a:15:04:3d:a6:d3 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-77 freq=2457
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 17:
fa:f5:32:35:cb:81 ssid='VTA Guest' wpa_ie_len=26 rsn_ie_len=24
caps=0x1411 level=-78 freq=2412
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 18:
8a:15:04:3d:a6:d4 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-79 freq=2457
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 19:
6c:ca:08:0e:c9:90 ssid='ATT6N5A5d2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 20:
8a:15:04:3d:a6:d1 ssid='\x00\x00\x00\x00\x00\x00\x00' wpa_ie_len=26
rsn_ie_len=24 caps=0x1431 level=-80 freq=2457
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 21:
f8:f5:32:ba:1e:50 ssid='ATTzFzuzCI' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2457  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 22:
12:93:97:4f:c0:31 ssid='NCFC Guest' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2462
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 23:
60:fe:20:7d:fd:46 ssid='ATT913' wpa_ie_len=28 rsn_ie_len=24 caps=0x411
level=-84 freq=2437
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 24:
14:59:c0:ab:a2:20 ssid='NETGEAR36' wpa_ie_len=0 rsn_ie_len=26
caps=0x1511 level=-86 freq=2462  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 25:
b0:ee:7b:6b:ca:5f ssid='DIRECT-roku-762-2D2B31' wpa_ie_len=0
rsn_ie_len=20 caps=0x511 level=-88 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 26:
e8:ed:05:6a:83:d0 ssid='Quick Wok SD' wpa_ie_len=0 rsn_ie_len=20
caps=0xc31 level=-88 freq=2462  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 27:
f8:f5:32:35:cb:80 ssid='VTA' wpa_ie_len=26 rsn_ie_len=24 caps=0x1411
level=-89 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 28:
f4:6b:ef:23:a9:3e ssid='MySpectrumWiFi38-2G' wpa_ie_len=0
rsn_ie_len=20 caps=0x431 level=-91 freq=2462
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 29:
24:de:c6:cb:2a:d8 ssid='Google Starbucks' wpa_ie_len=0 rsn_ie_len=0
caps=0x501 level=-38 freq=5765
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip -
blacklisted (count=1 limit=0)
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 30:
9c:d6:43:2c:72:90 ssid='' wpa_ie_len=0 rsn_ie_len=0 caps=0x421
level=-59 freq=2462
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: No APs found -
clear blacklist and try again
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: Removed BSSID
24:de:c6:cb:2a:d8 from blacklist (clear)
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Selecting BSS from
priority group 0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 0:
c6:c3:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1111 level=-57 freq=5745
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 1:
c4:b3:01:de:59:c3 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1111
level=-59 freq=5745
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 2:
24:de:c6:cb:2a:d9 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-38 freq=5765
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 3:
24:de:c6:cb:2a:da ssid='notes' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-38 freq=5765
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 4:
c4:b3:01:de:59:c2 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1511
level=-51 freq=2437
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 5:
c6:c2:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1511 level=-57 freq=2437
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 6:
00:1d:d5:56:90:70 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0xc11
level=-60 freq=2462
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 7:
9c:d6:43:2c:72:98 ssid='Ecenter' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-77 freq=5180
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 8:
10:93:97:58:5c:b0 ssid='ATTpdSDEa2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-72 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 9:
f8:f5:32:35:cb:83 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-82 freq=5745
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 10:
88:71:b1:5e:c9:f0 ssid='ATTg6YdfPi' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-75 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 11:
9c:3d:cf:16:4c:1f ssid='Nova nails' wpa_ie_len=0 rsn_ie_len=20
caps=0x411 level=-75 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 12:
06:93:97:4f:c0:33 ssid='NCFC' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-83 freq=5180  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 13:
e6:f5:32:35:cb:83 ssid='VTA' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-84 freq=5745  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 14:
e8:ed:05:6a:83:d5 ssid='Quick Wok SD-5G' wpa_ie_len=0 rsn_ie_len=20
caps=0x831 level=-83 freq=5220  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 15:
38:2c:4a:5d:32:90 ssid='Best_2-4' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-77 freq=2437  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 16:
8a:15:04:3d:a6:d3 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-77 freq=2457
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 17:
fa:f5:32:35:cb:81 ssid='VTA Guest' wpa_ie_len=26 rsn_ie_len=24
caps=0x1411 level=-78 freq=2412
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 18:
8a:15:04:3d:a6:d4 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-79 freq=2457
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 19:
6c:ca:08:0e:c9:90 ssid='ATT6N5A5d2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 20:
8a:15:04:3d:a6:d1 ssid='\x00\x00\x00\x00\x00\x00\x00' wpa_ie_len=26
rsn_ie_len=24 caps=0x1431 level=-80 freq=2457
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 21:
f8:f5:32:ba:1e:50 ssid='ATTzFzuzCI' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2457  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 22:
12:93:97:4f:c0:31 ssid='NCFC Guest' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2462
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 23:
60:fe:20:7d:fd:46 ssid='ATT913' wpa_ie_len=28 rsn_ie_len=24 caps=0x411
level=-84 freq=2437
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 24:
14:59:c0:ab:a2:20 ssid='NETGEAR36' wpa_ie_len=0 rsn_ie_len=26
caps=0x1511 level=-86 freq=2462  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 25:
b0:ee:7b:6b:ca:5f ssid='DIRECT-roku-762-2D2B31' wpa_ie_len=0
rsn_ie_len=20 caps=0x511 level=-88 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 26:
e8:ed:05:6a:83:d0 ssid='Quick Wok SD' wpa_ie_len=0 rsn_ie_len=20
caps=0xc31 level=-88 freq=2462  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 27:
f8:f5:32:35:cb:80 ssid='VTA' wpa_ie_len=26 rsn_ie_len=24 caps=0x1411
level=-89 freq=2412  wps
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 28:
f4:6b:ef:23:a9:3e ssid='MySpectrumWiFi38-2G' wpa_ie_len=0
rsn_ie_len=20 caps=0x431 level=-91 freq=2462
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: 29:
24:de:c6:cb:2a:d8 ssid='Google Starbucks' wpa_ie_len=0 rsn_ie_len=0
caps=0x501 level=-38 freq=5765
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    allow in non-WPA/WPA2
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1:    selected BSS
24:de:c6:cb:2a:d8 ssid='Google Starbucks'
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Considering
connect request: reassociate: 0  selected: 24:de:c6:cb:2a:d8  bssid:
00:00:00:00:00:00  pending: 00:00:00:00:00:00  wpa_state: SCANNING
ssid=0x55b76d53e670  current_ssid=(nil)
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Request
association with 24:de:c6:cb:2a:d8
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Re-association to
the same ESS
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: TDLS: TDLS is allowed in
the target BSS
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: TDLS: TDLS channel
switch allowed in the target BSS
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Add radio work
'sme-connect'@0x55b76d4e35f0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: First radio work
item in the queue - schedule start immediately
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/1
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/47
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/3
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/5
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/6
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/7
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/11
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Starting radio
work 'sme-connect'@0x55b76d4e35f0 after 0.000825 second wait
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Automatic auth_alg
selection: 0x1
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing AP WPA IE
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing AP RSN IE
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing own WPA/RSN IE
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: FT: Stored MDIE and FTIE
from (Re)Association Response - hexdump(len=0):
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: RRM: Determining whether
RRM can be used - device support: 0x10
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: RRM: No RRM in network
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Cancelling scan request
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: SME: Trying to
authenticate with 24:de:c6:cb:2a:d8 (SSID='Google Starbucks' freq=5765
MHz)
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: State: SCANNING ->
AUTHENTICATING
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: EAPOL: External
notification - EAP success=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: EAPOL: External
notification - EAP fail=0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portControl=ForceAuthorized
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Determining shared
radio frequencies (max len 1)
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: wlo1: Shared frequencies
(len=0): completed iteration
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: Authenticate (ifindex=3)
Sep 17 16:41:08 mumble15 wpa_supplicant[892]:   * bssid=24:de:c6:cb:2a:d8
Sep 17 16:41:08 mumble15 wpa_supplicant[892]:   * freq=5765
Sep 17 16:41:08 mumble15 wpa_supplicant[892]:   * IEs - hexdump(len=0): [NULL]
Sep 17 16:41:08 mumble15 wpa_supplicant[892]:   * Auth Type 0
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: Authentication
request send successfully
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/38
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/54) [s]
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/55) [s]
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/56) [s]
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/57) [s]
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/58) [s]
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: Drv Event 19
(NL80211_CMD_NEW_STATION) received for wlo1
Sep 17 16:41:08 mumble15 wpa_supplicant[892]: nl80211: New station
24:de:c6:cb:2a:d8
Sep 17 16:41:08 mumble15 kernel: [24591.480155] wlo1: send auth to
24:de:c6:cb:2a:d8 (try 1/3)
Sep 17 16:41:08 mumble15 NetworkManager[3656]: <info>
[1568763668.8180] device (wlo1): supplicant interface state: scanning
-> authenticating
Sep 17 16:41:08 mumble15 kernel: [24591.584371] wlo1: send auth to
24:de:c6:cb:2a:d8 (try 2/3)
Sep 17 16:41:09 mumble15 kernel: [24591.688370] wlo1: send auth to
24:de:c6:cb:2a:d8 (try 3/3)
Sep 17 16:41:09 mumble15 kernel: [24591.792412] wlo1: authentication
with 24:de:c6:cb:2a:d8 timed out
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: nl80211: Drv Event 20
(NL80211_CMD_DEL_STATION) received for wlo1
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: nl80211: Delete station
24:de:c6:cb:2a:d8
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: nl80211: Drv Event 37
(NL80211_CMD_AUTHENTICATE) received for wlo1
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: nl80211: MLME event 37;
timeout with 24:de:c6:cb:2a:d8
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: wlo1: Event
AUTH_TIMED_OUT (14) received
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: wlo1: SME:
Authentication timed out
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: wlo1: Radio work
'sme-connect'@0x55b76d4e35f0 done in 0.837417 seconds
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('sme-connect'@0x55b76d4e35f0: num_active_works --> 0
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: Added BSSID
24:de:c6:cb:2a:d8 into blacklist
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: wlo1: Blacklist count 3
--> request scan in 1000 ms
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: wlo1: Setting scan
request: 1.000000 sec
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: wlo1: State:
AUTHENTICATING -> DISCONNECTED
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: nl80211: Set wlo1
operstate 0->0 (DORMANT)
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: netlink: Operstate:
ifindex=3 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portEnabled=0
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portValid=0
Sep 17 16:41:09 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:09 mumble15 NetworkManager[3656]: <info>
[1568763669.1578] device (wlo1): supplicant interface state:
authenticating -> disconnected
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: wlo1: State:
DISCONNECTED -> SCANNING
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: wlo1: Starting AP scan
for wildcard SSID
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: 1568763670.152880: Scan
SSID - hexdump_ascii(len=16):
Sep 17 16:41:10 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: 1568763670.153091:
nl80211: Scan SSID - hexdump_ascii(len=16):
Sep 17 16:41:10 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: 1568763670.153113:
nl80211: Scan SSID - hexdump_ascii(len=0): [NULL]
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: wlo1: Add radio work
'scan'@0x55b76d523030
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: wlo1: First radio work
item in the queue - schedule start immediately
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: wlo1: Starting radio
work 'scan'@0x55b76d523030 after 0.000037 second wait
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: wlo1: nl80211: scan request
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: nl80211: Scan extra IEs
- hexdump(len=10): 7f 08 00 00 00 00 00 00 00 40
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: Scan requested (ret=0) -
scan timeout 30 seconds
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: nl80211: Drv Event 33
(NL80211_CMD_TRIGGER_SCAN) received for wlo1
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: wlo1: nl80211: Scan trigger
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_STARTED
(48) received
Sep 17 16:41:10 mumble15 wpa_supplicant[892]: wlo1: Own scan request
started a scan in 0.000388 seconds
Sep 17 16:41:10 mumble15 NetworkManager[3656]: <info>
[1568763670.6556] device (wlo1): supplicant interface state:
disconnected -> scanning
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Drv Event 34
(NL80211_CMD_NEW_SCAN_RESULTS) received for wlo1
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: nl80211: New scan
results available
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Scan probed for
SSID 'Google Starbucks'
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Scan probed for SSID ''
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Scan included
frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462
2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540
5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_RESULTS
(3) received
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Scan completed in
3.484366 seconds
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Received scan
results (33 BSSes)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: BSS: Start scan
result update 11
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 59
BSSID c8:d7:19:1f:c2:bc SSID 'PureMotion' freq 2452
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/59'
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 60
BSSID 10:93:97:4f:c0:30 SSID 'NCFC' freq 2462
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/60'
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: BSS: last_scan_res_used=33/64
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: New scan results
available (own=1 ext=0)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: message repeated 5
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP
c8:d7:19:1f:c2:bc type 0 added
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: message repeated 5
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP
10:93:97:4f:c0:30 type 0 added
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[0]
9c:3d:cf:16:4c:1f type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[1]
38:2c:4a:5d:32:90 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[2]
06:93:97:4f:c0:33 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[3]
e8:ed:05:6a:83:d5 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[4]
88:71:b1:5e:c9:f0 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[5]
e6:f5:32:35:cb:83 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[6]
6c:ca:08:0e:c9:90 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[7]
14:59:c0:ab:a2:20 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[8]
f8:f5:32:ba:1e:50 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[9]
10:93:97:58:5c:b0 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[10]
b0:ee:7b:6b:ca:5f type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[11]
e8:ed:05:6a:83:d0 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[12]
f8:f5:32:35:cb:80 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[13]
c8:d7:19:1f:c2:bc type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: WPS: AP[14]
10:93:97:4f:c0:30 type=0 tries=0 last_attempt=-1 sec ago blacklist=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Radio work
'scan'@0x55b76d523030 done in 3.988271 seconds
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('scan'@0x55b76d523030: num_active_works --> 0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Selecting BSS from
priority group 0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 0:
c6:c3:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1111 level=-60 freq=5745
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 1:
c4:b3:01:de:59:c3 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1111
level=-60 freq=5745
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 2:
24:de:c6:cb:2a:d9 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-40 freq=5765
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 3:
24:de:c6:cb:2a:da ssid='notes' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-40 freq=5765
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 4:
c6:c2:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1511 level=-54 freq=2437
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 5:
c4:b3:01:de:59:c2 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1511
level=-55 freq=2437
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 6:
c8:d7:19:1f:c2:bc ssid='PureMotion' wpa_ie_len=22 rsn_ie_len=20
caps=0x431 level=-68 freq=2452  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 7:
00:1d:d5:56:90:70 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0xc11
level=-65 freq=2462
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 8:
9c:d6:43:2c:72:98 ssid='Ecenter' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-78 freq=5180
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 9:
10:93:97:58:5c:b0 ssid='ATTpdSDEa2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-72 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 10:
e6:f5:32:35:cb:83 ssid='VTA' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-81 freq=5745  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 11:
f8:f5:32:35:cb:83 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-82 freq=5745
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 12:
88:71:b1:5e:c9:f0 ssid='ATTg6YdfPi' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-75 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 13:
9c:3d:cf:16:4c:1f ssid='Nova nails' wpa_ie_len=0 rsn_ie_len=20
caps=0x411 level=-75 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 14:
06:93:97:4f:c0:33 ssid='NCFC' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-83 freq=5180  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 15:
e8:ed:05:6a:83:d5 ssid='Quick Wok SD-5G' wpa_ie_len=0 rsn_ie_len=20
caps=0x831 level=-84 freq=5220  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 16:
38:2c:4a:5d:32:90 ssid='Best_2-4' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-77 freq=2437  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 17:
8a:15:04:3d:a6:d3 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-77 freq=2457
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: 1568763674.147975:   *
SSID - hexdump_ascii(len=16):
Sep 17 16:41:14 mumble15 wpa_supplicant[892]:      47 6f 6f 67 6c 65
20 53 74 61 72 62 75 63 6b 73   Google Starbucks
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 18:
fa:f5:32:35:cb:81 ssid='VTA Guest' wpa_ie_len=26 rsn_ie_len=24
caps=0x1411 level=-78 freq=2412
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 19:
8a:15:04:3d:a6:d4 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-79 freq=2457
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 20:
10:93:97:4f:c0:30 ssid='NCFC' wpa_ie_len=0 rsn_ie_len=20 caps=0x1411
level=-79 freq=2462  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 21:
6c:ca:08:0e:c9:90 ssid='ATT6N5A5d2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 22:
8a:15:04:3d:a6:d1 ssid='\x00\x00\x00\x00\x00\x00\x00' wpa_ie_len=26
rsn_ie_len=24 caps=0x1431 level=-80 freq=2457
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 23:
f8:f5:32:ba:1e:50 ssid='ATTzFzuzCI' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2457  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 24:
12:93:97:4f:c0:31 ssid='NCFC Guest' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2462
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 25:
e8:ed:05:6a:83:d0 ssid='Quick Wok SD' wpa_ie_len=0 rsn_ie_len=20
caps=0xc31 level=-82 freq=2462  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 26:
60:fe:20:7d:fd:46 ssid='ATT913' wpa_ie_len=28 rsn_ie_len=24 caps=0x411
level=-84 freq=2437
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 27:
14:59:c0:ab:a2:20 ssid='NETGEAR36' wpa_ie_len=0 rsn_ie_len=26
caps=0x1511 level=-86 freq=2462  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 28:
b0:ee:7b:6b:ca:5f ssid='DIRECT-roku-762-2D2B31' wpa_ie_len=0
rsn_ie_len=20 caps=0x511 level=-88 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 29:
f8:f5:32:35:cb:80 ssid='VTA' wpa_ie_len=26 rsn_ie_len=24 caps=0x1411
level=-89 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 30:
f4:6b:ef:23:a9:3e ssid='MySpectrumWiFi38-2G' wpa_ie_len=0
rsn_ie_len=20 caps=0x431 level=-91 freq=2462
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 31:
24:de:c6:cb:2a:d8 ssid='Google Starbucks' wpa_ie_len=0 rsn_ie_len=0
caps=0x501 level=-40 freq=5765
Sep 17 16:41:14 mumble15 kernel: [24596.813570] wlo1: authenticate
with 24:de:c6:cb:2a:d8
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip -
blacklisted (count=1 limit=0)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 32:
9c:d6:43:2c:72:90 ssid='' wpa_ie_len=0 rsn_ie_len=0 caps=0x421
level=-59 freq=2462
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: No APs found -
clear blacklist and try again
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: Removed BSSID
24:de:c6:cb:2a:d8 from blacklist (clear)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Selecting BSS from
priority group 0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 0:
c6:c3:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1111 level=-60 freq=5745
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 1:
c4:b3:01:de:59:c3 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1111
level=-60 freq=5745
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 2:
24:de:c6:cb:2a:d9 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-40 freq=5765
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 3:
24:de:c6:cb:2a:da ssid='notes' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-40 freq=5765
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 4:
c6:c2:59:de:01:b0 ssid='HLCSD-Guest' wpa_ie_len=22 rsn_ie_len=24
caps=0x1511 level=-54 freq=2437
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 5:
c4:b3:01:de:59:c2 ssid='HLCSD' wpa_ie_len=22 rsn_ie_len=24 caps=0x1511
level=-55 freq=2437
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 6:
c8:d7:19:1f:c2:bc ssid='PureMotion' wpa_ie_len=22 rsn_ie_len=20
caps=0x431 level=-68 freq=2452  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 7:
00:1d:d5:56:90:70 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0xc11
level=-65 freq=2462
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 8:
9c:d6:43:2c:72:98 ssid='Ecenter' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-78 freq=5180
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 9:
10:93:97:58:5c:b0 ssid='ATTpdSDEa2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-72 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 10:
e6:f5:32:35:cb:83 ssid='VTA' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-81 freq=5745  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 11:
f8:f5:32:35:cb:83 ssid='' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-82 freq=5745
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID not known
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 12:
88:71:b1:5e:c9:f0 ssid='ATTg6YdfPi' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-75 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 13:
9c:3d:cf:16:4c:1f ssid='Nova nails' wpa_ie_len=0 rsn_ie_len=20
caps=0x411 level=-75 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 14:
06:93:97:4f:c0:33 ssid='NCFC' wpa_ie_len=0 rsn_ie_len=20 caps=0x511
level=-83 freq=5180  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 15:
e8:ed:05:6a:83:d5 ssid='Quick Wok SD-5G' wpa_ie_len=0 rsn_ie_len=20
caps=0x831 level=-84 freq=5220  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 16:
38:2c:4a:5d:32:90 ssid='Best_2-4' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-77 freq=2437  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 17:
8a:15:04:3d:a6:d3 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-77 freq=2457
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 18:
fa:f5:32:35:cb:81 ssid='VTA Guest' wpa_ie_len=26 rsn_ie_len=24
caps=0x1411 level=-78 freq=2412
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 19:
8a:15:04:3d:a6:d4 ssid='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
wpa_ie_len=26 rsn_ie_len=24 caps=0x1431 level=-79 freq=2457
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 20:
10:93:97:4f:c0:30 ssid='NCFC' wpa_ie_len=0 rsn_ie_len=20 caps=0x1411
level=-79 freq=2462  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 21:
6c:ca:08:0e:c9:90 ssid='ATT6N5A5d2' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 22:
8a:15:04:3d:a6:d1 ssid='\x00\x00\x00\x00\x00\x00\x00' wpa_ie_len=26
rsn_ie_len=24 caps=0x1431 level=-80 freq=2457
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 23:
f8:f5:32:ba:1e:50 ssid='ATTzFzuzCI' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2457  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 24:
12:93:97:4f:c0:31 ssid='NCFC Guest' wpa_ie_len=0 rsn_ie_len=20
caps=0x1411 level=-80 freq=2462
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 25:
e8:ed:05:6a:83:d0 ssid='Quick Wok SD' wpa_ie_len=0 rsn_ie_len=20
caps=0xc31 level=-82 freq=2462  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 26:
60:fe:20:7d:fd:46 ssid='ATT913' wpa_ie_len=28 rsn_ie_len=24 caps=0x411
level=-84 freq=2437
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 27:
14:59:c0:ab:a2:20 ssid='NETGEAR36' wpa_ie_len=0 rsn_ie_len=26
caps=0x1511 level=-86 freq=2462  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 28:
b0:ee:7b:6b:ca:5f ssid='DIRECT-roku-762-2D2B31' wpa_ie_len=0
rsn_ie_len=20 caps=0x511 level=-88 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 29:
f8:f5:32:35:cb:80 ssid='VTA' wpa_ie_len=26 rsn_ie_len=24 caps=0x1411
level=-89 freq=2412  wps
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 30:
f4:6b:ef:23:a9:3e ssid='MySpectrumWiFi38-2G' wpa_ie_len=0
rsn_ie_len=20 caps=0x431 level=-91 freq=2462
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    skip - SSID mismatch
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: 31:
24:de:c6:cb:2a:d8 ssid='Google Starbucks' wpa_ie_len=0 rsn_ie_len=0
caps=0x501 level=-40 freq=5765
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    allow in non-WPA/WPA2
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:    selected BSS
24:de:c6:cb:2a:d8 ssid='Google Starbucks'
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Considering
connect request: reassociate: 0  selected: 24:de:c6:cb:2a:d8  bssid:
00:00:00:00:00:00  pending: 00:00:00:00:00:00  wpa_state: SCANNING
ssid=0x55b76d53e670  current_ssid=(nil)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Request
association with 24:de:c6:cb:2a:d8
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Re-association to
the same ESS
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: TDLS: TDLS is allowed in
the target BSS
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: TDLS: TDLS channel
switch allowed in the target BSS
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Add radio work
'sme-connect'@0x55b76d4db8c0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: First radio work
item in the queue - schedule start immediately
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/59) [s]
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/60) [s]
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: RTM_NEWLINK: ifi_index=3
ifname=wlo1 wext ifi_family=0 ifi_flags=0x1003 ([UP])
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Starting radio
work 'sme-connect'@0x55b76d4db8c0 after 0.003431 second wait
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Automatic auth_alg
selection: 0x1
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing AP WPA IE
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing AP RSN IE
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: WPA: clearing own WPA/RSN IE
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: FT: Stored MDIE and FTIE
from (Re)Association Response - hexdump(len=0):
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: RRM: Determining whether
RRM can be used - device support: 0x10
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: RRM: No RRM in network
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Cancelling scan request
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: SME: Trying to
authenticate with 24:de:c6:cb:2a:d8 (SSID='Google Starbucks' freq=5765
MHz)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: State: SCANNING ->
AUTHENTICATING
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: EAPOL: External
notification - EAP success=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: EAPOL: External
notification - EAP fail=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portControl=ForceAuthorized
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Determining shared
radio frequencies (max len 1)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Shared frequencies
(len=0): completed iteration
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Authenticate (ifindex=3)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]:   * bssid=24:de:c6:cb:2a:d8
Sep 17 16:41:14 mumble15 wpa_supplicant[892]:   * freq=5765
Sep 17 16:41:14 mumble15 wpa_supplicant[892]:   * IEs - hexdump(len=0): [NULL]
Sep 17 16:41:14 mumble15 wpa_supplicant[892]:   * Auth Type 0
Sep 17 16:41:14 mumble15 kernel: [24597.311805] wlo1: send auth to
24:de:c6:cb:2a:d8 (try 1/3)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Authentication
request send successfully
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Drv Event 19
(NL80211_CMD_NEW_STATION) received for wlo1
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: New station
24:de:c6:cb:2a:d8
Sep 17 16:41:14 mumble15 NetworkManager[3656]: <info>
[1568763674.6478] device (wlo1): supplicant interface state: scanning
-> authenticating
Sep 17 16:41:14 mumble15 kernel: [24597.416245] wlo1: send auth to
24:de:c6:cb:2a:d8 (try 2/3)
Sep 17 16:41:14 mumble15 kernel: [24597.520225] wlo1: send auth to
24:de:c6:cb:2a:d8 (try 3/3)
Sep 17 16:41:14 mumble15 kernel: [24597.624303] wlo1: authentication
with 24:de:c6:cb:2a:d8 timed out
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Drv Event 20
(NL80211_CMD_DEL_STATION) received for wlo1
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Delete station
24:de:c6:cb:2a:d8
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Drv Event 37
(NL80211_CMD_AUTHENTICATE) received for wlo1
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: MLME event 37;
timeout with 24:de:c6:cb:2a:d8
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Event
AUTH_TIMED_OUT (14) received
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: SME:
Authentication timed out
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Radio work
'sme-connect'@0x55b76d4db8c0 done in 0.827543 seconds
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('sme-connect'@0x55b76d4db8c0: num_active_works --> 0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: Added BSSID
24:de:c6:cb:2a:d8 into blacklist
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: Continuous association
failures - consider temporary network disabling
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1:
CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="Google Starbucks"
auth_failures=1 duration=10 reason=CONN_FAILED
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Blacklist count 4
--> request scan in 5000 ms
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: Setting scan
request: 5.000000 sec
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: wlo1: State:
AUTHENTICATING -> DISCONNECTED
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: nl80211: Set wlo1
operstate 0->0 (DORMANT)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: netlink: Operstate:
ifindex=3 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portEnabled=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: EAPOL: External
notification - portValid=0
Sep 17 16:41:14 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:14 mumble15 NetworkManager[3656]: <info>
[1568763674.9819] device (wlo1): supplicant interface state:
authenticating -> disconnected
Sep 17 16:41:17 mumble15 NetworkManager[3656]: <warn>
[1568763677.2533] device (wlo1): Activation: (wifi) association took
too long, failing activation
Sep 17 16:41:17 mumble15 NetworkManager[3656]: <info>
[1568763677.2534] device (wlo1): state change: config -> failed
(reason 'supplicant-timeout', sys-iface-state: 'managed')
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: dbus:
fi.w1.wpa_supplicant1.Interface.RemoveNetwork
(/fi/w1/wpa_supplicant1/Interfaces/9) [o]
Sep 17 16:41:17 mumble15 NetworkManager[3656]: <info>
[1568763677.2539] manager: NetworkManager state is now DISCONNECTED
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: dbus: Unregister network
object '/fi/w1/wpa_supplicant1/Interfaces/9/Networks/0'
Sep 17 16:41:17 mumble15 NetworkManager[3656]: <warn>
[1568763677.2549] device (wlo1): Activation: failed for connection
'Google Starbucks'
Sep 17 16:41:17 mumble15 NetworkManager[3656]: <info>
[1568763677.2566] device (wlo1): state change: failed -> disconnected
(reason 'none', sys-iface-state: 'managed')
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: RTM_NEWLINK: ifi_index=3
ifname=wlo1 operstate=2 linkmode=1 ifi_family=0 ifi_flags=0x1003
([UP])
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: dbus:
fi.w1.wpa_supplicant1.Interface.Scan
(/fi/w1/wpa_supplicant1/Interfaces/9) [a{sv}]
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: 1568763677.263658:
nl80211: Scan SSID - hexdump_ascii(len=0): [NULL]
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: wlo1: Add radio work
'scan'@0x55b76d510440
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: wlo1: First radio work
item in the queue - schedule start immediately
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: wlo1: Starting radio
work 'scan'@0x55b76d510440 after 0.000195 second wait
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: wlo1: nl80211: scan request
Sep 17 16:41:17 mumble15 gnome-shell[1139]: An active wireless
connection, in infrastructure mode, involves no access point?
Sep 17 16:41:17 mumble15 gnome-shell[1824]: An active wireless
connection, in infrastructure mode, involves no access point?
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: Scan requested (ret=0) -
scan timeout 30 seconds
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: nl80211: Drv Event 33
(NL80211_CMD_TRIGGER_SCAN) received for wlo1
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: wlo1: nl80211: Scan trigger
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_STARTED
(48) received
Sep 17 16:41:17 mumble15 wpa_supplicant[892]: wlo1: Own scan request
started a scan in 0.000443 seconds
Sep 17 16:41:19 mumble15 wpa_supplicant[892]: wlo1: Already scanning -
Reschedule the incoming scan req
Sep 17 16:41:19 mumble15 wpa_supplicant[892]: wlo1: Setting scan
request: 1.000000 sec
Sep 17 16:41:20 mumble15 wpa_supplicant[892]: wlo1: Already scanning -
Reschedule the incoming scan req
Sep 17 16:41:20 mumble15 wpa_supplicant[892]: wlo1: Setting scan
request: 1.000000 sec
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: RTM_NEWLINK: ifi_index=3
ifname=wlo1 wext ifi_family=0 ifi_flags=0x1003 ([UP])
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: nl80211: Drv Event 34
(NL80211_CMD_NEW_SCAN_RESULTS) received for wlo1
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: nl80211: New scan
results available
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: nl80211: Scan probed for SSID ''
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: nl80211: Scan included
frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462
2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540
5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_RESULTS
(3) received
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: Scan completed in
3.484585 seconds
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: nl80211: Received scan
results (37 BSSes)
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: BSS: Start scan
result update 12
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 61
BSSID 24:de:c6:cb:2a:d1 SSID '' freq 2412
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/61'
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 62
BSSID 10:93:97:4f:c0:33 SSID '' freq 5180
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/62'
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 63
BSSID 8a:15:04:3d:a6:d2 SSID 'SC-GUEST' freq 2457
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/63'
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 64
BSSID 24:de:c6:cb:2a:d0 SSID 'Google Starbucks' freq 2412
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/64'
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: BSS: last_scan_res_used=37/64
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: Scan-only results received
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: message repeated 5
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: Radio work
'scan'@0x55b76d510440 done in 3.987275 seconds
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('scan'@0x55b76d510440: num_active_works --> 0
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/0
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/1
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/47
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/3
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/6
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/5
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/59
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/7
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/54
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/38
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/37
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: message repeated 3
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/9
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/11
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/39
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9/BSSs/15
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/61) [s]
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/62) [s]
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/63) [s]
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/64) [s]
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: No enabled
networks - do not scan
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: State:
DISCONNECTED -> INACTIVE
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:21 mumble15 NetworkManager[3656]: <info>
[1568763681.9863] device (wlo1): supplicant interface state:
disconnected -> inactive
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: dbus:
fi.w1.wpa_supplicant1.Interface.Scan
(/fi/w1/wpa_supplicant1/Interfaces/9) [a{sv}]
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: Add radio work
'scan'@0x55b76d4fe5c0
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: First radio work
item in the queue - schedule start immediately
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: Starting radio
work 'scan'@0x55b76d4fe5c0 after 0.000315 second wait
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: 1568763681.987864:
nl80211: Scan SSID - hexdump_ascii(len=0): [NULL]
Sep 17 16:41:21 mumble15 wpa_supplicant[892]: wlo1: nl80211: scan request
Sep 17 16:41:22 mumble15 wpa_supplicant[892]: Scan requested (ret=0) -
scan timeout 30 seconds
Sep 17 16:41:22 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:22 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:22 mumble15 wpa_supplicant[892]: nl80211: Drv Event 33
(NL80211_CMD_TRIGGER_SCAN) received for wlo1
Sep 17 16:41:22 mumble15 wpa_supplicant[892]: wlo1: nl80211: Scan trigger
Sep 17 16:41:22 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_STARTED
(48) received
Sep 17 16:41:22 mumble15 wpa_supplicant[892]: wlo1: Own scan request
started a scan in 0.000330 seconds
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: RTM_NEWLINK: ifi_index=3
ifname=wlo1 wext ifi_family=0 ifi_flags=0x1003 ([UP])
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: nl80211: Event message available
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: nl80211: Drv Event 34
(NL80211_CMD_NEW_SCAN_RESULTS) received for wlo1
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: wlo1: nl80211: New scan
results available
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: nl80211: Scan probed for SSID ''
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: nl80211: Scan included
frequencies: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462
2467 2472 2484 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 5540
5560 5580 5600 5620 5640 5660 5680 5700 5745 5765 5785 5805 5825
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: wlo1: Event SCAN_RESULTS
(3) received
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: wlo1: Scan completed in
3.484750 seconds
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: nl80211: Received scan
results (33 BSSes)
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: wlo1: BSS: Start scan
result update 13
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: wlo1: BSS: Add new id 65
BSSID 56:d9:e7:43:6a:f6 SSID 'CMountain Dentistry Patient WiFi' freq
2447
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: dbus: Register BSS
object '/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/65'
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: BSS: last_scan_res_used=33/64
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: wlo1: Scan-only results received
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: WPS: Unsupported
attribute type 0x1058 len=24
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: message repeated 5
times: [ WPS: Unsupported attribute type 0x1058 len=24]
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: wlo1: Radio work
'scan'@0x55b76d4fe5c0 done in 3.985792 seconds
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: wlo1:
radio_work_free('scan'@0x55b76d4fe5c0: num_active_works --> 0
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: dbus:
flush_object_timeout_handler: Timeout - sending changed properties of
object /fi/w1/wpa_supplicant1/Interfaces/9
Sep 17 16:41:25 mumble15 wpa_supplicant[892]: dbus:
org.freedesktop.DBus.Properties.GetAll
(/fi/w1/wpa_supplicant1/Interfaces/9/BSSs/65) [s]

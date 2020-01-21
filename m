Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7122214364A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2020 05:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgAUEmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 23:42:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37246 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgAUEmA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 23:42:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so820575pfn.4
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2020 20:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=W56zui/slFQy7YL2akMaaPr9wZxkWq94QZaBXOCS9VY=;
        b=SPXqx72NBm4shIrjzlh54FecFayAXeQMN3L0d6a4ZsKT8nF8l8UTgpK0ejN6GvFfli
         qfiXIODvfeL/W4tBjv4pzKz5bXN/NG5twBCXLuO416WOe3+e+5QCWJ8c2Yz66VSRdBaD
         uuV/j30itDlWMzcQFAxe3ewUNhbh0pGGB3nZOfNDQhptFlngQE0mY+MXm/yhTjKYH5jZ
         GFlDQu/Ki80i2XaDpJnvyvVJoehm8tFALGek+csOEaXKL/N3i8/skdY/UuyH9gryj++H
         zMjGIXxhkKmcNYyBnEUo8yPTUzy3aRehYtXdQwLyYbRkNHqJdqKQiwnD+J7BI9EGkjsU
         1Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=W56zui/slFQy7YL2akMaaPr9wZxkWq94QZaBXOCS9VY=;
        b=Ev5XYstaF0rXS27dn7iHnGvqTP6B0L6eL8S8XxMObpfTA89UrBys/73+N3cSj0AN1L
         aE9L5lE0BHG2eUal9MJSw8XqE+ACzf1DRzLO9VyT9DpE9thZghvccOtLkZABqm05HIr3
         BQBygJldTd3NxUnsw2+ts47KzItze/yjPEReg4xmcXLKbZUo4KuyjKODaKY9UMbnmXqZ
         /jVm1nua7FsD4XZP9Y8fOg6FYEP40O7OWf5P9Wnj9WhaYqI4tt5o+2BoCu6Zc6BjxCCo
         0/nmjBcWRo92vz+nh3xgn7jla6SmgP0krQqM5UqDFv3qVs18mji3xqzWH3Y2N95RHDh4
         q6sQ==
X-Gm-Message-State: APjAAAVlhX3JkmGcEmlGDAsMe0KbNhoOW40EK5S1us7O74I0gKEdW3pq
        EXrb0oKaYSOWK83EcrGOKu8PSYnT
X-Google-Smtp-Source: APXvYqzc2icwwpixuCMZgNUNL/7E27UL9sde2Z4fapLROSHWQfxPH/lZnD3ydwhMrFs3BLAP//JNbg==
X-Received: by 2002:a62:4d87:: with SMTP id a129mr2663447pfb.116.1579581719429;
        Mon, 20 Jan 2020 20:41:59 -0800 (PST)
Received: from mua.localhost (99-7-172-215.lightspeed.snmtca.sbcglobal.net. [99.7.172.215])
        by smtp.gmail.com with ESMTPSA id j8sm1145043pjb.4.2020.01.20.20.41.58
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 20:41:59 -0800 (PST)
Reply-To: pgnet.dev@gmail.com
To:     linux-wireless@vger.kernel.org
From:   PGNet Dev <pgnet.dev@gmail.com>
Subject: ath9k / kernel 5.4.13 unable to set Regdomain country ; stuck at =CN
 ?
Message-ID: <5220fb60-9b93-f50e-c29c-ac330adae8a3@gmail.com>
Date:   Mon, 20 Jan 2020 20:41:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

i've a linux box, running latest kernel/stable

	uname -rm
		5.4.13-24.g5cf5394-default x86_64

with a usb-attached atheros wifi dongle

	lsusb | grep -i ath
		Bus 001 Device 006: ID 0cf3:9271 Qualcomm Atheros Communications AR9271 802.11n

it's recognized & functioning on boot

	lsmod | egrep -i "ath|80211"
		ath9k_htc              81920  0
		ath9k_common           20480  1 ath9k_htc
		ath9k_hw              491520  2 ath9k_htc,ath9k_common
		ath                    36864  3 ath9k_htc,ath9k_common,ath9k_hw
		mac80211              970752  4 ath9k_htc,rt2x00lib,rt2x00usb,rt2800lib
		cfg80211              823296  5 ath9k_htc,ath9k_common,rt2x00lib,ath,mac80211
		libarc4                16384  1 mac80211
		rfkill                 28672  5 rfkill_gpio,cfg80211
		usbcore               307200  6 ath9k_htc,xhci_hcd,rt2800usb,usbhid,xhci_pci,rt2x00usb
		dm_multipath           36864  0
		dm_mod                155648  28 dm_multipath


	hwinfo --wlan
		...
		21: USB 00.0: 0282 WLAN controller
		  [Created at usb.122]
		  Unique ID: BobO.B4pqOVVOeJE
		  Parent ID: ADDn.DFkaVl_rzX0
		  SysFS ID: /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.2/1-1.2:1.0
		  SysFS BusID: 1-1.2:1.0
		  Hardware Class: network
		  Model: "Qualcomm Atheros AR9271 802.11n"
		  Hotplug: USB
		  Vendor: usb 0x0cf3 "Qualcomm Atheros Communications"
		  Device: usb 0x9271 "AR9271 802.11n"
		  Revision: "1.08"
		  Serial ID: "12345"
		  Driver: "ath9k_htc"
		  Driver Modules: "ath9k_htc"
		  Device File: wlp0s20u1u2
		  Features: WLAN
		  Speed: 480 Mbps
		  HW Address: ec:08:6b:...
		  Permanent HW Address: ec:08:6b:...
		  Link detected: no
		  WLAN channels: 1 2 3 4 5 6 7 8 9 10 11 12 13
		  WLAN frequencies: 2.412 2.417 2.422 2.427 2.432 2.437 2.442 2.447 2.452 2.457 2.462 2.467 2.472
		  WLAN encryption modes: WEP40 WEP104 TKIP CCMP
		  WLAN authentication modes: open sharedkey wpa-psk wpa-eap
		  Module Alias: "usb:v0CF3p9271d0108dcFFdscFFdpFFicFFisc00ip00in00"
		  Driver Info #0:
		    Driver Status: ath9k_htc is active
		    Driver Activation Cmd: "modprobe ath9k_htc"
		  Config Status: cfg=new, avail=yes, need=no, active=unknown
		  Attached to: #26 (Hub)
		...

but the region code sets to China, "=CN"

	dmesg | egrep -i "ath|80211"
		[    8.359444] usb 1-1.2: Manufacturer: ATHEROS
		[   16.427256] cfg80211: Loading compiled-in X.509 certificates for regulatory database
		[   16.427734] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47abc4dd84'
		[   16.871247] usb 1-1.2: ath9k_htc: Firmware ath9k_htc/htc_9271-1.4.0.fw requested
		[   16.871435] usbcore: registered new interface driver ath9k_htc
		[   17.019552] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 3572, rev 0223 detected
		[   17.032734] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0009 detected
		[   17.033106] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
		[   17.284607] usb 1-1.2: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
		[   17.536427] ath9k_htc 1-1.2:1.0: ath9k_htc: HTC initialized with 33 credits
		[   17.803159] ath9k_htc 1-1.2:1.0: ath9k_htc: FW Version: 1.4
		[   17.803163] ath9k_htc 1-1.2:1.0: FW RMW support: On
		[   17.803166] ath: EEPROM regdomain: 0x809c
		[   17.803166] ath: EEPROM indicates we should expect a country code
		[   17.803168] ath: doing EEPROM country->regdmn map search
		[   17.803169] ath: country maps to regdmn code: 0x52
>>>		[   17.803170] ath: Country alpha2 being used: CN
		[   17.803171] ath: Regpair used: 0x52
		[   17.817209] ieee80211 phy1: Atheros AR9271 Rev:1
		[   17.820065] ath9k_htc 1-1.2:1.0 wlp0s20u1u2: renamed from wlan0

and


	iw reg get
		global
		country CN: DFS-FCC
		        (2402 - 2482 @ 40), (N/A, 20), (N/A)
		        (5170 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
		        (5250 - 5330 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
		        (5735 - 5835 @ 80), (N/A, 30), (N/A)
		        (57240 - 59400 @ 2160), (N/A, 28), (N/A)
		        (59400 - 63720 @ 2160), (N/A, 44), (N/A)
		        (63720 - 65880 @ 2160), (N/A, 28), (N/A)

		phy#1
		country CN: DFS-FCC
		        (2402 - 2482 @ 40), (N/A, 20), (N/A)
		        (5170 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
		        (5250 - 5330 @ 80), (N/A, 23), (0 ms), DFS, AUTO-BW
		        (5735 - 5835 @ 80), (N/A, 30), (N/A)
		        (57240 - 59400 @ 2160), (N/A, 28), (N/A)
		        (59400 - 63720 @ 2160), (N/A, 44), (N/A)
		        (63720 - 65880 @ 2160), (N/A, 28), (N/A)

even with

	cat /etc/modprobe.d/atheros.conf
		ath cn=US
		cfg80211 ieee80211_regdom=US


what add'l config/workaround is needed to set the reg domain country? add'l kernel config? or 


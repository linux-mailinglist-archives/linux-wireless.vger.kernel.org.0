Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB00EA1519
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2019 11:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfH2Jm5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 05:42:57 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:40941 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfH2Jm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 05:42:57 -0400
Received: by mail-pg1-f178.google.com with SMTP id w10so1303675pgj.7
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2019 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ODBUuSi7LrtKYxLPPsu8KHTgcuRckdT0f0bcpdll72E=;
        b=E+4DFgWAK00EPJlmzMrQeN6iVqAgbXqb/+7B/8bbjAgv2GhBtmKGH60HCLQX513ydt
         GcwfUcVHoCoM807rqtHu20V8qaxNGZGN9N9MoMkxeQYx/uVIpRGbiBBCMbly8kjGakS2
         vtQVqS2tsBL7bwJIxqKXcih2UOouw6KEv5Aim9TqmXWTPWVv8C5esvEQDyZ5+iH1DSBp
         Qix+GA2vFE692LOrm2G/XI+3q7Dp3qpkepL04CVC6wWZSu4A9fC1ePfWIb7nqcI/0yio
         Ri+0ohOh3qFs/P1dCpwVj0KkPCSSxLCzQW063I6EvktuQheUMyQghPqAPSw4WJGRS0G3
         MiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ODBUuSi7LrtKYxLPPsu8KHTgcuRckdT0f0bcpdll72E=;
        b=DC+v4RSgZrljNGpy6IdqgQ2B1kFO8j/ul4eK3t6JFDa8zXBsVpJS3LHH4IsqLI4gB+
         GsU+58RZz9zKISaqzdR3sCULl6hr05tu5o76KLq6X7bUlG/1WEwBFC6RcoBquUNMqNf2
         IeayHuJ3NUFOT6TF+0aNhweQuZB5eSBinM/M8JGpKOlemn5VKDfpWomp0p6XUUTMN8+l
         lLAxuYSuOrtPHhzyj/kyvlHh1REEGiAUQB0Oeq9HARiNh96hdjMntr8EUg1XrOi9amPK
         CTH/+m2UHOTv2RHmFhT0NljeXnjxM82g5yMGEi/XEtI6tubkNW8Iq9wnRDQ71YIhAKwa
         li3Q==
X-Gm-Message-State: APjAAAW1puRreVv49IC/OC9Q3hLdVOmkDYnbu+eQGBkB/oThYoTTguZh
        jOkdC2gKaCaz7R1HtSRM0OWSNMH2bqpPG4HLddha9rAl
X-Google-Smtp-Source: APXvYqxgKJcRg0d3idr5vjXTPuha+VD0WxK+Pczw2PqJ4/FMGfCUD22H8fte9vTAE+8mJdpXLkgIGcDsbsfZhBOfG+8=
X-Received: by 2002:a63:b60b:: with SMTP id j11mr7228908pgf.283.1567071776015;
 Thu, 29 Aug 2019 02:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJp6tx-L0Q4_OaUp+xMod0jsLjAByqnbrvk=JbEq5LOxTdhr_g@mail.gmail.com>
In-Reply-To: <CAJp6tx-L0Q4_OaUp+xMod0jsLjAByqnbrvk=JbEq5LOxTdhr_g@mail.gmail.com>
From:   Sergey Maranchuk <slav0nic0@gmail.com>
Date:   Thu, 29 Aug 2019 12:42:44 +0300
Message-ID: <CAJp6tx-RcubaTdL4tK1fuLv08s-pqU+RQz4m1mb1LRhg3625zw@mail.gmail.com>
Subject: rt2x00: 5Ghz signal power degradation with linux 5.2 kernel
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I got some problem after upgrade kernel to 5.2 version (debian testing
linux-image-5.2.0-2-amd64). 5Ghz client  stopped to see AP.
Some tests with 1metre distance between client-AP: 2.4Ghz  -22dBm, for
5Ghz - 53dBm !, for longer distance (8m + walls) 2.4 - 61dBm, 5Ghz not
visible.
All works fine with kernel 4.19 and on windows 10, other devices also
see AP without any problems with same distance.


Client Device - Alfa AWUS051NH

# lsmod |grep rt2
rt2800usb              28672  0
rt2x00usb              28672  1 rt2800usb
rt2800lib             135168  1 rt2800usb
rt2x00lib              69632  3 rt2800usb,rt2x00usb,rt2800lib
mac80211              868352  3 rt2x00lib,rt2x00usb,rt2800lib
cfg80211              819200  2 rt2x00lib,mac80211
crc_ccitt              16384  1 rt2800lib
usbcore               299008  9
xhci_hcd,rt2800usb,usbhid,xpad,usblp,usb_storage,xhci_pci,uas,rt2x00usb

# uname -a
Linux pc 5.2.0-2-amd64 #1 SMP Debian 5.2.9-2 (2019-08-21) x86_64 GNU/Linux

# modinfo rt2800usb
filename:
/lib/modules/5.2.0-2-amd64/kernel/drivers/net/wireless/ralink/rt2x00/rt2800usb.ko
license:        GPL
firmware:       rt2870.bin
description:    Ralink RT2800 USB Wireless LAN driver.
version:        2.3.0
author:         http://rt2x00.serialmonkey.com
srcversion:     554185273066F7CCC831E83
...


# dmesg|grep "rt2\|ieee8"
[    8.750465] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 2872,
rev 0202 detected
[    8.806271] ieee80211 phy0: rt2x00_set_rf: Info - RF chipset 0004 detected
[    8.822990] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[    8.823491] usbcore: registered new interface driver rt2800usb
[    8.829996] rt2800usb 3-3:1.0 wlx00c0ca32d4ad: renamed from wlan0
[   10.180340] ieee80211 phy0: rt2x00lib_request_firmware: Info -
Loading firmware file 'rt2870.bin'
[   10.181479] rt2800usb 3-3:1.0: firmware: direct-loading firmware rt2870.bin
[   10.181485] ieee80211 phy0: rt2x00lib_request_firmware: Info -
Firmware detected - version: 0.36

# lsusb
Bus 003 Device 005: ID 148f:2770 Ralink Technology, Corp. RT2770
Wireless Adapter

#  iw reg get
global
country UA: DFS-ETSI
(2400 - 2483 @ 40), (N/A, 20), (N/A), NO-OUTDOOR
(5150 - 5250 @ 80), (N/A, 20), (N/A), NO-OUTDOOR, AUTO-BW
(5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
(5490 - 5670 @ 160), (N/A, 20), (0 ms), DFS
(5735 - 5835 @ 80), (N/A, 20), (N/A)
(57000 - 66000 @ 2160), (N/A, 40), (N/A)

resetting to 00 didn't help

# iwlist wlx00c0ca32d4ad txpower
wlx00c0ca32d4ad  unknown transmit-power information.

          Current Tx-Power=20 dBm   (100 mW)

# iw list
Wiphy phy0
max # scan SSIDs: 4
max scan IEs length: 2257 bytes
max # sched scan SSIDs: 0
max # match sets: 0
max # scan plans: 1
max scan plan interval: -1
max scan plan iterations: 0
Retry short long limit: 2
Coverage class: 0 (up to 0m)
Device supports RSN-IBSS.
Supported Ciphers:
* WEP40 (00-0f-ac:1)
* WEP104 (00-0f-ac:5)
* TKIP (00-0f-ac:2)
* CCMP-128 (00-0f-ac:4)
* CCMP-256 (00-0f-ac:10)
* GCMP-128 (00-0f-ac:8)
* GCMP-256 (00-0f-ac:9)
Available Antennas: TX 0 RX 0
Supported interface modes:
* IBSS
* managed
* AP
* AP/VLAN
* monitor
* mesh point
Band 1:
Capabilities: 0x27e
HT20/HT40
SM Power Save disabled
RX Greenfield
RX HT20 SGI
RX HT40 SGI
RX STBC 2-streams
Max AMSDU length: 3839 bytes
No DSSS/CCK HT40
Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
Minimum RX AMPDU time spacing: 2 usec (0x04)
HT RX MCS rate indexes supported: 0-15, 32
TX unequal modulation not supported
HT TX Max spatial streams: 1
HT TX MCS rate indexes supported may differ
Bitrates (non-HT):
* 1.0 Mbps
* 2.0 Mbps (short preamble supported)
* 5.5 Mbps (short preamble supported)
* 11.0 Mbps (short preamble supported)
* 6.0 Mbps
* 9.0 Mbps
* 12.0 Mbps
* 18.0 Mbps
* 24.0 Mbps
* 36.0 Mbps
* 48.0 Mbps
* 54.0 Mbps
Frequencies:
* 2412 MHz [1] (20.0 dBm)
* 2417 MHz [2] (20.0 dBm)
* 2422 MHz [3] (20.0 dBm)
* 2427 MHz [4] (20.0 dBm)
* 2432 MHz [5] (20.0 dBm)
* 2437 MHz [6] (20.0 dBm)
* 2442 MHz [7] (20.0 dBm)
* 2447 MHz [8] (20.0 dBm)
* 2452 MHz [9] (20.0 dBm)
* 2457 MHz [10] (20.0 dBm)
* 2462 MHz [11] (20.0 dBm)
* 2467 MHz [12] (20.0 dBm)
* 2472 MHz [13] (20.0 dBm)
* 2484 MHz [14] (disabled)
Band 2:
Capabilities: 0x27e
HT20/HT40
SM Power Save disabled
RX Greenfield
RX HT20 SGI
RX HT40 SGI
RX STBC 2-streams
Max AMSDU length: 3839 bytes
No DSSS/CCK HT40
Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
Minimum RX AMPDU time spacing: 2 usec (0x04)
HT RX MCS rate indexes supported: 0-15, 32
TX unequal modulation not supported
HT TX Max spatial streams: 1
HT TX MCS rate indexes supported may differ
Bitrates (non-HT):
* 6.0 Mbps
* 9.0 Mbps
* 12.0 Mbps
* 18.0 Mbps
* 24.0 Mbps
* 36.0 Mbps
* 48.0 Mbps
* 54.0 Mbps
Frequencies:
* 5180 MHz [36] (20.0 dBm)
* 5190 MHz [38] (20.0 dBm)
* 5200 MHz [40] (20.0 dBm)
* 5220 MHz [44] (20.0 dBm)
* 5230 MHz [46] (20.0 dBm)
* 5240 MHz [48] (20.0 dBm)
* 5260 MHz [52] (20.0 dBm) (radar detection)
* 5270 MHz [54] (20.0 dBm) (radar detection)
* 5280 MHz [56] (20.0 dBm) (radar detection)
* 5300 MHz [60] (20.0 dBm) (radar detection)
* 5310 MHz [62] (20.0 dBm) (radar detection)
* 5320 MHz [64] (20.0 dBm) (radar detection)
* 5500 MHz [100] (20.0 dBm) (radar detection)
* 5510 MHz [102] (20.0 dBm) (radar detection)
* 5520 MHz [104] (20.0 dBm) (radar detection)
* 5540 MHz [108] (20.0 dBm) (radar detection)
* 5550 MHz [110] (20.0 dBm) (radar detection)
* 5560 MHz [112] (20.0 dBm) (radar detection)
* 5580 MHz [116] (20.0 dBm) (radar detection)
* 5590 MHz [118] (20.0 dBm) (radar detection)
* 5600 MHz [120] (20.0 dBm) (radar detection)
* 5620 MHz [124] (20.0 dBm) (radar detection)
* 5630 MHz [126] (20.0 dBm) (radar detection)
* 5640 MHz [128] (20.0 dBm) (radar detection)
* 5660 MHz [132] (20.0 dBm) (radar detection)
* 5670 MHz [134] (disabled)
* 5680 MHz [136] (disabled)
* 5700 MHz [140] (disabled)
* 5745 MHz [149] (20.0 dBm)
* 5755 MHz [151] (20.0 dBm)
* 5765 MHz [153] (20.0 dBm)
* 5785 MHz [157] (20.0 dBm)
* 5795 MHz [159] (20.0 dBm)
* 5805 MHz [161] (20.0 dBm)
* 5825 MHz [165] (20.0 dBm)
* 5835 MHz [167] (disabled)
* 5845 MHz [169] (disabled)
* 5855 MHz [171] (disabled)
* 5865 MHz [173] (disabled)
* 4920 MHz [184] (disabled)
* 4940 MHz [188] (disabled)
* 4960 MHz [192] (disabled)
* 4980 MHz [196] (disabled)
* 6040 MHz [208] (disabled)
* 6060 MHz [212] (disabled)
* 6080 MHz [216] (disabled)
Supported commands:
* new_interface
* set_interface
* new_key
* start_ap
* new_station
* new_mpath
* set_mesh_config
* set_bss
* authenticate
* associate
* deauthenticate
* disassociate
* join_ibss
* join_mesh
* set_tx_bitrate_mask
* frame
* frame_wait_cancel
* set_wiphy_netns
* set_channel
* set_wds_peer
* probe_client
* set_noack_map
* register_beacons
* start_p2p_device
* set_mcast_rate
* connect
* disconnect
* set_qos_map
* set_multicast_to_unicast
Supported TX frame types:
* IBSS: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0
0xc0 0xd0 0xe0 0xf0
* managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0
0xc0 0xd0 0xe0 0xf0
* AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0
0xd0 0xe0 0xf0
* AP/VLAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0
0xc0 0xd0 0xe0 0xf0
* mesh point: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0
0xb0 0xc0 0xd0 0xe0 0xf0
* P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0
0xb0 0xc0 0xd0 0xe0 0xf0
* P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0
0xc0 0xd0 0xe0 0xf0
* P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0
0xb0 0xc0 0xd0 0xe0 0xf0
Supported RX frame types:
* IBSS: 0x40 0xb0 0xc0 0xd0
* managed: 0x40 0xd0
* AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
* AP/VLAN: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
* mesh point: 0xb0 0xc0 0xd0
* P2P-client: 0x40 0xd0
* P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
* P2P-device: 0x40 0xd0
software interface modes (can always be added):
* AP/VLAN
* monitor
valid interface combinations:
* #{ AP, mesh point } <= 8,
  total <= 8, #channels <= 1
HT Capability overrides:
* MCS: ff ff ff ff ff ff ff ff ff ff
* maximum A-MSDU length
* supported channel width
* short GI for 40 MHz
* max A-MPDU length exponent
* min MPDU start spacing
Device supports TX status socket option.
Device supports HT-IBSS.
Device supports SAE with AUTHENTICATE command
Device supports low priority scan.
Device supports scan flush.
Device supports AP scan.
Device supports per-vif TX power setting
Driver supports full state transitions for AP/GO clients
Driver supports a userspace MPM
Device supports configuring vdev MAC-addr on create.
Supported extended features:
* [ RRM ]: RRM
* [ FILS_STA ]: STA FILS (Fast Initial Link Setup)
* [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
* [ CONTROL_PORT_OVER_NL80211 ]: control port over nl80211

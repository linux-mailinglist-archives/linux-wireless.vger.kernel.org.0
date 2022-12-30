Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B874659B05
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Dec 2022 18:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiL3Rja (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Dec 2022 12:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3Rj3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Dec 2022 12:39:29 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CD21B1E2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Dec 2022 09:39:27 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2fHt-1p7CLb0J39-0047zH; Fri, 30 Dec 2022 18:39:24 +0100
Message-ID: <2635fd4f-dfa0-1d87-058b-e455cee96750@i2se.com>
Date:   Fri, 30 Dec 2022 18:39:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
From:   Stefan Wahren <stefan.wahren@i2se.com>
Subject: brcmfmac: Unexpected cfg80211_set_channel: set chanspec ... fail,
 reason -52
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G+RGr9oTSeGDc97JJx9XjHIk4IEkv69vgtiDTzgOeKCM6/mX6JC
 rnTiVHrtRHDeuzcb9M4e7wiUbG7gfEA8SZJk6kARKYrGe7Vi0c1/EjQccBbswBMQnYlu/ou
 GVufklVAOjZPW6WAvKrYLzBkZABMtC2JBoLjjdjic/Nfx5csn4XsMzg3TG7hr5gB7WIBJFg
 xohNc0Ft+xrjXY83kZCxg==
UI-OutboundReport: notjunk:1;M01:P0:NbZWoo6Ywwg=;2jrAQyY/YRVXdMvfQNEt4MS4zHa
 KOmeyXenUo2utOx9tujcsdUO/WoiSaeUx9FenvZBBNYHpu9l6t5GPvTIaeWD8gVw+tGxVBpQ5
 0qNqD3M6TE1a95suiPR5YcgD3kZ91wbgbVgaFB/NJpIFkj2V8WYOv8FEDIkI2C0r3qEN6MWXz
 jdCnDckTMQe7Y4rWg5f4CdsCHgzUMpZTEg3T6pmL86YIsYRw1TnJ0exM5UV3ALrGK3E4Seac3
 JDw0W5eU39W2eCWJEysaD0Re7kXQXWXC7UQctHxLd0s+dbtlx03wMvfuR4880lY/iEUqgH2l1
 /OUC3ADxErdvoffG3s8VXWG1CrePNlCH0bCpcAenQadpIjYfndGTRNk4GvTkPSHYjqf9qAaVp
 g5cYB9m8pDMDBQh3H4XBBTVoXzElE/pRdNsMmSfdNsf+EXy8Y0k/iIUOdros88A08WmF9Yg3q
 1xu7W2pFhIz9IDa54jdptYidqNpwY4eByvQq7uzHwGHVyAuZKuJjRf7/38fOujw9UQ9Xu50Kk
 FMhg8kY6B+ZwWYufo4Bxw2NkcqIgjhrcTj3NktW4rzF+ehG70ieJ8JleMglHaVoX/QoT3IIai
 G7ijyMX/0UK71bwroDaBhTtY3cTBul9HJgsPfkM4YExS7fCFionu/9V3A1s9lQ1wB/Vsi3GIc
 BASk9EQBKzQHV/R56EsFvNNK09/Vj6D3J73dKwF2/Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

since Linux 6.2-rc1 i noticed on my Raspberry Pi 3 B+ 
(arm/multi_v7_defconfig) the following new error messages appear, even 
if there is no Wifi connection. I suspect this is not a real issue, so 
it would nice to get the rid of it:

[   26.303445] brcmfmac: brcmf_fw_alloc_request: using 
brcm/brcmfmac43455-sdio for chip BCM4345/6
[   26.303554] brcmfmac mmc1:0001:1: Direct firmware load for 
brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with error -2
[   26.516752] brcmfmac_wcc: brcmf_wcc_attach: executing
[   26.528264] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: 
Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e
[   27.076829] Bluetooth: hci0: BCM: features 0x2f
[   27.078592] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
[   27.078601] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342
[   30.142104] Adding 102396k swap on /var/swap.  Priority:-2 extents:1 
across:102396k SS
[   30.590017] Bluetooth: MGMT ver 1.22
[  104.897615] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail, 
reason -52
[  104.897992] brcmfmac: cfg80211_set_channel: set chanspec 0xd022 fail, 
reason -52
[  105.007672] brcmfmac: cfg80211_set_channel: set chanspec 0xd026 fail, 
reason -52
[  105.117654] brcmfmac: cfg80211_set_channel: set chanspec 0xd02a fail, 
reason -52
[  105.227636] brcmfmac: cfg80211_set_channel: set chanspec 0xd02e fail, 
reason -52
[  106.987552] brcmfmac: cfg80211_set_channel: set chanspec 0xd090 fail, 
reason -52
[  106.987911] brcmfmac: cfg80211_set_channel: set chanspec 0xd095 fail, 
reason -52
[  106.988233] brcmfmac: cfg80211_set_channel: set chanspec 0xd099 fail, 
reason -52
[  106.988565] brcmfmac: cfg80211_set_channel: set chanspec 0xd09d fail, 
reason -52
[  106.988909] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a1 fail, 
reason -52

All of these 10 errors are repeated every 60 sec.

If i enable the debugging for brcmf_fil_cmd_data, i'm getting this:

[  107.069199] brcmfmac: Firmware error: BCME_BADCHAN (-20)
[  107.069232] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail, 
reason -52
[  107.069597] brcmfmac: Firmware error: BCME_BADCHAN (-20)
[  107.069610] brcmfmac: cfg80211_set_channel: set chanspec 0xd022 fail, 
reason -52
...

Here some additional information:

$ iw info

Interface wlan0
     ifindex 4
     wdev 0x1
     addr b8:27:eb:2e:ec:42
     type managed
     wiphy 0
     channel 140 (5700 MHz), width: 20 MHz, center1: 5700 MHz
     txpower 31.00 dBm

$ iw reg get

global
country DE: DFS-ETSI
     (2400 - 2483 @ 40), (N/A, 20), (N/A)
     (5150 - 5250 @ 80), (N/A, 20), (N/A), NO-OUTDOOR, AUTO-BW
     (5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
     (5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
     (5725 - 5875 @ 80), (N/A, 13), (N/A)
     (57000 - 66000 @ 2160), (N/A, 40), (N/A)

phy#0
country 99: DFS-UNSET
     (2402 - 2482 @ 40), (6, 20), (N/A)
     (2474 - 2494 @ 20), (6, 20), (N/A)
     (5140 - 5360 @ 160), (6, 20), (N/A)
     (5460 - 5860 @ 160), (6, 20), (N/A)

$ iw list

Wiphy phy0
     max # scan SSIDs: 10
     max scan IEs length: 2048 bytes
     max # sched scan SSIDs: 16
     max # match sets: 16
     Retry short limit: 7
     Retry long limit: 4
     Coverage class: 0 (up to 0m)
     Device supports roaming.
     Device supports T-DLS.
     Supported Ciphers:
         * WEP40 (00-0f-ac:1)
         * WEP104 (00-0f-ac:5)
         * TKIP (00-0f-ac:2)
         * CCMP-128 (00-0f-ac:4)
         * CMAC (00-0f-ac:6)
     Available Antennas: TX 0 RX 0
     Supported interface modes:
          * IBSS
          * managed
          * AP
          * P2P-client
          * P2P-GO
          * P2P-device
     Band 1:
         Capabilities: 0x1062
             HT20/HT40
             Static SM Power Save
             RX HT20 SGI
             RX HT40 SGI
             No RX STBC
             Max AMSDU length: 3839 bytes
             DSSS/CCK HT40
         Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
         Minimum RX AMPDU time spacing: 16 usec (0x07)
         HT TX/RX MCS rate indexes supported: 0-7
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
         Capabilities: 0x1062
             HT20/HT40
             Static SM Power Save
             RX HT20 SGI
             RX HT40 SGI
             No RX STBC
             Max AMSDU length: 3839 bytes
             DSSS/CCK HT40
         Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
         Minimum RX AMPDU time spacing: 16 usec (0x07)
         HT TX/RX MCS rate indexes supported: 0-7
         VHT Capabilities (0x00001020):
             Max MPDU length: 3895
             Supported Channel Width: neither 160 nor 80+80
             short GI (80 MHz)
             SU Beamformee
         VHT RX MCS set:
             1 streams: MCS 0-9
             2 streams: not supported
             3 streams: not supported
             4 streams: not supported
             5 streams: not supported
             6 streams: not supported
             7 streams: not supported
             8 streams: not supported
         VHT RX highest supported: 0 Mbps
         VHT TX MCS set:
             1 streams: MCS 0-9
             2 streams: not supported
             3 streams: not supported
             4 streams: not supported
             5 streams: not supported
             6 streams: not supported
             7 streams: not supported
             8 streams: not supported
         VHT TX highest supported: 0 Mbps
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
             * 5170 MHz [34] (disabled)
             * 5180 MHz [36] (20.0 dBm)
             * 5190 MHz [38] (disabled)
             * 5200 MHz [40] (20.0 dBm)
             * 5210 MHz [42] (disabled)
             * 5220 MHz [44] (20.0 dBm)
             * 5230 MHz [46] (disabled)
             * 5240 MHz [48] (20.0 dBm)
             * 5260 MHz [52] (20.0 dBm) (no IR, radar detection)
             * 5280 MHz [56] (20.0 dBm) (no IR, radar detection)
             * 5300 MHz [60] (20.0 dBm) (no IR, radar detection)
             * 5320 MHz [64] (20.0 dBm) (no IR, radar detection)
             * 5500 MHz [100] (20.0 dBm) (no IR, radar detection)
             * 5520 MHz [104] (20.0 dBm) (no IR, radar detection)
             * 5540 MHz [108] (20.0 dBm) (no IR, radar detection)
             * 5560 MHz [112] (20.0 dBm) (no IR, radar detection)
             * 5580 MHz [116] (20.0 dBm) (no IR, radar detection)
             * 5600 MHz [120] (20.0 dBm) (no IR, radar detection)
             * 5620 MHz [124] (20.0 dBm) (no IR, radar detection)
             * 5640 MHz [128] (20.0 dBm) (no IR, radar detection)
             * 5660 MHz [132] (20.0 dBm) (no IR, radar detection)
             * 5680 MHz [136] (20.0 dBm) (no IR, radar detection)
             * 5700 MHz [140] (20.0 dBm) (no IR, radar detection)
             * 5720 MHz [144] (disabled)
             * 5745 MHz [149] (disabled)
             * 5765 MHz [153] (disabled)
             * 5785 MHz [157] (disabled)
             * 5805 MHz [161] (disabled)
             * 5825 MHz [165] (disabled)
     Supported commands:
          * new_interface
          * set_interface
          * new_key
          * start_ap
          * join_ibss
          * set_pmksa
          * del_pmksa
          * flush_pmksa
          * remain_on_channel
          * frame
          * set_wiphy_netns
          * set_channel
          * tdls_oper
          * start_sched_scan
          * start_p2p_device
          * connect
          * disconnect
          * crit_protocol_start
          * crit_protocol_stop
          * update_connect_params
     software interface modes (can always be added):
     valid interface combinations:
          * #{ managed } <= 2, #{ P2P-device } <= 1, #{ P2P-client, 
P2P-GO } <= 1,
            total <= 3, #channels <= 2
          * #{ managed } <= 1, #{ AP } <= 1, #{ P2P-client } <= 1, #{ 
P2P-device } <= 1,
            total <= 4, #channels <= 1
     Device supports scan flush.
     Device supports randomizing MAC-addr in sched scans.
     max # scan plans: 1
     max scan plan interval: 508
     max scan plan iterations: 0
     Supported TX frame types:
          * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 
0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
          * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 
0xb0 0xc0 0xd0 0xe0 0xf0
          * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 
0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
          * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 
0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
          * P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 
0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
     Supported RX frame types:
          * managed: 0x40 0xd0
          * AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
          * P2P-client: 0x40 0xd0
          * P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
          * P2P-device: 0x40 0xd0
     Supported extended features:
         * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
         * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in 
station mode
         * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in 
station mode
         * [ DFS_OFFLOAD ]: DFS offload


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DFE65B6F1
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 20:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbjABTYD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 14:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjABTYC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 14:24:02 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C54B85E
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 11:24:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id u9so68759435ejo.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jan 2023 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F5J7nkXbnOblCH6bNUhXkxF89RTW71Q+ym0sTUv8fAQ=;
        b=gyKD0zLQS4FTp9HPO4rNPUV5tVrS20PLA1iWBXz24e/o2q1SRsUd2ibWzIG1yxeZWn
         ZOY+gDgGfxIsapBFD0+ZL4/sU9i9S7b0LVyllj5oj/cXe6Uw98yj58+bLh7A2mvg+3Jb
         UfoPS3PHYap6PLgI7BIkyovGoAH1jGB/fOKEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5J7nkXbnOblCH6bNUhXkxF89RTW71Q+ym0sTUv8fAQ=;
        b=Or+Y8t4U59Ej5v98/BFAirOOs0Bwr53O2clGqds01dj+mUDdb1Hc16AG4GYSexqPBA
         ozSU1/Dy/jjOQ1oVeDmSpgEYD5f8Nq+PTR8rp9aPowONsiNwcz8hUtl/HIkssSNFhi/I
         Xa6M/+rfX122z/u3qfalheFyHSW4GENs3mcqDXRIXLLZzaSDkFtdroPNJbb9Zad/q2s4
         b0kOxiic9hOUyT3AKJA/b0dHJjK8HxkJ/I+Ewe5n5KeDzY9C6EMuHfnJ64ez97fG1pmm
         hNe6Ghafv+6LeOkSl/zfonG0evNt8P3fvW3JGbloutfVl9/ntgzHDHU53d9mj31x4M6Y
         g33w==
X-Gm-Message-State: AFqh2kovEp0isdcFrCCdPCkVC8ZY8f6qf9WORnY9L7FXGuo/9Kro9xeB
        KHHzxo55WiG7x28VVUR+KITAzmy4k8Ufg00w
X-Google-Smtp-Source: AMrXdXsCEYe9SZSZ0FVAa5RzNYTaJK1ipsh60YPyRwbckWrHftg5vbkpCG9j+MAHtUpnSdmygQBwQA==
X-Received: by 2002:a17:906:a2d6:b0:7c0:bf7c:19f4 with SMTP id by22-20020a170906a2d600b007c0bf7c19f4mr35092610ejb.74.1672687438861;
        Mon, 02 Jan 2023 11:23:58 -0800 (PST)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id t15-20020a170906608f00b0078d9cd0d2d6sm13574420ejj.11.2023.01.02.11.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 11:23:57 -0800 (PST)
Message-ID: <1f428e2b-f73f-64ff-02d3-eefbcd11db89@broadcom.com>
Date:   Mon, 2 Jan 2023 20:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: brcmfmac: Unexpected cfg80211_set_channel: set chanspec ... fail,
 reason -52
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <2635fd4f-dfa0-1d87-058b-e455cee96750@i2se.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <2635fd4f-dfa0-1d87-058b-e455cee96750@i2se.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a090c905f14ce465"
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000a090c905f14ce465
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+ Johannes

On 12/30/2022 6:39 PM, Stefan Wahren wrote:
> Hi,
> 
> since Linux 6.2-rc1 i noticed on my Raspberry Pi 3 B+ 
> (arm/multi_v7_defconfig) the following new error messages appear, even 
> if there is no Wifi connection. I suspect this is not a real issue, so 
> it would nice to get the rid of it:
> 
> [   26.303445] brcmfmac: brcmf_fw_alloc_request: using 
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [   26.303554] brcmfmac mmc1:0001:1: Direct firmware load for 
> brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with error -2
> [   26.516752] brcmfmac_wcc: brcmf_wcc_attach: executing
> [   26.528264] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: 
> Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e
> [   27.076829] Bluetooth: hci0: BCM: features 0x2f
> [   27.078592] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
> [   27.078601] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342
> [   30.142104] Adding 102396k swap on /var/swap.  Priority:-2 extents:1 
> across:102396k SS
> [   30.590017] Bluetooth: MGMT ver 1.22
> [  104.897615] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail, 
> reason -52
> [  104.897992] brcmfmac: cfg80211_set_channel: set chanspec 0xd022 fail, 
> reason -52
> [  105.007672] brcmfmac: cfg80211_set_channel: set chanspec 0xd026 fail, 
> reason -52
> [  105.117654] brcmfmac: cfg80211_set_channel: set chanspec 0xd02a fail, 
> reason -52
> [  105.227636] brcmfmac: cfg80211_set_channel: set chanspec 0xd02e fail, 
> reason -52
> [  106.987552] brcmfmac: cfg80211_set_channel: set chanspec 0xd090 fail, 
> reason -52
> [  106.987911] brcmfmac: cfg80211_set_channel: set chanspec 0xd095 fail, 
> reason -52
> [  106.988233] brcmfmac: cfg80211_set_channel: set chanspec 0xd099 fail, 
> reason -52
> [  106.988565] brcmfmac: cfg80211_set_channel: set chanspec 0xd09d fail, 
> reason -52
> [  106.988909] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a1 fail, 
> reason -52
> 
> All of these 10 errors are repeated every 60 sec.

Catching up after the holidays ;-) Above chanspec values are invalid. 
0x100e = channel 14/bw 20MHz. The 'iw list' output shows all these 
channels are disabled. So who/what is trying to set these channels. 
Scanning sets the channel in firmware. Is this initiated from hostapd? 
Maybe trying ACS? As these are marked as disabled user-space should not 
use them. What I don't understand is why these pass the cfg80211 layer 
so adding Johannes here.

Regards,
Arend

> If i enable the debugging for brcmf_fil_cmd_data, i'm getting this:
> 
> [  107.069199] brcmfmac: Firmware error: BCME_BADCHAN (-20)
> [  107.069232] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail, 
> reason -52
> [  107.069597] brcmfmac: Firmware error: BCME_BADCHAN (-20)
> [  107.069610] brcmfmac: cfg80211_set_channel: set chanspec 0xd022 fail, 
> reason -52
> ...
> 
> Here some additional information:
> 
> $ iw info
> 
> Interface wlan0
>      ifindex 4
>      wdev 0x1
>      addr b8:27:eb:2e:ec:42
>      type managed
>      wiphy 0
>      channel 140 (5700 MHz), width: 20 MHz, center1: 5700 MHz
>      txpower 31.00 dBm
> 
> $ iw reg get
> 
> global
> country DE: DFS-ETSI
>      (2400 - 2483 @ 40), (N/A, 20), (N/A)
>      (5150 - 5250 @ 80), (N/A, 20), (N/A), NO-OUTDOOR, AUTO-BW
>      (5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
>      (5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
>      (5725 - 5875 @ 80), (N/A, 13), (N/A)
>      (57000 - 66000 @ 2160), (N/A, 40), (N/A)
> 
> phy#0
> country 99: DFS-UNSET
>      (2402 - 2482 @ 40), (6, 20), (N/A)
>      (2474 - 2494 @ 20), (6, 20), (N/A)
>      (5140 - 5360 @ 160), (6, 20), (N/A)
>      (5460 - 5860 @ 160), (6, 20), (N/A)
> 
> $ iw list
> 
> Wiphy phy0
>      max # scan SSIDs: 10
>      max scan IEs length: 2048 bytes
>      max # sched scan SSIDs: 16
>      max # match sets: 16
>      Retry short limit: 7
>      Retry long limit: 4
>      Coverage class: 0 (up to 0m)
>      Device supports roaming.
>      Device supports T-DLS.
>      Supported Ciphers:
>          * WEP40 (00-0f-ac:1)
>          * WEP104 (00-0f-ac:5)
>          * TKIP (00-0f-ac:2)
>          * CCMP-128 (00-0f-ac:4)
>          * CMAC (00-0f-ac:6)
>      Available Antennas: TX 0 RX 0
>      Supported interface modes:
>           * IBSS
>           * managed
>           * AP
>           * P2P-client
>           * P2P-GO
>           * P2P-device
>      Band 1:
>          Capabilities: 0x1062
>              HT20/HT40
>              Static SM Power Save
>              RX HT20 SGI
>              RX HT40 SGI
>              No RX STBC
>              Max AMSDU length: 3839 bytes
>              DSSS/CCK HT40
>          Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
>          Minimum RX AMPDU time spacing: 16 usec (0x07)
>          HT TX/RX MCS rate indexes supported: 0-7
>          Bitrates (non-HT):
>              * 1.0 Mbps
>              * 2.0 Mbps (short preamble supported)
>              * 5.5 Mbps (short preamble supported)
>              * 11.0 Mbps (short preamble supported)
>              * 6.0 Mbps
>              * 9.0 Mbps
>              * 12.0 Mbps
>              * 18.0 Mbps
>              * 24.0 Mbps
>              * 36.0 Mbps
>              * 48.0 Mbps
>              * 54.0 Mbps
>          Frequencies:
>              * 2412 MHz [1] (20.0 dBm)
>              * 2417 MHz [2] (20.0 dBm)
>              * 2422 MHz [3] (20.0 dBm)
>              * 2427 MHz [4] (20.0 dBm)
>              * 2432 MHz [5] (20.0 dBm)
>              * 2437 MHz [6] (20.0 dBm)
>              * 2442 MHz [7] (20.0 dBm)
>              * 2447 MHz [8] (20.0 dBm)
>              * 2452 MHz [9] (20.0 dBm)
>              * 2457 MHz [10] (20.0 dBm)
>              * 2462 MHz [11] (20.0 dBm)
>              * 2467 MHz [12] (20.0 dBm)
>              * 2472 MHz [13] (20.0 dBm)
>              * 2484 MHz [14] (disabled)
>      Band 2:
>          Capabilities: 0x1062
>              HT20/HT40
>              Static SM Power Save
>              RX HT20 SGI
>              RX HT40 SGI
>              No RX STBC
>              Max AMSDU length: 3839 bytes
>              DSSS/CCK HT40
>          Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
>          Minimum RX AMPDU time spacing: 16 usec (0x07)
>          HT TX/RX MCS rate indexes supported: 0-7
>          VHT Capabilities (0x00001020):
>              Max MPDU length: 3895
>              Supported Channel Width: neither 160 nor 80+80
>              short GI (80 MHz)
>              SU Beamformee
>          VHT RX MCS set:
>              1 streams: MCS 0-9
>              2 streams: not supported
>              3 streams: not supported
>              4 streams: not supported
>              5 streams: not supported
>              6 streams: not supported
>              7 streams: not supported
>              8 streams: not supported
>          VHT RX highest supported: 0 Mbps
>          VHT TX MCS set:
>              1 streams: MCS 0-9
>              2 streams: not supported
>              3 streams: not supported
>              4 streams: not supported
>              5 streams: not supported
>              6 streams: not supported
>              7 streams: not supported
>              8 streams: not supported
>          VHT TX highest supported: 0 Mbps
>          Bitrates (non-HT):
>              * 6.0 Mbps
>              * 9.0 Mbps
>              * 12.0 Mbps
>              * 18.0 Mbps
>              * 24.0 Mbps
>              * 36.0 Mbps
>              * 48.0 Mbps
>              * 54.0 Mbps
>          Frequencies:
>              * 5170 MHz [34] (disabled)
>              * 5180 MHz [36] (20.0 dBm)
>              * 5190 MHz [38] (disabled)
>              * 5200 MHz [40] (20.0 dBm)
>              * 5210 MHz [42] (disabled)
>              * 5220 MHz [44] (20.0 dBm)
>              * 5230 MHz [46] (disabled)
>              * 5240 MHz [48] (20.0 dBm)
>              * 5260 MHz [52] (20.0 dBm) (no IR, radar detection)
>              * 5280 MHz [56] (20.0 dBm) (no IR, radar detection)
>              * 5300 MHz [60] (20.0 dBm) (no IR, radar detection)
>              * 5320 MHz [64] (20.0 dBm) (no IR, radar detection)
>              * 5500 MHz [100] (20.0 dBm) (no IR, radar detection)
>              * 5520 MHz [104] (20.0 dBm) (no IR, radar detection)
>              * 5540 MHz [108] (20.0 dBm) (no IR, radar detection)
>              * 5560 MHz [112] (20.0 dBm) (no IR, radar detection)
>              * 5580 MHz [116] (20.0 dBm) (no IR, radar detection)
>              * 5600 MHz [120] (20.0 dBm) (no IR, radar detection)
>              * 5620 MHz [124] (20.0 dBm) (no IR, radar detection)
>              * 5640 MHz [128] (20.0 dBm) (no IR, radar detection)
>              * 5660 MHz [132] (20.0 dBm) (no IR, radar detection)
>              * 5680 MHz [136] (20.0 dBm) (no IR, radar detection)
>              * 5700 MHz [140] (20.0 dBm) (no IR, radar detection)
>              * 5720 MHz [144] (disabled)
>              * 5745 MHz [149] (disabled)
>              * 5765 MHz [153] (disabled)
>              * 5785 MHz [157] (disabled)
>              * 5805 MHz [161] (disabled)
>              * 5825 MHz [165] (disabled)
>      Supported commands:
>           * new_interface
>           * set_interface
>           * new_key
>           * start_ap
>           * join_ibss
>           * set_pmksa
>           * del_pmksa
>           * flush_pmksa
>           * remain_on_channel
>           * frame
>           * set_wiphy_netns
>           * set_channel
>           * tdls_oper
>           * start_sched_scan
>           * start_p2p_device
>           * connect
>           * disconnect
>           * crit_protocol_start
>           * crit_protocol_stop
>           * update_connect_params
>      software interface modes (can always be added):
>      valid interface combinations:
>           * #{ managed } <= 2, #{ P2P-device } <= 1, #{ P2P-client, 
> P2P-GO } <= 1,
>             total <= 3, #channels <= 2
>           * #{ managed } <= 1, #{ AP } <= 1, #{ P2P-client } <= 1, #{ 
> P2P-device } <= 1,
>             total <= 4, #channels <= 1
>      Device supports scan flush.
>      Device supports randomizing MAC-addr in sched scans.
>      max # scan plans: 1
>      max scan plan interval: 508
>      max scan plan iterations: 0
>      Supported TX frame types:
>           * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 
> 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>           * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 
> 0xb0 0xc0 0xd0 0xe0 0xf0
>           * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 
> 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>           * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 
> 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>           * P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 
> 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
>      Supported RX frame types:
>           * managed: 0x40 0xd0
>           * AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
>           * P2P-client: 0x40 0xd0
>           * P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
>           * P2P-device: 0x40 0xd0
>      Supported extended features:
>          * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>          * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK in 
> station mode
>          * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with 802.1X in 
> station mode
>          * [ DFS_OFFLOAD ]: DFS offload
> 

--000000000000a090c905f14ce465
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB5t6artu2lvpQPd6Il
B3VDE9dDh2qH09sgt2wr9wlIuzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzAxMDIxOTIzNTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAeAqcRfx44//+MBzfhhe00n1uyelMyORXLFrM
KzQBund0x3LuAWQAbddIj/J277ofdr4T7syL3MDkzVb4hCktZkcWG9xLDXMc6njJyB41vHKBjbP4
TXptnG7pWLD3tZ8g7JrAnu91lAAF+DeCzO5h1CN4CGC5Jlm1qr/GzjT8JwhKoWxAKJlgfeBgZjxE
NZPxGYp/9J2ZyoRya+hrOxloXY5uzDPK1/fnH02f1NkYj7CmTNdYC5W9h/9ic+6p/ZbQavq3A9Kf
1j58xp5ODZtLRj3fc8nj6dmppD8x7LTmfUT/r4AxDmSKG+2atvdTEEt5LebI9edpRlOi/QYjd+iD
yQ==
--000000000000a090c905f14ce465--

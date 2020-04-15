Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCCB1AAF72
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 19:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410910AbgDORXm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410902AbgDORXj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 13:23:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F825C061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2020 10:23:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e5so5966439edq.5
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2020 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=i0tWakd3cSad3amTULDNAwA4Dz9B+jmw+a9flZaBQS8=;
        b=JT4LpdKRk8x0VTJDE+5bpk1ZVHu5V9ijKEL80ehylTfzhQfRSXS5p3VABVLwSXlRJy
         AjmbfCZH8zmBWZm1ygZs6ZUcXnpFG5o//ifDKMbjYvB0hOag0OIPVTkhPZevRfvDnsiV
         wSqjAozs5IzjAW/hzwsStK3+xMF1a2SeXaiw/iWYm4Se4AxK9uXgKyUrzxvA0ocejYso
         J4VLYBxYzyILVgFiuSZNkTCo8VRj8E4oQmAVwT0OPWRSwbL/kTk9SYQ7efDVTAA4KfF+
         TCeRhckZNssHbefWDsACmEjXYc410HDCuR70XgQN1QoWyduaHbEDn1SEEhZMJ2BTwm3t
         I5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i0tWakd3cSad3amTULDNAwA4Dz9B+jmw+a9flZaBQS8=;
        b=dStcXWTo7dHaz5+Y2xyf1xn7rN7qUkvysUZwAA9FRimVNaGpfVRn8vMte/TWCSC1Pd
         RP41r7MQeVRWFOfcEpZZholqRwXewGK9Ls0DRvR1XF8jcxLbYJHO3JXrEEXudcfMJQcc
         +LMQ6898Cp8I44POAXuce+2oqbNbvzZ8V6NgxKaTUtDYKkn1w3z9zTcQfKfkOZ6Yylpe
         zuocom1+/z+evDjwCwyZDQP/Tflg0SSwaIMoGaMkyPToorJtL3880PmnWciwCAbj2V0/
         2/BbKaCyN2BFzpIyI9v9UDekQbvvuh+TYN6DozKJVhAUs24ihOZ+MQffp28kWy0f5dA2
         DtNg==
X-Gm-Message-State: AGi0Pubhj8yE4l22wOTF8KGUxXXSBg/JTGj027J1SHl1fuGPhizMCytJ
        0Hh0V//bGbt7iWQkg07xvVL05mqrKPOknMWXb5gbaxjxocs=
X-Google-Smtp-Source: APiQypJuoUV31R9/MwhsfA12eh+PiNefQvpJgKHRDxlD1feCIr8PlU9UAPBvag/dc10te3+VzWbxxSNiPgo/pTtih7s=
X-Received: by 2002:a50:a7a6:: with SMTP id i35mr25507378edc.130.1586971416668;
 Wed, 15 Apr 2020 10:23:36 -0700 (PDT)
MIME-Version: 1.0
From:   James Prestwood <prestwoj@gmail.com>
Date:   Wed, 15 Apr 2020 10:23:25 -0700
Message-ID: <CAPv5Ue7kNRRf9esOKkQ=Kkx8f0_vdkiPYg24pzVsv3Dg71Ow_Q@mail.gmail.com>
Subject: Auth/Assoc/Connect events coming before CMD_CONNECT response (hwsim)
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have noticed this sometimes happening with mac80211_hwsim where the
Authenticate, Associate, and Connect events arrive in userspace before
the actual response to CMD_CONNECT. It seems to be a scheduling/timing
problem as turning on logging in hostapd or other applications "fixes"
the issue.

I have not seen this happen on any physical hardware, only with
mac80211_hwsim. But still, this does cause our testing framework to
fail, as IWD handles this case by assuming another userspace daemon is
running. It seems there needs to be some kind of wait/yield in
mac80211_hwsim so that the response to CMD_CONNECT comes before these
other events as it should.

Below is a relevant log of what is happening starting with the
CMD_CONNECT request. Note that in this case the connection fails, and
this is expected for this specific test. Still, the connect response
comes after all these other events.

< Request: Connect (0x2e) len 156 [ack]                               57.823865
    Interface Index: 15 (0x0000000f)
    Wiphy Frequency: 2412 (0x0000096c)
    MAC Address 02:00:00:00:02:00
    SSID: len 13
        54 65 73 74 42 6c 61 63 6b 6c 69 73 74           TestBlacklist
    Auth Type: 0 (0x00000000)
    Privacy: true
    Interface Socket Owner: true
    Cipher Suites Pairwise:
        CCMP (00:0f:ac) suite  04
    Cipher Suite Group: CCMP (00:0f:ac) suite  04
    AKM Suites:
        PSK; RSNA PSK (00:0f:ac) suite  02
    WPA Versions: 2 (0x00000002)
    Control Port: true
    Reserved: len 0
    Reserved: len 0
    Information Elements: len 41
        RSN:
            Group Data Cipher Suite: len 4
                CCMP (00:0f:ac) suite  04
            Pairwise Cipher Suite: len 4
                CCMP (00:0f:ac) suite  04
            AKM Suite: len 4
                PSK; RSNA PSK (00:0f:ac) suite  02
            RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
            RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
            01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f  ................
            ac 02 00 00                                      ....
        RM Enabled Capabilities: len 5
            Enabled: bit  4: Beacon Passive Measurement
            Enabled: bit  5: Beacon Active Measurement
            Enabled: bit  6: Beacon Table Measurement
            Operating Channel Max Measurement Duration: 0
            Non-Operating Channel Max Measurement Duration: 0
            Measurement Pilot Capability: 0
            70 00 00 00 00                                   p....
        Extended Capabilities: len 10
            Capability: bit  2: Extended channel switching
            Capability: bit 19: BSS transition
            Capability: bit 32: QoS Map
            Capability: bit 62: Opmode Notification
            04 00 08 00 01 00 00 40 00 01                    .......@..
> Event: New Station (0x13) len 32                                    57.824877
    Interface Index: 15 (0x0000000f)
    MAC Address 02:00:00:00:02:00
    Generation: 1 (0x00000001)
    Station Info: len 0
> Event: New Station (0x13) len 32                                    57.824898
    Interface Index: 15 (0x0000000f)
    MAC Address 02:00:00:00:02:00
    Generation: 1 (0x00000001)
    Station Info: len 0
> Event: Frame (0x3b) len 80                                          57.825838
    Wiphy: 2 (0x00000002)
    Interface Index: 7 (0x00000007)
    Wireless Device: 8589934593 (0x0000000200000001)
    Wiphy Frequency: 2412 (0x0000096c)
    RX Signal dBm: -20
    Frame: len 30
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 314
                Address 1 (RA): 02:00:00:00:02:00
                Address 2 (TA): 02:00:00:00:03:00
                Address 3: 02:00:00:00:02:00
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: Open (seq: 1, status: 0)
        b0 00 3a 01 02 00 00 00 02 00 02 00 00 00 03 00  ..:.............
        02 00 00 00 02 00 00 00 00 00 01 00 00 00        ..............
< Request: Frame (0x3b) len 52 [ack]                                  57.825929
    Interface Index: 7 (0x00000007)
    Wiphy Frequency: 2412 (0x0000096c)
    Frame: len 30
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 0
                Address 1 (RA): 02:00:00:00:03:00
                Address 2 (TA): 02:00:00:00:02:00
                Address 3: 02:00:00:00:02:00
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: Open (seq: 2, status: 17)
        b0 00 00 00 02 00 00 00 03 00 02 00 00 00 02 00  ................
        02 00 00 00 02 00 00 00 00 00 02 00 11 00        ..............
> Result: Frame (0x3b) len 12                                         57.825943
    Cookie: 4 (0x0000000000000004)
> Response: Frame (0x3b) len 4 [0x100]                                57.825945
    Status: Success (0)
> Event: Scan Aborted (0x23) len 368                                  57.825983
    Wiphy: 3 (0x00000003)
    Interface Index: 15 (0x0000000f)
    Wireless Device: 12884901892 (0x0000000300000004)
    Scan SSIDs: len 4
        0: len 0
    Scan Frequencies: len 304
        0: 2412 (0x0000096c)
        1: 2417 (0x00000971)
        2: 2422 (0x00000976)
        3: 2427 (0x0000097b)
        4: 2432 (0x00000980)
        5: 2437 (0x00000985)
        6: 2442 (0x0000098a)
        7: 2447 (0x0000098f)
        8: 2452 (0x00000994)
        9: 2457 (0x00000999)
        10: 2462 (0x0000099e)
        11: 2467 (0x000009a3)
        12: 2472 (0x000009a8)
        13: 2484 (0x000009b4)
        14: 5180 (0x0000143c)
        15: 5200 (0x00001450)
        16: 5220 (0x00001464)
        17: 5240 (0x00001478)
        18: 5260 (0x0000148c)
        19: 5280 (0x000014a0)
        20: 5300 (0x000014b4)
        21: 5320 (0x000014c8)
        22: 5500 (0x0000157c)
        23: 5520 (0x00001590)
        24: 5540 (0x000015a4)
        25: 5560 (0x000015b8)
        26: 5580 (0x000015cc)
        27: 5600 (0x000015e0)
        28: 5620 (0x000015f4)
        29: 5640 (0x00001608)
        30: 5660 (0x0000161c)
        31: 5680 (0x00001630)
        32: 5700 (0x00001644)
        33: 5745 (0x00001671)
        34: 5765 (0x00001685)
        35: 5785 (0x00001699)
        36: 5805 (0x000016ad)
        37: 5825 (0x000016c1)
    Information Elements: len 12
        Extended Capabilities: len 10
            Capability: bit  2: Extended channel switching
            Capability: bit 19: BSS transition
            Capability: bit 32: QoS Map
            Capability: bit 62: Opmode Notification
            04 00 08 00 01 00 00 40 00 01                    .......@..
    Scan Flags: 2056 (0x00000808)
> Event: Scan Aborted (0x23) len 368                                  57.825985
    Wiphy: 3 (0x00000003)
    Interface Index: 15 (0x0000000f)
    Wireless Device: 12884901892 (0x0000000300000004)
    Scan SSIDs: len 4
        0: len 0
    Scan Frequencies: len 304
        0: 2412 (0x0000096c)
        1: 2417 (0x00000971)
        2: 2422 (0x00000976)
        3: 2427 (0x0000097b)
        4: 2432 (0x00000980)
        5: 2437 (0x00000985)
        6: 2442 (0x0000098a)
        7: 2447 (0x0000098f)
        8: 2452 (0x00000994)
        9: 2457 (0x00000999)
        10: 2462 (0x0000099e)
        11: 2467 (0x000009a3)
        12: 2472 (0x000009a8)
        13: 2484 (0x000009b4)
        14: 5180 (0x0000143c)
        15: 5200 (0x00001450)
        16: 5220 (0x00001464)
        17: 5240 (0x00001478)
        18: 5260 (0x0000148c)
        19: 5280 (0x000014a0)
        20: 5300 (0x000014b4)
        21: 5320 (0x000014c8)
        22: 5500 (0x0000157c)
        23: 5520 (0x00001590)
        24: 5540 (0x000015a4)
        25: 5560 (0x000015b8)
        26: 5580 (0x000015cc)
        27: 5600 (0x000015e0)
        28: 5620 (0x000015f4)
        29: 5640 (0x00001608)
        30: 5660 (0x0000161c)
        31: 5680 (0x00001630)
        32: 5700 (0x00001644)
        33: 5745 (0x00001671)
        34: 5765 (0x00001685)
        35: 5785 (0x00001699)
        36: 5805 (0x000016ad)
        37: 5825 (0x000016c1)
    Information Elements: len 12
        Extended Capabilities: len 10
            Capability: bit  2: Extended channel switching
            Capability: bit 19: BSS transition
            Capability: bit 32: QoS Map
            Capability: bit 62: Opmode Notification
            04 00 08 00 01 00 00 40 00 01                    .......@..
    Scan Flags: 2056 (0x00000808)
> Event: Frame TX Status (0x3c) len 80                                57.826077
    Wiphy: 2 (0x00000002)
    Interface Index: 7 (0x00000007)
    Wireless Device: 8589934593 (0x0000000200000001)
    Frame: len 30
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 0
                Address 1 (RA): 02:00:00:00:03:00
                Address 2 (TA): 02:00:00:00:02:00
                Address 3: 02:00:00:00:02:00
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: Open (seq: 2, status: 17)
        b0 00 00 00 02 00 00 00 03 00 02 00 00 00 02 00  ................
        02 00 00 00 02 00 00 00 00 00 02 00 11 00        ..............
    Cookie: 4 (0x0000000000000004)
    ACK: true
> Event: Frame TX Status (0x3c) len 80                                57.826078
    Wiphy: 2 (0x00000002)
    Interface Index: 7 (0x00000007)
    Wireless Device: 8589934593 (0x0000000200000001)
    Frame: len 30
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 0
                Address 1 (RA): 02:00:00:00:03:00
                Address 2 (TA): 02:00:00:00:02:00
                Address 3: 02:00:00:00:02:00
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: Open (seq: 2, status: 17)
        b0 00 00 00 02 00 00 00 03 00 02 00 00 00 02 00  ................
        02 00 00 00 02 00 00 00 00 00 02 00 11 00        ..............
    Cookie: 4 (0x0000000000000004)
    ACK: true
> Event: Del Station (0x14) len 744                                   57.826941
    Interface Index: 15 (0x0000000f)
    MAC Address 02:00:00:00:02:00
    Generation: 2 (0x00000002)
    Station Info: len 712
        Connected time: 0 (0x00000000)
        Inactivity time: 1 (0x00000001)
        Reserved: len 8
            00 00 00 00 00 00 00 00                          ........
        Total RX bytes: 30 (0x0000001e)
        Total TX bytes: 30 (0x0000001e)
        Total RX bytes: 30 (0x000000000000001e)
        Total TX bytes: 30 (0x000000000000001e)
        Reserved: len 8
            00 00 00 00 00 00 00 00                          ........
        Reserved: len 8
            00 00 00 00 00 00 00 00                          ........
        Signal strength: -20
        Signal strength average: -20
        TX bitrate: len 16
            Bit Rate: 10 (0x0000000a)
            Bit Rate (Legacy): 10 (0x000a)
        RX packets: 2 (0x00000002)
        TX packets: 1 (0x00000001)
        TX retries: 10 (0x0000000a)
        TX failed: 0 (0x00000000)
        Beacon loss: 0 (0x00000000)
        BSS parameters: len 16
            DTIM Period: 0 (0x00)
            Beacon Interval: 100 (0x0064)
        Station flags: len 8
            Mask: 0x000000fe
                Authorized
                ShortPreamble
                WME
                MFP
                Authenticated
                TDLS-Peer
                Associated
            Set: 0x00000000
        Reserved: len 8
            00 00 00 00 00 00 00 00                          ........
        Reserved: len 8
            00 00 00 00 00 00 00 00                          ........
        Reserved: len 1
            00                                               .
        Reserved: len 476
            1c 00 01 00 0c 00 01 00 00 00 00 00 00 00 00 00  ................
            0c 00 02 00 00 00 00 00 00 00 00 00 1c 00 02 00  ................
            0c 00 01 00 00 00 00 00 00 00 00 00 0c 00 02 00  ................
            00 00 00 00 00 00 00 00 1c 00 03 00 0c 00 01 00  ................
            00 00 00 00 00 00 00 00 0c 00 02 00 00 00 00 00  ................
            00 00 00 00 1c 00 04 00 0c 00 01 00 00 00 00 00  ................
            00 00 00 00 0c 00 02 00 00 00 00 00 00 00 00 00  ................
            1c 00 05 00 0c 00 01 00 00 00 00 00 00 00 00 00  ................
            0c 00 02 00 00 00 00 00 00 00 00 00 1c 00 06 00  ................
            0c 00 01 00 00 00 00 00 00 00 00 00 0c 00 02 00  ................
            00 00 00 00 00 00 00 00 1c 00 07 00 0c 00 01 00  ................
            00 00 00 00 00 00 00 00 0c 00 02 00 00 00 00 00  ................
            00 00 00 00 1c 00 08 00 0c 00 01 00 00 00 00 00  ................
            00 00 00 00 0c 00 02 00 00 00 00 00 00 00 00 00  ................
            1c 00 09 00 0c 00 01 00 00 00 00 00 00 00 00 00  ................
            0c 00 02 00 00 00 00 00 00 00 00 00 1c 00 0a 00  ................
            0c 00 01 00 00 00 00 00 00 00 00 00 0c 00 02 00  ................
            00 00 00 00 00 00 00 00 1c 00 0b 00 0c 00 01 00  ................
            00 00 00 00 00 00 00 00 0c 00 02 00 00 00 00 00  ................
            00 00 00 00 1c 00 0c 00 0c 00 01 00 00 00 00 00  ................
            00 00 00 00 0c 00 02 00 00 00 00 00 00 00 00 00  ................
            1c 00 0d 00 0c 00 01 00 00 00 00 00 00 00 00 00  ................
            0c 00 02 00 00 00 00 00 00 00 00 00 1c 00 0e 00  ................
            0c 00 01 00 00 00 00 00 00 00 00 00 0c 00 02 00  ................
            00 00 00 00 00 00 00 00 1c 00 0f 00 0c 00 01 00  ................
            00 00 00 00 00 00 00 00 0c 00 02 00 00 00 00 00  ................
            00 00 00 00 1c 00 10 00 0c 00 01 00 00 00 00 00  ................
            00 00 00 00 0c 00 02 00 00 00 00 00 00 00 00 00  ................
            1c 00 11 00 0c 00 01 00 00 00 00 00 00 00 00 00  ................
            0c 00 02 00 01 00 00 00 00 00 00 00              ............
> Event: Del Station (0x14) len 744                                   57.826943
    Interface Index: 15 (0x0000000f)
    MAC Address 02:00:00:00:02:00
    Generation: 2 (0x00000002)
    Station Info: len 712
        Connected time: 0 (0x00000000)
        Inactivity time: 1 (0x00000001)
        Reserved: len 8
            00 00 00 00 00 00 00 00                          ........
        Total RX bytes: 30 (0x0000001e)
        Total TX bytes: 30 (0x0000001e)
        Total RX bytes: 30 (0x000000000000001e)
        Total TX bytes: 30 (0x000000000000001e)
        Reserved: len 8
            00 00 00 00 00 00 00 00                          ........
        Reserved: len 8
            00 00 00 00 00 00 00 00                          ........
        Signal strength: -20
        Signal strength average: -20
        TX bitrate: len 16
            Bit Rate: 10 (0x0000000a)
            Bit Rate (Legacy): 10 (0x000a)
        RX packets: 2 (0x00000002)
        TX packets: 1 (0x00000001)
        TX retries: 10 (0x0000000a)
        TX failed: 0 (0x00000000)
        Beacon loss: 0 (0x00000000)
        BSS parameters: len 16
            DTIM Period: 0 (0x00)
            Beacon Interval: 100 (0x0064)
        Station flags: len 8
            Mask: 0x000000fe
                Authorized
                ShortPreamble
                WME
                MFP
                Authenticated
                TDLS-Peer
                Associated
            Set: 0x00000000
        Reserved: len 8
            00 00 00 00 00 00 00 00                          ........
        Reserved: len 8
            00 00 00 00 00 00 00 00                          ........
        Reserved: len 1
            00                                               .
        Reserved: len 476
            1c 00 01 00 0c 00 01 00 00 00 00 00 00 00 00 00  ................
            0c 00 02 00 00 00 00 00 00 00 00 00 1c 00 02 00  ................
            0c 00 01 00 00 00 00 00 00 00 00 00 0c 00 02 00  ................
            00 00 00 00 00 00 00 00 1c 00 03 00 0c 00 01 00  ................
            00 00 00 00 00 00 00 00 0c 00 02 00 00 00 00 00  ................
            00 00 00 00 1c 00 04 00 0c 00 01 00 00 00 00 00  ................
            00 00 00 00 0c 00 02 00 00 00 00 00 00 00 00 00  ................
            1c 00 05 00 0c 00 01 00 00 00 00 00 00 00 00 00  ................
            0c 00 02 00 00 00 00 00 00 00 00 00 1c 00 06 00  ................
            0c 00 01 00 00 00 00 00 00 00 00 00 0c 00 02 00  ................
            00 00 00 00 00 00 00 00 1c 00 07 00 0c 00 01 00  ................
            00 00 00 00 00 00 00 00 0c 00 02 00 00 00 00 00  ................
            00 00 00 00 1c 00 08 00 0c 00 01 00 00 00 00 00  ................
            00 00 00 00 0c 00 02 00 00 00 00 00 00 00 00 00  ................
            1c 00 09 00 0c 00 01 00 00 00 00 00 00 00 00 00  ................
            0c 00 02 00 00 00 00 00 00 00 00 00 1c 00 0a 00  ................
            0c 00 01 00 00 00 00 00 00 00 00 00 0c 00 02 00  ................
            00 00 00 00 00 00 00 00 1c 00 0b 00 0c 00 01 00  ................
            00 00 00 00 00 00 00 00 0c 00 02 00 00 00 00 00  ................
            00 00 00 00 1c 00 0c 00 0c 00 01 00 00 00 00 00  ................
            00 00 00 00 0c 00 02 00 00 00 00 00 00 00 00 00  ................
            1c 00 0d 00 0c 00 01 00 00 00 00 00 00 00 00 00  ................
            0c 00 02 00 00 00 00 00 00 00 00 00 1c 00 0e 00  ................
            0c 00 01 00 00 00 00 00 00 00 00 00 0c 00 02 00  ................
            00 00 00 00 00 00 00 00 1c 00 0f 00 0c 00 01 00  ................
            00 00 00 00 00 00 00 00 0c 00 02 00 00 00 00 00  ................
            00 00 00 00 1c 00 10 00 0c 00 01 00 00 00 00 00  ................
            00 00 00 00 0c 00 02 00 00 00 00 00 00 00 00 00  ................
            1c 00 11 00 0c 00 01 00 00 00 00 00 00 00 00 00  ................
            0c 00 02 00 01 00 00 00 00 00 00 00              ............
> Event: Authenticate (0x25) len 52                                   57.826951
    Wiphy: 3 (0x00000003)
    Interface Index: 15 (0x0000000f)
    Frame: len 30
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 314
                Address 1 (RA): 02:00:00:00:03:00
                Address 2 (TA): 02:00:00:00:02:00
                Address 3: 02:00:00:00:02:00
                Fragment Number: 0
                Sequence Number: 16
                Algorithm: Open (seq: 2, status: 17)
        b0 00 3a 01 02 00 00 00 03 00 02 00 00 00 02 00  ..:.............
        02 00 00 00 02 00 00 01 00 00 02 00 11 00        ..............
> Event: Authenticate (0x25) len 52                                   57.826952
    Wiphy: 3 (0x00000003)
    Interface Index: 15 (0x0000000f)
    Frame: len 30
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 314
                Address 1 (RA): 02:00:00:00:03:00
                Address 2 (TA): 02:00:00:00:02:00
                Address 3: 02:00:00:00:02:00
                Fragment Number: 0
                Sequence Number: 16
                Algorithm: Open (seq: 2, status: 17)
        b0 00 3a 01 02 00 00 00 03 00 02 00 00 00 02 00  ..:.............
        02 00 00 00 02 00 00 01 00 00 02 00 11 00        ..............
> Event: Connect (0x2e) len 36                                        57.826954
    Wiphy: 3 (0x00000003)
    Interface Index: 15 (0x0000000f)
    MAC Address 02:00:00:00:02:00
    Status Code: 17 (0x0011)
> Event: Connect (0x2e) len 36                                        57.826966
    Wiphy: 3 (0x00000003)
    Interface Index: 15 (0x0000000f)
    MAC Address 02:00:00:00:02:00
    Status Code: 17 (0x0011)
> Response: Connect (0x2e) len 4 [0x100]                              57.827072
    Status: Success (0)

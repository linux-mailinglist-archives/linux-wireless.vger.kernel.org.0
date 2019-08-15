Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE498F42E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2019 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfHOTK2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Aug 2019 15:10:28 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37106 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbfHOTK2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Aug 2019 15:10:28 -0400
Received: by mail-ot1-f49.google.com with SMTP id f17so7467735otq.4
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2019 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=li1Ybi7HxPfvQGh0IZ7D7mEfO6rjl8/2qG4D9rmbnfk=;
        b=ULHQpoYyufR4QmhAsilbvhsPsNIk613c5/ZjFbGed9INUt8k4IJFrNgWAYuPVZQvHV
         Yk2UaIiXo6xpmNDYyL06K8fPNbEPuP+cbH+F5KtBULKzX4s0GwQpdoZEVUtULNbeHwpb
         /NPEoREp/asTYqthwfJUdknniL3ulVZniJpuGPXE/74h06Oe0/09xrgPQw1pArZNomLZ
         IBeA9t0cF2WsFjAynxBjZoyBcmCODqDmQYucAJNoSvDOZA8A0OT8/rP5BvLoWDWDmUi4
         RM6A2dz8VWBrsd5CM5UVvNyiaO6x/yJ6lSvFSjc25btVagQXxenz+MrVy2zfnuPRGDPu
         hSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=li1Ybi7HxPfvQGh0IZ7D7mEfO6rjl8/2qG4D9rmbnfk=;
        b=leNCYmKGEJxzRZUCrzynws+zoYteurlYNySgYTjFQSWij32OKz2RrwfY0bGkvGYNMU
         9nS4iGe9FJVFj3aEYVjcHKOq3g4Wwecjr0wNf8l8yRZaKL1eVdf8ebXlScfPCsjsF/df
         PnONtCdJUCA96VtDNJckOz/p940iuRD6ACrqVWHpmEhtWOOzVDX3PZZp8PYK2+zwDqA7
         KxVSL3IquzdlZqzFaK42wwrboaTPUIdTE1hcU62gZCgdisbzQj6qGHBmqyoptPc8ZMEp
         uflnpps1fBAFQbsnFds7PMSMeQzXokYh/Q75qvdIqlbVCTrDXCCZETebBO/2BRZHumDS
         i4iA==
X-Gm-Message-State: APjAAAVRUUgbxDOoz6qgiN5icO+barw1/qpG8Figir8KlI2Ru5qdD8h5
        CEytiLYHviamzsWNPp/IHBVHrE5I
X-Google-Smtp-Source: APXvYqxJODdryVDx2rivDvdWDxttiucz3KoBTe+oBaS6jv3rGTSLTwnQsJl+vf0fJX0RCt6Un84Tgg==
X-Received: by 2002:a05:6830:14ce:: with SMTP id t14mr2771085otq.316.1565896224186;
        Thu, 15 Aug 2019 12:10:24 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e10sm1315073otq.69.2019.08.15.12.10.23
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 12:10:23 -0700 (PDT)
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Denis Kenzior <denkenz@gmail.com>
Subject: BUG: atk9k/mac80211 CONTROL_PORT_FRAME processing + MFP
Message-ID: <c10499b7-8389-595d-b72a-c370f69f09e0@gmail.com>
Date:   Thu, 15 Aug 2019 14:10:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

We're getting reports of weird behavior on ath9k/mac80211 devices when 
CONTROL_PORT_FRAME support is used.  iwlwifi, works fine under the same 
circumstances.  If CONTROL_PORT_FRAME is disabled and the old legacy PAE 
transport is used, everything works fine.

The short version:
  - We Connect with MFP enabled
  - Handshake packet 1 & 2 is exchanged
  - Handshake packet 3 is received & reply sent
  - Keys are set
  - AP never receives our packet 4, or the card drops it locally
  - Subsequent retransmissions are sent un-encrypted by the AP and are 
probably sent encrypted (via MFP) by mac80211.  Since the driver never 
sets NO_ENCRYPT flag, userspace has no knowledge to try and send the 
reply un-encrypted.

Here's a log (some parts are removed for brevity, but if someone wants 
the full log, I can provide this as well):

< Request: Connect (0x2e) len 160 [ack] 
1565892849.337243
     Interface Index: 13 (0x0000000d)
     Wiphy Frequency: 5805 (0x000016ad)
     MAC Address 10:C3:7B:54:74:D4
     SSID: len 9
     Auth Type: 0 (0x00000000)
     Privacy: true
     Interface Socket Owner: true
     Cipher Suites Pairwise:
         CCMP (00:0f:ac) suite  04
     Cipher Suite Group: CCMP (00:0f:ac) suite  04
     Use MFP: 1 (0x00000001)
     AKM Suites:
         PSK; RSNA PSK (00:0f:ac) suite  02
     WPA Versions: 2 (0x00000002)
     Control Port: true
     Control Port over NL80211: true
     Use RRM: true
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
             RSN capabilities: bit  7: Management Frame Protection Capable
             01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f 
................
             ac 02 80 00                                      .... 

         RM Enabled Capabilities: len 5
             Operating Channel Max Measurement Duration: 0
             Non-Operating Channel Max Measurement Duration: 0
             Measurement Pilot Capability: 0
             00 00 00 00 00                                   ..... 

         Extended Capabilities: len 10
             Capability: bit 62: Opmode Notification
             00 00 00 00 00 00 00 40 00 00                    .......@.. 

 > Event: New Station (0x13) len 32 
1565892851.673886
     Interface Index: 13 (0x0000000d)
     MAC Address 10:C3:7B:54:74:D4
     Generation: 5 (0x00000005)
     Station Info: len 0
 > Response: Connect (0x2e) len 4 [0x100] 
1565892851.673971
     Status: Success (0)
 > Event: Authenticate (0x25) len 64 
1565892851.676737
     Wiphy: 1 (0x00000001)
     Interface Index: 13 (0x0000000d)
     Frame: len 41

<snip>

Here comes the Handshake packet 1 from the AP.  Why the hell is it here 
prior to Authenticate ?  But whatever ;)

 > Event: Control Port Frame (0x81) len 176 
1565892851.686055
     Wiphy: 1 (0x00000001)
     Interface Index: 13 (0x0000000d)
     Wireless Device: 4294967299 (0x0000000100000003)
     MAC Address 10:C3:7B:54:74:D4
     Control Port Ethertype: 34958 (0x888e)
     Frame: len 121
         Protocol Version: 2 (802.1X-2004)
         Type: 3 (Key)
         Length: 117
         Descriptor Type: 2
         Key MIC: false
         Secure: false
         Error: false
         Request: false
         Encrypted Key Data: false
         SMK Message: false
         Key Descriptor Version: 2 (02)
         Key Type: true
         Install: false
         Key ACK: true
         Key Length: 16
         Key Replay Counter: 0
         Key NONCE
             e4 5b 1d 98 fd db 54 ae 54 98 fc 39 69 f5 bc 0b 
.[....T.T..9i...
             f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d de 
....PC.m'.....m.
         Key IV
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
         Key RSC
             00 00 00 00 00 00 00 00                          ........ 

         Key MIC Data
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
         Key Data: len 22
             Vendor specific: len 20
                 IEEE 802.11 (00:0f:ac) type: 04
                 PMKID KDE
                 00 0f ac 04 d9 81 f4 29 57 31 7e ad 33 57 b8 af 
.......)W1~.3W..
                 c7 a7 40 8f                                      ..@. 

         02 03 00 75 02 00 8a 00 10 00 00 00 00 00 00 00  ...u............
         00 e4 5b 1d 98 fd db 54 ae 54 98 fc 39 69 f5 bc  ..[....T.T..9i..
         0b f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d  .....PC.m'.....m
         de 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 16 dd 14 00 0f ac 04 d9 81 f4 29 57 31 7e  ............)W1~
         ad 33 57 b8 af c7 a7 40 8f                       .3W....@.
 > Event: Associate (0x26) len 292 
1565892851.752271
     Wiphy: 1 (0x00000001)
     Interface Index: 13 (0x0000000d)
     Frame: len 152
<snip>
 > Event: Connect (0x2e) len 272 
1565892851.752302
     Wiphy: 1 (0x00000001)
     Interface Index: 13 (0x0000000d)
     MAC Address 10:C3:7B:54:74:D4
     Status Code: 0 (0x0000)
     Request IE: len 103
         SSID: <snip>
         Supported rates:
             6.0 9.0 12.0 18.0 24.0 36.0 48.0 54.0 Mbit/s
             0c 12 18 24 30 48 60 6c                          ...$0H`l 

         Tag 33: len 2
             00 1e                                            .. 

         RSN:
             Group Data Cipher Suite: len 4
                 CCMP (00:0f:ac) suite  04
             Pairwise Cipher Suite: len 4
                 CCMP (00:0f:ac) suite  04
             AKM Suite: len 4
                 PSK; RSNA PSK (00:0f:ac) suite  02
             RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
             RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
             RSN capabilities: bit  7: Management Frame Protection Capable
             01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f 
................
             ac 02 80 00                                      .... 

         RM Enabled Capabilities: len 5
             Operating Channel Max Measurement Duration: 0
             Non-Operating Channel Max Measurement Duration: 0
             Measurement Pilot Capability: 0
             00 00 00 00 00                                   ..... 

         HT Capabilities: len 26
             HT Capabilities Info: bit  1: Supported Channel Width Set
             HT Capabilities Info: bits 2-3: Disabled
             HT Capabilities Info: bit  6: Short GI for 40Mhz
             HT Capabilities Info: bit  7: Tx STBC
             HT Capabilities Info: bits 8-9: One spatial stream
             HT Capabilities Info: bit 12: DSSS/CCK Mode in 40Mhz
             A-MPDU Parameters: Maximum A-MPDU Length Exponent: 3
             A-MPDU Parameters: Minimum MPDU Start Spacing: 8 us
             Supported MCS: MCS 0
             Supported MCS: MCS 1
             Supported MCS: MCS 2
             Supported MCS: MCS 3
             Supported MCS: MCS 4
             Supported MCS: MCS 5
             Supported MCS: MCS 6
             Supported MCS: MCS 7
             Supported MCS: MCS 8
             Supported MCS: MCS 9
             Supported MCS: MCS 10
             Supported MCS: MCS 11
             Supported MCS: MCS 12
             Supported MCS: MCS 13
             Supported MCS: MCS 14
             Supported MCS: MCS 15
             MCS Set: bit 96: Tx MCS set defined
             HT Extended Capabilities: PCO: supported
             HT Extended Capabilities: MCS Feedback: No feedback
             HT Extended Capabilities: +HTC: not supported
             HT Extended Capabilities: RD Responder: not supported
             ce 11 1b ff ff 00 00 00 00 00 00 00 00 00 00 01 
................
             00 00 00 00 00 00 00 00 00 00                    .......... 

         Extended Capabilities: len 10
             Capability: bit 62: Opmode Notification
             00 00 00 00 00 00 00 40 00 00                    .......@.. 

         Vendor specific: len 7
             Microsoft (00:50:f2) type: 02
             00 50 f2 02 00 01 00                             .P..... 

     Response IE: len 122
         Supported rates:
             6.0(B) 9.0 12.0(B) 18.0 24.0(B) 36.0 48.0 54.0 Mbit/s
             8c 12 98 24 b0 48 60 6c                          ...$.H`l 

         Tag 53: len 1
             00                                               . 

         Tag 65: len 1
             00                                               . 

         RM Enabled Capabilities: len 5
             Enabled: bit  1: Neighbor Report
             Enabled: bit  4: Beacon Passive Measurement
             Enabled: bit  5: Beacon Active Measurement
             Enabled: bit  6: Beacon Table Measurement
             Enabled: bit 11: Statistics Measurement
             Enabled: bit 16: AP Channel Report
             Operating Channel Max Measurement Duration: 0
             Non-Operating Channel Max Measurement Duration: 0
             Measurement Pilot Capability: 0
             72 08 01 00 00                                   r.... 

         HT Capabilities: len 26
             HT Capabilities Info: bit  0: LDPC Coding Capability
             HT Capabilities Info: bit  1: Supported Channel Width Set
             HT Capabilities Info: bits 2-3: Disabled
             HT Capabilities Info: bit  5: Short GI for 20Mhz
             HT Capabilities Info: bit  6: Short GI for 40Mhz
             HT Capabilities Info: bit  7: Tx STBC
             HT Capabilities Info: bits 8-9: One spatial stream
             HT Capabilities Info: bit 11: Maximum A-MSDU Length
             A-MPDU Parameters: Maximum A-MPDU Length Exponent: 3
             A-MPDU Parameters: Minimum MPDU Start Spacing: 4 us
             Supported MCS: MCS 0
             Supported MCS: MCS 1
             Supported MCS: MCS 2
             Supported MCS: MCS 3
             Supported MCS: MCS 4
             Supported MCS: MCS 5
             Supported MCS: MCS 6
             Supported MCS: MCS 7
             Supported MCS: MCS 8
             Supported MCS: MCS 9
             Supported MCS: MCS 10
             Supported MCS: MCS 11
             Supported MCS: MCS 12
             Supported MCS: MCS 13
             Supported MCS: MCS 14
             Supported MCS: MCS 15
             HT Extended Capabilities: PCO: supported
             HT Extended Capabilities: MCS Feedback: No feedback
             HT Extended Capabilities: +HTC: not supported
             HT Extended Capabilities: RD Responder: not supported
             ef 09 17 ff ff 00 00 00 00 00 00 00 00 00 00 00 
................
             00 00 00 00 00 00 00 00 00 00                    .......... 

         HT Operation:
             Primary channel 161
             Information: Secondary Channel Offset: below primary channel
             Information: Channel width: bit  2: Any supported channel width
             Information: bit  3: RIFS permitted
             Information: HT Protection: bits  8 -  9: 20 MHz protection 
mode
             Information: bit 10: Non-greenfield HT STAs present
             Information: bit 12: OBSS non-HT STAs present
             a1 0f 16 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
             00 00 00 00 00 00                                ...... 

         Extended Capabilities: len 8
             Capability: bit  2: Extended channel switching
             Capability: bit 19: BSS transition
             Capability: bit 62: Opmode Notification
             04 00 08 00 00 00 00 40                          .......@ 

         Vendor specific: len 9
             Broadcom (00:10:18) type: 02
             00 10 18 02 01 00 1c 00 00                       ......... 

         Vendor specific: len 24
             Microsoft (00:50:f2) type: 02
             00 50 f2 02 01 01 84 00 03 a4 00 00 27 a4 00 00 
.P..........'...
             42 43 5e 00 62 32 2f 00                          BC^.b2/. 

< Request: Control Port Frame (0x81) len 156 [ack] 
1565892851.752751
     Interface Index: 13 (0x0000000d)
     Frame: len 121
         Protocol Version: 2 (802.1X-2004)
         Type: 3 (Key)
         Length: 117
         Descriptor Type: 2
         Key MIC: true
         Secure: false
         Error: false
         Request: false
         Encrypted Key Data: false
         SMK Message: false
         Key Descriptor Version: 2 (02)
         Key Type: true
         Install: false
         Key ACK: false
         Key Length: 0
         Key Replay Counter: 0
         Key NONCE
             74 29 cc 1b 86 49 4c 4d d7 cf e8 54 70 ec 67 ee 
t)...ILM...Tp.g.
             ea 15 f5 28 5c e7 46 ff cc c2 71 9b 0b 79 f1 d7 
...(\.F...q..y..
         Key IV
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
         Key RSC
             00 00 00 00 00 00 00 00                          ........ 

         Key MIC Data
             2a 9f bc 4a 3f 53 c4 68 a5 1f 86 3e 56 ea bd 3c 
*..J?S.h...>V..<
         Key Data: len 22
             RSN:
                 Group Data Cipher Suite: len 4
                     CCMP (00:0f:ac) suite  04
                 Pairwise Cipher Suite: len 4
                     CCMP (00:0f:ac) suite  04
                 AKM Suite: len 4
                     PSK; RSNA PSK (00:0f:ac) suite  02
                 RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
                 RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
                 RSN capabilities: bit  7: Management Frame Protection 
Capable
                 01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f 
................
                 ac 02 80 00                                      .... 

         02 03 00 75 02 01 0a 00 00 00 00 00 00 00 00 00  ...u............
         00 74 29 cc 1b 86 49 4c 4d d7 cf e8 54 70 ec 67  .t)...ILM...Tp.g
         ee ea 15 f5 28 5c e7 46 ff cc c2 71 9b 0b 79 f1  ....(\.F...q..y.
         d7 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 2a 9f bc 4a 3f 53 c4 68 a5 1f 86 3e 56 ea bd  .*..J?S.h...>V..
         3c 00 16 30 14 01 00 00 0f ac 04 01 00 00 0f ac  <..0............
         04 01 00 00 0f ac 02 80 00                       .........
     Control Port Ethertype: 34958 (0x888e)
     MAC Address 10:C3:7B:54:74:D4
 > Response: Control Port Frame (0x81) len 4 [0x100] 
1565892851.755532
     Status: Success (0)

Handshake packet 3:

 > Event: Control Port Frame (0x81) len 240 
1565892851.766837
     Wiphy: 1 (0x00000001)
     Interface Index: 13 (0x0000000d)
     Wireless Device: 4294967299 (0x0000000100000003)
     MAC Address 10:C3:7B:54:74:D4
     Control Port Ethertype: 34958 (0x888e)
     Frame: len 187
         Protocol Version: 2 (802.1X-2004)
         Type: 3 (Key)
         Length: 183
         Descriptor Type: 2
         Key MIC: true
         Secure: true
         Error: false
         Request: false
         Encrypted Key Data: true
         SMK Message: false
         Key Descriptor Version: 2 (02)
         Key Type: true
         Install: true
         Key ACK: true
         Key Length: 16
         Key Replay Counter: 1
         Key NONCE
             e4 5b 1d 98 fd db 54 ae 54 98 fc 39 69 f5 bc 0b 
.[....T.T..9i...
             f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d de 
....PC.m'.....m.
         Key IV
             f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d df 
....PC.m'.....m.
         Key RSC
             83 01 00 00 00 00 00 00                          ........ 

         Key MIC Data
             01 20 2e 3f 3c 26 03 cc 2f c8 eb 98 e0 ef 75 3d  . 
.?<&../.....u=
         Key Data: len 88
             78 d0 96 78 9f 2a 99 03 39 66 80 fd bd cf aa a5 
x..x.*..9f......
             6f 96 e2 bb 6b 95 51 e9 63 cd 69 17 7a 4a e2 f8 
o...k.Q.c.i.zJ..
             f6 b2 c4 f8 a0 08 8d b3 7d 1d ec d8 4a a1 60 33 
........}...J.`3
             e0 cb c0 14 26 d1 92 c4 70 91 6b ce a3 d2 11 5e 
....&...p.k....^
             99 90 65 22 49 e6 de 9f 01 02 e9 d4 53 37 2e 53 
..e"I.......S7.S
             6b f9 ab df d2 b4 8e 35                          k......5 

         02 03 00 b7 02 13 ca 00 10 00 00 00 00 00 00 00  ................
         01 e4 5b 1d 98 fd db 54 ae 54 98 fc 39 69 f5 bc  ..[....T.T..9i..
         0b f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d  .....PC.m'.....m
         de f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d  .....PC.m'.....m
         df 83 01 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 01 20 2e 3f 3c 26 03 cc 2f c8 eb 98 e0 ef 75  .. .?<&../.....u
         3d 00 58 78 d0 96 78 9f 2a 99 03 39 66 80 fd bd  =.Xx..x.*..9f...
         cf aa a5 6f 96 e2 bb 6b 95 51 e9 63 cd 69 17 7a  ...o...k.Q.c.i.z
         4a e2 f8 f6 b2 c4 f8 a0 08 8d b3 7d 1d ec d8 4a  J..........}...J
         a1 60 33 e0 cb c0 14 26 d1 92 c4 70 91 6b ce a3  .`3....&...p.k..
         d2 11 5e 99 90 65 22 49 e6 de 9f 01 02 e9 d4 53  ..^..e"I.......S
         37 2e 53 6b f9 ab df d2 b4 8e 35                 7.Sk......5
< Request: Control Port Frame (0x81) len 132 [ack] 
1565892851.767264
     Interface Index: 13 (0x0000000d)
     Frame: len 99
         Protocol Version: 2 (802.1X-2004)
         Type: 3 (Key)
         Length: 95
         Descriptor Type: 2
         Key MIC: true
         Secure: true
         Error: false
         Request: false
         Encrypted Key Data: false
         SMK Message: false
         Key Descriptor Version: 2 (02)
         Key Type: true
         Install: false
         Key ACK: false
         Key Length: 0
         Key Replay Counter: 1
         Key NONCE
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
         Key IV
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
         Key RSC
             00 00 00 00 00 00 00 00                          ........ 

         Key MIC Data
             b4 fb b3 ed 13 55 92 b4 79 4d 69 77 64 0d 47 dd 
.....U..yMiwd.G.
         Key Data: len 0
         02 03 00 5f 02 03 0a 00 00 00 00 00 00 00 00 00  ..._............
         01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 b4 fb b3 ed 13 55 92 b4 79 4d 69 77 64 0d 47  ......U..yMiwd.G
         dd 00 00                                         ...
     Control Port Ethertype: 34958 (0x888e)
     MAC Address 10:C3:7B:54:74:D4
 > Response: Control Port Frame (0x81) len 4 [0x100] 
1565892851.767292
     Status: Success (0)

So as you can see here, we process the handshake successfully, send the 
Handshake packet 4/4 and proceed to setting keys:

< Request: New Key (0x0b) len 60 [ack] 
1565892851.767323
     Interface Index: 13 (0x0000000d)
     Key: len 48
 > Response: New Key (0x0b) len 4 [0x100] 
1565892851.775960
     Status: Success (0)
< Request: New Key (0x0b) len 60 [ack] 
1565892851.775989
     Interface Index: 13 (0x0000000d)
     Key: len 48
 > Response: New Key (0x0b) len 4 [0x100] 
1565892851.776091
     Status: Success (0)
< Request: New Key (0x0b) len 56 [ack] 
1565892851.776103
     Key Data: len 16
     Key Cipher: CCMP (00:0f:ac) suite  04
     MAC Address 10:C3:7B:54:74:D4
     Key Index: 0 (0x00)
     Interface Index: 13 (0x0000000d)
 > Response: New Key (0x0b) len 4 [0x100] 
1565892851.783032
     Status: Success (0)

Here comes the REKEY_OFFLOAD which isn't supported:

< Request: Unknown (0x00) len 64 [ack] 
1565892851.783051
 > Response: Unknown (0x00) len 4 
1565892851.783058
     Status: Operation not supported (95)
< Request: Set Station (0x12) len 32 [ack] 
1565892851.783075
     Interface Index: 13 (0x0000000d)
     MAC Address 10:C3:7B:54:74:D4
     Station Flags 2: len 8
         Mask: 0x00000002
             Authorized
         Set: 0x00000002
             Authorized
 > Response: Set Station (0x12) len 4 [root] 
1565892851.783082
     Status: Success (0)
 > Event: Notify CQM (0x40) len 36 
1565892852.026773
     Wiphy: 1 (0x00000001)
     Interface Index: 13 (0x0000000d)
     CQM: len 16
         RSSI threshold event: 1 (0x00000001)
         Reserved: len 4
             c0 ff ff ff                                      .... 


And now AP is confused, because it never received our Handshake packet 4/4:

 > Event: Control Port Frame (0x81) len 240 
1565892852.757161
     Wiphy: 1 (0x00000001)
     Interface Index: 13 (0x0000000d)
     Wireless Device: 4294967299 (0x0000000100000003)
     MAC Address 10:C3:7B:54:74:D4
     Control Port Ethertype: 34958 (0x888e)
     Frame: len 187
         Protocol Version: 2 (802.1X-2004)
         Type: 3 (Key)
         Length: 183
         Descriptor Type: 2
         Key MIC: true
         Secure: true
         Error: false
         Request: false
         Encrypted Key Data: true
         SMK Message: false
         Key Descriptor Version: 2 (02)
         Key Type: true
         Install: true
         Key ACK: true
         Key Length: 16
         Key Replay Counter: 2
         Key NONCE
             e4 5b 1d 98 fd db 54 ae 54 98 fc 39 69 f5 bc 0b 
.[....T.T..9i...
             f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d de 
....PC.m'.....m.
         Key IV
             f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d df 
....PC.m'.....m.
         Key RSC
             83 01 00 00 00 00 00 00                          ........ 

         Key MIC Data
             d1 16 8d c7 e6 ab 4d 6e 0a c6 0c 87 97 25 76 52 
......Mn.....%vR
         Key Data: len 88
             78 d0 96 78 9f 2a 99 03 39 66 80 fd bd cf aa a5 
x..x.*..9f......
             6f 96 e2 bb 6b 95 51 e9 63 cd 69 17 7a 4a e2 f8 
o...k.Q.c.i.zJ..
             f6 b2 c4 f8 a0 08 8d b3 7d 1d ec d8 4a a1 60 33 
........}...J.`3
             e0 cb c0 14 26 d1 92 c4 70 91 6b ce a3 d2 11 5e 
....&...p.k....^
             99 90 65 22 49 e6 de 9f 01 02 e9 d4 53 37 2e 53 
..e"I.......S7.S
             6b f9 ab df d2 b4 8e 35                          k......5 

         02 03 00 b7 02 13 ca 00 10 00 00 00 00 00 00 00  ................
         02 e4 5b 1d 98 fd db 54 ae 54 98 fc 39 69 f5 bc  ..[....T.T..9i..
         0b f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d  .....PC.m'.....m
         de f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d  .....PC.m'.....m
         df 83 01 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 d1 16 8d c7 e6 ab 4d 6e 0a c6 0c 87 97 25 76  .......Mn.....%v
         52 00 58 78 d0 96 78 9f 2a 99 03 39 66 80 fd bd  R.Xx..x.*..9f...
         cf aa a5 6f 96 e2 bb 6b 95 51 e9 63 cd 69 17 7a  ...o...k.Q.c.i.z
         4a e2 f8 f6 b2 c4 f8 a0 08 8d b3 7d 1d ec d8 4a  J..........}...J
         a1 60 33 e0 cb c0 14 26 d1 92 c4 70 91 6b ce a3  .`3....&...p.k..
         d2 11 5e 99 90 65 22 49 e6 de 9f 01 02 e9 d4 53  ..^..e"I.......S
         37 2e 53 6b f9 ab df d2 b4 8e 35                 7.Sk......5

We reply

< Request: Control Port Frame (0x81) len 132 [ack] 
1565892852.757715
     Interface Index: 13 (0x0000000d)
     Frame: len 99
         Protocol Version: 2 (802.1X-2004)
         Type: 3 (Key)
         Length: 95
         Descriptor Type: 2
         Key MIC: true
         Secure: true
         Error: false
         Request: false
         Encrypted Key Data: false
         SMK Message: false
         Key Descriptor Version: 2 (02)
         Key Type: true
         Install: false
         Key ACK: false
         Key Length: 0
         Key Replay Counter: 2
         Key NONCE
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
         Key IV
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
         Key RSC
             00 00 00 00 00 00 00 00                          ........ 

         Key MIC Data
             20 67 47 e4 d9 89 46 88 66 e1 bc a3 c7 74 37 87 
gG...F.f....t7.
         Key Data: len 0
         02 03 00 5f 02 03 0a 00 00 00 00 00 00 00 00 00  ..._............
         02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 20 67 47 e4 d9 89 46 88 66 e1 bc a3 c7 74 37  . gG...F.f....t7
         87 00 00                                         ...
     Control Port Ethertype: 34958 (0x888e)
     MAC Address 10:C3:7B:54:74:D4
 > Response: Control Port Frame (0x81) len 4 [0x100] 
1565892852.757735
     Status: Success (0)

But it doesn't seems to receive that one either:

 > Event: Control Port Frame (0x81) len 240 
1565892853.748041
     Wiphy: 1 (0x00000001)
     Interface Index: 13 (0x0000000d)
     Wireless Device: 4294967299 (0x0000000100000003)
     MAC Address 10:C3:7B:54:74:D4
     Control Port Ethertype: 34958 (0x888e)
     Frame: len 187
         Protocol Version: 2 (802.1X-2004)
         Type: 3 (Key)
         Length: 183
         Descriptor Type: 2
         Key MIC: true
         Secure: true
         Error: false
         Request: false
         Encrypted Key Data: true
         SMK Message: false
         Key Descriptor Version: 2 (02)
         Key Type: true
         Install: true
         Key ACK: true
         Key Length: 16
         Key Replay Counter: 3
         Key NONCE
             e4 5b 1d 98 fd db 54 ae 54 98 fc 39 69 f5 bc 0b 
.[....T.T..9i...
             f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d de 
....PC.m'.....m.
         Key IV
             f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d df 
....PC.m'.....m.
         Key RSC
             84 01 00 00 00 00 00 00                          ........ 

         Key MIC Data
             ac d8 64 f9 f3 77 64 78 b8 fe 13 3b d4 b9 b9 4c 
..d..wdx...;...L
         Key Data: len 88
             78 d0 96 78 9f 2a 99 03 39 66 80 fd bd cf aa a5 
x..x.*..9f......
             6f 96 e2 bb 6b 95 51 e9 63 cd 69 17 7a 4a e2 f8 
o...k.Q.c.i.zJ..
             f6 b2 c4 f8 a0 08 8d b3 7d 1d ec d8 4a a1 60 33 
........}...J.`3
             e0 cb c0 14 26 d1 92 c4 70 91 6b ce a3 d2 11 5e 
....&...p.k....^
             99 90 65 22 49 e6 de 9f 01 02 e9 d4 53 37 2e 53 
..e"I.......S7.S
             6b f9 ab df d2 b4 8e 35                          k......5 

         02 03 00 b7 02 13 ca 00 10 00 00 00 00 00 00 00  ................
         03 e4 5b 1d 98 fd db 54 ae 54 98 fc 39 69 f5 bc  ..[....T.T..9i..
         0b f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d  .....PC.m'.....m
         de f6 a3 aa c5 50 43 9a 6d 27 e5 a4 bb e9 c5 6d  .....PC.m'.....m
         df 84 01 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 ac d8 64 f9 f3 77 64 78 b8 fe 13 3b d4 b9 b9  ...d..wdx...;...
         4c 00 58 78 d0 96 78 9f 2a 99 03 39 66 80 fd bd  L.Xx..x.*..9f...
         cf aa a5 6f 96 e2 bb 6b 95 51 e9 63 cd 69 17 7a  ...o...k.Q.c.i.z
         4a e2 f8 f6 b2 c4 f8 a0 08 8d b3 7d 1d ec d8 4a  J..........}...J
         a1 60 33 e0 cb c0 14 26 d1 92 c4 70 91 6b ce a3  .`3....&...p.k..
         d2 11 5e 99 90 65 22 49 e6 de 9f 01 02 e9 d4 53  ..^..e"I.......S
         37 2e 53 6b f9 ab df d2 b4 8e 35                 7.Sk......5
< Request: Control Port Frame (0x81) len 132 [ack] 
1565892853.748627
     Interface Index: 13 (0x0000000d)
     Frame: len 99
         Protocol Version: 2 (802.1X-2004)
         Type: 3 (Key)
         Length: 95
         Descriptor Type: 2
         Key MIC: true
         Secure: true
         Error: false
         Request: false
         Encrypted Key Data: false
         SMK Message: false
         Key Descriptor Version: 2 (02)
         Key Type: true
         Install: false
         Key ACK: false
         Key Length: 0
         Key Replay Counter: 3
         Key NONCE
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
         Key IV
             00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
................
         Key RSC
             00 00 00 00 00 00 00 00                          ........ 

         Key MIC Data
             a7 ca 85 f4 a4 85 e8 9d 6b 0b 4e 73 c4 f4 58 cc 
........k.Ns..X.
         Key Data: len 0
         02 03 00 5f 02 03 0a 00 00 00 00 00 00 00 00 00  ..._............
         03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
         00 a7 ca 85 f4 a4 85 e8 9d 6b 0b 4e 73 c4 f4 58  .........k.Ns..X
         cc 00 00                                         ...
     Control Port Ethertype: 34958 (0x888e)
     MAC Address 10:C3:7B:54:74:D4
 > Response: Control Port Frame (0x81) len 4 [0x100] 
1565892853.748648
     Status: Success (0)

So this cycle continues for a while until:

 > Event: Unprot Deauthenticate (0x46) len 48 
1565892859.690863
     Wiphy: 1 (0x00000001)
     Interface Index: 13 (0x0000000d)
     Frame: len 26
<snip>
 > Event: Unprot Deauthenticate (0x46) len 48 
1565892860.204587
     Wiphy: 1 (0x00000001)
     Interface Index: 13 (0x0000000d)
     Frame: len 26
<snip>

Regards,
-Denis

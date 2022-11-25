Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FECF637FC9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKXTrj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKXTri (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:47:38 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE714D1A
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:47:35 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j4so3928577lfk.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eUnFpCdUcWPFZI12/bZ7IS7Zpu6SJnTNmHnRqjGgIXw=;
        b=cfx0fAmysbBcdreeRbZia7Qm4Ic6ho67HdzIYPHEeQhB+XyzisXHDajRV9+2fv42+g
         A+UCPE4qeQ0Kqa3x/J6jfZc0vqFr/+qWhm7mo6YHkXK95dPH7KkrepQj9zQvoonGkwqX
         CJv2KlZpz8R+YNk8xPmWyfkDZ8GZvR+ibYTYatibKmiB9UF4XU478mKOMkU7UMbxXfci
         UH/GHsam44OhMolVTGtf/xk0VDJYURPVWVyUy6hrTPwXDCT8c/TA7Xbl3gGCp524nhAH
         tZFSGtwqw0dN4IHq2eo47jL/0HHM3dK/xbRb5X21PdZNlbAtmow8dBNnJZL/EusDPSD+
         a03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUnFpCdUcWPFZI12/bZ7IS7Zpu6SJnTNmHnRqjGgIXw=;
        b=XxaMnPTwdUVengwf41GHyF554l/ShUPUNQB6PZh9w/vaSfA8ydt3Q1FcFQJvTD+XA0
         9DdFZLdjLki6jmd4OteeDOmj5D8uwqBXQ+SWlZ1ixP7UtyorGShYNy5RJE9zZKkU+Rnw
         txZ9nL2Lnkrbc12BVe+BFjWFlKC2R/L3YjVZFzsBiou2tOrdBW8JsMHv3Wg3nKgSJe3C
         0iXB9kms2Vj2DMDnrNbgrFhuaBBgq/WKoW//A40K9H7j//5ex4fMV61IzjnhDXkGII5i
         def8sU5/PteR6jrJ2pMnJNNGSOv229qHoSn8AR3qkmkUFKvQPGnoM8RZ8bm2kzWj9jK0
         NffA==
X-Gm-Message-State: ANoB5pkRi+FxFKsutK9ij3W4ubEbpRnGJbtMC5/CRfFzMmFyGAm9J7u8
        8IdwKxFJFDC8XNSHwAgxxaxlbOFYNz0mD3+Zh/qRnmqK1HoG8g==
X-Google-Smtp-Source: AA0mqf5hRdTnUFMlHlM5LLIag7dajtMdItfvQae6tpMepbR602vlLhnE4L3kD1/5zv7RyvuIrDRPT8rfHFjt/aHL+5I=
X-Received: by 2002:a05:6512:2390:b0:4ac:7d84:cba8 with SMTP id
 c16-20020a056512239000b004ac7d84cba8mr6708744lfv.425.1669319254248; Thu, 24
 Nov 2022 11:47:34 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:46:24 +0200
Message-ID: <CADUzMVbWA0QFsgTwDwtBjYsb+CrkKvX===Hag+GLrNFX4B5eVw@mail.gmail.com>
Subject: AR241x Atheros WPA2,3 SSID connection problem #2
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Moving on to the next mPCIe device, on Ubuntu boot I got:
[   97.002796] ath5k 0000:05:06.0: registered as 'phy0'
[   97.714196] ath: EEPROM regdomain: 0x63
[   97.714203] ath: EEPROM indicates we should expect a direct regpair map
[   97.714205] ath: Country alpha2 being used: 00
[   97.714207] ath: Regpair used: 0x63
[   97.714229] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   97.714561] ath5k: phy0: Atheros AR2413 chip found (MAC: 0x78, PHY: 0x45)
[   97.729120] ath5k 0000:05:06.0 wlp5s6: renamed from wlan0

It got connected to WPA3 2,4GHz SSID so I moved on to the combo
WPA2,3. After enabling air-plane mode, I got this:
[  994.871066] wlp5s6: authenticate with c6:27:28:1e:f0:b4
[  994.871151] wlp5s6: 80 MHz not supported, disabling VHT
[  994.876190] wlp5s6: send auth to c6:27:28:1e:f0:b4 (try 1/3)
[  995.013061] wlp5s6: authenticate with c6:27:28:1e:f0:b4
[  995.013085] wlp5s6: send auth to c6:27:28:1e:f0:b4 (try 1/3)
[  995.123340] wlp5s6: authenticated
[  995.127512] wlp5s6: associate with c6:27:28:1e:f0:b4 (try 1/3)
[  995.130773] wlp5s6: RX AssocResp from c6:27:28:1e:f0:b4
(capab=0x1431 status=0 aid=16)
[  995.130944] wlp5s6: associated
[  995.131222] ath: EEPROM regdomain: 0x812c
[  995.131228] ath: EEPROM indicates we should expect a country code
[  995.131233] ath: doing EEPROM country->regdmn map search
[  995.131236] ath: country maps to regdmn code: 0x37
[  995.131241] ath: Country alpha2 being used: GR
[  995.131245] ath: Regpair used: 0x37
[  995.131249] ath: regdomain 0x812c dynamically updated by country element
[  995.179221] wlp5s6: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:1e:f0:b4
[  995.260401] IPv6: ADDRCONF(NETDEV_CHANGE): wlp5s6: link becomes ready
[ 1209.325924] ================================================================================
[ 1209.325943] UBSAN: array-index-out-of-bounds in
/build/linux-JDy9aa/linux-5.19.0/drivers/net/wireless/ath/ath5k/base.c:1741:20
[ 1209.325957] index 4 is out of range for type 'ieee80211_tx_rate [4]'
[ 1209.325966] CPU: 5 PID: 0 Comm: swapper/5 Tainted: P           O
  5.19.0-21-generic #21-Ubuntu
[ 1209.325976] Hardware name: Gigabyte Technology Co., Ltd.
GA-880GMA-USB3/GA-880GMA-USB3, BIOS F4e 05/24/2012
[ 1209.325981] Call Trace:
[ 1209.325987]  <IRQ>
[ 1209.325996]  show_stack+0x4e/0x61
[ 1209.326014]  dump_stack_lvl+0x4a/0x6d
[ 1209.326031]  dump_stack+0x10/0x18
[ 1209.326041]  ubsan_epilogue+0x9/0x43
[ 1209.326051]  __ubsan_handle_out_of_bounds.cold+0x42/0x47
[ 1209.326064]  ath5k_tx_frame_completed.constprop.0+0x28f/0x2e0 [ath5k]
[ 1209.326097]  ath5k_tx_processq+0xb2/0x1d0 [ath5k]
[ 1209.326123]  ath5k_tasklet_tx+0x80/0xf0 [ath5k]
[ 1209.326148]  tasklet_action_common.constprop.0+0xbc/0x100
[ 1209.326163]  tasklet_action+0x22/0x30
[ 1209.326173]  __do_softirq+0xdb/0x34f
[ 1209.326184]  __irq_exit_rcu+0x87/0xc0
[ 1209.326195]  irq_exit_rcu+0xe/0x20
[ 1209.326204]  common_interrupt+0xa4/0xb0
[ 1209.326213]  </IRQ>
[ 1209.326216]  <TASK>
[ 1209.326220]  asm_common_interrupt+0x27/0x40
[ 1209.326232] RIP: 0010:native_safe_halt+0xb/0x10
[ 1209.326245] Code: cc cc cc 4c 89 ee 48 c7 c7 e0 4f 25 99 e8 8d 8f
84 ff eb c4 cc cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d b9 46 4e
00 fb f4 <c3> cc cc cc cc eb 07 0f 00 2d a9 46 4e 00 f4 c3 cc cc cc cc
cc 0f
[ 1209.326253] RSP: 0018:ffffa6ac800cfdc0 EFLAGS: 00000246
[ 1209.326263] RAX: 0000000000004000 RBX: ffff8a7c81270464 RCX: 0000000000000000
[ 1209.326270] RDX: 0000000000000001 RSI: ffff8a7c81270400 RDI: 0000000000000001
[ 1209.326275] RBP: ffffa6ac800cfdd0 R08: 0000000000000000 R09: 0000000000000000
[ 1209.326280] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a7c81270464
[ 1209.326285] R13: 0000000000000005 R14: ffffffff994c5220 R15: ffff8a7fa0540000
[ 1209.326296]  ? acpi_idle_do_entry+0x79/0xc0
[ 1209.326307]  acpi_idle_enter+0xbb/0x180
[ 1209.326318]  cpuidle_enter_state+0x9a/0x650
[ 1209.326331]  ? native_load_gs_index+0x19/0x40
[ 1209.326342]  ? raw_spin_rq_unlock+0x10/0x40
[ 1209.326354]  cpuidle_enter+0x2e/0x50
[ 1209.326365]  call_cpuidle+0x23/0x50
[ 1209.326375]  cpuidle_idle_call+0x11b/0x190
[ 1209.326383]  do_idle+0x82/0x100
[ 1209.326390]  cpu_startup_entry+0x1d/0x20
[ 1209.326398]  start_secondary+0x122/0x160
[ 1209.326408]  secondary_startup_64_no_verify+0xe5/0xeb
[ 1209.326423]  </TASK>
[ 1209.326478] ================================================================================
[ 1227.796076] wlp5s6: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 3=DEAUTH_LEAVING)

Here is the device:
05:06.0 Ethernet controller [0200]: Qualcomm Atheros AR2413/AR2414
Wireless Network Adapter [AR5005G(S) 802.11bg] [168c:001a] (rev 01)
    Subsystem: AMBIT Microsystem Corp. AR2413/AR2414 Wireless Network
Adapter [AR5005G(S) 802.11bg] [1468:0418]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 168 (2500ns min, 7000ns max), Cache Line Size: 4 bytes
    Interrupt: pin A routed to IRQ 20
    NUMA node: 0
    Region 0: Memory at fdbf0000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
    Kernel driver in use: ath5k
    Kernel modules: ath5k
00: 8c 16 1a 00 06 00 90 02 01 00 00 02 01 a8 00 00
10: 00 00 bf fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 01 50 00 00 68 14 18 04
30: 00 00 00 00 44 00 00 00 00 00 00 00 05 01 0a 1c
40: 00 00 00 00 01 00 c2 01 00 40 00 c6 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

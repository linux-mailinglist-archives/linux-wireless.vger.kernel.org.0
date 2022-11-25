Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B412637FAF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKXTdl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKXTdl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:33:41 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258F182235
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:33:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so3856903lfv.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JetEHbxEPqJhb0ETp/fgJQYlCPaT7pyzcFLrucFD4zw=;
        b=HvB/WHI/rk5sDad/bKSvNHr9W3WbqMO+Y216wb8+nVnlpI35+Xr5aHKvDpkel7NKvn
         aImgVkCae+2o5E9B1rC+9zzhIxUvtZgdVE+mPZNnUIB5QW+LITfwh3zZFRNPZtEzOIVK
         rAxh89NB1S0GdsaCxODRW4HbLN2Fqkf/YBbAmlMDj5TH39S/yypvJ+XE6oFX+kIVDVSr
         yzqTQC4GcTBMypdA6VlKcmam+vS//zq1ZkMmc8sfP0ULBCaDiVUsnZsQ1BV0K/8C9lfG
         ksACjwaMWPKdQ4yZWMuy065vEEd1n82oXi8khy3t6p3qwx4AbS1Jbp8Xg9MHfNrtJ7Af
         RIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JetEHbxEPqJhb0ETp/fgJQYlCPaT7pyzcFLrucFD4zw=;
        b=VgK74TCFrASqhsM08bzDogZ0fkCdruP8ClkOoCApl9A/TxCiWU0xAlWBHZpOCTA7hD
         D5lnt339fYOO/VqM4vz/uepcShhIh0mvCXnb/NiDqEcRc3DXgL3FjkNYg/b8Qpc9Zknt
         MA6YE3mri6DY3y8n1gZuU/B2DJfW/nUDpLIHUkaclAJ5EwAESkzFJRrHfIerI/1T5R0x
         +lj47a7BikJnCnvpLEXqE05n7hKyzVzXFzxq4OVEesb9uhXYjuvgNt4yKaWrnE271keG
         cHHxgnWNlr0IHQWFIut/EWxA0e0Pomsoh/S9MgOd7OVX50G+JYdLRXIfqzgR2tCVp3zH
         niWg==
X-Gm-Message-State: ANoB5pnLd8+S80YdOr8r8+mppW+LYCTmQK4jkJ99x2eFWvALWNqrMDAr
        ekavv4jVS+6vU4/AWOKPUYsdCQekXhGSUXEcWlIR1q1DSp/6Gg==
X-Google-Smtp-Source: AA0mqf6YQnfLhtt+9ZK12w7M1chlWwomTRxUrlgjLhLZGxCdf13cIPD1gtxQ2i39CgiyVvFYWgPj3zxCcD8DiTDym4A=
X-Received: by 2002:a19:6a02:0:b0:4a2:9853:b89d with SMTP id
 u2-20020a196a02000000b004a29853b89dmr10860357lfu.105.1669318418489; Thu, 24
 Nov 2022 11:33:38 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:32:28 +0200
Message-ID: <CADUzMVZu-6W88MyR6+Vi5FvJUPxxrRUYKkNftCWy6ZvfMUK9nA@mail.gmail.com>
Subject: TL-WN551G Atheros WPA3 SSID connection problem #6
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

Moving on to my PCI devices, this is seen on Ubuntu boot:
[   60.950274] ath5k 0000:05:06.0: registered as 'phy0'
[   61.559799] ath: EEPROM regdomain: 0x809c
[   61.559805] ath: EEPROM indicates we should expect a country code
[   61.559806] ath: doing EEPROM country->regdmn map search
[   61.559807] ath: country maps to regdmn code: 0x52
[   61.559808] ath: Country alpha2 being used: CN
[   61.559809] ath: Regpair used: 0x52
[   61.559833] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[   61.560201] ath5k: phy0: Atheros AR2413 chip found (MAC: 0x78, PHY: 0x45)
[   63.069976] ath5k 0000:05:06.0 wlp5s6: renamed from wlan0

Do not know why it has chosen CN, I am at EU! Maybe wrong value in
serial EEPROM.

It was able to connect to the 2,4GHz WPA3 SSID:
[  665.113370] wlp5s6: authenticate with c6:27:28:**:**:**
[  665.113421] wlp5s6: 80 MHz not supported, disabling VHT
[  665.118229] wlp5s6: send auth to c6:27:28:**:**:** (try 1/3)
[  665.119872] wlp5s6: authenticated
[  665.124467] wlp5s6: associate with c6:27:28:**:**:** (try 1/3)
[  665.128611] wlp5s6: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  665.128787] wlp5s6: associated
[  665.160040] wlp5s6: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  665.375713] IPv6: ADDRCONF(NETDEV_CHANGE): wlp5s6: link becomes ready
[  669.398074] systemd-journald[969]: Time jumped backwards, rotating.
[  711.862557] wlp5s6: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 3=DEAUTH_LEAVING)
[  712.115085] wlp5s6: authenticate with c6:27:28:**:**:**
[  712.115115] wlp5s6: 80 MHz not supported, disabling VHT
[  712.120467] wlp5s6: send auth to c6:27:28:**:**:** (try 1/3)
[  712.122050] wlp5s6: authenticated
[  712.122999] wlp5s6: associate with c6:27:28:**:**:** (try 1/3)
[  712.126066] wlp5s6: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  712.126181] wlp5s6: associated
[  712.162838] wlp5s6: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  712.231286] IPv6: ADDRCONF(NETDEV_CHANGE): wlp5s6: link becomes ready
[  722.209998] ath5k: ath5k_hw_get_isr: ISR: 0x00000400 IMR: 0x00000000

But moments before disconnecting from it, I got:
[  929.701994] ================================================================================
[  929.702005] UBSAN: array-index-out-of-bounds in
/build/linux-JDy9aa/linux-5.19.0/drivers/net/wireless/ath/ath5k/base.c:1741:20
[  929.702009] index 4 is out of range for type 'ieee80211_tx_rate [4]'
[  929.702012] CPU: 5 PID: 0 Comm: swapper/5 Tainted: P           O
  5.19.0-21-generic #21-Ubuntu
[  929.702015] Hardware name: Gigabyte Technology Co., Ltd.
GA-880GMA-USB3/GA-880GMA-USB3, BIOS F4e 05/24/2012
[  929.702017] Call Trace:
[  929.702019]  <IRQ>
[  929.702022]  show_stack+0x4e/0x61
[  929.702029]  dump_stack_lvl+0x4a/0x6d
[  929.702036]  dump_stack+0x10/0x18
[  929.702038]  ubsan_epilogue+0x9/0x43
[  929.702041]  __ubsan_handle_out_of_bounds.cold+0x42/0x47
[  929.702044]  ath5k_tx_frame_completed.constprop.0+0x28f/0x2e0 [ath5k]
[  929.702055]  ath5k_tx_processq+0xb2/0x1d0 [ath5k]
[  929.702062]  ath5k_tasklet_tx+0x80/0xf0 [ath5k]
[  929.702067]  tasklet_action_common.constprop.0+0xbc/0x100
[  929.702072]  tasklet_action+0x22/0x30
[  929.702074]  __do_softirq+0xdb/0x34f
[  929.702078]  __irq_exit_rcu+0x87/0xc0
[  929.702081]  irq_exit_rcu+0xe/0x20
[  929.702083]  common_interrupt+0xa4/0xb0
[  929.702086]  </IRQ>
[  929.702087]  <TASK>
[  929.702088]  asm_common_interrupt+0x27/0x40
[  929.702092] RIP: 0010:native_safe_halt+0xb/0x10
[  929.702095] Code: cc cc cc 4c 89 ee 48 c7 c7 e0 4f 25 98 e8 8d 8f
84 ff eb c4 cc cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d b9 46 4e
00 fb f4 <c3> cc cc cc cc eb 07 0f 00 2d a9 46 4e 00 f4 c3 cc cc cc cc
cc 0f
[  929.702097] RSP: 0018:ffffbf91800cfdc0 EFLAGS: 00000246
[  929.702100] RAX: 0000000000004000 RBX: ffff9d0e41270064 RCX: 0000000000000000
[  929.702102] RDX: 0000000000000001 RSI: ffff9d0e41270000 RDI: 0000000000000001
[  929.702103] RBP: ffffbf91800cfdd0 R08: 0000000000000000 R09: 0000000000000000
[  929.702104] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9d0e41270064
[  929.702105] R13: 0000000000000005 R14: ffffffff984c5220 R15: ffff9d1160540000
[  929.702108]  ? acpi_idle_do_entry+0x79/0xc0
[  929.702111]  acpi_idle_enter+0xbb/0x180
[  929.702114]  cpuidle_enter_state+0x9a/0x650
[  929.702117]  ? native_load_gs_index+0x19/0x40
[  929.702121]  ? raw_spin_rq_unlock+0x10/0x40
[  929.702125]  cpuidle_enter+0x2e/0x50
[  929.702127]  call_cpuidle+0x23/0x50
[  929.702130]  cpuidle_idle_call+0x11b/0x190
[  929.702132]  do_idle+0x82/0x100
[  929.702134]  cpu_startup_entry+0x1d/0x20
[  929.702136]  start_secondary+0x122/0x160
[  929.702139]  secondary_startup_64_no_verify+0xe5/0xeb
[  929.702143]  </TASK>
[  929.702144] ================================================================================
[  978.737790] ath5k: ath5k_hw_get_isr: ISR: 0x00000001 IMR: 0x00000000
[ 1137.988980] wlp5s6: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 3=DEAUTH_LEAVING)

Is it something harmless?

Here is the device:
05:06.0 Ethernet controller [0200]: Qualcomm Atheros AR2413/AR2414
Wireless Network Adapter [AR5005G(S) 802.11bg] [168c:001a] (rev 01)
    Subsystem: Qualcomm Atheros Compex Wireless 802.11 b/g  MiniPCI
Adapter, Rev A1 [WLM54G] [168c:2052]
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
20: 00 00 00 00 00 00 00 00 01 50 00 00 8c 16 52 20
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

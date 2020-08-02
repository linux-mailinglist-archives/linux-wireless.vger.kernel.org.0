Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE0239C0A
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Aug 2020 22:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHBUyy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 16:54:54 -0400
Received: from mail.ispras.ru ([83.149.199.84]:43746 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgHBUyy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 16:54:54 -0400
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Aug 2020 16:54:52 EDT
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 8E4CF40A2047;
        Sun,  2 Aug 2020 20:46:10 +0000 (UTC)
Date:   Sun, 2 Aug 2020 23:46:10 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-wireless@vger.kernel.org
cc:     Luca Coelho <luca@coelho.fi>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>, linuxwifi@intel.com
Subject: iwlmvm bug: AX 200 firmware crash on boot
Message-ID: <alpine.LNX.2.20.13.2008022329000.2454@monopod.intra.ispras.ru>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I'm regularly facing an issue where cold-booting a laptop while on battery
(not on AC, not on warm reboot) leaves it without wifi because the firmware
crashed. A simple 'modprobe -r iwlmvm && modprobe iwlmvm' "fixes" the issue.

The card is Intel Wi-Fi 6 AX 200. I'm pasting 'dmesg | grep iwlwifi' below.
Can I help in identifying the problem?

Thanks.
Alexander

iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-cc-a0-56.ucode failed with error -2
iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.22
iwlwifi 0000:01:00.0: Found debug destination: EXTERNAL_DRAM
iwlwifi 0000:01:00.0: Found debug configuration: 0
iwlwifi 0000:01:00.0: loaded firmware version 55.d9698065.0 cc-a0-55.ucode op_mode iwlmvm
iwlwifi 0000:01:00.0: Direct firmware load for iwl-debug-yoyo.bin failed with error -2
iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
iwlwifi 0000:01:00.0: SecBoot CPU1 Status: 0x65d3, CPU2 Status: 0x3
iwlwifi 0000:01:00.0: UMAC PC: 0x8048074c
iwlwifi 0000:01:00.0: LMAC PC: 0x4e4bbc
iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 13 fired.
iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
iwlwifi 0000:01:00.0: Status: 0x00000000, count: 6
iwlwifi 0000:01:00.0: Loaded firmware version: 55.d9698065.0 cc-a0-55.ucode
iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN       
iwlwifi 0000:01:00.0: 0x002022F0 | trm_hw_status0
iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:01:00.0: 0x004FA34A | branchlink2
iwlwifi 0000:01:00.0: 0x004E4BBC | interruptlink1
iwlwifi 0000:01:00.0: 0x004E4BBC | interruptlink2
iwlwifi 0000:01:00.0: 0x004F9230 | data1
iwlwifi 0000:01:00.0: 0xFF000000 | data2
iwlwifi 0000:01:00.0: 0x00000000 | data3
iwlwifi 0000:01:00.0: 0x00000000 | beacon time
iwlwifi 0000:01:00.0: 0x000B1A7A | tsf low
iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
iwlwifi 0000:01:00.0: 0x00000000 | time gp1
iwlwifi 0000:01:00.0: 0x000B8479 | time gp2
iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:01:00.0: 0x00000037 | uCode version major
iwlwifi 0000:01:00.0: 0xD9698065 | uCode version minor
iwlwifi 0000:01:00.0: 0x00000340 | hw version
iwlwifi 0000:01:00.0: 0x00C89000 | board version
iwlwifi 0000:01:00.0: 0x8004F502 | hcmd
iwlwifi 0000:01:00.0: 0x00020000 | isr0
iwlwifi 0000:01:00.0: 0x00000000 | isr1
iwlwifi 0000:01:00.0: 0x08F00002 | isr2
iwlwifi 0000:01:00.0: 0x00C0001C | isr3
iwlwifi 0000:01:00.0: 0x00000000 | isr4
iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
iwlwifi 0000:01:00.0: 0x004F9230 | wait_event
iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
iwlwifi 0000:01:00.0: 0x00000020 | l2p_duration
iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:01:00.0: 0x00000000 | timestamp
iwlwifi 0000:01:00.0: 0x00000020 | flow_handler
iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
iwlwifi 0000:01:00.0: Status: 0x00000000, count: 7
iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:01:00.0: 0x80465826 | umac branchlink2
iwlwifi 0000:01:00.0: 0x8048074C | umac interruptlink1
iwlwifi 0000:01:00.0: 0x8048074C | umac interruptlink2
iwlwifi 0000:01:00.0: 0x01000000 | umac data1
iwlwifi 0000:01:00.0: 0x8048074C | umac data2
iwlwifi 0000:01:00.0: 0x00000000 | umac data3
iwlwifi 0000:01:00.0: 0x00000037 | umac major
iwlwifi 0000:01:00.0: 0xD9698065 | umac minor
iwlwifi 0000:01:00.0: 0x000B8474 | frame pointer
iwlwifi 0000:01:00.0: 0xC0886270 | stack pointer
iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
iwlwifi 0000:01:00.0: Fseq Registers:
iwlwifi 0000:01:00.0: 0x20000000 | FSEQ_ERROR_CODE
iwlwifi 0000:01:00.0: 0x80290021 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:01:00.0: 0x00050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:01:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:01:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:01:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:01:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:01:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:01:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:01:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:01:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5E01E4E4F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 21:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgE0Tgx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 15:36:53 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:51512 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0Tgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 15:36:52 -0400
Received: from [192.168.254.4] (unknown [50.34.197.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 768A913C2B0
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 12:36:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 768A913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1590608209;
        bh=ahnyjx7du8MX+Ky35qPju0BQzSqK2vlzgbY/Ga/QDuo=;
        h=To:From:Subject:Date:From;
        b=I1Rr+FGC6CcNGX3APYX4dTfnVhB0StAsOXWFXzFcbdBQBAPBPyOOOrNM88gqN9WSq
         Z9H5h9k9B2uAW1/t6HvE2VH/wi0N3kMCCw/o79w3H2g0qz4OJgURHQeI0SOe+5MeB/
         vL87+zghUEwzwH88QFSRi4hb4KX7vxtzPfxuyLDM=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax200 crashed and did not recover, firmware 48.4fa0041f.0
Message-ID: <9f566f83-43a3-dd8d-8558-8ae4c8fb7d93@candelatech.com>
Date:   Wed, 27 May 2020 12:36:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here is console logs for a system with 4 ax200 radios in it.  Test case was
bi-directional traffic to wave-2 AP.

The bitrate warning is not a real problem I think.

wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
iwlwifi 0000:0a:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:0a:00.0: Start IWL Error Log Dump:
iwlwifi 0000:0a:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:0a:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:0a:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:0a:00.0: 0x000022F0 | trm_hw_status0
iwlwifi 0000:0a:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:0a:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:0a:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:0a:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:0a:00.0: 0x000DFFD5 | data1
iwlwifi 0000:0a:00.0: 0x64000001 | data2
iwlwifi 0000:0a:00.0: 0x04180604 | data3
iwlwifi 0000:0a:00.0: 0x9440F173 | beacon time
iwlwifi 0000:0a:00.0: 0x26C3FE57 | tsf low
iwlwifi 0000:0a:00.0: 0x00000001 | tsf hi
iwlwifi 0000:0a:00.0: 0x00000000 | time gp1
iwlwifi 0000:0a:00.0: 0x04284A2E | time gp2
iwlwifi 0000:0a:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:0a:00.0: 0x00000030 | uCode version major
iwlwifi 0000:0a:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:0a:00.0: 0x00000340 | hw version
iwlwifi 0000:0a:00.0: 0x00C89000 | board version
iwlwifi 0000:0a:00.0: 0x8053FD06 | hcmd
iwlwifi 0000:0a:00.0: 0x80021000 | isr0
iwlwifi 0000:0a:00.0: 0x00440000 | isr1
iwlwifi 0000:0a:00.0: 0x08F00102 | isr2
iwlwifi 0000:0a:00.0: 0x04C1FFDD | isr3
iwlwifi 0000:0a:00.0: 0x00000000 | isr4
iwlwifi 0000:0a:00.0: 0x0362001C | last cmd Id
iwlwifi 0000:0a:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:0a:00.0: 0x000000B4 | l2p_control
iwlwifi 0000:0a:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:0a:00.0: 0x0000000F | l2p_mhvalid
iwlwifi 0000:0a:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:0a:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:0a:00.0: 0x00000000 | timestamp
iwlwifi 0000:0a:00.0: 0x00006040 | flow_handler
iwlwifi 0000:0a:00.0: Start IWL Error Log Dump:
iwlwifi 0000:0a:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:0a:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:0a:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:0a:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:0a:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:0a:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:0a:00.0: 0x00000400 | umac data1
iwlwifi 0000:0a:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:0a:00.0: 0x00000000 | umac data3
iwlwifi 0000:0a:00.0: 0x00000030 | umac major
iwlwifi 0000:0a:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:0a:00.0: 0x04284A3E | frame pointer
iwlwifi 0000:0a:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:0a:00.0: 0x00B2010C | last host cmd
iwlwifi 0000:0a:00.0: 0x00000000 | isr status reg
iwlwifi 0000:0a:00.0: Fseq Registers:
iwlwifi 0000:0a:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:0a:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:0a:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:0a:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:0a:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:0a:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:0a:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:0a:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:0a:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:0a:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:0a:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:0a:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:09:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:09:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:09:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:09:00.0: 0x00A022F0 | trm_hw_status0
iwlwifi 0000:09:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:09:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:09:00.0: 0xFFECFFDC | data1
iwlwifi 0000:09:00.0: 0x64010001 | data2
iwlwifi 0000:09:00.0: 0x040C0606 | data3
iwlwifi 0000:09:00.0: 0x97012E87 | beacon time
iwlwifi 0000:09:00.0: 0x26D81143 | tsf low
iwlwifi 0000:09:00.0: 0x00000001 | tsf hi
iwlwifi 0000:09:00.0: 0x00000000 | time gp1
iwlwifi 0000:09:00.0: 0x0439B149 | time gp2
iwlwifi 0000:09:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:09:00.0: 0x00000030 | uCode version major
iwlwifi 0000:09:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:09:00.0: 0x00000340 | hw version
iwlwifi 0000:09:00.0: 0x00C89000 | board version
iwlwifi 0000:09:00.0: 0x80B5FD06 | hcmd
iwlwifi 0000:09:00.0: 0x80021000 | isr0
iwlwifi 0000:09:00.0: 0x01440000 | isr1
iwlwifi 0000:09:00.0: 0x08F00102 | isr2
iwlwifi 0000:09:00.0: 0x04C1FFDD | isr3
iwlwifi 0000:09:00.0: 0x00000000 | isr4
iwlwifi 0000:09:00.0: 0x00A9019C | last cmd Id
iwlwifi 0000:09:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:09:00.0: 0x00000A88 | l2p_control
iwlwifi 0000:09:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:09:00.0: 0x000000BF | l2p_mhvalid
iwlwifi 0000:09:00.0: 0x000000E7 | l2p_addr_match
iwlwifi 0000:09:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:09:00.0: 0x00000000 | timestamp
iwlwifi 0000:09:00.0: 0x0000E804 | flow_handler
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:09:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:09:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:09:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:09:00.0: 0x00000400 | umac data1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:09:00.0: 0x00000000 | umac data3
iwlwifi 0000:09:00.0: 0x00000030 | umac major
iwlwifi 0000:09:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:09:00.0: 0x0439B159 | frame pointer
iwlwifi 0000:09:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:09:00.0: 0x00AA010C | last host cmd
iwlwifi 0000:09:00.0: 0x00000000 | isr status reg
iwlwifi 0000:09:00.0: Fseq Registers:
iwlwifi 0000:09:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:09:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:09:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:09:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:09:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:09:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:09:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:09:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:09:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:09:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:09:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:09:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:09:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:09:00.0: 0x00A022F0 | trm_hw_status0
iwlwifi 0000:09:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:09:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:09:00.0: 0xFFF0FFCE | data1
iwlwifi 0000:09:00.0: 0x64010001 | data2
iwlwifi 0000:09:00.0: 0x04180604 | data3
iwlwifi 0000:09:00.0: 0x05010D99 | beacon time
iwlwifi 0000:09:00.0: 0x271050E0 | tsf low
iwlwifi 0000:09:00.0: 0x00000001 | tsf hi
iwlwifi 0000:09:00.0: 0x00000000 | time gp1
iwlwifi 0000:09:00.0: 0x00216245 | time gp2
iwlwifi 0000:09:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:09:00.0: 0x00000030 | uCode version major
iwlwifi 0000:09:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:09:00.0: 0x00000340 | hw version
iwlwifi 0000:09:00.0: 0x00C89000 | board version
iwlwifi 0000:09:00.0: 0x8093FD06 | hcmd
iwlwifi 0000:09:00.0: 0x00021000 | isr0
iwlwifi 0000:09:00.0: 0x00040000 | isr1
iwlwifi 0000:09:00.0: 0x08F00102 | isr2
iwlwifi 0000:09:00.0: 0x04C1FFDD | isr3
iwlwifi 0000:09:00.0: 0x00000000 | isr4
iwlwifi 0000:09:00.0: 0x0301001C | last cmd Id
iwlwifi 0000:09:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:09:00.0: 0x00000000 | l2p_control
iwlwifi 0000:09:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:09:00.0: 0x000000BF | l2p_mhvalid
iwlwifi 0000:09:00.0: 0x00000004 | l2p_addr_match
iwlwifi 0000:09:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:09:00.0: 0x00000000 | timestamp
iwlwifi 0000:09:00.0: 0x000048FC | flow_handler
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:09:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:09:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:09:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:09:00.0: 0x00000400 | umac data1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:09:00.0: 0x00000000 | umac data3
iwlwifi 0000:09:00.0: 0x00000030 | umac major
iwlwifi 0000:09:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:09:00.0: 0x00216255 | frame pointer
iwlwifi 0000:09:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:09:00.0: 0x0043019C | last host cmd
iwlwifi 0000:09:00.0: 0x00000000 | isr status reg
iwlwifi 0000:09:00.0: Fseq Registers:
iwlwifi 0000:09:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:09:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:09:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:09:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:09:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:09:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:09:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:09:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:09:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:09:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
iwlwifi 0000:09:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:09:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:09:00.0: 0x00004424 | ADVANCED_SYSASSERT
iwlwifi 0000:09:00.0: 0x00002EF5 | trm_hw_status0
iwlwifi 0000:09:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:09:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:09:00.0: 0x00025829 | data1
iwlwifi 0000:09:00.0: 0x00000007 | data2
iwlwifi 0000:09:00.0: 0x00000FFE | data3
iwlwifi 0000:09:00.0: 0x73C096DE | beacon time
iwlwifi 0000:09:00.0: 0x2B6FA8EB | tsf low
iwlwifi 0000:09:00.0: 0x00000001 | tsf hi
iwlwifi 0000:09:00.0: 0x00000000 | time gp1
iwlwifi 0000:09:00.0: 0x03161A2C | time gp2
iwlwifi 0000:09:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:09:00.0: 0x00000030 | uCode version major
iwlwifi 0000:09:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:09:00.0: 0x00000340 | hw version
iwlwifi 0000:09:00.0: 0x00C89000 | board version
iwlwifi 0000:09:00.0: 0x0393001C | hcmd
iwlwifi 0000:09:00.0: 0x80120000 | isr0
iwlwifi 0000:09:00.0: 0x00400000 | isr1
iwlwifi 0000:09:00.0: 0x08F00002 | isr2
iwlwifi 0000:09:00.0: 0x04C1820C | isr3
iwlwifi 0000:09:00.0: 0x00000000 | isr4
iwlwifi 0000:09:00.0: 0x0392001C | last cmd Id
iwlwifi 0000:09:00.0: 0x00016FF4 | wait_event
iwlwifi 0000:09:00.0: 0x000000D4 | l2p_control
iwlwifi 0000:09:00.0: 0x00002820 | l2p_duration
iwlwifi 0000:09:00.0: 0x00000007 | l2p_mhvalid
iwlwifi 0000:09:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:09:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:09:00.0: 0x00000000 | timestamp
iwlwifi 0000:09:00.0: 0x00003850 | flow_handler
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:09:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:09:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:09:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:09:00.0: 0x00000400 | umac data1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:09:00.0: 0x00000000 | umac data3
iwlwifi 0000:09:00.0: 0x00000030 | umac major
iwlwifi 0000:09:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:09:00.0: 0x03161A3C | frame pointer
iwlwifi 0000:09:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:09:00.0: 0x009F010C | last host cmd
iwlwifi 0000:09:00.0: 0x00000000 | isr status reg
iwlwifi 0000:09:00.0: Fseq Registers:
iwlwifi 0000:09:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:09:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:09:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:09:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:09:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:09:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:09:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:09:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:09:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:09:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:05:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:05:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:05:00.0: 0x00004424 | ADVANCED_SYSASSERT
iwlwifi 0000:05:00.0: 0x00002EF0 | trm_hw_status0
iwlwifi 0000:05:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:05:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:05:00.0: 0x0002DCBD | data1
iwlwifi 0000:05:00.0: 0x00000007 | data2
iwlwifi 0000:05:00.0: 0x00000FFE | data3
iwlwifi 0000:05:00.0: 0xD5404959 | beacon time
iwlwifi 0000:05:00.0: 0x2DB6C670 | tsf low
iwlwifi 0000:05:00.0: 0x00000001 | tsf hi
iwlwifi 0000:05:00.0: 0x00000000 | time gp1
iwlwifi 0000:05:00.0: 0x0562BA99 | time gp2
iwlwifi 0000:05:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:05:00.0: 0x00000030 | uCode version major
iwlwifi 0000:05:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:05:00.0: 0x00000340 | hw version
iwlwifi 0000:05:00.0: 0x00C89000 | board version
iwlwifi 0000:05:00.0: 0x0301001C | hcmd
iwlwifi 0000:05:00.0: 0x80120000 | isr0
iwlwifi 0000:05:00.0: 0x00400000 | isr1
iwlwifi 0000:05:00.0: 0x08F00002 | isr2
iwlwifi 0000:05:00.0: 0x04C00008 | isr3
iwlwifi 0000:05:00.0: 0x00000000 | isr4
iwlwifi 0000:05:00.0: 0x030E001C | last cmd Id
iwlwifi 0000:05:00.0: 0x0001503E | wait_event
iwlwifi 0000:05:00.0: 0x00000000 | l2p_control
iwlwifi 0000:05:00.0: 0x00000020 | l2p_duration
iwlwifi 0000:05:00.0: 0x000000BF | l2p_mhvalid
iwlwifi 0000:05:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:05:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:05:00.0: 0x00000000 | timestamp
iwlwifi 0000:05:00.0: 0x000040D8 | flow_handler
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:05:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:05:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:05:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:05:00.0: 0x00000400 | umac data1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:05:00.0: 0x00000000 | umac data3
iwlwifi 0000:05:00.0: 0x00000030 | umac major
iwlwifi 0000:05:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:05:00.0: 0x0562BAA9 | frame pointer
iwlwifi 0000:05:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:05:00.0: 0x00EF010C | last host cmd
iwlwifi 0000:05:00.0: 0x00000000 | isr status reg
iwlwifi 0000:05:00.0: Fseq Registers:
iwlwifi 0000:05:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:05:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:05:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:05:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:05:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:05:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:05:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:05:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:05:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:05:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
iwlwifi 0000:05:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:05:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:05:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:05:00.0: 0x00A022F0 | trm_hw_status0
iwlwifi 0000:05:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:05:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:05:00.0: 0xFFE0FFEE | data1
iwlwifi 0000:05:00.0: 0x6A000201 | data2
iwlwifi 0000:05:00.0: 0x040C0605 | data3
iwlwifi 0000:05:00.0: 0x96C08218 | beacon time
iwlwifi 0000:05:00.0: 0x31B5FDB1 | tsf low
iwlwifi 0000:05:00.0: 0x00000001 | tsf hi
iwlwifi 0000:05:00.0: 0x00000000 | time gp1
iwlwifi 0000:05:00.0: 0x03EB72F7 | time gp2
iwlwifi 0000:05:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:05:00.0: 0x00000030 | uCode version major
iwlwifi 0000:05:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:05:00.0: 0x00000340 | hw version
iwlwifi 0000:05:00.0: 0x00C89000 | board version
iwlwifi 0000:05:00.0: 0x808CFD06 | hcmd
iwlwifi 0000:05:00.0: 0x80021000 | isr0
iwlwifi 0000:05:00.0: 0x00440000 | isr1
iwlwifi 0000:05:00.0: 0x08F00102 | isr2
iwlwifi 0000:05:00.0: 0x04C1EFCD | isr3
iwlwifi 0000:05:00.0: 0x00000000 | isr4
iwlwifi 0000:05:00.0: 0x03A3001C | last cmd Id
iwlwifi 0000:05:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:05:00.0: 0x000000B4 | l2p_control
iwlwifi 0000:05:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:05:00.0: 0x0000000F | l2p_mhvalid
iwlwifi 0000:05:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:05:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:05:00.0: 0x00000000 | timestamp
iwlwifi 0000:05:00.0: 0x0000403C | flow_handler
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:05:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:05:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:05:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:05:00.0: 0x00000400 | umac data1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:05:00.0: 0x00000000 | umac data3
iwlwifi 0000:05:00.0: 0x00000030 | umac major
iwlwifi 0000:05:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:05:00.0: 0x03EB7306 | frame pointer
iwlwifi 0000:05:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:05:00.0: 0x0004010C | last host cmd
iwlwifi 0000:05:00.0: 0x00000000 | isr status reg
iwlwifi 0000:05:00.0: Fseq Registers:
iwlwifi 0000:05:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:05:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:05:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:05:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:05:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:05:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:05:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:05:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:05:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:05:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
iwlwifi 0000:05:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:05:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:05:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:05:00.0: 0x00A0A210 | trm_hw_status0
iwlwifi 0000:05:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:05:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:05:00.0: 0xFFE7FFDA | data1
iwlwifi 0000:05:00.0: 0x6A010201 | data2
iwlwifi 0000:05:00.0: 0x040C0606 | data3
iwlwifi 0000:05:00.0: 0x0080CD36 | beacon time
iwlwifi 0000:05:00.0: 0x3607F2CC | tsf low
iwlwifi 0000:05:00.0: 0x00000001 | tsf hi
iwlwifi 0000:05:00.0: 0x00000000 | time gp1
iwlwifi 0000:05:00.0: 0x003D037F | time gp2
iwlwifi 0000:05:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:05:00.0: 0x00000030 | uCode version major
iwlwifi 0000:05:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:05:00.0: 0x00000340 | hw version
iwlwifi 0000:05:00.0: 0x00C89000 | board version
iwlwifi 0000:05:00.0: 0x80ACFD06 | hcmd
iwlwifi 0000:05:00.0: 0xE6821000 | isr0
iwlwifi 0000:05:00.0: 0x00040000 | isr1
iwlwifi 0000:05:00.0: 0x08F00102 | isr2
iwlwifi 0000:05:00.0: 0x04C1DFDD | isr3
iwlwifi 0000:05:00.0: 0x00000000 | isr4
iwlwifi 0000:05:00.0: 0x802F009D | last cmd Id
iwlwifi 0000:05:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:05:00.0: 0x00000084 | l2p_control
iwlwifi 0000:05:00.0: 0x00010014 | l2p_duration
iwlwifi 0000:05:00.0: 0x0000000F | l2p_mhvalid
iwlwifi 0000:05:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:05:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:05:00.0: 0x00000000 | timestamp
iwlwifi 0000:05:00.0: 0x000070C4 | flow_handler
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:05:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:05:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:05:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:05:00.0: 0x00000400 | umac data1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:05:00.0: 0x00000000 | umac data3
iwlwifi 0000:05:00.0: 0x00000030 | umac major
iwlwifi 0000:05:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:05:00.0: 0x003D038F | frame pointer
iwlwifi 0000:05:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:05:00.0: 0x00420128 | last host cmd
iwlwifi 0000:05:00.0: 0x00000000 | isr status reg
iwlwifi 0000:05:00.0: Fseq Registers:
iwlwifi 0000:05:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:05:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:05:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:05:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:05:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:05:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:05:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:05:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:05:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:05:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:05:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000050, count: 6
iwlwifi 0000:05:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:05:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:05:00.0: 0x0000A2F0 | trm_hw_status0
iwlwifi 0000:05:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:05:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:05:00.0: 0xFFF5FFE5 | data1
iwlwifi 0000:05:00.0: 0x70010300 | data2
iwlwifi 0000:05:00.0: 0x010C0606 | data3
iwlwifi 0000:05:00.0: 0x00000000 | beacon time
iwlwifi 0000:05:00.0: 0x0001AA04 | tsf low
iwlwifi 0000:05:00.0: 0x00000000 | tsf hi
iwlwifi 0000:05:00.0: 0x00000000 | time gp1
iwlwifi 0000:05:00.0: 0x00020B40 | time gp2
iwlwifi 0000:05:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:05:00.0: 0x00000030 | uCode version major
iwlwifi 0000:05:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:05:00.0: 0x00000340 | hw version
iwlwifi 0000:05:00.0: 0x00C89000 | board version
iwlwifi 0000:05:00.0: 0x8011FD0C | hcmd
iwlwifi 0000:05:00.0: 0xE29A9000 | isr0
iwlwifi 0000:05:00.0: 0x00000000 | isr1
iwlwifi 0000:05:00.0: 0x08F80002 | isr2
iwlwifi 0000:05:00.0: 0x04C0001C | isr3
iwlwifi 0000:05:00.0: 0x00000000 | isr4
iwlwifi 0000:05:00.0: 0x00000000 | last cmd Id
iwlwifi 0000:05:00.0: 0x0001503E | wait_event
iwlwifi 0000:05:00.0: 0x00000000 | l2p_control
iwlwifi 0000:05:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:05:00.0: 0x00000000 | l2p_mhvalid
iwlwifi 0000:05:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:05:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:05:00.0: 0x00000000 | timestamp
iwlwifi 0000:05:00.0: 0x00000020 | flow_handler
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000050, count: 7
iwlwifi 0000:05:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:05:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:05:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:05:00.0: 0x00000400 | umac data1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:05:00.0: 0x00000000 | umac data3
iwlwifi 0000:05:00.0: 0x00000030 | umac major
iwlwifi 0000:05:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:05:00.0: 0x00020B52 | frame pointer
iwlwifi 0000:05:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:05:00.0: 0x00010C00 | last host cmd
iwlwifi 0000:05:00.0: 0x00000000 | isr status reg
iwlwifi 0000:05:00.0: Fseq Registers:
iwlwifi 0000:05:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:05:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:05:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:05:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:05:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:05:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:05:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:05:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:05:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:05:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:05:00.0: Firmware error during reconfiguration - reprobe!
iwlwifi 0000:05:00.0: Failed to start RT ucode: -5
iwlwifi 0000:05:00.0: Firmware not running - cannot dump error
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
iwlwifi 0000:05:00.0: Failed to trigger RX queues sync (-5)
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0

-- 
Brent Lovelace
Candela Technologies
brent.lovelace@candelatech.com
Office: 360-380-1618


ax-console-output.txt

Fedora 30 (MATE-Compiz)
Kernel 5.4.35+ on an x86_64 (ttyS0)

ct523c-620b login: wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
iwlwifi 0000:0a:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:0a:00.0: Start IWL Error Log Dump:
iwlwifi 0000:0a:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:0a:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:0a:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:0a:00.0: 0x000022F0 | trm_hw_status0
iwlwifi 0000:0a:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:0a:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:0a:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:0a:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:0a:00.0: 0x000DFFD5 | data1
iwlwifi 0000:0a:00.0: 0x64000001 | data2
iwlwifi 0000:0a:00.0: 0x04180604 | data3
iwlwifi 0000:0a:00.0: 0x9440F173 | beacon time
iwlwifi 0000:0a:00.0: 0x26C3FE57 | tsf low
iwlwifi 0000:0a:00.0: 0x00000001 | tsf hi
iwlwifi 0000:0a:00.0: 0x00000000 | time gp1
iwlwifi 0000:0a:00.0: 0x04284A2E | time gp2
iwlwifi 0000:0a:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:0a:00.0: 0x00000030 | uCode version major
iwlwifi 0000:0a:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:0a:00.0: 0x00000340 | hw version
iwlwifi 0000:0a:00.0: 0x00C89000 | board version
iwlwifi 0000:0a:00.0: 0x8053FD06 | hcmd
iwlwifi 0000:0a:00.0: 0x80021000 | isr0
iwlwifi 0000:0a:00.0: 0x00440000 | isr1
iwlwifi 0000:0a:00.0: 0x08F00102 | isr2
iwlwifi 0000:0a:00.0: 0x04C1FFDD | isr3
iwlwifi 0000:0a:00.0: 0x00000000 | isr4
iwlwifi 0000:0a:00.0: 0x0362001C | last cmd Id
iwlwifi 0000:0a:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:0a:00.0: 0x000000B4 | l2p_control
iwlwifi 0000:0a:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:0a:00.0: 0x0000000F | l2p_mhvalid
iwlwifi 0000:0a:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:0a:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:0a:00.0: 0x00000000 | timestamp
iwlwifi 0000:0a:00.0: 0x00006040 | flow_handler
iwlwifi 0000:0a:00.0: Start IWL Error Log Dump:
iwlwifi 0000:0a:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:0a:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:0a:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:0a:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:0a:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:0a:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:0a:00.0: 0x00000400 | umac data1
iwlwifi 0000:0a:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:0a:00.0: 0x00000000 | umac data3
iwlwifi 0000:0a:00.0: 0x00000030 | umac major
iwlwifi 0000:0a:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:0a:00.0: 0x04284A3E | frame pointer
iwlwifi 0000:0a:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:0a:00.0: 0x00B2010C | last host cmd
iwlwifi 0000:0a:00.0: 0x00000000 | isr status reg
iwlwifi 0000:0a:00.0: Fseq Registers:
iwlwifi 0000:0a:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:0a:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:0a:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:0a:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:0a:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:0a:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:0a:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:0a:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:0a:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:0a:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:0a:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:0a:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:09:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:09:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:09:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:09:00.0: 0x00A022F0 | trm_hw_status0
iwlwifi 0000:09:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:09:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:09:00.0: 0xFFECFFDC | data1
iwlwifi 0000:09:00.0: 0x64010001 | data2
iwlwifi 0000:09:00.0: 0x040C0606 | data3
iwlwifi 0000:09:00.0: 0x97012E87 | beacon time
iwlwifi 0000:09:00.0: 0x26D81143 | tsf low
iwlwifi 0000:09:00.0: 0x00000001 | tsf hi
iwlwifi 0000:09:00.0: 0x00000000 | time gp1
iwlwifi 0000:09:00.0: 0x0439B149 | time gp2
iwlwifi 0000:09:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:09:00.0: 0x00000030 | uCode version major
iwlwifi 0000:09:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:09:00.0: 0x00000340 | hw version
iwlwifi 0000:09:00.0: 0x00C89000 | board version
iwlwifi 0000:09:00.0: 0x80B5FD06 | hcmd
iwlwifi 0000:09:00.0: 0x80021000 | isr0
iwlwifi 0000:09:00.0: 0x01440000 | isr1
iwlwifi 0000:09:00.0: 0x08F00102 | isr2
iwlwifi 0000:09:00.0: 0x04C1FFDD | isr3
iwlwifi 0000:09:00.0: 0x00000000 | isr4
iwlwifi 0000:09:00.0: 0x00A9019C | last cmd Id
iwlwifi 0000:09:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:09:00.0: 0x00000A88 | l2p_control
iwlwifi 0000:09:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:09:00.0: 0x000000BF | l2p_mhvalid
iwlwifi 0000:09:00.0: 0x000000E7 | l2p_addr_match
iwlwifi 0000:09:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:09:00.0: 0x00000000 | timestamp
iwlwifi 0000:09:00.0: 0x0000E804 | flow_handler
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:09:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:09:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:09:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:09:00.0: 0x00000400 | umac data1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:09:00.0: 0x00000000 | umac data3
iwlwifi 0000:09:00.0: 0x00000030 | umac major
iwlwifi 0000:09:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:09:00.0: 0x0439B159 | frame pointer
iwlwifi 0000:09:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:09:00.0: 0x00AA010C | last host cmd
iwlwifi 0000:09:00.0: 0x00000000 | isr status reg
iwlwifi 0000:09:00.0: Fseq Registers:
iwlwifi 0000:09:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:09:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:09:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:09:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:09:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:09:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:09:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:09:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:09:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:09:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:09:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:09:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:09:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:09:00.0: 0x00A022F0 | trm_hw_status0
iwlwifi 0000:09:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:09:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:09:00.0: 0xFFF0FFCE | data1
iwlwifi 0000:09:00.0: 0x64010001 | data2
iwlwifi 0000:09:00.0: 0x04180604 | data3
iwlwifi 0000:09:00.0: 0x05010D99 | beacon time
iwlwifi 0000:09:00.0: 0x271050E0 | tsf low
iwlwifi 0000:09:00.0: 0x00000001 | tsf hi
iwlwifi 0000:09:00.0: 0x00000000 | time gp1
iwlwifi 0000:09:00.0: 0x00216245 | time gp2
iwlwifi 0000:09:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:09:00.0: 0x00000030 | uCode version major
iwlwifi 0000:09:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:09:00.0: 0x00000340 | hw version
iwlwifi 0000:09:00.0: 0x00C89000 | board version
iwlwifi 0000:09:00.0: 0x8093FD06 | hcmd
iwlwifi 0000:09:00.0: 0x00021000 | isr0
iwlwifi 0000:09:00.0: 0x00040000 | isr1
iwlwifi 0000:09:00.0: 0x08F00102 | isr2
iwlwifi 0000:09:00.0: 0x04C1FFDD | isr3
iwlwifi 0000:09:00.0: 0x00000000 | isr4
iwlwifi 0000:09:00.0: 0x0301001C | last cmd Id
iwlwifi 0000:09:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:09:00.0: 0x00000000 | l2p_control
iwlwifi 0000:09:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:09:00.0: 0x000000BF | l2p_mhvalid
iwlwifi 0000:09:00.0: 0x00000004 | l2p_addr_match
iwlwifi 0000:09:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:09:00.0: 0x00000000 | timestamp
iwlwifi 0000:09:00.0: 0x000048FC | flow_handler
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:09:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:09:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:09:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:09:00.0: 0x00000400 | umac data1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:09:00.0: 0x00000000 | umac data3
iwlwifi 0000:09:00.0: 0x00000030 | umac major
iwlwifi 0000:09:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:09:00.0: 0x00216255 | frame pointer
iwlwifi 0000:09:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:09:00.0: 0x0043019C | last host cmd
iwlwifi 0000:09:00.0: 0x00000000 | isr status reg
iwlwifi 0000:09:00.0: Fseq Registers:
iwlwifi 0000:09:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:09:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:09:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:09:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:09:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:09:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:09:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:09:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:09:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:09:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan1: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan0: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
iwlwifi 0000:09:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:09:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:09:00.0: 0x00004424 | ADVANCED_SYSASSERT
iwlwifi 0000:09:00.0: 0x00002EF5 | trm_hw_status0
iwlwifi 0000:09:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:09:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:09:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:09:00.0: 0x00025829 | data1
iwlwifi 0000:09:00.0: 0x00000007 | data2
iwlwifi 0000:09:00.0: 0x00000FFE | data3
iwlwifi 0000:09:00.0: 0x73C096DE | beacon time
iwlwifi 0000:09:00.0: 0x2B6FA8EB | tsf low
iwlwifi 0000:09:00.0: 0x00000001 | tsf hi
iwlwifi 0000:09:00.0: 0x00000000 | time gp1
iwlwifi 0000:09:00.0: 0x03161A2C | time gp2
iwlwifi 0000:09:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:09:00.0: 0x00000030 | uCode version major
iwlwifi 0000:09:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:09:00.0: 0x00000340 | hw version
iwlwifi 0000:09:00.0: 0x00C89000 | board version
iwlwifi 0000:09:00.0: 0x0393001C | hcmd
iwlwifi 0000:09:00.0: 0x80120000 | isr0
iwlwifi 0000:09:00.0: 0x00400000 | isr1
iwlwifi 0000:09:00.0: 0x08F00002 | isr2
iwlwifi 0000:09:00.0: 0x04C1820C | isr3
iwlwifi 0000:09:00.0: 0x00000000 | isr4
iwlwifi 0000:09:00.0: 0x0392001C | last cmd Id
iwlwifi 0000:09:00.0: 0x00016FF4 | wait_event
iwlwifi 0000:09:00.0: 0x000000D4 | l2p_control
iwlwifi 0000:09:00.0: 0x00002820 | l2p_duration
iwlwifi 0000:09:00.0: 0x00000007 | l2p_mhvalid
iwlwifi 0000:09:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:09:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:09:00.0: 0x00000000 | timestamp
iwlwifi 0000:09:00.0: 0x00003850 | flow_handler
iwlwifi 0000:09:00.0: Start IWL Error Log Dump:
iwlwifi 0000:09:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:09:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:09:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:09:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:09:00.0: 0x00000400 | umac data1
iwlwifi 0000:09:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:09:00.0: 0x00000000 | umac data3
iwlwifi 0000:09:00.0: 0x00000030 | umac major
iwlwifi 0000:09:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:09:00.0: 0x03161A3C | frame pointer
iwlwifi 0000:09:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:09:00.0: 0x009F010C | last host cmd
iwlwifi 0000:09:00.0: 0x00000000 | isr status reg
iwlwifi 0000:09:00.0: Fseq Registers:
iwlwifi 0000:09:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:09:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:09:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:09:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:09:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:09:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:09:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:09:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:09:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:09:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:09:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:05:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:05:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:05:00.0: 0x00004424 | ADVANCED_SYSASSERT
iwlwifi 0000:05:00.0: 0x00002EF0 | trm_hw_status0
iwlwifi 0000:05:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:05:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:05:00.0: 0x0002DCBD | data1
iwlwifi 0000:05:00.0: 0x00000007 | data2
iwlwifi 0000:05:00.0: 0x00000FFE | data3
iwlwifi 0000:05:00.0: 0xD5404959 | beacon time
iwlwifi 0000:05:00.0: 0x2DB6C670 | tsf low
iwlwifi 0000:05:00.0: 0x00000001 | tsf hi
iwlwifi 0000:05:00.0: 0x00000000 | time gp1
iwlwifi 0000:05:00.0: 0x0562BA99 | time gp2
iwlwifi 0000:05:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:05:00.0: 0x00000030 | uCode version major
iwlwifi 0000:05:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:05:00.0: 0x00000340 | hw version
iwlwifi 0000:05:00.0: 0x00C89000 | board version
iwlwifi 0000:05:00.0: 0x0301001C | hcmd
iwlwifi 0000:05:00.0: 0x80120000 | isr0
iwlwifi 0000:05:00.0: 0x00400000 | isr1
iwlwifi 0000:05:00.0: 0x08F00002 | isr2
iwlwifi 0000:05:00.0: 0x04C00008 | isr3
iwlwifi 0000:05:00.0: 0x00000000 | isr4
iwlwifi 0000:05:00.0: 0x030E001C | last cmd Id
iwlwifi 0000:05:00.0: 0x0001503E | wait_event
iwlwifi 0000:05:00.0: 0x00000000 | l2p_control
iwlwifi 0000:05:00.0: 0x00000020 | l2p_duration
iwlwifi 0000:05:00.0: 0x000000BF | l2p_mhvalid
iwlwifi 0000:05:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:05:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:05:00.0: 0x00000000 | timestamp
iwlwifi 0000:05:00.0: 0x000040D8 | flow_handler
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:05:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:05:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:05:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:05:00.0: 0x00000400 | umac data1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:05:00.0: 0x00000000 | umac data3
iwlwifi 0000:05:00.0: 0x00000030 | umac major
iwlwifi 0000:05:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:05:00.0: 0x0562BAA9 | frame pointer
iwlwifi 0000:05:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:05:00.0: 0x00EF010C | last host cmd
iwlwifi 0000:05:00.0: 0x00000000 | isr status reg
iwlwifi 0000:05:00.0: Fseq Registers:
iwlwifi 0000:05:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:05:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:05:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:05:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:05:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:05:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:05:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:05:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:05:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:05:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
iwlwifi 0000:05:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:05:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:05:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:05:00.0: 0x00A022F0 | trm_hw_status0
iwlwifi 0000:05:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:05:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:05:00.0: 0xFFE0FFEE | data1
iwlwifi 0000:05:00.0: 0x6A000201 | data2
iwlwifi 0000:05:00.0: 0x040C0605 | data3
iwlwifi 0000:05:00.0: 0x96C08218 | beacon time
iwlwifi 0000:05:00.0: 0x31B5FDB1 | tsf low
iwlwifi 0000:05:00.0: 0x00000001 | tsf hi
iwlwifi 0000:05:00.0: 0x00000000 | time gp1
iwlwifi 0000:05:00.0: 0x03EB72F7 | time gp2
iwlwifi 0000:05:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:05:00.0: 0x00000030 | uCode version major
iwlwifi 0000:05:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:05:00.0: 0x00000340 | hw version
iwlwifi 0000:05:00.0: 0x00C89000 | board version
iwlwifi 0000:05:00.0: 0x808CFD06 | hcmd
iwlwifi 0000:05:00.0: 0x80021000 | isr0
iwlwifi 0000:05:00.0: 0x00440000 | isr1
iwlwifi 0000:05:00.0: 0x08F00102 | isr2
iwlwifi 0000:05:00.0: 0x04C1EFCD | isr3
iwlwifi 0000:05:00.0: 0x00000000 | isr4
iwlwifi 0000:05:00.0: 0x03A3001C | last cmd Id
iwlwifi 0000:05:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:05:00.0: 0x000000B4 | l2p_control
iwlwifi 0000:05:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:05:00.0: 0x0000000F | l2p_mhvalid
iwlwifi 0000:05:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:05:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:05:00.0: 0x00000000 | timestamp
iwlwifi 0000:05:00.0: 0x0000403C | flow_handler
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:05:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:05:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:05:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:05:00.0: 0x00000400 | umac data1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:05:00.0: 0x00000000 | umac data3
iwlwifi 0000:05:00.0: 0x00000030 | umac major
iwlwifi 0000:05:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:05:00.0: 0x03EB7306 | frame pointer
iwlwifi 0000:05:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:05:00.0: 0x0004010C | last host cmd
iwlwifi 0000:05:00.0: 0x00000000 | isr status reg
iwlwifi 0000:05:00.0: Fseq Registers:
iwlwifi 0000:05:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:05:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:05:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:05:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:05:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:05:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:05:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:05:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:05:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:05:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan2: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
wlan3: drv-set-bitrate-mask had error return: -95
rdev-set-bitrate-mask failed: -95
iwlwifi 0000:05:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:05:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:05:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:05:00.0: 0x00A0A210 | trm_hw_status0
iwlwifi 0000:05:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:05:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:05:00.0: 0xFFE7FFDA | data1
iwlwifi 0000:05:00.0: 0x6A010201 | data2
iwlwifi 0000:05:00.0: 0x040C0606 | data3
iwlwifi 0000:05:00.0: 0x0080CD36 | beacon time
iwlwifi 0000:05:00.0: 0x3607F2CC | tsf low
iwlwifi 0000:05:00.0: 0x00000001 | tsf hi
iwlwifi 0000:05:00.0: 0x00000000 | time gp1
iwlwifi 0000:05:00.0: 0x003D037F | time gp2
iwlwifi 0000:05:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:05:00.0: 0x00000030 | uCode version major
iwlwifi 0000:05:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:05:00.0: 0x00000340 | hw version
iwlwifi 0000:05:00.0: 0x00C89000 | board version
iwlwifi 0000:05:00.0: 0x80ACFD06 | hcmd
iwlwifi 0000:05:00.0: 0xE6821000 | isr0
iwlwifi 0000:05:00.0: 0x00040000 | isr1
iwlwifi 0000:05:00.0: 0x08F00102 | isr2
iwlwifi 0000:05:00.0: 0x04C1DFDD | isr3
iwlwifi 0000:05:00.0: 0x00000000 | isr4
iwlwifi 0000:05:00.0: 0x802F009D | last cmd Id
iwlwifi 0000:05:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:05:00.0: 0x00000084 | l2p_control
iwlwifi 0000:05:00.0: 0x00010014 | l2p_duration
iwlwifi 0000:05:00.0: 0x0000000F | l2p_mhvalid
iwlwifi 0000:05:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:05:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:05:00.0: 0x00000000 | timestamp
iwlwifi 0000:05:00.0: 0x000070C4 | flow_handler
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:05:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:05:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:05:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:05:00.0: 0x00000400 | umac data1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:05:00.0: 0x00000000 | umac data3
iwlwifi 0000:05:00.0: 0x00000030 | umac major
iwlwifi 0000:05:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:05:00.0: 0x003D038F | frame pointer
iwlwifi 0000:05:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:05:00.0: 0x00420128 | last host cmd
iwlwifi 0000:05:00.0: 0x00000000 | isr status reg
iwlwifi 0000:05:00.0: Fseq Registers:
iwlwifi 0000:05:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:05:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:05:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:05:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:05:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:05:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:05:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:05:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:05:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:05:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:05:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000050, count: 6
iwlwifi 0000:05:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:05:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:05:00.0: 0x0000A2F0 | trm_hw_status0
iwlwifi 0000:05:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:05:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:05:00.0: 0xFFF5FFE5 | data1
iwlwifi 0000:05:00.0: 0x70010300 | data2
iwlwifi 0000:05:00.0: 0x010C0606 | data3
iwlwifi 0000:05:00.0: 0x00000000 | beacon time
iwlwifi 0000:05:00.0: 0x0001AA04 | tsf low
iwlwifi 0000:05:00.0: 0x00000000 | tsf hi
iwlwifi 0000:05:00.0: 0x00000000 | time gp1
iwlwifi 0000:05:00.0: 0x00020B40 | time gp2
iwlwifi 0000:05:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:05:00.0: 0x00000030 | uCode version major
iwlwifi 0000:05:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:05:00.0: 0x00000340 | hw version
iwlwifi 0000:05:00.0: 0x00C89000 | board version
iwlwifi 0000:05:00.0: 0x8011FD0C | hcmd
iwlwifi 0000:05:00.0: 0xE29A9000 | isr0
iwlwifi 0000:05:00.0: 0x00000000 | isr1
iwlwifi 0000:05:00.0: 0x08F80002 | isr2
iwlwifi 0000:05:00.0: 0x04C0001C | isr3
iwlwifi 0000:05:00.0: 0x00000000 | isr4
iwlwifi 0000:05:00.0: 0x00000000 | last cmd Id
iwlwifi 0000:05:00.0: 0x0001503E | wait_event
iwlwifi 0000:05:00.0: 0x00000000 | l2p_control
iwlwifi 0000:05:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:05:00.0: 0x00000000 | l2p_mhvalid
iwlwifi 0000:05:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:05:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:05:00.0: 0x00000000 | timestamp
iwlwifi 0000:05:00.0: 0x00000020 | flow_handler
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000050, count: 7
iwlwifi 0000:05:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:05:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:05:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:05:00.0: 0x00000400 | umac data1
iwlwifi 0000:05:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:05:00.0: 0x00000000 | umac data3
iwlwifi 0000:05:00.0: 0x00000030 | umac major
iwlwifi 0000:05:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:05:00.0: 0x00020B52 | frame pointer
iwlwifi 0000:05:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:05:00.0: 0x00010C00 | last host cmd
iwlwifi 0000:05:00.0: 0x00000000 | isr status reg
iwlwifi 0000:05:00.0: Fseq Registers:
iwlwifi 0000:05:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:05:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:05:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:05:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:05:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:05:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:05:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:05:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:05:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:05:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:05:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:05:00.0: Firmware error during reconfiguration - reprobe!
iwlwifi 0000:05:00.0: Failed to start RT ucode: -5
iwlwifi 0000:05:00.0: Firmware not running - cannot dump error
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
iwlwifi 0000:05:00.0: Failed to trigger RX queues sync (-5)
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0
wlan3: Failed check-sdata-in-driver check, flags: 0x0

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

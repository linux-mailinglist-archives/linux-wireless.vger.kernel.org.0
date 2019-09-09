Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52A0ADDC0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405370AbfIIRD3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 13:03:29 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:45314 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405368AbfIIRD3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 13:03:29 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4F501D949
        for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2019 10:03:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4F501D949
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1568048605;
        bh=8yWFGFIBB4zh2NYtdJ8KQWi0x/1MEVy1OnQw6psfFHA=;
        h=To:From:Subject:Date:From;
        b=mu8qaKzjatZz0TiTaDqJtpvSQsM/qCMG6nZcSeUq93Ub2MOV1ZSW/c3eLwmSWnApm
         1rH6+75GCfqKPXvs4lPUMOeOv0/cmeCMEyKUyLKC3OOXiOPHbhxh2VZHj3QpYnN8rH
         xOsyWEKDhr9Hr2XpXRWh7dEunVLKZxFVw/YvGv6M=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: intel AX200 crash on 5.2.7+
Organization: Candela Technologies
Message-ID: <438925e0-deab-d84d-2b0a-da544d0989b3@candelatech.com>
Date:   Mon, 9 Sep 2019 10:03:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Looks like we managed to crash the AX200 firmware.  This was running 5.2.7+ kernel
in an apu2 platform.

Is there a better place to report/discuss this?

[ 6065.589162] iwlwifi 0000:01:00.0: iwl_trans_send_cmd bad state = 0
[ 6065.594315] iwlwifi 0000:01:00.0: iwl_trans_send_cmd bad state = 0
[ 6066.028461] alloc_contig_range: 4 callbacks suppressed
[ 6066.028468] alloc_contig_range: [11cf00, 11cf08) PFNs busy
[ 6066.028891] alloc_contig_range: [11cf00, 11cf08) PFNs busy
[ 6066.029418] alloc_contig_range: [11cf00, 11cf08) PFNs busy
[ 6066.029738] alloc_contig_range: [11cf00, 11cf08) PFNs busy
[ 6066.029991] alloc_contig_range: [11cf20, 11cf28) PFNs busy
[ 6066.030359] alloc_contig_range: [11cf28, 11cf30) PFNs busy
[ 6066.030686] alloc_contig_range: [11cf00, 11cf08) PFNs busy
[ 6066.030879] alloc_contig_range: [11cf20, 11cf28) PFNs busy
[ 6066.031175] alloc_contig_range: [11cf28, 11cf30) PFNs busy
[ 6066.031622] alloc_contig_range: [11cf00, 11cf08) PFNs busy
[ 6066.159033] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting 0x0.
[ 6066.165395] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 6066.170089] iwlwifi 0000:01:00.0: Status: 0x00000080, count: 6
[ 6066.175035] iwlwifi 0000:01:00.0: Loaded firmware version: 46.3cfab8da.0
[ 6066.180908] iwlwifi 0000:01:00.0: 0x00000942 | ADVANCED_SYSASSERT
[ 6066.186838] iwlwifi 0000:01:00.0: 0x000022F0 | trm_hw_status0
[ 6066.191483] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[ 6066.196141] iwlwifi 0000:01:00.0: 0x004FC308 | branchlink2
[ 6066.200492] iwlwifi 0000:01:00.0: 0x000013A6 | interruptlink1
[ 6066.205108] iwlwifi 0000:01:00.0: 0x000013A6 | interruptlink2
[ 6066.209728] iwlwifi 0000:01:00.0: 0x00030018 | data1
[ 6066.213631] iwlwifi 0000:01:00.0: 0x06000102 | data2
[ 6066.217421] iwlwifi 0000:01:00.0: 0x010C0605 | data3
[ 6066.221279] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[ 6066.225677] iwlwifi 0000:01:00.0: 0x00016A84 | tsf low
[ 6066.229754] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[ 6066.233656] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[ 6066.237702] iwlwifi 0000:01:00.0: 0x00016A85 | time gp2
[ 6066.241771] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[ 6066.246840] iwlwifi 0000:01:00.0: 0x0000002E | uCode version major
[ 6066.251970] iwlwifi 0000:01:00.0: 0x3CFAB8DA | uCode version minor
[ 6066.256990] iwlwifi 0000:01:00.0: 0x00000340 | hw version
[ 6066.261300] iwlwifi 0000:01:00.0: 0x18C89000 | board version
[ 6066.265877] iwlwifi 0000:01:00.0: 0x8008FD0C | hcmd
[ 6066.269662] iwlwifi 0000:01:00.0: 0x82121000 | isr0
[ 6066.273458] iwlwifi 0000:01:00.0: 0x00004000 | isr1
[ 6066.277145] iwlwifi 0000:01:00.0: 0x08F00002 | isr2
[ 6066.280873] iwlwifi 0000:01:00.0: 0x04C0001C | isr3
[ 6066.284666] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[ 6066.288464] iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
[ 6066.292860] iwlwifi 0000:01:00.0: 0x000151BE | wait_event
[ 6066.297132] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[ 6066.301482] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[ 6066.305997] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[ 6066.310347] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[ 6066.315031] iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
[ 6066.319564] iwlwifi 0000:01:00.0: 0x16042142 | timestamp
[ 6066.323790] iwlwifi 0000:01:00.0: 0x00000024 | flow_handler
[ 6066.328256] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 6066.332696] iwlwifi 0000:01:00.0: Status: 0x00000080, count: 7
[ 6066.337412] iwlwifi 0000:01:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[ 6066.342996] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[ 6066.347956] iwlwifi 0000:01:00.0: 0xC008B1C0 | umac branchlink2
[ 6066.352839] iwlwifi 0000:01:00.0: 0x80489F5E | umac interruptlink1
[ 6066.357873] iwlwifi 0000:01:00.0: 0x80489F5E | umac interruptlink2
[ 6066.362946] iwlwifi 0000:01:00.0: 0x00000400 | umac data1
[ 6066.367230] iwlwifi 0000:01:00.0: 0x80489F5E | umac data2
[ 6066.371543] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[ 6066.375864] iwlwifi 0000:01:00.0: 0x0000002E | umac major
[ 6066.380130] iwlwifi 0000:01:00.0: 0x3CFAB8DA | umac minor
[ 6066.384454] iwlwifi 0000:01:00.0: 0x00016A96 | frame pointer
[ 6066.389009] iwlwifi 0000:01:00.0: 0xC088628C | stack pointer
[ 6066.393542] iwlwifi 0000:01:00.0: 0x00010C00 | last host cmd
[ 6066.398258] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[ 6066.403123] iwlwifi 0000:01:00.0: Fseq Registers:
[ 6066.406667] iwlwifi 0000:01:00.0: 0xE0000000 | FSEQ_ERROR_CODE
[ 6066.411353] iwlwifi 0000:01:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
[ 6066.416585] iwlwifi 0000:01:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
[ 6066.421945] iwlwifi 0000:01:00.0: 0x0000A503 | FSEQ_OTP_VERSION
[ 6066.426745] iwlwifi 0000:01:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
[ 6066.432205] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 6066.436945] iwlwifi 0000:01:00.0: 0x00100530 | FSEQ_CNVI_ID
[ 6066.441305] iwlwifi 0000:01:00.0: 0x00000532 | FSEQ_CNVR_ID
[ 6066.445706] iwlwifi 0000:01:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
[ 6066.450683] iwlwifi 0000:01:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
[ 6066.455696] iwlwifi 0000:01:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 6066.462428] iwlwifi 0000:01:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 6066.469601] iwlwifi 0000:01:00.0: Failed to start RT ucode: -5
[ 6066.469800] iwlwifi 0000:01:00.0: Collecting data: trigger 2 fired.
[ 6066.474667] ieee80211 wiphy0: Hardware restart was requested
[ 6066.474705] iwlwifi 0000:01:00.0: Firmware not running - cannot dump error
[ 6066.670312] iwlwifi 0000:01:00.0: Microcode SW error detected. Restarting 0x0.
[ 6066.676579] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 6066.681073] iwlwifi 0000:01:00.0: Status: 0x00000090, count: 6
[ 6066.686028] iwlwifi 0000:01:00.0: Loaded firmware version: 46.3cfab8da.0
[ 6066.691805] iwlwifi 0000:01:00.0: 0x00000942 | ADVANCED_SYSASSERT
[ 6066.697807] iwlwifi 0000:01:00.0: 0x000022F0 | trm_hw_status0
[ 6066.702552] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[ 6066.707275] iwlwifi 0000:01:00.0: 0x004FC308 | branchlink2
[ 6066.711613] iwlwifi 0000:01:00.0: 0x000013A6 | interruptlink1
[ 6066.716231] iwlwifi 0000:01:00.0: 0x000013A6 | interruptlink2
[ 6066.720830] iwlwifi 0000:01:00.0: 0xFFF3001D | data1
[ 6066.724695] iwlwifi 0000:01:00.0: 0x06000201 | data2
[ 6066.728540] iwlwifi 0000:01:00.0: 0x01200603 | data3
[ 6066.732462] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[ 6066.736908] iwlwifi 0000:01:00.0: 0x00016CBA | tsf low
[ 6066.740883] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[ 6066.744841] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[ 6066.748946] iwlwifi 0000:01:00.0: 0x00016CBA | time gp2
[ 6066.753177] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[ 6066.758309] iwlwifi 0000:01:00.0: 0x0000002E | uCode version major
[ 6066.763468] iwlwifi 0000:01:00.0: 0x3CFAB8DA | uCode version minor
[ 6066.768602] iwlwifi 0000:01:00.0: 0x00000340 | hw version
[ 6066.772947] iwlwifi 0000:01:00.0: 0x18C89000 | board version
[ 6066.777493] iwlwifi 0000:01:00.0: 0x8008FD0C | hcmd
[ 6066.781223] iwlwifi 0000:01:00.0: 0x82121000 | isr0
[ 6066.784900] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[ 6066.788623] iwlwifi 0000:01:00.0: 0x08F00002 | isr2
[ 6066.792304] iwlwifi 0000:01:00.0: 0x04C0001C | isr3
[ 6066.796062] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[ 6066.799853] iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
[ 6066.804214] iwlwifi 0000:01:00.0: 0x000151BE | wait_event
[ 6066.808507] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[ 6066.812858] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[ 6066.817280] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[ 6066.821654] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[ 6066.826302] iwlwifi 0000:01:00.0: 0x00000009 | lmpm_pmg_sel
[ 6066.830814] iwlwifi 0000:01:00.0: 0x16042142 | timestamp
[ 6066.835048] iwlwifi 0000:01:00.0: 0x00000024 | flow_handler
[ 6066.839597] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 6066.843962] iwlwifi 0000:01:00.0: Status: 0x00000090, count: 7
[ 6066.848688] iwlwifi 0000:01:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[ 6066.854249] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[ 6066.859120] iwlwifi 0000:01:00.0: 0xC008B1C0 | umac branchlink2
[ 6066.863939] iwlwifi 0000:01:00.0: 0x80489F5E | umac interruptlink1
[ 6066.869063] iwlwifi 0000:01:00.0: 0x80489F5E | umac interruptlink2
[ 6066.874151] iwlwifi 0000:01:00.0: 0x00000400 | umac data1
[ 6066.878595] iwlwifi 0000:01:00.0: 0x80489F5E | umac data2
[ 6066.882851] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[ 6066.887132] iwlwifi 0000:01:00.0: 0x0000002E | umac major
[ 6066.891368] iwlwifi 0000:01:00.0: 0x3CFAB8DA | umac minor
[ 6066.895677] iwlwifi 0000:01:00.0: 0x00016CCC | frame pointer
[ 6066.900213] iwlwifi 0000:01:00.0: 0xC088628C | stack pointer
[ 6066.904821] iwlwifi 0000:01:00.0: 0x00010C00 | last host cmd
[ 6066.909553] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[ 6066.914192] iwlwifi 0000:01:00.0: Fseq Registers:
[ 6066.917799] iwlwifi 0000:01:00.0: 0xE0000000 | FSEQ_ERROR_CODE
[ 6066.922556] iwlwifi 0000:01:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
[ 6066.927827] iwlwifi 0000:01:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
[ 6066.933241] iwlwifi 0000:01:00.0: 0x0000A503 | FSEQ_OTP_VERSION
[ 6066.938043] iwlwifi 0000:01:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
[ 6066.943689] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 6066.948427] iwlwifi 0000:01:00.0: 0x00100530 | FSEQ_CNVI_ID
[ 6066.952870] iwlwifi 0000:01:00.0: 0x00000532 | FSEQ_CNVR_ID
[ 6066.957297] iwlwifi 0000:01:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
[ 6066.962267] iwlwifi 0000:01:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
[ 6066.967218] iwlwifi 0000:01:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 6066.973944] iwlwifi 0000:01:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 6066.981216] iwlwifi 0000:01:00.0: Firmware error during reconfiguration - reprobe!
[ 6066.981231] iwlwifi 0000:01:00.0: Failed to start RT ucode: -5
[ 6066.988465] iwlwifi 0000:01:00.0: LED command failed: -5
[ 6066.992905] iwlwifi 0000:01:00.0: Collecting data: trigger 16 fired.
[ 6066.992941] iwlwifi 0000:01:00.0: LED command failed: -5
[ 6067.242271] iwlwifi 0000:01:00.0: Firmware not running - cannot dump error


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


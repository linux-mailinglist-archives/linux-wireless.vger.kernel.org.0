Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03133C930B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 22:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfJBUsO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 16:48:14 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:50824 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJBUsO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 16:48:14 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 07142D94D
        for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2019 13:48:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 07142D94D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1570049293;
        bh=bCAzc2i+qP1CXNmuVBmA3SSf+eQiwTQcl5Sd3L+Hnb4=;
        h=To:From:Subject:Date:From;
        b=ra0JDSmovFETIW5S2F19NiVWBTRVBiSsVOqORCuZPd1JU0J2NFKjE+x6j2+GD6Kvk
         wqXHqailhzcX8sREZASpFF4kfXVDoOBG5wFdlA6dauFkKYX68b52/C7vJAxp2GeGIh
         frp8XsN2+Fus5LwAe18yINexs/nBI/HUMlAqTb/w=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: AX200 crash on udp upload, cannot restart
Organization: Candela Technologies
Message-ID: <08f29d02-2fcf-e779-6fc0-ea7a9d4e59b6@candelatech.com>
Date:   Wed, 2 Oct 2019 13:48:12 -0700
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

We have a system with several of the AX200 NICs in it, kernel is 5.2.14+.  We ran a udp upload
test of 10Mbps across all radios, and after about 10 minutes one of the radios crashed and could
not be restarted.  The others continued to run so far.

I will open a bug in the kernel bug tracker.

iwlwifi 0000:10:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:10:00.0: Start IWL Error Log Dump:
iwlwifi 0000:10:00.0: Status: 0x00000080, count: 6
iwlwifi 0000:10:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:10:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:10:00.0: 0x00A0A210 | trm_hw_status0
iwlwifi 0000:10:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:10:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:10:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:10:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:10:00.0: 0xFFE2FFEF | data1
iwlwifi 0000:10:00.0: 0x6A010200 | data2
iwlwifi 0000:10:00.0: 0x040C0605 | data3
iwlwifi 0000:10:00.0: 0xE90146BA | beacon time
iwlwifi 0000:10:00.0: 0x0A57190F | tsf low
iwlwifi 0000:10:00.0: 0x00000001 | tsf hi
iwlwifi 0000:10:00.0: 0x00000000 | time gp1
iwlwifi 0000:10:00.0: 0x129412C7 | time gp2
iwlwifi 0000:10:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:10:00.0: 0x00000030 | uCode version major
iwlwifi 0000:10:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:10:00.0: 0x00000340 | hw version
iwlwifi 0000:10:00.0: 0x00C89000 | board version
iwlwifi 0000:10:00.0: 0x80B2FD06 | hcmd
iwlwifi 0000:10:00.0: 0xE6821000 | isr0
iwlwifi 0000:10:00.0: 0x00440000 | isr1
iwlwifi 0000:10:00.0: 0x08F00102 | isr2
iwlwifi 0000:10:00.0: 0x04C187CD | isr3
iwlwifi 0000:10:00.0: 0x00000000 | isr4
iwlwifi 0000:10:00.0: 0x03AC001C | last cmd Id
iwlwifi 0000:10:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:10:00.0: 0x000000B4 | l2p_control
iwlwifi 0000:10:00.0: 0x00010014 | l2p_duration
iwlwifi 0000:10:00.0: 0x0000000F | l2p_mhvalid
iwlwifi 0000:10:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:10:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:10:00.0: 0x00000000 | timestamp
iwlwifi 0000:10:00.0: 0x0000307C | flow_handler
iwlwifi 0000:10:00.0: Start IWL Error Log Dump:
iwlwifi 0000:10:00.0: Status: 0x00000080, count: 7
iwlwifi 0000:10:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:10:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:10:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:10:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:10:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:10:00.0: 0x00000400 | umac data1
iwlwifi 0000:10:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:10:00.0: 0x00000000 | umac data3
iwlwifi 0000:10:00.0: 0x00000030 | umac major
iwlwifi 0000:10:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:10:00.0: 0x129412D8 | frame pointer
iwlwifi 0000:10:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:10:00.0: 0x004E019C | last host cmd
iwlwifi 0000:10:00.0: 0x00000000 | isr status reg
iwlwifi 0000:10:00.0: Fseq Registers:
iwlwifi 0000:10:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:10:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:10:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:10:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:10:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:10:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:10:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:10:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:10:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:10:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:10:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:10:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:10:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:10:00.0: Start IWL Error Log Dump:
iwlwifi 0000:10:00.0: Status: 0x00000080, count: 6
iwlwifi 0000:10:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:10:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:10:00.0: 0x00A0A210 | trm_hw_status0
iwlwifi 0000:10:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:10:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:10:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:10:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:10:00.0: 0xFFB1FFC7 | data1
iwlwifi 0000:10:00.0: 0x6A000200 | data2
iwlwifi 0000:10:00.0: 0x040C0605 | data3
iwlwifi 0000:10:00.0: 0x00C0ED90 | beacon time
iwlwifi 0000:10:00.0: 0xF7C97272 | tsf low
iwlwifi 0000:10:00.0: 0x00000001 | tsf hi
iwlwifi 0000:10:00.0: 0x00000000 | time gp1
iwlwifi 0000:10:00.0: 0x00066C5B | time gp2
iwlwifi 0000:10:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:10:00.0: 0x00000030 | uCode version major
iwlwifi 0000:10:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:10:00.0: 0x00000340 | hw version
iwlwifi 0000:10:00.0: 0x00C89000 | board version
iwlwifi 0000:10:00.0: 0x801FFD06 | hcmd
iwlwifi 0000:10:00.0: 0xE68A9000 | isr0
iwlwifi 0000:10:00.0: 0x00440000 | isr1
iwlwifi 0000:10:00.0: 0x08F00002 | isr2
iwlwifi 0000:10:00.0: 0x00C1F00C | isr3
iwlwifi 0000:10:00.0: 0x00000000 | isr4
iwlwifi 0000:10:00.0: 0x02A2001C | last cmd Id
iwlwifi 0000:10:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:10:00.0: 0x000000D4 | l2p_control
iwlwifi 0000:10:00.0: 0x00010014 | l2p_duration
iwlwifi 0000:10:00.0: 0x00000007 | l2p_mhvalid
iwlwifi 0000:10:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:10:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:10:00.0: 0x00000000 | timestamp
iwlwifi 0000:10:00.0: 0x000068B8 | flow_handler
iwlwifi 0000:10:00.0: Start IWL Error Log Dump:
iwlwifi 0000:10:00.0: Status: 0x00000080, count: 7
iwlwifi 0000:10:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:10:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:10:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:10:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:10:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:10:00.0: 0x00000400 | umac data1
iwlwifi 0000:10:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:10:00.0: 0x00000000 | umac data3
iwlwifi 0000:10:00.0: 0x00000030 | umac major
iwlwifi 0000:10:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:10:00.0: 0x00066C6B | frame pointer
iwlwifi 0000:10:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:10:00.0: 0x0036010C | last host cmd
iwlwifi 0000:10:00.0: 0x00000000 | isr status reg
iwlwifi 0000:10:00.0: Fseq Registers:
iwlwifi 0000:10:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:10:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:10:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:10:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:10:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:10:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:10:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:10:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:10:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:10:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:10:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:10:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:08:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:08:00.0: Start IWL Error Log Dump:
iwlwifi 0000:08:00.0: Status: 0x00000080, count: 6
iwlwifi 0000:08:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:08:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:08:00.0: 0x00A0A210 | trm_hw_status0
iwlwifi 0000:08:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:08:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:08:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:08:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:08:00.0: 0xFFD5FFE2 | data1
iwlwifi 0000:08:00.0: 0x6A010201 | data2
iwlwifi 0000:08:00.0: 0x040C0605 | data3
iwlwifi 0000:08:00.0: 0x57007D73 | beacon time
iwlwifi 0000:08:00.0: 0x0CBF8256 | tsf low
iwlwifi 0000:08:00.0: 0x00000001 | tsf hi
iwlwifi 0000:08:00.0: 0x00000000 | time gp1
iwlwifi 0000:08:00.0: 0x1505FF93 | time gp2
iwlwifi 0000:08:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:08:00.0: 0x00000030 | uCode version major
iwlwifi 0000:08:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:08:00.0: 0x00000340 | hw version
iwlwifi 0000:08:00.0: 0x00C89000 | board version
iwlwifi 0000:08:00.0: 0x804CFD06 | hcmd
iwlwifi 0000:08:00.0: 0xE6821000 | isr0
iwlwifi 0000:08:00.0: 0x00440000 | isr1
iwlwifi 0000:08:00.0: 0x08F00102 | isr2
iwlwifi 0000:08:00.0: 0x04C19A5D | isr3
iwlwifi 0000:08:00.0: 0x00000000 | isr4
iwlwifi 0000:08:00.0: 0x03CA001C | last cmd Id
iwlwifi 0000:08:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:08:00.0: 0x00000000 | l2p_control
iwlwifi 0000:08:00.0: 0x00010014 | l2p_duration
iwlwifi 0000:08:00.0: 0x00000000 | l2p_mhvalid
iwlwifi 0000:08:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:08:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:08:00.0: 0x00000000 | timestamp
iwlwifi 0000:08:00.0: 0x00004090 | flow_handler
iwlwifi 0000:08:00.0: Start IWL Error Log Dump:
iwlwifi 0000:08:00.0: Status: 0x00000080, count: 7
iwlwifi 0000:08:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:08:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:08:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:08:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:08:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:08:00.0: 0x00000400 | umac data1
iwlwifi 0000:08:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:08:00.0: 0x00000000 | umac data3
iwlwifi 0000:08:00.0: 0x00000030 | umac major
iwlwifi 0000:08:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:08:00.0: 0x1505FFA3 | frame pointer
iwlwifi 0000:08:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:08:00.0: 0x00F0019C | last host cmd
iwlwifi 0000:08:00.0: 0x00000000 | isr status reg
iwlwifi 0000:08:00.0: Fseq Registers:
iwlwifi 0000:08:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:08:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:08:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:08:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:08:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:08:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:08:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:08:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:08:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:08:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:08:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:08:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:08:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:08:00.0: Start IWL Error Log Dump:
iwlwifi 0000:08:00.0: Status: 0x00000090, count: 6
iwlwifi 0000:08:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:08:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:08:00.0: 0x0000A2F0 | trm_hw_status0
iwlwifi 0000:08:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:08:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:08:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:08:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:08:00.0: 0xFFDCFFF0 | data1
iwlwifi 0000:08:00.0: 0x70000300 | data2
iwlwifi 0000:08:00.0: 0x010C0605 | data3
iwlwifi 0000:08:00.0: 0x00000000 | beacon time
iwlwifi 0000:08:00.0: 0x0001ABEA | tsf low
iwlwifi 0000:08:00.0: 0x00000000 | tsf hi
iwlwifi 0000:08:00.0: 0x00000000 | time gp1
iwlwifi 0000:08:00.0: 0x00020DDE | time gp2
iwlwifi 0000:08:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:08:00.0: 0x00000030 | uCode version major
iwlwifi 0000:08:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:08:00.0: 0x00000340 | hw version
iwlwifi 0000:08:00.0: 0x00C89000 | board version
iwlwifi 0000:08:00.0: 0x8011FD0C | hcmd
iwlwifi 0000:08:00.0: 0xE29A1000 | isr0
iwlwifi 0000:08:00.0: 0x00000000 | isr1
iwlwifi 0000:08:00.0: 0x08F80002 | isr2
iwlwifi 0000:08:00.0: 0x04C0001C | isr3
iwlwifi 0000:08:00.0: 0x00000000 | isr4
iwlwifi 0000:08:00.0: 0x00000000 | last cmd Id
iwlwifi 0000:08:00.0: 0x0001503E | wait_event
iwlwifi 0000:08:00.0: 0x00000000 | l2p_control
iwlwifi 0000:08:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:08:00.0: 0x00000000 | l2p_mhvalid
iwlwifi 0000:08:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:08:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:08:00.0: 0x00000000 | timestamp
iwlwifi 0000:08:00.0: 0x00000020 | flow_handler
iwlwifi 0000:08:00.0: Start IWL Error Log Dump:
iwlwifi 0000:08:00.0: Status: 0x00000090, count: 7
iwlwifi 0000:08:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:08:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:08:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:08:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:08:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:08:00.0: 0x00000400 | umac data1
iwlwifi 0000:08:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:08:00.0: 0x00000000 | umac data3
iwlwifi 0000:08:00.0: 0x00000030 | umac major
iwlwifi 0000:08:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:08:00.0: 0x00020DF0 | frame pointer
iwlwifi 0000:08:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:08:00.0: 0x00010C00 | last host cmd
iwlwifi 0000:08:00.0: 0x00000000 | isr status reg
iwlwifi 0000:08:00.0: Fseq Registers:
iwlwifi 0000:08:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:08:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:08:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:08:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:08:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:08:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:08:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:08:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:08:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:08:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:08:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:08:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:08:00.0: Firmware error during reconfiguration - reprobe!
iwlwifi 0000:08:00.0: Failed to start RT ucode: -5
iwlwifi 0000:08:00.0: Firmware not running - cannot dump error
wlan6: Failed check-sdata-in-driver check, flags: 0x0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
iwlwifi 0000:08:00.0: Failed to trigger RX queues sync (-5)
wlan6: Failed check-sdata-in-driver check, flags: 0x0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
iwlwifi 0000:08:00.0: iwl_trans_wait_txq_empty bad state = 0
wlan6: Failed check-sdata-in-driver check, flags: 0x0
iwlwifi 0000:08:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:08:00.0: Start IWL Error Log Dump:
iwlwifi 0000:08:00.0: Status: 0x00000080, count: 6
iwlwifi 0000:08:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:08:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:08:00.0: 0x0000A2F0 | trm_hw_status0
iwlwifi 0000:08:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:08:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:08:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:08:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:08:00.0: 0xFFE6FFF3 | data1
iwlwifi 0000:08:00.0: 0x70000201 | data2
iwlwifi 0000:08:00.0: 0x010C0605 | data3
iwlwifi 0000:08:00.0: 0x00000000 | beacon time
iwlwifi 0000:08:00.0: 0x0001A90F | tsf low
iwlwifi 0000:08:00.0: 0x00000000 | tsf hi
iwlwifi 0000:08:00.0: 0x00000000 | time gp1
iwlwifi 0000:08:00.0: 0x00020AD8 | time gp2
iwlwifi 0000:08:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:08:00.0: 0x00000030 | uCode version major
iwlwifi 0000:08:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:08:00.0: 0x00000340 | hw version
iwlwifi 0000:08:00.0: 0x18C89000 | board version
iwlwifi 0000:08:00.0: 0x8011FD0C | hcmd
iwlwifi 0000:08:00.0: 0xE69A9600 | isr0
iwlwifi 0000:08:00.0: 0x00000000 | isr1
iwlwifi 0000:08:00.0: 0x08F80002 | isr2
iwlwifi 0000:08:00.0: 0x04C0001C | isr3
iwlwifi 0000:08:00.0: 0x00000000 | isr4
iwlwifi 0000:08:00.0: 0x00000000 | last cmd Id
iwlwifi 0000:08:00.0: 0x0001503E | wait_event
iwlwifi 0000:08:00.0: 0x00000000 | l2p_control
iwlwifi 0000:08:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:08:00.0: 0x00000000 | l2p_mhvalid
iwlwifi 0000:08:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:08:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:08:00.0: 0x00000000 | timestamp
iwlwifi 0000:08:00.0: 0x00000020 | flow_handler
iwlwifi 0000:08:00.0: Start IWL Error Log Dump:
iwlwifi 0000:08:00.0: Status: 0x00000080, count: 7
iwlwifi 0000:08:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:08:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:08:00.0: 0xC008CC3C | umac branchlink2
iwlwifi 0000:08:00.0: 0x8048D0E6 | umac interruptlink1
iwlwifi 0000:08:00.0: 0x8048D0E6 | umac interruptlink2
iwlwifi 0000:08:00.0: 0x00000400 | umac data1
iwlwifi 0000:08:00.0: 0x8048D0E6 | umac data2
iwlwifi 0000:08:00.0: 0x00000000 | umac data3
iwlwifi 0000:08:00.0: 0x00000030 | umac major
iwlwifi 0000:08:00.0: 0x4FA0041F | umac minor
iwlwifi 0000:08:00.0: 0x00020AEA | frame pointer
iwlwifi 0000:08:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:08:00.0: 0x00010C00 | last host cmd
iwlwifi 0000:08:00.0: 0x00000000 | isr status reg
iwlwifi 0000:08:00.0: Fseq Registers:
iwlwifi 0000:08:00.0: 0xE0000000 | FSEQ_ERROR_CODE
iwlwifi 0000:08:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:08:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:08:00.0: 0x0000A503 | FSEQ_OTP_VERSION
iwlwifi 0000:08:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:08:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:08:00.0: 0x00100530 | FSEQ_CNVI_ID
iwlwifi 0000:08:00.0: 0x00000532 | FSEQ_CNVR_ID
iwlwifi 0000:08:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:08:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:08:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:08:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:08:00.0: Firmware not running - cannot dump error
iwlwifi 0000:08:00.0: Failed to run INIT ucode: -5

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


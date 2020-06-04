Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC31EE6C3
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 16:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgFDOii (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 10:38:38 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:35834 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgFDOii (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 10:38:38 -0400
Received: from [192.168.254.4] (unknown [50.34.197.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 86C0B13C2B0;
        Thu,  4 Jun 2020 07:38:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 86C0B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1591281516;
        bh=DxWdtq7I5qc9hmId2DIZiZ9rgy1A/3CZP+aebNFk+rg=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=qlQKYo0vI7J9Zw23pPogPtcdbavGCffII1r710AsWCys43GTZ+wy+TADjTom5hdAH
         mOlAOy7wIGLBucHyj2GYOO9sKqaBE9GB9c2bxdjQW52uALg9o5aMOGttKJi/ZXuVY7
         J4E4ZXvvCMXg/eZohS5ecqgRYBr01yHj59INt37w=
Subject: Re: ax200 very poor performance in stock 5.7.0 and 53.c3 firmware.
To:     Tim Higgins <tim@timhiggins.com>
References: <c2898228-836e-549b-85ee-8c2d24051912@candelatech.com>
 <3B9D5022-D95A-4CC3-B8A0-1104358F241E@timhiggins.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <8f1f9938-2fa6-38ca-b9e8-c792078ee3c1@candelatech.com>
Date:   Thu, 4 Jun 2020 07:38:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <3B9D5022-D95A-4CC3-B8A0-1104358F241E@timhiggins.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 06/04/2020 04:35 AM, Tim Higgins wrote:
>
>
>> On Jun 3, 2020, at 11:54 PM, Ben Greear <greearb@candelatech.com> wrote:
>>
>> I'm testing an un-modified kernel for a change, and latest firmware that I could find,
>> but ax200 is still sucking.
>>
>> UDP upload of single ax200 station gets about 1Mbps, and station disconnects
>> very often.  TCP download gets about 400Mbps on each of two radios.  UDP download stalls
>> often and averages around 1Mbps throughput.  TCP upload also stalls out.
>>
>> Previous testing on other kernels has shown problems with other firmware as well.
>>
>> I'm requesting 500Mbps UDP speeds.    Requesting only 100Mbps does not help (tested with DL direction only).
>>
>> [root@ct523c-0b29 ~]# ethtool -i wlan2
>> driver: iwlwifi
>> version: 5.7.0
>> firmware-version: 53.c31ac674.0 cc-a0-53.ucode
>> expansion-rom-version:
>> bus-info: 0000:12:00.0
>> supports-statistics: yes
>> supports-test: no
>> supports-eeprom-access: no
>> supports-register-dump: no
>> supports-priv-flags: no
>>
>>
>> Is there any way to disable OFDMA or /ax on the ax200 in case that helps somehow?
>>
>> Thanks,
>> Ben
> Hi Ben,
> Try running with no encryption. I know that is not a solution. But it could point to a cause. I've seen disabling encryption make a big difference.

I set to open auth (was using wpa3 PSK previously), and started TCP upload on two stations.  One is doing around 80Mbps, the other seems to have crashed the firmware
and will not recover.

Jun 04 07:31:53 ct523c-0b29 dhclient[11124]: bound to 192.168.50.201 -- renewal in 36927 seconds.
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Microcode SW error detected. Restarting 0x0.
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Start IWL Error Log Dump:
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Status: 0x00000040, count: 6
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Loaded firmware version: 53.c31ac674.0 cc-a0-53.ucode
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00003800 | ADVANCED_SYSASSERT
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x0580A202 | trm_hw_status0
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | trm_hw_status1
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x004F9A5E | branchlink2
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000E16 | interruptlink1
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000E16 | interruptlink2
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xDEADBEEF | data1
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xDEADBEEF | data2
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xDEADBEEF | data3
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x34004196 | beacon time
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x05555E6D | tsf low
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | tsf hi
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | time gp1
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00FF983D | time gp2
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000001 | uCode revision type
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000035 | uCode version major
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xC31AC674 | uCode version minor
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000340 | hw version
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x18C89000 | board version
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x8032FC20 | hcmd
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xE686BE10 | isr0
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x01448000 | isr1
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x08F00102 | isr2
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00C00008 | isr3
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | isr4
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x0339001C | last cmd Id
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x0000C848 | wait_event
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000288 | l2p_control
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00498034 | l2p_duration
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | l2p_mhvalid
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x000000E7 | l2p_addr_match
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000009 | lmpm_pmg_sel
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | timestamp
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x000008F4 | flow_handler
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Start IWL Error Log Dump:
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Status: 0x00000040, count: 7
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | umac branchlink1
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x80467420 | umac branchlink2
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x80483454 | umac interruptlink1
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x80483454 | umac interruptlink2
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000400 | umac data1
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x80483454 | umac data2
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | umac data3
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000035 | umac major
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xC31AC674 | umac minor
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00FF9853 | frame pointer
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xC088626C | stack pointer
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00E1010C | last host cmd
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | isr status reg
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Fseq Registers:
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x60000000 | FSEQ_ERROR_CODE
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x80290011 | FSEQ_TOP_INIT_VERSION
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00050008 | FSEQ_CNVIO_INIT_VERSION
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x0000A503 | FSEQ_OTP_VERSION
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00100530 | FSEQ_CNVI_ID
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000532 | FSEQ_CNVR_ID
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
Jun 04 07:32:08 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: WRT: Collecting data: ini trigger 4 fired.
Jun 04 07:32:08 ct523c-0b29 kernel: ieee80211 wiphy3: Hardware restart was requested
Jun 04 07:32:09 ct523c-0b29 kernel: alloc_contig_range: [265ed0, 265ed8) PFNs busy
Jun 04 07:32:09 ct523c-0b29 kernel: alloc_contig_range: [265ed0, 265ed8) PFNs busy
Jun 04 07:32:09 ct523c-0b29 kernel: alloc_contig_range: [265ed0, 265ed8) PFNs busy
Jun 04 07:32:09 ct523c-0b29 kernel: alloc_contig_range: [265ed0, 265ed8) PFNs busy
Jun 04 07:32:09 ct523c-0b29 kernel: alloc_contig_range: [265ed0, 265ed8) PFNs busy
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Got NSS = 4 - trimming to 2
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Got NSS = 4 - trimming to 2
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Microcode SW error detected. Restarting 0x0.
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Start IWL Error Log Dump:
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Status: 0x00000050, count: 6
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Loaded firmware version: 53.c31ac674.0 cc-a0-53.ucode
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x0000A210 | trm_hw_status0
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | trm_hw_status1
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x004F9A5E | branchlink2
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x004E81C4 | interruptlink1
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x004E81C4 | interruptlink2
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00014462 | data1
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00001000 | data2
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | data3
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00002DDD | beacon time
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x045B7275 | tsf low
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | tsf hi
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | time gp1
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00028BE3 | time gp2
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000001 | uCode revision type
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000035 | uCode version major
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xC31AC674 | uCode version minor
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000340 | hw version
Jun 04 07:32:09 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x18C89000 | board version
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x8046001C | hcmd
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xA6020000 | isr0
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | isr1
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x38F00002 | isr2
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00C00009 | isr3
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | isr4
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x002A019C | last cmd Id
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00014462 | wait_event
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000094 | l2p_control
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00010034 | l2p_duration
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x0000000F | l2p_mhvalid
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | l2p_addr_match
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000009 | lmpm_pmg_sel
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | timestamp
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00002874 | flow_handler
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Start IWL Error Log Dump:
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Status: 0x00000050, count: 7
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x2010104C | ADVANCED_SYSASSERT
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | umac branchlink1
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x80467420 | umac branchlink2
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xC0086AC2 | umac interruptlink1
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | umac interruptlink2
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | umac data1
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | umac data2
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xDEADBEEF | umac data3
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000035 | umac major
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xC31AC674 | umac minor
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00028BD6 | frame pointer
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0xC0887F28 | stack pointer
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000000 | last host cmd
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00020040 | isr status reg
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Fseq Registers:
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x60000000 | FSEQ_ERROR_CODE
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x80290011 | FSEQ_TOP_INIT_VERSION
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00050008 | FSEQ_CNVIO_INIT_VERSION
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x0000A503 | FSEQ_OTP_VERSION
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00100530 | FSEQ_CNVI_ID
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000532 | FSEQ_CNVR_ID
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Firmware error during reconfiguration - reprobe!
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: LED command failed: -5
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: LED command failed: -5
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: FW error in SYNC CMD BCAST_FILTER_CMD
Jun 04 07:32:10 ct523c-0b29 kernel: CPU: 2 PID: 23014 Comm: kworker/2:1 Not tainted 5.7.0 #37
Jun 04 07:32:10 ct523c-0b29 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/19/2019
Jun 04 07:32:10 ct523c-0b29 kernel: Workqueue: events_freezable ieee80211_restart_work [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel: Call Trace:
Jun 04 07:32:10 ct523c-0b29 kernel:  dump_stack+0x8f/0xd0
Jun 04 07:32:10 ct523c-0b29 kernel:  iwl_trans_pcie_gen2_send_hcmd+0x3b2/0x3c0 [iwlwifi]
Jun 04 07:32:10 ct523c-0b29 kernel:  ? wait_woken+0xa0/0xa0
Jun 04 07:32:10 ct523c-0b29 kernel:  iwl_trans_send_cmd+0x75/0x140 [iwlwifi]
Jun 04 07:32:10 ct523c-0b29 kernel:  iwl_mvm_send_cmd+0x23/0x70 [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel:  iwl_mvm_send_cmd_pdu+0x4c/0x70 [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel:  iwl_mvm_configure_bcast_filter.part.35+0x45/0x70 [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel:  ? bpf_prog_test_run_xdp+0x5/0x190
Jun 04 07:32:10 ct523c-0b29 kernel:  iwl_mvm_bss_info_changed+0x207/0x750 [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel:  ieee80211_bss_info_change_notify+0xc8/0x2c0 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  ieee80211_reconfig+0x7c8/0x1cb0 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  ieee80211_restart_work+0xb6/0xe0 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  process_one_work+0x2a8/0x610
Jun 04 07:32:10 ct523c-0b29 kernel:  worker_thread+0x34/0x3d0
Jun 04 07:32:10 ct523c-0b29 kernel:  ? process_one_work+0x610/0x610
Jun 04 07:32:10 ct523c-0b29 kernel:  kthread+0x12e/0x150
Jun 04 07:32:10 ct523c-0b29 kernel:  ? kthread_park+0x80/0x80
Jun 04 07:32:10 ct523c-0b29 kernel:  ret_from_fork+0x24/0x30
Jun 04 07:32:10 ct523c-0b29 kernel: ------------[ cut here ]------------
Jun 04 07:32:10 ct523c-0b29 kernel: WARNING: CPU: 2 PID: 23014 at drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:2419 iwl_mvm_bss_info_changed+0x6c3/0x750 [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel: Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 bpfilter vrf 8021q garp mrp stp llc macvlan pktgen f71882fg sunrpc snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg ath10k_pci snd_hda_codec snd_hda_core ath10k_core iwlmvm snd_hwdep ath coretemp snd_seq intel_rapl_msr snd_seq_device intel_rapl_common mac80211 snd_pcm iTCO_wdt iTCO_vendor_support iwlwifi snd_timer snd i2c_i801 intel_wmi_thunderbolt x86_pkg_temp_thermal cfg80211 soundcore intel_powerclamp mei_hdcp intel_pch_thermal mei_wdt acpi_pad sch_fq_codel raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 intel_gtt drm_kms_helper ixgbe igb mdio cec rc_core i2c_algo_bit hwmon dca drm agpgart i2c_core wmi video fuse [last unloaded: nf_conntrack]
Jun 04 07:32:10 ct523c-0b29 kernel: CPU: 2 PID: 23014 Comm: kworker/2:1 Not tainted 5.7.0 #37
Jun 04 07:32:10 ct523c-0b29 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/19/2019
Jun 04 07:32:10 ct523c-0b29 kernel: Workqueue: events_freezable ieee80211_restart_work [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel: RIP: 0010:iwl_mvm_bss_info_changed+0x6c3/0x750 [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel: Code: ff e9 be fe ff ff 48 8b 04 24 48 89 ee 4c 89 ef 0f b6 50 0c e8 7e 61 01 00 85 c0 75 5d 48 8b 04 24 c6 40 0c ff e9 86 fe ff ff <0f> 0b e9 b7 fb ff ff 49 8b 7c 24 08 48 c7 c1 d1 b5 82 a0 31 d2 31
Jun 04 07:32:10 ct523c-0b29 kernel: RSP: 0018:ffffc9000cdefd60 EFLAGS: 00010282
Jun 04 07:32:10 ct523c-0b29 kernel: RAX: 00000000fffffffb RBX: 00000000029674ff RCX: 0000000000000000
Jun 04 07:32:10 ct523c-0b29 kernel: RDX: 0000000000000000 RSI: ffffc9000cdefcb0 RDI: ffff888250ebc028
Jun 04 07:32:10 ct523c-0b29 kernel: RBP: ffff88824051ddc0 R08: ffffc9000cdefd14 R09: ffff888259feb148
Jun 04 07:32:10 ct523c-0b29 kernel: R10: 000000000000003c R11: 0000000000000000 R12: ffff888259feb140
Jun 04 07:32:10 ct523c-0b29 kernel: R13: ffff888259feb148 R14: ffff888259feb178 R15: ffff88824051ddc8
Jun 04 07:32:10 ct523c-0b29 kernel: FS:  0000000000000000(0000) GS:ffff88826dc80000(0000) knlGS:0000000000000000
Jun 04 07:32:10 ct523c-0b29 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 04 07:32:10 ct523c-0b29 kernel: CR2: 00007f29f0006008 CR3: 0000000002810002 CR4: 00000000003606e0
Jun 04 07:32:10 ct523c-0b29 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 04 07:32:10 ct523c-0b29 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jun 04 07:32:10 ct523c-0b29 kernel: Call Trace:
Jun 04 07:32:10 ct523c-0b29 kernel:  ieee80211_bss_info_change_notify+0xc8/0x2c0 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  ieee80211_reconfig+0x7c8/0x1cb0 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  ieee80211_restart_work+0xb6/0xe0 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  process_one_work+0x2a8/0x610
Jun 04 07:32:10 ct523c-0b29 kernel:  worker_thread+0x34/0x3d0
Jun 04 07:32:10 ct523c-0b29 kernel:  ? process_one_work+0x610/0x610
Jun 04 07:32:10 ct523c-0b29 kernel:  kthread+0x12e/0x150
Jun 04 07:32:10 ct523c-0b29 kernel:  ? kthread_park+0x80/0x80
Jun 04 07:32:10 ct523c-0b29 kernel:  ret_from_fork+0x24/0x30
Jun 04 07:32:10 ct523c-0b29 kernel: irq event stamp: 0
Jun 04 07:32:10 ct523c-0b29 kernel: hardirqs last  enabled at (0): [<0000000000000000>] 0x0
Jun 04 07:32:10 ct523c-0b29 kernel: hardirqs last disabled at (0): [<ffffffff8114fdc9>] copy_process+0x899/0x1bd0
Jun 04 07:32:10 ct523c-0b29 kernel: softirqs last  enabled at (0): [<ffffffff8114fdc9>] copy_process+0x899/0x1bd0
Jun 04 07:32:10 ct523c-0b29 kernel: softirqs last disabled at (0): [<0000000000000000>] 0x0
Jun 04 07:32:10 ct523c-0b29 kernel: ---[ end trace 03411fdff35a6b25 ]---
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: failed to update power mode
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: failed to update CQM thresholds
Jun 04 07:32:10 ct523c-0b29 kernel: wlan3: HW problem - can not stop rx aggregation for 0c:9d:92:02:42:e4 tid 0
Jun 04 07:32:10 ct523c-0b29 kernel: wlan3: HW problem - can not stop rx aggregation for 0c:9d:92:02:42:e4 tid 6
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Failed to send recovery cmd -5
Jun 04 07:32:10 ct523c-0b29 kernel: wlan3: deauthenticating from 0c:9d:92:02:42:e4 by local choice (Reason: 3=DEAUTH_LEAVING)
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Failed to send flush command (-5)
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: flush request fail
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Failed to trigger RX queues sync (-5)
Jun 04 07:32:10 ct523c-0b29 kernel: iwlwifi 0000:14:00.0: Failed to send MAC context (action:2): -5
Jun 04 07:32:10 ct523c-0b29 kernel: ------------[ cut here ]------------
Jun 04 07:32:10 ct523c-0b29 kernel: WARNING: CPU: 2 PID: 30687 at drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:3180 iwl_mvm_mac_sta_state+0x48d/0x710 [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel: Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 bpfilter vrf 8021q garp mrp stp llc macvlan pktgen f71882fg sunrpc snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg ath10k_pci snd_hda_codec snd_hda_core ath10k_core iwlmvm snd_hwdep ath coretemp snd_seq intel_rapl_msr snd_seq_device intel_rapl_common mac80211 snd_pcm iTCO_wdt iTCO_vendor_support iwlwifi snd_timer snd i2c_i801 intel_wmi_thunderbolt x86_pkg_temp_thermal cfg80211 soundcore intel_powerclamp mei_hdcp intel_pch_thermal mei_wdt acpi_pad sch_fq_codel raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 intel_gtt drm_kms_helper ixgbe igb mdio cec rc_core i2c_algo_bit hwmon dca drm agpgart i2c_core wmi video fuse [last unloaded: nf_conntrack]
Jun 04 07:32:10 ct523c-0b29 kernel: CPU: 2 PID: 30687 Comm: kworker/2:2 Tainted: G        W         5.7.0 #37
Jun 04 07:32:10 ct523c-0b29 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/19/2019
Jun 04 07:32:10 ct523c-0b29 kernel: Workqueue: events iwl_mvm_reprobe_wk [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel: RIP: 0010:iwl_mvm_mac_sta_state+0x48d/0x710 [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel: Code: df e8 47 74 00 00 31 d2 48 89 ee 48 89 df e8 5a 96 02 00 85 c0 0f 84 bd fe ff ff 49 8b 86 b0 01 00 00 a8 08 0f 85 ae fe ff ff <0f> 0b 48 8b 3c 24 e8 b8 72 42 e1 e9 a7 fe ff ff 84 d2 74 09 40 84
Jun 04 07:32:10 ct523c-0b29 kernel: RSP: 0018:ffffc90005187830 EFLAGS: 00010246
Jun 04 07:32:10 ct523c-0b29 kernel: RAX: 0000000000000040 RBX: ffff888259feb148 RCX: 0000000000000040
Jun 04 07:32:10 ct523c-0b29 kernel: RDX: 0000000000000000 RSI: ffffc90005187780 RDI: ffff888250ebc028
Jun 04 07:32:10 ct523c-0b29 kernel: RBP: ffff88824051ddc0 R08: ffffc900051877dc R09: ffff888259feb148
Jun 04 07:32:10 ct523c-0b29 kernel: R10: 000000000000003c R11: 0000000000000000 R12: ffff88824051df50
Jun 04 07:32:10 ct523c-0b29 kernel: R13: 0000000000000003 R14: ffff888259feb140 R15: 0000000000000004
Jun 04 07:32:10 ct523c-0b29 kernel: FS:  0000000000000000(0000) GS:ffff88826dc80000(0000) knlGS:0000000000000000
Jun 04 07:32:10 ct523c-0b29 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun 04 07:32:10 ct523c-0b29 kernel: CR2: 00007f29f0006008 CR3: 0000000254864001 CR4: 00000000003606e0
Jun 04 07:32:10 ct523c-0b29 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jun 04 07:32:10 ct523c-0b29 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Jun 04 07:32:10 ct523c-0b29 kernel: Call Trace:
Jun 04 07:32:10 ct523c-0b29 kernel:  ? __sdata_dbg+0x117/0x170 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  drv_sta_state+0xa5/0x7a0 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  sta_info_move_state+0x244/0x370 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  __sta_info_destroy_part2+0x40/0x1b0 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  __sta_info_flush+0x130/0x180 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  ieee80211_set_disassoc+0xc6/0x470 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  ieee80211_mgd_deauth+0xf0/0x4a0 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  cfg80211_mlme_deauth+0xd7/0x340 [cfg80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  cfg80211_mlme_down+0x7c/0xc0 [cfg80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  cfg80211_disconnect+0x1c2/0x330 [cfg80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  cfg80211_leave+0x26/0x40 [cfg80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  cfg80211_netdev_notifier_call+0x317/0x660 [cfg80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  ? lock_acquire+0xad/0x3a0
Jun 04 07:32:10 ct523c-0b29 kernel:  ? packet_getname_spkt+0x130/0x130
Jun 04 07:32:10 ct523c-0b29 kernel:  ? packet_notifier+0x196/0x2f0
Jun 04 07:32:10 ct523c-0b29 kernel:  notifier_call_chain+0x40/0x60
Jun 04 07:32:10 ct523c-0b29 kernel:  __dev_close_many+0x68/0x110
Jun 04 07:32:10 ct523c-0b29 kernel:  dev_close_many+0x77/0x120
Jun 04 07:32:10 ct523c-0b29 kernel:  dev_close.part.106+0x39/0x70
Jun 04 07:32:10 ct523c-0b29 kernel:  cfg80211_shutdown_all_interfaces+0x68/0xc0 [cfg80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  ieee80211_remove_interfaces+0x55/0x1f0 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  ieee80211_unregister_hw+0x41/0x110 [mac80211]
Jun 04 07:32:10 ct523c-0b29 kernel:  iwl_op_mode_mvm_stop+0x24/0x140 [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel:  iwl_drv_stop+0x40/0x1a0 [iwlwifi]
Jun 04 07:32:10 ct523c-0b29 kernel:  iwl_pci_remove+0x11/0x20 [iwlwifi]
Jun 04 07:32:10 ct523c-0b29 kernel:  pci_device_remove+0x31/0xb0
Jun 04 07:32:10 ct523c-0b29 kernel:  device_release_driver_internal+0xdd/0x1c0
Jun 04 07:32:10 ct523c-0b29 kernel:  device_reprobe+0x10/0x20
Jun 04 07:32:10 ct523c-0b29 kernel:  iwl_mvm_reprobe_wk+0x12/0x30 [iwlmvm]
Jun 04 07:32:10 ct523c-0b29 kernel:  process_one_work+0x2a8/0x610
Jun 04 07:32:10 ct523c-0b29 kernel:  worker_thread+0x34/0x3d0
Jun 04 07:32:10 ct523c-0b29 kernel:  ? process_one_work+0x610/0x610
Jun 04 07:32:10 ct523c-0b29 kernel:  kthread+0x12e/0x150
Jun 04 07:32:10 ct523c-0b29 kernel:  ? kthread_park+0x80/0x80
Jun 04 07:32:10 ct523c-0b29 kernel:  ret_from_fork+0x24/0x30
Jun 04 07:32:10 ct523c-0b29 kernel: irq event stamp: 0
Jun 04 07:32:10 ct523c-0b29 kernel: hardirqs last  enabled at (0): [<0000000000000000>] 0x0
Jun 04 07:32:10 ct523c-0b29 kernel: hardirqs last disabled at (0): [<ffffffff8114fdc9>] copy_process+0x899/0x1bd0
Jun 04 07:32:10 ct523c-0b29 kernel: softirqs last  enabled at (0): [<ffffffff8114fdc9>] copy_process+0x899/0x1bd0
Jun 04 07:32:10 ct523c-0b29 kernel: softirqs last disabled at (0): [<0000000000000000>] 0x0
Jun 04 07:32:10 ct523c-0b29 kernel: ---[ end trace 03411fdff35a6b26 ]---

....

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

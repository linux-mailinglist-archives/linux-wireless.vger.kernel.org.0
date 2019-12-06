Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E24911587B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 22:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLFVSN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 16:18:13 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:56270 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfLFVSM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 16:18:12 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 19041137532
        for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2019 13:18:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 19041137532
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1575667092;
        bh=gMOZPeN80hs/v1CjqGdhgLk1Ar18YzhNLxC4fTu1EN4=;
        h=To:From:Subject:Date:From;
        b=kM7tO9DZNzIDKLOyC4r+nHq/FvD10O/wF8aXh2BcOx0TPCOV2vXs/OYadPpoJgDox
         zM707nokwSvHfKpWKaiH4PBhjBkb4rJHqdQOGvkzGbq44Bc9awf03YsmjNJCBQyAWA
         vGujtuwcoO7ZCZlj6ZWtJLr8RCoCb5aGDQQuNkTE=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax200 firmware crash on 5.2.21+ kernel
Organization: Candela Technologies
Message-ID: <c659f79f-afe4-c2bc-405f-34eb09ff0790@candelatech.com>
Date:   Fri, 6 Dec 2019 13:18:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Is this a known crash signature?

Our kernel is 5.2.21+, and has the upload-crashes-the-firmware fix applied.

Test was UDP bi-directional 30Mbps for both radios in APU2.

iwlwifi 0000:05:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000080, count: 6
iwlwifi 0000:05:00.0: Loaded firmware version: 48.4fa0041f.0
iwlwifi 0000:05:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:05:00.0: 0x000022F0 | trm_hw_status0
iwlwifi 0000:05:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:05:00.0: 0x004F8E3C | branchlink2
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink1
iwlwifi 0000:05:00.0: 0x00000E26 | interruptlink2
iwlwifi 0000:05:00.0: 0x0002FFF5 | data1
iwlwifi 0000:05:00.0: 0x64000001 | data2
iwlwifi 0000:05:00.0: 0x040C0606 | data3
iwlwifi 0000:05:00.0: 0xA78102B5 | beacon time
iwlwifi 0000:05:00.0: 0x9AD90315 | tsf low
iwlwifi 0000:05:00.0: 0x00000000 | tsf hi
iwlwifi 0000:05:00.0: 0x00000000 | time gp1
iwlwifi 0000:05:00.0: 0x1D7FA305 | time gp2
iwlwifi 0000:05:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:05:00.0: 0x00000030 | uCode version major
iwlwifi 0000:05:00.0: 0x4FA0041F | uCode version minor
iwlwifi 0000:05:00.0: 0x00000340 | hw version
iwlwifi 0000:05:00.0: 0x00C89000 | board version
iwlwifi 0000:05:00.0: 0x800BFD06 | hcmd
iwlwifi 0000:05:00.0: 0x82021000 | isr0
iwlwifi 0000:05:00.0: 0x00444000 | isr1
iwlwifi 0000:05:00.0: 0x08F80102 | isr2
iwlwifi 0000:05:00.0: 0x04C1EBCD | isr3
iwlwifi 0000:05:00.0: 0x00000000 | isr4
iwlwifi 0000:05:00.0: 0x0021019C | last cmd Id
iwlwifi 0000:05:00.0: 0x004EB8B4 | wait_event
iwlwifi 0000:05:00.0: 0x00000000 | l2p_control
iwlwifi 0000:05:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:05:00.0: 0x000000BF | l2p_mhvalid
iwlwifi 0000:05:00.0: 0x00000000 | l2p_addr_match
iwlwifi 0000:05:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:05:00.0: 0x00000000 | timestamp
iwlwifi 0000:05:00.0: 0x00009860 | flow_handler
iwlwifi 0000:05:00.0: Start IWL Error Log Dump:
iwlwifi 0000:05:00.0: Status: 0x00000080, count: 7
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
iwlwifi 0000:05:00.0: 0x1D7FA314 | frame pointer
iwlwifi 0000:05:00.0: 0xC0886284 | stack pointer
iwlwifi 0000:05:00.0: 0x0021019C | last host cmd
iwlwifi 0000:05:00.0: 0x00000000 | isr status reg
iwlwifi 0000:05:00.0: Fseq Registers:
iwlwifi 0000:05:00.0: 0xE0000101 | FSEQ_ERROR_CODE
iwlwifi 0000:05:00.0: 0x00290008 | FSEQ_TOP_INIT_VERSION
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

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


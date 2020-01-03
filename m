Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E312FE68
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2020 22:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgACVkb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jan 2020 16:40:31 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:41342 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgACVkb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jan 2020 16:40:31 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id DE8DC13C340
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2020 13:40:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DE8DC13C340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1578087629;
        bh=SUSR+3QeOT7Ok6XS8sPwQAvGD+QBLLpA2BGpfKgfW48=;
        h=To:From:Subject:Date:From;
        b=a3zHd1dlGTZmCt8ZEcnN4IRjw2F3p19R34RDvf2+QEoD/dMvETsAfCTsHOuj9B1BH
         MVApiZ5tBP6HFrm9XFp/2cDKPk6PJBLmaD7ItDgAP3kG1+9R/WxWIEM20S4Ypx8k+S
         dH+S9rBXN7rIp3hwOd7REulegr9DU6ZW2JbHyw4A=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax200 crash, status 0x00000080
Organization: Candela Technologies
Message-ID: <d0336d37-ccb9-f7c9-b9f6-71dfcfa34bc5@candelatech.com>
Date:   Fri, 3 Jan 2020 13:40:29 -0800
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

NOTE:  This same info is in bugzilla:  https://bugzilla.kernel.org/show_bug.cgi?id=206067

Our test team reported this problem.  The hardware is Intel x86-64 with pcie to mini-pcie to m.2 adapter boards and 8 total AX200 radios in one system.

Notes on the AX crashes:

- When the crash happens, the station does not seem to make a full recovery. There are many duplicate rx packets on the UDP download side. The upload direction 
is normal with no duplicate packets.

- Traffic is fixed after resetting the station.

- Sometimes traffic just stops completely for both sides and cannot resume until resetting the station.

- I've found a way to reproduce a crash fairly reliably.

- To reproduce the crash, I ran UDP upload traffic at 100 Mbps on one radio (wiphy1). Then I brought up a second station on another radio (wiphy0). The station 
on wiphy0 will then crash as it comes up. If there is no traffic flowing on the wiphy1 radio, or if it is only doing 30Mbps upload, the station doesn't crash.

- Traffic is over the air and not encrypted. I'm using our LANforge virtual AP on channel 36.

- I was also able to get a crash with an Asus AX6000 AP. My earlier method of reproducing the crash did not work. Basically I got it to crash running 160 Mbps 
UDP upload on one AX station then resetting 7 other stations (each on their own AX radio).

Representative firmware crash log:

Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: Microcode SW error detected. Restarting 0x0.
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: Start IWL Error Log Dump:
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: Status: 0x00000080, count: 6
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: Loaded firmware version: 48.4fa0041f.0
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000942 | ADVANCED_SYSASSERT
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00A0A2F0 | trm_hw_status0
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000000 | trm_hw_status1
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x004F8E3C | branchlink2
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000E26 | interruptlink1
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000E26 | interruptlink2
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0xFFEFFFFC | data1
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x26010101 | data2
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x040C0605 | data3
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0xBB01867B | beacon time
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x92BDF98E | tsf low
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x0000000F | tsf hi
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000000 | time gp1
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x0AF4D781 | time gp2
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000001 | uCode revision type
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000030 | uCode version major
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x4FA0041F | uCode version minor
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000340 | hw version
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00C89000 | board version
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x807BFD06 | hcmd
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0xE7821000 | isr0
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00040000 | isr1
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x08F00002 | isr2
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00C1871D | isr3
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000000 | isr4
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x0016019C | last cmd Id
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x004EB8B4 | wait_event
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000000 | l2p_control
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000000 | l2p_duration
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x000000BF | l2p_mhvalid
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x0000000E | l2p_addr_match
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000009 | lmpm_pmg_sel
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000000 | timestamp
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x0000B0D0 | flow_handler
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: Start IWL Error Log Dump:
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: Status: 0x00000080, count: 7
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000000 | umac branchlink1
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0xC008CC3C | umac branchlink2
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x8048D0E6 | umac interruptlink1
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x8048D0E6 | umac interruptlink2
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000400 | umac data1
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x8048D0E6 | umac data2
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000000 | umac data3
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000030 | umac major
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x4FA0041F | umac minor
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x0AF4D791 | frame pointer
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0xC0886284 | stack pointer
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x0017010C | last host cmd
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000000 | isr status reg
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: Fseq Registers:
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0xE0000000 | FSEQ_ERROR_CODE
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x80290001 | FSEQ_TOP_INIT_VERSION
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x80050008 | FSEQ_CNVIO_INIT_VERSION
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x0000A503 | FSEQ_OTP_VERSION
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00100530 | FSEQ_CNVI_ID
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000532 | FSEQ_CNVR_ID
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
Jan  3 05:38:55 localhost kernel: iwlwifi 0000:0e:00.0: Collecting data: trigger 2 fired.
Jan  3 05:38:55 localhost kernel: ieee80211 wiphy5: Hardware restart was requested

We also have binary crash files available, but they are too big to attach to bugzilla.  Let me know if there is someplace helpful that I can send them.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


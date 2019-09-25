Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20C6BE5C3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 21:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392369AbfIYTgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 15:36:44 -0400
Received: from smtp107.ord1c.emailsrvr.com ([108.166.43.107]:58515 "EHLO
        smtp107.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392351AbfIYTgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 15:36:44 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Sep 2019 15:36:43 EDT
X-Auth-ID: robert.carter@octoscope.com
Received: by smtp14.relay.ord1c.emailsrvr.com (Authenticated sender: robert.carter-AT-octoscope.com) with ESMTPSA id 574F5C0223
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2019 15:27:35 -0400 (EDT)
X-Sender-Id: robert.carter@octoscope.com
Received: from [10.100.100.91] (static-98-118-126-237.bstnma.fios.verizon.net [98.118.126.237])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 25 Sep 2019 15:27:35 -0400
To:     linux-wireless@vger.kernel.org
From:   Robert Carter <robert.carter@octoscope.com>
Subject:  Intel AX200 driver crash on 5.2.8 kernel
Message-ID: <fde66eaf-a0c9-6206-c718-475e4168fe3d@octoscope.com>
Date:   Wed, 25 Sep 2019 15:27:35 -0400
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

I'm running an AX200 on a AAEON PICO-APL4 running the 5.2.8 kernel. In 
running multiple, upstream UDP tests (towards the AP), the 
iwlwifi-cc-a0-48.ucode driver is crashing. See below. It's happily 
rolling over! I've pulled this driver from the 
linux-firmware-20190815.tar.gz archive.

Below is a representative crash dump from syslog.

I'm not on this mailing list; contact me if any information is needed. I 
_may_ be able to test a new AX200 firmware load.

Bob Carter

-----------

octoscope@octo-pico-4:~$ sudo cat /var/log/syslog | grep -Ea "Microcode 
SW error detected. Restarting" | wc
      24     360    2832

-----------

Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179271] iwlwifi 0000:03:00.0: 
Microcode SW error detected. Restarting 0x0.
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179399] iwlwifi 0000:03:00.0: 
Start IWL Error Log Dump:
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179405] iwlwifi 0000:03:00.0: 
Status: 0x00000080, count: 6
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179411] iwlwifi 0000:03:00.0: 
Loaded firmware version: 48.4fa0041f.0
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179417] iwlwifi 0000:03:00.0: 
0x00000EDC | ADVANCED_SYSASSERT
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179423] iwlwifi 0000:03:00.0: 
0x0080AE11 | trm_hw_status0
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179428] iwlwifi 0000:03:00.0: 
0x00000000 | trm_hw_status1
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179433] iwlwifi 0000:03:00.0: 
0x004F8E3C | branchlink2
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179438] iwlwifi 0000:03:00.0: 
0x00000E26 | interruptlink1
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179443] iwlwifi 0000:03:00.0: 
0x00000E26 | interruptlink2
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179448] iwlwifi 0000:03:00.0: 
0x8D69BE05 | data1
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179453] iwlwifi 0000:03:00.0: 
0x62481231 | data2
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179458] iwlwifi 0000:03:00.0: 
0x00002730 | data3
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179463] iwlwifi 0000:03:00.0: 
0xA141234E | beacon time
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179468] iwlwifi 0000:03:00.0: 
0x697D1CC5 | tsf low
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179473] iwlwifi 0000:03:00.0: 
0x00000000 | tsf hi
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179477] iwlwifi 0000:03:00.0: 
0x00000000 | time gp1
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179482] iwlwifi 0000:03:00.0: 
0x073015E3 | time gp2
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179487] iwlwifi 0000:03:00.0: 
0x00000001 | uCode revision type
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179493] iwlwifi 0000:03:00.0: 
0x00000030 | uCode version major
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179498] iwlwifi 0000:03:00.0: 
0x4FA0041F | uCode version minor
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179503] iwlwifi 0000:03:00.0: 
0x00000340 | hw version
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179508] iwlwifi 0000:03:00.0: 
0x00C89000 | board version
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179513] iwlwifi 0000:03:00.0: 
0x62481231 | hcmd
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179518] iwlwifi 0000:03:00.0: 
0xE6F21010 | isr0
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179522] iwlwifi 0000:03:00.0: 
0x01448000 | isr1
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179527] iwlwifi 0000:03:00.0: 
0x08F00002 | isr2
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179532] iwlwifi 0000:03:00.0: 
0x00C1D508 | isr3
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179536] iwlwifi 0000:03:00.0: 
0x00000000 | isr4
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179541] iwlwifi 0000:03:00.0: 
0x05AB001C | last cmd Id
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179546] iwlwifi 0000:03:00.0: 
0x0000DB06 | wait_event
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179551] iwlwifi 0000:03:00.0: 
0x00000024 | l2p_control
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179556] iwlwifi 0000:03:00.0: 
0x00014C14 | l2p_duration
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179561] iwlwifi 0000:03:00.0: 
0x0000000F | l2p_mhvalid
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179566] iwlwifi 0000:03:00.0: 
0x000000C6 | l2p_addr_match
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179571] iwlwifi 0000:03:00.0: 
0x00000009 | lmpm_pmg_sel
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179576] iwlwifi 0000:03:00.0: 
0x00000000 | timestamp
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179581] iwlwifi 0000:03:00.0: 
0x00000000 | flow_handler
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179616] iwlwifi 0000:03:00.0: 
Start IWL Error Log Dump:
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179621] iwlwifi 0000:03:00.0: 
Status: 0x00000080, count: 7
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179627] iwlwifi 0000:03:00.0: 
0x20000070 | NMI_INTERRUPT_LMAC_FATAL
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179632] iwlwifi 0000:03:00.0: 
0x00000000 | umac branchlink1
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179637] iwlwifi 0000:03:00.0: 
0xC008CC3C | umac branchlink2
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179642] iwlwifi 0000:03:00.0: 
0x8048D0E6 | umac interruptlink1
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179647] iwlwifi 0000:03:00.0: 
0x8048D0E6 | umac interruptlink2
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179652] iwlwifi 0000:03:00.0: 
0x00000400 | umac data1
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179657] iwlwifi 0000:03:00.0: 
0x8048D0E6 | umac data2
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179664] iwlwifi 0000:03:00.0: 
0x00000000 | umac data3
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179669] iwlwifi 0000:03:00.0: 
0x00000030 | umac major
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179674] iwlwifi 0000:03:00.0: 
0x4FA0041F | umac minor
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179679] iwlwifi 0000:03:00.0: 
0x073015F2 | frame pointer
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179684] iwlwifi 0000:03:00.0: 
0xC0886284 | stack pointer
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179689] iwlwifi 0000:03:00.0: 
0x00D8019C | last host cmd
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179694] iwlwifi 0000:03:00.0: 
0x00000000 | isr status reg
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179707] iwlwifi 0000:03:00.0: 
Fseq Registers:
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179715] iwlwifi 0000:03:00.0: 
0xE0000000 | FSEQ_ERROR_CODE
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179723] iwlwifi 0000:03:00.0: 
0x80290001 | FSEQ_TOP_INIT_VERSION
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179731] iwlwifi 0000:03:00.0: 
0x80050008 | FSEQ_CNVIO_INIT_VERSION
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179739] iwlwifi 0000:03:00.0: 
0x0000A503 | FSEQ_OTP_VERSION
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179747] iwlwifi 0000:03:00.0: 
0x80000003 | FSEQ_TOP_CONTENT_VERSION
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179755] iwlwifi 0000:03:00.0: 
0x4552414E | FSEQ_ALIVE_TOKEN
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179763] iwlwifi 0000:03:00.0: 
0x00100530 | FSEQ_CNVI_ID
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179771] iwlwifi 0000:03:00.0: 
0x00000532 | FSEQ_CNVR_ID
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179779] iwlwifi 0000:03:00.0: 
0x00100530 | CNVI_AUX_MISC_CHIP
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179789] iwlwifi 0000:03:00.0: 
0x00000532 | CNVR_AUX_MISC_CHIP
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179799] iwlwifi 0000:03:00.0: 
0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179810] iwlwifi 0000:03:00.0: 
0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179932] iwlwifi 0000:03:00.0: 
Collecting data: trigger 2 fired.
Sep 25 13:43:16 octo-pico-4 kernel: [ 5618.179947] ieee80211 phy0: 
Hardware restart was requested
Sep 25 13:43:17 octo-pico-4 kernel: [ 5618.755398] iwlwifi 0000:03:00.0: 
Applying debug destination EXTERNAL_DRAM
Sep 25 13:43:17 octo-pico-4 kernel: [ 5618.904492] iwlwifi 0000:03:00.0: 
FW already configured (0) - re-configuring
Sep 25 13:43:17 octo-pico-4 kernel: [ 5618.931426] iwlwifi 0000:03:00.0: 
Got NSS = 4 - trimming to 2
Sep 25 13:43:17 octo-pico-4 kernel: [ 5618.932215] iwlwifi 0000:03:00.0: 
Got NSS = 4 - trimming to 2
Sep 25 13:43:17 octo-pico-4 wpa_supplicant[890]: wlp3s0: 
CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-60 noise=9999 txrate=6000

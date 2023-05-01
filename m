Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD346F317A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 May 2023 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjEANUE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 May 2023 09:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEANUD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 May 2023 09:20:03 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A465128
        for <linux-wireless@vger.kernel.org>; Mon,  1 May 2023 06:20:01 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5D2AE10006E;
        Mon,  1 May 2023 13:19:59 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4EDD613C2B0;
        Mon,  1 May 2023 06:19:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4EDD613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1682947197;
        bh=PP1j5uRuWSEBU8uWvj4N0D7YJC6Tbz2abV3nq1NOlbE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=SNUbglON8dYE0VxPlUZTSG5ANuKNQa0yQTws583uWZq1J8wiOGml5vu63ij0bZkkr
         GAMMgXacmib9PVQ9Ol9f7cYMSML/dbfjJEXJR1HsEHB1scAZ92OGfULTY6hCajuWzn
         1g8OAaxiKFiTudJ8G3BHObr3ub/qZzbN3VM3370o=
Subject: Re: ax210 fw v78 crash in 6.4-ish kernel.
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <a558d27a-33ef-6c75-0552-03772ccfbe5f@candelatech.com>
 <cb551f45-ae06-f06b-4a72-dfd312f8eddf@candelatech.com>
 <f4398b3eb4e5652cef870a18c07f18f908d1de20.camel@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <8d820460-8f9d-31aa-7159-37a9575f49fd@candelatech.com>
Date:   Mon, 1 May 2023 06:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f4398b3eb4e5652cef870a18c07f18f908d1de20.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-MDID: 1682947200-4AxA4paDQ2De
X-MDID-O: us5;ut7;1682947200;4AxA4paDQ2De;<greearb@candelatech.com>;265462eed456beb3817746e42c55c9f9
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/30/23 1:54 PM, Greenman, Gregory wrote:
> Hi Ben,
> 
> On Fri, 2023-04-28 at 15:17 -0700, Ben Greear wrote:
>> On 4/28/23 14:42, Ben Greear wrote:
>>> I saw this in kernel based on recent Linus tree:
>>>
>>> [  154.760738] iwlwifi 0000:0c:00.0: Microcode SW error detected. Restarting 0x2.
>>> [  154.766812] iwlwifi 0000:0c:00.0: Start IWL Error Log Dump:
>>> [  154.771123] iwlwifi 0000:0c:00.0: Transport status: 0x0000004B, valid: 6
>>> [  154.776564] iwlwifi 0000:0c:00.0: Loaded firmware version: 78.3bfdc55f.0 ty-a0-gf-a0-78.ucode
>>> [  154.783811] iwlwifi 0000:0c:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
>>> [  154.789485] iwlwifi 0000:0c:00.0: 0x00808203 | trm_hw_status0
>>> [  154.793954] iwlwifi 0000:0c:00.0: 0x00000000 | trm_hw_status1
>>> [  154.798427] iwlwifi 0000:0c:00.0: 0x004DC220 | branchlink2
>>> [  154.802623] iwlwifi 0000:0c:00.0: 0x000088B8 | interruptlink1
>>> [  154.807108] iwlwifi 0000:0c:00.0: 0x000088B8 | interruptlink2
>>> [  154.811568] iwlwifi 0000:0c:00.0: 0x00016AEC | data1
>>> [  154.815257] iwlwifi 0000:0c:00.0: 0x00000010 | data2
>>> [  154.818949] iwlwifi 0000:0c:00.0: 0x00000000 | data3
>>> [  154.822656] iwlwifi 0000:0c:00.0: 0x41817919 | beacon time
>>> [  154.826873] iwlwifi 0000:0c:00.0: 0x7E3EA72C | tsf low
>>> [  154.830722] iwlwifi 0000:0c:00.0: 0x00000003 | tsf hi
>>> [  154.834492] iwlwifi 0000:0c:00.0: 0x00000000 | time gp1
>>> [  154.838446] iwlwifi 0000:0c:00.0: 0x01CE3A83 | time gp2
>>> [  154.842385] iwlwifi 0000:0c:00.0: 0x00000001 | uCode revision type
>>> [  154.847273] iwlwifi 0000:0c:00.0: 0x0000004E | uCode version major
>>> [  154.852165] iwlwifi 0000:0c:00.0: 0x3BFDC55F | uCode version minor
>>> [  154.857090] iwlwifi 0000:0c:00.0: 0x00000420 | hw version
>>> [  154.861201] iwlwifi 0000:0c:00.0: 0x00C80002 | board version
>>> [  154.865594] iwlwifi 0000:0c:00.0: 0x806EF400 | hcmd
>>> [  154.869182] iwlwifi 0000:0c:00.0: 0xE6F4B610 | isr0
>>> [  154.872785] iwlwifi 0000:0c:00.0: 0x01448000 | isr1
>>> [  154.876378] iwlwifi 0000:0c:00.0: 0x40F8011A | isr2
>>> [  154.879994] iwlwifi 0000:0c:00.0: 0x00C00008 | isr3
>>> [  154.883611] iwlwifi 0000:0c:00.0: 0x00200000 | isr4
>>> [  154.887259] iwlwifi 0000:0c:00.0: 0x0311001C | last cmd Id
>>> [  154.891459] iwlwifi 0000:0c:00.0: 0x00016AEC | wait_event
>>> [  154.895573] iwlwifi 0000:0c:00.0: 0x00004288 | l2p_control
>>> [  154.899806] iwlwifi 0000:0c:00.0: 0x00019C14 | l2p_duration
>>> [  154.904092] iwlwifi 0000:0c:00.0: 0x00000000 | l2p_mhvalid
>>> [  154.908304] iwlwifi 0000:0c:00.0: 0x00EF00F8 | l2p_addr_match
>>> [  154.912777] iwlwifi 0000:0c:00.0: 0x00000009 | lmpm_pmg_sel
>>> [  154.917065] iwlwifi 0000:0c:00.0: 0x00000000 | timestamp
>>> [  154.921103] iwlwifi 0000:0c:00.0: 0x05F83838 | flow_handler
>>> [  154.925473] iwlwifi 0000:0c:00.0: Start IWL Error Log Dump:
>>> [  154.929778] iwlwifi 0000:0c:00.0: Transport status: 0x0000004B, valid: 7
>>> [  154.935190] iwlwifi 0000:0c:00.0: 0x20100246 | ADVANCED_SYSASSERT
>>> [  154.940001] iwlwifi 0000:0c:00.0: 0x00000000 | umac branchlink1
>>> [  154.944643] iwlwifi 0000:0c:00.0: 0x8046D728 | umac branchlink2
>>> [  154.949291] iwlwifi 0000:0c:00.0: 0x8048DB02 | umac interruptlink1
>>> [  154.954190] iwlwifi 0000:0c:00.0: 0x00000000 | umac interruptlink2
>>> [  154.959117] iwlwifi 0000:0c:00.0: 0xDEADBEEF | umac data1
>>> [  154.963238] iwlwifi 0000:0c:00.0: 0xDEADBEEF | umac data2
>>> [  154.967367] iwlwifi 0000:0c:00.0: 0xDEADBEEF | umac data3
>>> [  154.971493] iwlwifi 0000:0c:00.0: 0x0000004E | umac major
>>> [  154.975657] iwlwifi 0000:0c:00.0: 0x3BFDC55F | umac minor
>>> [  154.979798] iwlwifi 0000:0c:00.0: 0x01CE3A7D | frame pointer
>>> [  154.984177] iwlwifi 0000:0c:00.0: 0xC0887F00 | stack pointer
>>> [  154.988574] iwlwifi 0000:0c:00.0: 0x00030303 | last host cmd
>>> [  154.992985] iwlwifi 0000:0c:00.0: 0x00010008 | isr status reg
>>> [  154.997471] iwlwifi 0000:0c:00.0: IML/ROM dump:
>>> [  155.000722] iwlwifi 0000:0c:00.0: 0x00000B03 | IML/ROM error/state
>>> [  155.005655] iwlwifi 0000:0c:00.0: 0x00007F8A | IML/ROM data1
>>> [  155.010041] iwlwifi 0000:0c:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
>>> [  155.015285] iwlwifi 0000:0c:00.0: Fseq Registers:
>>> [  155.018704] iwlwifi 0000:0c:00.0: 0x60000000 | FSEQ_ERROR_CODE
>>> [  155.023255] iwlwifi 0000:0c:00.0: 0x80440006 | FSEQ_TOP_INIT_VERSION
>>> [  155.028328] iwlwifi 0000:0c:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
>>> [  155.033572] iwlwifi 0000:0c:00.0: 0x0000A652 | FSEQ_OTP_VERSION
>>> [  155.038221] iwlwifi 0000:0c:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
>>> [  155.043557] iwlwifi 0000:0c:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
>>> [  155.048196] iwlwifi 0000:0c:00.0: 0x00400410 | FSEQ_CNVI_ID
>>> [  155.052486] iwlwifi 0000:0c:00.0: 0x00400410 | FSEQ_CNVR_ID
>>> [  155.056776] iwlwifi 0000:0c:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
>>> [  155.061611] iwlwifi 0000:0c:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
>>> [  155.066453] iwlwifi 0000:0c:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
>>> [  155.073000] iwlwifi 0000:0c:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
>>> [  155.079912] iwlwifi 0000:0c:00.0: UMAC CURRENT PC: 0xd05c18
>>> [  155.084204] iwlwifi 0000:0c:00.0: LMAC1 CURRENT PC: 0xd05c1c
>>> [  155.089017] iwlwifi 0000:0c:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
>>> [  155.089026] ieee80211 wiphy5: Hardware restart was requested
>>> [  155.089064] iwlwifi 0000:0c:00.0: FW error in SYNC CMD UNKNOWN
>>
>> v77 firmware crashes as well:
>>
>> [  107.339313] iwlwifi 0000:0c:00.0: Microcode SW error detected. Restarting 0x100.
>> [  107.347603] iwlwifi 0000:0c:00.0: Start IWL Error Log Dump:
>> [  107.351904] iwlwifi 0000:0c:00.0: Transport status: 0x0000004B, valid: 6
>> [  107.357345] iwlwifi 0000:0c:00.0: Loaded firmware version: 77.f92b5fed.0 ty-a0-gf-a0-77.ucode
>> [  107.364602] iwlwifi 0000:0c:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
>> [  107.370297] iwlwifi 0000:0c:00.0: 0x00000C07 | trm_hw_status0
>> [  107.374772] iwlwifi 0000:0c:00.0: 0x00000000 | trm_hw_status1
>> [  107.379244] iwlwifi 0000:0c:00.0: 0x004DC582 | branchlink2
>> [  107.383459] iwlwifi 0000:0c:00.0: 0x00008B14 | interruptlink1
>> [  107.387929] iwlwifi 0000:0c:00.0: 0x00008B14 | interruptlink2
>> [  107.392407] iwlwifi 0000:0c:00.0: 0x0000C586 | data1
>> [  107.396090] iwlwifi 0000:0c:00.0: 0x00000010 | data2
>> [  107.399791] iwlwifi 0000:0c:00.0: 0x00000000 | data3
>> [  107.403482] iwlwifi 0000:0c:00.0: 0x08003A16 | beacon time
>> [  107.407690] iwlwifi 0000:0c:00.0: 0xC22E862C | tsf low
>> [  107.411556] iwlwifi 0000:0c:00.0: 0x00000003 | tsf hi
>> [  107.415332] iwlwifi 0000:0c:00.0: 0x00000000 | time gp1
>> [  107.419283] iwlwifi 0000:0c:00.0: 0x006FCDBE | time gp2
>> [  107.423227] iwlwifi 0000:0c:00.0: 0x00000001 | uCode revision type
>> [  107.428129] iwlwifi 0000:0c:00.0: 0x0000004D | uCode version major
>> [  107.433039] iwlwifi 0000:0c:00.0: 0xF92B5FED | uCode version minor
>> [  107.437937] iwlwifi 0000:0c:00.0: 0x00000420 | hw version
>> [  107.442049] iwlwifi 0000:0c:00.0: 0x18C80002 | board version
>> [  107.446427] iwlwifi 0000:0c:00.0: 0x80EAFF00 | hcmd
>> [  107.450023] iwlwifi 0000:0c:00.0: 0xE6F48400 | isr0
>> [  107.453624] iwlwifi 0000:0c:00.0: 0x01000000 | isr1
>> [  107.457218] iwlwifi 0000:0c:00.0: 0x40F8001A | isr2
>> [  107.460812] iwlwifi 0000:0c:00.0: 0x04C3601E | isr3
>> [  107.464429] iwlwifi 0000:0c:00.0: 0x00200000 | isr4
>> [  107.468035] iwlwifi 0000:0c:00.0: 0x0402001C | last cmd Id
>> [  107.472251] iwlwifi 0000:0c:00.0: 0x0000C586 | wait_event
>> [  107.476374] iwlwifi 0000:0c:00.0: 0x00004A88 | l2p_control
>> [  107.480573] iwlwifi 0000:0c:00.0: 0x0001BC34 | l2p_duration
>> [  107.484863] iwlwifi 0000:0c:00.0: 0x000003BF | l2p_mhvalid
>> [  107.489089] iwlwifi 0000:0c:00.0: 0x00EF00F8 | l2p_addr_match
>> [  107.493559] iwlwifi 0000:0c:00.0: 0x00000009 | lmpm_pmg_sel
>> [  107.497849] iwlwifi 0000:0c:00.0: 0x00000000 | timestamp
>> [  107.501899] iwlwifi 0000:0c:00.0: 0x05F8C8C8 | flow_handler
>> [  107.506240] iwlwifi 0000:0c:00.0: Start IWL Error Log Dump:
>> [  107.510534] iwlwifi 0000:0c:00.0: Transport status: 0x0000004B, valid: 7
>> [  107.515953] iwlwifi 0000:0c:00.0: 0x20100246 | ADVANCED_SYSASSERT
>> [  107.520774] iwlwifi 0000:0c:00.0: 0x00000000 | umac branchlink1
>> [  107.525405] iwlwifi 0000:0c:00.0: 0x8046D64C | umac branchlink2
>> [  107.530044] iwlwifi 0000:0c:00.0: 0x8048D8D6 | umac interruptlink1
>> [  107.534940] iwlwifi 0000:0c:00.0: 0x00000000 | umac interruptlink2
>> [  107.539852] iwlwifi 0000:0c:00.0: 0xDEADBEEF | umac data1
>> [  107.543982] iwlwifi 0000:0c:00.0: 0xDEADBEEF | umac data2
>> [  107.548090] iwlwifi 0000:0c:00.0: 0xDEADBEEF | umac data3
>> [  107.552198] iwlwifi 0000:0c:00.0: 0x0000004D | umac major
>> [  107.556326] iwlwifi 0000:0c:00.0: 0xF92B5FED | umac minor
>> [  107.560448] iwlwifi 0000:0c:00.0: 0x006FCDB8 | frame pointer
>> [  107.564840] iwlwifi 0000:0c:00.0: 0xC0887F00 | stack pointer
>> [  107.569214] iwlwifi 0000:0c:00.0: 0x007B0303 | last host cmd
>> [  107.573588] iwlwifi 0000:0c:00.0: 0x00010008 | isr status reg
>> [  107.578077] iwlwifi 0000:0c:00.0: IML/ROM dump:
>> [  107.581340] iwlwifi 0000:0c:00.0: 0x00000B03 | IML/ROM error/state
>> [  107.586286] iwlwifi 0000:0c:00.0: 0x00007D74 | IML/ROM data1
>> [  107.590699] iwlwifi 0000:0c:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
>> [  107.595963] iwlwifi 0000:0c:00.0: Fseq Registers:
>> [  107.599385] iwlwifi 0000:0c:00.0: 0x60000100 | FSEQ_ERROR_CODE
>> [  107.603950] iwlwifi 0000:0c:00.0: 0x80440006 | FSEQ_TOP_INIT_VERSION
>> [  107.609024] iwlwifi 0000:0c:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
>> [  107.614282] iwlwifi 0000:0c:00.0: 0x0000A652 | FSEQ_OTP_VERSION
>> [  107.618921] iwlwifi 0000:0c:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
>> [  107.624250] iwlwifi 0000:0c:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
>> [  107.628903] iwlwifi 0000:0c:00.0: 0x00400410 | FSEQ_CNVI_ID
>> [  107.633203] iwlwifi 0000:0c:00.0: 0x00400410 | FSEQ_CNVR_ID
>> [  107.637503] iwlwifi 0000:0c:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
>> [  107.642328] iwlwifi 0000:0c:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
>> [  107.647155] iwlwifi 0000:0c:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
>> [  107.653702] iwlwifi 0000:0c:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
>> [  107.660601] iwlwifi 0000:0c:00.0: UMAC CURRENT PC: 0xd05c18
>> [  107.664895] iwlwifi 0000:0c:00.0: LMAC1 CURRENT PC: 0xd05c1c
>> [  107.669512] iwlwifi 0000:0c:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
>> [  107.669517] ieee80211 wiphy5: Hardware restart was requested
>> [  107.669528] iwlwifi 0000:0c:00.0: FW error in SYNC CMD UNKNOWN
>> [  107.674073] CPU: 1 PID: 193 Comm: kworker/1:3 Not tainted 6.3.0+ #1
>> [  107.674078] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/19/2019
>> [  107.674081] Workqueue: events iwl_mvm_tcm_work [iwlmvm]
>> [  107.674132] Call Trace:
>> [  107.674135]  <TASK>
>> [  107.674137]  dump_stack_lvl+0x43/0x60
>> [  107.674145]  iwl_trans_txq_send_hcmd+0x578/0x760 [iwlwifi]
>> [  107.674207]  ? iwl_trans_txq_freeze_timer+0x1f0/0x1f0 [iwlwifi]
>> [  107.674258]  ? destroy_sched_domains_rcu+0x30/0x30
>> [  107.674268]  ? stack_trace_save+0x8c/0xc0
>> [  107.674274]  ? filter_irq_stacks+0x18/0x60
>> [  107.674277]  ? __stack_depot_save+0x35/0x470
>> [  107.674283]  iwl_trans_send_cmd+0xc4/0x180 [iwlwifi]
>> [  107.674328]  iwl_mvm_send_cmd+0x32/0x80 [iwlmvm]
>> [  107.674368]  iwl_mvm_send_low_latency_cmd+0x107/0x170 [iwlmvm]
>> [  107.674406]  ? iwl_mvm_rx_diversity_allowed+0x150/0x150 [iwlmvm]
>> [  107.674442]  ? enqueue_timer+0xbf/0x1e0
>> [  107.674447]  ? detach_if_pending+0x1e/0x180
>> [  107.674452]  iwl_mvm_update_low_latency+0xc9/0x120 [iwlmvm]
>> [  107.674492]  __iterate_interfaces+0x102/0x190 [mac80211]
>> [  107.674633]  ? iwl_mvm_update_low_latency+0x120/0x120 [iwlmvm]
>> [  107.674671]  ? iwl_mvm_update_low_latency+0x120/0x120 [iwlmvm]
>> [  107.674710]  ieee80211_iterate_interfaces+0x32/0x50 [mac80211]
>> [  107.674811]  iwl_mvm_recalc_tcm+0x1e7/0x990 [iwlmvm]
>> [  107.674862]  ? iwl_mvm_tcm_load_percentage+0x20/0x20 [iwlmvm]
>> [  107.674916]  ? __schedule+0x7b3/0x1250
>> [  107.674920]  ? io_schedule_timeout+0xb0/0xb0
>> [  107.674924]  ? strscpy+0x146/0x190
>> [  107.674928]  process_one_work+0x463/0x790
>> [  107.674935]  worker_thread+0x88/0x6f0
>> [  107.674939]  ? migrate_enable+0x170/0x170
>> [  107.674945]  ? process_one_work+0x790/0x790
>> [  107.674949]  kthread+0x16d/0x1b0
>> [  107.674954]  ? kthread_complete_and_exit+0x20/0x20
>> [  107.674958]  ret_from_fork+0x1f/0x30
>> [  107.674965]  </TASK>
>> [  107.674974] iwlwifi 0000:0c:00.0: Failed to send low latency command
>> [  122.878885] iwlwifi 0000:0c:00.0: mcast filter cmd error. ret=-5
>> [  122.883632] iwlwifi 0000:0c:00.0: Failed to synchronize multicast groups update
>> [  123.791841] iwlwifi 0000:0c:00.0: Master Disable Timed Out, 100 usec
>> [  234.009047] iwlwifi 0000:0c:00.0: WRT: Invalid buffer destination
>> [  234.240960] iwlwifi 0000:0c:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x1f
>> [  234.258687] iwlwifi 0000:0c:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
>> [  234.262627] iwlwifi 0000:0c:00.0: WFPM_AUTH_KEY_0: 0x80
>> [  234.266550] iwlwifi 0000:0c:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
>>
>>
>>>
>>> Thanks,
>>> Ben
>>>
>>
> Do you have a way to reproduce it or it just happens randomly?

The system I looked at was crashing often and regularly.  I can get you a binary
crash dump from the firmware if that would help.

Thanks,
Ben

> 
> Thanks,
> Gregory
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

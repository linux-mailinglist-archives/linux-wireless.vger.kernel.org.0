Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E828E4C4858
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Feb 2022 16:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbiBYPLe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 10:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiBYPLc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 10:11:32 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D356725EB2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 07:10:59 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nNcFE-0001dZ-2P; Fri, 25 Feb 2022 16:10:56 +0100
Message-ID: <4da43e43-c2f3-1f5a-a00f-f1be65668e60@leemhuis.info>
Date:   Fri, 25 Feb 2022 16:10:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Bug 215523 - Firmware crash with 66.f1c864e0.0 (cc-a0-66.ucode)
 and 68.01d30b0c (cc-a0-68.ucode)
Content-Language: en-BS
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Luca Coelho <luciano.coelho@intel.com>
References: <adf5ac57-cd60-a004-a05d-6d7c3ad7efa7@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        golan.ben.ami@intel.com
In-Reply-To: <adf5ac57-cd60-a004-a05d-6d7c3ad7efa7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1645801859;55d822dc;
X-HE-SMSGID: 1nNcFE-0001dZ-2P
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easy accessible to everyone.

Luca, can you help me out please? Below regression was reported a while
ago in https://bugzilla.kernel.org/show_bug.cgi?id=215523

Goan about two weeks ago came up with a rough patch that helped:
https://bugzilla.kernel.org/show_bug.cgi?id=215523#c13

What the status of that fix? I couldn't find a similar fix in the
archives and no commit that linked to the ticket. I already asked Goan
for a update in the ticket about a week ago, but I didn't get an answer.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot poke

On 10.02.22 10:56, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> There is a regression in bugzilla.kernel.org I'd like to add to the
> tracking:
> 
> #regzbot introduced: v5.16..v5.17-rc1
> #regzbot from: Udo Steinberg <udo@hypervisor.org>
> #regzbot title: iwlwifi: Firmware crash with 66.f1c864e0.0
> (cc-a0-66.ucode) and 68.01d30b0c (cc-a0-68.ucode)
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215523
> 
> Quote:
> 
>> Seeing the following firmware crash frequently with
>> firmware-version: 66.f1c864e0.0 cc-a0-66.ucode
>>
>> [14699.974055] iwlwifi 0000:03:00.0: Microcode SW error detected. Restarting 0x0.
>> [14699.974484] iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
>> [14699.974496] iwlwifi 0000:03:00.0: Transport status: 0x0000004A, valid: 6
>> [14699.974509] iwlwifi 0000:03:00.0: Loaded firmware version: 66.f1c864e0.0 cc-a0-66.ucode
>> [14699.974521] iwlwifi 0000:03:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL    
>> [14699.974532] iwlwifi 0000:03:00.0: 0x000022F0 | trm_hw_status0
>> [14699.974541] iwlwifi 0000:03:00.0: 0x00000000 | trm_hw_status1
>> [14699.974549] iwlwifi 0000:03:00.0: 0x004FAA46 | branchlink2
>> [14699.974557] iwlwifi 0000:03:00.0: 0x004F13DE | interruptlink1
>> [14699.974565] iwlwifi 0000:03:00.0: 0x004F13DE | interruptlink2
>> [14699.974573] iwlwifi 0000:03:00.0: 0x00005D04 | data1
>> [14699.974581] iwlwifi 0000:03:00.0: 0x00001000 | data2
>> [14699.974588] iwlwifi 0000:03:00.0: 0x00000000 | data3
>> [14699.974596] iwlwifi 0000:03:00.0: 0x5F80B98E | beacon time
>> [14699.974604] iwlwifi 0000:03:00.0: 0xDA80E7BE | tsf low
>> [14699.974612] iwlwifi 0000:03:00.0: 0x000001D9 | tsf hi
>> [14699.974621] iwlwifi 0000:03:00.0: 0x00000000 | time gp1
>> [14699.974629] iwlwifi 0000:03:00.0: 0x1622E64D | time gp2
>> [14699.974636] iwlwifi 0000:03:00.0: 0x00000001 | uCode revision type
>> [14699.974645] iwlwifi 0000:03:00.0: 0x00000042 | uCode version major
>> [14699.974652] iwlwifi 0000:03:00.0: 0xF1C864E0 | uCode version minor
>> [14699.974662] iwlwifi 0000:03:00.0: 0x00000340 | hw version
>> [14699.974668] iwlwifi 0000:03:00.0: 0x00C89000 | board version
>> [14699.974675] iwlwifi 0000:03:00.0: 0x800EFC03 | hcmd
>> [14699.974682] iwlwifi 0000:03:00.0: 0x00020000 | isr0
>> [14699.974689] iwlwifi 0000:03:00.0: 0x00400000 | isr1
>> [14699.974695] iwlwifi 0000:03:00.0: 0x08F04802 | isr2
>> [14699.974702] iwlwifi 0000:03:00.0: 0x00C3780C | isr3
>> [14699.974710] iwlwifi 0000:03:00.0: 0x00000000 | isr4
>> [14699.974718] iwlwifi 0000:03:00.0: 0x0510001C | last cmd Id
>> [14699.974725] iwlwifi 0000:03:00.0: 0x00005D04 | wait_event
>> [14699.974733] iwlwifi 0000:03:00.0: 0x00000054 | l2p_control
>> [14699.974740] iwlwifi 0000:03:00.0: 0x00000000 | l2p_duration
>> [14699.974746] iwlwifi 0000:03:00.0: 0x0000000F | l2p_mhvalid
>> [14699.974754] iwlwifi 0000:03:00.0: 0x000000C7 | l2p_addr_match
>> [14699.974761] iwlwifi 0000:03:00.0: 0x00000008 | lmpm_pmg_sel
>> [14699.974768] iwlwifi 0000:03:00.0: 0x00000000 | timestamp
>> [14699.974776] iwlwifi 0000:03:00.0: 0x00004890 | flow_handler
>> [14699.974923] iwlwifi 0000:03:00.0: Start IWL Error Log Dump:
>> [14699.974933] iwlwifi 0000:03:00.0: Transport status: 0x0000004A, valid: 7
>> [14699.974945] iwlwifi 0000:03:00.0: 0x20003463 | ADVANCED_SYSASSERT
>> [14699.974953] iwlwifi 0000:03:00.0: 0x00000000 | umac branchlink1
>> [14699.974961] iwlwifi 0000:03:00.0: 0x80455A96 | umac branchlink2
>> [14699.974969] iwlwifi 0000:03:00.0: 0xC00811A4 | umac interruptlink1
>> [14699.974976] iwlwifi 0000:03:00.0: 0x00000000 | umac interruptlink2
>> [14699.974983] iwlwifi 0000:03:00.0: 0xDA80E7B1 | umac data1
>> [14699.974992] iwlwifi 0000:03:00.0: 0x1622E63F | umac data2
>> [14699.974999] iwlwifi 0000:03:00.0: 0xC5490101 | umac data3
>> [14699.975006] iwlwifi 0000:03:00.0: 0x00000042 | umac major
>> [14699.975013] iwlwifi 0000:03:00.0: 0xF1C864E0 | umac minor
>> [14699.975020] iwlwifi 0000:03:00.0: 0x1622E647 | frame pointer
>> [14699.975027] iwlwifi 0000:03:00.0: 0xC0885E08 | stack pointer
>> [14699.975035] iwlwifi 0000:03:00.0: 0x00AB010C | last host cmd
>> [14699.975042] iwlwifi 0000:03:00.0: 0x00000000 | isr status reg
>> [14699.975089] iwlwifi 0000:03:00.0: IML/ROM dump:
>> [14699.975096] iwlwifi 0000:03:00.0: 0x00000003 | IML/ROM error/state
>> [14699.975135] iwlwifi 0000:03:00.0: 0x00005A9A | IML/ROM data1
>> [14699.975170] iwlwifi 0000:03:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
>> [14699.975249] iwlwifi 0000:03:00.0: Fseq Registers:
>> [14699.975269] iwlwifi 0000:03:00.0: 0x60000000 | FSEQ_ERROR_CODE
>> [14699.975288] iwlwifi 0000:03:00.0: 0x80290021 | FSEQ_TOP_INIT_VERSION
>> [14699.975308] iwlwifi 0000:03:00.0: 0x00050008 | FSEQ_CNVIO_INIT_VERSION
>> [14699.975328] iwlwifi 0000:03:00.0: 0x0000A503 | FSEQ_OTP_VERSION
>> [14699.975348] iwlwifi 0000:03:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
>> [14699.975368] iwlwifi 0000:03:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
>> [14699.975388] iwlwifi 0000:03:00.0: 0x00100530 | FSEQ_CNVI_ID
>> [14699.975407] iwlwifi 0000:03:00.0: 0x00000532 | FSEQ_CNVR_ID
>> [14699.975428] iwlwifi 0000:03:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
>> [14699.975450] iwlwifi 0000:03:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
>> [14699.975472] iwlwifi 0000:03:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
>> [14699.975494] iwlwifi 0000:03:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
>> [14699.975970] iwlwifi 0000:03:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
> 

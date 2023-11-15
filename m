Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647A97ED5D4
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 22:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbjKOVQU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 16:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjKOVQT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 16:16:19 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE53AB7
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 13:16:14 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3638EB0006D;
        Wed, 15 Nov 2023 21:16:12 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 5E1B713C2B0;
        Wed, 15 Nov 2023 13:16:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5E1B713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1700082969;
        bh=hmrHj2TZon78G5c3vDocP2sbUoiog8K/cpZF/vEv6EE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qvScktDO47uzFPvZNs3bGK2yLCJXY9HSnbRDTHKXzS4JnTDe6RItcGNGaqVLnmIWh
         kUx80mUx5CLr8W3LMglEf4dC4m+QEdacyWtxWHmsxGNirpy4dR0wgHsWEs3TkB/Mr5
         jwSWfguujxRSnz3iVSYqEJFQTeSKPrkMhIcF67SE=
Message-ID: <16c7fe0c-19c0-4b9f-60dd-9a892a9390cd@candelatech.com>
Date:   Wed, 15 Nov 2023 13:16:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: iwlwifi firmware updates 2023-11-15-fixed
Content-Language: en-US
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>
References: <a2cd0356c69d1e0c1f0489bad22ecab7b9e589a0.camel@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <a2cd0356c69d1e0c1f0489bad22ecab7b9e589a0.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1700082973-ndlyPGdIirPK
X-MDID-O: us5;ut7;1700082973;ndlyPGdIirPK;<greearb@candelatech.com>;c4cb9ae18b457cd2373b30bda2d9c03e
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Gregory,

Still won't load for me:

# md5sum /lib/firmware/iwlwifi-gl-c0-fm-c0-86.ucode
7809461c1cb181003f5844937e7aa3fc  /lib/firmware/iwlwifi-gl-c0-fm-c0-86.ucode


[  176.219456] iwlwifi 0000:2a:00.0: Loaded firmware version: 86.fb5c9aeb.0 gl-c0-fm-c0-86.ucode
[  176.226745] iwlwifi 0000:2a:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
[  176.232437] iwlwifi 0000:2a:00.0: 0x000002F0 | trm_hw_status0
[  176.236904] iwlwifi 0000:2a:00.0: 0x00000000 | trm_hw_status1
[  176.241377] iwlwifi 0000:2a:00.0: 0x002C3FDA | branchlink2
[  176.245586] iwlwifi 0000:2a:00.0: 0x002B8B86 | interruptlink1
[  176.250053] iwlwifi 0000:2a:00.0: 0x002B8B86 | interruptlink2
[  176.254522] iwlwifi 0000:2a:00.0: 0x002A5A70 | data1
[  176.258204] iwlwifi 0000:2a:00.0: 0x00000010 | data2
[  176.261888] iwlwifi 0000:2a:00.0: 0x00000000 | data3
[  176.265572] iwlwifi 0000:2a:00.0: 0x00000000 | beacon time
[  176.269788] iwlwifi 0000:2a:00.0: 0x000164F6 | tsf low
[  176.273649] iwlwifi 0000:2a:00.0: 0x00000000 | tsf hi
[  176.277417] iwlwifi 0000:2a:00.0: 0x00000000 | time gp1
[  176.281363] iwlwifi 0000:2a:00.0: 0x0004051E | time gp2
[  176.285306] iwlwifi 0000:2a:00.0: 0x00000001 | uCode revision type
[  176.290219] iwlwifi 0000:2a:00.0: 0x00000056 | uCode version major
[  176.295126] iwlwifi 0000:2a:00.0: 0xFB5C9AEB | uCode version minor
[  176.300033] iwlwifi 0000:2a:00.0: 0x00000472 | hw version
[  176.304158] iwlwifi 0000:2a:00.0: 0x18C80002 | board version
[  176.308540] iwlwifi 0000:2a:00.0: 0x8001FF03 | hcmd
[  176.312141] iwlwifi 0000:2a:00.0: 0x00020000 | isr0
[  176.315745] iwlwifi 0000:2a:00.0: 0x20000000 | isr1
[  176.319347] iwlwifi 0000:2a:00.0: 0x58F80002 | isr2
[  176.322942] iwlwifi 0000:2a:00.0: 0x00C0001C | isr3
[  176.326544] iwlwifi 0000:2a:00.0: 0x02000000 | isr4
[  176.330145] iwlwifi 0000:2a:00.0: 0x00000000 | last cmd Id
[  176.334355] iwlwifi 0000:2a:00.0: 0x002A5A70 | wait_event
[  176.338476] iwlwifi 0000:2a:00.0: 0x10000414 | l2p_control
[  176.342679] iwlwifi 0000:2a:00.0: 0x00000000 | l2p_duration
[  176.346967] iwlwifi 0000:2a:00.0: 0x00000000 | l2p_mhvalid
[  176.351178] iwlwifi 0000:2a:00.0: 0x00000000 | l2p_addr_match
[  176.355842] iwlwifi 0000:2a:00.0: 0x0000000B | lmpm_pmg_sel
[  176.360310] iwlwifi 0000:2a:00.0: 0x00000000 | timestamp
[  176.364518] iwlwifi 0000:2a:00.0: 0x00000020 | flow_handler
[  176.368933] iwlwifi 0000:2a:00.0: Start IWL Error Log Dump:
[  176.373229] iwlwifi 0000:2a:00.0: Transport status: 0x00000042, valid: 7
[  176.378665] iwlwifi 0000:2a:00.0: 0x201000B6 | ADVANCED_SYSASSERT
[  176.383489] iwlwifi 0000:2a:00.0: 0x00000000 | umac branchlink1
[  176.388130] iwlwifi 0000:2a:00.0: 0xC00809B8 | umac branchlink2
[  176.392774] iwlwifi 0000:2a:00.0: 0x8026FB40 | umac interruptlink1
[  176.397668] iwlwifi 0000:2a:00.0: 0x010293A0 | umac interruptlink2
[  176.402581] iwlwifi 0000:2a:00.0: 0x00000009 | umac data1
[  176.406704] iwlwifi 0000:2a:00.0: 0xDEADBEEF | umac data2
[  176.410826] iwlwifi 0000:2a:00.0: 0xDEADBEEF | umac data3
[  176.414941] iwlwifi 0000:2a:00.0: 0x00000056 | umac major
[  176.419059] iwlwifi 0000:2a:00.0: 0xFB5C9AEB | umac minor
[  176.423178] iwlwifi 0000:2a:00.0: 0x00040511 | frame pointer
[  176.427560] iwlwifi 0000:2a:00.0: 0xD00D6B10 | stack pointer
[  176.431936] iwlwifi 0000:2a:00.0: 0x00000000 | last host cmd
[  176.436315] iwlwifi 0000:2a:00.0: 0x00000000 | isr status reg
[  176.440940] iwlwifi 0000:2a:00.0: TCM1 status:
[  176.444103] iwlwifi 0000:2a:00.0: 0x00000070 | error ID
[  176.448049] iwlwifi 0000:2a:00.0: 0x000019C2 | tcm branchlink2
[  176.452599] iwlwifi 0000:2a:00.0: 0x00001DB8 | tcm interruptlink1
[  176.457411] iwlwifi 0000:2a:00.0: 0x00001DB8 | tcm interruptlink2
[  176.462228] iwlwifi 0000:2a:00.0: 0x40000000 | tcm data1
[  176.466259] iwlwifi 0000:2a:00.0: 0xDEADBEEF | tcm data2
[  176.470298] iwlwifi 0000:2a:00.0: 0xDEADBEEF | tcm data3
[  176.474325] iwlwifi 0000:2a:00.0: 0x00001A20 | tcm log PC
[  176.478489] iwlwifi 0000:2a:00.0: 0x00803FF0 | tcm frame pointer
[  176.483224] iwlwifi 0000:2a:00.0: 0x00803F4C | tcm stack pointer
[  176.488221] iwlwifi 0000:2a:00.0: 0x00000000 | tcm msg ID
[  176.492404] iwlwifi 0000:2a:00.0: 0x40000000 | tcm ISR status
[  176.496898] iwlwifi 0000:2a:00.0: 0x000002F0 | tcm HW status[0]
[  176.501608] iwlwifi 0000:2a:00.0: 0x00000000 | tcm HW status[1]
[  176.506431] iwlwifi 0000:2a:00.0: 0x00000000 | tcm HW status[2]
[  176.511174] iwlwifi 0000:2a:00.0: 0x00008000 | tcm HW status[3]
[  176.515822] iwlwifi 0000:2a:00.0: 0x00000000 | tcm HW status[4]
[  176.520461] iwlwifi 0000:2a:00.0: 0x00000000 | tcm SW status[0]
[  176.525268] iwlwifi 0000:2a:00.0: RCM1 status:
[  176.528439] iwlwifi 0000:2a:00.0: 0x00000070 | error ID
[  176.532386] iwlwifi 0000:2a:00.0: 0x00001CFA | rcm branchlink2
[  176.536946] iwlwifi 0000:2a:00.0: 0x000022D8 | rcm interruptlink1
[  176.541763] iwlwifi 0000:2a:00.0: 0x000022D8 | rcm interruptlink2
[  176.546583] iwlwifi 0000:2a:00.0: 0x20000000 | rcm data1
[  176.550627] iwlwifi 0000:2a:00.0: 0xDEADBEEF | rcm data2
[  176.554665] iwlwifi 0000:2a:00.0: 0xDEADBEEF | rcm data3
[  176.558702] iwlwifi 0000:2a:00.0: 0x00001D5C | rcm log PC
[  176.562824] iwlwifi 0000:2a:00.0: 0x00803FF0 | rcm frame pointer
[  176.567553] iwlwifi 0000:2a:00.0: 0x00803F4C | rcm stack pointer
[  176.572281] iwlwifi 0000:2a:00.0: 0x00000000 | rcm msg ID
[  176.576402] iwlwifi 0000:2a:00.0: 0x20000000 | rcm ISR status
[  176.580867] iwlwifi 0000:2a:00.0: 0x00420500 | frame HW status
[  176.585428] iwlwifi 0000:2a:00.0: 0x00000000 | LMAC-to-RCM request mbox
[  176.590785] iwlwifi 0000:2a:00.0: 0x00000000 | RCM-to-LMAC request mbox
[  176.596125] iwlwifi 0000:2a:00.0: 0x00000000 | MAC header control
[  176.600943] iwlwifi 0000:2a:00.0: 0x00000000 | MAC header addr1 low
[  176.605934] iwlwifi 0000:2a:00.0: 0x003C0000 | MAC header info
[  176.610487] iwlwifi 0000:2a:00.0: 0x00000000 | MAC header error
[  176.615548] iwlwifi 0000:2a:00.0: TCM2 status:
[  176.618842] iwlwifi 0000:2a:00.0: 0x00000070 | error ID
[  176.622854] iwlwifi 0000:2a:00.0: 0x000019C2 | tcm branchlink2
[  176.627590] iwlwifi 0000:2a:00.0: 0x00001DB8 | tcm interruptlink1
[  176.632473] iwlwifi 0000:2a:00.0: 0x00001DB8 | tcm interruptlink2
[  176.637321] iwlwifi 0000:2a:00.0: 0x40000000 | tcm data1
[  176.641506] iwlwifi 0000:2a:00.0: 0xDEADBEEF | tcm data2
[  176.645607] iwlwifi 0000:2a:00.0: 0xDEADBEEF | tcm data3
[  176.649809] iwlwifi 0000:2a:00.0: 0x00001A20 | tcm log PC
[  176.654041] iwlwifi 0000:2a:00.0: 0x00803FF0 | tcm frame pointer
[  176.658944] iwlwifi 0000:2a:00.0: 0x00803F4C | tcm stack pointer
[  176.663845] iwlwifi 0000:2a:00.0: 0x00000000 | tcm msg ID
[  176.668134] iwlwifi 0000:2a:00.0: 0x40000000 | tcm ISR status
[  176.672607] iwlwifi 0000:2a:00.0: 0x000002F0 | tcm HW status[0]
[  176.677252] iwlwifi 0000:2a:00.0: 0x00000000 | tcm HW status[1]
[  176.681896] iwlwifi 0000:2a:00.0: 0x00000000 | tcm HW status[2]
[  176.686544] iwlwifi 0000:2a:00.0: 0x00008000 | tcm HW status[3]
[  176.691187] iwlwifi 0000:2a:00.0: 0x00000000 | tcm HW status[4]
[  176.695851] iwlwifi 0000:2a:00.0: 0x00000000 | tcm SW status[0]
[  176.700660] iwlwifi 0000:2a:00.0: RCM2 status:
[  176.703832] iwlwifi 0000:2a:00.0: 0x00000070 | error ID
[  176.707782] iwlwifi 0000:2a:00.0: 0x00001CFA | rcm branchlink2
[  176.712333] iwlwifi 0000:2a:00.0: 0x000022D8 | rcm interruptlink1
[  176.717154] iwlwifi 0000:2a:00.0: 0x000022D8 | rcm interruptlink2
[  176.721988] iwlwifi 0000:2a:00.0: 0x20000000 | rcm data1
[  176.726028] iwlwifi 0000:2a:00.0: 0xDEADBEEF | rcm data2
[  176.730067] iwlwifi 0000:2a:00.0: 0xDEADBEEF | rcm data3
[  176.734104] iwlwifi 0000:2a:00.0: 0x00001D5C | rcm log PC
[  176.738226] iwlwifi 0000:2a:00.0: 0x00803FF0 | rcm frame pointer
[  176.742954] iwlwifi 0000:2a:00.0: 0x00803F4C | rcm stack pointer
[  176.747692] iwlwifi 0000:2a:00.0: 0x00000000 | rcm msg ID
[  176.751820] iwlwifi 0000:2a:00.0: 0x20000000 | rcm ISR status
[  176.756290] iwlwifi 0000:2a:00.0: 0x00420500 | frame HW status
[  176.760848] iwlwifi 0000:2a:00.0: 0x00000000 | LMAC-to-RCM request mbox
[  176.766180] iwlwifi 0000:2a:00.0: 0x00000000 | RCM-to-LMAC request mbox
[  176.771519] iwlwifi 0000:2a:00.0: 0x00000000 | MAC header control
[  176.776336] iwlwifi 0000:2a:00.0: 0x00000000 | MAC header addr1 low
[  176.781331] iwlwifi 0000:2a:00.0: 0x003C0000 | MAC header info
[  176.785888] iwlwifi 0000:2a:00.0: 0x00000000 | MAC header error
[  176.790585] iwlwifi 0000:2a:00.0: IML/ROM dump:
[  176.793841] iwlwifi 0000:2a:00.0: 0x00000B03 | IML/ROM error/state
[  176.798815] iwlwifi 0000:2a:00.0: 0x0000EE6C | IML/ROM data1
[  176.803254] iwlwifi 0000:2a:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[  176.808548] iwlwifi 0000:2a:00.0: Fseq Registers:
[  176.812013] iwlwifi 0000:2a:00.0: 0x66A00000 | FSEQ_ERROR_CODE
[  176.816608] iwlwifi 0000:2a:00.0: 0x80B00004 | FSEQ_TOP_INIT_VERSION
[  176.821721] iwlwifi 0000:2a:00.0: 0x00550000 | FSEQ_CNVIO_INIT_VERSION
[  176.827007] iwlwifi 0000:2a:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[  176.831692] iwlwifi 0000:2a:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[  176.837065] iwlwifi 0000:2a:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[  176.841746] iwlwifi 0000:2a:00.0: 0x02001910 | FSEQ_CNVI_ID
[  176.846080] iwlwifi 0000:2a:00.0: 0x02001910 | FSEQ_CNVR_ID
[  176.850413] iwlwifi 0000:2a:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[  176.855270] iwlwifi 0000:2a:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[  176.860124] iwlwifi 0000:2a:00.0: 0x00001BE5 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  176.866723] iwlwifi 0000:2a:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  176.873672] iwlwifi 0000:2a:00.0: 0x00550000 | FSEQ_PREV_CNVIO_INIT_VERSION
[  176.879393] iwlwifi 0000:2a:00.0: 0x00B00004 | FSEQ_WIFI_FSEQ_VERSION
[  176.884598] iwlwifi 0000:2a:00.0: 0xFF12475A | FSEQ_BT_FSEQ_VERSION
[  176.889619] iwlwifi 0000:2a:00.0: 0x000000BF | FSEQ_CLASS_TP_VERSION
[  176.894802] iwlwifi 0000:2a:00.0: UMAC CURRENT PC: 0x8026b3aa
[  176.899310] iwlwifi 0000:2a:00.0: LMAC1 CURRENT PC: 0xd0
[  176.903396] iwlwifi 0000:2a:00.0: LMAC2 CURRENT PC: 0xd0
[  176.907465] iwlwifi 0000:2a:00.0: UMAC CURRENT PC 1: 0x8026b3a8
[  176.912148] iwlwifi 0000:2a:00.0: TCM1 CURRENT PC: 0xd0
[  176.916134] iwlwifi 0000:2a:00.0: RCM1 CURRENT PC: 0xd0
[  176.920121] iwlwifi 0000:2a:00.0: RCM2 CURRENT PC: 0xd0
[  176.924352] iwlwifi 0000:2a:00.0: Function Scratch status:
[  176.928742] iwlwifi 0000:2a:00.0: 0x01010101 | Func Scratch
[  176.995430] iwlwifi 0000:2a:00.0: Failed to run INIT ucode: -110
[  177.048087] iwlwifi 0000:2a:00.0: retry init count 2

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



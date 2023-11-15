Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E874D7ECA0D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 18:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjKOR4T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 12:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOR4S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 12:56:18 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B649F1AC
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 09:56:13 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B81EAA8007D;
        Wed, 15 Nov 2023 17:56:07 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id ED19F13C2B0;
        Wed, 15 Nov 2023 09:56:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com ED19F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1700070965;
        bh=BjvOSubBvj64qzbSbNweojoh5QmB6sYvckVL3/3j0xI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZYXBu1eNEkzmcqdvL9C2dCMFA0eSoC1m01nXJTRj+qfXy5e/3SAvg/6wB7qzNAk2N
         9Mq6gb0TF57lHUbs/1X6xlCC6jAzwNE74dS7eUsSuXsDl2BBKw7iyRbUGopw2U9RK7
         GKYTtWZb9wTntNgYsuBXMzqTQSxiyfKDXGDEvYOE=
Message-ID: <86f1b069-83f7-5bcb-1d05-64fbf8990fcf@candelatech.com>
Date:   Wed, 15 Nov 2023 09:56:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: iwlwifi firmware updates 2023-11-15
Content-Language: en-US
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
References: <afd952bc8ba251f060aa9179ba2ad9d20c7058ff.camel@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <afd952bc8ba251f060aa9179ba2ad9d20c7058ff.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1700070969-37yYsk_MJVVR
X-MDID-O: us5;ut7;1700070969;37yYsk_MJVVR;<greearb@candelatech.com>;c4cb9ae18b457cd2373b30bda2d9c03e
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

On 11/15/23 09:01, Greenman, Gregory wrote:
> Hi,
> 
> This contains some new and updated firmwares for all our currently
> maintained FW binaries.
> 
> Please pull or let me know if there are any issues.
> 
> Thanks,
> Gregory
> 
> The following changes since commit b72eeb603950f39f320c8113e56d69cbcfe2cb44:
> 
>    Merge branch 'mlimonci/robot-pr-improvements' into 'main' (2023-11-14 12:40:38 +0000)
> 
> are available in the Git repository at:
> 
>    http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2023-11-15
> 
> for you to fetch changes up to a07fd0b96b5adfb6614f11ca0bdb5a7f5b40410e:
> 
>    iwlwifi: add new FWs from core83-55 release (2023-11-15 18:30:59 +0200)

Hello Gregory,

I pulled this in, and be200 radios won't show up at all in 6.7.0-rc1+.
Any idea why it is crashing?

Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: SecBoot CPU1 Status: 0x0, CPU2 Status: 0x3030801
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: WFPM_LMAC1_PD_NOTIFICATION: 0x1f
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: HPM_SECONDARY_DEVICE_STATE: 0x42
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: WFPM_MAC_OTP_CFG7_ADDR: 0x0
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: WFPM_MAC_OTP_CFG7_DATA: 0x0
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: UMAC CURRENT PC: 0xd05c18
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: LMAC1 CURRENT PC: 0xd05c20
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: LMAC2 CURRENT PC: 0xd05c24
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: UMAC CURRENT PC 1: 0xd05c1c
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: TCM1 CURRENT PC: 0xa0444c
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: RCM1 CURRENT PC: 0xa0bd7c
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: RCM2 CURRENT PC: 0xb0bd7c
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: Start IWL Error Log Dump:
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: Transport status: 0x00000042, valid: -361012315
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: Loaded firmware version: 86.fb5c9aeb.0 gl-c0-fm-c0-86.ucode
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x9CFFE87D | ADVANCED_SYSASSERT
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xFBE2A7E3 | trm_hw_status0
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xFA31DD24 | trm_hw_status1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x899B976B | branchlink2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x3F621680 | interruptlink1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x3FD9F4FA | interruptlink2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xCB4BE7BF | data1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x41A76897 | data2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x7F794B75 | data3
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xBA79FAAF | beacon time
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x3E667332 | tsf low
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xFFC64F5D | tsf hi
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x511B0B3A | time gp1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xB5E28DE7 | time gp2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xDB71D9EF | uCode revision type
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xB697BD9B | uCode version major
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xBAAFE1D3 | uCode version minor
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x6716BFB4 | hw version
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xE9B6F5EE | board version
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xAB5A0C95 | hcmd
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xF142B6A2 | isr0
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x394E81C3 | isr1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xB9CBDD57 | isr2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x8C0F127E | isr3
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xE6DBFA77 | isr4
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x9C8CC6F5 | last cmd Id
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xB0C23849 | wait_event
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xA4FC5D79 | l2p_control
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xEB0482FE | l2p_duration
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x2241496C | l2p_mhvalid
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xCDF35F10 | l2p_addr_match
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x63A6A1EC | lmpm_pmg_sel
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xE7764B5E | timestamp
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xD83847CA | flow_handler
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: Start IWL Error Log Dump:
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: Transport status: 0x00000042, valid: 1628936561
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: Loaded firmware version: 86.fb5c9aeb.0 gl-c0-fm-c0-86.ucode
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x7B93D9EB | ADVANCED_SYSASSERT
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xBFFDDFF6 | trm_hw_status0
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x77E239E5 | trm_hw_status1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xF178C25A | branchlink2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x55EF45DB | interruptlink1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xFE78519C | interruptlink2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x2CCD4134 | data1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xB2DFD8BB | data2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xECDFD1B4 | data3
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x6FB78D91 | beacon time
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x59EFB7A5 | tsf low
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xFE87F56F | tsf hi
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x27DFBFD2 | time gp1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x166C5566 | time gp2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xCA9F89F8 | uCode revision type
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x56B5F8F5 | uCode version major
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xFDFB4F28 | uCode version minor
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xDF5DD37B | hw version
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x57C1E5FC | board version
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xBD8F6070 | hcmd
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xDF4E34B6 | isr0
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x7017E05B | isr1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x3C72CAA3 | isr2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xDAD0C491 | isr3
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x3728314E | isr4
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x428826B3 | last cmd Id
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x1CBE8239 | wait_event
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xC15CEF9E | l2p_control
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x0563B5F9 | l2p_duration
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xEF3772E6 | l2p_mhvalid
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xE5F433B8 | l2p_addr_match
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x3E32F6EE | lmpm_pmg_sel
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xC36A8740 | timestamp
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xD96B0470 | flow_handler
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: Start IWL Error Log Dump:
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: Transport status: 0x00000042, valid: -1203348495
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xDA093F97 | ADVANCED_SYSASSERT
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xA1CE845A | umac branchlink1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x8BAE7992 | umac branchlink2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x718D87AC | umac interruptlink1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xF4AB8FDA | umac interruptlink2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x0BDEE797 | umac data1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x6F7F47FB | umac data2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xBD4532C9 | umac data3
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x34304D3E | umac major
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xAD70F50C | umac minor
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x862DB89F | frame pointer
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x2667CBF5 | stack pointer
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x3BB5F349 | last host cmd
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xF92CA34F | isr status reg
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: TCM1 status:
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xCF111A8A | error ID
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xD04E4E50 | tcm branchlink2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x14FB65E4 | tcm interruptlink1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x44FBB630 | tcm interruptlink2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x962CC032 | tcm data1
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xBEF74559 | tcm data2
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x622F526A | tcm data3
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x11241DE3 | tcm log PC
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x1909F794 | tcm frame pointer
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x6F9EB6B6 | tcm stack pointer
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xDBE6FEC7 | tcm msg ID
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xD11EFF6F | tcm ISR status
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xD7E5B37D | tcm HW status[0]
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x77CE2E12 | tcm HW status[1]
Nov 15 09:51:22 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x5DF53958 | tcm HW status[2]
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xF5B858AE | tcm HW status[3]
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x71AE351E | tcm HW status[4]
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x41A832BF | tcm SW status[0]
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: RCM1 status:
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x59A3F87F | error ID
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x6DACF3BB | rcm branchlink2
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xF9DE7149 | rcm interruptlink1
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x4E95CDB3 | rcm interruptlink2
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xAC9CEAC0 | rcm data1
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xE64F356A | rcm data2
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xED5251A6 | rcm data3
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x3AB5E28C | rcm log PC
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x69DD33E5 | rcm frame pointer
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x9E6DCC8F | rcm stack pointer
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xBFEDFB6F | rcm msg ID
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xDA5CEDBD | rcm ISR status
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xE16EDA7D | frame HW status
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xF39E8BD4 | LMAC-to-RCM request mbox
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xFD6DD78D | RCM-to-LMAC request mbox
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xEFADF072 | MAC header control
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xBFF9C7C8 | MAC header addr1 low
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xDF4F2E66 | MAC header info
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xD8BFEB2D | MAC header error
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: TCM2 status:
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xFD4DC881 | error ID
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x66C3DF2C | tcm branchlink2
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x2BB62F92 | tcm interruptlink1
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x86B95BAA | tcm interruptlink2
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xAB1F5FFF | tcm data1
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xAC1C4D2D | tcm data2
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x33B70847 | tcm data3
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xAC84E54A | tcm log PC
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x9F3A596B | tcm frame pointer
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x6E79C6BD | tcm stack pointer
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xE77F44D3 | tcm msg ID
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x62DFEBEC | tcm ISR status
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x653B0DF5 | tcm HW status[0]
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x44E6215D | tcm HW status[1]
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x9F2333FA | tcm HW status[2]
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xB55FDC0D | tcm HW status[3]
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xC77FD84E | tcm HW status[4]
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x2FAC9F1E | tcm SW status[0]
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: RCM2 status:
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x8729749D | error ID
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x573138F6 | rcm branchlink2
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x1C301D42 | rcm interruptlink1
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x6707808B | rcm interruptlink2
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xF7712EE2 | rcm data1
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xBB666D21 | rcm data2
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x148B9A5C | rcm data3
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xFC42DB2F | rcm log PC
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x497236B7 | rcm frame pointer
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x2AA930BF | rcm stack pointer
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x05D787F4 | rcm msg ID
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x808EC1AF | rcm ISR status
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x874DF475 | frame HW status
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xB0D521F6 | LMAC-to-RCM request mbox
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x9E88267F | RCM-to-LMAC request mbox
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x979E7D4E | MAC header control
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x1871EB46 | MAC header addr1 low
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xC65FFC5E | MAC header info
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x57BD5E63 | MAC header error
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: IML/ROM dump:
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x0303 | IML/ROM SYSASSERT
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x03030801 | IML/ROM error/state
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x00000000 | IML/ROM data1
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: Fseq Registers:
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xDE23DB5D | FSEQ_ERROR_CODE
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x8E66CE00 | FSEQ_ALIVE_TOKEN
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x71A974DF | FSEQ_CNVI_ID
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xF97001B4 | FSEQ_CNVR_ID
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x00001041 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x000EAB83 | FSEQ_PREV_CNVIO_INIT_VERSION
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x9DF94CAD | FSEQ_WIFI_FSEQ_VERSION
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xFF12475A | FSEQ_BT_FSEQ_VERSION
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0xCF778FE3 | FSEQ_CLASS_TP_VERSION
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: UMAC CURRENT PC: 0xc00c040e
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: LMAC1 CURRENT PC: 0x0
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: LMAC2 CURRENT PC: 0x0
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: UMAC CURRENT PC 1: 0xc00c040c
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: TCM1 CURRENT PC: 0x0
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: RCM1 CURRENT PC: 0x0
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: RCM2 CURRENT PC: 0x0
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: Function Scratch status:
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: 0x01010101 | Func Scratch
Nov 15 09:51:23 ct523c-2103 kernel: iwlwifi 0000:2a:00.0: run-mvm-ucode: Failed to start RT ucode: -110

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



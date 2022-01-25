Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70149BF5F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 00:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiAYXIv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 18:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiAYXIu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 18:08:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C30C06161C
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jan 2022 15:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=x/yB+MHtVpE0KpIqiH7kgMikyuutK4Wyhnic00YJ/IY=; b=VRcGVX0YarlHF3LT5LXnvCMj6a
        V45rNBDZSOwbXVaLC0ReQ/O33FRDl+yVsViGuiuaPkRChBHByUJ76rqqLGd7rsQjOk+QL9cNcluUF
        WoQhxa9n5pS5jKrLNbQhOrZdkbuJFq3KSRL/aWaV3OX9DaXEgez30gOs2rWp72HZ3K8vdEvCKNe4w
        7SkNwvi3s2O8UIm0TiH3g8lp0YLbnZvxQYKkBc64YWOGpLKayKq3FcVw6xoICuExSjhXKzLXHypKY
        U4cdH+UzUBA0J0cRt3a5c+U+IB7mUO8hOhudPNr8sgzL+yh87VkVaAONjm+38Rx9cR73v3Mx3kMNY
        Z6twV+SQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCUvf-003UG2-0n; Tue, 25 Jan 2022 23:08:47 +0000
Message-ID: <92b00b94-aff6-8108-06d1-932b77f9d218@infradead.org>
Date:   Tue, 25 Jan 2022 15:08:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: iwlwifi problems, maybe firmware related?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

When I boot 5.16 or 5.17-rc1, I get messages like:

iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.37
iwlwifi 0000:00:14.3: loaded firmware version 67.8f59b80b.0 QuZ-a0-hr-b0-67.ucode op_mode iwlmvm

iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201 160MHz, REV=0x354
iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
iwlwifi 0000:00:14.3: base HW address: bc:09:1b:5f:30:25

wlan0: authenticate with d4:b9:2f:7c:10:db
wlan0: send auth to d4:b9:2f:7c:10:db (try 1/3)
wlan0: authenticated
wlan0: associate with d4:b9:2f:7c:10:db (try 1/3)
wlan0: RX AssocResp from d4:b9:2f:7c:10:db (capab=0x1511 status=0 aid=2)
iwlwifi 0000:00:14.3: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
iwlwifi 0000:00:14.3: Loaded firmware version: 67.8f59b80b.0 QuZ-a0-hr-b0-67.ucode
iwlwifi 0000:00:14.3: 0x00001062 | ADVANCED_SYSASSERT          
iwlwifi 0000:00:14.3: 0x0080A212 | trm_hw_status0
iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
iwlwifi 0000:00:14.3: 0x004CB2DE | branchlink2
iwlwifi 0000:00:14.3: 0x000018DC | interruptlink1
iwlwifi 0000:00:14.3: 0x000018DC | interruptlink2
iwlwifi 0000:00:14.3: 0x00000000 | data1
iwlwifi 0000:00:14.3: 0x00000001 | data2
iwlwifi 0000:00:14.3: 0xDEADBEEF | data3
iwlwifi 0000:00:14.3: 0x000AB296 | beacon time
iwlwifi 0000:00:14.3: 0x959B1740 | tsf low
iwlwifi 0000:00:14.3: 0x000000AC | tsf hi
iwlwifi 0000:00:14.3: 0x00000000 | time gp1
iwlwifi 0000:00:14.3: 0x00386026 | time gp2
iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
iwlwifi 0000:00:14.3: 0x00000043 | uCode version major
iwlwifi 0000:00:14.3: 0x8F59B80B | uCode version minor
iwlwifi 0000:00:14.3: 0x00000351 | hw version
iwlwifi 0000:00:14.3: 0x18489004 | board version
iwlwifi 0000:00:14.3: 0x8068FC32 | hcmd
iwlwifi 0000:00:14.3: 0x26620000 | isr0
iwlwifi 0000:00:14.3: 0x01000000 | isr1
iwlwifi 0000:00:14.3: 0x08B00002 | isr2
iwlwifi 0000:00:14.3: 0x00C34008 | isr3
iwlwifi 0000:00:14.3: 0x00000000 | isr4
iwlwifi 0000:00:14.3: 0x0035019C | last cmd Id
iwlwifi 0000:00:14.3: 0x0000B2C8 | wait_event
iwlwifi 0000:00:14.3: 0x00000080 | l2p_control
iwlwifi 0000:00:14.3: 0x00001C20 | l2p_duration
iwlwifi 0000:00:14.3: 0x0000003F | l2p_mhvalid
iwlwifi 0000:00:14.3: 0x00000080 | l2p_addr_match
iwlwifi 0000:00:14.3: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:00:14.3: 0x00000000 | timestamp
iwlwifi 0000:00:14.3: 0x000098E4 | flow_handler
iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
iwlwifi 0000:00:14.3: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
iwlwifi 0000:00:14.3: 0x80455E52 | umac branchlink2
iwlwifi 0000:00:14.3: 0x010332C0 | umac interruptlink1
iwlwifi 0000:00:14.3: 0xC0081AC6 | umac interruptlink2
iwlwifi 0000:00:14.3: 0x00000400 | umac data1
iwlwifi 0000:00:14.3: 0xC0081AC6 | umac data2
iwlwifi 0000:00:14.3: 0x00000000 | umac data3
iwlwifi 0000:00:14.3: 0x00000043 | umac major
iwlwifi 0000:00:14.3: 0x8F59B80B | umac minor
iwlwifi 0000:00:14.3: 0x0038604B | frame pointer
iwlwifi 0000:00:14.3: 0xC088750C | stack pointer
iwlwifi 0000:00:14.3: 0x003901A9 | last host cmd
iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
iwlwifi 0000:00:14.3: IML/ROM dump:
iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
iwlwifi 0000:00:14.3: 0x00005A13 | IML/ROM data1
iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
iwlwifi 0000:00:14.3: Fseq Registers:
iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
iwlwifi 0000:00:14.3: 0x80290033 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:00:14.3: 0x00090006 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
iwlwifi 0000:00:14.3: 0x01300504 | FSEQ_CNVR_ID
iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:00:14.3: 0x01300504 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:00:14.3: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:00:14.3: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
ieee80211 phy0: Hardware restart was requested
iwlwifi 0000:00:14.3: FW error in SYNC CMD PHY_CONTEXT_CMD
CPU: 2 PID: 129 Comm: kworker/u16:3 Not tainted 5.16.0 #8
Hardware name: Dell Inc. Inspiron 15 5510/076F7Y, BIOS 2.4.1 11/05/2021
Workqueue: phy0 ieee80211_iface_work [mac80211]

iwlwifi 0000:00:14.3: PHY ctxt cmd error. ret=-5
wlan0: associated
iwlwifi 0000:00:14.3: Microcode SW error detected. Restarting 0x0.



Can anyone tell what's going on here?
Is it just firmware version problem?
Any suggestions/ideas?


This is openSUSE Tumbleweed (rolling updates) on a Dell Inspiron 15.
I don't know how new or old this problem is since I just got the laptop
and I haven't used anything older on it.

thanks.
-- 
~Randy

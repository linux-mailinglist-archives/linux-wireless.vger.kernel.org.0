Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377375049ED
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Apr 2022 01:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiDQXFP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Apr 2022 19:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiDQXFG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Apr 2022 19:05:06 -0400
X-Greylist: delayed 407 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Apr 2022 16:02:28 PDT
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C64186DF
        for <linux-wireless@vger.kernel.org>; Sun, 17 Apr 2022 16:02:27 -0700 (PDT)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4KhQQH49Hcz10wt
        for <linux-wireless@vger.kernel.org>; Sun, 17 Apr 2022 22:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
        s=stigmate; t=1650236135;
        bh=hTjQ2OBwytQSgOzaE5Iyglzt7Ylt9xF/OgFi1mttji8=;
        h=Subject:From:To:Date:From;
        b=EXbjw1GEkDmUJrFNwAxfhR3oEA3tK31lQp0a4fYl1hN0YIWfjWfxBZ9VukQsJAWAD
         ymIMbk0vW7KgHBiBBA8y3DDa7hzN8xhiBVS6j6LuQ5EIakSXKK+to0ZFADwHb/MhdQ
         YRShANBRl4GaqoAyNFubJzTyb500l63gVzU+J4nE=
Received: from [93.190.126.19] (mx1.investici.org [93.190.126.19]) (Authenticated sender: kitestramuort@autistici.org) by localhost (Postfix) with ESMTPSA id 4KhQQH32yqz10wg
        for <linux-wireless@vger.kernel.org>; Sun, 17 Apr 2022 22:55:35 +0000 (UTC)
Message-ID: <63741bd20284a108454625bc322b46e4d10b1735.camel@autistici.org>
Subject: iwlwifi crash with 5.18
From:   kitestramuort <kitestramuort@autistici.org>
To:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Apr 2022 23:55:34 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AX210 card, iwlwifi compiled into the kernel, firmware (69 or 71)
crashes systematically on boot. Still there in rc3. All good on 5.17

 iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
 iwlwifi 0000:01:00.0: Direct firmware load for iwlwifi-ty-a0-gf-a0-
72.ucode failed with error -2
 iwlwifi 0000:01:00.0: api flags index 2 larger than supported by
driver
 iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.36
 iwlwifi 0000:01:00.0: loaded firmware version 71.058653f6.0 ty-a0-gf-
a0-71.ucode op_mode iwlmvm
 iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz,
REV=3D0x420
 iwlwifi 0000:01:00.0: Allocated 0x04000000 bytes for firmware monitor.
 iwlwifi 0000:01:00.0: SecBoot CPU1 Status: 0x8d71, CPU2 Status: 0xb03
 iwlwifi 0000:01:00.0: WFPM_LMAC1_PD_NOTIFICATION: 0x1f
 iwlwifi 0000:01:00.0: HPM_SECONDARY_DEVICE_STATE: 0x42
 iwlwifi 0000:01:00.0: UMAC PC: 0x8047e2d8
 iwlwifi 0000:01:00.0: LMAC PC: 0x0
 iwlwifi 0000:01:00.0: Collecting data: trigger 15 fired.
 iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-
a0-71.ucode
 iwlwifi 0000:01:00.0: 0x00000000 | ADVANCED_SYSASSERT         =20
 iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status0
 iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
 iwlwifi 0000:01:00.0: 0x00000000 | branchlink2
 iwlwifi 0000:01:00.0: 0x00000000 | interruptlink1
 iwlwifi 0000:01:00.0: 0x00000000 | interruptlink2
 iwlwifi 0000:01:00.0: 0x00000000 | data1
 iwlwifi 0000:01:00.0: 0x00000000 | data2
 iwlwifi 0000:01:00.0: 0x00000000 | data3
 iwlwifi 0000:01:00.0: 0x00000000 | beacon time
 iwlwifi 0000:01:00.0: 0x00000000 | tsf low
 iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
 iwlwifi 0000:01:00.0: 0x00000000 | time gp1
 iwlwifi 0000:01:00.0: 0x00000000 | time gp2
 iwlwifi 0000:01:00.0: 0x00000000 | uCode revision type
 iwlwifi 0000:01:00.0: 0x00000000 | uCode version major
 iwlwifi 0000:01:00.0: 0x00000000 | uCode version minor
 iwlwifi 0000:01:00.0: 0x00000000 | hw version
 iwlwifi 0000:01:00.0: 0x00000000 | board version
 iwlwifi 0000:01:00.0: 0x00000000 | hcmd
 iwlwifi 0000:01:00.0: 0x00000000 | isr0
 iwlwifi 0000:01:00.0: 0x00000000 | isr1
 iwlwifi 0000:01:00.0: 0x00000000 | isr2
 iwlwifi 0000:01:00.0: 0x00000000 | isr3
 iwlwifi 0000:01:00.0: 0x00000000 | isr4
 iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
 iwlwifi 0000:01:00.0: 0x00000000 | wait_event
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
 iwlwifi 0000:01:00.0: 0x00000000 | lmpm_pmg_sel
 iwlwifi 0000:01:00.0: 0x00000000 | timestamp
 iwlwifi 0000:01:00.0: 0x00000000 | flow_handler
 iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
 iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
 iwlwifi 0000:01:00.0: 0x2010210B | ADVANCED_SYSASSERT
 iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
 iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
 iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink1
 iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
 iwlwifi 0000:01:00.0: 0x00000000 | umac data1
 iwlwifi 0000:01:00.0: 0x00000000 | umac data2
 iwlwifi 0000:01:00.0: 0x04000000 | umac data3
 iwlwifi 0000:01:00.0: 0x00000047 | umac major
 iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
 iwlwifi 0000:01:00.0: 0x00015BC5 | frame pointer
 iwlwifi 0000:01:00.0: 0xC0887E28 | stack pointer
 iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
 iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
 iwlwifi 0000:01:00.0: IML/ROM dump:
 iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
 iwlwifi 0000:01:00.0: 0x00008D71 | IML/ROM data1
 iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
 iwlwifi 0000:01:00.0: Fseq Registers:
 iwlwifi 0000:01:00.0: 0x20000000 | FSEQ_ERROR_CODE
 iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
 iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
 iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
 iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
 iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
 iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
 iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
 iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
 iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
 iwlwifi 0000:01:00.0: 0x00009061 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
 iwlwifi 0000:01:00.0: 0x00000061 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
 iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
 iwlwifi 0000:01:00.0: Collecting data: trigger 16 fired.
 iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
 iwlwifi 0000:01:00.0: retry init count 0
 iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz,
REV=3D0x420
 iwlwifi 0000:01:00.0: SecBoot CPU1 Status: 0x8d70, CPU2 Status: 0xb03
 iwlwifi 0000:01:00.0: WFPM_LMAC1_PD_NOTIFICATION: 0x1f
 iwlwifi 0000:01:00.0: HPM_SECONDARY_DEVICE_STATE: 0x42
 iwlwifi 0000:01:00.0: UMAC PC: 0x8047e2d8
 iwlwifi 0000:01:00.0: LMAC PC: 0x0
 iwlwifi 0000:01:00.0: Collecting data: trigger 15 fired.
 iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-
a0-71.ucode
 iwlwifi 0000:01:00.0: 0x00000000 | ADVANCED_SYSASSERT         =20
 iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status0
 iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
 iwlwifi 0000:01:00.0: 0x00000000 | branchlink2
 iwlwifi 0000:01:00.0: 0x00000000 | interruptlink1
 iwlwifi 0000:01:00.0: 0x00000000 | interruptlink2
 iwlwifi 0000:01:00.0: 0x00000000 | data1
 iwlwifi 0000:01:00.0: 0x00000000 | data2
 iwlwifi 0000:01:00.0: 0x00000000 | data3
 iwlwifi 0000:01:00.0: 0x00000000 | beacon time
 iwlwifi 0000:01:00.0: 0x00000000 | tsf low
 iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
 iwlwifi 0000:01:00.0: 0x00000000 | time gp1
 iwlwifi 0000:01:00.0: 0x00000000 | time gp2
 iwlwifi 0000:01:00.0: 0x00000000 | uCode revision type
 iwlwifi 0000:01:00.0: 0x00000000 | uCode version major
 iwlwifi 0000:01:00.0: 0x00000000 | uCode version minor
 iwlwifi 0000:01:00.0: 0x00000000 | hw version
 iwlwifi 0000:01:00.0: 0x00000000 | board version
 iwlwifi 0000:01:00.0: 0x00000000 | hcmd
 iwlwifi 0000:01:00.0: 0x00000000 | isr0
 iwlwifi 0000:01:00.0: 0x00000000 | isr1
 iwlwifi 0000:01:00.0: 0x00000000 | isr2
 iwlwifi 0000:01:00.0: 0x00000000 | isr3
 iwlwifi 0000:01:00.0: 0x00000000 | isr4
 iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
 iwlwifi 0000:01:00.0: 0x00000000 | wait_event
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
 iwlwifi 0000:01:00.0: 0x00000000 | lmpm_pmg_sel
 iwlwifi 0000:01:00.0: 0x00000000 | timestamp
 iwlwifi 0000:01:00.0: 0x00000000 | flow_handler
 iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
 iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
 iwlwifi 0000:01:00.0: 0x2010210B | ADVANCED_SYSASSERT
 iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
 iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
 iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink1
 iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
 iwlwifi 0000:01:00.0: 0x00000000 | umac data1
 iwlwifi 0000:01:00.0: 0x00000000 | umac data2
 iwlwifi 0000:01:00.0: 0x04000000 | umac data3
 iwlwifi 0000:01:00.0: 0x00000047 | umac major
 iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
 iwlwifi 0000:01:00.0: 0x00015AEB | frame pointer
 iwlwifi 0000:01:00.0: 0xC0887E28 | stack pointer
 iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
 iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
 iwlwifi 0000:01:00.0: IML/ROM dump:
 iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
 iwlwifi 0000:01:00.0: 0x00008D70 | IML/ROM data1
 iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
 iwlwifi 0000:01:00.0: Fseq Registers:
 iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
 iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
 iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
 iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
 iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
 iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
 iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
 iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
 iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
 iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
 iwlwifi 0000:01:00.0: 0x00009061 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
 iwlwifi 0000:01:00.0: 0x00000061 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
 iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
 iwlwifi 0000:01:00.0: Collecting data: trigger 16 fired.
 iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
 iwlwifi 0000:01:00.0: retry init count 1
 iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz,
REV=3D0x420
 iwlwifi 0000:01:00.0: SecBoot CPU1 Status: 0x8d3e, CPU2 Status: 0xb03
 iwlwifi 0000:01:00.0: WFPM_LMAC1_PD_NOTIFICATION: 0x1f
 iwlwifi 0000:01:00.0: HPM_SECONDARY_DEVICE_STATE: 0x42
 iwlwifi 0000:01:00.0: UMAC PC: 0x8047e2d8
 iwlwifi 0000:01:00.0: LMAC PC: 0x0
 iwlwifi 0000:01:00.0: Collecting data: trigger 15 fired.
 iwlwifi 0000:01:00.0: Loaded firmware version: 71.058653f6.0 ty-a0-gf-
a0-71.ucode
 iwlwifi 0000:01:00.0: 0x00000000 | ADVANCED_SYSASSERT         =20
 iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status0
 iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
 iwlwifi 0000:01:00.0: 0x00000000 | branchlink2
 iwlwifi 0000:01:00.0: 0x00000000 | interruptlink1
 iwlwifi 0000:01:00.0: 0x00000000 | interruptlink2
 iwlwifi 0000:01:00.0: 0x00000000 | data1
 iwlwifi 0000:01:00.0: 0x00000000 | data2
 iwlwifi 0000:01:00.0: 0x00000000 | data3
 iwlwifi 0000:01:00.0: 0x00000000 | beacon time
 iwlwifi 0000:01:00.0: 0x00000000 | tsf low
 iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
 iwlwifi 0000:01:00.0: 0x00000000 | time gp1
 iwlwifi 0000:01:00.0: 0x00000000 | time gp2
 iwlwifi 0000:01:00.0: 0x00000000 | uCode revision type
 iwlwifi 0000:01:00.0: 0x00000000 | uCode version major
 iwlwifi 0000:01:00.0: 0x00000000 | uCode version minor
 iwlwifi 0000:01:00.0: 0x00000000 | hw version
 iwlwifi 0000:01:00.0: 0x00000000 | board version
 iwlwifi 0000:01:00.0: 0x00000000 | hcmd
 iwlwifi 0000:01:00.0: 0x00000000 | isr0
 iwlwifi 0000:01:00.0: 0x00000000 | isr1
 iwlwifi 0000:01:00.0: 0x00000000 | isr2
 iwlwifi 0000:01:00.0: 0x00000000 | isr3
 iwlwifi 0000:01:00.0: 0x00000000 | isr4
 iwlwifi 0000:01:00.0: 0x00000000 | last cmd Id
 iwlwifi 0000:01:00.0: 0x00000000 | wait_event
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
 iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
 iwlwifi 0000:01:00.0: 0x00000000 | lmpm_pmg_sel
 iwlwifi 0000:01:00.0: 0x00000000 | timestamp
 iwlwifi 0000:01:00.0: 0x00000000 | flow_handler
 iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
 iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
 iwlwifi 0000:01:00.0: 0x2010210B | ADVANCED_SYSASSERT
 iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
 iwlwifi 0000:01:00.0: 0x8045EFDC | umac branchlink2
 iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink1
 iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
 iwlwifi 0000:01:00.0: 0x00000000 | umac data1
 iwlwifi 0000:01:00.0: 0x00000000 | umac data2
 iwlwifi 0000:01:00.0: 0x04000000 | umac data3
 iwlwifi 0000:01:00.0: 0x00000047 | umac major
 iwlwifi 0000:01:00.0: 0x058653F6 | umac minor
 iwlwifi 0000:01:00.0: 0x00015AB8 | frame pointer
 iwlwifi 0000:01:00.0: 0xC0887E28 | stack pointer
 iwlwifi 0000:01:00.0: 0x00000000 | last host cmd
 iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
 iwlwifi 0000:01:00.0: IML/ROM dump:
 iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
 iwlwifi 0000:01:00.0: 0x00008D3E | IML/ROM data1
 iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
 iwlwifi 0000:01:00.0: Fseq Registers:
 iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
 iwlwifi 0000:01:00.0: 0x80440005 | FSEQ_TOP_INIT_VERSION
 iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
 iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
 iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
 iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
 iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
 iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
 iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
 iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
 iwlwifi 0000:01:00.0: 0x00009061 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
 iwlwifi 0000:01:00.0: 0x00000061 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
 iwlwifi 0000:01:00.0: Failed to start RT ucode: -110
 iwlwifi 0000:01:00.0: Collecting data: trigger 16 fired.
 iwlwifi 0000:01:00.0: Failed to run INIT ucode: -110
 iwlwifi 0000:01:00.0: retry init count 2

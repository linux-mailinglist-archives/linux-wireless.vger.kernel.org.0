Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94356F2036
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 23:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjD1Vm7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 17:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjD1Vm6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 17:42:58 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1123A26AF
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 14:42:57 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D39BD340067
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 21:42:54 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3AAB013C2B0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 14:42:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3AAB013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1682718174;
        bh=Cog2Db6CxdZiGIxLN9VNc1J/Aa7hLiHl6MP1J1mi3bg=;
        h=Date:To:From:Subject:From;
        b=sK2Tgcg9Sr/22+wQyPzsd7HOTph28R+MNdnobG2FqpHRejfOoLrufgLL10i5en6Uo
         OrDpyjgH0fsM1kvyz+ZIonRPdxrjddEPnxU3A5m04+fTAE/rZD8FtQzAL9gc09u85I
         s9vug4iI7bYgLbFoHmt9J7ii6LrDPngRkCXSXkAY=
Message-ID: <a558d27a-33ef-6c75-0552-03772ccfbe5f@candelatech.com>
Date:   Fri, 28 Apr 2023 14:42:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax210 fw v78 crash in 6.4-ish kernel.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1682718175-cmWD4iZevOgp
X-MDID-O: us5;at1;1682718175;cmWD4iZevOgp;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I saw this in kernel based on recent Linus tree:

[  154.760738] iwlwifi 0000:0c:00.0: Microcode SW error detected. Restarting 0x2.
[  154.766812] iwlwifi 0000:0c:00.0: Start IWL Error Log Dump:
[  154.771123] iwlwifi 0000:0c:00.0: Transport status: 0x0000004B, valid: 6
[  154.776564] iwlwifi 0000:0c:00.0: Loaded firmware version: 78.3bfdc55f.0 ty-a0-gf-a0-78.ucode
[  154.783811] iwlwifi 0000:0c:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
[  154.789485] iwlwifi 0000:0c:00.0: 0x00808203 | trm_hw_status0
[  154.793954] iwlwifi 0000:0c:00.0: 0x00000000 | trm_hw_status1
[  154.798427] iwlwifi 0000:0c:00.0: 0x004DC220 | branchlink2
[  154.802623] iwlwifi 0000:0c:00.0: 0x000088B8 | interruptlink1
[  154.807108] iwlwifi 0000:0c:00.0: 0x000088B8 | interruptlink2
[  154.811568] iwlwifi 0000:0c:00.0: 0x00016AEC | data1
[  154.815257] iwlwifi 0000:0c:00.0: 0x00000010 | data2
[  154.818949] iwlwifi 0000:0c:00.0: 0x00000000 | data3
[  154.822656] iwlwifi 0000:0c:00.0: 0x41817919 | beacon time
[  154.826873] iwlwifi 0000:0c:00.0: 0x7E3EA72C | tsf low
[  154.830722] iwlwifi 0000:0c:00.0: 0x00000003 | tsf hi
[  154.834492] iwlwifi 0000:0c:00.0: 0x00000000 | time gp1
[  154.838446] iwlwifi 0000:0c:00.0: 0x01CE3A83 | time gp2
[  154.842385] iwlwifi 0000:0c:00.0: 0x00000001 | uCode revision type
[  154.847273] iwlwifi 0000:0c:00.0: 0x0000004E | uCode version major
[  154.852165] iwlwifi 0000:0c:00.0: 0x3BFDC55F | uCode version minor
[  154.857090] iwlwifi 0000:0c:00.0: 0x00000420 | hw version
[  154.861201] iwlwifi 0000:0c:00.0: 0x00C80002 | board version
[  154.865594] iwlwifi 0000:0c:00.0: 0x806EF400 | hcmd
[  154.869182] iwlwifi 0000:0c:00.0: 0xE6F4B610 | isr0
[  154.872785] iwlwifi 0000:0c:00.0: 0x01448000 | isr1
[  154.876378] iwlwifi 0000:0c:00.0: 0x40F8011A | isr2
[  154.879994] iwlwifi 0000:0c:00.0: 0x00C00008 | isr3
[  154.883611] iwlwifi 0000:0c:00.0: 0x00200000 | isr4
[  154.887259] iwlwifi 0000:0c:00.0: 0x0311001C | last cmd Id
[  154.891459] iwlwifi 0000:0c:00.0: 0x00016AEC | wait_event
[  154.895573] iwlwifi 0000:0c:00.0: 0x00004288 | l2p_control
[  154.899806] iwlwifi 0000:0c:00.0: 0x00019C14 | l2p_duration
[  154.904092] iwlwifi 0000:0c:00.0: 0x00000000 | l2p_mhvalid
[  154.908304] iwlwifi 0000:0c:00.0: 0x00EF00F8 | l2p_addr_match
[  154.912777] iwlwifi 0000:0c:00.0: 0x00000009 | lmpm_pmg_sel
[  154.917065] iwlwifi 0000:0c:00.0: 0x00000000 | timestamp
[  154.921103] iwlwifi 0000:0c:00.0: 0x05F83838 | flow_handler
[  154.925473] iwlwifi 0000:0c:00.0: Start IWL Error Log Dump:
[  154.929778] iwlwifi 0000:0c:00.0: Transport status: 0x0000004B, valid: 7
[  154.935190] iwlwifi 0000:0c:00.0: 0x20100246 | ADVANCED_SYSASSERT
[  154.940001] iwlwifi 0000:0c:00.0: 0x00000000 | umac branchlink1
[  154.944643] iwlwifi 0000:0c:00.0: 0x8046D728 | umac branchlink2
[  154.949291] iwlwifi 0000:0c:00.0: 0x8048DB02 | umac interruptlink1
[  154.954190] iwlwifi 0000:0c:00.0: 0x00000000 | umac interruptlink2
[  154.959117] iwlwifi 0000:0c:00.0: 0xDEADBEEF | umac data1
[  154.963238] iwlwifi 0000:0c:00.0: 0xDEADBEEF | umac data2
[  154.967367] iwlwifi 0000:0c:00.0: 0xDEADBEEF | umac data3
[  154.971493] iwlwifi 0000:0c:00.0: 0x0000004E | umac major
[  154.975657] iwlwifi 0000:0c:00.0: 0x3BFDC55F | umac minor
[  154.979798] iwlwifi 0000:0c:00.0: 0x01CE3A7D | frame pointer
[  154.984177] iwlwifi 0000:0c:00.0: 0xC0887F00 | stack pointer
[  154.988574] iwlwifi 0000:0c:00.0: 0x00030303 | last host cmd
[  154.992985] iwlwifi 0000:0c:00.0: 0x00010008 | isr status reg
[  154.997471] iwlwifi 0000:0c:00.0: IML/ROM dump:
[  155.000722] iwlwifi 0000:0c:00.0: 0x00000B03 | IML/ROM error/state
[  155.005655] iwlwifi 0000:0c:00.0: 0x00007F8A | IML/ROM data1
[  155.010041] iwlwifi 0000:0c:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[  155.015285] iwlwifi 0000:0c:00.0: Fseq Registers:
[  155.018704] iwlwifi 0000:0c:00.0: 0x60000000 | FSEQ_ERROR_CODE
[  155.023255] iwlwifi 0000:0c:00.0: 0x80440006 | FSEQ_TOP_INIT_VERSION
[  155.028328] iwlwifi 0000:0c:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[  155.033572] iwlwifi 0000:0c:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[  155.038221] iwlwifi 0000:0c:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[  155.043557] iwlwifi 0000:0c:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[  155.048196] iwlwifi 0000:0c:00.0: 0x00400410 | FSEQ_CNVI_ID
[  155.052486] iwlwifi 0000:0c:00.0: 0x00400410 | FSEQ_CNVR_ID
[  155.056776] iwlwifi 0000:0c:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[  155.061611] iwlwifi 0000:0c:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[  155.066453] iwlwifi 0000:0c:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  155.073000] iwlwifi 0000:0c:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  155.079912] iwlwifi 0000:0c:00.0: UMAC CURRENT PC: 0xd05c18
[  155.084204] iwlwifi 0000:0c:00.0: LMAC1 CURRENT PC: 0xd05c1c
[  155.089017] iwlwifi 0000:0c:00.0: WRT: Collecting data: ini trigger 4 fired (delay=0ms).
[  155.089026] ieee80211 wiphy5: Hardware restart was requested
[  155.089064] iwlwifi 0000:0c:00.0: FW error in SYNC CMD UNKNOWN

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


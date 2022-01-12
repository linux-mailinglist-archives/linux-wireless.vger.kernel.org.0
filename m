Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E58548BCA4
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 02:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347954AbiALBrz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 20:47:55 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:34713 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347953AbiALBry (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 20:47:54 -0500
Received: by mail-lf1-f42.google.com with SMTP id o12so2993067lfk.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 17:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LMZv8sgbVdO3W8CddVhyQet3c8/ezPF49PxhHlNmZ+o=;
        b=em8BN5R/52VV2EJ2Cf/P5piu+zoca4HMtNOJApZY0VlYxLQKhbnjbT6Y6N+mTkS5b2
         z9cRqyJ7OYOfVuI/oYTwL6l3IRFaKXWC3mRXk7cmXRIx9u6ROUM2i+KOoGZ96Dj+JWky
         +3xIpkfO4AOnTEXTRhIQ7b3A1rExL0Ojxwb/06GNNuQUaLHJNgc90URYMPKmLQYzKSrq
         CvWALB6xDhafNPdMolkc6qNxbDnkOfCe8s4PJZm40lmJAMdHIVSdWwYOLvBB26IBidDB
         g5k9b4fERy985hXH8+FFZUHIgmDFpnNDO2mJNhGRagiR3pve8quyLru8rujP8nVsEEba
         tB8Q==
X-Gm-Message-State: AOAM532s5ORsI3DmQXsABVre/VPOPIU0c/vAGGgalgQgOUVeThRdiETs
        dg+ToLvYEPK1HUfZd5RPw3qYG5zeSxTGNscRv8byv4PBeaclrg==
X-Google-Smtp-Source: ABdhPJwszFg5DWXoui/R/9zFDP9hK+umns2yvcoCyfdH29OIoDk7wUTVfZ25rSdh07neM/j+742T8rR/Zfm1HRsukD8=
X-Received: by 2002:a19:f80d:: with SMTP id a13mr5411917lff.216.1641952072986;
 Tue, 11 Jan 2022 17:47:52 -0800 (PST)
MIME-Version: 1.0
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 11 Jan 2022 20:47:41 -0500
Message-ID: <CAJvTdKm9PQrnyEG=b-8DbdnOHup8Ec6VqoKp3ZCQXwmvXU3FbA@mail.gmail.com>
Subject: iwlwifi 0000:3a:00.0: Microcode SW error detected. Restarting 0x2000000.
To:     Luca Coelho <luciano.coelho@intel.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have a Dell XPS 13 9360 with a this Intel wifi card:

iwlwifi 0000:3a:00.0: Detected Intel(R) Dual Band Wireless AC 3160, REV=0x164

(Note that this laptop did not originally ship with this card.
 It shipped with a card from another vendor  that was so
 unreliable for suspend/resume endurance testing that I had to replace it.
 And until now, this Intel card has been performing well)

I recently installed Fedora 35, and the card worked fine.
But when I built and booted a 5.15 or 5.16 upstream kernel from src,
the card fails at initialization and I've not found a way to revive it.
(dmesg below)

Since the word "Microcode" was involved, I feared there was some
mis-match between Fedora and upstream.  So I installed Ubuntu 21.10 --
but the same thing happened.  wifi worked for the Ubuntu kernel, but
not for an upstream 5.16 kernel.

(I use a config that starts with the distro config, and is updated
with a "make localmodconfig", any any other tweaks to turn off
distro-specific stuff that doesn't build upstream)

Is this a known problem (with a known solution?)

thanks,
Len Brown, Intel Open Source Technology Center

lenb@lenb-Dell-XPS-13-9360:~$ grep iwlwifi dmesg.ubuntu
[    2.018698] iwlwifi 0000:3a:00.0: enabling device (0000 -> 0002)
[    2.035549] iwlwifi 0000:3a:00.0: loaded firmware version
17.3216344376.0 3160-17.ucode op_mode iwlmvm
[    2.118226] iwlwifi 0000:3a:00.0: Detected Intel(R) Dual Band
Wireless AC 3160, REV=0x164
[    2.144883] iwlwifi 0000:3a:00.0: base HW address: e4:02:9b:c0:4d:f1
[    3.049603] iwlwifi 0000:3a:00.0 wlp58s0: renamed from wlan0
[   11.406530] iwlwifi 0000:3a:00.0: Microcode SW error detected.
Restarting 0x2000000.
[   11.408338] iwlwifi 0000:3a:00.0: Start IWL Error Log Dump:
[   11.409829] iwlwifi 0000:3a:00.0: Transport status: 0x0000004B, valid: 6
[   11.411533] iwlwifi 0000:3a:00.0: Loaded firmware version:
17.3216344376.0 3160-17.ucode
[   11.412815] iwlwifi 0000:3a:00.0: 0x00000038 | BAD_COMMAND
[   11.414597] iwlwifi 0000:3a:00.0: 0x000002F0 | trm_hw_status0
[   11.416155] iwlwifi 0000:3a:00.0: 0x00000000 | trm_hw_status1
[   11.417542] iwlwifi 0000:3a:00.0: 0x00000B30 | branchlink2
[   11.419140] iwlwifi 0000:3a:00.0: 0x00014908 | interruptlink1
[   11.420414] iwlwifi 0000:3a:00.0: 0x00000000 | interruptlink2
[   11.421799] iwlwifi 0000:3a:00.0: 0xDEADBEEF | data1
[   11.424074] iwlwifi 0000:3a:00.0: 0xDEADBEEF | data2
[   11.425305] iwlwifi 0000:3a:00.0: 0xDEADBEEF | data3
[   11.427531] iwlwifi 0000:3a:00.0: 0x003FE220 | beacon time
[   11.429713] iwlwifi 0000:3a:00.0: 0x00001DDE | tsf low
[   11.432221] iwlwifi 0000:3a:00.0: 0x00000000 | tsf hi
[   11.434755] iwlwifi 0000:3a:00.0: 0x00000000 | time gp1
[   11.437282] iwlwifi 0000:3a:00.0: 0x00001DE0 | time gp2
[   11.439847] iwlwifi 0000:3a:00.0: 0x00000000 | uCode revision type
[   11.441340] iwlwifi 0000:3a:00.0: 0x00000011 | uCode version major
[   11.443347] iwlwifi 0000:3a:00.0: 0xBFB58538 | uCode version minor
[   11.445820] iwlwifi 0000:3a:00.0: 0x00000164 | hw version
[   11.448265] iwlwifi 0000:3a:00.0: 0x00C89204 | board version
[   11.450758] iwlwifi 0000:3a:00.0: 0x001E0405 | hcmd
[   11.453217] iwlwifi 0000:3a:00.0: 0x00022080 | isr0
[   11.455648] iwlwifi 0000:3a:00.0: 0x00000000 | isr1
[   11.458300] iwlwifi 0000:3a:00.0: 0x00000002 | isr2
[   11.460747] iwlwifi 0000:3a:00.0: 0x004000C0 | isr3
[   11.463125] iwlwifi 0000:3a:00.0: 0x00000000 | isr4
[   11.465510] iwlwifi 0000:3a:00.0: 0x01000112 | last cmd Id
[   11.467867] iwlwifi 0000:3a:00.0: 0x00000000 | wait_event
[   11.470215] iwlwifi 0000:3a:00.0: 0x000000D4 | l2p_control
[   11.472553] iwlwifi 0000:3a:00.0: 0x00000000 | l2p_duration
[   11.474865] iwlwifi 0000:3a:00.0: 0x00000000 | l2p_mhvalid
[   11.477236] iwlwifi 0000:3a:00.0: 0x00000000 | l2p_addr_match
[   11.479364] iwlwifi 0000:3a:00.0: 0x00000007 | lmpm_pmg_sel
[   11.481481] iwlwifi 0000:3a:00.0: 0x15041745 | timestamp
[   11.483595] iwlwifi 0000:3a:00.0: 0x00001828 | flow_handler
[   11.485692] iwlwifi 0000:3a:00.0: Fseq Registers:
[   11.487917] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_ERROR_CODE
[   11.490156] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[   11.492372] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[   11.494577] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_OTP_VERSION
[   11.496734] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[   11.498586] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[   11.499921] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_CNVI_ID
[   11.501279] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_CNVR_ID
[   11.502465] iwlwifi 0000:3a:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[   11.503572] iwlwifi 0000:3a:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[   11.504681] iwlwifi 0000:3a:00.0: 0x00000000 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   11.505770] iwlwifi 0000:3a:00.0: 0x00000000 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   11.506709] iwlwifi 0000:3a:00.0: Starting mac, retry will be
triggered anyway
[   11.507645] iwlwifi 0000:3a:00.0: FW error in SYNC CMD
PER_CHAIN_LIMIT_OFFSET_CMD
[   11.508634]  iwl_trans_txq_send_hcmd+0x45c/0x470 [iwlwifi]
[   11.508657]  iwl_trans_send_cmd+0x66/0xf0 [iwlwifi]
[   11.508926] iwlwifi 0000:3a:00.0: Failed to send MAC context (action:1): -5
[   11.509884] iwlwifi 0000:3a:00.0: Failed to disable queue 1 (ret=-5)
[   11.510899] iwlwifi 0000:3a:00.0: Failed to remove station. Id=1
[   11.511864] iwlwifi 0000:3a:00.0: Failed sending remove station
[   11.687220] iwlwifi 0000:3a:00.0: Microcode SW error detected.
Restarting 0x2000000.
[   11.687472] iwlwifi 0000:3a:00.0: Start IWL Error Log Dump:
[   11.687475] iwlwifi 0000:3a:00.0: Transport status: 0x0000004B, valid: 6
[   11.687479] iwlwifi 0000:3a:00.0: Loaded firmware version:
17.3216344376.0 3160-17.ucode
[   11.687481] iwlwifi 0000:3a:00.0: 0x00000038 | BAD_COMMAND
[   11.687484] iwlwifi 0000:3a:00.0: 0x000002F0 | trm_hw_status0
[   11.687487] iwlwifi 0000:3a:00.0: 0x00000000 | trm_hw_status1
[   11.687489] iwlwifi 0000:3a:00.0: 0x00000B30 | branchlink2
[   11.687491] iwlwifi 0000:3a:00.0: 0x00014908 | interruptlink1
[   11.687493] iwlwifi 0000:3a:00.0: 0x00000000 | interruptlink2
[   11.687495] iwlwifi 0000:3a:00.0: 0xDEADBEEF | data1
[   11.687496] iwlwifi 0000:3a:00.0: 0xDEADBEEF | data2
[   11.687498] iwlwifi 0000:3a:00.0: 0xDEADBEEF | data3
[   11.687499] iwlwifi 0000:3a:00.0: 0x003FD637 | beacon time
[   11.687501] iwlwifi 0000:3a:00.0: 0x000029C7 | tsf low
[   11.687502] iwlwifi 0000:3a:00.0: 0x00000000 | tsf hi
[   11.687504] iwlwifi 0000:3a:00.0: 0x00000000 | time gp1
[   11.687506] iwlwifi 0000:3a:00.0: 0x000029C8 | time gp2
[   11.687508] iwlwifi 0000:3a:00.0: 0x00000000 | uCode revision type
[   11.687509] iwlwifi 0000:3a:00.0: 0x00000011 | uCode version major
[   11.687511] iwlwifi 0000:3a:00.0: 0xBFB58538 | uCode version minor
[   11.687513] iwlwifi 0000:3a:00.0: 0x00000164 | hw version
[   11.687515] iwlwifi 0000:3a:00.0: 0x00C89204 | board version
[   11.687517] iwlwifi 0000:3a:00.0: 0x001D0405 | hcmd
[   11.687519] iwlwifi 0000:3a:00.0: 0x00022080 | isr0
[   11.687522] iwlwifi 0000:3a:00.0: 0x00000000 | isr1
[   11.687524] iwlwifi 0000:3a:00.0: 0x00000002 | isr2
[   11.687526] iwlwifi 0000:3a:00.0: 0x004000C0 | isr3
[   11.687527] iwlwifi 0000:3a:00.0: 0x00000000 | isr4
[   11.687530] iwlwifi 0000:3a:00.0: 0x01000112 | last cmd Id
[   11.687532] iwlwifi 0000:3a:00.0: 0x00000000 | wait_event
[   11.687534] iwlwifi 0000:3a:00.0: 0x000000D4 | l2p_control
[   11.687536] iwlwifi 0000:3a:00.0: 0x00000000 | l2p_duration
[   11.687538] iwlwifi 0000:3a:00.0: 0x00000000 | l2p_mhvalid
[   11.687541] iwlwifi 0000:3a:00.0: 0x00000000 | l2p_addr_match
[   11.687543] iwlwifi 0000:3a:00.0: 0x00000007 | lmpm_pmg_sel
[   11.687544] iwlwifi 0000:3a:00.0: 0x15041745 | timestamp
[   11.687546] iwlwifi 0000:3a:00.0: 0x00001828 | flow_handler
[   11.687549] iwlwifi 0000:3a:00.0: Fseq Registers:
[   11.687694] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_ERROR_CODE
[   11.687749] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[   11.687804] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_CNVIO_INIT_VERSION
[   11.687859] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_OTP_VERSION
[   11.687914] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_TOP_CONTENT_VERSION
[   11.687964] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_ALIVE_TOKEN
[   11.688019] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_CNVI_ID
[   11.688074] iwlwifi 0000:3a:00.0: 0x00000000 | FSEQ_CNVR_ID
[   11.688130] iwlwifi 0000:3a:00.0: 0x00000000 | CNVI_AUX_MISC_CHIP
[   11.688185] iwlwifi 0000:3a:00.0: 0x00000000 | CNVR_AUX_MISC_CHIP
[   11.688240] iwlwifi 0000:3a:00.0: 0x00000000 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   11.688295] iwlwifi 0000:3a:00.0: 0x00000000 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   11.688299] iwlwifi 0000:3a:00.0: Starting mac, retry will be
triggered anyway
[   11.688317] iwlwifi 0000:3a:00.0: FW error in SYNC CMD
PER_CHAIN_LIMIT_OFFSET_CMD
[   11.688339]  iwl_trans_txq_send_hcmd+0x45c/0x470 [iwlwifi]
[   11.688366]  iwl_trans_send_cmd+0x66/0xf0 [iwlwifi]
...

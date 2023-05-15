Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1A703FF9
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 23:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245618AbjEOVk4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 17:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245615AbjEOVkw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 17:40:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3EA93E1
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 14:40:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so12302099a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684186843; x=1686778843;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pOEi2mUes+o58tfOVMp4K1ci6Z0cR7qAm+Kqr3g33N0=;
        b=h2WpR3+GhOUW9IuYDXOtPXZ2IZ9WaqMm61+UM1cBZqJWSHGtHSR6e+GIW1wZkUVHEw
         1n7ifrTv5T2sWYtaIdTY5Lhc7AM51/rFNu3JiXGkNk0EF+WEP1hSKp15ANSaDxY021PC
         E4yBSOTsj6kSe6/sel6zQu0oOnkm6i90DT/9AGPD/ydyc24Q0Pn/dwCJura7UYziCGwc
         uGSV5v1IPE5O7Xg8jkvs4CeJH1UHE0aK/1kePDmPlbydVXKJVtXm0RHD3AgGMWPUPnQr
         n67VhZKSAD9JhZO1jIxfYcPKsAc1+DLnLV4yvDKxxn+Wy26bWuxciZeHKoTW/XdwnFTS
         /kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684186843; x=1686778843;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOEi2mUes+o58tfOVMp4K1ci6Z0cR7qAm+Kqr3g33N0=;
        b=hbqtxBFek1MQKl0M8OBZRQOV5xhLgB02nPAxKVr4XFu4VQKjo90ghAfArM6mpWQ9Ks
         MpRKazIlxS7Uvjhr7pJqa8jCL1YnpsDAlR4e+MLbk75jfETLZS1tS9p7YqXuzDpXwWl8
         2d8Zy2POui16GJ6NBci5hiX2buZhDVQF69si5iGajLAcrnIMvIlH6UZET40QYRiV3qGZ
         +TMBgywE+4Wb2v04lCc/IHh1vDXSM+yBTMGYx+BBSBB/yCeh2FYRWyhz+HMvdZXoAUpc
         SnzbrVIoh2zyfJurp4FMQndAISdGOFJmdzpHvew4+mCbqRvN8j5YxVQui1QiODqx/rqv
         YqtQ==
X-Gm-Message-State: AC+VfDxW6MB65Idak9m0m20EcgrCnWs0gcErF/3vwJnj28x1pWDRnTgA
        OuKdbGWbnthRUXckvEeyCvsjmUp6EEVrFmTuJg6X2q1MBq4=
X-Google-Smtp-Source: ACHHUZ7Khq8yhLBTlGfJNWYPqrvLuL5GHbFvlGPff8wAzQwrKV0v1NcQPNDW0ZHbXYFJAlJ8SVJn/UDC8Zemvd40Bcg=
X-Received: by 2002:a17:90b:a13:b0:24d:ebfe:be93 with SMTP id
 gg19-20020a17090b0a1300b0024debfebe93mr34447714pjb.37.1684186843398; Mon, 15
 May 2023 14:40:43 -0700 (PDT)
MIME-Version: 1.0
From:   JT Croteau <jt.tobit@gmail.com>
Date:   Mon, 15 May 2023 16:40:32 -0500
Message-ID: <CAErVL1t3vFRzb9bRhG=Q8mK_V00rv3r8BBPktDJkuYi5QRGQ+g@mail.gmail.com>
Subject: iwlwifi AX101 kernel 6.4
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I was recently presently surprised to find kernel 6.4.0 (rc1 and rc2)
finally detecting my AX101 adapter properly and loading the firmware.
I had some limited success using the 6.1 tree and the -dkms patch but
had some issues.

Unfortunately, I can't get the AX101 in 6.4 to work now that it is
properly being detected and loading the firmware (didn't work at all
in 6.3).  I'm getting an i/o error when I try to bring up the
interface.  My dmesg dump and IWL error log dump is at the bottom of
the message.  Is AX101 support still a work in progress, is this a
legitimate issue, or am I just doing something wrong I'm totally
missing?

Also, although I'm doing all of this testing with Bluetooth disabled,
bluetooth is still an issue as well as it is detecting an AX201
interface and wants to load firmware not currently available (
ibt-0040-1050.sfi).

Thanks and I'm always available for testing, this isn't a mission
critical device.

[    0.000000] Linux version 6.4.0-rc2 (root@ganymede) (gcc (Gentoo
13.1.0-r1 p1) 13.1.0, GNU ld (Gentoo 2.40 p5) 2.40.0) #1 SMP
PREEMPT_DYNAMIC Sun May 14 19:38:07 CDT 2023
[    0.619679] Intel(R) Wireless WiFi driver for Linux
[    0.619751] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    0.621969] iwlwifi 0000:00:14.3: Detected crf-id 0x501, cnv-id
0x80400 wfpm id 0x80000030
[    0.622010] iwlwifi 0000:00:14.3: PCI dev 54f0/0244, rev=0x370, rfid=0x10c000
[    0.622085] iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-so-a0-hr-b0-78.ucode failed with error -2
[    0.622091] iwlwifi 0000:00:14.3: api flags index 2 larger than
supported by driver
[    0.622101] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.36
[    0.622270] iwlwifi 0000:00:14.3: loaded firmware version
77.f92b5fed.0 so-a0-hr-b0-77.ucode op_mode iwlmvm
[    0.629241] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX101, REV=0x370
[    0.635988] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[    0.733175] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x1f
[    0.733221] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    0.733270] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[    0.733321] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x10
[    0.733371] iwlwifi 0000:00:14.3: Detected RF HR1 B3, rfid=0x10c000
[    0.734489] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[    3.911892] iwlwifi 0000:00:14.3 wlo1: renamed from wlan0
[    5.675433] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
[    5.772382] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x1f
[    5.772431] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    5.772439] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[    5.772447] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x10
[    5.773493] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[    5.821003] iwlwifi 0000:00:14.3: Registered PHC clock:
iwlwifi-PTP, with index: 2
[    5.821965] iwlwifi 0000:00:14.3: Microcode SW error detected.
Restarting 0x0.
[    5.822119] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[    5.822121] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[    5.822123] iwlwifi 0000:00:14.3: Loaded firmware version:
77.f92b5fed.0 so-a0-hr-b0-77.ucode
[    5.822125] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
[    5.822126] iwlwifi 0000:00:14.3: 0x000002F0 | trm_hw_status0
[    5.822127] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[    5.822128] iwlwifi 0000:00:14.3: 0x004D930E | branchlink2
[    5.822129] iwlwifi 0000:00:14.3: 0x004CF3DA | interruptlink1
[    5.822130] iwlwifi 0000:00:14.3: 0x004CF3DA | interruptlink2
[    5.822131] iwlwifi 0000:00:14.3: 0x0001556A | data1
[    5.822132] iwlwifi 0000:00:14.3: 0x00000010 | data2
[    5.822132] iwlwifi 0000:00:14.3: 0x00000000 | data3
[    5.822133] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[    5.822134] iwlwifi 0000:00:14.3: 0x0001838C | tsf low
[    5.822135] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[    5.822135] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[    5.822136] iwlwifi 0000:00:14.3: 0x00023B24 | time gp2
[    5.822137] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[    5.822138] iwlwifi 0000:00:14.3: 0x0000004D | uCode version major
[    5.822139] iwlwifi 0000:00:14.3: 0xF92B5FED | uCode version minor
[    5.822140] iwlwifi 0000:00:14.3: 0x00000370 | hw version
[    5.822140] iwlwifi 0000:00:14.3: 0x00C80002 | board version
[    5.822141] iwlwifi 0000:00:14.3: 0x8057FF00 | hcmd
[    5.822142] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[    5.822143] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[    5.822143] iwlwifi 0000:00:14.3: 0x48F00002 | isr2
[    5.822144] iwlwifi 0000:00:14.3: 0x00C3000C | isr3
[    5.822145] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[    5.822146] iwlwifi 0000:00:14.3: 0x00000000 | last cmd Id
[    5.822147] iwlwifi 0000:00:14.3: 0x0001556A | wait_event
[    5.822147] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[    5.822148] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[    5.822149] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[    5.822149] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[    5.822150] iwlwifi 0000:00:14.3: 0x00000018 | lmpm_pmg_sel
[    5.822151] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[    5.822152] iwlwifi 0000:00:14.3: 0x00001034 | flow_handler
[    5.822200] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[    5.822201] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[    5.822202] iwlwifi 0000:00:14.3: 0x201002FD | ADVANCED_SYSASSERT
[    5.822203] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[    5.822204] iwlwifi 0000:00:14.3: 0x8046CE44 | umac branchlink2
[    5.822204] iwlwifi 0000:00:14.3: 0xC00814B0 | umac interruptlink1
[    5.822205] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[    5.822206] iwlwifi 0000:00:14.3: 0x0014020B | umac data1
[    5.822206] iwlwifi 0000:00:14.3: 0x00000308 | umac data2
[    5.822207] iwlwifi 0000:00:14.3: 0x00000304 | umac data3
[    5.822208] iwlwifi 0000:00:14.3: 0x0000004D | umac major
[    5.822208] iwlwifi 0000:00:14.3: 0xF92B5FED | umac minor
[    5.822209] iwlwifi 0000:00:14.3: 0x00023B1E | frame pointer
[    5.822210] iwlwifi 0000:00:14.3: 0xC0886C24 | stack pointer
[    5.822210] iwlwifi 0000:00:14.3: 0x0014020B | last host cmd
[    5.822211] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[    5.822250] iwlwifi 0000:00:14.3: IML/ROM dump:
[    5.822251] iwlwifi 0000:00:14.3: 0x00000B03 | IML/ROM error/state
[    5.822259] iwlwifi 0000:00:14.3: 0x000050AE | IML/ROM data1
[    5.822268] iwlwifi 0000:00:14.3: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[    5.822273] iwlwifi 0000:00:14.3: Fseq Registers:
[    5.822275] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[    5.822278] iwlwifi 0000:00:14.3: 0x80350002 | FSEQ_TOP_INIT_VERSION
[    5.822281] iwlwifi 0000:00:14.3: 0x00150000 | FSEQ_CNVIO_INIT_VERSION
[    5.822283] iwlwifi 0000:00:14.3: 0x0000A482 | FSEQ_OTP_VERSION
[    5.822286] iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
[    5.822289] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[    5.822291] iwlwifi 0000:00:14.3: 0x00080400 | FSEQ_CNVI_ID
[    5.822294] iwlwifi 0000:00:14.3: 0x00000501 | FSEQ_CNVR_ID
[    5.822296] iwlwifi 0000:00:14.3: 0x00080400 | CNVI_AUX_MISC_CHIP
[    5.822301] iwlwifi 0000:00:14.3: 0x00000501 | CNVR_AUX_MISC_CHIP
[    5.822306] iwlwifi 0000:00:14.3: 0x05B0905B |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[    5.822311] iwlwifi 0000:00:14.3: 0x0000025B |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[    5.822313] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0xd05c18
[    5.822314] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd05c1c
[    5.822316] iwlwifi 0000:00:14.3: Starting mac, retry will be
triggered anyway
[    5.822346] iwlwifi 0000:00:14.3: FW error in SYNC CMD RFI_CONFIG_CMD
[    5.822349] CPU: 0 PID: 1960 Comm: dhcpcd Not tainted 6.4.0-rc2 #1
[    5.822351] Hardware name: AZW EQ/EQ, BIOS N95V104 03/17/2023
[    5.822353] Call Trace:
[    5.822355]  <TASK>
[    5.822356]  dump_stack_lvl+0x36/0x50
[    5.822360]  iwl_trans_txq_send_hcmd+0x338/0x450
[    5.822364]  ? __pfx_autoremove_wake_function+0x10/0x10
[    5.822367]  iwl_trans_send_cmd+0x61/0xf0
[    5.822369]  iwl_mvm_send_cmd+0x11/0x40
[    5.822371]  iwl_rfi_send_config_cmd+0xf0/0x190
[    5.822373]  ? acpi_os_release_object+0x9/0x10
[    5.822377]  iwl_mvm_up+0xbff/0xc50
[    5.822380]  ? __iwl_mvm_mac_start+0x5a/0x200
[    5.822382]  __iwl_mvm_mac_start+0x5a/0x200
[    5.822384]  iwl_mvm_mac_start+0x74/0x130
[    5.822385]  drv_start+0x3a/0x100
[    5.822387]  ieee80211_do_open+0x315/0x780
[    5.822390]  ieee80211_open+0x65/0x80
[    5.822392]  __dev_open+0xec/0x1a0
[    5.822394]  __dev_change_flags+0x1aa/0x220
[    5.822396]  dev_change_flags+0x21/0x60
[    5.822397]  devinet_ioctl+0x30e/0x7c0
[    5.822399]  inet_ioctl+0x1c7/0x1e0
[    5.822401]  sock_ioctl+0x2f3/0x3d0
[    5.822405]  ? security_file_ioctl+0x38/0x60
[    5.822407]  __x64_sys_ioctl+0x505/0xa10
[    5.822410]  do_syscall_64+0x3c/0x90
[    5.822412]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    5.822414] RIP: 0033:0x7fb18c29ac2b
[    5.822417] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
00 0f 05 <3d> 00 f0 ff ff 89 c2 77 1c 48 8b 44 24 18 64 48 2b 04 25 28
00>
[    5.822418] RSP: 002b:00007ffd85ac1ac0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[    5.822420] RAX: ffffffffffffffda RBX: 0000000000001043 RCX: 00007fb18c29ac2b
[    5.822421] RDX: 00007ffd85ac1b20 RSI: 0000000000008914 RDI: 000000000000000c
[    5.822422] RBP: 000055fb1151eba0 R08: 000000000417ce4b R09: 000000003782fbb5
[    5.822423] R10: 00007ffd85bf8080 R11: 0000000000000246 R12: 00007ffd85ac1b20
[    5.822424] R13: 0000000000000000 R14: 00007ffd85ac1c18 R15: 0000000000000000
[    5.822425]  </TASK>
[    5.822426] iwlwifi 0000:00:14.3: Failed to send RFI config cmd -5
[    5.822431] iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD
(action:1): -5

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA65B3569
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 12:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiIIKmM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiIIKmL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 06:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC57D138122
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662720129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3eG0BWBatjLI1VMEMQm+hyrlJCvTrNFzZLaRxl0P8Wo=;
        b=FGmcYp9SAD/q47WjuSwJO0xcNTpy7touK8/BIwMC2v/LI0KO9nlCNdaOke04W0q5dREMPr
        37uGMlT0pVMdQRiLbgPmRIWZr6iNUj2dB7g9xeunTa0WwxBqpUf0v/pUjIzPBJf30hzyjW
        O9XNNa7DAF5YT6mHiZVjLZ7cFKstlI4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-342-jGvRxlvaN4y5yLu6a3zrvg-1; Fri, 09 Sep 2022 06:42:08 -0400
X-MC-Unique: jGvRxlvaN4y5yLu6a3zrvg-1
Received: by mail-qv1-f71.google.com with SMTP id c6-20020a0ce7c6000000b004abe95fbed8so907057qvo.11
        for <linux-wireless@vger.kernel.org>; Fri, 09 Sep 2022 03:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3eG0BWBatjLI1VMEMQm+hyrlJCvTrNFzZLaRxl0P8Wo=;
        b=IaDKXUJxz1VThA2KreAlX1ryOuhMdWOMoUt8SSuEJDgdQa+Bb511K4CTTkO/yhMrpf
         EM+x4aaj4T5zC1xKYVnYBNxa1iZxRV2Yigj3eGO35GIEfUkZRxsMMcBgXDQopmSuhN8M
         ge3FIsOklcLwTyML44SNT/B4Nu7dDLTTq/17OFxQRGosetGOMVk68pXXCuoA+yqefIG8
         klNGeOrLN5v+8xvDkIMoYIeEm9sOLtcjtcUkpReLxWf7Ew5tWIWvsR84fWTBSv1Otbtc
         Xd6bLbG+er4qaiXIxMdCPlzX05Wk5yhIvD+ldGKkFaYKvV08hKhZ9AtLuwLAdBqmydb9
         MhcQ==
X-Gm-Message-State: ACgBeo3YdYviXocF42G4KUtWu//FuOuQXTEyh9hQGlB94kwYUyBGIZhu
        WEyjjAqbUgjyDTQM/O8yDaF4PB2CRPHu2Ay11DTI7Gg641W/KrJN65qBEJRa1hwbt1o35FQ4ba3
        RTaYaq4AyAWdVXlYWlSYLYhIVBlqOXzpiek5aVhTwq4g=
X-Received: by 2002:a05:6214:2486:b0:4a5:8b:9ba0 with SMTP id gi6-20020a056214248600b004a5008b9ba0mr11686717qvb.70.1662720126869;
        Fri, 09 Sep 2022 03:42:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4NJucqm4gEefx84ob3cJ18L+qrGCOFoJsa4MVdIz/YmBIndWcjtmHAF1kzJV3SNvaddmhAv+Gx2s+aF1UFNuI=
X-Received: by 2002:a05:6214:2486:b0:4a5:8b:9ba0 with SMTP id
 gi6-20020a056214248600b004a5008b9ba0mr11686698qvb.70.1662720126487; Fri, 09
 Sep 2022 03:42:06 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Fri, 9 Sep 2022 12:41:55 +0200
Message-ID: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
Subject: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0 versions
 above 55
To:     gregory.greenman@intel.com
Cc:     Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Laura Trivelloni <ltrivell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With an AC9560 installed on a system with Quasar (11th gen processor,
in my case) we're getting a firmware crash as soon as you try to do
something with the card. The problem doesn't happen with the card
installed in older platforms (8th / 9th gen), and it neither happens
with firmware iwlwifi-QuZ-a0-jf-b0-55 version, but yes with any other
newer version.

I've tried different versions of kernel and firmware, including the
latest kernel and linux-firmware available today, and all of them fail
unless I remove all fw files above version 55.

In relation to a similar problem, Gregory told to my colleague Jos=C3=A9
Ignacio that sometimes the firmware of the WiFi and Bluetooth parts
have to be compatible versions (for example loading an old BT fw
version might cause the firmware to crash).

Because of this, I checked the Bluetooth firmware version and saw that
ibt-19-0-1 was being loaded. This surprised me because according to
the Git logs in linux-firmware and the code in btintel.c, ibt-19 files
are for HarrisonPeak devices, but AC9560 is a JeffersonPeak device,
and it should use an ibt-17 file.

iwlwifi recognizes it as a JeffersonPeak device:
  iwlwifi 0000:00:14.3: loaded firmware version 66.f1c864e0.0
QuZ-a0-jf-b0-66.ucode op_mode iwlmvm
  iwlwifi 0000:00:14.3: Detected Intel(R) Wireless-AC 9560 160MHz, REV=3D0x=
351
  iwlwifi 0000:00:14.3: Detected RF JF, rfid=3D0x105110

I tried renaming ibt-17-0-1 to ibt-19-0-1 to see if that was the right
firmware to use, but the device refused to load it.

Gregory, any idea?

Here there is a sample of the logs I get:

[    7.869571] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    7.870880] iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-QuZ-a0-jf-b0-67.ucode failed with error -2
[    7.907064] iwlwifi 0000:00:14.3: api flags index 2 larger than
supported by driver
[    7.907084] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ
Version: 89.3.35.37
[    7.907397] iwlwifi 0000:00:14.3: loaded firmware version
66.f1c864e0.0 QuZ-a0-jf-b0-66.ucode op_mode iwlmvm
[    8.019867] iwlwifi 0000:00:14.3: Detected Intel(R) Wireless-AC
9560 160MHz, REV=3D0x351
[    8.134141] iwlwifi 0000:00:14.3: Detected RF JF, rfid=3D0x105110
[    8.191186] iwlwifi 0000:00:14.3: base HW address: 64:79:f0:73:4b:d2
[    8.208752] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[   15.093446] iwlwifi 0000:00:14.3: Microcode SW error detected.
Restarting 0x0.
[   15.093869] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   15.093870] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   15.093871] iwlwifi 0000:00:14.3: Loaded firmware version:
66.f1c864e0.0 QuZ-a0-jf-b0-66.ucode
[   15.093872] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
[   15.093874] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   15.093874] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   15.093875] iwlwifi 0000:00:14.3: 0x004C2726 | branchlink2
[   15.093876] iwlwifi 0000:00:14.3: 0x004B974E | interruptlink1
[   15.093877] iwlwifi 0000:00:14.3: 0x004B974E | interruptlink2
[   15.093878] iwlwifi 0000:00:14.3: 0x004BAD74 | data1
[   15.093878] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   15.093879] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   15.093880] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   15.093880] iwlwifi 0000:00:14.3: 0x00021989 | tsf low
[   15.093881] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   15.093882] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   15.093883] iwlwifi 0000:00:14.3: 0x000271FB | time gp2
[   15.093883] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   15.093884] iwlwifi 0000:00:14.3: 0x00000042 | uCode version major
[   15.093885] iwlwifi 0000:00:14.3: 0xF1C864E0 | uCode version minor
[   15.093886] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   15.093886] iwlwifi 0000:00:14.3: 0x00489001 | board version
[   15.093887] iwlwifi 0000:00:14.3: 0x8039FD22 | hcmd
[   15.093888] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   15.093889] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   15.093889] iwlwifi 0000:00:14.3: 0x08F00002 | isr2
[   15.093890] iwlwifi 0000:00:14.3: 0x00C3400C | isr3
[   15.093891] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   15.093892] iwlwifi 0000:00:14.3: 0x00000000 | last cmd Id
[   15.093892] iwlwifi 0000:00:14.3: 0x004BAD74 | wait_event
[   15.093893] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   15.093894] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   15.093895] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   15.093895] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   15.093896] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   15.093897] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   15.093897] iwlwifi 0000:00:14.3: 0x00000850 | flow_handler
[   15.093969] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   15.093970] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   15.093970] iwlwifi 0000:00:14.3: 0x201002FF | ADVANCED_SYSASSERT
[   15.093971] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   15.093972] iwlwifi 0000:00:14.3: 0x8045348E | umac branchlink2
[   15.093973] iwlwifi 0000:00:14.3: 0xC00811A4 | umac interruptlink1
[   15.093974] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   15.093974] iwlwifi 0000:00:14.3: 0x00110407 | umac data1
[   15.093975] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data2
[   15.093976] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   15.093977] iwlwifi 0000:00:14.3: 0x00000042 | umac major
[   15.093977] iwlwifi 0000:00:14.3: 0xF1C864E0 | umac minor
[   15.093978] iwlwifi 0000:00:14.3: 0x000271F5 | frame pointer
[   15.093979] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   15.093979] iwlwifi 0000:00:14.3: 0x00110407 | last host cmd
[   15.093980] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   15.094004] iwlwifi 0000:00:14.3: IML/ROM dump:
[   15.094005] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   15.094013] iwlwifi 0000:00:14.3: 0x00005679 | IML/ROM data1
[   15.094021] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   15.094027] iwlwifi 0000:00:14.3: Fseq Registers:
[   15.094029] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   15.094032] iwlwifi 0000:00:14.3: 0x80260000 | FSEQ_TOP_INIT_VERSION
[   15.094034] iwlwifi 0000:00:14.3: 0x00020006 | FSEQ_CNVIO_INIT_VERSION
[   15.094037] iwlwifi 0000:00:14.3: 0x0000A384 | FSEQ_OTP_VERSION
[   15.094040] iwlwifi 0000:00:14.3: 0x516D77EF | FSEQ_TOP_CONTENT_VERSION
[   15.094042] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   15.094045] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   15.094048] iwlwifi 0000:00:14.3: 0x01300202 | FSEQ_CNVR_ID
[   15.094050] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   15.094055] iwlwifi 0000:00:14.3: 0x01300202 | CNVR_AUX_MISC_CHIP
[   15.094060] iwlwifi 0000:00:14.3: 0x0000485B |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   15.094094] iwlwifi 0000:00:14.3: 0xA5A5A5A2 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   15.094097] iwlwifi 0000:00:14.3: Starting mac, retry will be
triggered anyway
[   15.094109] iwlwifi 0000:00:14.3: FW error in SYNC CMD UNKNOWN
[   15.094113] CPU: 7 PID: 2061 Comm: NetworkManager Not tainted
5.14.0-70.13.1.el9_0.x86_64 #1
[   15.094115] Hardware name: HP HP ProBook 450 G8 Notebook PC/8808,
BIOS T85 Ver. 01.08.02 01/14/2022
[   15.094116] Call Trace:
[   15.094123] iwlwifi 0000:00:14.3: Hardware error detected. Restarting.
[   15.094120]  dump_stack_lvl+0x34/0x44
[   15.094127]  iwl_trans_txq_send_hcmd_sync+0x2ab/0x2c0 [iwlwifi]
[   15.094139]  ? do_wait_intr_irq+0xa0/0xa0
[   15.094143]  iwl_trans_send_cmd+0x5a/0xe0 [iwlwifi]
[   15.094150]  iwl_mvm_send_cmd_pdu+0x5c/0xa0 [iwlmvm]
[   15.094159]  iwl_mvm_ppag_send_cmd+0x79/0xd0 [iwlmvm]
[   15.094164]  iwl_mvm_up+0x533/0x760 [iwlmvm]
[   15.094170]  ? e1000e_set_rx_mode+0x80/0x5b0 [e1000e]
[   15.094179]  __iwl_mvm_mac_start+0x26/0x1a0 [iwlmvm]
[   15.094184]  iwl_mvm_mac_start+0x45/0xa0 [iwlmvm]
[   15.094190]  drv_start+0x3c/0x100 [mac80211]
[   15.094210]  ieee80211_do_open+0x47c/0x900 [mac80211]
[   15.094228]  ieee80211_open+0x67/0x90 [mac80211]
[   15.094246]  __dev_open+0xe7/0x1a0
[   15.094250]  __dev_change_flags+0x1d7/0x240
[   15.094252]  ? inet6_set_link_af+0x4c/0xb0
[   15.094256]  dev_change_flags+0x21/0x60
[   15.094258]  do_setlink+0x269/0xbb0
[   15.094261]  ? cpumask_next+0x1f/0x20
[   15.094263]  ? __snmp6_fill_stats64.constprop.0+0x67/0x110
[   15.094267]  ? __nla_validate_parse+0x49/0x180
[   15.094269]  __rtnl_newlink+0x5ee/0x9b0
[   15.094271]  ? pskb_expand_head+0x10e/0x330
[   15.094273]  ? skb_queue_tail+0x1b/0x50
[   15.094275]  ? sock_def_readable+0xe/0x80
[   15.094276]  ? __netlink_sendskb+0x64/0x80
[   15.094278]  ? netlink_unicast+0x30d/0x350
[   15.094279]  ? rtnl_getlink+0x366/0x3e0
[   15.094282]  ? kmem_cache_alloc_trace+0x45/0x420
[   15.094286]  rtnl_newlink+0x44/0x70
[   15.094287]  rtnetlink_rcv_msg+0x13e/0x380
[   15.094289]  ? avc_has_perm+0x8f/0x1a0
[   15.094291]  ? rtnl_calcit.isra.0+0x130/0x130
[   15.094292]  netlink_rcv_skb+0x4e/0xf0
[   15.094294]  netlink_unicast+0x234/0x350
[   15.094296]  netlink_sendmsg+0x23b/0x480
[   15.094297]  sock_sendmsg+0x5b/0x60
[   15.094299]  ____sys_sendmsg+0x22c/0x270
[   15.094300]  ? import_iovec+0x17/0x20
[   15.094302]  ? sendmsg_copy_msghdr+0x79/0xa0
[   15.094304]  ___sys_sendmsg+0x81/0xc0
[   15.094306]  ? proc_sys_call_handler+0x1a8/0x290
[   15.094309]  ? kfree+0x206/0x260
[   15.094311]  ? __fput+0xff/0x240
[   15.094313]  ? rcu_nocb_try_bypass+0x4d/0x410
[   15.094315]  ? __fget_light+0x8f/0x110
[   15.094317]  __sys_sendmsg+0x59/0xa0
[   15.094319]  do_syscall_64+0x38/0x90
[   15.094322]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   15.094324] RIP: 0033:0x7fe25cd8ac1d
[   15.094327] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 1a
c0 f4 ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 5e c0 f4
ff 48
[   15.094328] RSP: 002b:00007ffcef869850 EFLAGS: 00000293 ORIG_RAX:
000000000000002e
[   15.094330] RAX: ffffffffffffffda RBX: 000055b39779a040 RCX: 00007fe25cd=
8ac1d
[   15.094331] RDX: 0000000000000000 RSI: 00007ffcef869890 RDI: 00000000000=
0000c
[   15.094332] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[   15.094332] R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000=
00003
[   15.094333] R13: 00007ffcef8699f0 R14: 00007ffcef8699ec R15: 00000000000=
00000
[   15.094341] iwlwifi 0000:00:14.3: failed to send
PER_PLATFORM_ANT_GAIN_CMD (-5)
[   15.106460] iwlwifi 0000:00:14.3: mac start retry 0
[   15.284772] iwlwifi 0000:00:14.3: Microcode SW error detected.
Restarting 0x0.
[   15.285810] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   15.285811] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
[   15.285812] iwlwifi 0000:00:14.3: Loaded firmware version:
66.f1c864e0.0 QuZ-a0-jf-b0-66.ucode
[   15.285813] iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
[   15.285815] iwlwifi 0000:00:14.3: 0x000022F0 | trm_hw_status0
[   15.285815] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
[   15.285816] iwlwifi 0000:00:14.3: 0x004C2726 | branchlink2
[   15.285817] iwlwifi 0000:00:14.3: 0x004B974E | interruptlink1
[   15.285817] iwlwifi 0000:00:14.3: 0x004B974E | interruptlink2
[   15.285818] iwlwifi 0000:00:14.3: 0x004BAD74 | data1
[   15.285819] iwlwifi 0000:00:14.3: 0x00001000 | data2
[   15.285819] iwlwifi 0000:00:14.3: 0x00000000 | data3
[   15.285820] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
[   15.285821] iwlwifi 0000:00:14.3: 0x000223B2 | tsf low
[   15.285821] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
[   15.285822] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
[   15.285822] iwlwifi 0000:00:14.3: 0x00028789 | time gp2
[   15.285823] iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
[   15.285824] iwlwifi 0000:00:14.3: 0x00000042 | uCode version major
[   15.285825] iwlwifi 0000:00:14.3: 0xF1C864E0 | uCode version minor
[   15.285825] iwlwifi 0000:00:14.3: 0x00000351 | hw version
[   15.285826] iwlwifi 0000:00:14.3: 0x00489001 | board version
[   15.285827] iwlwifi 0000:00:14.3: 0x8038FD22 | hcmd
[   15.285827] iwlwifi 0000:00:14.3: 0x00020000 | isr0
[   15.285828] iwlwifi 0000:00:14.3: 0x00000000 | isr1
[   15.285828] iwlwifi 0000:00:14.3: 0x08F00002 | isr2
[   15.285829] iwlwifi 0000:00:14.3: 0x00C3400C | isr3
[   15.285830] iwlwifi 0000:00:14.3: 0x00000000 | isr4
[   15.285830] iwlwifi 0000:00:14.3: 0x00000000 | last cmd Id
[   15.285831] iwlwifi 0000:00:14.3: 0x004BAD74 | wait_event
[   15.285832] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
[   15.285832] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
[   15.285833] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
[   15.285833] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
[   15.285834] iwlwifi 0000:00:14.3: 0x00000048 | lmpm_pmg_sel
[   15.285835] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
[   15.285835] iwlwifi 0000:00:14.3: 0x0000084C | flow_handler
[   15.286251] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
[   15.286252] iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
[   15.286253] iwlwifi 0000:00:14.3: 0x201002FF | ADVANCED_SYSASSERT
[   15.286254] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
[   15.286254] iwlwifi 0000:00:14.3: 0x8045348E | umac branchlink2
[   15.286255] iwlwifi 0000:00:14.3: 0xC00811A4 | umac interruptlink1
[   15.286256] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
[   15.286256] iwlwifi 0000:00:14.3: 0x00100407 | umac data1
[   15.286257] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data2
[   15.286257] iwlwifi 0000:00:14.3: 0xDEADBEEF | umac data3
[   15.286258] iwlwifi 0000:00:14.3: 0x00000042 | umac major
[   15.286259] iwlwifi 0000:00:14.3: 0xF1C864E0 | umac minor
[   15.286259] iwlwifi 0000:00:14.3: 0x00028783 | frame pointer
[   15.286260] iwlwifi 0000:00:14.3: 0xC0886C14 | stack pointer
[   15.286261] iwlwifi 0000:00:14.3: 0x00100407 | last host cmd
[   15.286261] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
[   15.286355] iwlwifi 0000:00:14.3: IML/ROM dump:
[   15.286355] iwlwifi 0000:00:14.3: 0x00000003 | IML/ROM error/state
[   15.286456] iwlwifi 0000:00:14.3: 0x000061DE | IML/ROM data1
[   15.286544] iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[   15.286587] iwlwifi 0000:00:14.3: Fseq Registers:
[   15.286609] iwlwifi 0000:00:14.3: 0x60000000 | FSEQ_ERROR_CODE
[   15.286631] iwlwifi 0000:00:14.3: 0x80260000 | FSEQ_TOP_INIT_VERSION
[   15.286653] iwlwifi 0000:00:14.3: 0x00020006 | FSEQ_CNVIO_INIT_VERSION
[   15.286675] iwlwifi 0000:00:14.3: 0x0000A384 | FSEQ_OTP_VERSION
[   15.286698] iwlwifi 0000:00:14.3: 0x516D77EF | FSEQ_TOP_CONTENT_VERSION
[   15.286719] iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
[   15.286742] iwlwifi 0000:00:14.3: 0x20000302 | FSEQ_CNVI_ID
[   15.286764] iwlwifi 0000:00:14.3: 0x01300202 | FSEQ_CNVR_ID
[   15.286786] iwlwifi 0000:00:14.3: 0x20000302 | CNVI_AUX_MISC_CHIP
[   15.286810] iwlwifi 0000:00:14.3: 0x01300202 | CNVR_AUX_MISC_CHIP
[   15.286834] iwlwifi 0000:00:14.3: 0x0000485B |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[   15.286887] iwlwifi 0000:00:14.3: 0xA5A5A5A2 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[   15.286909] iwlwifi 0000:00:14.3: Starting mac, retry will be
triggered anyway
[   15.286915] iwlwifi 0000:00:14.3: FW error in SYNC CMD UNKNOWN
[   15.286917] CPU: 7 PID: 2061 Comm: NetworkManager Not tainted
5.14.0-70.13.1.el9_0.x86_64 #1
[   15.286919] Hardware name: HP HP ProBook 450 G8 Notebook PC/8808,
BIOS T85 Ver. 01.08.02 01/14/2022
[   15.286920] Call Trace:
[   15.286923]  dump_stack_lvl+0x34/0x44
[   15.286929]  iwl_trans_txq_send_hcmd_sync+0x2ab/0x2c0 [iwlwifi]
[   15.286980] iwlwifi 0000:00:14.3: Hardware error detected. Restarting.
[   15.286986]  ? do_wait_intr_irq+0xa0/0xa0
[   15.286989]  iwl_trans_send_cmd+0x5a/0xe0 [iwlwifi]
[   15.286995]  iwl_mvm_send_cmd_pdu+0x5c/0xa0 [iwlmvm]
[   15.287003]  iwl_mvm_ppag_send_cmd+0x79/0xd0 [iwlmvm]
[   15.287008]  iwl_mvm_up+0x533/0x760 [iwlmvm]
[   15.287012]  ? __iwl_err.cold+0x5d/0x62 [iwlwifi]
[   15.287020]  __iwl_mvm_mac_start+0x26/0x1a0 [iwlmvm]
[   15.287025]  iwl_mvm_mac_start+0x45/0xa0 [iwlmvm]
[   15.287025]  iwl_mvm_mac_start+0x45/0xa0 [iwlmvm]
[   15.287030]  drv_start+0x3c/0x100 [mac80211]
[   15.287048]  ieee80211_do_open+0x47c/0x900 [mac80211]
[   15.287064]  ieee80211_open+0x67/0x90 [mac80211]
[   15.287077]  __dev_open+0xe7/0x1a0
[   15.287080]  __dev_change_flags+0x1d7/0x240
[   15.287082]  ? inet6_set_link_af+0x4c/0xb0
[   15.287084]  dev_change_flags+0x21/0x60
[   15.287085]  do_setlink+0x269/0xbb0
[   15.287087]  ? cpumask_next+0x1f/0x20
[   15.287089]  ? __snmp6_fill_stats64.constprop.0+0x67/0x110
[   15.287092]  ? __nla_validate_parse+0x49/0x180
[   15.287094]  __rtnl_newlink+0x5ee/0x9b0
[   15.287096]  ? pskb_expand_head+0x10e/0x330
[   15.287098]  ? skb_queue_tail+0x1b/0x50
[   15.287100]  ? sock_def_readable+0xe/0x80
[   15.287101]  ? __netlink_sendskb+0x64/0x80
[   15.287103]  ? netlink_unicast+0x30d/0x350
[   15.287104]  ? rtnl_getlink+0x366/0x3e0
[   15.287107]  ? kmem_cache_alloc_trace+0x45/0x420
[   15.287109]  rtnl_newlink+0x44/0x70
[   15.287111]  rtnetlink_rcv_msg+0x13e/0x380
[   15.287112]  ? avc_has_perm+0x8f/0x1a0
[   15.287114]  ? rtnl_calcit.isra.0+0x130/0x130
[   15.287116]  netlink_rcv_skb+0x4e/0xf0
[   15.287117]  netlink_unicast+0x234/0x350
[   15.287118]  netlink_sendmsg+0x23b/0x480
[   15.287120]  sock_sendmsg+0x5b/0x60
[   15.287123]  ____sys_sendmsg+0x22c/0x270
[   15.287124]  ? import_iovec+0x17/0x20
[   15.287126]  ? sendmsg_copy_msghdr+0x79/0xa0
[   15.287128]  ___sys_sendmsg+0x81/0xc0
[   15.287130]  ? proc_sys_call_handler+0x1a8/0x290
[   15.287132]  ? kfree+0x206/0x260
[   15.287133]  ? __fput+0xff/0x240
[   15.287135]  ? rcu_nocb_try_bypass+0x4d/0x410
[   15.287137]  ? __fget_light+0x8f/0x110
[   15.287139]  __sys_sendmsg+0x59/0xa0
[   15.287141]  do_syscall_64+0x38/0x90
[   15.287143]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   15.287145] RIP: 0033:0x7fe25cd8ac1d
[   15.287147] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 1a
c0 f4 ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 5e c0 f4
ff 48
[   15.287148] RSP: 002b:00007ffcef869850 EFLAGS: 00000293 ORIG_RAX:
000000000000002e
[   15.287150] RAX: ffffffffffffffda RBX: 000055b39779a040 RCX: 00007fe25cd=
8ac1d
[   15.287151] RDX: 0000000000000000 RSI: 00007ffcef869890 RDI: 00000000000=
0000c
[   15.287151] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[   15.287152] R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000=
00003
[   15.287152] R13: 00007ffcef8699f0 R14: 00007ffcef8699ec R15: 00000000000=
00000
[   15.287154] iwlwifi 0000:00:14.3: failed to send
PER_PLATFORM_ANT_GAIN_CMD (-5)
[   15.300157] iwlwifi 0000:00:14.3: mac start retry 1


--=20
=C3=8D=C3=B1igo Huguet


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4F637FC2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKXTpb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXTpa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:45:30 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364018A141
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:45:29 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id q7so2973763ljp.9
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K3N60ViEruCvrajPZIqfu7L9PXdSSYwJ34Z6R6BCwDg=;
        b=NxpB+rqIICPXTaw+VFlj26+YTDfULIZWdWrrzyvaUXR2OCPMg4An4eWSgN4W6csZOl
         k84yZ2+Fji42whrBodPfFw1LpCsJFwcj2Uk9h4Y+p3qYfrMQXJIxYIqK+l85Ajf5jdZ8
         rLn3c69qk4D9amX2x3JxQDgPdeIpJBtfwhGtdGTaqAWGI7MFFD4IEDv2MBEV6m12DV6V
         sc1FqCIpi1L97d06+s7ERR4bdOpV1/+PTsymIoXNlOv2InPPMf2tJuOAuOsNM4BY6XRD
         3c8NEC4U8a0VhoQd2E1Mebx6HCVYVjVagKkEun+pvLJnI5Ym6A0YhC6hLoGP85TtVo8s
         Dcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3N60ViEruCvrajPZIqfu7L9PXdSSYwJ34Z6R6BCwDg=;
        b=799TnD6pbLevOExrPqh86LwsSaDzJFfT9wOBunDxcgqLSMr7nFcZ9qj6s1ObADAgP6
         419XaKjVCcArrytJOF8VRj6AOb0ywmxgO5/zicjm4tgb+W3O028te2+YXQ5WQrdyHugd
         FawgYJceahVCIIfcvBINiYh8SuSa+AOw3yGGfRbuth9wP0qA0ugCDId+M16pF8Ej3B5E
         nBqSW2AoIQhct0zwQpv60vPDRn70moHAXPFfgwrXlaxM8QM973DOinvXsLRtoSBOEA+7
         DQ+3OIMCyosU+kg+QTFWhSfyHdHWA6x6FgoE0/E81j1l2DPOlp7qRerOnws7OGRsZN7r
         bp/A==
X-Gm-Message-State: ANoB5pn3yOQgO0v6lpHgfV7KE8aHYhi7QYZUPjtmiCsEaBy82zbU0FS1
        HKwtiKUfDNjO/kpQia8+AdrxlS5dbKCPPMxGIdNgrMTnpTvgVQ==
X-Google-Smtp-Source: AA0mqf5xR6iu6T1Tx8Eq5PZ9KpOsSfyq5hYMKan/GwVJaqgRKqF7KDFklkOxX5Ataj+ANoU35FyJ47SZCGPqVV0LLP4=
X-Received: by 2002:a2e:894f:0:b0:279:7c42:9240 with SMTP id
 b15-20020a2e894f000000b002797c429240mr2551289ljk.54.1669319127551; Thu, 24
 Nov 2022 11:45:27 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:44:17 +0200
Message-ID: <CADUzMVbWG9HC7gh=z_HMm2J7Wjgfbr4myY9YGHsPB4jGc6H+yQ@mail.gmail.com>
Subject: PRO/Wireless 4965 Intel WPA2,3 SSID connection problem #1
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Moving on to the next miniPCIe device and driver, during testing this
card had an issue with a combo 2,4GHz WPA2,3 SSID.

On Ubuntu boot I get:
[   58.746843] iwl4965: Intel(R) Wireless WiFi 4965 driver for Linux, in-tree:
[   58.746856] iwl4965: Copyright(c) 2003-2011 Intel Corporation
[   58.747013] iwl4965 0000:02:00.0: can't disable ASPM; OS doesn't
have ASPM control
[   58.747278] iwl4965 0000:02:00.0: Detected Intel(R) Wireless WiFi
Link 4965AGN, REV=0x4
[   58.789586] iwl4965 0000:02:00.0: device EEPROM VER=0x36, CALIB=0x5
[   58.789655] iwl4965 0000:02:00.0: Tunable channels: 13 802.11bg, 19
802.11a channels
[   69.134094] iwl4965 0000:02:00.0: loaded firmware version 228.61.2.24
[   69.134564] ieee80211 phy0: Selected rate control algorithm 'iwl-4965-rs'
[   69.159649] iwl4965 0000:02:00.0 wlp2s0: renamed from wlan0
[  699.019058] iwl4965 0000:02:00.0: Enabling power save might cause
firmware crashes

This is what happened upon connecting to the WPA2,3 2,4GHz SSID:
[  700.609023] ================================================================================
[  700.609064] UBSAN: shift-out-of-bounds in
/build/linux-JDy9aa/linux-5.19.0/drivers/net/wireless/intel/iwlegacy/4965-rs.c:671:18
[  700.609078] shift exponent -1 is negative
[  700.609088] CPU: 5 PID: 0 Comm: swapper/5 Tainted: P           O
  5.19.0-21-generic #21-Ubuntu
[  700.609099] Hardware name: Gigabyte Technology Co., Ltd.
GA-880GMA-USB3/GA-880GMA-USB3, BIOS F4e 05/24/2012
[  700.609105] Call Trace:
[  700.609111]  <IRQ>
[  700.609120]  show_stack+0x4e/0x61
[  700.609139]  dump_stack_lvl+0x4a/0x6d
[  700.609153]  dump_stack+0x10/0x18
[  700.609163]  ubsan_epilogue+0x9/0x43
[  700.609174]  __ubsan_handle_shift_out_of_bounds.cold+0x61/0xef
[  700.609189]  ? __smp_call_single_queue+0x61/0xa0
[  700.609203]  il4965_rs_get_adjacent_rate.constprop.0.cold+0x17/0x9c [iwl4965]
[  700.609235]  il4965_rs_get_best_rate.isra.0+0xc3/0x150 [iwl4965]
[  700.609261]  il4965_rs_switch_to_siso.isra.0+0xad/0x110 [iwl4965]
[  700.609284]  il4965_rs_move_legacy_other.isra.0+0x10b/0x480 [iwl4965]
[  700.609308]  il4965_rs_rate_scale_perform+0xa7b/0xc90 [iwl4965]
[  700.609332]  il4965_rs_tx_status+0x3f3/0x670 [iwl4965]
[  700.609369]  rate_control_tx_status+0xcf/0xe0 [mac80211]
[  700.609578]  ieee80211_tx_status_ext+0x305/0x6c0 [mac80211]
[  700.609729]  ieee80211_tx_status+0x77/0xb0 [mac80211]
[  700.609879]  ieee80211_tasklet_handler+0xac/0xd0 [mac80211]
[  700.610026]  tasklet_action_common.constprop.0+0xbc/0x100
[  700.610041]  tasklet_action+0x22/0x30
[  700.610051]  __do_softirq+0xdb/0x34f
[  700.610060]  ? handle_irq_event+0x52/0x80
[  700.610074]  __irq_exit_rcu+0x87/0xc0
[  700.610084]  irq_exit_rcu+0xe/0x20
[  700.610094]  common_interrupt+0xa4/0xb0
[  700.610103]  </IRQ>
[  700.610106]  <TASK>
[  700.610110]  asm_common_interrupt+0x27/0x40
[  700.610122] RIP: 0010:native_safe_halt+0xb/0x10
[  700.610135] Code: cc cc cc 4c 89 ee 48 c7 c7 e0 4f 85 97 e8 8d 8f
84 ff eb c4 cc cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d b9 46 4e
00 fb f4 <c3> cc cc cc cc eb 07 0f 00 2d a9 46 4e 00 f4 c3 cc cc cc cc
cc 0f
[  700.610143] RSP: 0018:ffffacec000cfdc0 EFLAGS: 00000246
[  700.610153] RAX: 0000000000004000 RBX: ffff9c8041237c64 RCX: 0000000000000000
[  700.610160] RDX: 0000000000000001 RSI: ffff9c8041237c00 RDI: 0000000000000001
[  700.610165] RBP: ffffacec000cfdd0 R08: 0000000000000000 R09: 0000000000000000
[  700.610170] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9c8041237c64
[  700.610175] R13: 0000000000000005 R14: ffffffff97ac5220 R15: ffff9c8360540000
[  700.610186]  ? acpi_idle_do_entry+0x79/0xc0
[  700.610197]  acpi_idle_enter+0xbb/0x180
[  700.610209]  cpuidle_enter_state+0x9a/0x650
[  700.610223]  cpuidle_enter+0x2e/0x50
[  700.610234]  call_cpuidle+0x23/0x50
[  700.610245]  cpuidle_idle_call+0x11b/0x190
[  700.610253]  do_idle+0x82/0x100
[  700.610260]  cpu_startup_entry+0x1d/0x20
[  700.610267]  start_secondary+0x122/0x160
[  700.610279]  secondary_startup_64_no_verify+0xe5/0xeb
[  700.610294]  </TASK>
[  700.610328] ================================================================================

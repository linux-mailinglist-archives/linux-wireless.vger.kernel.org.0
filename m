Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE79F4B96CB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Feb 2022 04:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiBQDpI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Feb 2022 22:45:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBQDpH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Feb 2022 22:45:07 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE2C29C138
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 19:44:54 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id l125so10412356ybl.4
        for <linux-wireless@vger.kernel.org>; Wed, 16 Feb 2022 19:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rD10PjGpV82q/7yLVnBBBmkypvIjcdEwQBzwjiZ21AU=;
        b=ukjN/DmulWgEQYXf/86TxvVpPA46i3IBzwHg8QZtyHU/gCxS8gDaApGRaHgPVvLDJ8
         yyAG3eEeb4lMpb/tTGVN09NWdwui6cTAX7zpaoeU42QJIOnTSGd8ntajSpOQFujVV8z3
         J6KXZNvQquPZj7ulCCi8eJdVybFMqdU66Wk3Lbldv+yJ3M+UYH7FJGHoAUXx37OulD8i
         9ytBOlDG2Iv/NOQoCIF4+goOGCT6ueOknhnmXayMknaAUwQIClxCoFCMzxJz2JAIzhjE
         CVz5mSkGYQqWHM2kcfkSK4YoEn3BP/HKzYdzQazTqZfal4ZNO9dTsjgWoawal/4xuJUV
         cAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rD10PjGpV82q/7yLVnBBBmkypvIjcdEwQBzwjiZ21AU=;
        b=BQ8PrRxY+Jep1aiCv5kamYVvdEjiHwbedzib/Uayi/F3mC7RvvRedfef1C4hJVHKRU
         MkUV4qlijKRNePWwU/Hu+C+mv0RNynQda9zR2/7Wz/hfwS2lCVA6JTJjyMeQAmd7bb6k
         WjT3td82rl8SbDjc17m8dgvsq53DR1PliubVyQbkKBxAcIr2+QPIM+9cClXc9G8I+qeD
         YQePk3uA0NLMjpDERHMmxkoYCbhhY/SsWNq7uAl02vH8OrE2kVl7HoD0P/zUjoHfSIkK
         Jse20pYchyEFqTD5wEJ1O5u2uxK29gF2oizXCyofbh33i2mjXS5Ks9DInRqbjCQuXuDw
         x/ug==
X-Gm-Message-State: AOAM5323Nu7gg15HvcaK/4LsHwQCNhWx7WmpZFg5SRzjZS3zn0H3jloE
        azVMLRFvn4Vcx6eyBWadjN+kzhwTa48pXKWVsaZczXADUTlJaEY2
X-Google-Smtp-Source: ABdhPJxs+aWVyPrhCv1P2KnCkgz0QSIDmh/h1WsFLGdqiT1tpoG3JszvqypjqELGCUIjt+frvoJkhSWj+Ok5duZReQw=
X-Received: by 2002:a25:cc91:0:b0:623:d177:28c9 with SMTP id
 l139-20020a25cc91000000b00623d17728c9mr884520ybf.524.1645069493031; Wed, 16
 Feb 2022 19:44:53 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtQsvWMzVPDdLeGOwMWtZgfS3qLvFkPOtUbuFT640emW4w@mail.gmail.com>
In-Reply-To: <CAJCQCtQsvWMzVPDdLeGOwMWtZgfS3qLvFkPOtUbuFT640emW4w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 16 Feb 2022 20:44:37 -0700
Message-ID: <CAJCQCtQa+zpHHMsaAq2MYsdZ1bDTfZNyPBgi2Y1hs9OgWxihaw@mail.gmail.com>
Subject: Re: netconsole fail, iwlwifi, WARNING: at net/mac80211/tx.c:3638 ieee80211_tx_dequeue
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

So this is quite a bit more verbose with kernel
5.17.0-0.rc4.96.fc36.x86_64+debug.

Is netconsole expected to work from a host with wifi?

Snippet below, complete trace is at:
https://bugzilla.redhat.com/attachment.cgi?id=1861614



[ 4970.929723] kernel: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock
order detected
[ 4970.929726] kernel: 5.17.0-0.rc4.96.fc36.x86_64+debug #1 Tainted: G
       W        --------- ---
[ 4970.929728] kernel: -----------------------------------------------------
[ 4970.929729] kernel: modprobe/8230 [HC0[0]:SC0[2]:HE0:SE0] is trying
to acquire:
[ 4970.929734] kernel: ffff953c499b9070 (&fq->lock){+.-.}-{2:2}, at:
ieee80211_xmit_fast+0x412/0xb90 [mac80211]
[ 4970.929823] kernel:
                       and this task is already holding:
[ 4970.929824] kernel: ffffffffc1504618
(target_list_lock){....}-{2:2}, at: write_msg+0x48/0xf0 [netconsole]
[ 4970.929834] kernel: which would create a new lock dependency:
[ 4970.929835] kernel:  (target_list_lock){....}-{2:2} ->
(&fq->lock){+.-.}-{2:2}
[ 4970.929840] kernel:
                       but this new dependency connects a HARDIRQ-irq-safe lock:
[ 4970.929841] kernel:  (&ec->lock){-.-.}-{2:2}
[ 4970.929842] kernel:
                       ... which became HARDIRQ-irq-safe at:
[ 4970.929844] kernel:   lock_acquire+0xd0/0x2d0
[ 4970.929850] kernel:   _raw_spin_lock_irqsave+0x4f/0x90
[ 4970.929855] kernel:   acpi_ec_gpe_handler+0x1b/0x40
[ 4970.929860] kernel:   acpi_ev_detect_gpe+0x15a/0x1a0
[ 4970.929864] kernel:   acpi_ev_gpe_detect+0x10d/0x153
[ 4970.929866] kernel:   acpi_ev_sci_xrupt_handler+0x36/0x6a
[ 4970.929869] kernel:   acpi_irq+0x15/0x40
[ 4970.929873] kernel:   __handle_irq_event_percpu+0x90/0x330
[ 4970.929879] kernel:   handle_irq_event+0x34/0x70
[ 4970.929883] kernel:   handle_fasteoi_irq+0x90/0x1e0
[ 4970.929886] kernel:   __common_interrupt+0x6e/0x150
[ 4970.929889] kernel:   common_interrupt+0x5c/0xd0
[ 4970.929893] kernel:   asm_common_interrupt+0x1e/0x40
[ 4970.929897] kernel:   __do_softirq+0xcb/0x599
[ 4970.929901] kernel:   __irq_exit_rcu+0xf3/0x170
[ 4970.929905] kernel:   irq_exit_rcu+0xa/0x20
[ 4970.929908] kernel:   sysvec_apic_timer_interrupt+0x9e/0xc0
[ 4970.929912] kernel:   asm_sysvec_apic_timer_interrupt+0x12/0x20
[ 4970.929916] kernel:   _raw_spin_unlock_irqrestore+0x37/0x60
[ 4970.929919] kernel:   prepare_to_wait_event+0x72/0x190
[ 4970.929924] kernel:   ec_guard+0x154/0x1f0
[ 4970.929929] kernel:   acpi_ec_transaction+0x17e/0x400
[ 4970.929933] kernel:   acpi_ec_space_handler+0x117/0x270
[ 4970.929935] kernel:   acpi_ev_address_space_dispatch+0x304/0x3ac
[ 4970.929938] kernel:   acpi_ex_access_region+0x449/0x4e8
[ 4970.929943] kernel:   acpi_ex_field_datum_io+0x181/0x413
[ 4970.929947] kernel:   acpi_ex_extract_from_field+0x152/0x2e2
[ 4970.929951] kernel:   acpi_ex_read_data_from_field+0x303/0x34b
[ 4970.929955] kernel:   acpi_ex_resolve_node_to_value+0x366/0x480
[ 4970.929959] kernel:   acpi_ex_resolve_to_value+0x407/0x49b
[ 4970.929963] kernel:   acpi_ds_evaluate_name_path+0x9a/0x13c
[ 4970.929965] kernel:   acpi_ds_exec_end_op+0x111/0x7b1
[ 4970.929968] kernel:   acpi_ps_parse_loop+0x7ab/0x86a
[ 4970.929972] kernel:   acpi_ps_parse_aml+0x2db/0x57e
[ 4970.929976] kernel:   acpi_ps_execute_method+0x237/0x2ef
[ 4970.929980] kernel:   acpi_ns_evaluate+0x341/0x4e3
[ 4970.929983] kernel:   acpi_ut_evaluate_object+0xb1/0x24d
[ 4970.929986] kernel:   acpi_ut_execute_STA+0x45/0xf4
[ 4970.929989] kernel:   acpi_ns_get_device_callback+0x74/0x160
[ 4970.929993] kernel:   acpi_ns_walk_namespace+0x137/0x29e
[ 4970.929996] kernel:   acpi_get_devices+0xd1/0x10c
[ 4970.930000] kernel:   pnpacpi_init+0x4b/0x6a
[ 4970.930005] kernel:   do_one_initcall+0x66/0x350
[ 4970.930009] kernel:   kernel_init_freeable+0x28e/0x2cf
[ 4970.930013] kernel:   kernel_init+0x16/0x130
[ 4970.930015] kernel:   ret_from_fork+0x1f/0x30
[ 4970.930019] kernel:
                       to a HARDIRQ-irq-unsafe lock:
[ 4970.930020] kernel:  (&fq->lock){+.-.}-{2:2}
[ 4970.930022] kernel:
                       ... which became HARDIRQ-irq-unsafe at:
[ 4970.930023] kernel: ...
[ 4970.930024] kernel:   lock_acquire+0xd0/0x2d0
[ 4970.930027] kernel:   _raw_spin_lock_bh+0x38/0x80
[ 4970.930030] kernel:   ieee80211_get_txq_stats+0x49/0x190 [mac80211]
[ 4970.930097] kernel:   rdev_get_txq_stats+0x50/0x130 [cfg80211]
[ 4970.930164] kernel:   nl80211_send_iface+0x38c/0x9d0 [cfg80211]
[ 4970.930221] kernel:   nl80211_notify_iface+0x48/0xa0 [cfg80211]
[ 4970.930279] kernel:   cfg80211_register_netdevice+0x7c/0xf0 [cfg80211]
[ 4970.930328] kernel:   ieee80211_if_add+0x4eb/0x820 [mac80211]
[ 4970.930403] kernel:   ieee80211_register_hw+0xc93/0xcb0 [mac80211]
[ 4970.930459] kernel:   iwl_mvm_mac_setup_register+0xb41/0xc90 [iwlmvm]
[ 4970.930482] kernel:   iwl_mvm_start_post_nvm+0x4f/0xd0 [iwlmvm]
[ 4970.930501] kernel:   iwl_op_mode_mvm_start+0xb0e/0xb80 [iwlmvm]
[ 4970.930521] kernel:   _iwl_op_mode_start+0x98/0xc0 [iwlwifi]
[ 4970.930546] kernel:   iwl_opmode_register+0x6a/0xd0 [iwlwifi]
[ 4970.930568] kernel:   tcc_get_cur_state+0x24/0x40 [intel_tcc_cooling]
[ 4970.930572] kernel:   do_one_initcall+0x66/0x350
[ 4970.930576] kernel:   do_init_module+0x4a/0x260
[ 4970.930580] kernel:   __do_sys_init_module+0x13a/0x190
[ 4970.930583] kernel:   do_syscall_64+0x37/0x80
[ 4970.930587] kernel:   entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 4970.930591] kernel:
                       other info that might help us debug this:
[ 4970.930592] kernel: Chain exists of:

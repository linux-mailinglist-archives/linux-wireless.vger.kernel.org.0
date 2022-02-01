Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AD54A5BAC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 13:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiBAMAe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 07:00:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237302AbiBAMAd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 07:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643716833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4xKRPjaNFTaZyXq6DTWqiwowWqcQLL9P4oPdENZUIeQ=;
        b=AVY0i9T2O0yWchlR/A/gduPuGM8/OE3Z+rRIcFEDn+Sl5r45ShqnctJ81VpmI85n6Unx/u
        J5p6yG+NGSBuwU5MO8Q5OPBf4q4MIqy+yiTDt62EO+cedjFy3TTvszqqD7UVMXUxa59kU4
        TB4RwkyjMypL1zg1bCnNPaKn4IxddNU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-PjKfCaFWPZaQDMEzkAGQcw-1; Tue, 01 Feb 2022 07:00:32 -0500
X-MC-Unique: PjKfCaFWPZaQDMEzkAGQcw-1
Received: by mail-qt1-f200.google.com with SMTP id g13-20020ac8774d000000b002cf75f5b13aso12718390qtu.11
        for <linux-wireless@vger.kernel.org>; Tue, 01 Feb 2022 04:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=4xKRPjaNFTaZyXq6DTWqiwowWqcQLL9P4oPdENZUIeQ=;
        b=Bw1scsxUTSLV1KbA6LntRoVpmnWU/WP+3PP+q1s+lj0AXwMiva6UxZoh72U+4NfNaQ
         XuOGKRnBFGNby9lIT0tjvMsF/MnRlb0JesbvYDgVylJ+LfuPOmfy1HMp2gG2u6kj2Y+E
         sspyEAS9UaMT6AhYkp8OjlgdbFwg5gb09beJ/GG+rIAvKvoCQ5rA80bUE0dECPJxN1Ht
         NlyzlRWXxpNAMo0XpW/1V6Uxtl5zlNs0ERkxqGR5BC47GNCpwrwRolhfF3XKs/SslSQv
         EE92vPqOyPQi0jbKR6RJgNiF0OmbM4QFHKIZ35poiIR3nX4XflUT7UHOmkMbLvpRCMpr
         nP1Q==
X-Gm-Message-State: AOAM530b2HBcmaPRKMBr8tiWXfY1GpOhadNjuY17wrVidlXtmrntytNF
        3goMXByU1dUoR/hivI3Fmf1cdZhg9ZzE3Qd/uvs8fx7cLEziRag1tBnHj5p4GnTzGLodd+hmVAT
        NnMCv7relL3jhPeOQqUGSRghtjjE=
X-Received: by 2002:ad4:5b85:: with SMTP id 5mr16873017qvp.1.1643716830051;
        Tue, 01 Feb 2022 04:00:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyeJt69MNOFbsJelEEzHgKyJo/TE5OGWQD4E/ymAJ6RJaTqnFzwPAMqlnSI/bGNTLOIQso/dA==
X-Received: by 2002:ad4:5b85:: with SMTP id 5mr16872971qvp.1.1643716829437;
        Tue, 01 Feb 2022 04:00:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b4sm9884620qkf.61.2022.02.01.04.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 04:00:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F3A6D1806B5; Tue,  1 Feb 2022 13:00:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Another hang in cfg80211_destroy_iface_wk()
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Feb 2022 13:00:26 +0100
Message-ID: <87leyuu78l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes

I'm running into a deadlock on my laptop that on the face of it seems to
be similar to the one you fixed back in April in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea6b2098dd02789f68770fd3d5a373732207be2f

Only this happens on my pristine 5.16.3-arch1-1 kernel. It does involve
iwd, though; looks like iwd is crashing, which I guess causes the
interface to get torn down, causing the hang?

I left 'dmesg -w' running while this happened, and got the splats below
more or less simultaneously - any clue what might be going on here?

-Toke

[54189.370954] INFO: task kworker/4:2:131133 blocked for more than 122 seconds.
[54189.370966]       Tainted: G     U     OE     5.16.3-arch1-1 #1
[54189.370971] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[54189.370974] task:kworker/4:2     state:D stack:    0 pid:131133 ppid:     2 flags:0x00004000
[54189.370987] Workqueue: events cfg80211_destroy_iface_wk [cfg80211]
[54189.371089] Call Trace:
[54189.371092]  <TASK>
[54189.371100]  __schedule+0x307/0x10d0
[54189.371116]  ? preempt_schedule_thunk+0x16/0x18
[54189.371129]  schedule+0x4b/0xd0
[54189.371136]  schedule_preempt_disabled+0x11/0x20
[54189.371143]  __mutex_lock.constprop.0+0x256/0x450
[54189.371160]  cfg80211_netdev_notifier_call+0x13a/0x500 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.371252]  raw_notifier_call_chain+0x44/0x60
[54189.371261]  __dev_close_many+0x70/0x130
[54189.371270]  dev_close_many+0x9c/0x150
[54189.371277]  unregister_netdevice_many+0x16a/0x760
[54189.371288]  unregister_netdevice_queue+0xe4/0x120
[54189.371297]  _cfg80211_unregister_wdev+0x14a/0x1e0 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.371374]  ieee80211_if_remove+0x92/0x120 [mac80211 8b88b4a7d6e6c9d99095e6aeff6275c4c2fc1d1d]
[54189.371496]  ieee80211_del_iface+0xe/0x20 [mac80211 8b88b4a7d6e6c9d99095e6aeff6275c4c2fc1d1d]
[54189.371601]  cfg80211_destroy_ifaces+0xf4/0x1f0 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.371683]  cfg80211_destroy_iface_wk+0x1a/0x20 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.371757]  process_one_work+0x1e8/0x3c0
[54189.371766]  worker_thread+0x50/0x3c0
[54189.371772]  ? rescuer_thread+0x380/0x380
[54189.371778]  kthread+0x15c/0x180
[54189.371788]  ? set_kthread_struct+0x50/0x50
[54189.371797]  ret_from_fork+0x22/0x30
[54189.371811]  </TASK>
[54189.371820] INFO: task kworker/u16:1:136559 blocked for more than 122 seconds.
[54189.371826]       Tainted: G     U     OE     5.16.3-arch1-1 #1
[54189.371829] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[54189.371832] task:kworker/u16:1   state:D stack:    0 pid:136559 ppid:     2 flags:0x00004000
[54189.371841] Workqueue: netns cleanup_net
[54189.371852] Call Trace:
[54189.371854]  <TASK>
[54189.371858]  __schedule+0x307/0x10d0
[54189.371867]  ? schedule+0x4b/0xd0
[54189.371873]  ? wq_worker_running+0xa/0x50
[54189.371881]  schedule+0x4b/0xd0
[54189.371887]  schedule_preempt_disabled+0x11/0x20
[54189.371894]  __mutex_lock.constprop.0+0x256/0x450
[54189.371904]  cfg80211_pernet_exit+0xf/0x70 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.371981]  ops_exit_list+0x33/0x70
[54189.371989]  cleanup_net+0x213/0x3c0
[54189.371998]  process_one_work+0x1e8/0x3c0
[54189.372006]  worker_thread+0x50/0x3c0
[54189.372011]  ? rescuer_thread+0x380/0x380
[54189.372017]  kthread+0x15c/0x180
[54189.372025]  ? set_kthread_struct+0x50/0x50
[54189.372035]  ret_from_fork+0x22/0x30
[54189.372047]  </TASK>
[54189.372050] INFO: task kworker/4:0:137246 blocked for more than 122 seconds.
[54189.372054]       Tainted: G     U     OE     5.16.3-arch1-1 #1
[54189.372057] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[54189.372060] task:kworker/4:0     state:D stack:    0 pid:137246 ppid:     2 flags:0x00004000
[54189.372068] Workqueue: events cfg80211_mgmt_registrations_update_wk [cfg80211]
[54189.372173] Call Trace:
[54189.372175]  <TASK>
[54189.372179]  __schedule+0x307/0x10d0
[54189.372186]  ? update_load_avg+0x7e/0x600
[54189.372198]  schedule+0x4b/0xd0
[54189.372204]  schedule_preempt_disabled+0x11/0x20
[54189.372210]  __mutex_lock.constprop.0+0x256/0x450
[54189.372219]  ? __schedule+0x30f/0x10d0
[54189.372227]  cfg80211_mgmt_registrations_update_wk+0x1f/0x50 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.372327]  process_one_work+0x1e8/0x3c0
[54189.372334]  worker_thread+0x50/0x3c0
[54189.372340]  ? rescuer_thread+0x380/0x380
[54189.372345]  kthread+0x15c/0x180
[54189.372354]  ? set_kthread_struct+0x50/0x50
[54189.372363]  ret_from_fork+0x22/0x30
[54189.372375]  </TASK>
[54189.372378] INFO: task kworker/4:3:137260 blocked for more than 122 seconds.
[54189.372381]       Tainted: G     U     OE     5.16.3-arch1-1 #1
[54189.372384] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[54189.372386] task:kworker/4:3     state:D stack:    0 pid:137260 ppid:     2 flags:0x00004000
[54189.372394] Workqueue: events linkwatch_event
[54189.372405] Call Trace:
[54189.372407]  <TASK>
[54189.372410]  __schedule+0x307/0x10d0
[54189.372421]  schedule+0x4b/0xd0
[54189.372427]  schedule_preempt_disabled+0x11/0x20
[54189.372433]  __mutex_lock.constprop.0+0x256/0x450
[54189.372443]  linkwatch_event+0xa/0x30
[54189.372452]  process_one_work+0x1e8/0x3c0
[54189.372458]  worker_thread+0x50/0x3c0
[54189.372464]  ? rescuer_thread+0x380/0x380
[54189.372469]  kthread+0x15c/0x180
[54189.372477]  ? set_kthread_struct+0x50/0x50
[54189.372487]  ret_from_fork+0x22/0x30
[54189.372498]  </TASK>
[54189.372500] INFO: task kworker/4:4:137263 blocked for more than 122 seconds.
[54189.372504]       Tainted: G     U     OE     5.16.3-arch1-1 #1
[54189.372506] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[54189.372508] task:kworker/4:4     state:D stack:    0 pid:137263 ppid:     2 flags:0x00004000
[54189.372515] Workqueue: events disconnect_work [cfg80211]
[54189.372612] Call Trace:
[54189.372615]  <TASK>
[54189.372618]  __schedule+0x307/0x10d0
[54189.372628]  schedule+0x4b/0xd0
[54189.372634]  schedule_preempt_disabled+0x11/0x20
[54189.372640]  __mutex_lock.constprop.0+0x256/0x450
[54189.372651]  disconnect_work+0x12/0xd0 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.372749]  process_one_work+0x1e8/0x3c0
[54189.372756]  worker_thread+0x50/0x3c0
[54189.372762]  ? rescuer_thread+0x380/0x380
[54189.372767]  kthread+0x15c/0x180
[54189.372775]  ? set_kthread_struct+0x50/0x50
[54189.372785]  ret_from_fork+0x22/0x30
[54189.372797]  </TASK>
[54189.372801] INFO: task iwd:137266 blocked for more than 122 seconds.
[54189.372805]       Tainted: G     U     OE     5.16.3-arch1-1 #1
[54189.372808] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[54189.372810] task:iwd             state:D stack:    0 pid:137266 ppid:     1 flags:0x00000000
[54189.372816] Call Trace:
[54189.372818]  <TASK>
[54189.372821]  __schedule+0x307/0x10d0
[54189.372831]  schedule+0x4b/0xd0
[54189.372837]  schedule_preempt_disabled+0x11/0x20
[54189.372843]  __mutex_lock.constprop.0+0x256/0x450
[54189.372853]  nl80211_dump_wiphy+0x22/0x1b0 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.372946]  netlink_dump+0x165/0x2e0
[54189.372960]  __netlink_dump_start+0x1b0/0x2e0
[54189.372972]  genl_family_rcv_msg_dumpit+0xf4/0x1b0
[54189.372980]  ? genl_family_rcv_msg_doit+0x170/0x170
[54189.372986]  ? nl80211_send_wiphy+0x2e80/0x2e80 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.373077]  ? genl_family_rcv_msg_dumpit+0x1b0/0x1b0
[54189.373085]  genl_rcv_msg+0x161/0x1f0
[54189.373091]  ? nl80211_dump_wiphy+0x1b0/0x1b0 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.373181]  ? nl80211_send_wiphy+0x2e80/0x2e80 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.373269]  ? nl80211_register_unexpected_frame+0x50/0x50 [cfg80211 a54daa6064550d2f8e9fbeda732654ff2f76efba]
[54189.373355]  ? genl_get_cmd+0x100/0x100
[54189.373362]  netlink_rcv_skb+0x5b/0x110
[54189.373375]  genl_rcv+0x24/0x40
[54189.373380]  netlink_unicast+0x246/0x360
[54189.373391]  netlink_sendmsg+0x24f/0x4b0
[54189.373403]  sock_sendmsg+0x64/0x70
[54189.373414]  __sys_sendto+0x128/0x1a0
[54189.373431]  __x64_sys_sendto+0x20/0x40
[54189.373441]  do_syscall_64+0x5c/0x90
[54189.373448]  ? do_user_addr_fault+0x1d7/0x6a0
[54189.373459]  ? syscall_exit_to_user_mode+0x23/0x50
[54189.373470]  ? exc_page_fault+0x72/0x180
[54189.373478]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[54189.373490] RIP: 0033:0x7fb47b8afc10
[54189.373497] RSP: 002b:00007ffc248a7a58 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[54189.373504] RAX: ffffffffffffffda RBX: 00005588eae52c80 RCX: 00007fb47b8afc10
[54189.373509] RDX: 0000000000000018 RSI: 00005588eae5d820 RDI: 0000000000000004
[54189.373513] RBP: 00005588eae699c0 R08: 0000000000000000 R09: 0000000000000000
[54189.373517] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc248a7af0
[54189.373521] R13: 00007ffc248a7aec R14: 00005588eae5c910 R15: 00005588e95b07a5
[54189.373530]  </TASK>


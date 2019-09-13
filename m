Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A51ABB17F4
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 07:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfIMFv2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 01:51:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46959 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfIMFv1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 01:51:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so21143269lfc.13
        for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2019 22:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=agilox-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TJ0a60AMtR+Mu+EmlgUJjAR19eDrGBSK0DxhiEDvsGk=;
        b=gK8hUN5F2VmDdZlQCRi59jTbd3UoTpOBLAfEEBHVl32itTq18QANCyA4iBHOnZGZuR
         846k7k44tajRKsJKcezbYfmMlCmMM26nwF2aeVlirIStPHynewlqlDLJqlGtmAxtUvPy
         2K+tugHc0hxgYLddIMsAV3oach7fJvwY40osz7ly6b4LIp7w7bdsb8/F4x4u+/7u9xuT
         J5xUGkp195XBAJNoFeVdi1iHIGC22wafKMu4jvsi5nL4N7r/c5n1nIw8gScLq5YmcfFb
         Dc6uZtYTJAxj1x084yTygPYpFjjtEYIsDE30VJ4RCvHnDLpc3G32MQFZX6COEKoJwSdH
         IOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TJ0a60AMtR+Mu+EmlgUJjAR19eDrGBSK0DxhiEDvsGk=;
        b=GU+gTGEOAGfNm3yEpDZB25DNZZ9SEgNLed/JZfiHW6YXohayRv43i4tNW+iQYkGxTh
         YnYqv1oms0zk3qaatKIJdWqaAjolPcw74WR/iovRsmXkUtfy3+/K0KgiEjSrELMfsdFD
         aZ6TQ0a86aRUBgzdj9wIDA46M8XJnz1djQE96QwHeNAuFwI2qbSzPC2Vrum0WFMhDQPK
         p4+4SAmMo/Lw1NSln0NBLyHSpq0wzKw1GUWzgVdkROra2Y0+5yvgrmIERE5CFRb2/B5o
         9Q1cy1pEhqhlvU4co4KFFZitpawvWLWnMaqkdzBFdZoKiSqNxbJFKqJjhpl6o2Fdkpg6
         /RfQ==
X-Gm-Message-State: APjAAAWjcYiYcbGuxChzhCE+oa1QzWc1XcwM9TEkTeTCa+CwFQNcGfXH
        fQcvjDIT6VY9wwRwmbAovRL95SWRMGo+MOtaakBTKx2fLD4=
X-Google-Smtp-Source: APXvYqxZvCjW6rOxBFIw4UkvnKzRJNigQIV9xUCHeptqrlzaJf9XtSDNQyhMj+iglfVAnKcVLrWKHFs+8XmqZgDjEj8=
X-Received: by 2002:a19:4f07:: with SMTP id d7mr10524380lfb.161.1568353885284;
 Thu, 12 Sep 2019 22:51:25 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Redlinger <rel+kernel@agilox.net>
Date:   Fri, 13 Sep 2019 07:51:09 +0200
Message-ID: <CAN5HydrWb3o_FE6A1XDnP1E+xS66d5kiEuhHfiGKkLNQokx13Q@mail.gmail.com>
Subject: BUG: using smp_processor_id() in preemptible [00000000] code: wpa_supplicant
To:     linux-wireless@vger.kernel.org
Cc:     j@w1.fi
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

on Arch Linux 5.2.11 with wpa_supplicant 2.8 / 2.9 our systems
increasingly show this issue:

[72770.969617] BUG: using smp_processor_id() in preemptible [00000000]
code: wpa_supplicant/16207
[72770.969638] caller is ieee80211_xmit_fast_finish+0x5a/0x1e0 [mac80211]
[72770.969640] CPU: 2 PID: 16207 Comm: wpa_supplicant Tainted: G
 W         5.2.11-arch1-1-ARCH #1
[72770.969641] Hardware name: CINCOZE DI-1000/DI-1000, BIOS 5.11 02/20/2019
[72770.969642] Call Trace:
[72770.969647]  dump_stack+0x5c/0x80
[72770.969661]  debug_smp_processor_id+0xde/0xe0
[72770.969674]  ieee80211_xmit_fast_finish+0x5a/0x1e0 [mac80211]
[72770.969687]  ieee80211_tx_dequeue+0x472/0xb50 [mac80211]
[72770.969695]  iwl_mvm_mac_itxq_xmit+0x6f/0x100 [iwlmvm]
[72770.969721]  _ieee80211_wake_txqs+0x218/0x450 [mac80211]
[72770.969733]  ieee80211_wake_queues_by_reason+0x7a/0xd0 [mac80211]
[72770.969745]  ieee80211_set_disassoc+0x48d/0x5d0 [mac80211]
[72770.969760]  ieee80211_mgd_deauth.cold+0x4a/0x3f4 [mac80211]
[72770.969797]  cfg80211_mlme_deauth+0xc1/0x220 [cfg80211]
[72770.969809]  nl80211_deauthenticate+0xd8/0x120 [cfg80211]
[72770.969813]  genl_family_rcv_msg+0x1f3/0x470
[72770.969815]  genl_rcv_msg+0x47/0x90
[72770.969818]  ? __kmalloc_node_track_caller+0x1b7/0x2d0
[72770.969819]  ? genl_family_rcv_msg+0x470/0x470
[72770.969820]  netlink_rcv_skb+0x75/0x140
[72770.969822]  genl_rcv+0x24/0x40
[72770.969823]  netlink_unicast+0x177/0x1f0
[72770.969824]  netlink_sendmsg+0x1fe/0x3c0
[72770.969827]  sock_sendmsg+0x4f/0x60
[72770.969828]  ___sys_sendmsg+0x304/0x370
[72770.969831]  ? unix_ioctl+0x99/0x190
[72770.969834]  __sys_sendmsg+0x81/0xd0
[72770.969850]  do_syscall_64+0x5f/0x1d0
[72770.969851]  ? prepare_exit_to_usermode+0x85/0xb0
[72770.969853]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[72770.969855] RIP: 0033:0x7f0bf1c83598
[72770.969857] Code: 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00
00 00 f3 0f 1e fa 48 8d 05 85 4c 0c 00 8b 00 85 c0 75 17 b8 2e 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28
89 54
[72770.969857] RSP: 002b:00007ffc3580a188 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[72770.969859] RAX: ffffffffffffffda RBX: 0000555f92d1e8c0 RCX: 00007f0bf1c83598
[72770.969859] RDX: 0000000000000000 RSI: 00007ffc3580a1c0 RDI: 0000000000000004
[72770.969860] RBP: 0000555f92da0bc0 R08: 0000000000000004 R09: 000000000000000d
[72770.969860] R10: 00007ffc3580a294 R11: 0000000000000246 R12: 0000555f92d1e7d0
[72770.969861] R13: 00007ffc3580a1c0 R14: 00007ffc3580a294 R15: 0000555f92de7c40

Somebody already filed a bug here:
https://bugzilla.kernel.org/show_bug.cgi?id=204127

Do you guys need any more information? I do have 12 systems at a
costumer alternating between
https://bugzilla.kernel.org/show_bug.cgi?id=204127 and
https://bugzilla.kernel.org/show_bug.cgi?id=203805 ;-) so I could
provide more logs if needed...

Thanks in advance!

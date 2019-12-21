Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38411128BD2
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2019 23:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLUW6n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Dec 2019 17:58:43 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:44007 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUW6m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Dec 2019 17:58:42 -0500
Received: by mail-io1-f49.google.com with SMTP id n21so11349267ioo.10;
        Sat, 21 Dec 2019 14:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2ZhCc0nXVz+eHUsJdbDzJJziYPwRlHUdb+178cJrsjg=;
        b=l58kL1H9jmQRFKrLNF30maOoUXUHssWn5do/yLJGAybICin5XXMzvxsvjTpS2+t/0Z
         guWLmFFYbeVQu5aggS3ihoM83PjzHsF2hdoO/OGU6hH8+00PLUfrEDzxzqFkIcNlbc+b
         5JRDtmHCKzAgjK+aBCpwcHSzvXc8Rs/B3HglIq/uBcfg2NeH/9n7enW7yslmU2tY6RZn
         J7TC5l8jMZtZBe2JuJgmxPawl4BwFjorO55LZYdiJMPtBgu3Vfl3M7tWR6t0f5G5gqlY
         dylydKMCufAkDRiwIC9s7ExxorX/TMBgcSOQtPG0JNz5vnKdPMBnOmbUh0uYsViWFFWC
         Bjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2ZhCc0nXVz+eHUsJdbDzJJziYPwRlHUdb+178cJrsjg=;
        b=nYvYhMw4BJVa/XBB0JwHWRSD4d7/hXEDMjb3rrwlUkEqOKgHKxF/Z7CCub8p4fF0dt
         p3h3odBTI44RmBsWr0Hvtg53RAzsXV5ejAF0EsKAJ98bZyc8fE4HtLmrdTEzIf3TkIcu
         RP3cVS8dc9ZHdJrXUuwDosMfEvjs2X50KpdhxBxI+v1m1DvWtxodX5oc4k7KabKkRyWP
         PBHVg9VqdLjjApSWTwPVnfoxef2Fi2PUCjWcsYhVLKymYWjsemNLrSgKBfXfXio4MAcp
         jk3Vs6gH0zfJxfUIyidKxAfeIZUKAmwG8rJ1jwbS5igCjvSZkUC/XDY/dxPoamcLJA5j
         c0SQ==
X-Gm-Message-State: APjAAAXaD0t9hng9B+BZ7W6074UjADWA3RZrEyLIiVRBSwlAhz+qauLT
        2BPxS5DKX875MmDCKLIShCQY4k+gGOFQJJkCV9Xbvg==
X-Google-Smtp-Source: APXvYqyEY3v6lE+EJyMz9A26EHUhGhDOZZ5tanIW8pVJUktVMhtIqcAEivWOHGKtyjIjMFDVxHwq9aDnxAT6V37YpPA=
X-Received: by 2002:a02:c951:: with SMTP id u17mr18924307jao.27.1576969121593;
 Sat, 21 Dec 2019 14:58:41 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 21 Dec 2019 16:58:30 -0600
Message-ID: <CAH2r5mu5NC+QxAuECihhFdMgJjZVeoOqj1aQv+RR+kscHYH_hw@mail.gmail.com>
Subject: Oops in ieee80211 driver on 5.5-rc2
To:     linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I saw this oops again in the ieee80211 driver again today when the
laptop was started at a connecting to a new WiFi in different location
(in a fast food restaurant instead of at home or work).  I hadn't seen
it connecting to Wifi at home for a while.

.x86_64 #1
[   66.632041] Hardware name: LENOVO 20MAS08500/20MAS08500, BIOS
N2CET48W (1.31 ) 11/04/2019
[   66.632047] RIP:
0010:ieee80211_sta_update_pending_airtime+0xed/0x120 [mac80211]
[   66.632048] Code: 8b b2 90 01 00 00 48 85 f6 75 07 48 8b b2 40 01
00 00 41 89 e8 89 c1 44 89 ea 48 c7 c7 58 3d 08 c1 89 44 24 04 e8 e5
6c 0d ef <0f> 0b 8b 44 24 04 eb 9d 48 83 c6 40 41 89 e8 89 c1 48 c7 c7
20 3d
[   66.632049] RSP: 0018:ffffb0ef40c53ba8 EFLAGS: 00010286
[   66.632049] RAX: 0000000000000000 RBX: 00000000ffffffb0 RCX: 0000000000000000
[   66.632049] RDX: 000000000000003a RSI: ffffffffb215047a RDI: 0000000000000246
[   66.632050] RBP: 0000000000000050 R08: 0000000f839398c6 R09: 000000000000003a
[   66.632050] R10: 0000000000000001 R11: 00000000b2150446 R12: ffff9d76f2db87c0
[   66.632051] R13: 0000000000000002 R14: ffff9d76a2c5a5c8 R15: ffff9d76f0833d00
[   66.632051] FS:  0000000000000000(0000) GS:ffff9d76fbcc0000(0000)
knlGS:0000000000000000
[   66.632052] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   66.632052] CR2: 00001cab696ac008 CR3: 000000081492e006 CR4: 00000000003606e0
[   66.632052] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   66.632053] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   66.632053] Call Trace:
[   66.632060]  __ieee80211_tx_status+0x720/0x900 [mac80211]
[   66.632066]  ieee80211_tx_status+0x6a/0x90 [mac80211]
[   66.632070]  iwl_mvm_tx_reclaim+0x2a2/0x3c0 [iwlmvm]
[   66.632074]  iwl_mvm_rx_ba_notif+0xff/0x2e0 [iwlmvm]
[   66.632076]  ? __switch_to_asm+0x40/0x70
[   66.632079]  iwl_mvm_rx_common+0xdd/0x2c0 [iwlmvm]
[   66.632083]  iwl_pcie_rx_handle+0x3af/0x9c0 [iwlwifi]
[   66.632085]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[   66.632088]  iwl_pcie_irq_rx_msix_handler+0x45/0x80 [iwlwifi]
[   66.632089]  irq_thread_fn+0x20/0x60
[   66.632090]  irq_thread+0xdc/0x170
[   66.632091]  ? irq_forced_thread_fn+0x80/0x80
[   66.632092]  kthread+0xf9/0x130
[   66.632093]  ? irq_thread_check_affinity+0xf0/0xf0
[   66.632094]  ? kthread_park+0x90/0x90
[   66.632095]  ret_from_fork+0x35/0x40
[   66.632096] ---[ end trace 9f6b29cb2168e61f ]---


--
Thanks,

Steve

Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121457D2202
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 10:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJVI6O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVI6O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 04:58:14 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC7F4
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1697965088; x=1698569888; i=jwollrath@web.de;
        bh=S6km8YIhENyXRJN7imLF4N/ccLQEeE9D4UB280cKzSU=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=rDgIfqZSiXZ30nMcH3KX03x0ZjBe6nvqEYkB3RVvUZxMj/npMD0PrKwzdh/grH3M
         Tb3iUYjCqXZrka96wM13kprfrLBXnQNloE3hq5Uz3I1bgknywtGzbI8Uh4fooDuSN
         OjfKUZ3YcPExQPtyj1583biTDFl0HkGqGa/Z2qIe+gKwmfkPuaY1kRRI/K9Qibn1A
         OaXnfvP3Kiw60SPbXCIeb08jS9/8BwX/HCT7vLkb+Za1tVM89jJafriS5b2K3PvuG
         Dm7f4UdsPOyw6nBFLLIOxrxBEzbW3s461ppJnvThQC0oiIMOlsqFjswZHzitDW+sU
         /OQizIree/xIQa7qPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mayene ([178.196.174.8]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsrdM-1rnHrc2W1Q-00tCGZ for
 <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 10:58:08 +0200
Date:   Sun, 22 Oct 2023 10:58:07 +0200
From:   Julian Wollrath <jwollrath@web.de>
To:     linux-wireless@vger.kernel.org
Subject: v6.6-rc6+: ath11k not available after hibernation with trace
Message-ID: <20231022105807.5a210fe9@mayene>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9HKeArEUsVL25SoRfXm8uOuk6ee5QSJ27eIyR2C5TbQS7CxI41z
 eqbwklZX3FS/TQi9qpMKf7ilr+VMOSL3w0GB9Os077sWCDFPpuATtS/ePiDcFNfQviSkBxs
 8wWldG6R19er8SX6kxQdzbYZ+pd0VuFOaeM9rbWffg6S0M+6tNu0/j2+YTfiIoBg6SewtoJ
 hCsNT7Gs+qj6lCC9PGaDA==
UI-OutboundReport: notjunk:1;M01:P0:ly33MYTrA+M=;d6ndBE/VRw670pOUm9h22KBLTBa
 bx9QTLdMs2owgZAiqkGsD2zdAKvgYPpBPslc3JXeMuX3FaUq4h3U6F9YYXlhu9PbDZVCsRjag
 IvMG4NSnSBYVoqEtNat821bFHDeZ1la36htQOy4OXR06FixoWX4AmSKAEzUebglak44PvsIUq
 cIb2+eFEG1/acaQ6bHjR3aadD9gdlvwDnLIo03MrDhx9I5wNCMNo71++NWHbILsf53MfE6/ch
 3X/ecgTOYzHBRkf72MjhlUsg4cYtf5bI7R8V+hiNwvn3fAPYUVQn8E4Bk8ZRO61b6QRTv8CuL
 xMIrntRrEcQDyCCiIP+0Ux/Vn23TdWmWrjrtwSenLSepnNyEh3NbKkb3Pins04UAf+y1PxQw9
 zDhy0EazBghD9Kqs0KcW5h5b9C8X9qlnMpTUUK3oBFSg1QQ4mmK9E114TQcMuqs3Da3JZplEq
 56nAQJZK0lMgA/zgimeVUw7Qz0RFLemTZrtkC37Gs9fDo8y1eGRiPANgBrwHp4IepgtUQMOut
 d/dqrmgNgfr/dFvaVxaeqiEo3hBJOHZ8sQa+HyL8RgrzlTjtDj36UTxWCkcE9ZdfYgtafFuBI
 ja/2jXPTP+01DD2yhih/fIlFBxzADe+OPaLfYoXj83mYWOe4yB1TJMwJYPIKonKN+N87iGfSW
 623HPwkPZU+6QM+qVpAVtu/TZRCHAHcdjpO7A/Jtx/XN5RskTmXoK5Vnmp4lF9oUlhFOZynJC
 EZa0YwUOzsUI3Ft4zvTppzumZiEPbG04beDO0muGPt4q3NDoXLp/vqCtDFfrFeMsf02G00TvK
 g7ZajXKwyY/7ua8WdvFElOc4FsMy0cCFa/UT0+DCshlFbXmcLDwqN24ikbXkD/SN0oaaz2B8y
 itw27c2p0kh42il4h0Ws5nVFaeB0i/rllExDHe4T0QBJ2lcRRq16dTpJb+ZyFJRngO6ORlo9y
 KCf9SQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear maintainers,

on v6.6-rc6+ (git commit 9c5d00cb7b6b) the QCNFA765 (17cb:1103) adapter
does not work after resuming from hibernation to disk. I see the
following in the kernel log:

mhi mhi0: Did not enter M0 state, MHI state: M3, PM state: M3->M0
ath11k_pci 0000:02:00.0: failed to resume mhi: -5
ath11k_pci 0000:02:00.0: failed to resume hif during resume: -5
ath11k_pci 0000:02:00.0: failed to resume core: -5
ath11k_pci 0000:02:00.0: PM: dpm_run_callback(): pci_pm_restore+0x0/0xe0 r=
eturns -5
ath11k_pci 0000:02:00.0: PM: failed to restore async: error -5
ath11k_pci 0000:02:00.0: wmi command 16387 timeout
ath11k_pci 0000:02:00.0: failed to send WMI_PDEV_SET_PARAM cmd
ath11k_pci 0000:02:00.0: failed to enable dynamic bw: -11
=2D-----------[ cut here ]------------
Hardware became unavailable upon resume. This could be a software issue pr=
ior to suspend or a hardware issue.
WARNING: CPU: 10 PID: 91402 at net/mac80211/util.c:2568 ieee80211_reconfig=
+0x9c/0x17f0 [mac80211]
CPU: 10 PID: 91402 Comm: kworker/u32:48 Not tainted 6.6.0-rc6+ #7
Hardware name: LENOVO 21K4S07400/21K4S07400, BIOS R2FET31W (1.11 ) 08/03/2=
023
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:ieee80211_reconfig+0x9c/0x17f0 [mac80211]
Code: ad 02 00 00 c6 85 8d 05 00 00 00 48 89 ef e8 9b ae fb ff 41 89 c5 85=
 c0 0f 84 bc 02 00 00 48 c7 c7 e0 cb 21 c1 e8 24 f1 cd c4 <0f> 0b eb 2d 84=
 c0 0f 85 56 01 00 00 c6 87 8d 05 00 00 00 e8 6c ae
RSP: 0018:ffffb298c9f57cc8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffa0d9b9120538 RCX: 0000000000000027
RDX: ffffa0e0bee9b3c8 RSI: 0000000000000001 RDI: ffffa0e0bee9b3c0
RBP: ffffa0d9b91208e0 R08: ffffffff86f73de0 R09: 0a2e657573736920
R10: 646e657073757320 R11: 6168206120726f20 R12: 0000000000000040
R13: 00000000fffffff5 R14: 0000000000000000 R15: ffffa0d9800514b0
FS:  0000000000000000(0000) GS:ffffa0e0bee80000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000623210000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? ieee80211_reconfig+0x9c/0x17f0 [mac80211]
 ? __warn+0x81/0x130
 ? ieee80211_reconfig+0x9c/0x17f0 [mac80211]
 ? report_bug+0x171/0x1a0
 ? handle_bug+0x3a/0x70
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? ieee80211_reconfig+0x9c/0x17f0 [mac80211]
 ? ieee80211_reconfig+0x9c/0x17f0 [mac80211]
 ? srso_alias_return_thunk+0x5/0x7f
 ? schedule+0x5b/0xa0
 ? srso_alias_return_thunk+0x5/0x7f
 ? srso_alias_return_thunk+0x5/0x7f
 ? schedule_timeout+0x151/0x160
 ? srso_alias_return_thunk+0x5/0x7f
 wiphy_resume+0x82/0x1b0 [cfg80211]
 ? wiphy_suspend+0x2c0/0x2c0 [cfg80211]
 dpm_run_callback+0x89/0x1e0
 device_resume+0xa2/0x1f0
 async_resume+0x1e/0x60
 async_run_entry_fn+0x2f/0x120
 process_one_work+0x165/0x330
 worker_thread+0x2f5/0x410
 ? rcu_work_rcufn+0x80/0x80
 kthread+0xe5/0x120
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x31/0x50
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>
=2D--[ end trace 0000000000000000 ]---
=2D-----------[ cut here ]------------
WARNING: CPU: 10 PID: 91402 at net/mac80211/driver-ops.c:39 drv_stop+0xf0/=
0x100 [mac80211]
CPU: 10 PID: 91402 Comm: kworker/u32:48 Tainted: G        W          6.6.0=
-rc6+ #7
Hardware name: LENOVO 21K4S07400/21K4S07400, BIOS R2FET31W (1.11 ) 08/03/2=
023
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:drv_stop+0xf0/0x100 [mac80211]
Code: 0a 00 48 85 c0 74 0c 48 8b 78 08 48 89 de e8 d7 dd 04 00 65 ff 0d a8=
 f5 ed 3e 0f 85 39 ff ff ff e8 d5 6f cb c4 e9 2f ff ff ff <0f> 0b e9 09 ce=
 5d c5 66 0f 1f 84 00 00 00 00 00 66 0f 1f 00 0f 1f
RSP: 0018:ffffb298c9f57c40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffa0d983018940 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000286 RDI: ffffa0d9b91208e0
RBP: ffffa0d9b9121b18 R08: ffffffff86f1d430 R09: ffffffff86f1d430
R10: 0000000000000001 R11: 0000000000000000 R12: ffffa0d9b91208e0
R13: ffffa0d983019980 R14: ffffa0d9b91211e8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffa0e0bee80000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000623210000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 ? drv_stop+0xf0/0x100 [mac80211]
 ? __warn+0x81/0x130
 ? drv_stop+0xf0/0x100 [mac80211]
 ? report_bug+0x171/0x1a0
 ? handle_bug+0x3a/0x70
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? drv_stop+0xf0/0x100 [mac80211]
 ieee80211_do_stop+0x5ca/0x880 [mac80211]
 ieee80211_stop+0x4d/0x180 [mac80211]
 __dev_close_many+0x96/0x110
 dev_close_many+0x7f/0x130
 dev_close+0x61/0x80
 cfg80211_shutdown_all_interfaces+0x4d/0xf0 [cfg80211]
 wiphy_resume+0xc1/0x1b0 [cfg80211]
 ? wiphy_suspend+0x2c0/0x2c0 [cfg80211]
 dpm_run_callback+0x89/0x1e0
 device_resume+0xa2/0x1f0
 async_resume+0x1e/0x60
 async_run_entry_fn+0x2f/0x120
 process_one_work+0x165/0x330
 worker_thread+0x2f5/0x410
 ? rcu_work_rcufn+0x80/0x80
 kthread+0xe5/0x120
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x31/0x50
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>
=2D--[ end trace 0000000000000000 ]---
ieee80211 phy0: PM: dpm_run_callback(): wiphy_resume+0x0/0x1b0 [cfg80211] =
returns -11
ieee80211 phy0: PM: failed to restore async: error -11



Best regards,
Julian

=2D-
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments

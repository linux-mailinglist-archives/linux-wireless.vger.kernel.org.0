Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4346940D451
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhIPINd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 04:13:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64414 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232184AbhIPINd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 04:13:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631779933; h=Content-Type: MIME-Version: Message-ID: Date:
 Subject: Cc: To: From: Sender;
 bh=4ZGU5j6FvUQprweQgEeWIRjWrpMF9A+6Rtk7tApjoCo=; b=kTe6CDZAKD6GqH0kUfUPtVykP/IntQal31g7HlZxLFcPC4XCc/MIv1okLOXnxbGd7rsNcxqh
 bcTMD8NO1nfVE/nrwYLNg2/FB5kkxfwbnQiODVzBXXwTw6pu11qdFElhZ6Ih4Xrg2JsPXQV/
 CBrPwGRe4r4e9JgqgTYYJ1cMPj8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6142f991bd6681d8ed361b45 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 08:00:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 017ACC43460; Thu, 16 Sep 2021 08:00:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E05AC4338F;
        Thu, 16 Sep 2021 08:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 6E05AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Loic Poulain <loic.poulain@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev
Subject: [regression] mhi: ath11k resume fails on some devices
Date:   Thu, 16 Sep 2021 11:00:09 +0300
Message-ID: <871r5p0x2u.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Loic and Mani,

I hate to be the bearer of bad news again :)

I noticed already a while ago that commit 020d3b26c07a ("bus: mhi: Early
MHI resume failure in non M3 state"), introduced in v5.13-rc1, broke
ath11k resume on my NUC x86 testbox using QCA6390. Interestingly enough
Dell XPS 13 9310 laptop (with QCA6390 as well) does not have this
problem, I only see the problem on the NUC. I do not know what's causing
this difference.

At the moment I'm running my tests with commit 020d3b26c07a reverted and
everything works without problems. Is there a simple way to fix this? Or
maybe we should just revert the commit? Commit log and kernel logs from
a failing case below.

Kalle

commit 020d3b26c07abe274ac17f64999bbd3bf3342195
Author:     Loic Poulain <loic.poulain@linaro.org>
AuthorDate: Fri Mar 5 17:14:01 2021 +0100
Commit:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CommitDate: Wed Mar 10 20:11:22 2021 +0530

    bus: mhi: Early MHI resume failure in non M3 state
    
    MHI suspend/resume are symmetric and balanced procedures. If device is
    not in M3 state on a resume, that means something happened behind our
    back. In this case resume is aborted and error reported, to let the
    controller handle the situation.
    
    This is mainly requested for system wide suspend-resume operation in
    PCI context which may lead to power-down/reset of the controller which
    will then lose its MHI context. In such cases, PCI driver is supposed
    to recover and reinitialize the device.
    
    Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
    Reviewed-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
    Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    Link: https://lore.kernel.org/r/1614960841-20233-1-git-send-email-loic.poulain@linaro.org
    Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[  267.182376] ACPI: PM: Waking up from system sleep state S3
[  268.192783] ACPI: EC: interrupt unblocked
[  268.193023] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS workaround enabled
[  268.204389] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[  268.204391] pcieport 0000:00:1c.1: Intel SPT PCH root port ACS workaround enabled
[  268.205227] pcieport 0000:00:1c.2: Intel SPT PCH root port ACS workaround enabled
[  269.360336] ACPI: EC: event unblocked
[  269.367187] usb usb3: root hub lost power or was reset
[  269.367215] usb usb4: root hub lost power or was reset
[  269.368584] ath11k_pci 0000:06:00.0: failed to set mhi state: RESUME(6)
[  269.455966] nvme nvme0: 8/0/0 default/read/poll queues
[  272.289737] igb 0000:05:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[  272.424084] ath11k_pci 0000:06:00.0: timed out while waiting for wow wakeup completion
[  272.424091] ath11k_pci 0000:06:00.0: failed to wakeup wow during resume: -110
[  272.424096] ath11k_pci 0000:06:00.0: failed to resume core: -110
[  272.424101] PM: dpm_run_callback(): pci_pm_resume+0x0/0x2d0 returns -110
[  272.424119] ath11k_pci 0000:06:00.0: PM: failed to resume async: error -110
[  275.432003] ath11k_pci 0000:06:00.0: wmi command 16387 timeout
[  275.432034] ath11k_pci 0000:06:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[  275.432088] ath11k_pci 0000:06:00.0: failed to enable PMF QOS: (-11
[  275.432094] ------------[ cut here ]------------
[  275.432114] Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
[  275.432144] WARNING: CPU: 3 PID: 3164 at net/mac80211/util.c:2361 ieee80211_reconfig+0x216/0x22a0 [mac80211]
[  275.432225] Modules linked in: ath11k_pci ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr ns mos7840 usbserial nvme nvme_core [last unloaded: mhi]
[  275.432287] CPU: 3 PID: 3164 Comm: kworker/u16:20 Not tainted 5.15.0-rc1 #483
[  275.432293] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0049.2018.0801.1601 08/01/2018
[  275.432298] Workqueue: events_unbound async_run_entry_fn
[  275.432307] RIP: 0010:ieee80211_reconfig+0x216/0x22a0 [mac80211]
[  275.432381] Code: c0 0f 85 4b 1f 00 00 41 c6 87 7c 08 00 00 00 4c 89 ff e8 ed 41 f1 ff 41 89 c5 85 c0 74 13 48 c7 c7 40 bc 7e c0 e8 ef 63 07 e4 <0f> 0b e9 12 ff ff ff 88 5c 24 37 49 8d 47 40 48 89 c2 48 89 44 24
[  275.432386] RSP: 0000:ffffc90002bc7ab0 EFLAGS: 00010286
[  275.432394] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  275.432399] RDX: 0000000000000027 RSI: 0000000000000004 RDI: fffff52000578f48
[  275.432403] RBP: ffff88810890169a R08: 0000000000000001 R09: ffff888234fe581b
[  275.432408] R10: ffffed10469fcb03 R11: 0000000000000001 R12: ffff88810890169e
[  275.432412] R13: 00000000fffffff5 R14: 0000000000000000 R15: ffff888108900e20
[  275.432417] FS:  0000000000000000(0000) GS:ffff888234e00000(0000) knlGS:0000000000000000
[  275.432421] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  275.432426] CR2: 0000000000000000 CR3: 0000000101148002 CR4: 00000000003706e0
[  275.432430] Call Trace:
[  275.432443]  ? trace_rdev_return_int+0x1a0/0x1a0 [cfg80211]
[  275.432515]  wiphy_resume+0x190/0x370 [cfg80211]
[  275.432574]  ? trace_device_pm_callback_start+0x123/0x1b0
[  275.432584]  ? trace_rdev_return_int+0x1a0/0x1a0 [cfg80211]
[  275.432642]  dpm_run_callback+0xf4/0x1b0
[  275.432650]  ? trace_device_pm_callback_end+0x1a0/0x1a0
[  275.432658]  ? device_links_read_unlock+0x1b/0x30
[  275.432665]  ? dpm_wait_for_superior+0x256/0x430
[  275.432679]  device_resume+0x3d5/0x980
[  275.432688]  ? dpm_run_callback+0x1b0/0x1b0
[  275.432693]  ? lockdep_hardirqs_on_prepare.part.0+0x19a/0x350
[  275.432701]  ? ktime_get+0x214/0x2f0
[  275.432707]  ? trace_hardirqs_on+0x1c/0x120
[  275.432715]  ? recalibrate_cpu_khz+0x10/0x10
[  275.432726]  ? device_resume+0x980/0x980
[  275.432732]  async_resume+0x14/0x30
[  275.432738]  async_run_entry_fn+0x90/0x4f0
[  275.432750]  process_one_work+0x866/0x1460
[  275.432768]  ? pwq_dec_nr_in_flight+0x230/0x230
[  275.432787]  ? worker_thread+0x152/0x1010
[  275.432798]  worker_thread+0x596/0x1010
[  275.432818]  ? process_one_work+0x1460/0x1460
[  275.432828]  kthread+0x322/0x3e0
[  275.432833]  ? _raw_spin_unlock_irq+0x1f/0x30
[  275.432838]  ? set_kthread_struct+0x100/0x100
[  275.432848]  ret_from_fork+0x22/0x30
[  275.432872] irq event stamp: 977
[  275.432876] hardirqs last  enabled at (985): [<ffffffffa2462c4b>] console_trylock_spinning+0x19b/0x1f0
[  275.432882] hardirqs last disabled at (992): [<ffffffffa2462bfa>] console_trylock_spinning+0x14a/0x1f0
[  275.432888] softirqs last  enabled at (402): [<ffffffffc095f878>] ath11k_htc_send+0x668/0xc10 [ath11k]
[  275.432914] softirqs last disabled at (400): [<ffffffffc095f797>] ath11k_htc_send+0x587/0xc10 [ath11k]
[  275.432937] ---[ end trace 88fd8120acef327c ]---
[  275.433884] ------------[ cut here ]------------
[  275.433888] wlan0: Failed check-sdata-in-driver check, flags: 0x4
[  275.433917] WARNING: CPU: 3 PID: 3164 at net/mac80211/driver-ops.c:97 drv_remove_interface+0x2cb/0x330 [mac80211]
[  275.434008] Modules linked in: ath11k_pci ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr ns mos7840 usbserial nvme nvme_core [last unloaded: mhi]
[  275.434068] CPU: 3 PID: 3164 Comm: kworker/u16:20 Tainted: G        W         5.15.0-rc1 #483
[  275.434074] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0049.2018.0801.1601 08/01/2018
[  275.434079] Workqueue: events_unbound async_run_entry_fn
[  275.434087] RIP: 0010:drv_remove_interface+0x2cb/0x330 [mac80211]
[  275.434154] Code: c1 e9 03 80 3c 01 00 75 72 48 8b 83 88 06 00 00 48 8d b3 a8 06 00 00 48 c7 c7 60 2a 7e c0 48 85 c0 48 0f 45 f0 e8 8a 12 16 e4 <0f> 0b eb 90 e8 6c a8 23 e2 e9 e9 fd ff ff e8 62 a8 23 e2 e9 06 fe
[  275.434159] RSP: 0000:ffffc90002bc7788 EFLAGS: 00010282
[  275.434167] RAX: 0000000000000000 RBX: ffff8881735a0c40 RCX: 0000000000000000
[  275.434171] RDX: 0000000000000027 RSI: 0000000000000004 RDI: fffff52000578ee3
[  275.434176] RBP: ffff888108900e20 R08: 0000000000000001 R09: ffff888234fe581b
[  275.434180] R10: ffffed10469fcb03 R11: 0000000000000001 R12: dffffc0000000000
[  275.434184] R13: ffff8881735a12d8 R14: ffff888108901568 R15: 000000000000000f
[  275.434189] FS:  0000000000000000(0000) GS:ffff888234e00000(0000) knlGS:0000000000000000
[  275.434194] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  275.434198] CR2: 0000000000000000 CR3: 0000000101148002 CR4: 00000000003706e0
[  275.434203] Call Trace:
[  275.434212]  ieee80211_do_stop+0xe27/0x1a20 [mac80211]
[  275.434291]  ? mutex_lock_io_nested+0x1490/0x1490
[  275.434303]  ? ieee80211_del_virtual_monitor+0x1a0/0x1a0 [mac80211]
[  275.434370]  ? mark_held_locks+0xa5/0xe0
[  275.434382]  ? lockdep_hardirqs_on_prepare.part.0+0x19a/0x350
[  275.434389]  ? __local_bh_enable_ip+0x9d/0xf0
[  275.434394]  ? trace_hardirqs_on+0x1c/0x120
[  275.434410]  ieee80211_stop+0xb2/0x230 [mac80211]
[  275.434484]  __dev_close_many+0x191/0x2a0
[  275.434491]  ? netif_tx_stop_all_queues+0xf0/0xf0
[  275.434496]  ? find_held_lock+0x33/0x110
[  275.434507]  ? __lock_release+0x494/0xa40
[  275.434518]  dev_close_many+0x1c5/0x540
[  275.434527]  ? wait_for_completion_io+0x280/0x280
[  275.434535]  ? dev_get_by_napi_id+0x110/0x110
[  275.434544]  ? wiphy_resume+0x1a5/0x370 [cfg80211]
[  275.434610]  dev_close+0x132/0x1d0
[  275.434617]  ? dev_xdp_attach.constprop.0+0x750/0x750
[  275.434633]  cfg80211_shutdown_all_interfaces+0x71/0x180 [cfg80211]
[  275.434697]  wiphy_resume+0x1b2/0x370 [cfg80211]
[  275.434755]  ? trace_device_pm_callback_start+0x123/0x1b0
[  275.434765]  ? trace_rdev_return_int+0x1a0/0x1a0 [cfg80211]
[  275.434822]  dpm_run_callback+0xf4/0x1b0
[  275.434830]  ? trace_device_pm_callback_end+0x1a0/0x1a0
[  275.434839]  ? device_links_read_unlock+0x1b/0x30
[  275.434845]  ? dpm_wait_for_superior+0x256/0x430
[  275.434859]  device_resume+0x3d5/0x980
[  275.434868]  ? dpm_run_callback+0x1b0/0x1b0
[  275.434873]  ? lockdep_hardirqs_on_prepare.part.0+0x19a/0x350
[  275.434880]  ? ktime_get+0x214/0x2f0
[  275.434886]  ? trace_hardirqs_on+0x1c/0x120
[  275.434893]  ? recalibrate_cpu_khz+0x10/0x10
[  275.434904]  ? device_resume+0x980/0x980
[  275.434910]  async_resume+0x14/0x30
[  275.434916]  async_run_entry_fn+0x90/0x4f0
[  275.434928]  process_one_work+0x866/0x1460
[  275.434946]  ? pwq_dec_nr_in_flight+0x230/0x230
[  275.434965]  ? worker_thread+0x152/0x1010
[  275.434992]  worker_thread+0x596/0x1010
[  275.435013]  ? process_one_work+0x1460/0x1460
[  275.435022]  kthread+0x322/0x3e0
[  275.435027]  ? _raw_spin_unlock_irq+0x1f/0x30
[  275.435032]  ? set_kthread_struct+0x100/0x100
[  275.435042]  ret_from_fork+0x22/0x30
[  275.435065] irq event stamp: 1923
[  275.435069] hardirqs last  enabled at (1931): [<ffffffffa2462c4b>] console_trylock_spinning+0x19b/0x1f0
[  275.435076] hardirqs last disabled at (1938): [<ffffffffa2462bfa>] console_trylock_spinning+0x14a/0x1f0
[  275.435082] softirqs last  enabled at (1290): [<ffffffffa4c0050a>] __do_softirq+0x50a/0x7d5
[  275.435087] softirqs last disabled at (1283): [<ffffffffa2336935>] __irq_exit_rcu+0xe5/0x120
[  275.435093] ---[ end trace 88fd8120acef327d ]---
[  275.435126] ------------[ cut here ]------------
[  275.435130] WARNING: CPU: 3 PID: 3164 at net/mac80211/driver-ops.c:36 drv_stop+0x290/0x310 [mac80211]
[  275.435197] Modules linked in: ath11k_pci ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr ns mos7840 usbserial nvme nvme_core [last unloaded: mhi]
[  275.435256] CPU: 3 PID: 3164 Comm: kworker/u16:20 Tainted: G        W         5.15.0-rc1 #483
[  275.435261] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0049.2018.0801.1601 08/01/2018
[  275.435265] Workqueue: events_unbound async_run_entry_fn
[  275.435274] RIP: 0010:drv_stop+0x290/0x310 [mac80211]
[  275.435339] Code: 80 3d 5f f1 29 00 00 75 e2 48 c7 c2 c0 29 7e c0 be 34 01 00 00 48 c7 c7 20 2a 7e c0 c6 05 43 f1 29 00 01 e8 af 64 16 e4 eb c1 <0f> 0b 5b 5d 41 5c 41 5d c3 0f 0b e9 d3 fd ff ff 48 89 ef e8 18 b2
[  275.435344] RSP: 0000:ffffc90002bc7790 EFLAGS: 00010246
[  275.435352] RAX: 0000000000000000 RBX: ffff888108900e20 RCX: 0000000000000001
[  275.435356] RDX: 0000000000000004 RSI: ffffffffa5a021a0 RDI: ffff888145778920
[  275.435360] RBP: ffff88810890169c R08: 0000000000000001 R09: ffffc90002bc757f
[  275.435365] R10: ffffc90002bc77a8 R11: 0000000000000001 R12: dffffc0000000000
[  275.435369] R13: ffff888108900e20 R14: ffff888108901568 R15: 000000000000000f
[  275.435373] FS:  0000000000000000(0000) GS:ffff888234e00000(0000) knlGS:0000000000000000
[  275.435378] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  275.435382] CR2: 0000000000000000 CR3: 0000000101148002 CR4: 00000000003706e0
[  275.435387] Call Trace:
[  275.435394]  ieee80211_do_stop+0x11dd/0x1a20 [mac80211]
[  275.435472]  ? mutex_lock_io_nested+0x1490/0x1490
[  275.435484]  ? ieee80211_del_virtual_monitor+0x1a0/0x1a0 [mac80211]
[  275.435551]  ? mark_held_locks+0xa5/0xe0
[  275.435562]  ? lockdep_hardirqs_on_prepare.part.0+0x19a/0x350
[  275.435569]  ? __local_bh_enable_ip+0x9d/0xf0
[  275.435574]  ? trace_hardirqs_on+0x1c/0x120
[  275.435590]  ieee80211_stop+0xb2/0x230 [mac80211]
[  275.435663]  __dev_close_many+0x191/0x2a0
[  275.435670]  ? netif_tx_stop_all_queues+0xf0/0xf0
[  275.435675]  ? find_held_lock+0x33/0x110
[  275.435686]  ? __lock_release+0x494/0xa40
[  275.435697]  dev_close_many+0x1c5/0x540
[  275.435706]  ? wait_for_completion_io+0x280/0x280
[  275.435713]  ? dev_get_by_napi_id+0x110/0x110
[  275.435723]  ? wiphy_resume+0x1a5/0x370 [cfg80211]
[  275.435790]  dev_close+0x132/0x1d0
[  275.435797]  ? dev_xdp_attach.constprop.0+0x750/0x750
[  275.435813]  cfg80211_shutdown_all_interfaces+0x71/0x180 [cfg80211]
[  275.435876]  wiphy_resume+0x1b2/0x370 [cfg80211]
[  275.435935]  ? trace_device_pm_callback_start+0x123/0x1b0
[  275.435944]  ? trace_rdev_return_int+0x1a0/0x1a0 [cfg80211]
[  275.436018]  dpm_run_callback+0xf4/0x1b0
[  275.436026]  ? trace_device_pm_callback_end+0x1a0/0x1a0
[  275.436035]  ? device_links_read_unlock+0x1b/0x30
[  275.436041]  ? dpm_wait_for_superior+0x256/0x430
[  275.436055]  device_resume+0x3d5/0x980
[  275.436064]  ? dpm_run_callback+0x1b0/0x1b0
[  275.436069]  ? lockdep_hardirqs_on_prepare.part.0+0x19a/0x350
[  275.436076]  ? ktime_get+0x214/0x2f0
[  275.436082]  ? trace_hardirqs_on+0x1c/0x120
[  275.436089]  ? recalibrate_cpu_khz+0x10/0x10
[  275.436100]  ? device_resume+0x980/0x980
[  275.436106]  async_resume+0x14/0x30
[  275.436112]  async_run_entry_fn+0x90/0x4f0
[  275.436124]  process_one_work+0x866/0x1460
[  275.436142]  ? pwq_dec_nr_in_flight+0x230/0x230
[  275.436161]  ? worker_thread+0x152/0x1010
[  275.436172]  worker_thread+0x596/0x1010
[  275.436191]  ? process_one_work+0x1460/0x1460
[  275.436201]  kthread+0x322/0x3e0
[  275.436206]  ? _raw_spin_unlock_irq+0x1f/0x30
[  275.436211]  ? set_kthread_struct+0x100/0x100
[  275.436221]  ret_from_fork+0x22/0x30
[  275.436244] irq event stamp: 2619
[  275.436248] hardirqs last  enabled at (2627): [<ffffffffa2462c4b>] console_trylock_spinning+0x19b/0x1f0
[  275.436254] hardirqs last disabled at (2634): [<ffffffffa2462bfa>] console_trylock_spinning+0x14a/0x1f0
[  275.436260] softirqs last  enabled at (1290): [<ffffffffa4c0050a>] __do_softirq+0x50a/0x7d5
[  275.436266] softirqs last disabled at (1283): [<ffffffffa2336935>] __irq_exit_rcu+0xe5/0x120
[  275.436271] ---[ end trace 88fd8120acef327e ]---
[  275.438124] PM: dpm_run_callback(): wiphy_resume+0x0/0x370 [cfg80211] returns -11
[  275.438194] ieee80211 phy0: PM: failed to resume async: error -11

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

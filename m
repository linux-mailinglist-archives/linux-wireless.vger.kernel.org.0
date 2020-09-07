Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9D625FEC2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 18:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgIGQXW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 12:23:22 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:35306
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730478AbgIGQXP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 12:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599495794;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=IHSOM/AeiUJXOx0i4mfPQY7ed3f7eENPhR5wFalpAHE=;
        b=E441V2aVGywvZgfDLaktlNZLAUd0WzyuJA9BW7kcPijjTGuaMiBKXq6qmYHXZvFt
        EWUhjw1HZgWbqdfe08BzG5w4EYZ9GPn8lp5HpCD3hFF3QtOgS4v7eDo0wUWpcO8yIPD
        hEBwsXZBIMNedjJ4/wSjhacIXZy7gXhgWC+NNpQA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599495794;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=IHSOM/AeiUJXOx0i4mfPQY7ed3f7eENPhR5wFalpAHE=;
        b=iXzNW5Wot9yWW0f9O3VkoDPTnm7VTVzc5clN0OR5qmw1bvhrr5KeW+tvKOvmCOjB
        bQxb5D/97zrMeVbj1GShgmf2MQSJTotK/w9tDDrMAgbGqMGkJrc3h/Wv/frszP8oZGK
        HzChpWQF2L0nwPQ7Y5v7hrPow2p1CGGImXwH5WWs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED53DC58BEF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] ath10k: add flag to protect napi operation to avoid dead loop hang
References: <1598617348-2325-1-git-send-email-wgong@codeaurora.org>
Date:   Mon, 7 Sep 2020 16:23:14 +0000
In-Reply-To: <1598617348-2325-1-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Fri, 28 Aug 2020 20:22:28 +0800")
Message-ID: <010101746960edb9-af9e3af2-2661-4a02-86a4-aa69f0dc4b96-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> It happened "Kernel panic - not syncing: hung_task: blocked tasks" when
> test simulate crash and ifconfig down/rmmod meanwhile.
>
> Test steps:
>
> 1.Test commands, either can reproduce the hang for PCIe, SDIO and SNOC.
> echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;sleep 0.05;ifconfig wlan0 down
> echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;rmmod ath10k_sdio
> echo hw-restart > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash;rmmod ath10k_pci
>
> 2. dmesg:
> [ 5622.548630] ath10k_sdio mmc1:0001:1: simulating soft firmware crash
> [ 5622.655995] ieee80211 phy0: Hardware restart was requested
> [ 5776.355164] INFO: task shill:1572 blocked for more than 122 seconds.
> [ 5776.355687] INFO: task kworker/1:2:24437 blocked for more than 122 seconds.
> [ 5776.359812] Kernel panic - not syncing: hung_task: blocked tasks
> [ 5776.359836] CPU: 1 PID: 55 Comm: khungtaskd Tainted: G        W         4.19.86 #137
> [ 5776.359846] Hardware name: MediaTek krane sku176 board (DT)
> [ 5776.359855] Call trace:
> [ 5776.359868]  dump_backtrace+0x0/0x170
> [ 5776.359881]  show_stack+0x20/0x2c
> [ 5776.359896]  dump_stack+0xd4/0x10c
> [ 5776.359916]  panic+0x12c/0x29c
> [ 5776.359937]  hung_task_panic+0x0/0x50
> [ 5776.359953]  kthread+0x120/0x130
> [ 5776.359965]  ret_from_fork+0x10/0x18
> [ 5776.359986] SMP: stopping secondary CPUs
> [ 5776.360012] Kernel Offset: 0x141ea00000 from 0xffffff8008000000
> [ 5776.360026] CPU features: 0x0,2188200c
> [ 5776.360035] Memory Limit: none
>
> command "ifconfig wlan0 down" or "rmmod ath10k_sdio" will be blocked
> callstack of ifconfig:
> [<0>] __switch_to+0x120/0x13c
> [<0>] msleep+0x28/0x38
> [<0>] ath10k_sdio_hif_stop+0x24c/0x294 [ath10k_sdio]
> [<0>] ath10k_core_stop+0x50/0x78 [ath10k_core]
> [<0>] ath10k_halt+0x120/0x178 [ath10k_core]
> [<0>] ath10k_stop+0x4c/0x8c [ath10k_core]
> [<0>] drv_stop+0xe0/0x1e4 [mac80211]
> [<0>] ieee80211_stop_device+0x48/0x54 [mac80211]
> [<0>] ieee80211_do_stop+0x678/0x6f8 [mac80211]
> [<0>] ieee80211_stop+0x20/0x30 [mac80211]
> [<0>] __dev_close_many+0xb8/0x11c
> [<0>] __dev_change_flags+0xe0/0x1d0
> [<0>] dev_change_flags+0x30/0x6c
> [<0>] devinet_ioctl+0x370/0x564
> [<0>] inet_ioctl+0xdc/0x304
> [<0>] sock_do_ioctl+0x50/0x288
> [<0>] compat_sock_ioctl+0x1b4/0x1aac
> [<0>] __se_compat_sys_ioctl+0x100/0x26fc
> [<0>] __arm64_compat_sys_ioctl+0x20/0x2c
> [<0>] el0_svc_common+0xa4/0x154
> [<0>] el0_svc_compat_handler+0x2c/0x38
> [<0>] el0_svc_compat+0x8/0x18
> [<0>] 0xffffffffffffffff
>
> callstack of rmmod:
> [<0>] __switch_to+0x120/0x13c
> [<0>] msleep+0x28/0x38
> [<0>] ath10k_sdio_hif_stop+0x294/0x31c [ath10k_sdio]
> [<0>] ath10k_core_stop+0x50/0x78 [ath10k_core]
> [<0>] ath10k_halt+0x120/0x178 [ath10k_core]
> [<0>] ath10k_stop+0x4c/0x8c [ath10k_core]
> [<0>] drv_stop+0xe0/0x1e4 [mac80211]
> [<0>] ieee80211_stop_device+0x48/0x54 [mac80211]
> [<0>] ieee80211_do_stop+0x678/0x6f8 [mac80211]
> [<0>] ieee80211_stop+0x20/0x30 [mac80211]
> [<0>] __dev_close_many+0xb8/0x11c
> [<0>] dev_close_many+0x70/0x100
> [<0>] dev_close+0x4c/0x80
> [<0>] cfg80211_shutdown_all_interfaces+0x50/0xcc [cfg80211]
> [<0>] ieee80211_remove_interfaces+0x58/0x1a0 [mac80211]
> [<0>] ieee80211_unregister_hw+0x40/0x100 [mac80211]
> [<0>] ath10k_mac_unregister+0x1c/0x44 [ath10k_core]
> [<0>] ath10k_core_unregister+0x38/0x7c [ath10k_core]
> [<0>] ath10k_sdio_remove+0x8c/0xd0 [ath10k_sdio]
> [<0>] sdio_bus_remove+0x48/0x108
> [<0>] device_release_driver_internal+0x138/0x1ec
> [<0>] driver_detach+0x6c/0xa8
> [<0>] bus_remove_driver+0x78/0xa8
> [<0>] driver_unregister+0x30/0x50
> [<0>] sdio_unregister_driver+0x28/0x34
> [<0>] cleanup_module+0x14/0x6bc [ath10k_sdio]
> [<0>] __arm64_sys_delete_module+0x1e0/0x22c
> [<0>] el0_svc_common+0xa4/0x154
> [<0>] el0_svc_compat_handler+0x2c/0x38
> [<0>] el0_svc_compat+0x8/0x18
> [<0>] 0xffffffffffffffff
>
> SNOC:
> [  647.156863] Call trace:
> [  647.162166] [<ffffff80080855a4>] __switch_to+0x120/0x13c
> [  647.164512] [<ffffff800899d8b8>] __schedule+0x5ec/0x798
> [  647.170062] [<ffffff800899dad8>] schedule+0x74/0x94
> [  647.175050] [<ffffff80089a0848>] schedule_timeout+0x314/0x42c
> [  647.179874] [<ffffff80089a0a14>] schedule_timeout_uninterruptible+0x34/0x40
> [  647.185780] [<ffffff80082a494>] msleep+0x28/0x38
> [  647.192546] [<ffffff800117ec4c>] ath10k_snoc_hif_stop+0x4c/0x1e0 [ath10k_snoc]
> [  647.197439] [<ffffff80010dfbd8>] ath10k_core_stop+0x50/0x7c [ath10k_core]
> [  647.204652] [<ffffff80010c8f48>] ath10k_halt+0x114/0x16c [ath10k_core]
> [  647.211420] [<ffffff80010cad68>] ath10k_stop+0x4c/0x88 [ath10k_core]
> [  647.217865] [<ffffff8000fdbf54>] drv_stop+0x110/0x244 [mac80211]
> [  647.224367] [<ffffff80010147ac>] ieee80211_stop_device+0x48/0x54 [mac80211]
> [  647.230359] [<ffffff8000ff3eec>] ieee80211_do_stop+0x6a4/0x73c [mac80211]
> [  647.237033] [<ffffff8000ff4500>] ieee80211_stop+0x20/0x30 [mac80211]
> [  647.243942] [<ffffff80087e39b8>] __dev_close_many+0xa0/0xfc
> [  647.250435] [<ffffff80087e3888>] dev_close_many+0x70/0x100
> [  647.255651] [<ffffff80087e3a60>] dev_close+0x4c/0x80
> [  647.261244] [<ffffff8000f1ba54>] cfg80211_shutdown_all_interfaces+0x44/0xcc [cfg80211]
> [  647.266383] [<ffffff8000ff3fdc>] ieee80211_remove_interfaces+0x58/0x1b4 [mac80211]
> [  647.274128] [<ffffff8000fda540>] ieee80211_unregister_hw+0x50/0x120 [mac80211]
> [  647.281659] [<ffffff80010ca314>] ath10k_mac_unregister+0x1c/0x44 [ath10k_core]
> [  647.288839] [<ffffff80010dfc94>] ath10k_core_unregister+0x48/0x90 [ath10k_core]
> [  647.296027] [<ffffff800117e598>] ath10k_snoc_remove+0x5c/0x150 [ath10k_snoc]
> [  647.303229] [<ffffff80085625fc>] platform_drv_remove+0x28/0x50
> [  647.310517] [<ffffff80085601a4>] device_release_driver_internal+0x114/0x1b8
> [  647.316257] [<ffffff80085602e4>] driver_detach+0x6c/0xa8
> [  647.323021] [<ffffff800855e5b8>] bus_remove_driver+0x78/0xa8
> [  647.328571] [<ffffff800856107c>] driver_unregister+0x30/0x50
> [  647.334213] [<ffffff8008562674>] platform_driver_unregister+0x1c/0x28
> [  647.339876] [<ffffff800117fefc>] cleanup_module+0x1c/0x120 [ath10k_snoc]
> [  647.346196] [<ffffff8008143ab8>] SyS_delete_module+0x1dc/0x22c
>
> PCIe:
> [  615.392770] rmmod           D    0  3523   3458 0x00000080
> [  615.392777] Call Trace:
> [  615.392784]  __schedule+0x617/0x7d3
> [  615.392791]  ? __mod_timer+0x263/0x35c
> [  615.392797]  schedule+0x62/0x72
> [  615.392803]  schedule_timeout+0x8d/0xf3
> [  615.392809]  ? run_local_timers+0x6b/0x6b
> [  615.392814]  msleep+0x1b/0x22
> [  615.392824]  ath10k_pci_hif_stop+0x68/0xd6 [ath10k_pci]
> [  615.392844]  ath10k_core_stop+0x44/0x67 [ath10k_core]
> [  615.392859]  ath10k_halt+0x102/0x153 [ath10k_core]
> [  615.392873]  ath10k_stop+0x38/0x75 [ath10k_core]
> [  615.392893]  drv_stop+0x9a/0x13c [mac80211]
> [  615.392915]  ieee80211_do_stop+0x772/0x7cd [mac80211]
> [  615.392937]  ieee80211_stop+0x1a/0x1e [mac80211]
> [  615.392945]  __dev_close_many+0x9e/0xf0
> [  615.392952]  dev_close_many+0x62/0xe8
> [  615.392958]  dev_close+0x54/0x7d
> [  615.392975]  cfg80211_shutdown_all_interfaces+0x6e/0xa5 [cfg80211]
> [  615.393021]  ieee80211_remove_interfaces+0x52/0x1aa [mac80211]
> [  615.393049]  ieee80211_unregister_hw+0x54/0x136 [mac80211]
> [  615.393068]  ath10k_mac_unregister+0x19/0x4a [ath10k_core]
> [  615.393091]  ath10k_core_unregister+0x39/0x7e [ath10k_core]
> [  615.393104]  ath10k_pci_remove+0x3d/0x7f [ath10k_pci]
> [  615.393117]  pci_device_remove+0x41/0xa6
> [  615.393129]  device_release_driver_internal+0x123/0x1ec
> [  615.393140]  driver_detach+0x60/0x90
> [  615.393152]  bus_remove_driver+0x72/0x9f
> [  615.393164]  pci_unregister_driver+0x1e/0x87
> [  615.393177]  SyS_delete_module+0x1d7/0x277
> [  615.393188]  do_syscall_64+0x6b/0xf7
> [  615.393199]  entry_SYSCALL_64_after_hwframe+0x41/0xa6
>
> The test command run simulate_fw_crash firstly and it call into
> ath10k_sdio_hif_stop from ath10k_core_restart, then napi_disable
> is called and bit NAPI_STATE_SCHED is set. After that, function
> ath10k_sdio_hif_stop is called again from ath10k_stop by command
> "ifconfig wlan0 down" or "rmmod ath10k_sdio", then command blocked.
>
> It is blocked by napi_synchronize, napi_disable will set bit with
> NAPI_STATE_SCHED, and then napi_synchronize will enter dead loop
> becuase bit NAPI_STATE_SCHED is set by napi_disable.
>
> function of napi_synchronize
> static inline void napi_synchronize(const struct napi_struct *n)
> {
> 	if (IS_ENABLED(CONFIG_SMP))
> 		while (test_bit(NAPI_STATE_SCHED, &n->state))
> 			msleep(1);
> 	else
> 		barrier();
> }
>
> function of napi_disable
> void napi_disable(struct napi_struct *n)
> {
> 	might_sleep();
> 	set_bit(NAPI_STATE_DISABLE, &n->state);
>
> 	while (test_and_set_bit(NAPI_STATE_SCHED, &n->state))
> 		msleep(1);
> 	while (test_and_set_bit(NAPI_STATE_NPSVC, &n->state))
> 		msleep(1);
>
> 	hrtimer_cancel(&n->timer);
>
> 	clear_bit(NAPI_STATE_DISABLE, &n->state);
> }
>
> Add flag for it avoid the hang and crash.
>
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1
> Tested-on: WCN3990 hw1.0 SNOC hw1.0 WLAN.HL.3.1-01307.1-QCAHLSWMTPL-2
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> +void ath10k_core_napi_enable(struct ath10k *ar)
> +{
> +	if (ar->napi_enabled)
> +		return;
> +
> +	napi_enable(&ar->napi);
> +	ar->napi_enabled = true;
> +}
> +EXPORT_SYMBOL(ath10k_core_napi_enable);
> +
> +void ath10k_core_napi_sync_disable(struct ath10k *ar)
> +{
> +	if (ar->napi_enabled) {
> +		napi_synchronize(&ar->napi);
> +		napi_disable(&ar->napi);
> +		ar->napi_enabled = false;
> +	}
> +}
> +EXPORT_SYMBOL(ath10k_core_napi_sync_disable);

Just like with the recent firmware restart patch, isn't ar->napi_enabled
racy? Wouldn't test_and_set_bit() and test_and_clear_bit() be safer?

Or are we holding a lock? But then that should be documented with
lockdep_assert_held().

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

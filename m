Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A41255BFC
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 16:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgH1OJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 10:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgH1OJZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 10:09:25 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23319C061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 07:09:25 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id p191so625335ybg.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaB9C63ZZcQmJFTtjl0Z1bw5YF604SXNKvkHwIMwdFo=;
        b=HY6AHqfMvf7qlgAo5L1qkL1nmE9XYu9tbGiQzvbVx+dK5/LDkBDLz6IetVSqiY3lhe
         UcGVwY4VfrLdDe0RTySzqfIxq75tam14l07LZOKh5lNxltb1m4kDvllG7sGKxkuoDXvw
         H18J9BvSqn2SRFAyeDsFOtlwNyEF0yYwrHdVDXTlH/WPrGxMEspul31ls29w4wGYETRT
         J5V7Lb7p+M4jE9dMx/3eng+DJkhl2GwuUwgyTHc/53ot/DT55Y8lkr42IjJMERrMDA8D
         Q9pNH11cfrkAA3AdMlXRY9pEaJJEJ/cTjnm88Ci3nEI7q52Bp9Op1IX6tKjOuAOAaaHp
         uEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaB9C63ZZcQmJFTtjl0Z1bw5YF604SXNKvkHwIMwdFo=;
        b=KIizXezIBmmvFVwkiL4OdefoeXqhGOnifU0svYkUPN0llyUW5/FqOY063AHGf9HcxE
         Qn5zhoQ020MOzsptiLDlXGJGRTisPvmm2IlWrsMuikSt8Mm2/ptdItEqlUlYny2G//Au
         VF9XkCNVMuIf2ZXGTe7kpz3uLDxR24g+yOIOrsn4bNk8fO2rSSASf90RnfeTi3WGI4J5
         qFrEickuMuW6YK6Rl5M8umEd4f92OrC2zRnZN9gI/oVvLHv2QxeL3/jKQzbFNXTWO26j
         L6vTbTfq8XNaKlj8j9Lg+p14g2rLgPcvI9BGMwjlZgTmDUabwBXJ32F0osQd4vuaI1Ou
         VJsA==
X-Gm-Message-State: AOAM533vJ67qR70/ZCmFdiIkc/1nsMAr8QlF0a9vOmL8FAlPr5C7PVwV
        XRKvB9YCEoCSbAvbpX5qI+TgHhJU1C2JNf4U55kFeRKelAEA6A==
X-Google-Smtp-Source: ABdhPJwoz5bE6ZX7gYpjdpld4ERfpnFyGgKWCHqaQ0TWNEN1jQYctwHTlKzG81jmWuP68cqDXQ379Xh+FvgmrTBidS8=
X-Received: by 2002:a25:e045:: with SMTP id x66mr2426281ybg.502.1598623762373;
 Fri, 28 Aug 2020 07:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <1598617348-2325-1-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1598617348-2325-1-git-send-email-wgong@codeaurora.org>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Fri, 28 Aug 2020 19:39:11 +0530
Message-ID: <CABPxzYKOCtA0n=bTHXT5VdsTGHcVc5PEvS2-TnGD9XEKCWdrNQ@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: add flag to protect napi operation to avoid
 dead loop hang
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 28, 2020 at 5:53 PM Wen Gong <wgong@codeaurora.org> wrote:
>
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
>         if (IS_ENABLED(CONFIG_SMP))
>                 while (test_bit(NAPI_STATE_SCHED, &n->state))
>                         msleep(1);
>         else
>                 barrier();
> }
>
> function of napi_disable
> void napi_disable(struct napi_struct *n)
> {
>         might_sleep();
>         set_bit(NAPI_STATE_DISABLE, &n->state);
>
>         while (test_and_set_bit(NAPI_STATE_SCHED, &n->state))
>                 msleep(1);
>         while (test_and_set_bit(NAPI_STATE_NPSVC, &n->state))
>                 msleep(1);
>
>         hrtimer_cancel(&n->timer);
>
>         clear_bit(NAPI_STATE_DISABLE, &n->state);
> }
>
> Add flag for it avoid the hang and crash.
>
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1
> Tested-on: WCN3990 hw1.0 SNOC hw1.0 WLAN.HL.3.1-01307.1-QCAHLSWMTPL-2
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
> v3: change all bus type
>
> v2: change to use flag
>  drivers/net/wireless/ath/ath10k/ahb.c  |  5 ++---
>  drivers/net/wireless/ath/ath10k/core.c | 20 ++++++++++++++++++++
>  drivers/net/wireless/ath/ath10k/core.h |  3 +++
>  drivers/net/wireless/ath/ath10k/pci.c  |  7 ++++---
>  drivers/net/wireless/ath/ath10k/sdio.c |  5 ++---
>  drivers/net/wireless/ath/ath10k/snoc.c |  5 ++---
>  6 files changed, 33 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
> index 05a61975c83f..869524852fba 100644
> --- a/drivers/net/wireless/ath/ath10k/ahb.c
> +++ b/drivers/net/wireless/ath/ath10k/ahb.c
> @@ -626,7 +626,7 @@ static int ath10k_ahb_hif_start(struct ath10k *ar)
>  {
>         ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot ahb hif start\n");
>
> -       napi_enable(&ar->napi);
> +       ath10k_core_napi_enable(ar);
>         ath10k_ce_enable_interrupts(ar);
>         ath10k_pci_enable_legacy_irq(ar);
>
> @@ -644,8 +644,7 @@ static void ath10k_ahb_hif_stop(struct ath10k *ar)
>         ath10k_ahb_irq_disable(ar);
>         synchronize_irq(ar_ahb->irq);
>
> -       napi_synchronize(&ar->napi);
> -       napi_disable(&ar->napi);
> +       ath10k_core_napi_sync_disable(ar);
>
>         ath10k_pci_flush(ar);
>  }
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index cfffd20df0cc..7e52fd14659d 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -2277,6 +2277,26 @@ static int ath10k_init_hw_params(struct ath10k *ar)
>         return 0;
>  }
>
> +void ath10k_core_napi_enable(struct ath10k *ar)
> +{
> +       if (ar->napi_enabled)
> +               return;
> +
> +       napi_enable(&ar->napi);
> +       ar->napi_enabled = true;
> +}
> +EXPORT_SYMBOL(ath10k_core_napi_enable);
> +
> +void ath10k_core_napi_sync_disable(struct ath10k *ar)
> +{
> +       if (ar->napi_enabled) {
> +               napi_synchronize(&ar->napi);
> +               napi_disable(&ar->napi);
> +               ar->napi_enabled = false;
> +       }
> +}
> +EXPORT_SYMBOL(ath10k_core_napi_sync_disable);
> +
>  static void ath10k_core_restart(struct work_struct *work)
>  {
>         struct ath10k *ar = container_of(work, struct ath10k, restart_work);
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> index 5c18f6c20462..efb26420cc20 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -1230,6 +1230,7 @@ struct ath10k {
>         /* NAPI */
>         struct net_device napi_dev;
>         struct napi_struct napi;
> +       bool napi_enabled;
>
>         struct work_struct set_coverage_class_work;
>         /* protected by conf_mutex */
> @@ -1276,6 +1277,8 @@ static inline bool ath10k_peer_stats_enabled(struct ath10k *ar)
>
>  extern unsigned long ath10k_coredump_mask;
>
> +void ath10k_core_napi_sync_disable(struct ath10k *ar);
> +void ath10k_core_napi_enable(struct ath10k *ar);
>  struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
>                                   enum ath10k_bus bus,
>                                   enum ath10k_hw_rev hw_rev,
> diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
> index 36426efdb2ea..7786accc5f96 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -1958,7 +1958,7 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
>
>         ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot hif start\n");
>
> -       napi_enable(&ar->napi);
> +       ath10k_core_napi_enable(ar);
>
>         ath10k_pci_irq_enable(ar);
>         ath10k_pci_rx_post(ar);
> @@ -2075,8 +2075,9 @@ static void ath10k_pci_hif_stop(struct ath10k *ar)
>
>         ath10k_pci_irq_disable(ar);
>         ath10k_pci_irq_sync(ar);
> -       napi_synchronize(&ar->napi);
> -       napi_disable(&ar->napi);
> +
> +       ath10k_core_napi_sync_disable(ar);
> +
>         cancel_work_sync(&ar_pci->dump_work);
>
>         /* Most likely the device has HTT Rx ring configured. The only way to
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index 81ddaafb6721..8834f118ef77 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -1859,7 +1859,7 @@ static int ath10k_sdio_hif_start(struct ath10k *ar)
>         struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
>         int ret;
>
> -       napi_enable(&ar->napi);
> +       ath10k_core_napi_enable(ar);
>
>         /* Sleep 20 ms before HIF interrupts are disabled.
>          * This will give target plenty of time to process the BMI done
> @@ -1986,8 +1986,7 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
>
>         spin_unlock_bh(&ar_sdio->wr_async_lock);
>
> -       napi_synchronize(&ar->napi);
> -       napi_disable(&ar->napi);
> +       ath10k_core_napi_sync_disable(ar);
>  }
>
>  #ifdef CONFIG_PM
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 645ed5f63ef8..d54438c01df8 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -913,8 +913,7 @@ static void ath10k_snoc_hif_stop(struct ath10k *ar)
>         if (!test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags))
>                 ath10k_snoc_irq_disable(ar);
>
> -       napi_synchronize(&ar->napi);
> -       napi_disable(&ar->napi);
> +       ath10k_core_napi_sync_disable(ar);
>         ath10k_snoc_buffer_cleanup(ar);
>         ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot hif stop\n");
>  }
> @@ -923,7 +922,7 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
>  {
>         struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
>
> -       napi_enable(&ar->napi);
> +       ath10k_core_napi_enable(ar);
>         ath10k_snoc_irq_enable(ar);
>         ath10k_snoc_rx_post(ar);
>
LGTM, except maybe a shorted title "ath10k: Prevent deinitializing NAPI twice".

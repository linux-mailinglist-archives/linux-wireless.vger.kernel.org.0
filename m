Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AF92AA31B
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 08:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgKGH5r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 02:57:47 -0500
Received: from z5.mailgun.us ([104.130.96.5]:11279 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbgKGH5r (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 02:57:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604735866; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/IC+u2sRG2yQ8rGQ92Fd2/YJGQiD9+lf6qHb0w6uQ38=;
 b=cnRc06HO0p2GlfVBWTRxms5Ziw+gTPBQCm4P5cuGzqT3ArGvBEdJDm79f6QNrFSUV+9DpoPA
 jfLFLBaEmlCFs5sokOBtCe7nftrrjvZF4b0f4gXC2swaToEjJbCzUH8YetWnh7JjfwVsQaWf
 bkY3lOhiybPmC7Un0gm8hGnbYks=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fa6536fc1b74298b74bf6b2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 07:57:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A700DC433CB; Sat,  7 Nov 2020 07:57:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0127C433C6;
        Sat,  7 Nov 2020 07:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0127C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath10k:  Don't iterate over not-sdata-in-driver
 interfaces.
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200922191957.25257-2-greearb@candelatech.com>
References: <20200922191957.25257-2-greearb@candelatech.com>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Ben Greear <greearb@candelatech.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107075734.A700DC433CB@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 07:57:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com wrote:

> This fixes possible crash scenario where interfaces that were not
> set up in the driver yet might still be iterated over.  When originally
> debugged on the ath10k-ct driver, the crash looked like this:
> 
> kernel BUG at /home/greearb/git/linux-4.7.dev.y/drivers/net/wireless/ath/ath10k/wmi.c:1781!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv4 bridge carl9170 mac80211_hwsim ath10k_pci ath10k_core ath5k ath9k ath9k_common ath9k_hw ath mac80211 cfg80211 8021q garp mrp stp llc bnep bluetooth fuse macvlan pktgen rpcsec_gss_krb5 nfsv4 nfs fscache snd_hda_codec_hdmi coretemp hwmon intel_rapl x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_realtek snd_hda_codec_generic kvm iTCO_wdt irqbypass iTCO_vendor_support joydev snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device pcspkr snd_pcm snd_timer shpchp snd i2c_i801 lpc_ich soundcore tpm_tis tpm nfsd auth_rpcgss nfs_acl lockd grace sunrpc i915 serio_raw i2c_algo_bit drm_kms_helper ata_generic e1000e pata_acpi drm ptp pps_core i2c_core fjes video ipv6 [last unloaded: nf_conntrack]
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.7.10+ #15
> Hardware name: To be filled by O.E.M. To be filled by O.E.M./ChiefRiver, BIOS 4.6.5 06/07/2013
> task: ffff8801d4f20000 ti: ffff8801d4f28000 task.ti: ffff8801d4f28000
> RIP: 0010:[<ffffffffa0efbcfb>]  [<ffffffffa0efbcfb>] ath10k_wmi_tx_beacons_iter+0x28b/0x290 [ath10k_core]
> RSP: 0018:ffff8801d6447a98  EFLAGS: 00010293
> RAX: 0000000000000018 RBX: ffff8801ce97e1d8 RCX: 0000000000000000
> RDX: 0000000000000018 RSI: 0000000000000003 RDI: ffffed003ac88f49
> RBP: ffff8801d6447af0 R08: 0000000000000003 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff8801ce97e320 R14: ffff8801ce97e378 R15: ffff8801ce97ca40
> FS:  0000000000000000(0000) GS:ffff8801d6440000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007eff191ef1ab CR3: 000000000260a000 CR4: 00000000001406e0
> Stack:
>  1ffff1003ac88f59 0000000041b58ab3 ffffffffa0f4d52a ffff8801d4f20000
>  0000000000000246 0000000000000002 ffff8801ce97e1d8 ffff8801bd5d39b8
>  0000000000000002 0000000000000001 ffff8801ce97ca40 ffff8801d6447b48
> Call Trace:
>  <IRQ>
>  [<ffffffffa0d03e5c>] __iterate_interfaces+0xfc/0x1d0 [mac80211]
>  [<ffffffffa0efba70>] ? ath10k_wmi_cmd_send_nowait+0x260/0x260 [ath10k_core]
>  [<ffffffffa0efba70>] ? ath10k_wmi_cmd_send_nowait+0x260/0x260 [ath10k_core]
>  [<ffffffffa0d04477>] ieee80211_iterate_active_interfaces_atomic+0x67/0x100 [mac80211]
>  [<ffffffffa0d04410>] ? ieee80211_handle_reconfig_failure+0x140/0x140 [mac80211]
>  [<ffffffffa0ef4060>] ? ath10k_tpc_config_disp_tables+0x620/0x620 [ath10k_core]
>  [<ffffffffa0ef408b>] ath10k_wmi_op_ep_tx_credits+0x2b/0x50 [ath10k_core]
>  [<ffffffffa0ee2fd2>] ath10k_htc_rx_completion_handler+0x422/0x5c0 [ath10k_core]
>  [<ffffffffa0b4301e>] ath10k_pci_process_rx_cb+0x37e/0x430 [ath10k_pci]
>  [<ffffffffa0ee2bb0>] ? ath10k_htc_build_tx_ctrl_skb+0xc0/0xc0 [ath10k_core]
>  [<ffffffffa0b42ca0>] ? ath10k_pci_rx_post_pipe+0x550/0x550 [ath10k_pci]
>  [<ffffffff8120cbe5>] ? debug_lockdep_rcu_enabled+0x35/0x40
>  [<ffffffff811e1893>] ? mark_held_locks+0x23/0xc0
>  [<ffffffff8116019a>] ? __local_bh_enable_ip+0x6a/0xd0
>  [<ffffffff811e1abb>] ? trace_hardirqs_on_caller+0x18b/0x290
>  [<ffffffff811e1bcd>] ? trace_hardirqs_on+0xd/0x10
>  [<ffffffff8116019a>] ? __local_bh_enable_ip+0x6a/0xd0
>  [<ffffffff81df11d0>] ? _raw_spin_unlock_bh+0x30/0x40
>  [<ffffffffa0b4902e>] ? ath10k_ce_per_engine_service+0xee/0x100 [ath10k_pci]
>  [<ffffffffa0b43139>] ath10k_pci_htt_htc_rx_cb+0x29/0x30 [ath10k_pci]
>  [<ffffffffa0b48fe6>] ath10k_ce_per_engine_service+0xa6/0x100 [ath10k_pci]
>  [<ffffffffa0b49116>] ath10k_ce_per_engine_service_any+0xd6/0xf0 [ath10k_pci]
>  [<ffffffffa0b45800>] ? ath10k_pci_enable_legacy_irq+0xe0/0xe0 [ath10k_pci]
>  [<ffffffffa0b4585f>] ath10k_pci_tasklet+0x5f/0xb0 [ath10k_pci]
>  [<ffffffff81160445>] tasklet_action+0x245/0x2b0
>  [<ffffffff81df4831>] __do_softirq+0x181/0x595
>  [<ffffffff8116137c>] irq_exit+0xbc/0xc0
>  [<ffffffff81df423c>] do_IRQ+0x7c/0x150
>  [<ffffffff81df23cc>] common_interrupt+0x8c/0x8c
>  <EOI>
>  [<ffffffff811e1abb>] ? trace_hardirqs_on_caller+0x18b/0x290
>  [<ffffffff81b722ae>] ? cpuidle_enter_state+0x1ae/0x4b0
>  [<ffffffff81b722a7>] ? cpuidle_enter_state+0x1a7/0x4b0
>  [<ffffffff81b72602>] cpuidle_enter+0x12/0x20
>  [<ffffffff811d0b6e>] call_cpuidle+0x4e/0x90
>  [<ffffffff811d10e7>] cpu_startup_entry+0x3f7/0x540
>  [<ffffffff811d0cf0>] ? default_idle_call+0x50/0x50
>  [<ffffffff81234bdf>] ? clockevents_config_and_register+0x5f/0x70
>  [<ffffffff81085a9a>] ? setup_APIC_timer+0xfa/0x110
>  [<ffffffff81083b63>] start_secondary+0x253/0x2b0
>  [<ffffffff81083910>] ? set_cpu_sibling_map+0x920/0x920
> Code: 4d 49 e0 8b b3 48 01 00 00 48 c7 c7 a0 ee f3 a0 e8 d9 c2 3f e0 49 81 fd 3f 1f 00 00 76 0f 49 81 fc 3f 1f 00 00 0f 87 c0 fd ff ff <0f> 0b 0f 0b 90 55 48 89 e5 41 57 41 56 48 8d 85 58 ff ff ff 41
> RIP  [<ffffffffa0efbcfb>] ath10k_wmi_tx_beacons_iter+0x28b/0x290 [ath10k_core]
>  RSP <ffff8801d6447a98>
> ---[ end trace 6588464714e5163a ]---
> 
> Similar logic was tested for years in ath10k-ct driver and various firmware.
> 
> Also tested with stock kernel plus this patch, with firmware
> 10.2.4-1.0-00037
> 
> This test case was to bring up 5 vap on a radio and fake a firmware
> crash.  Make sure ap interfaces continue to function properly.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ee06fcb98dcd ath10k: Don't iterate over not-sdata-in-driver interfaces.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20200922191957.25257-2-greearb@candelatech.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


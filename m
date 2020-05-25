Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BFE1E1310
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 18:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389166AbgEYQxX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 12:53:23 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:60384 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgEYQxW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 12:53:22 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id D3A4513C2B0;
        Mon, 25 May 2020 09:53:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D3A4513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1590425601;
        bh=TCsdVc7WN15/ZIXBeULJ6wninmtyW5kV2ROHPCtmWAk=;
        h=From:To:Cc:Subject:Date:From;
        b=YDedKuIqRW0/Yw51rK+G6dEwyXbInGPyMhxDPEbX+REPbGw2k2q2qgQ2nMWZ9eajm
         hmw2vk3ttYLjnAUEVIuCI2nAHoXQJ4+XePte5LLJnb0N6pdt5Gt3v0nSIIgFfVcg2F
         cvRIXXwPX3/gfUROZAu4nTeY7ZfyhzHJ5TH1dOwc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211: do not iterate active interfaces when in re-configure
Date:   Mon, 25 May 2020 09:53:17 -0700
Message-Id: <20200525165317.2269-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This appears to fix a problem where ath10k firmware would crash,
mac80211 would start re-adding interfaces to the driver, but the
iterate-active-interfaces logic would then try to use the half-built
interfaces.  With a bit of extra debug to catch the problem, the
ath10k crash looks like this:

ath10k_pci 0000:05:00.0: Initializing arvif: ffff8801ce97e320 on vif: ffff8801ce97e1d8

[the print that happens after arvif->ar is assigned is not shown, so code did not make it that far before
 the tx-beacon-nowait method was called]

tx-beacon-nowait:  arvif: ffff8801ce97e320  ar:           (null)
arvif->magic: 0x87560001
------------[ cut here ]------------
kernel BUG at /home/greearb/git/linux-4.7.dev.y/drivers/net/wireless/ath/ath10k/wmi.c:1781!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv4 bridge carl9170 mac80211_hwsim ath10k_pci ath10k_core ath5k ath9k ath9k_common ath9k_hw ath mac80211 cfg80211 8021q garp mrp stp llc bnep bluetooth fuse macvlan pktgen rpcsec_gss_krb5 nfsv4 nfs fscache snd_hda_codec_hdmi coretemp hwmon intel_rapl x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_realtek snd_hda_codec_generic kvm iTCO_wdt irqbypass iTCO_vendor_support joydev snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device pcspkr snd_pcm snd_timer shpchp snd i2c_i801 lpc_ich soundcore tpm_tis tpm nfsd auth_rpcgss nfs_acl lockd grace sunrpc i915 serio_raw i2c_algo_bit drm_kms_helper ata_generic e1000e pata_acpi drm ptp pps_core i2c_core fjes video ipv6 [last unloaded: nf_conntrack]
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.7.10+ #15
Hardware name: To be filled by O.E.M. To be filled by O.E.M./ChiefRiver, BIOS 4.6.5 06/07/2013
task: ffff8801d4f20000 ti: ffff8801d4f28000 task.ti: ffff8801d4f28000
RIP: 0010:[<ffffffffa0efbcfb>]  [<ffffffffa0efbcfb>] ath10k_wmi_tx_beacons_iter+0x28b/0x290 [ath10k_core]
RSP: 0018:ffff8801d6447a98  EFLAGS: 00010293
RAX: 0000000000000018 RBX: ffff8801ce97e1d8 RCX: 0000000000000000
RDX: 0000000000000018 RSI: 0000000000000003 RDI: ffffed003ac88f49
RBP: ffff8801d6447af0 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8801ce97e320 R14: ffff8801ce97e378 R15: ffff8801ce97ca40
FS:  0000000000000000(0000) GS:ffff8801d6440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007eff191ef1ab CR3: 000000000260a000 CR4: 00000000001406e0
Stack:
 1ffff1003ac88f59 0000000041b58ab3 ffffffffa0f4d52a ffff8801d4f20000
 0000000000000246 0000000000000002 ffff8801ce97e1d8 ffff8801bd5d39b8
 0000000000000002 0000000000000001 ffff8801ce97ca40 ffff8801d6447b48
Call Trace:
 <IRQ>
 [<ffffffffa0d03e5c>] __iterate_interfaces+0xfc/0x1d0 [mac80211]
 [<ffffffffa0efba70>] ? ath10k_wmi_cmd_send_nowait+0x260/0x260 [ath10k_core]
 [<ffffffffa0efba70>] ? ath10k_wmi_cmd_send_nowait+0x260/0x260 [ath10k_core]
 [<ffffffffa0d04477>] ieee80211_iterate_active_interfaces_atomic+0x67/0x100 [mac80211]
 [<ffffffffa0d04410>] ? ieee80211_handle_reconfig_failure+0x140/0x140 [mac80211]
 [<ffffffffa0ef4060>] ? ath10k_tpc_config_disp_tables+0x620/0x620 [ath10k_core]
 [<ffffffffa0ef408b>] ath10k_wmi_op_ep_tx_credits+0x2b/0x50 [ath10k_core]
 [<ffffffffa0ee2fd2>] ath10k_htc_rx_completion_handler+0x422/0x5c0 [ath10k_core]
 [<ffffffffa0b4301e>] ath10k_pci_process_rx_cb+0x37e/0x430 [ath10k_pci]
 [<ffffffffa0ee2bb0>] ? ath10k_htc_build_tx_ctrl_skb+0xc0/0xc0 [ath10k_core]
 [<ffffffffa0b42ca0>] ? ath10k_pci_rx_post_pipe+0x550/0x550 [ath10k_pci]
 [<ffffffff8120cbe5>] ? debug_lockdep_rcu_enabled+0x35/0x40
 [<ffffffff811e1893>] ? mark_held_locks+0x23/0xc0
 [<ffffffff8116019a>] ? __local_bh_enable_ip+0x6a/0xd0
 [<ffffffff811e1abb>] ? trace_hardirqs_on_caller+0x18b/0x290
 [<ffffffff811e1bcd>] ? trace_hardirqs_on+0xd/0x10
 [<ffffffff8116019a>] ? __local_bh_enable_ip+0x6a/0xd0
 [<ffffffff81df11d0>] ? _raw_spin_unlock_bh+0x30/0x40
 [<ffffffffa0b4902e>] ? ath10k_ce_per_engine_service+0xee/0x100 [ath10k_pci]
 [<ffffffffa0b43139>] ath10k_pci_htt_htc_rx_cb+0x29/0x30 [ath10k_pci]
 [<ffffffffa0b48fe6>] ath10k_ce_per_engine_service+0xa6/0x100 [ath10k_pci]
 [<ffffffffa0b49116>] ath10k_ce_per_engine_service_any+0xd6/0xf0 [ath10k_pci]
 [<ffffffffa0b45800>] ? ath10k_pci_enable_legacy_irq+0xe0/0xe0 [ath10k_pci]
 [<ffffffffa0b4585f>] ath10k_pci_tasklet+0x5f/0xb0 [ath10k_pci]
 [<ffffffff81160445>] tasklet_action+0x245/0x2b0
 [<ffffffff81df4831>] __do_softirq+0x181/0x595
 [<ffffffff8116137c>] irq_exit+0xbc/0xc0
 [<ffffffff81df423c>] do_IRQ+0x7c/0x150
 [<ffffffff81df23cc>] common_interrupt+0x8c/0x8c
 <EOI>
 [<ffffffff811e1abb>] ? trace_hardirqs_on_caller+0x18b/0x290
 [<ffffffff81b722ae>] ? cpuidle_enter_state+0x1ae/0x4b0
 [<ffffffff81b722a7>] ? cpuidle_enter_state+0x1a7/0x4b0
 [<ffffffff81b72602>] cpuidle_enter+0x12/0x20
 [<ffffffff811d0b6e>] call_cpuidle+0x4e/0x90
 [<ffffffff811d10e7>] cpu_startup_entry+0x3f7/0x540
 [<ffffffff811d0cf0>] ? default_idle_call+0x50/0x50
 [<ffffffff81234bdf>] ? clockevents_config_and_register+0x5f/0x70
 [<ffffffff81085a9a>] ? setup_APIC_timer+0xfa/0x110
 [<ffffffff81083b63>] start_secondary+0x253/0x2b0
 [<ffffffff81083910>] ? set_cpu_sibling_map+0x920/0x920
Code: 4d 49 e0 8b b3 48 01 00 00 48 c7 c7 a0 ee f3 a0 e8 d9 c2 3f e0 49 81 fd 3f 1f 00 00 76 0f 49 81 fc 3f 1f 00 00 0f 87 c0 fd ff ff <0f> 0b 0f 0b 90 55 48 89 e5 41 57 41 56 48 8d 85 58 ff ff ff 41
RIP  [<ffffffffa0efbcfb>] ath10k_wmi_tx_beacons_iter+0x28b/0x290 [ath10k_core]
 RSP <ffff8801d6447a98>
---[ end trace 6588464714e5163a ]---

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 5db2cd0..186a696 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -831,7 +831,7 @@ static void __iterate_interfaces(struct ieee80211_local *local,
 			break;
 		}
 		if (!(iter_flags & IEEE80211_IFACE_ITER_RESUME_ALL) &&
-		    active_only && !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
+		    (active_only && (local->in_reconfig || !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))))
 			continue;
 		if (ieee80211_sdata_running(sdata) || !active_only)
 			iterator(data, sdata->vif.addr,
-- 
2.9.5


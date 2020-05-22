Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C811DEDF0
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 19:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgEVRMX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 13:12:23 -0400
Received: from mail.aperture-lab.de ([138.201.29.205]:37502 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbgEVRMW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 13:12:22 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2020 13:12:20 EDT
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1590167059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jrc6cxpSCPFmIwpoQg4KbnyEOuQBracyGs1BEVtpOPg=;
        b=XXRPi7EXRhTERLUNQ4QV77O8TOSRJezLZvL26ckefNkBFtij7M+nulfbLBUqc8EpXGexmw
        vKdkBFaIe3m+P75AeZcf5nFDmsIVvWiAlkNjMcaaIZ0nW2O7rBmIiLZdEL7fivrEZbafiK
        YP0Lgb+cUVOPte6/unT+oWOIo0klUt/Z8V0OoqCf3LmpziwDZVCiRx/66DRVmp8bO2H2+U
        6XpnCaXu2JuodP5dt6Qbd2rW+YoY1VMhK3BUnnK1A4SGDLiXK8ywtNcr/IAFZfAZGPjM9F
        /4u5+OoTe48dBUYEvQu2nFyiK9paTLgFMSP5Fw05KINp8TN0mpPZca2bdyLVZg==
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <ll@simonwunderlich.de>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH] mac80211: mesh: fix discovery timer re-arming issue / crash
Date:   Fri, 22 May 2020 19:04:13 +0200
Message-Id: <20200522170413.14973-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Linus Lüssing <ll@simonwunderlich.de>

On a non-forwarding 802.11s link between two fairly busy
neighboring nodes (iperf with -P 16 at ~850MBit/s TCP;
1733.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 4), so with
frequent PREQ retries, usually after around 30-40 seconds the
following crash would occur:

[ 1110.822428] Unable to handle kernel read from unreadable memory at virtual address 00000000
[ 1110.830786] Mem abort info:
[ 1110.833573]   Exception class = IABT (current EL), IL = 32 bits
[ 1110.839494]   SET = 0, FnV = 0
[ 1110.842546]   EA = 0, S1PTW = 0
[ 1110.845678] user pgtable: 4k pages, 48-bit VAs, pgd = ffff800076386000
[ 1110.852204] [0000000000000000] *pgd=00000000f6322003, *pud=00000000f62de003, *pmd=0000000000000000
[ 1110.861167] Internal error: Oops: 86000004 [#1] PREEMPT SMP
[ 1110.866730] Modules linked in: pppoe ppp_async batman_adv ath10k_pci ath10k_core ath pppox ppp_generic nf_conntrack_ipv6 mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_FLOWOFFLOAD slhc nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv4 nf_conntrack_ipv4 nf_nat_ipv4 nf_nat nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack iptable_mangle iptable_filter ip_tables crc_ccitt compat nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 usb_storage xhci_plat_hcd xhci_pci xhci_hcd dwc3 usbcore usb_common
[ 1110.932190] Process swapper/3 (pid: 0, stack limit = 0xffff0000090c8000)
[ 1110.938884] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.14.162 #0
[ 1110.944965] Hardware name: LS1043A RGW Board (DT)
[ 1110.949658] task: ffff8000787a81c0 task.stack: ffff0000090c8000
[ 1110.955568] PC is at 0x0
[ 1110.958097] LR is at call_timer_fn.isra.27+0x24/0x78
[ 1110.963055] pc : [<0000000000000000>] lr : [<ffff0000080ff29c>] pstate: 00400145
[ 1110.970440] sp : ffff00000801be10
[ 1110.973744] x29: ffff00000801be10 x28: ffff000008bf7018
[ 1110.979047] x27: ffff000008bf87c8 x26: ffff000008c160c0
[ 1110.984352] x25: 0000000000000000 x24: 0000000000000000
[ 1110.989657] x23: dead000000000200 x22: 0000000000000000
[ 1110.994959] x21: 0000000000000000 x20: 0000000000000101
[ 1111.000262] x19: ffff8000787a81c0 x18: 0000000000000000
[ 1111.005565] x17: ffff0000089167b0 x16: 0000000000000058
[ 1111.010868] x15: ffff0000089167b0 x14: 0000000000000000
[ 1111.016172] x13: ffff000008916788 x12: 0000000000000040
[ 1111.021475] x11: ffff80007fda9af0 x10: 0000000000000001
[ 1111.026777] x9 : ffff00000801bea0 x8 : 0000000000000004
[ 1111.032080] x7 : 0000000000000000 x6 : ffff80007fda9aa8
[ 1111.037383] x5 : ffff00000801bea0 x4 : 0000000000000010
[ 1111.042685] x3 : ffff00000801be98 x2 : 0000000000000614
[ 1111.047988] x1 : 0000000000000000 x0 : 0000000000000000
[ 1111.053290] Call trace:
[ 1111.055728] Exception stack(0xffff00000801bcd0 to 0xffff00000801be10)
[ 1111.062158] bcc0:                                   0000000000000000 0000000000000000
[ 1111.069978] bce0: 0000000000000614 ffff00000801be98 0000000000000010 ffff00000801bea0
[ 1111.077798] bd00: ffff80007fda9aa8 0000000000000000 0000000000000004 ffff00000801bea0
[ 1111.085618] bd20: 0000000000000001 ffff80007fda9af0 0000000000000040 ffff000008916788
[ 1111.093437] bd40: 0000000000000000 ffff0000089167b0 0000000000000058 ffff0000089167b0
[ 1111.101256] bd60: 0000000000000000 ffff8000787a81c0 0000000000000101 0000000000000000
[ 1111.109075] bd80: 0000000000000000 dead000000000200 0000000000000000 0000000000000000
[ 1111.116895] bda0: ffff000008c160c0 ffff000008bf87c8 ffff000008bf7018 ffff00000801be10
[ 1111.124715] bdc0: ffff0000080ff29c ffff00000801be10 0000000000000000 0000000000400145
[ 1111.132534] bde0: ffff8000787a81c0 ffff00000801bde8 0000ffffffffffff 000001029eb19be8
[ 1111.140353] be00: ffff00000801be10 0000000000000000
[ 1111.145220] [<          (null)>]           (null)
[ 1111.149917] [<ffff0000080ff77c>] run_timer_softirq+0x184/0x398
[ 1111.155741] [<ffff000008081938>] __do_softirq+0x100/0x1fc
[ 1111.161130] [<ffff0000080a2e28>] irq_exit+0x80/0xd8
[ 1111.166002] [<ffff0000080ea708>] __handle_domain_irq+0x88/0xb0
[ 1111.171825] [<ffff000008081678>] gic_handle_irq+0x68/0xb0
[ 1111.177213] Exception stack(0xffff0000090cbe30 to 0xffff0000090cbf70)
[ 1111.183642] be20:                                   0000000000000020 0000000000000000
[ 1111.191461] be40: 0000000000000001 0000000000000000 00008000771af000 0000000000000000
[ 1111.199281] be60: ffff000008c95180 0000000000000000 ffff000008c19360 ffff0000090cbef0
[ 1111.207101] be80: 0000000000000810 0000000000000400 0000000000000098 ffff000000000000
[ 1111.214920] bea0: 0000000000000001 ffff0000089167b0 0000000000000000 ffff0000089167b0
[ 1111.222740] bec0: 0000000000000000 ffff000008c198e8 ffff000008bf7018 ffff000008c19000
[ 1111.230559] bee0: 0000000000000000 0000000000000000 ffff8000787a81c0 ffff000008018000
[ 1111.238380] bf00: ffff00000801c000 ffff00000913ba34 ffff8000787a81c0 ffff0000090cbf70
[ 1111.246199] bf20: ffff0000080857cc ffff0000090cbf70 ffff0000080857d0 0000000000400145
[ 1111.254020] bf40: ffff000008018000 ffff00000801c000 ffffffffffffffff ffff0000080fa574
[ 1111.261838] bf60: ffff0000090cbf70 ffff0000080857d0
[ 1111.266706] [<ffff0000080832e8>] el1_irq+0xe8/0x18c
[ 1111.271576] [<ffff0000080857d0>] arch_cpu_idle+0x10/0x18
[ 1111.276880] [<ffff0000080d7de4>] do_idle+0xec/0x1b8
[ 1111.281748] [<ffff0000080d8020>] cpu_startup_entry+0x20/0x28
[ 1111.287399] [<ffff00000808f81c>] secondary_start_kernel+0x104/0x110
[ 1111.293662] Code: bad PC value
[ 1111.296710] ---[ end trace 555b6ca4363c3edd ]---
[ 1111.301318] Kernel panic - not syncing: Fatal exception in interrupt
[ 1111.307661] SMP: stopping secondary CPUs
[ 1111.311574] Kernel Offset: disabled
[ 1111.315053] CPU features: 0x0002000
[ 1111.318530] Memory Limit: none
[ 1111.321575] Rebooting in 3 seconds..

With some added debug output / delays we were able to push the crash from
the timer callback runner into the callback function and by that shedding
some light on which object holding the timer gets corrupted:

[  401.720899] Unable to handle kernel read from unreadable memory at virtual address 00000868
[...]
[  402.335836] [<ffff0000088fafa4>] _raw_spin_lock_bh+0x14/0x48
[  402.341548] [<ffff000000dbe684>] mesh_path_timer+0x10c/0x248 [mac80211]
[  402.348154] [<ffff0000080ff29c>] call_timer_fn.isra.27+0x24/0x78
[  402.354150] [<ffff0000080ff77c>] run_timer_softirq+0x184/0x398
[  402.359974] [<ffff000008081938>] __do_softirq+0x100/0x1fc
[  402.365362] [<ffff0000080a2e28>] irq_exit+0x80/0xd8
[  402.370231] [<ffff0000080ea708>] __handle_domain_irq+0x88/0xb0
[  402.376053] [<ffff000008081678>] gic_handle_irq+0x68/0xb0

The issue happens due to the following sequence of events:

1) mesh_path_start_discovery():
-> spin_unlock_bh(&mpath->state_lock) before mesh_path_sel_frame_tx()

2) mesh_path_free_rcu()
-> del_timer_sync(&mpath->timer)
   [...]
-> kfree_rcu(mpath)

3) mesh_path_start_discovery():
-> mod_timer(&mpath->timer, ...)
   [...]
-> rcu_read_unlock()

4) mesh_path_free_rcu()'s kfree_rcu():
-> kfree(mpath)

5) mesh_path_timer() starts after timeout, using freed mpath object

So a use-after-free issue due to a timer re-arming bug caused by an
early spin-unlocking.

This patch fixes this issue by re-checking if mpath is about to be
free'd and if so bails out of re-arming the timer.

Fixes: 050ac52cbe1f ("mac80211: code for on-demand Hybrid Wireless Mesh Protocol")
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Linus Lüssing <ll@simonwunderlich.de>
---
 net/mac80211/mesh_hwmp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 38a0383dfbcf..aa5150929996 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -1103,7 +1103,14 @@ void mesh_path_start_discovery(struct ieee80211_sub_if_data *sdata)
 	mesh_path_sel_frame_tx(MPATH_PREQ, 0, sdata->vif.addr, ifmsh->sn,
 			       target_flags, mpath->dst, mpath->sn, da, 0,
 			       ttl, lifetime, 0, ifmsh->preq_id++, sdata);
+
+	spin_lock_bh(&mpath->state_lock);
+	if (mpath->flags & MESH_PATH_DELETED) {
+		spin_unlock_bh(&mpath->state_lock);
+		goto enddiscovery;
+	}
 	mod_timer(&mpath->timer, jiffies + mpath->discovery_timeout);
+	spin_unlock_bh(&mpath->state_lock);
 
 enddiscovery:
 	rcu_read_unlock();
-- 
2.27.0.rc0


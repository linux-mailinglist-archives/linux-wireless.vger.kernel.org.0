Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C65F57D8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbfKHTm2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:42:28 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:46166 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbfKHTm0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:42:26 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id A8A5813C2B9;
        Fri,  8 Nov 2019 11:42:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A8A5813C2B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1573242145;
        bh=8ELRAG2n71de0dF7xggWJbz2Vlx0Mjl0IOo9finFisw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DptXW+4HMlZ3yQCRNZw6tOZCsyCEYFR5W5KbKXsZxrW+sTojG4wKux/ILPPdSemFP
         Azq6pMbXijLuQ4jaKCkmESwDhrDpczlh6ts/kGnTI1I/sHA/AVAFLSsNtmfXuwySHA
         AwqWHUJg2hFywvoGNVIql06LhHErafNNSzK/w1cs=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 03/10] mac80211: Don't spam kernel with sdata-in-driver failures.
Date:   Fri,  8 Nov 2019 11:42:04 -0800
Message-Id: <20191108194210.23618-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108194210.23618-1-greearb@candelatech.com>
References: <20191108194210.23618-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Using 400 hwsim radios with 1 station on each, we see lots and
lots of kernel warnings about sdata-in-driver check failures:

Feb 19 17:08:22 kernel: WARNING: CPU: 0 PID: 24673 at /home/greearb/git/linux-4.2.dev.y/net/mac80211/driver-ops.h:12 ieee80211_bss_info_change_notify+0xe7/0x166 [mac80211]()
Feb 19 17:08:22 kernel: S170657910:  Failed check-sdata-in-driver check, flags: 0x0
Feb 19 17:08:22 kernel: Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink wanlink(O) mac80211_hwsim nf_defrag_ipv4 mac80211 cfg80211 8021q mrp garp stp llc macvlan pktgen iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi vfat fat ipv6 ppdev pvpanic parport_pc parport 8250_fintek pcspkr joydev i2c_piix4 floppy cirrus ttm drm_kms_helper drm i2c_core [last unloaded: nfnetlink]
Feb 19 17:08:22 kernel: CPU: 0 PID: 24673 Comm: iwconfig Tainted: G        W  O    4.2.8+ #53
Feb 19 17:08:22 kernel: Hardware name: OpenStack Foundation OpenStack Nova, BIOS Bochs 01/01/2011
Feb 19 17:08:22 kernel: 0000000000000009 ffff8800bb233b68 ffffffff81696197 0000000000000006
Feb 19 17:08:22 kernel: ffff8800bb233bb8 ffff8800bb233ba8 ffffffff810e1fb4 ffff8800bb233c68
Feb 19 17:08:22 kernel: ffffffffa02ec8f2 ffff88037424a800 0000000000040000 ffff88037424b018
Feb 19 17:08:22 kernel: Call Trace:
Feb 19 17:08:22 kernel: [<ffffffff81696197>] dump_stack+0x4c/0x6e
Feb 19 17:08:22 kernel: [<ffffffff810e1fb4>] warn_slowpath_common+0x96/0xb0
Feb 19 17:08:22 kernel: [<ffffffffa02ec8f2>] ? ieee80211_bss_info_change_notify+0xe7/0x166 [mac80211]
Feb 19 17:08:22 kernel: [<ffffffff810e200f>] warn_slowpath_fmt+0x41/0x43
Feb 19 17:08:22 kernel: [<ffffffffa02ec8f2>] ieee80211_bss_info_change_notify+0xe7/0x166 [mac80211]
Feb 19 17:08:22 kernel: [<ffffffffa02fda00>] ieee80211_recalc_txpower+0x28/0x2d [mac80211]
Feb 19 17:08:22 kernel: [<ffffffffa0304155>] ieee80211_set_tx_power+0x8a/0x152 [mac80211]
Feb 19 17:08:22 kernel: [<ffffffffa027e4e1>] cfg80211_wext_siwtxpower+0xdc/0x12b [cfg80211]
Feb 19 17:08:22 kernel: [<ffffffff816837dc>] ioctl_standard_call+0x4a/0xa3
Feb 19 17:08:22 kernel: [<ffffffff816840f5>] ? iw_handler_get_private+0x49/0x49
Feb 19 17:08:22 kernel: [<ffffffff81683792>] ? call_commit_handler+0x2c/0x2c
Feb 19 17:08:22 kernel: [<ffffffff81682fba>] wireless_process_ioctl+0x6b/0x124
Feb 19 17:08:22 kernel: [<ffffffff816840f5>] ? iw_handler_get_private+0x49/0x49
Feb 19 17:08:22 kernel: [<ffffffff81683915>] wext_handle_ioctl+0x64/0xa1
Feb 19 17:08:22 kernel: [<ffffffff811f5af6>] ? inode_init_always+0x109/0x1b0
Feb 19 17:08:22 kernel: [<ffffffff815ffd30>] dev_ioctl+0x5a5/0x5d6
Feb 19 17:08:22 kernel: [<ffffffff811b3650>] ? handle_mm_fault+0xe6c/0xeb5
Feb 19 17:08:22 kernel: [<ffffffff815d4f12>] sock_ioctl+0x46/0x208
Feb 19 17:08:22 kernel: [<ffffffff811efb3c>] do_vfs_ioctl+0x372/0x420
Feb 19 17:08:22 kernel: [<ffffffff811365d2>] ? current_kernel_time+0x9/0x2d
Feb 19 17:08:22 kernel: [<ffffffff8115c765>] ? __audit_syscall_entry+0xbc/0xde
Feb 19 17:08:22 kernel: [<ffffffff811f7a59>] ? __fget_light+0x28/0x4a
Feb 19 17:08:22 kernel: [<ffffffff811efc3f>] SyS_ioctl+0x55/0x7a
Feb 19 17:08:22 kernel: [<ffffffff8169bcf2>] entry_SYSCALL_64_fastpath+0x16/0x75
Feb 19 17:08:22 kernel: ---[ end trace d4e525588dd9d9fc ]---
Feb 19 17:08:22 kernel: cfg80211: Setting DFS Master region in update_regulatory, was: 00 unset, new: 00 unset  lr: ffff8803ca63b300  regdom: ffffffffa0280f50

Instead, warn once, and then be silent after that.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/driver-ops.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 2c9b3eb8b652..d8967cd461fe 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -19,6 +19,17 @@ static inline bool check_sdata_in_driver(struct ieee80211_sub_if_data *sdata)
 		     sdata->dev ? sdata->dev->name : sdata->name, sdata->flags);
 }
 
+static inline bool _check_sdata_in_driver(struct ieee80211_sub_if_data *sdata,
+					  bool can_warn)
+{
+	if (can_warn)
+		return !WARN(!(sdata->flags & IEEE80211_SDATA_IN_DRIVER),
+			     "%s:  Failed check-sdata-in-driver check, flags: 0x%x\n",
+			     sdata->dev ? sdata->dev->name : sdata->name, sdata->flags);
+
+	return (sdata->flags & IEEE80211_SDATA_IN_DRIVER);
+}
+
 static inline struct ieee80211_sub_if_data *
 get_bss_sdata(struct ieee80211_sub_if_data *sdata)
 {
@@ -153,6 +164,7 @@ static inline void drv_bss_info_changed(struct ieee80211_local *local,
 					struct ieee80211_bss_conf *info,
 					u32 changed)
 {
+	static int warn_once = true;
 	might_sleep();
 
 	if (WARN_ON_ONCE(changed & (BSS_CHANGED_BEACON |
@@ -170,8 +182,10 @@ static inline void drv_bss_info_changed(struct ieee80211_local *local,
 			  !(changed & BSS_CHANGED_TXPOWER))))
 		return;
 
-	if (!check_sdata_in_driver(sdata))
+	if (!_check_sdata_in_driver(sdata, warn_once)) {
+		warn_once = false;
 		return;
+	}
 
 	trace_drv_bss_info_changed(local, sdata, info, changed);
 	if (local->ops->bss_info_changed)
-- 
2.20.1


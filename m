Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79E1233AFB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 23:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgG3VqR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 17:46:17 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:45048 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgG3VqR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 17:46:17 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5A14F13C2B0;
        Thu, 30 Jul 2020 14:46:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5A14F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1596145576;
        bh=wLzKmj3LS6VsdNjQWvRBgvj0nDaqjEVStZunrTM+ZU8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ipma8CttLAeCNXyTZkVhGCJNF8kmJb9ZMODkpZMbo87PaXTmhRo08qRqsGxQVnDIZ
         D25gXZnHZP9WxZI3F4dFKXHvG5irnNXsDYtt3BtaphE4BIeSyVAJdNNpR8yrNYsOE5
         KtNGe9wKdk8lK4d2/xKS+VZOd3mlUnz2MOaRCaq8=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211: Fix kernel hang when driver fails to make progress.
Date:   Thu, 30 Jul 2020 14:46:13 -0700
Message-Id: <20200730214613.13239-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

When sta_info_move does not make progress, likely to due driver
being funky, mac80211 can busy spin forever.  Fix this by detecting
the lack of progress and attempting to recover as best we can.

Painful details on how this bug was found:

I backported out-of-tree ax200 driver from backport-iwlwifi to my
5.4 kernel so that I could run ax200 beside other radios (backports
mac80211 otherwise is incompatible and other drivers will crash).

While running tx + rx udp and tcp traffic on ax200, it crashes often
(but backport driver is much more stable than in-kernel driver).

The crash often causes the kernel to deadlock due to the
while (sta->sta_state == IEEE80211_STA_AUTHORIZED)
loop in __sta_info_Destroy_part.  If sta_info_move_state does not
make progress, then it will loop forever.  In my case, sta_info_move_state
fails due to the sdata-in-driver check.

Hung process looks like this:

CPU: 7 PID: 23301 Comm: kworker/7:0 Tainted: G        W         5.4.43+ #5
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/19/2019
Workqueue: events_freezable ieee80211_restart_work [mac80211]
RIP: 0010:memcpy_erms+0x6/0x10
Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 ce
RSP: 0018:ffffc90006117728 EFLAGS: 00010002
RAX: ffffffff837ca040 RBX: 0000000000000000 RCX: 0000000000000006
RDX: 0000000000000046 RSI: ffffffff8380aa84 RDI: ffffffff837ca080
RBP: 0000000000000046 R08: 0000000000000000 R09: 0000000000001697
R10: 0000000000000007 R11: 0000000000000000 R12: ffffffff837ca040
R13: 0000000000000046 R14: 0000000000000000 R15: ffffffff8380aa44
FS:  0000000000000000(0000) GS:ffff88826ddc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562e61e28f18 CR3: 00000002554f6006 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 msg_print_text+0x12a/0x1e0
 console_unlock+0x160/0x600
 vprintk_emit+0x146/0x2c0
 printk+0x4d/0x69
 ? lockdep_hardirqs_on+0xf1/0x190
 __sdata_err+0x61/0x150 [mac80211]
 drv_sta_state+0x433/0x8f0 [mac80211]
 sta_info_move_state+0x28e/0x370 [mac80211]
 __sta_info_destroy_part2+0x48/0x1d0 [mac80211]
 __sta_info_flush+0xf6/0x180 [mac80211]
 ieee80211_set_disassoc+0xc1/0x490 [mac80211]
 ieee80211_mgd_deauth+0x291/0x420 [mac80211]
 cfg80211_mlme_deauth+0xd2/0x330 [cfg80211]
 cfg80211_mlme_down+0x7c/0xc0 [cfg80211]
 cfg80211_disconnect+0x2b1/0x320 [cfg80211]
 cfg80211_leave+0x23/0x30 [cfg80211]
 cfg80211_netdev_notifier_call+0x3a5/0x680 [cfg80211]
 ? lockdep_rtnl_is_held+0x11/0x20
 ? addrconf_notify+0xb4/0xbb0 [ipv6]
 ? packet_notifier+0xb8/0x2c0
 notifier_call_chain+0x40/0x60
 __dev_close_many+0x68/0x120
 dev_close_many+0x83/0x130
 dev_close.part.96+0x3f/0x70
 cfg80211_shutdown_all_interfaces+0x3e/0xc0 [cfg80211]
 ieee80211_reconfig+0x96/0x2180 [mac80211]
 ? cond_synchronize_rcu+0x20/0x20
 ieee80211_restart_work+0xb6/0xe0 [mac80211]
 process_one_work+0x27c/0x640
 worker_thread+0x47/0x3f0
 ? process_one_work+0x640/0x640
 kthread+0xfc/0x130
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x24/0x30

With this patch, there is safety code to bail out after 1000 tries of
moving the sta state, and also I check for EIO which is returned by
the sdata-in-driver failure case and treat that as success as far as
changing sta state goes.

Console logs look like this in the failure case, and aside from the ax200
radio that went phantom, the rest of the system is usable:

iwlwifi 0000:12:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:12:00.0: Firmware error during reconfiguration - reprobe!
iwlwifi 0000:12:00.0: Failed to start RT ucode: -5
wlan2: Failed check-sdata-in-driver check, flags: 0x0 count: 1
wlan2: Failed check-sdata-in-driver check, flags: 0x0 count: 1
wlan2: Failed check-sdata-in-driver check, flags: 0x0 count: 1
iwlwifi 0000:12:00.0: Failed to trigger RX queues sync (-5)
wlan2: Failed check-sdata-in-driver check, flags: 0x0 count: 1
wlan2: drv_sta_state failed with EIO (sdata not in driver?), state: 4  new-state: 3
wlan2: drv_sta_state failed with EIO (sdata not in driver?), state: 3  new-state: 2
wlan2: drv_sta_state failed with EIO (sdata not in driver?), state: 2  new-state: 1
wlan2: Failed check-sdata-in-driver check, flags: 0x0 count: 1
iwlwifi 0000:12:00.0: iwl_trans_wait_txq_empty bad state = 0
iwlwifi 0000:12:00.0: dma_pool_destroy iwlwifi:bc, 00000000d859bd4c busy

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Change title, use WARN_ONCE.  Compile tested only, please
double-check the WARN_ONCE usage.

 net/mac80211/sta_info.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index b30291906741..10799d681f2a 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1109,6 +1109,7 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct station_info *sinfo;
 	int ret;
+	int count = 0;
 
 	/*
 	 * NOTE: This assumes at least synchronize_net() was done
@@ -1121,6 +1122,11 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 	while (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
 		ret = sta_info_move_state(sta, IEEE80211_STA_ASSOC);
 		WARN_ON_ONCE(ret);
+		if (WARN_ONCE(++count > 1000, "%s: Could not move state after 1000 tries, ret: %d  state: %d\n",
+			      sdata->dev->name, ret, sta->sta_state)) {
+			/* WTF, bail out so that at least we don't hang the system. */
+			break;
+		}
 	}
 
 	/* now keys can no longer be reached */
@@ -2058,8 +2064,19 @@ int sta_info_move_state(struct sta_info *sta,
 	if (test_sta_flag(sta, WLAN_STA_INSERTED)) {
 		int err = drv_sta_state(sta->local, sta->sdata, sta,
 					sta->sta_state, new_state);
-		if (err)
-			return err;
+		if (err == -EIO) {
+			/* Sdata-not-in-driver, we are out of sync, but probably
+			 * best to carry on instead of bailing here, at least maybe
+			 * we can clean this up.
+			 */
+			sdata_err(sta->sdata, "drv_sta_state failed with EIO (sdata not in driver?), state: %d  new-state: %d\n",
+				  sta->sta_state, new_state);
+			WARN_ON_ONCE(1);
+		}
+		else {
+			if (err)
+				return err;
+		}
 	}
 
 	/* reflect the change in all state variables */
-- 
2.20.1


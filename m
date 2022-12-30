Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ED2659819
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Dec 2022 13:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiL3MTT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Dec 2022 07:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiL3MTT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Dec 2022 07:19:19 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 278DA1AA28
        for <linux-wireless@vger.kernel.org>; Fri, 30 Dec 2022 04:19:18 -0800 (PST)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1672402756;
        bh=U1+L9DNvznPlf2IyP2gi3a1b+7B+PjNv8Pi49ijQz/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=upG8BqR2k9EZEPDUzr2j2phqW4Sujle+4n8xaak4OdIBrAjaE7c4AMz63cErVZygG
         kCox3pTCseCzF9msIBcH2mFEEDjFmu5exqwiUrBaFjMrFljxyKLTElrAFGP7Cb7bCO
         tXjMfCzNKUzSuBr3phUSzCfoDO1sSHHDyavDrY98=
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] wifi: mac80211: sdata can be NULL during AMPDU start
Date:   Fri, 30 Dec 2022 13:18:50 +0100
Message-Id: <20221230121850.218810-2-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221230121850.218810-1-alexander@wetzel-home.de>
References: <20221230121850.218810-1-alexander@wetzel-home.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ieee80211_tx_ba_session_handle_start() may get NULL for sdata when a
deauthentication is ongoing.

Here a trace triggering the race with the hostapd test
multi_ap_fronthaul_on_ap:

(gdb) list *drv_ampdu_action+0x46
0x8b16 is in drv_ampdu_action (net/mac80211/driver-ops.c:396).
391             int ret = -EOPNOTSUPP;
392
393             might_sleep();
394
395             sdata = get_bss_sdata(sdata);
396             if (!check_sdata_in_driver(sdata))
397                     return -EIO;
398
399             trace_drv_ampdu_action(local, sdata, params);
400

wlan0: moving STA 02:00:00:00:03:00 to state 3
wlan0: associated
wlan0: deauthenticating from 02:00:00:00:03:00 by local choice (Reason: 3=DEAUTH_LEAVING)
wlan3.sta1: Open BA session requested for 02:00:00:00:00:00 tid 0
wlan3.sta1: dropped frame to 02:00:00:00:00:00 (unauthorized port)
wlan0: moving STA 02:00:00:00:03:00 to state 2
wlan0: moving STA 02:00:00:00:03:00 to state 1
wlan0: Removed STA 02:00:00:00:03:00
wlan0: Destroyed STA 02:00:00:00:03:00
BUG: unable to handle page fault for address: fffffffffffffb48
PGD 11814067 P4D 11814067 PUD 11816067 PMD 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 2 PID: 133397 Comm: kworker/u16:1 Tainted: G        W          6.1.0-rc8-wt+ #59
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
Workqueue: phy3 ieee80211_ba_session_work [mac80211]
RIP: 0010:drv_ampdu_action+0x46/0x280 [mac80211]
Code: 53 48 89 f3 be 89 01 00 00 e8 d6 43 bf ef e8 21 46 81 f0 83 bb a0 1b 00 00 04 75 0e 48 8b 9b 28 0d 00 00 48 81 eb 10 0e 00 00 <8b> 93 58 09 00 00 f6 c2 20 0f 84 3b 01 00 00 8b 05 dd 1c 0f 00 85
RSP: 0018:ffffc900025ebd20 EFLAGS: 00010287
RAX: 0000000000000000 RBX: fffffffffffff1f0 RCX: ffff888102228240
RDX: 0000000080000000 RSI: ffffffff918c5de0 RDI: ffff888102228b40
RBP: ffffc900025ebd40 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888118c18ec0
R13: 0000000000000000 R14: ffffc900025ebd60 R15: ffff888018b7efb8
FS:  0000000000000000(0000) GS:ffff88817a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffb48 CR3: 0000000105228006 CR4: 0000000000170ee0
Call Trace:
 <TASK>
 ieee80211_tx_ba_session_handle_start+0xd0/0x190 [mac80211]
 ieee80211_ba_session_work+0xff/0x2e0 [mac80211]
 process_one_work+0x29f/0x620
 worker_thread+0x4d/0x3d0
 ? process_one_work+0x620/0x620
 kthread+0xfb/0x120
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x22/0x30
 </TASK>

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>

---
The fix is not perfect, we still dereference sdata and use it without
any strong guarantee that it's still valid. But I don't see another
solution here without fundamental changes. With the patch I'm unable to
trigger the issue any longer. Other attempts to fix it failed in that
regard...

Alexander
---
 net/mac80211/agg-tx.c     | 6 +++++-
 net/mac80211/driver-ops.c | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 9c40f8d3bce8..3dbb724d7dc4 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -491,7 +491,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 {
 	struct tid_ampdu_tx *tid_tx;
 	struct ieee80211_local *local = sta->local;
-	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_ampdu_params params = {
 		.sta = &sta->sta,
 		.action = IEEE80211_AMPDU_TX_START,
@@ -521,6 +521,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 	 */
 	synchronize_net();
 
+	sdata = sta->sdata;
 	params.ssn = sta->tid_seq[tid] >> 4;
 	ret = drv_ampdu_action(local, sdata, &params);
 	tid_tx->ssn = params.ssn;
@@ -534,6 +535,9 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 		 */
 		set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state);
 	} else if (ret) {
+		if (!sdata)
+			return;
+
 		ht_dbg(sdata,
 		       "BA request denied - HW unavailable for %pM tid %d\n",
 		       sta->sta.addr, tid);
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index d737db4e07e2..cfb09e4aed4d 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -392,6 +392,9 @@ int drv_ampdu_action(struct ieee80211_local *local,
 
 	might_sleep();
 
+	if (!sdata)
+		return -EIO;
+
 	sdata = get_bss_sdata(sdata);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
-- 
2.39.0


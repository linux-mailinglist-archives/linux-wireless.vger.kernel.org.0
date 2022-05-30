Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A48537C6D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 15:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiE3Nbn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 09:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiE3Na2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 09:30:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C64B8D686;
        Mon, 30 May 2022 06:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2E72B80D89;
        Mon, 30 May 2022 13:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABE5C3411F;
        Mon, 30 May 2022 13:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653917240;
        bh=0SOjUx1vP3pC5to7NMBxAemGEoK1IKRZDN4I6BH/TuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r5llVgSf2B0XJJOjzcSt/Sub17ERn65EWdXZY1hhbZsy2Ceeh66LzVHqICsxiMlXT
         6Utvs4BIMCf2s9/YRPpGU0eNMeR2MSTXXpJKivL1Ui2c7z+pbdrmpXeGodkMbpjoKd
         QEK8hYYKkpSusW4WgxaBzuazlLUM9tfXY2ryKE/KpkLn80+8NIi09S/7punnb1+4r7
         Hq7rQfSAqJYQD59CuAX/ACtdoxoM81QNNVUzNG0jfzdZ26RygU3e72eOyRP4US3ST2
         RKnXiiyxaAc8H1KWw7esVP81G8mE0avQXU51/efcVSHx9r4anC3hKlFkOgFUpqXTGF
         pWlb6s408R4Xw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Abhishek Kumar <kuabhs@chromium.org>,
        Wen Gong <quic_wgong@quicinc.com>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 068/159] ath10k: skip ath10k_halt during suspend for driver state RESTARTING
Date:   Mon, 30 May 2022 09:22:53 -0400
Message-Id: <20220530132425.1929512-68-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530132425.1929512-1-sashal@kernel.org>
References: <20220530132425.1929512-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abhishek Kumar <kuabhs@chromium.org>

[ Upstream commit b72a4aff947ba807177bdabb43debaf2c66bee05 ]

Double free crash is observed when FW recovery(caused by wmi
timeout/crash) is followed by immediate suspend event. The FW recovery
is triggered by ath10k_core_restart() which calls driver clean up via
ath10k_halt(). When the suspend event occurs between the FW recovery,
the restart worker thread is put into frozen state until suspend completes.
The suspend event triggers ath10k_stop() which again triggers ath10k_halt()
The double invocation of ath10k_halt() causes ath10k_htt_rx_free() to be
called twice(Note: ath10k_htt_rx_alloc was not called by restart worker
thread because of its frozen state), causing the crash.

To fix this, during the suspend flow, skip call to ath10k_halt() in
ath10k_stop() when the current driver state is ATH10K_STATE_RESTARTING.
Also, for driver state ATH10K_STATE_RESTARTING, call
ath10k_wait_for_suspend() in ath10k_stop(). This is because call to
ath10k_wait_for_suspend() is skipped later in
[ath10k_halt() > ath10k_core_stop()] for the driver state
ATH10K_STATE_RESTARTING.

The frozen restart worker thread will be cancelled during resume when the
device comes out of suspend.

Below is the crash stack for reference:

[  428.469167] ------------[ cut here ]------------
[  428.469180] kernel BUG at mm/slub.c:4150!
[  428.469193] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  428.469219] Workqueue: events_unbound async_run_entry_fn
[  428.469230] RIP: 0010:kfree+0x319/0x31b
[  428.469241] RSP: 0018:ffffa1fac015fc30 EFLAGS: 00010246
[  428.469247] RAX: ffffedb10419d108 RBX: ffff8c05262b0000
[  428.469252] RDX: ffff8c04a8c07000 RSI: 0000000000000000
[  428.469256] RBP: ffffa1fac015fc78 R08: 0000000000000000
[  428.469276] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  428.469285] Call Trace:
[  428.469295]  ? dma_free_attrs+0x5f/0x7d
[  428.469320]  ath10k_core_stop+0x5b/0x6f
[  428.469336]  ath10k_halt+0x126/0x177
[  428.469352]  ath10k_stop+0x41/0x7e
[  428.469387]  drv_stop+0x88/0x10e
[  428.469410]  __ieee80211_suspend+0x297/0x411
[  428.469441]  rdev_suspend+0x6e/0xd0
[  428.469462]  wiphy_suspend+0xb1/0x105
[  428.469483]  ? name_show+0x2d/0x2d
[  428.469490]  dpm_run_callback+0x8c/0x126
[  428.469511]  ? name_show+0x2d/0x2d
[  428.469517]  __device_suspend+0x2e7/0x41b
[  428.469523]  async_suspend+0x1f/0x93
[  428.469529]  async_run_entry_fn+0x3d/0xd1
[  428.469535]  process_one_work+0x1b1/0x329
[  428.469541]  worker_thread+0x213/0x372
[  428.469547]  kthread+0x150/0x15f
[  428.469552]  ? pr_cont_work+0x58/0x58
[  428.469558]  ? kthread_blkcg+0x31/0x31

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
Co-developed-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20220426221859.v2.1.I650b809482e1af8d0156ed88b5dc2677a0711d46@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index b11aaee8b8c0..a11b31191d5a 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5339,13 +5339,29 @@ static int ath10k_start(struct ieee80211_hw *hw)
 static void ath10k_stop(struct ieee80211_hw *hw)
 {
 	struct ath10k *ar = hw->priv;
+	u32 opt;
 
 	ath10k_drain_tx(ar);
 
 	mutex_lock(&ar->conf_mutex);
 	if (ar->state != ATH10K_STATE_OFF) {
-		if (!ar->hw_rfkill_on)
-			ath10k_halt(ar);
+		if (!ar->hw_rfkill_on) {
+			/* If the current driver state is RESTARTING but not yet
+			 * fully RESTARTED because of incoming suspend event,
+			 * then ath10k_halt() is already called via
+			 * ath10k_core_restart() and should not be called here.
+			 */
+			if (ar->state != ATH10K_STATE_RESTARTING) {
+				ath10k_halt(ar);
+			} else {
+				/* Suspending here, because when in RESTARTING
+				 * state, ath10k_core_stop() skips
+				 * ath10k_wait_for_suspend().
+				 */
+				opt = WMI_PDEV_SUSPEND_AND_DISABLE_INTR;
+				ath10k_wait_for_suspend(ar, opt);
+			}
+		}
 		ar->state = ATH10K_STATE_OFF;
 	}
 	mutex_unlock(&ar->conf_mutex);
-- 
2.35.1


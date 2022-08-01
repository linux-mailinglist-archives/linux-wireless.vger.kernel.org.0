Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFB7586CB6
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Aug 2022 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiHAOTs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Aug 2022 10:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHAOTr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Aug 2022 10:19:47 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D214E22BF6
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659363586; x=1690899586;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t2X0WI6Nw8+PxkH+8k9Ql55DG6fzAKqBzfbuQLlTSFE=;
  b=blPL1rJYvvQGBEVFxYUaISiyk1zxbnPwMKoxm2wIrPEkeuoL4caZnnzQ
   i68phq4nZ8rqgSmsYka4rpI39DnNURyVcg0aO9p7sIFKkdFW1pw+SMGWy
   kEV1fiZtxDAFqpCCXzi4Vk+Jsu5RgUZ6eUOCtnhlrADxW5TO/WQt5WjUC
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Aug 2022 07:19:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 07:19:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 07:19:45 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 07:19:44 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] wifi: ath10k: add peer map clean up for peer delete in ath10k_sta_state()
Date:   Mon, 1 Aug 2022 10:19:30 -0400
Message-ID: <20220801141930.16794-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When peer delete failed in a disconnect operation, use-after-free
detected by KFENCE in below log. It is because for each vdev_id and
address, it has only one struct ath10k_peer, it is allocated in
ath10k_peer_map_event(). When connected to an AP, it has more than
one HTT_T2H_MSG_TYPE_PEER_MAP reported from firmware, then the
array peer_map of struct ath10k will be set muti-elements to the
same ath10k_peer in ath10k_peer_map_event(). When peer delete failed
in ath10k_sta_state(), the ath10k_peer will be free for the 1st peer
id in array peer_map of struct ath10k, and then use-after-free happened
for the 2nd peer id because they map to the same ath10k_peer.

And clean up all peers in array peer_map for the ath10k_peer, then
user-after-free disappeared

peer map event log:
[  306.911021] wlan0: authenticate with b0:2a:43:e6:75:0e
[  306.957187] ath10k_pci 0000:01:00.0: mac vdev 0 peer create b0:2a:43:e6:75:0e (new sta) sta 1 / 32 peer 1 / 33
[  306.957395] ath10k_pci 0000:01:00.0: htt peer map vdev 0 peer b0:2a:43:e6:75:0e id 246
[  306.957404] ath10k_pci 0000:01:00.0: htt peer map vdev 0 peer b0:2a:43:e6:75:0e id 198
[  306.986924] ath10k_pci 0000:01:00.0: htt peer map vdev 0 peer b0:2a:43:e6:75:0e id 166

peer unmap event log:
[  435.715691] wlan0: deauthenticating from b0:2a:43:e6:75:0e by local choice (Reason: 3=DEAUTH_LEAVING)
[  435.716802] ath10k_pci 0000:01:00.0: mac vdev 0 peer delete b0:2a:43:e6:75:0e sta ffff990e0e9c2b50 (sta gone)
[  435.717177] ath10k_pci 0000:01:00.0: htt peer unmap vdev 0 peer b0:2a:43:e6:75:0e id 246
[  435.717186] ath10k_pci 0000:01:00.0: htt peer unmap vdev 0 peer b0:2a:43:e6:75:0e id 198
[  435.717193] ath10k_pci 0000:01:00.0: htt peer unmap vdev 0 peer b0:2a:43:e6:75:0e id 166

use-after-free log:
<6>[21705.888627] wlan0: deauthenticating from d0:76:8f:82:be:75 by local choice (Reason: 3=DEAUTH_LEAVING)
<4>[21713.799910] ath10k_pci 0000:01:00.0: failed to delete peer d0:76:8f:82:be:75 for vdev 0: -110
<4>[21713.799925] ath10k_pci 0000:01:00.0: found sta peer d0:76:8f:82:be:75 (ptr 0000000000000000 id 102) entry on vdev 0 after it was supposedly removed
<3>[21713.799968] ==================================================================
<3>[21713.799991] BUG: KFENCE: use-after-free read in ath10k_sta_state+0x265/0xb8a [ath10k_core]
<3>[21713.799991]
<3>[21713.799997] Use-after-free read at 0x00000000abe1c75e (in kfence-#69):
<4>[21713.800010]  ath10k_sta_state+0x265/0xb8a [ath10k_core]
<4>[21713.800041]  drv_sta_state+0x115/0x677 [mac80211]
<4>[21713.800059]  __sta_info_destroy_part2+0xb1/0x133 [mac80211]
<4>[21713.800076]  __sta_info_flush+0x11d/0x162 [mac80211]
<4>[21713.800093]  ieee80211_set_disassoc+0x12d/0x2f4 [mac80211]
<4>[21713.800110]  ieee80211_mgd_deauth+0x26c/0x29b [mac80211]
<4>[21713.800137]  cfg80211_mlme_deauth+0x13f/0x1bb [cfg80211]
<4>[21713.800153]  nl80211_deauthenticate+0xf8/0x121 [cfg80211]
<4>[21713.800161]  genl_rcv_msg+0x38e/0x3be
<4>[21713.800166]  netlink_rcv_skb+0x89/0xf7
<4>[21713.800171]  genl_rcv+0x28/0x36
<4>[21713.800176]  netlink_unicast+0x179/0x24b
<4>[21713.800181]  netlink_sendmsg+0x3a0/0x40e
<4>[21713.800187]  sock_sendmsg+0x72/0x76
<4>[21713.800192]  ____sys_sendmsg+0x16d/0x1e3
<4>[21713.800196]  ___sys_sendmsg+0x95/0xd1
<4>[21713.800200]  __sys_sendmsg+0x85/0xbf
<4>[21713.800205]  do_syscall_64+0x43/0x55
<4>[21713.800210]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<3>[21713.800213]
<4>[21713.800219] kfence-#69: 0x000000009149b0d5-0x000000004c0697fb, size=1064, cache=kmalloc-2k
<4>[21713.800219]
<4>[21713.800224] allocated by task 13 on cpu 0 at 21705.501373s:
<4>[21713.800241]  ath10k_peer_map_event+0x7e/0x154 [ath10k_core]
<4>[21713.800254]  ath10k_htt_t2h_msg_handler+0x586/0x1039 [ath10k_core]
<4>[21713.800265]  ath10k_htt_htc_t2h_msg_handler+0x12/0x28 [ath10k_core]
<4>[21713.800277]  ath10k_htc_rx_completion_handler+0x14c/0x1b5 [ath10k_core]
<4>[21713.800283]  ath10k_pci_process_rx_cb+0x195/0x1df [ath10k_pci]
<4>[21713.800294]  ath10k_ce_per_engine_service+0x55/0x74 [ath10k_core]
<4>[21713.800305]  ath10k_ce_per_engine_service_any+0x76/0x84 [ath10k_core]
<4>[21713.800310]  ath10k_pci_napi_poll+0x49/0x144 [ath10k_pci]
<4>[21713.800316]  net_rx_action+0xdc/0x361
<4>[21713.800320]  __do_softirq+0x163/0x29a
<4>[21713.800325]  asm_call_irq_on_stack+0x12/0x20
<4>[21713.800331]  do_softirq_own_stack+0x3c/0x48
<4>[21713.800337]  __irq_exit_rcu+0x9b/0x9d
<4>[21713.800342]  common_interrupt+0xc9/0x14d
<4>[21713.800346]  asm_common_interrupt+0x1e/0x40
<4>[21713.800351]  ksoftirqd_should_run+0x5/0x16
<4>[21713.800357]  smpboot_thread_fn+0x148/0x211
<4>[21713.800362]  kthread+0x150/0x15f
<4>[21713.800367]  ret_from_fork+0x22/0x30
<4>[21713.800370]
<4>[21713.800374] freed by task 708 on cpu 1 at 21713.799953s:
<4>[21713.800498]  ath10k_sta_state+0x2c6/0xb8a [ath10k_core]
<4>[21713.800515]  drv_sta_state+0x115/0x677 [mac80211]
<4>[21713.800532]  __sta_info_destroy_part2+0xb1/0x133 [mac80211]
<4>[21713.800548]  __sta_info_flush+0x11d/0x162 [mac80211]
<4>[21713.800565]  ieee80211_set_disassoc+0x12d/0x2f4 [mac80211]
<4>[21713.800581]  ieee80211_mgd_deauth+0x26c/0x29b [mac80211]
<4>[21713.800598]  cfg80211_mlme_deauth+0x13f/0x1bb [cfg80211]
<4>[21713.800614]  nl80211_deauthenticate+0xf8/0x121 [cfg80211]
<4>[21713.800619]  genl_rcv_msg+0x38e/0x3be
<4>[21713.800623]  netlink_rcv_skb+0x89/0xf7
<4>[21713.800628]  genl_rcv+0x28/0x36
<4>[21713.800632]  netlink_unicast+0x179/0x24b
<4>[21713.800637]  netlink_sendmsg+0x3a0/0x40e
<4>[21713.800642]  sock_sendmsg+0x72/0x76
<4>[21713.800646]  ____sys_sendmsg+0x16d/0x1e3
<4>[21713.800651]  ___sys_sendmsg+0x95/0xd1
<4>[21713.800655]  __sys_sendmsg+0x85/0xbf
<4>[21713.800659]  do_syscall_64+0x43/0x55
<4>[21713.800663]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1

Fixes: d0eeafad1189 ("ath10k: Clean up peer when sta goes away.")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2: add "wifi:" in subject

 drivers/net/wireless/ath/ath10k/mac.c | 54 ++++++++++++++-------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index a04e18250dae..5ccbb81739de 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -864,11 +864,36 @@ static int ath10k_peer_delete(struct ath10k *ar, u32 vdev_id, const u8 *addr)
 	return 0;
 }
 
+static void ath10k_peer_map_cleanup(struct ath10k *ar, struct ath10k_peer *peer)
+{
+	int peer_id, i;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	for_each_set_bit(peer_id, peer->peer_ids,
+			 ATH10K_MAX_NUM_PEER_IDS) {
+		ar->peer_map[peer_id] = NULL;
+	}
+
+	/* Double check that peer is properly un-referenced from
+	 * the peer_map
+	 */
+	for (i = 0; i < ARRAY_SIZE(ar->peer_map); i++) {
+		if (ar->peer_map[i] == peer) {
+			ath10k_warn(ar, "removing stale peer_map entry for %pM (ptr %pK idx %d)\n",
+				    peer->addr, peer, i);
+			ar->peer_map[i] = NULL;
+		}
+	}
+
+	list_del(&peer->list);
+	kfree(peer);
+	ar->num_peers--;
+}
+
 static void ath10k_peer_cleanup(struct ath10k *ar, u32 vdev_id)
 {
 	struct ath10k_peer *peer, *tmp;
-	int peer_id;
-	int i;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -880,25 +905,7 @@ static void ath10k_peer_cleanup(struct ath10k *ar, u32 vdev_id)
 		ath10k_warn(ar, "removing stale peer %pM from vdev_id %d\n",
 			    peer->addr, vdev_id);
 
-		for_each_set_bit(peer_id, peer->peer_ids,
-				 ATH10K_MAX_NUM_PEER_IDS) {
-			ar->peer_map[peer_id] = NULL;
-		}
-
-		/* Double check that peer is properly un-referenced from
-		 * the peer_map
-		 */
-		for (i = 0; i < ARRAY_SIZE(ar->peer_map); i++) {
-			if (ar->peer_map[i] == peer) {
-				ath10k_warn(ar, "removing stale peer_map entry for %pM (ptr %pK idx %d)\n",
-					    peer->addr, peer, i);
-				ar->peer_map[i] = NULL;
-			}
-		}
-
-		list_del(&peer->list);
-		kfree(peer);
-		ar->num_peers--;
+		ath10k_peer_map_cleanup(ar, peer);
 	}
 	spin_unlock_bh(&ar->data_lock);
 }
@@ -7620,10 +7627,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 				/* Clean up the peer object as well since we
 				 * must have failed to do this above.
 				 */
-				list_del(&peer->list);
-				ar->peer_map[i] = NULL;
-				kfree(peer);
-				ar->num_peers--;
+				ath10k_peer_map_cleanup(ar, peer);
 			}
 		}
 		spin_unlock_bh(&ar->data_lock);

base-commit: c35538ce3b892dd4b41e24e887a434f296792959
-- 
2.31.1


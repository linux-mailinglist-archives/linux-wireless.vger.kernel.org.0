Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA71A6F7459
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 21:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjEDTud (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 15:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjEDTtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 15:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84CA13297;
        Thu,  4 May 2023 12:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 745F263792;
        Thu,  4 May 2023 19:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFFAC4339B;
        Thu,  4 May 2023 19:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229549;
        bh=DZKU6XSyyuM1gByFJC0vIm3uimmnBCy1jTXJ/4/A0vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fj9IioaQ+yfIYw1iF/IkH6gVV9//TJQ9u0sAajytfZuzIZikhMt0vS3azh0y6Ns3W
         98ivIz2unBVsaL8xhtXp0yco0/B4DmawdyfhDSdZS11qAnVlMeQuMdW9SLuGi8ju0V
         63xjhnzi6HNLhnUnupRxPM12BwPLu4FX3czi9L/BKbesIgvXWcGuRQtD5leD3Sg24h
         YkZvZNjtL/oEJLOOVKks0FvCfrKwXwW2gDRtogK6DFC7wYyXkmeQ+eEDOo5kocxt+Z
         pllHz/GS+5fqScCbAsvaM/f+D2yz1yQA15P5CXJZlfK1iMZjqQ98pj6qR4UrCydMdZ
         wZgxE8FQ+UkDQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harshitha Prem <quic_hprem@quicinc.com>,
        Nagarajan Maran <quic_nmaran@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 36/53] wifi: ath11k: Ignore frags from uninitialized peer in dp.
Date:   Thu,  4 May 2023 15:43:56 -0400
Message-Id: <20230504194413.3806354-36-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Harshitha Prem <quic_hprem@quicinc.com>

[ Upstream commit a06bfb3c9f69f303692cdae87bc0899d2ae8b2a6 ]

When max virtual ap interfaces are configured in all the bands with
ACS and hostapd restart is done every 60s, a crash is observed at
random times.
In this certain scenario, a fragmented packet is received for
self peer, for which rx_tid and rx_frags are not initialized in
datapath. While handling this fragment, crash is observed as the
rx_frag list is uninitialised and when we walk in
ath11k_dp_rx_h_sort_frags, skb null leads to exception.

To address this, before processing received fragments we check
dp_setup_done flag is set to ensure that peer has completed its
dp peer setup for fragment queue, else ignore processing the
fragments.

Call trace:
  ath11k_dp_process_rx_err+0x550/0x1084 [ath11k]
  ath11k_dp_service_srng+0x70/0x370 [ath11k]
  0xffffffc009693a04
  __napi_poll+0x30/0xa4
  net_rx_action+0x118/0x270
  __do_softirq+0x10c/0x244
  irq_exit+0x64/0xb4
  __handle_domain_irq+0x88/0xac
  gic_handle_irq+0x74/0xbc
  el1_irq+0xf0/0x1c0
  arch_cpu_idle+0x10/0x18
  do_idle+0x104/0x248
  cpu_startup_entry+0x20/0x64
  rest_init+0xd0/0xdc
  arch_call_rest_init+0xc/0x14
  start_kernel+0x480/0x4b8
  Code: f9400281 f94066a2 91405021 b94a0023 (f9406401)

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230403184155.8670-2-quic_nmaran@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp.c    | 4 +++-
 drivers/net/wireless/ath/ath11k/dp_rx.c | 8 ++++++++
 drivers/net/wireless/ath/ath11k/peer.h  | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index f5156a7fbdd7a..d070bcb3fe247 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -36,6 +36,7 @@ void ath11k_dp_peer_cleanup(struct ath11k *ar, int vdev_id, const u8 *addr)
 	}
 
 	ath11k_peer_rx_tid_cleanup(ar, peer);
+	peer->dp_setup_done = false;
 	crypto_free_shash(peer->tfm_mmic);
 	spin_unlock_bh(&ab->base_lock);
 }
@@ -72,7 +73,8 @@ int ath11k_dp_peer_setup(struct ath11k *ar, int vdev_id, const u8 *addr)
 	ret = ath11k_peer_rx_frag_setup(ar, addr, vdev_id);
 	if (ret) {
 		ath11k_warn(ab, "failed to setup rx defrag context\n");
-		return ret;
+		tid--;
+		goto peer_clean;
 	}
 
 	/* TODO: Setup other peer specific resource used in data path */
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index e964e1b722871..1786d83f8f2ed 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3138,6 +3138,7 @@ int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id
 	}
 
 	peer->tfm_mmic = tfm;
+	peer->dp_setup_done = true;
 	spin_unlock_bh(&ab->base_lock);
 
 	return 0;
@@ -3583,6 +3584,13 @@ static int ath11k_dp_rx_frag_h_mpdu(struct ath11k *ar,
 		ret = -ENOENT;
 		goto out_unlock;
 	}
+	if (!peer->dp_setup_done) {
+		ath11k_warn(ab, "The peer %pM [%d] has uninitialized datapath\n",
+			    peer->addr, peer_id);
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
 	rx_tid = &peer->rx_tid[tid];
 
 	if ((!skb_queue_empty(&rx_tid->rx_frags) && seqno != rx_tid->cur_sn) ||
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 6dd17bafe3a0c..9bd385d0a38c9 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -35,6 +35,7 @@ struct ath11k_peer {
 	u16 sec_type;
 	u16 sec_type_grp;
 	bool is_authorized;
+	bool dp_setup_done;
 };
 
 void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id);
-- 
2.39.2


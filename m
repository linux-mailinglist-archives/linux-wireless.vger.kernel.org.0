Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8270D591390
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiHLQLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbiHLQK5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F1A50DF
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0383AB8248C
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D9EC433D7;
        Fri, 12 Aug 2022 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320645;
        bh=1xHK8GqI1RR066SlJkmt9TyqVekiMv873sCKWYIPPcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9iEzlSn38yRBbD361cEhRRbsXgXRG9op+47zeOHrpR40AY9+WzgFQDiPlTY7260T
         NIHLRAnQlGc1gjTnziG/ijhTNv4cwykxyj3A8KfLuDLrYlAWpwEba0U/jey3s6TGp8
         duY7qoAfkxqgRikC0ex19IERauW8OHeC5xDv+LnDuVCUDICyNLBZijNSPA/bxJrw1f
         58EZxrx/+TdY6aurTY8MbbYt7wmQbes64iyA1+UmNbAFH/VJGDmpuEaudI/copMe0Z
         2G1EvDL/5w0KAqqT5Rleb6j41bzg1t9qipCGW2/3OjzELWYbo33K3Z/Xn7FY25DKIo
         yRFgWza580mSw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 37/50] wifi: ath12k: add peer.c
Date:   Fri, 12 Aug 2022 19:09:50 +0300
Message-Id: <20220812161003.27279-38-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812161003.27279-1-kvalo@kernel.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
MIME-Version: 1.0
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

From: Kalle Valo <quic_kvalo@quicinc.com>

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/peer.c | 343 +++++++++++++++++++++++++++++++++
 1 file changed, 343 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
new file mode 100644
index 000000000000..30ffdbbdcc7f
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "core.h"
+#include "peer.h"
+#include "debug.h"
+
+struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
+				     const u8 *addr)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (peer->vdev_id != vdev_id)
+			continue;
+		if (!ether_addr_equal(peer->addr, addr))
+			continue;
+
+		return peer;
+	}
+
+	return NULL;
+}
+
+static struct ath12k_peer *ath12k_peer_find_by_pdev_idx(struct ath12k_base *ab,
+							u8 pdev_idx, const u8 *addr)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (peer->pdev_idx != pdev_idx)
+			continue;
+		if (!ether_addr_equal(peer->addr, addr))
+			continue;
+
+		return peer;
+	}
+
+	return NULL;
+}
+
+struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
+					     const u8 *addr)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (!ether_addr_equal(peer->addr, addr))
+			continue;
+
+		return peer;
+	}
+
+	return NULL;
+}
+
+struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
+					   int peer_id)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list)
+		if (peer_id == peer->peer_id)
+			return peer;
+
+	return NULL;
+}
+
+struct ath12k_peer *ath12k_peer_find_by_vdev_id(struct ath12k_base *ab,
+						int vdev_id)
+{
+	struct ath12k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (vdev_id == peer->vdev_id) {
+			spin_unlock_bh(&ab->base_lock);
+			return peer;
+		}
+	}
+	spin_unlock_bh(&ab->base_lock);
+	return NULL;
+}
+
+struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab,
+					    int ast_hash)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list)
+		if (ast_hash == peer->ast_hash)
+			return peer;
+
+	return NULL;
+}
+
+void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
+{
+	struct ath12k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath12k_peer_find_by_id(ab, peer_id);
+	if (!peer) {
+		ath12k_warn(ab, "peer-unmap-event: unknown peer id %d\n",
+			    peer_id);
+		goto exit;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt peer unmap vdev %d peer %pM id %d\n",
+		   peer->vdev_id, peer->addr, peer_id);
+
+	list_del(&peer->list);
+	kfree(peer);
+	wake_up(&ab->peer_mapping_wq);
+
+exit:
+	spin_unlock_bh(&ab->base_lock);
+}
+
+void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
+			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id)
+{
+	struct ath12k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_peer_find(ab, vdev_id, mac_addr);
+	if (!peer) {
+		peer = kzalloc(sizeof(*peer), GFP_ATOMIC);
+		if (!peer)
+			goto exit;
+
+		peer->vdev_id = vdev_id;
+		peer->peer_id = peer_id;
+		peer->ast_hash = ast_hash;
+		peer->hw_peer_id = hw_peer_id;
+		ether_addr_copy(peer->addr, mac_addr);
+		list_add(&peer->list, &ab->peers);
+		wake_up(&ab->peer_mapping_wq);
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt peer map vdev %d peer %pM id %d\n",
+		   vdev_id, mac_addr, peer_id);
+
+exit:
+	spin_unlock_bh(&ab->base_lock);
+}
+
+static int ath12k_wait_for_peer_common(struct ath12k_base *ab, int vdev_id,
+				       const u8 *addr, bool expect_mapped)
+{
+	int ret;
+
+	ret = wait_event_timeout(ab->peer_mapping_wq, ({
+				bool mapped;
+
+				spin_lock_bh(&ab->base_lock);
+				mapped = !!ath12k_peer_find(ab, vdev_id, addr);
+				spin_unlock_bh(&ab->base_lock);
+
+				(mapped == expect_mapped ||
+				 test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags));
+				}), 3 * HZ);
+
+	if (ret <= 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id)
+{
+	struct ath12k_peer *peer, *tmp;
+	struct ath12k_base *ab = ar->ab;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	spin_lock_bh(&ab->base_lock);
+	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
+		if (peer->vdev_id != vdev_id)
+			continue;
+
+		ath12k_warn(ab, "removing stale peer %pM from vdev_id %d\n",
+			    peer->addr, vdev_id);
+
+		list_del(&peer->list);
+		kfree(peer);
+		ar->num_peers--;
+	}
+
+	spin_unlock_bh(&ab->base_lock);
+}
+
+static int ath12k_wait_for_peer_deleted(struct ath12k *ar, int vdev_id, const u8 *addr)
+{
+	return ath12k_wait_for_peer_common(ar->ab, vdev_id, addr, false);
+}
+
+int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
+				     const u8 *addr)
+{
+	int ret;
+	unsigned long time_left;
+
+	ret = ath12k_wait_for_peer_deleted(ar, vdev_id, addr);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed wait for peer deleted");
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->peer_delete_done,
+						3 * HZ);
+	if (time_left == 0) {
+		ath12k_warn(ar->ab, "Timeout in receiving peer delete response\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr)
+{
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	reinit_completion(&ar->peer_delete_done);
+
+	ret = ath12k_wmi_send_peer_delete_cmd(ar, addr, vdev_id);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to delete peer vdev_id %d addr %pM ret %d\n",
+			    vdev_id, addr, ret);
+		return ret;
+	}
+
+	ret = ath12k_wait_for_peer_delete_done(ar, vdev_id, addr);
+	if (ret)
+		return ret;
+
+	ar->num_peers--;
+
+	return 0;
+}
+
+static int ath12k_wait_for_peer_created(struct ath12k *ar, int vdev_id, const u8 *addr)
+{
+	return ath12k_wait_for_peer_common(ar->ab, vdev_id, addr, true);
+}
+
+int ath12k_peer_create(struct ath12k *ar, struct ath12k_vif *arvif,
+		       struct ieee80211_sta *sta,
+		       struct ath12k_wmi_peer_create_arg *arg)
+{
+	struct ath12k_peer *peer;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (ar->num_peers > (ar->max_num_peers - 1)) {
+		ath12k_warn(ar->ab,
+			    "failed to create peer due to insufficient peer entry resource in firmware\n");
+		return -ENOBUFS;
+	}
+
+	spin_lock_bh(&ar->ab->base_lock);
+	peer = ath12k_peer_find_by_pdev_idx(ar->ab, ar->pdev_idx, arg->peer_addr);
+	if (peer) {
+		spin_unlock_bh(&ar->ab->base_lock);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	ret = ath12k_wmi_send_peer_create_cmd(ar, arg);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to send peer create vdev_id %d ret %d\n",
+			    arg->vdev_id, ret);
+		return ret;
+	}
+
+	ret = ath12k_wait_for_peer_created(ar, arg->vdev_id,
+					   arg->peer_addr);
+	if (ret)
+		return ret;
+
+	spin_lock_bh(&ar->ab->base_lock);
+
+	peer = ath12k_peer_find(ar->ab, arg->vdev_id, arg->peer_addr);
+	if (!peer) {
+		spin_unlock_bh(&ar->ab->base_lock);
+		ath12k_warn(ar->ab, "failed to find peer %pM on vdev %i after creation\n",
+			    arg->peer_addr, arg->vdev_id);
+
+		reinit_completion(&ar->peer_delete_done);
+
+		ret = ath12k_wmi_send_peer_delete_cmd(ar, arg->peer_addr,
+						      arg->vdev_id);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
+				    arg->vdev_id, arg->peer_addr);
+			return ret;
+		}
+
+		ret = ath12k_wait_for_peer_delete_done(ar, arg->vdev_id,
+						       arg->peer_addr);
+		if (ret)
+			return ret;
+
+		return -ENOENT;
+	}
+
+	peer->pdev_idx = ar->pdev_idx;
+	peer->sta = sta;
+
+	if (arvif->vif->type == NL80211_IFTYPE_STATION) {
+		arvif->ast_hash = peer->ast_hash;
+		arvif->ast_idx = peer->hw_peer_id;
+	}
+
+	peer->sec_type = HAL_ENCRYPT_TYPE_OPEN;
+	peer->sec_type_grp = HAL_ENCRYPT_TYPE_OPEN;
+
+	ar->num_peers++;
+
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	return 0;
+}


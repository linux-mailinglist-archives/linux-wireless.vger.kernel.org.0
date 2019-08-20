Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3B9655D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfHTPuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:50:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45958 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730661AbfHTPuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:50:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 96DB061BE2; Tue, 20 Aug 2019 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316217;
        bh=0Tm9dsgGn1v5E3kEMinoUDouoXdJufht5mJ0KlZ3bXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jz/cz+B7UQhAKVPXLOrkZi6OJPFRcipQwSYzWjEFlNk0CypcAOYUCjxkwOEkXz/Oe
         OmvdF3L0fmX14vXuv0vxfU23Io5EjSOtQt1Y6bYKiHCrSoRGainM3NmlfCmd9W/WZ2
         srgWKDPTsih1LwLw/NkyfdWTJm8lOGBsIk9Am4+E=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6C2461AD7;
        Tue, 20 Aug 2019 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316192;
        bh=0Tm9dsgGn1v5E3kEMinoUDouoXdJufht5mJ0KlZ3bXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLSf5D0Qz8OfR9irh0rfad5oSaARAb5GxmUl2N18DIWZQIkoePYAQm/7tIAkOOvOU
         WQDeLwVkqpydrd0ARrCzi/uzyDfiNZ2czbOtVZlX+bw9+VHaumFGcv/eKGz/nwlbWJ
         GWMPsnT1K9Qcetm2KV4GETcmRSm1T2lfyrKyMazg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6C2461AD7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 33/49] ath11k: add peer.c
Date:   Tue, 20 Aug 2019 18:47:59 +0300
Message-Id: <1566316095-27507-34-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/peer.c | 236 +++++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
new file mode 100644
index 000000000000..d484a3b42e49
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#include "core.h"
+#include "peer.h"
+#include "debug.h"
+
+struct ath11k_peer *ath11k_peer_find(struct ath11k_base *ab, int vdev_id,
+				     const u8 *addr)
+{
+	struct ath11k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (peer->vdev_id != vdev_id)
+			continue;
+		if (memcmp(peer->addr, addr, ETH_ALEN))
+			continue;
+
+		return peer;
+	}
+
+	return NULL;
+}
+
+struct ath11k_peer *ath11k_peer_find_by_addr(struct ath11k_base *ab,
+					     const u8 *addr)
+{
+	struct ath11k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (memcmp(peer->addr, addr, ETH_ALEN))
+			continue;
+
+		return peer;
+	}
+
+	return NULL;
+}
+
+struct ath11k_peer *ath11k_peer_find_by_id(struct ath11k_base *ab,
+					   int peer_id)
+{
+	struct ath11k_peer *peer;
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
+void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id)
+{
+	struct ath11k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath11k_peer_find_by_id(ab, peer_id);
+	if (!peer) {
+		ath11k_warn(ab, "peer-unmap-event: unknown peer id %d\n",
+			    peer_id);
+		goto exit;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "htt peer unmap vdev %d peer %pM id %d\n",
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
+void ath11k_peer_map_event(struct ath11k_base *ab, u8 vdev_id, u16 peer_id,
+			   u8 *mac_addr, u16 ast_hash)
+{
+	struct ath11k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find(ab, vdev_id, mac_addr);
+	if (!peer) {
+		peer = kzalloc(sizeof(*peer), GFP_ATOMIC);
+		if (!peer)
+			goto exit;
+
+		peer->vdev_id = vdev_id;
+		peer->peer_id = peer_id;
+		peer->ast_hash = ast_hash;
+		ether_addr_copy(peer->addr, mac_addr);
+		list_add(&peer->list, &ab->peers);
+		wake_up(&ab->peer_mapping_wq);
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "htt peer map vdev %d peer %pM id %d\n",
+		   vdev_id, mac_addr, peer_id);
+
+exit:
+	spin_unlock_bh(&ab->base_lock);
+}
+
+static int ath11k_wait_for_peer_common(struct ath11k_base *ab, int vdev_id,
+				       const u8 *addr, bool expect_mapped)
+{
+	int ret;
+
+	ret = wait_event_timeout(ab->peer_mapping_wq, ({
+				bool mapped;
+
+				spin_lock_bh(&ab->base_lock);
+				mapped = !!ath11k_peer_find(ab, vdev_id, addr);
+				spin_unlock_bh(&ab->base_lock);
+
+				(mapped == expect_mapped ||
+				 test_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags));
+				}), 3 * HZ);
+
+	if (ret <= 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+void ath11k_peer_cleanup(struct ath11k *ar, u32 vdev_id)
+{
+	struct ath11k_peer *peer, *tmp;
+	struct ath11k_base *ab = ar->ab;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	spin_lock_bh(&ab->base_lock);
+	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
+		if (peer->vdev_id != vdev_id)
+			continue;
+
+		ath11k_warn(ab, "removing stale peer %pM from vdev_id %d\n",
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
+static int ath11k_wait_for_peer_deleted(struct ath11k *ar, int vdev_id, const u8 *addr)
+{
+	return ath11k_wait_for_peer_common(ar->ab, vdev_id, addr, false);
+}
+
+int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr)
+{
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	ret = ath11k_wmi_send_peer_delete_cmd(ar, addr, vdev_id);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to delete peer vdev_id %d addr %pM ret %d\n",
+			    vdev_id, addr, ret);
+		return ret;
+	}
+
+	ret = ath11k_wait_for_peer_deleted(ar, vdev_id, addr);
+	if (ret)
+		return ret;
+
+	ar->num_peers--;
+
+	return 0;
+}
+
+static int ath11k_wait_for_peer_created(struct ath11k *ar, int vdev_id, const u8 *addr)
+{
+	return ath11k_wait_for_peer_common(ar->ab, vdev_id, addr, true);
+}
+
+int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
+		       struct ieee80211_sta *sta, struct peer_create_params *param)
+{
+	struct ath11k_peer *peer;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	if (ar->num_peers > (ar->max_num_peers - 1)) {
+		ath11k_warn(ar->ab,
+			    "failed to create peer due to insufficient peer entry resource in firmware\n");
+		return -ENOBUFS;
+	}
+
+	ret = ath11k_wmi_send_peer_create_cmd(ar, param);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send peer create vdev_id %d ret %d\n",
+			    param->vdev_id, ret);
+		return ret;
+	}
+
+	ret = ath11k_wait_for_peer_created(ar, param->vdev_id,
+					   param->peer_addr);
+	if (ret)
+		return ret;
+
+	spin_lock_bh(&ar->ab->base_lock);
+
+	peer = ath11k_peer_find(ar->ab, param->vdev_id, param->peer_addr);
+	if (!peer) {
+		spin_unlock_bh(&ar->ab->base_lock);
+		ath11k_warn(ar->ab, "failed to find peer %pM on vdev %i after creation\n",
+			    param->peer_addr, param->vdev_id);
+		ath11k_wmi_send_peer_delete_cmd(ar, param->peer_addr,
+						param->vdev_id);
+		return -ENOENT;
+	}
+
+	peer->sta = sta;
+	arvif->ast_hash = peer->ast_hash;
+
+	ar->num_peers++;
+
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	return 0;
+}


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD14C1A1F5E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2020 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgDHLD3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Apr 2020 07:03:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31962 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727902AbgDHLD3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Apr 2020 07:03:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586343808; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BmFElC3ctK8PO1sISYZXYcCU72aBcOs1eAcrKQiBGd0=; b=g2/v2TOMrio4gO0gTz9DOBxpp0VrJjdHY6DttJjGbyu7HTWS/Mp6zARz1adKT4NVQsOWkBOM
 ImwWHPoqRY8QCBLFKjDlMTJCdyp3XKkJF+b2hKMtKcTWoijBEQBoVHYEEOqobS53s3yZzvOd
 9cJM7EEzBVawF+xpcI4WKl6+SKk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8daf80.7fe1d9853ea0-smtp-out-n04;
 Wed, 08 Apr 2020 11:03:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07FDAC433D2; Wed,  8 Apr 2020 11:03:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from CHECSTP284781-LIN.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E015C433F2;
        Wed,  8 Apr 2020 11:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E015C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: fix duplication peer create on same radio
Date:   Wed,  8 Apr 2020 16:33:15 +0530
Message-Id: <1586343795-21422-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the pdev index information in the peer object to validate
the peer creation. Ignore the peer creation request, if the given
MAC address is already present in the peer list with same radio.
If we allow the peer creation in above scenario, FW assert will happen.
Above scenario occurred in two cases, where Multiple AP VAP created in
the same radio.

1. when testing tool sends association request to two AP with same
   MAC address
2. when a station do roaming from one AP VAP to another AP VAP.

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/peer.c | 35 ++++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/peer.h |  1 +
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index f43deac..2971725 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -17,7 +17,26 @@ struct ath11k_peer *ath11k_peer_find(struct ath11k_base *ab, int vdev_id,
 	list_for_each_entry(peer, &ab->peers, list) {
 		if (peer->vdev_id != vdev_id)
 			continue;
-		if (memcmp(peer->addr, addr, ETH_ALEN))
+		if (!ether_addr_equal(peer->addr, addr))
+			continue;
+
+		return peer;
+	}
+
+	return NULL;
+}
+
+static struct ath11k_peer *ath11k_peer_find_by_pdev_idx(struct ath11k_base *ab,
+							u8 pdev_idx, const u8 *addr)
+{
+	struct ath11k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (peer->pdev_idx != pdev_idx)
+			continue;
+		if (!ether_addr_equal(peer->addr, addr))
 			continue;
 
 		return peer;
@@ -34,7 +53,7 @@ struct ath11k_peer *ath11k_peer_find_by_addr(struct ath11k_base *ab,
 	lockdep_assert_held(&ab->base_lock);
 
 	list_for_each_entry(peer, &ab->peers, list) {
-		if (memcmp(peer->addr, addr, ETH_ALEN))
+		if (!ether_addr_equal(peer->addr, addr))
 			continue;
 
 		return peer;
@@ -200,6 +219,17 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		return -ENOBUFS;
 	}
 
+	spin_lock_bh(&ar->ab->base_lock);
+	peer = ath11k_peer_find_by_pdev_idx(ar->ab, ar->pdev_idx, param->peer_addr);
+	if (peer) {
+		spin_unlock_bh(&ar->ab->base_lock);
+		ath11k_info(ar->ab,
+			    "ignoring the peer %pM creation on same pdev idx %d\n",
+			    param->peer_addr, ar->pdev_idx);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&ar->ab->base_lock);
+
 	ret = ath11k_wmi_send_peer_create_cmd(ar, param);
 	if (ret) {
 		ath11k_warn(ar->ab,
@@ -225,6 +255,7 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		return -ENOENT;
 	}
 
+	peer->pdev_idx = ar->pdev_idx;
 	peer->sta = sta;
 	arvif->ast_hash = peer->ast_hash;
 
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index ccca152..5d125ce 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -13,6 +13,7 @@ struct ath11k_peer {
 	u8 addr[ETH_ALEN];
 	int peer_id;
 	u16 ast_hash;
+	u8 pdev_idx;
 
 	/* protected by ab->data_lock */
 	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
-- 
1.9.1

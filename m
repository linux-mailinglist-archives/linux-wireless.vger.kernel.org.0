Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBDD1DCE05
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgEUNbX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 09:31:23 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:18983 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729333AbgEUNbX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 09:31:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590067882; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=qdrd459IHLhiCJZoF1OToHP6HOHTqLtOX4Nsf9qS/f4=; b=AiHHSregnsYDvW2msti3ALxQa0YZWl2GMI6Z55lfj7AkAOA9JwbzzId9sNeUfWb1OlZfoupk
 wz7VmG8FRd89J/kNI3LLoAUKYS7GM8LVEnrTetRSGnwRvnPjL990VosAYnA6NPmGpQGh/p2E
 4BhR0MvGXETq5ACEXeD8c3wZERM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ec682974c3faf51e21f37fe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 May 2020 13:31:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 52ED4C433C6; Thu, 21 May 2020 13:31:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from CHECSTP344574-LIN.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38AF3C433C8;
        Thu, 21 May 2020 13:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38AF3C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ritesh Singh <ritesi@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH 2/3] ath11k: peer delete synchronization with firmware
Date:   Thu, 21 May 2020 19:00:28 +0530
Message-Id: <1590067829-26109-3-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590067829-26109-1-git-send-email-mkenna@codeaurora.org>
References: <1590067829-26109-1-git-send-email-mkenna@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ritesh Singh <ritesi@codeaurora.org>

Peer creation in firmware fails, if last peer deletion
is still in progress.
Hence, add wait for the event after deleting every peer
from host driver to synchronize with firmware.

Tested-on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 17 ++++++++++++-
 drivers/net/wireless/ath/ath11k/peer.c | 44 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/peer.h |  2 ++
 drivers/net/wireless/ath/ath11k/wmi.c  | 17 ++++++++++---
 6 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index cccd411..c783e13 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -653,6 +653,7 @@ static void ath11k_core_restart(struct work_struct *work)
 		complete(&ar->scan.started);
 		complete(&ar->scan.completed);
 		complete(&ar->peer_assoc_done);
+		complete(&ar->peer_delete_done);
 		complete(&ar->install_key_done);
 		complete(&ar->vdev_setup_done);
 		complete(&ar->vdev_delete_done);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index f3b6dd9..283846e 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -488,6 +488,7 @@ struct ath11k {
 	u8 lmac_id;
 
 	struct completion peer_assoc_done;
+	struct completion peer_delete_done;
 
 	int install_key_status;
 	struct completion install_key_done;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 12f501e..a936bb6 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4368,8 +4368,22 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 err_peer_del:
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
+		reinit_completion(&ar->peer_delete_done);
+
+		ret = ath11k_wmi_send_peer_delete_cmd(ar, vif->addr,
+						      arvif->vdev_id);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
+				    arvif->vdev_id, vif->addr);
+			return ret;
+		}
+
+		ret = ath11k_wait_for_peer_delete_done(ar, arvif->vdev_id,
+						       vif->addr);
+		if (ret)
+			return ret;
+
 		ar->num_peers--;
-		ath11k_wmi_send_peer_delete_cmd(ar, vif->addr, arvif->vdev_id);
 	}
 
 err_vdev_del:
@@ -6045,6 +6059,7 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		init_completion(&ar->vdev_setup_done);
 		init_completion(&ar->vdev_delete_done);
 		init_completion(&ar->peer_assoc_done);
+		init_completion(&ar->peer_delete_done);
 		init_completion(&ar->install_key_done);
 		init_completion(&ar->bss_survey_done);
 		init_completion(&ar->scan.started);
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 2971725..da11c6e 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -177,12 +177,36 @@ static int ath11k_wait_for_peer_deleted(struct ath11k *ar, int vdev_id, const u8
 	return ath11k_wait_for_peer_common(ar->ab, vdev_id, addr, false);
 }
 
+int ath11k_wait_for_peer_delete_done(struct ath11k *ar, u32 vdev_id,
+				     const u8 *addr)
+{
+	int ret;
+	unsigned long time_left;
+
+	ret = ath11k_wait_for_peer_deleted(ar, vdev_id, addr);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed wait for peer deleted");
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->peer_delete_done,
+						3 * HZ);
+	if (time_left == 0) {
+		ath11k_warn(ar->ab, "Timeout in receiving peer delete response\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr)
 {
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
+	reinit_completion(&ar->peer_delete_done);
+
 	ret = ath11k_wmi_send_peer_delete_cmd(ar, addr, vdev_id);
 	if (ret) {
 		ath11k_warn(ar->ab,
@@ -191,7 +215,7 @@ int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr)
 		return ret;
 	}
 
-	ret = ath11k_wait_for_peer_deleted(ar, vdev_id, addr);
+	ret = ath11k_wait_for_peer_delete_done(ar, vdev_id, addr);
 	if (ret)
 		return ret;
 
@@ -250,8 +274,22 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		spin_unlock_bh(&ar->ab->base_lock);
 		ath11k_warn(ar->ab, "failed to find peer %pM on vdev %i after creation\n",
 			    param->peer_addr, param->vdev_id);
-		ath11k_wmi_send_peer_delete_cmd(ar, param->peer_addr,
-						param->vdev_id);
+
+		reinit_completion(&ar->peer_delete_done);
+
+		ret = ath11k_wmi_send_peer_delete_cmd(ar, param->peer_addr,
+						      param->vdev_id);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
+				    param->vdev_id, param->peer_addr);
+			return ret;
+		}
+
+		ret = ath11k_wait_for_peer_delete_done(ar, param->vdev_id,
+						       param->peer_addr);
+		if (ret)
+			return ret;
+
 		return -ENOENT;
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 5d125ce..bba2e00 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -41,5 +41,7 @@ struct ath11k_peer *ath11k_peer_find_by_addr(struct ath11k_base *ab,
 int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr);
 int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		       struct ieee80211_sta *sta, struct peer_create_params *param);
+int ath11k_wait_for_peer_delete_done(struct ath11k *ar, u32 vdev_id,
+				     const u8 *addr);
 
 #endif /* _PEER_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5eae527..7cc0fca 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5081,15 +5081,26 @@ static int ath11k_ready_event(struct ath11k_base *ab, struct sk_buff *skb)
 static void ath11k_peer_delete_resp_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_peer_delete_resp_event peer_del_resp;
+	struct ath11k *ar;
 
 	if (ath11k_pull_peer_del_resp_ev(ab, skb, &peer_del_resp) != 0) {
 		ath11k_warn(ab, "failed to extract peer delete resp");
 		return;
 	}
 
-	/* TODO: Do we need to validate whether ath11k_peer_find() return NULL
-	 *	 Why this is needed when there is HTT event for peer delete
-	 */
+	rcu_read_lock();
+	ar = ath11k_mac_get_ar_by_vdev_id(ab, peer_del_resp.vdev_id);
+	if (!ar) {
+		ath11k_warn(ab, "invalid vdev id in peer delete resp ev %d",
+			    peer_del_resp.vdev_id);
+		rcu_read_unlock();
+		return;
+	}
+
+	complete(&ar->peer_delete_done);
+	rcu_read_unlock();
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "peer delete resp for vdev id %d addr %pM\n",
+		   peer_del_resp.vdev_id, peer_del_resp.peer_macaddr.addr);
 }
 
 static void ath11k_vdev_delete_resp_event(struct ath11k_base *ab,
-- 
1.9.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8658B2B0077
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 08:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgKLHn2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 02:43:28 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:63314 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKLHn2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 02:43:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605167007; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=7v7wXNLh42AEbGdiGTTh0hKbOG4virabwxJZ3vK4t6E=; b=P/W6maOZRRfjmo0o7Ib+9FijLccYIi3Ot2EP/kiI/wvErj8o1JU0RpH04iIj9Th+c+4EuIlx
 sdtz8Ye85N9UW2Vcw6AJhb5v/Jgbgp25yfdzgjrTcAIw7n0vCSBoXdJwk5TAu5NrnbzpVv6I
 PjF0lBNAF/u/c5POgPX/q/CC/Gs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5face7963825e013b5e4b931 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Nov 2020 07:43:18
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 53ABCC433CB; Thu, 12 Nov 2020 07:43:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0DE2BC433FE;
        Thu, 12 Nov 2020 07:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DE2BC433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Ritesh Singh <ritesi@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH 2/3] ath11k: peer delete synchronization with firmware
Date:   Thu, 12 Nov 2020 13:12:59 +0530
Message-Id: <1605166980-29115-3-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605166980-29115-1-git-send-email-mkenna@codeaurora.org>
References: <1605166980-29115-1-git-send-email-mkenna@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ritesh Singh <ritesi@codeaurora.org>

Peer creation in firmware fails, if last peer deletion
is still in progress.
Hence, add wait for the event after deleting every peer
from host driver to synchronize with firmware.

Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---

    V2: Rebased on latest ath.git TOT(Addressed Kalle's comment).

 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 17 ++++++++++++-
 drivers/net/wireless/ath/ath11k/peer.c | 44 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/peer.h |  2 ++
 drivers/net/wireless/ath/ath11k/wmi.c  | 17 ++++++++++---
 6 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index f792825..da20ed7 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -808,6 +808,7 @@ static void ath11k_core_restart(struct work_struct *work)
 		complete(&ar->scan.started);
 		complete(&ar->scan.completed);
 		complete(&ar->peer_assoc_done);
+		complete(&ar->peer_delete_done);
 		complete(&ar->install_key_done);
 		complete(&ar->vdev_setup_done);
 		complete(&ar->vdev_delete_done);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 714dcb4..c7ce7c2 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -506,6 +506,7 @@ struct ath11k {
 	u8 lmac_id;
 
 	struct completion peer_assoc_done;
+	struct completion peer_delete_done;
 
 	int install_key_status;
 	struct completion install_key_done;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f0ab88c..10d83a9 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4628,8 +4628,22 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 
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
@@ -6474,6 +6488,7 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		init_completion(&ar->vdev_setup_done);
 		init_completion(&ar->vdev_delete_done);
 		init_completion(&ar->peer_assoc_done);
+		init_completion(&ar->peer_delete_done);
 		init_completion(&ar->install_key_done);
 		init_completion(&ar->bss_survey_done);
 		init_completion(&ar->scan.started);
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 61ad930..1866d82 100644
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
 
@@ -247,8 +271,22 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
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
@@ -41,5 +41,7 @@ void ath11k_peer_cleanup(struct ath11k *ar, u32 vdev_id);
 int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr);
 int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		       struct ieee80211_sta *sta, struct peer_create_params *param);
+int ath11k_wait_for_peer_delete_done(struct ath11k *ar, u32 vdev_id,
+				     const u8 *addr);
 
 #endif /* _PEER_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d1175a1..e374270 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5730,15 +5730,26 @@ static int ath11k_ready_event(struct ath11k_base *ab, struct sk_buff *skb)
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
2.7.4


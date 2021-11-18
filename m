Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991FE455856
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 10:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245371AbhKRJ47 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 04:56:59 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:6203 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245330AbhKRJ4O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 04:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637229194; x=1668765194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aIrfynLLaOEKnwbxdjszEQAR5XKTa3ipQ1Jl64A6oLY=;
  b=fS0rLiLENvxRl9oQPkGcDpUCKxJGeP3K+zNIvk/1r9RuJ1sADZpy5Hu9
   8Kl2Em0sOyIqgXrifvgg1M7LqankNpiaAwNwgRUWMXtVFZOywv9W40Fyq
   JyF0amyYz/vfqzrsyxT/tIathr6uaY7FFlLy0xnOA7vABpgNcmzfOZ38T
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Nov 2021 01:53:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 01:53:09 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 01:53:09 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 01:53:07 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] ath11k: add wait operation for tx management packets for flush from mac80211
Date:   Thu, 18 Nov 2021 04:52:54 -0500
Message-ID: <20211118095254.7916-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In ath11k, tx of management packet is doing in a work queue. Sometimes
the workqueue does not finish tx immediately, then it lead after the next
step of vdev delete finished, it start to send the management packet to
firmware and lead firmware crash.

ieee80211_set_disassoc have logic of ieee80211_flush_queues after it
send_deauth_disassoc to ath11k, its purpose is make sure the deauth
was actually sent, so it need to change ath11k to match the purpose
of mac80211.

To address these issue wait for tx mgmt and tx data packets.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2: rebased to latest ath.git master ath-202111170737

 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 40 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/wmi.c  | 12 +++++++-
 4 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a40bbca3e9af..a7817c3bcaae 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1078,6 +1078,7 @@ static void ath11k_core_restart(struct work_struct *work)
 		idr_for_each(&ar->txmgmt_idr,
 			     ath11k_mac_tx_mgmt_pending_free, ar);
 		idr_destroy(&ar->txmgmt_idr);
+		wake_up(&ar->txmgmt_empty_waitq);
 	}
 
 	wake_up(&ab->wmi_ab.tx_credits_wq);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index bbfc10fd5c6d..6c6337bbe378 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -547,6 +547,7 @@ struct ath11k {
 	/* protects txmgmt_idr data */
 	spinlock_t txmgmt_idr_lock;
 	atomic_t num_pending_mgmt_tx;
+	wait_queue_head_t txmgmt_empty_waitq;
 
 	/* cycle count is reported twice for each visited channel during scan.
 	 * access protected by data_lock
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 292b2b7eab11..01308c70366f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5128,6 +5128,14 @@ static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
 	return 0;
 }
 
+static void ath11k_mgmt_over_wmi_tx_drop(struct ath11k *ar, struct sk_buff *skb)
+{
+	ieee80211_free_txskb(ar->hw, skb);
+
+	if (atomic_dec_and_test(&ar->num_pending_mgmt_tx))
+		wake_up(&ar->txmgmt_empty_waitq);
+}
+
 int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx)
 {
 	struct sk_buff *msdu = skb;
@@ -5144,7 +5152,7 @@ int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx)
 	info = IEEE80211_SKB_CB(msdu);
 	memset(&info->status, 0, sizeof(info->status));
 
-	ieee80211_free_txskb(ar->hw, msdu);
+	ath11k_mgmt_over_wmi_tx_drop(ar, msdu);
 
 	return 0;
 }
@@ -5182,6 +5190,10 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
 			   ATH11K_TX_MGMT_NUM_PENDING_MAX, GFP_ATOMIC);
 	spin_unlock_bh(&ar->txmgmt_idr_lock);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "mac tx mgmt frame, buf id %d\n", buf_id);
+
 	if (buf_id < 0)
 		return -ENOSPC;
 
@@ -5228,7 +5240,7 @@ static void ath11k_mgmt_over_wmi_tx_purge(struct ath11k *ar)
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&ar->wmi_mgmt_tx_queue)) != NULL)
-		ieee80211_free_txskb(ar->hw, skb);
+		ath11k_mgmt_over_wmi_tx_drop(ar, skb);
 }
 
 static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
@@ -5243,7 +5255,7 @@ static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 		skb_cb = ATH11K_SKB_CB(skb);
 		if (!skb_cb->vif) {
 			ath11k_warn(ar->ab, "no vif found for mgmt frame\n");
-			ieee80211_free_txskb(ar->hw, skb);
+			ath11k_mgmt_over_wmi_tx_drop(ar, skb);
 			continue;
 		}
 
@@ -5258,14 +5270,18 @@ static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 
 				ath11k_warn(ar->ab, "failed to tx mgmt frame, vdev_id %d :%d\n",
 					    arvif->vdev_id, ret);
-				ieee80211_free_txskb(ar->hw, skb);
+				ath11k_mgmt_over_wmi_tx_drop(ar, skb);
+			} else {
+				ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+					   "mac tx mgmt frame, vdev_id %d\n",
+					   arvif->vdev_id);
 			}
 		} else {
 			ath11k_warn(ar->ab,
 				    "dropping mgmt frame for vdev %d, is_started %d\n",
 				    arvif->vdev_id,
 				    arvif->is_started);
-			ieee80211_free_txskb(ar->hw, skb);
+			ath11k_mgmt_over_wmi_tx_drop(ar, skb);
 		}
 	}
 }
@@ -5297,6 +5313,7 @@ static int ath11k_mac_mgmt_tx(struct ath11k *ar, struct sk_buff *skb,
 
 	skb_queue_tail(q, skb);
 	ieee80211_queue_work(ar->hw, &ar->wmi_mgmt_tx_work);
+	atomic_inc(&ar->num_pending_mgmt_tx);
 
 	return 0;
 }
@@ -6784,6 +6801,17 @@ static void ath11k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
 				       ATH11K_FLUSH_TIMEOUT);
 	if (time_left == 0)
 		ath11k_warn(ar->ab, "failed to flush transmit queue %ld\n", time_left);
+
+	time_left = wait_event_timeout(ar->txmgmt_empty_waitq,
+				       (atomic_read(&ar->num_pending_mgmt_tx) == 0),
+				       ATH11K_FLUSH_TIMEOUT);
+	if (time_left == 0)
+		ath11k_warn(ar->ab, "failed to flush mgmt transmit queue %ld\n",
+			    time_left);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "mac mgmt tx flush mgmt pending %d\n",
+		   atomic_read(&ar->num_pending_mgmt_tx));
 }
 
 static int
@@ -8022,6 +8050,8 @@ int ath11k_mac_register(struct ath11k_base *ab)
 		ret = __ath11k_mac_register(ar);
 		if (ret)
 			goto err_cleanup;
+
+		init_waitqueue_head(&ar->txmgmt_empty_waitq);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 614b2f6bcc8e..2c1f3d783083 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4867,6 +4867,7 @@ static int wmi_process_mgmt_tx_comp(struct ath11k *ar, u32 desc_id,
 	struct sk_buff *msdu;
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
+	int num_mgmt;
 
 	spin_lock_bh(&ar->txmgmt_idr_lock);
 	msdu = idr_find(&ar->txmgmt_idr, desc_id);
@@ -4890,10 +4891,19 @@ static int wmi_process_mgmt_tx_comp(struct ath11k *ar, u32 desc_id,
 
 	ieee80211_tx_status_irqsafe(ar->hw, msdu);
 
+	num_mgmt = atomic_dec_if_positive(&ar->num_pending_mgmt_tx);
+
 	/* WARN when we received this event without doing any mgmt tx */
-	if (atomic_dec_if_positive(&ar->num_pending_mgmt_tx) < 0)
+	if (num_mgmt < 0)
 		WARN_ON_ONCE(1);
 
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi mgmt tx comp pending %d desc id %d\n",
+		   num_mgmt, desc_id);
+
+	if (!num_mgmt)
+		wake_up(&ar->txmgmt_empty_waitq);
+
 	return 0;
 }
 

base-commit: 63ec871bc50a306aac550e2d85f697ca2d5f5deb
-- 
2.31.1


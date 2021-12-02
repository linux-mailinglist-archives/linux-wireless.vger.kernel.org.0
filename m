Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84E6465E4D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 07:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbhLBGku (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 01:40:50 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:62308 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344659AbhLBGkt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 01:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638427047; x=1669963047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9XQDJQzAkgsjlCbOcVP4ei8bFcm0EeInom/RLRLxZwo=;
  b=Kglbn9kYxUowTUnhG0/YjWS29RxPYl5j+nH29WAaBIJDgoL8lgyBzM8a
   IUJKlcKvG8ylx2UVXrFFL6yowJTszb6g+3mfTxcK5V1pfl35BWuvENlCz
   8/s+FFXHRu+QQEepzzn8kD6yuxFEF10NiMcTsZvyitDxEI3iMusm0XKDz
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Dec 2021 22:37:26 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 22:37:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 22:37:22 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 22:37:20 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v4] ath11k: add wait operation for tx management packets for flush from mac80211
Date:   Thu, 2 Dec 2021 01:37:05 -0500
Message-ID: <20211202063705.14321-1-quic_wgong@quicinc.com>
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

ieee80211_set_disassoc() have logic of ieee80211_flush_queues() after
it send_deauth_disassoc() to ath11k, its purpose is make sure the
deauth was actually sent, so it need to change ath11k to match the
purpose of mac80211.

To address these issue wait for tx mgmt as well as tx data packets.

dmesg log of connect/disconnect to AP:
[  307.522226] wls1: authenticate with 62:66:e4:e9:6a:a9
[  307.586565] wls1: send auth to 62:66:e4:e9:6a:a9 (try 1/3)
[  307.586581] ath11k_pci 0000:05:00.0: mac tx mgmt frame, buf id 0
[  307.586922] ath11k_pci 0000:05:00.0: mac tx mgmt frame, vdev_id 0
[  307.590179] ath11k_pci 0000:05:00.0: wmi mgmt tx comp pending 0 desc id 0
[  307.590181] ath11k_pci 0000:05:00.0: mgmt tx compl ev pdev_id 2, desc_id 0, status 0
[  307.598699] wls1: authenticated
[  307.599483] wls1: associate with 62:66:e4:e9:6a:a9 (try 1/3)
[  307.599506] ath11k_pci 0000:05:00.0: mac tx mgmt frame, buf id 0
[  307.599519] ath11k_pci 0000:05:00.0: mac tx mgmt frame, vdev_id 0
[  307.603059] ath11k_pci 0000:05:00.0: wmi mgmt tx comp pending 0 desc id 0
[  307.603063] ath11k_pci 0000:05:00.0: mgmt tx compl ev pdev_id 2, desc_id 0, status 0
[  307.637105] wls1: associated
[  317.365239] wls1: deauthenticating from 62:66:e4:e9:6a:a9 by local choice (Reason: 3=DEAUTH_LEAVING)
[  317.368104] ath11k_pci 0000:05:00.0: mac tx mgmt frame, buf id 0
[  317.372622] ath11k_pci 0000:05:00.0: mac tx mgmt frame, vdev_id 0
[  317.378320] ath11k_pci 0000:05:00.0: wmi mgmt tx comp pending 0 desc id 0
[  317.378330] ath11k_pci 0000:05:00.0: mgmt tx compl ev pdev_id 2, desc_id 0, status 0
[  317.378359] ath11k_pci 0000:05:00.0: mac mgmt tx flush mgmt pending 0
[  317.421066] ath11k_pci 0000:05:00.0: mac mgmt tx flush mgmt pending 0
[  317.421427] ath11k_pci 0000:05:00.0: mac remove interface (vdev 0)

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v4: rebased to ath.git master ath-202111291547

v3:
   1. rebased to latest ath.git master ath-202111221436
   2. fix the inc twice of num_pending_mgmt_tx issue
   3. change commit log

v2: rebased to latest ath.git master ath-202111170737

 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 51 +++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/wmi.c  | 12 +++++-
 4 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index dd1a1bb078c3..ce53cd4504b7 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1083,6 +1083,7 @@ static void ath11k_core_restart(struct work_struct *work)
 		idr_for_each(&ar->txmgmt_idr,
 			     ath11k_mac_tx_mgmt_pending_free, ar);
 		idr_destroy(&ar->txmgmt_idr);
+		wake_up(&ar->txmgmt_empty_waitq);
 	}
 
 	wake_up(&ab->wmi_ab.tx_credits_wq);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0103cfd0508d..86afb0da9677 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -549,6 +549,7 @@ struct ath11k {
 	/* protects txmgmt_idr data */
 	spinlock_t txmgmt_idr_lock;
 	atomic_t num_pending_mgmt_tx;
+	wait_queue_head_t txmgmt_empty_waitq;
 
 	/* cycle count is reported twice for each visited channel during scan.
 	 * access protected by data_lock
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 0050e2c84888..ecdc220eab17 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5225,6 +5225,21 @@ static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
 	return 0;
 }
 
+static void ath11k_mgmt_over_wmi_tx_drop(struct ath11k *ar, struct sk_buff *skb)
+{
+	int num_mgmt;
+
+	ieee80211_free_txskb(ar->hw, skb);
+
+	num_mgmt = atomic_dec_if_positive(&ar->num_pending_mgmt_tx);
+
+	if (num_mgmt < 0)
+		WARN_ON_ONCE(1);
+
+	if (!num_mgmt)
+		wake_up(&ar->txmgmt_empty_waitq);
+}
+
 static void ath11k_mac_tx_mgmt_free(struct ath11k *ar, int buf_id)
 {
 	struct sk_buff *msdu;
@@ -5243,7 +5258,7 @@ static void ath11k_mac_tx_mgmt_free(struct ath11k *ar, int buf_id)
 	info = IEEE80211_SKB_CB(msdu);
 	memset(&info->status, 0, sizeof(info->status));
 
-	ieee80211_free_txskb(ar->hw, msdu);
+	ath11k_mgmt_over_wmi_tx_drop(ar, msdu);
 }
 
 int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx)
@@ -5283,6 +5298,10 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
 			   ATH11K_TX_MGMT_NUM_PENDING_MAX, GFP_ATOMIC);
 	spin_unlock_bh(&ar->txmgmt_idr_lock);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "mac tx mgmt frame, buf id %d\n", buf_id);
+
 	if (buf_id < 0)
 		return -ENOSPC;
 
@@ -5329,7 +5348,7 @@ static void ath11k_mgmt_over_wmi_tx_purge(struct ath11k *ar)
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&ar->wmi_mgmt_tx_queue)) != NULL)
-		ieee80211_free_txskb(ar->hw, skb);
+		ath11k_mgmt_over_wmi_tx_drop(ar, skb);
 }
 
 static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
@@ -5344,29 +5363,29 @@ static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 		skb_cb = ATH11K_SKB_CB(skb);
 		if (!skb_cb->vif) {
 			ath11k_warn(ar->ab, "no vif found for mgmt frame\n");
-			ieee80211_free_txskb(ar->hw, skb);
+			ath11k_mgmt_over_wmi_tx_drop(ar, skb);
 			continue;
 		}
 
 		arvif = ath11k_vif_to_arvif(skb_cb->vif);
 		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id) &&
 		    arvif->is_started) {
-			atomic_inc(&ar->num_pending_mgmt_tx);
 			ret = ath11k_mac_mgmt_tx_wmi(ar, arvif, skb);
 			if (ret) {
-				if (atomic_dec_if_positive(&ar->num_pending_mgmt_tx) < 0)
-					WARN_ON_ONCE(1);
-
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
@@ -5397,6 +5416,7 @@ static int ath11k_mac_mgmt_tx(struct ath11k *ar, struct sk_buff *skb,
 	}
 
 	skb_queue_tail(q, skb);
+	atomic_inc(&ar->num_pending_mgmt_tx);
 	ieee80211_queue_work(ar->hw, &ar->wmi_mgmt_tx_work);
 
 	return 0;
@@ -6855,6 +6875,17 @@ static void ath11k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
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
@@ -8093,6 +8124,8 @@ int ath11k_mac_register(struct ath11k_base *ab)
 		ret = __ath11k_mac_register(ar);
 		if (ret)
 			goto err_cleanup;
+
+		init_waitqueue_head(&ar->txmgmt_empty_waitq);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5b8c506633d1..1d7ba6f3dbe1 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4873,6 +4873,7 @@ static int wmi_process_mgmt_tx_comp(struct ath11k *ar, u32 desc_id,
 	struct sk_buff *msdu;
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
+	int num_mgmt;
 
 	spin_lock_bh(&ar->txmgmt_idr_lock);
 	msdu = idr_find(&ar->txmgmt_idr, desc_id);
@@ -4896,10 +4897,19 @@ static int wmi_process_mgmt_tx_comp(struct ath11k *ar, u32 desc_id,
 
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
 
-- 
2.31.1


Return-Path: <linux-wireless+bounces-17345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357DEA09CBF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 21:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D103A65E3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 20:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA6C2080CF;
	Fri, 10 Jan 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O7d9BT8c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAC206F3E
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736542773; cv=none; b=VxhQRkIv6X8dSYJXaSppx/1GvAVm9GP9eYxlLqPAF4u99vwrlVugbJ+WaWteYpotMEIKqjGJjSTHFSre+q2OOfKhWZcK42Drajisr7YQJLgx0qtZ46ofqP+Nc5fZdnoAxF3C5kkV6MNVvljd5bIW0nwu1Yt88Ja/x37FIr0RCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736542773; c=relaxed/simple;
	bh=XthbMeezW1GFOPYTxNdoLcbM2tWLgJVdCfu2GR3gj78=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qO8weIR2aj2rBEIHktqcEoOqn4E2kanURfA6FCJVZJbrySu9JBRMaACiwJ81HbhA8vgNgK4qHueaw/J/Q9V4TEnH+TUWK2VG44d/yQJDPy2viouUUOPMxT1wCMbYldra56mrApxkuouV4yKN2tYoBggBwqn6OMTyDxSA3WtWXBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O7d9BT8c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ACLPgi004084;
	Fri, 10 Jan 2025 20:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P1+oKnZ7ZASfI6A6czyO+/
	jdBxpZHn2FYffpDcnF+70=; b=O7d9BT8c2O2n/KSVKPDDfJAyVjKed0YDFk5Sm5
	YmPARGKWYqVsFTCOk+G3DzFbb0vXqQya0f30OMn7j/D0Eg1NPvGp9cZfsswiqpZx
	CtNUVo02xOxvdNZaX3Oi7CD43g1IBRGHYTjIOgPuVqqqRlLjJYM+dvtInptV4y8X
	1wflGBKgYcTXYpqrIiO8aYZ4hkbcY79hCeGSCsdD9kMmIrCU6AHnziBnML1UFeoX
	rJ5/DO3+IK7uS309VAH8dPEPXdDizf51R/wk8HGRNOLDH83QOhHOS9WwEQlIQqA+
	ZKo3xH9T7L5xFqggWOu4VRAhm08+Fs5EzoFr7GGLYZAd4EEw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4433g0s99a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 20:59:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50AKxQHW017236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 20:59:26 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 10 Jan 2025 12:59:26 -0800
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>
Subject: [PATCH] wifi: ath12k: Add support for link specific datapath stats
Date: Fri, 10 Jan 2025 12:59:12 -0800
Message-ID: <20250110205912.2585850-1-quic_bmahalin@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5BCahwC94pNFyAOpxPeF-uZpg1b_TY8V
X-Proofpoint-ORIG-GUID: 5BCahwC94pNFyAOpxPeF-uZpg1b_TY8V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501100161

Add support to record the number of frames enqueued, hardware
descriptor type, encapsulation/encryption types used, frames
dropped and completed. This is useful for understanding the
datapath performance and tune the peak throughput.

The link specific stats can be viewed through the below debugfs file

cat /sys/kernel/debug/ieee80211/phy0/netdev:wlan1/link_stats
link[0] Tx Unicast Frames Enqueued  = 9
link[0] Tx Broadcast Frames Enqueued = 78689
link[0] Tx Frames Completed = 78698
link[0] Tx Frames Dropped = 0
link[0] Tx Frame descriptor Encap Type =  raw:0 native wifi:78698 ethernet:0
link[0] Tx Frame descriptor Encrypt Type =  0:78698 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0
link[0] Tx Frame descriptor Type = buffer:78698 extension:0
------------------------------------------------------
link[1] Tx Unicast Frames Enqueued  = 0
link[1] Tx Broadcast Frames Enqueued = 78689
link[1] Tx Frames Completed = 78689
link[1] Tx Frames Dropped = 0
link[1] Tx Frame descriptor Encap Type =  raw:0 native wifi:78689 ethernet:0
link[1] Tx Frame descriptor Encrypt Type =  0:78689 1:0 2:0 3:0 4:0 5:0 6:0 7:0 8:0 9:0 10:0 11:0
link[1] Tx Frame descriptor Type = buffer:78689 extension:0
------------------------------------------------------

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
---

Depends-on : 
[PATCH 0/2] wifi: ath12k: Add support for MLO Multicast Handling
Link: https://lore.kernel.org/all/20250109184932.1593157-1-quic_bmahalin@quicinc.com/ 

Note: Verified with ath12k-check and there is an exception on hal_desc.h
      for length in copyright string. Exception will be submitted separately.

 drivers/net/wireless/ath/ath12k/core.h     |   2 +
 drivers/net/wireless/ath/ath12k/debugfs.c  | 120 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/debugfs.h  |   9 +-
 drivers/net/wireless/ath/ath12k/dp.h       |  11 ++
 drivers/net/wireless/ath/ath12k/dp_tx.c    |  51 ++++++++-
 drivers/net/wireless/ath/ath12k/dp_tx.h    |   3 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h |   6 +-
 drivers/net/wireless/ath/ath12k/mac.c      |  10 +-
 8 files changed, 204 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 203255081221..e3db791dfee7 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -298,6 +298,8 @@ struct ath12k_link_vif {
 	u8 link_id;
 	struct ath12k_vif *ahvif;
 	struct ath12k_rekey_data rekey_data;
+	struct ath12k_link_stats link_stats;
+	spinlock_t link_stats_lock; /* Protects updates to link_stats */
 };
 
 struct ath12k_vif {
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index d4b32d1a431c..81a2e14f9d86 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -31,6 +31,124 @@ static const struct file_operations fops_simulate_radar = {
 	.open = simple_open
 };
 
+static int ath12k_open_link_stats(struct inode *inode, struct file *file)
+{
+	struct ath12k_vif *ahvif = inode->i_private;
+	size_t len = 0, buf_len = (PAGE_SIZE * 2);
+	struct ath12k_link_stats linkstat;
+	struct ath12k_link_vif *arvif;
+	unsigned long links_map;
+	struct wiphy *wiphy;
+	int link_id, i;
+	char *buf;
+
+	if (!ahvif)
+		return -EINVAL;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	wiphy = ahvif->ah->hw->wiphy;
+	wiphy_lock(wiphy);
+
+	links_map = ahvif->links_map;
+	for_each_set_bit(link_id, &links_map,
+			 IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = rcu_dereference_protected(ahvif->link[link_id],
+						  lockdep_is_held(&wiphy->mtx));
+
+		spin_lock_bh(&arvif->link_stats_lock);
+		linkstat = arvif->link_stats;
+		spin_unlock_bh(&arvif->link_stats_lock);
+
+		len += scnprintf(buf + len, buf_len - len,
+				 "link[%d] Tx Unicast Frames Enqueued  = %d\n",
+				 link_id, linkstat.tx_enqueued);
+		len += scnprintf(buf + len, buf_len - len,
+				 "link[%d] Tx Broadcast Frames Enqueued = %d\n",
+				 link_id, linkstat.tx_bcast_mcast);
+		len += scnprintf(buf + len, buf_len - len,
+				 "link[%d] Tx Frames Completed = %d\n",
+				 link_id, linkstat.tx_completed);
+		len += scnprintf(buf + len, buf_len - len,
+				 "link[%d] Tx Frames Dropped = %d\n",
+				 link_id, linkstat.tx_dropped);
+
+		len += scnprintf(buf + len, buf_len - len,
+				 "link[%d] Tx Frame descriptor Encap Type = ",
+				 link_id);
+
+		len += scnprintf(buf + len, buf_len - len,
+					 " raw:%d",
+					 linkstat.tx_encap_type[0]);
+
+		len += scnprintf(buf + len, buf_len - len,
+					 " native_wifi:%d",
+					 linkstat.tx_encap_type[1]);
+
+		len += scnprintf(buf + len, buf_len - len,
+					 " ethernet:%d",
+					 linkstat.tx_encap_type[2]);
+
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nlink[%d] Tx Frame descriptor Encrypt Type = ",
+				 link_id);
+
+		for (i = 0; i < HAL_ENCRYPT_TYPE_MAX; i++) {
+			len += scnprintf(buf + len, buf_len - len,
+					 " %d:%d", i,
+					 linkstat.tx_encrypt_type[i]);
+		}
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nlink[%d] Tx Frame descriptor Type = buffer:%d extension:%d\n",
+				 link_id, linkstat.tx_desc_type[0],
+				 linkstat.tx_desc_type[1]);
+
+		len += scnprintf(buf + len, buf_len - len,
+				"------------------------------------------------------\n");
+	}
+
+	wiphy_unlock(wiphy);
+
+	file->private_data = buf;
+
+	return 0;
+}
+
+static int ath12k_release_link_stats(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+static ssize_t ath12k_read_link_stats(struct file *file,
+				      char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	const char *buf = file->private_data;
+	size_t len = strlen(buf);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static const struct file_operations ath12k_fops_link_stats = {
+	.open = ath12k_open_link_stats,
+	.release = ath12k_release_link_stats,
+	.read = ath12k_read_link_stats,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif)
+{
+	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
+
+	debugfs_create_file("link_stats", 0400, vif->debugfs_dir, ahvif,
+			    &ath12k_fops_link_stats);
+}
+
 void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
 	bool dput_needed;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index 8d64ba03aa9a..beff5304b13a 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _ATH12K_DEBUGFS_H_
@@ -12,6 +12,9 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab);
 void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
 void ath12k_debugfs_register(struct ath12k *ar);
 void ath12k_debugfs_unregister(struct ath12k *ar);
+void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif);
+
 #else
 static inline void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
@@ -29,6 +32,10 @@ static inline void ath12k_debugfs_unregister(struct ath12k *ar)
 {
 }
 
+static inline void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
+					     struct ieee80211_vif *vif)
+{
+}
 #endif /* CONFIG_ATH12K_DEBUGFS */
 
 #endif /* _ATH12K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index b2f978f50304..9430a52166c4 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -7,6 +7,7 @@
 #ifndef ATH12K_DP_H
 #define ATH12K_DP_H
 
+#include "hal_desc.h"
 #include "hal_rx.h"
 #include "hw.h"
 
@@ -314,6 +315,16 @@ struct ath12k_reo_q_addr_lut {
 	u32 *vaddr;
 };
 
+struct ath12k_link_stats {
+	u32 tx_enqueued;
+	u32 tx_completed;
+	u32 tx_bcast_mcast;
+	u32 tx_dropped;
+	u32 tx_encap_type[HAL_TCL_ENCAP_TYPE_MAX];
+	u32 tx_encrypt_type[HAL_ENCRYPT_TYPE_MAX];
+	u32 tx_desc_type[HAL_TCL_DESC_TYPE_MAX];
+};
+
 struct ath12k_dp {
 	struct ath12k_base *ab;
 	u8 num_bank_profiles;
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 9d05fe7a870c..f892ce48aa52 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -217,7 +217,8 @@ static int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
 }
 
 int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
-		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn)
+		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
+		 bool is_mcast)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = &ab->dp;
@@ -458,6 +459,17 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		goto fail_unmap_dma;
 	}
 
+	spin_lock_bh(&arvif->link_stats_lock);
+	arvif->link_stats.tx_encap_type[ti.encap_type]++;
+	arvif->link_stats.tx_encrypt_type[ti.encrypt_type]++;
+	arvif->link_stats.tx_desc_type[ti.type]++;
+
+	if (is_mcast)
+		arvif->link_stats.tx_bcast_mcast++;
+	else
+		arvif->link_stats.tx_enqueued++;
+	spin_unlock_bh(&arvif->link_stats_lock);
+
 	ath12k_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
 
 	ath12k_hal_srng_access_end(ab, tcl_ring);
@@ -481,6 +493,11 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 fail_remove_tx_buf:
 	ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);
+
+	spin_lock_bh(&arvif->link_stats_lock);
+	arvif->link_stats.tx_dropped++;
+	spin_unlock_bh(&arvif->link_stats_lock);
+
 	if (tcl_ring_retry)
 		goto tcl_ring_sel;
 
@@ -516,7 +533,10 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 				 struct ath12k_dp_htt_wbm_tx_status *ts)
 {
 	struct ieee80211_tx_info *info;
+	struct ath12k_link_vif *arvif;
 	struct ath12k_skb_cb *skb_cb;
+	struct ieee80211_vif *vif;
+	struct ath12k_vif *ahvif;
 	struct ath12k *ar;
 
 	skb_cb = ATH12K_SKB_CB(msdu);
@@ -532,6 +552,19 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
 
+	vif = skb_cb->vif;
+	if (vif) {
+		ahvif = ath12k_vif_to_ahvif(vif);
+		rcu_read_lock();
+		arvif = rcu_dereference(ahvif->link[skb_cb->link_id]);
+		if (arvif) {
+			spin_lock_bh(&arvif->link_stats_lock);
+			arvif->link_stats.tx_completed++;
+			spin_unlock_bh(&arvif->link_stats_lock);
+		}
+		rcu_read_unlock();
+	}
+
 	memset(&info->status, 0, sizeof(info->status));
 
 	if (ts->acked) {
@@ -586,7 +619,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 		 */
 		break;
 	default:
-		ath12k_warn(ab, "Unknown htt tx status %d\n", wbm_status);
+		ath12k_warn(ab, "Unknown htt wbm tx status %d\n", wbm_status);
 		break;
 	}
 }
@@ -598,7 +631,10 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_hw *ah = ar->ah;
 	struct ieee80211_tx_info *info;
+	struct ath12k_link_vif *arvif;
 	struct ath12k_skb_cb *skb_cb;
+	struct ieee80211_vif *vif;
+	struct ath12k_vif *ahvif;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -624,6 +660,17 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 		goto exit;
 	}
 
+	vif = skb_cb->vif;
+	if (vif) {
+		ahvif = ath12k_vif_to_ahvif(vif);
+		arvif = rcu_dereference(ahvif->link[skb_cb->link_id]);
+		if (arvif) {
+			spin_lock_bh(&arvif->link_stats_lock);
+			arvif->link_stats.tx_completed++;
+			spin_unlock_bh(&arvif->link_stats_lock);
+		}
+	}
+
 	info = IEEE80211_SKB_CB(msdu);
 	memset(&info->status, 0, sizeof(info->status));
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index a5904097dc34..10acdcf1fa8f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -17,7 +17,8 @@ struct ath12k_dp_htt_wbm_tx_status {
 
 int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);
 int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
-		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn);
+		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
+		 bool is_mcast);
 void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
 
 int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask);
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 7b0403d245e5..217dc76847f3 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include "core.h"
 
@@ -1263,6 +1263,7 @@ struct hal_reo_flush_cache {
 
 #define HAL_TCL_DATA_CMD_INFO5_RING_ID			GENMASK(27, 20)
 #define HAL_TCL_DATA_CMD_INFO5_LOOPING_COUNT		GENMASK(31, 28)
+#define HAL_ENCRYPT_TYPE_MAX 12
 
 enum hal_encrypt_type {
 	HAL_ENCRYPT_TYPE_WEP_40,
@@ -1284,11 +1285,13 @@ enum hal_tcl_encap_type {
 	HAL_TCL_ENCAP_TYPE_NATIVE_WIFI,
 	HAL_TCL_ENCAP_TYPE_ETHERNET,
 	HAL_TCL_ENCAP_TYPE_802_3 = 3,
+	HAL_TCL_ENCAP_TYPE_MAX
 };
 
 enum hal_tcl_desc_type {
 	HAL_TCL_DESC_TYPE_BUFFER,
 	HAL_TCL_DESC_TYPE_EXT_DESC,
+	HAL_TCL_DESC_TYPE_MAX,
 };
 
 enum hal_wbm_htt_tx_comp_status {
@@ -1298,6 +1301,7 @@ enum hal_wbm_htt_tx_comp_status {
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ,
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT,
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY,
+	HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH,
 	HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX,
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 562135893926..0a413269ccec 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3899,6 +3899,9 @@ static struct ath12k_link_vif *ath12k_mac_assign_link_vif(struct ath12k_hw *ah,
 	arvif->link_id = link_id;
 	ahvif->links_map |= BIT(link_id);
 
+	/* Protects the datapath stats update on a per link basis */
+	spin_lock_init(&arvif->link_stats_lock);
+
 	INIT_LIST_HEAD(&arvif->list);
 	INIT_DELAYED_WORK(&arvif->connection_loss_work,
 			  ath12k_mac_vif_sta_connection_loss_work);
@@ -7258,7 +7261,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 
 	if (!vif->valid_links || !is_mcast ||
 	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
-		ret = ath12k_dp_tx(ar, arvif, skb, false, 0);
+		ret = ath12k_dp_tx(ar, arvif, skb, false, 0, is_mcast);
 		if (unlikely(ret)) {
 			ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
 			ieee80211_free_txskb(ar->ah->hw, skb);
@@ -7292,7 +7295,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 			skb_cb->link_id = link_id;
 
 			ret = ath12k_dp_tx(tmp_ar, tmp_arvif,
-					   msdu_copied, true, mcbc_gsn);
+					   msdu_copied, true, mcbc_gsn, is_mcast);
 
 			if (unlikely(ret)) {
 				if (ret == -ENOMEM) {
@@ -10373,6 +10376,9 @@ static const struct ieee80211_ops ath12k_ops = {
 	.resume				= ath12k_wow_op_resume,
 	.set_wakeup			= ath12k_wow_op_set_wakeup,
 #endif
+#ifdef CONFIG_ATH12K_DEBUGFS
+	.vif_add_debugfs                = ath12k_debugfs_op_vif_add,
+#endif
 };
 
 static void ath12k_mac_update_ch_list(struct ath12k *ar,
-- 
2.34.1



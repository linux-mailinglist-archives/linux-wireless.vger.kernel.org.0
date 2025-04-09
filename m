Return-Path: <linux-wireless+bounces-21344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B632DA82BBA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 18:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4925189A38C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 15:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C525B267B72;
	Wed,  9 Apr 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O3hpzK5X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509126A085
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213903; cv=none; b=Qz0RT/GgKj0F2bTFPE6snpkdXJBzzgYvDMb8oIB4++fh1zaEc+Q8z+Gl/UwrvTLDoJhTNyFoAAK76zjU/IKLkgBYLAwZw5AenniZ5jA0CkNFs3KF4h0gKOKcu7VHaM/c5RlFgdQbjRaFHtT5f37ANK53Z90ccKne+OfKkXG4x9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213903; c=relaxed/simple;
	bh=zPhFlSqAhmD3IwUobsXCA+JX5Ci38UFRI4Smcw7pD3A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdAAqsgy2859PMyHBGmsVcsbSE5PEuLNhzplw1YrHXkZop+/m5O5lcYGYz1fuMOjHL673Vy4zNQcdWI8umn8gvtjDNkSa4WPJvat2BhX3AhGyOf6EOUlGLNokbE8g54beUTbNSUU/VMAvDnlsUvfHATfsINRe+oXYpVc/tDsjlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O3hpzK5X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398d58K029098;
	Wed, 9 Apr 2025 15:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BXWUtpG5kiFVrB8zkFCGWP
	23C+hSIkTMLKMlaTQH//4=; b=O3hpzK5XAWqoyEA0FN9omjCEXpGjwwoVBV61vD
	sc9q4jv35JbEbsQRBClyfjjpplKh2deRYAiLyPskvIBrXq0+Qfeflz1mzyK8yA+X
	vM5vEEAhV6JJ1B1VHHZCYph7Fh6vMgqeWm4FB1cBKbU3yN2KK0Yu6q5N4kVZh1j9
	XOvJa+tXYW+ZbO9LInVcOiYc+onVDzfc75UVRwV9rTu2yYWQ2aaS2/paziSXWIMZ
	i8C007EP1wIX9iE/glAEue9hfqdTdp/sE3fs+r0oXEoqapr2AxT9QJ2SBHUzcxsb
	M/cgNdw08NTvcZuO8LWmYSYdFMcAjt8GORDAotIeYQ/uGm4g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmbssg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 15:51:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 539FpbfB025074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 15:51:37 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 9 Apr 2025 08:51:37 -0700
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>,
        <quic_tamizhr@quicinc.com>
Subject: [PATCH v5] wifi: ath12k: Add support for link specific datapath stats
Date: Wed, 9 Apr 2025 08:51:25 -0700
Message-ID: <20250409155125.299380-1-quic_bmahalin@quicinc.com>
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
X-Proofpoint-GUID: 0m90cGc7T-Glt28elST67cupiR0AoP3Y
X-Proofpoint-ORIG-GUID: 0m90cGc7T-Glt28elST67cupiR0AoP3Y
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f6978a cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=3H110R4YSZwA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=L9aF0h0yJHtvMh3hrdMA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090101

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

Depends-on: [PATCH v4 0/2] wifi: ath12k: Add support for MLO Multicast Handling
Link: https://patchwork.kernel.org/project/linux-wireless/list/?series=930206

v5:
    Rebased on top of the main branch.

v4:
    Rebased on top of dependent patch.

v3: https://patchwork.kernel.org/project/linux-wireless/patch/20250203080032.3983556-1-quic_bmahalin@quicinc.com/
    Rebased on top of dependent patch.

v2: https://patchwork.kernel.org/project/linux-wireless/patch/20250203025714.3852826-1-quic_bmahalin@quicinc.com/
    Rebased on top of master branch.

v1: https://patchwork.kernel.org/project/linux-wireless/patch/20250110205912.2585850-1-quic_bmahalin@quicinc.com/

 drivers/net/wireless/ath/ath12k/core.h     |   2 +
 drivers/net/wireless/ath/ath12k/debugfs.c  | 118 +++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/debugfs.h  |   7 ++
 drivers/net/wireless/ath/ath12k/dp.h       |  11 ++
 drivers/net/wireless/ath/ath12k/dp_tx.c    |  51 ++++++++-
 drivers/net/wireless/ath/ath12k/dp_tx.h    |   3 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h |   3 +
 drivers/net/wireless/ath/ath12k/mac.c      |  10 +-
 8 files changed, 200 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index e8d2a0c859f6..ef5cf275b834 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -310,6 +310,8 @@ struct ath12k_link_vif {
 	u8 link_id;
 	struct ath12k_vif *ahvif;
 	struct ath12k_rekey_data rekey_data;
+	struct ath12k_link_stats link_stats;
+	spinlock_t link_stats_lock; /* Protects updates to link_stats */
 
 	u8 current_cntdown_counter;
 };
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index e8a2d0eefa43..bab7be9c5a38 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -833,6 +833,124 @@ static const struct file_operations fops_extd_rx_stats = {
 	.open = simple_open,
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
index 4cbcfbb7fa07..74a255a27886 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -14,6 +14,8 @@ void ath12k_debugfs_register(struct ath12k *ar);
 void ath12k_debugfs_unregister(struct ath12k *ar);
 void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
 				     struct ath12k_fw_stats *stats);
+void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif);
 
 static inline bool ath12k_debugfs_is_extd_rx_stats_enabled(struct ath12k *ar)
 {
@@ -137,6 +139,11 @@ static inline int ath12k_debugfs_rx_filter(struct ath12k *ar)
 {
 	return 0;
 }
+
+static inline void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
+					     struct ieee80211_vif *vif)
+{
+}
 #endif /* CONFIG_ATH12K_DEBUGFS */
 
 #endif /* _ATH12K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index e8dbba0c3bb7..6ce5f853dcdb 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -7,6 +7,7 @@
 #ifndef ATH12K_DP_H
 #define ATH12K_DP_H
 
+#include "hal_desc.h"
 #include "hal_rx.h"
 #include "hw.h"
 
@@ -318,6 +319,16 @@ struct ath12k_reo_q_addr_lut {
 	u32 size;
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
index b93669348f35..91da0805706f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -220,7 +220,8 @@ static int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
 }
 
 int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
-		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn)
+		 struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
+		 bool is_mcast)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_dp *dp = &ab->dp;
@@ -466,6 +467,17 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
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
@@ -489,6 +501,11 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 fail_remove_tx_buf:
 	ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);
+
+	spin_lock_bh(&arvif->link_stats_lock);
+	arvif->link_stats.tx_dropped++;
+	spin_unlock_bh(&arvif->link_stats_lock);
+
 	if (tcl_ring_retry)
 		goto tcl_ring_sel;
 
@@ -524,7 +541,10 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 				 struct ath12k_dp_htt_wbm_tx_status *ts)
 {
 	struct ieee80211_tx_info *info;
+	struct ath12k_link_vif *arvif;
 	struct ath12k_skb_cb *skb_cb;
+	struct ieee80211_vif *vif;
+	struct ath12k_vif *ahvif;
 	struct ath12k *ar;
 
 	skb_cb = ATH12K_SKB_CB(msdu);
@@ -540,6 +560,19 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
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
@@ -595,7 +628,7 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 		 */
 		break;
 	default:
-		ath12k_warn(ab, "Unknown htt tx status %d\n", wbm_status);
+		ath12k_warn(ab, "Unknown htt wbm tx status %d\n", wbm_status);
 		break;
 	}
 }
@@ -725,7 +758,10 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_hw *ah = ar->ah;
 	struct ieee80211_tx_info *info;
+	struct ath12k_link_vif *arvif;
 	struct ath12k_skb_cb *skb_cb;
+	struct ieee80211_vif *vif;
+	struct ath12k_vif *ahvif;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -751,6 +787,17 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
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
index 63d279fab322..49eededbfa9d 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -1284,11 +1284,13 @@ enum hal_tcl_encap_type {
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
@@ -1999,6 +2001,7 @@ struct hal_wbm_release_ring_cc_rx {
 #define HAL_WBM_RELEASE_INFO3_CONTINUATION		BIT(2)
 
 #define HAL_WBM_RELEASE_INFO5_LOOPING_COUNT		GENMASK(31, 28)
+#define HAL_ENCRYPT_TYPE_MAX 12
 
 struct hal_wbm_release_ring {
 	struct ath12k_buffer_addr buf_addr_info;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2b6bdc3d2b11..eb0c461559b9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3397,6 +3397,9 @@ static void ath12k_mac_init_arvif(struct ath12k_vif *ahvif,
 	arvif->ahvif = ahvif;
 	arvif->link_id = _link_id;
 
+	/* Protects the datapath stats update on a per link basis */
+	spin_lock_init(&arvif->link_stats_lock);
+
 	INIT_LIST_HEAD(&arvif->list);
 	INIT_DELAYED_WORK(&arvif->connection_loss_work,
 			  ath12k_mac_vif_sta_connection_loss_work);
@@ -7467,7 +7470,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 
 	if (!vif->valid_links || !is_mcast ||
 	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
-		ret = ath12k_dp_tx(ar, arvif, skb, false, 0);
+		ret = ath12k_dp_tx(ar, arvif, skb, false, 0, is_mcast);
 		if (unlikely(ret)) {
 			ath12k_warn(ar->ab, "failed to transmit frame %d\n", ret);
 			ieee80211_free_txskb(ar->ah->hw, skb);
@@ -7529,7 +7532,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 
 skip_peer_find:
 			ret = ath12k_dp_tx(tmp_ar, tmp_arvif,
-					   msdu_copied, true, mcbc_gsn);
+					   msdu_copied, true, mcbc_gsn, is_mcast);
 			if (unlikely(ret)) {
 				if (ret == -ENOMEM) {
 					/* Drops are expected during heavy multicast
@@ -10804,6 +10807,9 @@ static const struct ieee80211_ops ath12k_ops = {
 	.suspend			= ath12k_wow_op_suspend,
 	.resume				= ath12k_wow_op_resume,
 	.set_wakeup			= ath12k_wow_op_set_wakeup,
+#endif
+#ifdef CONFIG_ATH12K_DEBUGFS
+	.vif_add_debugfs                = ath12k_debugfs_op_vif_add,
 #endif
 	CFG80211_TESTMODE_CMD(ath12k_tm_cmd)
 #ifdef CONFIG_ATH12K_DEBUGFS
-- 
2.34.1



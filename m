Return-Path: <linux-wireless+bounces-28230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB141C07ADD
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98EB44F3E08
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673F92A1BB;
	Fri, 24 Oct 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GpwJuRBs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8425EF97
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329779; cv=none; b=hMeXLzkguerzw497D3404C1rEA60eK6ClB1hvT7LGGL8I+ZgAb08btp6/ut9VJ6P0gBDsRBAozAOOdXcXFjW53/1LznP8iUXK3GNEhiGLGP3EJW0JSu5mFvHAb5sItAstNn7hKPJqA1rM5wxufJUrcSvKL1ln1aVODBoCc8Jm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329779; c=relaxed/simple;
	bh=Ok2lyzTFC/as1bj/wa278UQj3NlfNBLiMLPvMlxVLjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+15SfHTmEsc55+ZuYla4zr1h23PYP6iGNIz9hx6NEY5vWmfMbi9+sfiw6HwgUExDarlAqyCvXXlpoXpkxuPFhTx0LOmHVtad/O5EM0AytBzZhSfCgnvtTXxufvrOubCbqBRGt06gJrN36wwZxYTFuARXgbor8sZDaCcCc4snvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GpwJuRBs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9IYs023498;
	Fri, 24 Oct 2025 18:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FCVP+381ppAxUsrGWU2GOmS6B0TEjt091c4ksQeDKag=; b=GpwJuRBsKxerJCVu
	1t7IKPwy3l46t8G2JGoLxtts1xTWMxudbmKrBdxRGml5BEiGfh/h175YZ3XDQURv
	dp4aI3CPjQ6daV8Fj3yiFXGW6ejqkirtgLzBNCtJ/YLiHEEQcjxHhpw4TLF61Rmw
	ivvcJ8wiHKOz+S5nWNB5kVLoIOxfO9p1+7UaHAB/4qg9mjPx5egWqwAMRlwDahhn
	KfhgQDNJy8SxzskFULY9zP+1xZeou3STbzmISjAvdwelJygHgirmSch3rUshpxGU
	XdM+IXnQhDH4IuW3IRe81KLVZ4mzLvjredlD5iZYBMtsJo3FUBpgKfjURC9zQ4ss
	zIC4mQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8q3rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59OIGA7j021972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:10 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 24 Oct 2025 11:16:09 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 3/9] wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base
Date: Fri, 24 Oct 2025 23:45:42 +0530
Message-ID: <20251024181548.3255166-4-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
References: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nNBb2I6BeQcYrUzQ6f_6kf75_-GaXbGW
X-Proofpoint-GUID: nNBb2I6BeQcYrUzQ6f_6kf75_-GaXbGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfXyx3z9FVOz/3M
 g4M2ZXwIFfLfi9ykBr4mTH1XVAP3nD2tDKSv16pu89ysyp+f+qGjphPF/e2Zwn4Wx1LztHei3Bu
 Gf+qauz9aPBZ8PtwwqOxw+xwR6z69b2V6J6zTEKSVUkbtd0WvnaBK6Oq5Gmr80SKaOJhZjFnrzb
 topEfNAzdDmdo62L9RYGoYlwbGeahFplYjofKLicD+jIdBdmk7IaKCf0eWoQxl640cNc49SugoG
 q6p3/W+ka6nxWShxRFz2fCEgwOBYHzRiPotFMohIfCIre1Wfcnsal4CuGwfPMqGTyAffUtlZn+F
 tFMh/oY5HHmK8K5XgA48o6Z7yd6BoN4NmppH+V0re9RPCtKD6qQYM74C2UP4+reQrOV5/ATCM1G
 F7CGvRQGaWYeMNIbgZfQipXLl1eQgg==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fbc26b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=LntumCSTeYDDm6ARqX8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

Currently ath12k_base maintains a linked list of ath12k_dp_link_peer as "peers".
This linked list is used for all kinds of peer search operations.

In the control path, if there is a requirement to search for ath12k_link_sta
using mac address, then below sequence is to be followed:
  1. Find ath12k_dp_link_peer in the linked list using mac address
  2. Fetch ieee80211_sta from ath12k_dp_link_peer
  3. Fetch ath12k_sta from ieee80211_sta
  4. Finally fetch ath12k_link_sta from ath12k_sta using link_id

In the above sequence, there are too many indirections involved.

In order to simplify this, add hash table for ath12k_link_sta in ath12k_base.
This hash table is lock protected by existing spinlock "base_lock" in
ath12k_base as this table can be concurrently accessed in different contexts.

Use this table for ath12k_link_sta search operations using mac address in the
control path.
Ex: For WMI interface and mac80211_ops interface in the control path, sta mac
address is received and this hash table can be used to search for
ath12k_link_sta directly instead of following the longer route mentioned above.

Helper APIs added:
 - ath12k_link_sta_rhash_add() - To add arsta entry to hash table
 - ath12k_link_sta_rhash_delete() - To remove arsta entry from hash table
 - ath12k_link_sta_find_by_addr() - To find arsta from hash table using
				    mac address

Make changes in API ath12k_peer_sta_kickout_event() to find arsta using above
mechanism.

ath11k driver has been taken as reference for implementation of hash table.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  10 +++
 drivers/net/wireless/ath/ath12k/core.h |   7 ++
 drivers/net/wireless/ath/ath12k/mac.c  |  72 +++++++++++++++
 drivers/net/wireless/ath/ath12k/peer.c | 116 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/peer.h |   6 ++
 drivers/net/wireless/ath/ath12k/wmi.c  |  14 +--
 6 files changed, 218 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 1adbdd571a0f..c5aebe66d190 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -23,6 +23,7 @@
 #include "pci.h"
 #include "wow.h"
 #include "dp_cmn.h"
+#include "peer.h"
 
 unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
@@ -702,6 +703,8 @@ void ath12k_core_to_group_ref_put(struct ath12k_base *ab)
 
 static void ath12k_core_stop(struct ath12k_base *ab)
 {
+	ath12k_link_sta_rhash_tbl_destroy(ab);
+
 	ath12k_core_to_group_ref_put(ab);
 
 	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
@@ -964,6 +967,12 @@ static int ath12k_core_start(struct ath12k_base *ab)
 	/* Indicate the core start in the appropriate group */
 	ath12k_core_to_group_ref_get(ab);
 
+	ret = ath12k_link_sta_rhash_tbl_init(ab);
+	if (ret) {
+		ath12k_warn(ab, "failed to init peer addr rhash table %d\n", ret);
+		goto err_reo_cleanup;
+	}
+
 	return 0;
 
 err_reo_cleanup:
@@ -1351,6 +1360,7 @@ static int ath12k_core_reconfigure_on_crash(struct ath12k_base *ab)
 	int ret, total_vdev;
 
 	mutex_lock(&ab->core_lock);
+	ath12k_link_sta_rhash_tbl_destroy(ab);
 	ath12k_dp_pdev_free(ab);
 	ath12k_ce_cleanup_pipes(ab);
 	ath12k_wmi_detach(ab);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 2bbe543bcf13..8b5a0a99cd31 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -18,6 +18,7 @@
 #include <linux/panic_notifier.h>
 #include <linux/average.h>
 #include <linux/of.h>
+#include <linux/rhashtable.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -560,6 +561,9 @@ struct ath12k_link_sta {
 	u8 link_idx;
 	u32 tx_retry_failed;
 	u32 tx_retry_count;
+
+	/* peer addr based rhashtable list pointer */
+	struct rhash_head rhash_addr;
 };
 
 struct ath12k_reoq_buf {
@@ -1220,6 +1224,9 @@ struct ath12k_base {
 	 */
 	const struct ieee80211_ops *ath12k_ops;
 
+	struct rhashtable *rhead_sta_addr;
+	struct rhashtable_params rhash_sta_addr_param;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 64609fffa7ce..5e6e176bf6a9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1145,6 +1145,35 @@ static int ath12k_mac_set_kickout(struct ath12k_link_vif *arvif)
 	return 0;
 }
 
+static void ath12k_mac_link_sta_rhash_cleanup(void *data, struct ieee80211_sta *sta)
+{
+	u8 link_id;
+	unsigned long links_map;
+	struct ath12k_sta *ahsta;
+	struct ath12k *ar = data;
+	struct ath12k_link_sta *arsta;
+	struct ath12k_link_vif *arvif;
+	struct ath12k_base *ab = ar->ab;
+
+	ahsta = ath12k_sta_to_ahsta(sta);
+	links_map = ahsta->links_map;
+
+	rcu_read_lock();
+	for_each_set_bit(link_id, &links_map, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arsta = rcu_dereference(ahsta->link[link_id]);
+		if (!arsta)
+			continue;
+		arvif = arsta->arvif;
+		if (!(arvif->ar == ar))
+			continue;
+
+		spin_lock_bh(&ab->base_lock);
+		ath12k_link_sta_rhash_delete(ab, arsta);
+		spin_unlock_bh(&ab->base_lock);
+	}
+	rcu_read_unlock();
+}
+
 void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 {
 	struct ath12k_dp_link_peer *peer, *tmp;
@@ -1165,6 +1194,10 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 
 	ar->num_peers = 0;
 	ar->num_stations = 0;
+
+	/* Cleanup rhash table maintained for arsta by iterating over sta */
+	ieee80211_iterate_stations_mtx(ar->ah->hw, ath12k_mac_link_sta_rhash_cleanup,
+				       ar);
 }
 
 static int ath12k_mac_vdev_setup_sync(struct ath12k *ar)
@@ -6349,6 +6382,7 @@ static int ath12k_mac_station_remove(struct ath12k *ar,
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	struct ath12k_vif *ahvif = arvif->ahvif;
 	int ret = 0;
+	struct ath12k_link_sta *temp_arsta;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -6377,6 +6411,15 @@ static int ath12k_mac_station_remove(struct ath12k *ar,
 
 	ath12k_mac_station_post_remove(ar, arvif, arsta);
 
+	spin_lock_bh(&ar->ab->base_lock);
+
+	/* To handle roaming and split phy scenario */
+	temp_arsta = ath12k_link_sta_find_by_addr(ar->ab, arsta->addr);
+	if (temp_arsta && temp_arsta->arvif->ar == ar)
+		ath12k_link_sta_rhash_delete(ar->ab, arsta);
+
+	spin_unlock_bh(&ar->ab->base_lock);
+
 	if (sta->valid_links)
 		ath12k_mac_free_unassign_link_sta(ahvif->ah,
 						  arsta->ahsta, arsta->link_id);
@@ -6393,6 +6436,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 	struct ieee80211_sta *sta = ath12k_ahsta_to_sta(arsta->ahsta);
 	struct ath12k_wmi_peer_create_arg peer_param = {};
 	int ret;
+	struct ath12k_link_sta *temp_arsta;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -6411,6 +6455,26 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 		}
 	}
 
+	spin_lock_bh(&ab->base_lock);
+
+	/*
+	 * In case of Split PHY and roaming scenario, pdev idx
+	 * might differ but both the pdev will share same rhash
+	 * table. In that case update the rhash table if link_sta is
+	 * already present
+	 */
+	temp_arsta = ath12k_link_sta_find_by_addr(ab, arsta->addr);
+	if (temp_arsta && temp_arsta->arvif->ar != ar)
+		ath12k_link_sta_rhash_delete(ab, temp_arsta);
+
+	ret = ath12k_link_sta_rhash_add(ab, arsta);
+	spin_unlock_bh(&ab->base_lock);
+	if (ret) {
+		ath12k_warn(ab, "Failed to add arsta: %pM to hash table, ret: %d",
+			    arsta->addr, ret);
+		goto free_rx_stats;
+	}
+
 	peer_param.vdev_id = arvif->vdev_id;
 	peer_param.peer_addr = arsta->addr;
 	peer_param.peer_type = WMI_PEER_TYPE_DEFAULT;
@@ -6459,6 +6523,10 @@ static int ath12k_mac_station_add(struct ath12k *ar,
 
 free_peer:
 	ath12k_peer_delete(ar, arvif->vdev_id, arsta->addr);
+	spin_lock_bh(&ab->base_lock);
+	ath12k_link_sta_rhash_delete(ab, arsta);
+	spin_unlock_bh(&ab->base_lock);
+free_rx_stats:
 	kfree(arsta->rx_stats);
 	arsta->rx_stats = NULL;
 dec_num_station:
@@ -6537,6 +6605,10 @@ static void ath12k_mac_ml_station_remove(struct ath12k_vif *ahvif,
 
 		ath12k_mac_station_post_remove(ar, arvif, arsta);
 
+		spin_lock_bh(&ar->ab->base_lock);
+		ath12k_link_sta_rhash_delete(ar->ab, arsta);
+		spin_unlock_bh(&ar->ab->base_lock);
+
 		ath12k_mac_free_unassign_link_sta(ah, ahsta, link_id);
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 16f4a74712d8..28801d87e6ed 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -406,3 +406,119 @@ int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_st
 
 	return err_ret;
 }
+
+static int ath12k_link_sta_rhash_insert(struct ath12k_base *ab,
+					struct ath12k_link_sta *arsta)
+{
+	struct ath12k_link_sta *tmp;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	tmp = rhashtable_lookup_get_insert_fast(ab->rhead_sta_addr, &arsta->rhash_addr,
+						ab->rhash_sta_addr_param);
+	if (!tmp)
+		return 0;
+	else if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	else
+		return -EEXIST;
+}
+
+static int ath12k_link_sta_rhash_remove(struct ath12k_base *ab,
+					struct ath12k_link_sta *arsta)
+{
+	int ret;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	ret = rhashtable_remove_fast(ab->rhead_sta_addr, &arsta->rhash_addr,
+				     ab->rhash_sta_addr_param);
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	return 0;
+}
+
+int ath12k_link_sta_rhash_add(struct ath12k_base *ab,
+			      struct ath12k_link_sta *arsta)
+{
+	int ret;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	ret = ath12k_link_sta_rhash_insert(ab, arsta);
+	if (ret)
+		ath12k_warn(ab, "failed to add arsta %pM in rhash_addr ret %d\n",
+			    arsta->addr, ret);
+
+	return ret;
+}
+
+void ath12k_link_sta_rhash_delete(struct ath12k_base *ab,
+				  struct ath12k_link_sta *arsta)
+{
+	/*
+	 * Return type of this function is void since there is nothing to be
+	 * done in failure case
+	 */
+	int ret;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	ret = ath12k_link_sta_rhash_remove(ab, arsta);
+	if (ret)
+		ath12k_warn(ab,
+			    "failed to remove arsta %pM in rhash_addr ret %d\n",
+			    arsta->addr, ret);
+}
+
+int ath12k_link_sta_rhash_tbl_init(struct ath12k_base *ab)
+{
+	struct rhashtable_params *param;
+	struct rhashtable *rhash_addr_tbl;
+	int ret;
+
+	rhash_addr_tbl = kzalloc(sizeof(*ab->rhead_sta_addr), GFP_KERNEL);
+	if (!rhash_addr_tbl)
+		return -ENOMEM;
+
+	param = &ab->rhash_sta_addr_param;
+
+	param->key_offset = offsetof(struct ath12k_link_sta, addr);
+	param->head_offset = offsetof(struct ath12k_link_sta, rhash_addr);
+	param->key_len = sizeof_field(struct ath12k_link_sta, addr);
+	param->automatic_shrinking = true;
+	param->nelem_hint = ab->num_radios * ath12k_core_get_max_peers_per_radio(ab);
+
+	ret = rhashtable_init(rhash_addr_tbl, param);
+	if (ret) {
+		ath12k_warn(ab, "failed to init peer addr rhash table %d\n",
+			    ret);
+		goto err_free;
+	}
+
+	ab->rhead_sta_addr = rhash_addr_tbl;
+
+	return 0;
+
+err_free:
+	kfree(rhash_addr_tbl);
+
+	return ret;
+}
+
+void ath12k_link_sta_rhash_tbl_destroy(struct ath12k_base *ab)
+{
+	rhashtable_destroy(ab->rhead_sta_addr);
+	kfree(ab->rhead_sta_addr);
+	ab->rhead_sta_addr = NULL;
+}
+
+struct ath12k_link_sta *ath12k_link_sta_find_by_addr(struct ath12k_base *ab,
+						     const u8 *addr)
+{
+	lockdep_assert_held(&ab->base_lock);
+
+	return rhashtable_lookup_fast(ab->rhead_sta_addr, addr,
+				      ab->rhash_sta_addr_param);
+}
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index 81e9bcc067ff..cf8a463d4c37 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -27,4 +27,10 @@ int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta);
 struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah,
 					   const u8 *addr);
+int ath12k_link_sta_rhash_tbl_init(struct ath12k_base *ab);
+void ath12k_link_sta_rhash_tbl_destroy(struct ath12k_base *ab);
+void ath12k_link_sta_rhash_delete(struct ath12k_base *ab, struct ath12k_link_sta *arsta);
+int ath12k_link_sta_rhash_add(struct ath12k_base *ab, struct ath12k_link_sta *arsta);
+struct ath12k_link_sta *ath12k_link_sta_find_by_addr(struct ath12k_base *ab,
+						     const u8 *addr);
 #endif /* _PEER_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 817f1c917320..0d4a83b8005a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7202,7 +7202,7 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 {
 	struct wmi_peer_sta_kickout_arg arg = {};
 	struct ieee80211_sta *sta;
-	struct ath12k_dp_link_peer *peer;
+	struct ath12k_link_sta *arsta;
 	struct ath12k *ar;
 
 	if (ath12k_pull_peer_sta_kickout_ev(ab, skb, &arg) != 0) {
@@ -7214,18 +7214,18 @@ static void ath12k_peer_sta_kickout_event(struct ath12k_base *ab, struct sk_buff
 
 	spin_lock_bh(&ab->base_lock);
 
-	peer = ath12k_dp_link_peer_find_by_addr(ab, arg.mac_addr);
+	arsta = ath12k_link_sta_find_by_addr(ab, arg.mac_addr);
 
-	if (!peer) {
-		ath12k_warn(ab, "peer not found %pM\n",
+	if (!arsta) {
+		ath12k_warn(ab, "arsta not found %pM\n",
 			    arg.mac_addr);
 		goto exit;
 	}
 
-	ar = ath12k_mac_get_ar_by_vdev_id(ab, peer->vdev_id);
+	ar = arsta->arvif->ar;
 	if (!ar) {
-		ath12k_warn(ab, "invalid vdev id in peer sta kickout ev %d",
-			    peer->vdev_id);
+		ath12k_warn(ab, "invalid ar in peer sta kickout ev for STA %pM\n",
+			    arg.mac_addr);
 		goto exit;
 	}
 
-- 
2.34.1



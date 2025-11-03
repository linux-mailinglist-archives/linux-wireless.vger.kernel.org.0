Return-Path: <linux-wireless+bounces-28493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CA9C2B498
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFD13AD2DA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEEE3019B5;
	Mon,  3 Nov 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HQFy7I4S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBD2EB87A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168902; cv=none; b=hAjYW5vOVM6yWviSXxdDWITMapiZa1U4Ik8zuCBHtYugd6doBcbTjwKure629LrpYlcLYMxC06VqA2y6Nqo6dSV0vQBKrO0tdnngUrO5XL3rYcvqVP5TqjIrytfWF+04HeELREuQ2s06AtQsPg9OGUdqSoTESv/u3I9rPSj09tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168902; c=relaxed/simple;
	bh=/ux9C/g4QCtiKrIOleYKONAk1Lhvu8zglSfDMG/iVow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eepkBNzKdDGrRsRrer9QmrMkpv2mi/sGQmT1HlrIJBFjbOsYJpiBGEgz6Kq0ESg78kKbmmJwtHhUHtp6n4rc1Gq5yE1Tcea2K1CkmNfiwWenMkK6KV9W4ISo4jeOJghQM9w08ChqhrXqLkBQEaChEyMJc9q3hvzWLAgSPbgXZg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HQFy7I4S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3AIUi42755762;
	Mon, 3 Nov 2025 11:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mKNQofj+soIXMnhmwEyzyWxo7b066bNPR8Kg0CNjMCs=; b=HQFy7I4SOO/yKxnj
	T8pJZ0UzM2GqxG15duwvryXplWIbO7YZ9Hv+7zd0yn2Z+BjlcX0y4RO1fcKo2iQh
	n224yUNkorFyQJhVB0DB6VPH9ALJPdxTFKCWnDIjRZQAWHuzPuE7RjbSwB6vcL03
	rxOxZ6WPD+a55wKVwcVnvg2RlbeBoNmsBUBzgt9ri8mDgmhKtP4dvW8B5l+Sx27P
	M6kTlBCbvIDoPQEn2OQEZu9VCB7vHQI1EPTJECQEwMiGBQvkr6sYKsAvM2Uh+QUB
	WwyfPEN5AFIpT8DpjWGsKohWMUXMjcNjynYMq/l1NOtYGbbZ4XdWtNLyJondWiPg
	G5BJ4A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6th9r4uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:21:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3BLbr9004988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 11:21:37 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 3 Nov 2025 03:21:35 -0800
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 01/12] wifi: ath12k: Add callbacks in arch_ops for rx APIs
Date: Mon, 3 Nov 2025 16:51:00 +0530
Message-ID: <20251103112111.2260639-2-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
References: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 94VhebwdHAcYzIsGjycdTJFfd2Yd4udH
X-Authority-Analysis: v=2.4 cv=ea8wvrEH c=1 sm=1 tr=0 ts=69089041 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=j2L2Nl0JYyHsiOhxElAA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 94VhebwdHAcYzIsGjycdTJFfd2Yd4udH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwMyBTYWx0ZWRfXyM9B/OP9rtxn
 v8OmLM8LOe5LQvuxMRHThewJ2fPpYzVE1senebGX/2ouK6DKmU+xKDe8tAufVjE165hd9cqvkCu
 UL/H0sdqG4cH4QyiLCbO1jstlCjwrax5LWa3+zvg/LiBYYPq3T+wakdj0/YgCt2nW3BQG5/y2To
 T/8crAPowRZyv5OULbd/YwL+sqxSVKwvJMn4j+6RDAzF2jwx9/LTWaUVdj/BormLZw3ePMuI8SL
 kcUNs8+d/8h1u5oH7wFyTMrlwmOfl6eNpEayseoxXOZYL8J4t/SSRbajDkwWYh54BjosxqJejHQ
 e21C91TNG6KQUKua5sDEKAPFC7LI1lmDgQl+jOr8BBo2oDO5NBubO4ZPAgUU6aVhu2PMqsqXk8i
 xdUH9uamFjvu5Pwgc5JlQyKvkezlpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030103

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Facilitate modular and architecture-agnostic access to Wi-Fi 7 Rx functionality
by introducing wrapper APIs in common module for existing RX callbacks already
defined in arch_ops.

Also remove redundant ar usage in these APIs and registered callbacks
definitions, and change the callback names of few of the APIs to remove the
redundant usage of "dp".

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c          |   5 +-
 drivers/net/wireless/ath/ath12k/dp.h          | 102 +++++++++++++++++-
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  38 ++++---
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  10 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |  19 ++--
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   4 +-
 6 files changed, 141 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index ff914c0e125f..e8f3f396dfde 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -10,7 +10,6 @@
 #include "hif.h"
 #include "hal.h"
 #include "debug.h"
-#include "wifi7/dp_rx.h"
 #include "peer.h"
 #include "dp_mon.h"
 #include "dp_cmn.h"
@@ -99,7 +98,7 @@ int ath12k_dp_peer_setup(struct ath12k *ar, int vdev_id, const u8 *addr)
 	}
 
 	for (tid--; tid >= 0; tid--)
-		ath12k_wifi7_dp_rx_peer_tid_delete(ar, peer, tid);
+		ath12k_dp_arch_rx_peer_tid_delete(dp, peer, tid);
 
 	spin_unlock_bh(&dp->dp_lock);
 
@@ -345,7 +344,7 @@ static int ath12k_dp_tx_get_bank_profile(struct ath12k_base *ab,
 	bool configure_register = false;
 
 	/* convert vdev params into hal_tx_bank_config */
-	bank_config = dp->ops->dp_tx_get_vdev_bank_config(ab, arvif);
+	bank_config = ath12k_dp_arch_tx_get_vdev_bank_config(dp, arvif);
 
 	spin_lock_bh(&dp->tx_bank_lock);
 	/* TODO: implement using idr kernel framework*/
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 1ffa3066ade5..e223cd85b08a 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -21,6 +21,7 @@ struct ath12k_vif;
 struct ath12k_link_vif;
 struct hal_tcl_status_ring;
 struct ath12k_ext_irq_grp;
+struct ath12k_dp_rx_tid;
 
 #define DP_MON_PURGE_TIMEOUT_MS     100
 #define DP_MON_SERVICE_BUDGET       128
@@ -389,8 +390,34 @@ struct ath12k_dp_arch_ops {
 	int (*service_srng)(struct ath12k_dp *dp,
 			    struct ath12k_ext_irq_grp *irq_grp,
 			    int budget);
-	u32 (*dp_tx_get_vdev_bank_config)(struct ath12k_base *ab,
-					  struct ath12k_link_vif *arvif);
+	u32 (*tx_get_vdev_bank_config)(struct ath12k_base *ab,
+				       struct ath12k_link_vif *arvif);
+	int (*reo_cmd_send)(struct ath12k_base *ab,
+			    struct ath12k_dp_rx_tid *rx_tid,
+			    enum hal_reo_cmd_type type,
+			    struct ath12k_hal_reo_cmd *cmd,
+			    void (*cb)(struct ath12k_dp *dp, void *ctx,
+				       enum hal_reo_cmd_status status));
+	void (*setup_pn_check_reo_cmd)(struct ath12k_hal_reo_cmd *cmd,
+				       struct ath12k_dp_rx_tid *rx_tid,
+				       u32 cipher, enum set_key_cmd key_cmd);
+	void (*rx_peer_tid_delete)(struct ath12k_base *ab,
+				   struct ath12k_dp_link_peer *peer, u8 tid);
+	void (*reo_cache_flush)(struct ath12k_base *ab,
+				struct ath12k_dp_rx_tid *rx_tid);
+	int (*rx_link_desc_return)(struct ath12k_base *ab,
+				   struct ath12k_buffer_addr *buf_addr_info,
+				   enum hal_wbm_rel_bm_act action);
+	int (*peer_rx_tid_reo_update)(struct ath12k_dp *dp,
+				      struct ath12k_dp_link_peer *peer,
+				      struct ath12k_dp_rx_tid *rx_tid,
+				      u32 ba_win_sz, u16 ssn,
+				      bool update_ssn);
+	int (*rx_assign_reoq)(struct ath12k_base *ab, struct ath12k_dp_peer *dp_peer,
+			      struct ath12k_dp_rx_tid *rx_tid,
+			      u16 ssn, enum hal_pn_type pn_type);
+	void (*peer_rx_tid_qref_setup)(struct ath12k_base *ab, u16 peer_id, u16 tid,
+				       dma_addr_t paddr);
 };
 
 struct ath12k_dp {
@@ -489,6 +516,77 @@ struct ath12k_dp {
 	struct rhashtable_params rhash_peer_addr_param;
 };
 
+static inline u32 ath12k_dp_arch_tx_get_vdev_bank_config(struct ath12k_dp *dp,
+							 struct ath12k_link_vif *arvif)
+{
+	return dp->ops->tx_get_vdev_bank_config(dp->ab, arvif);
+}
+
+static inline int ath12k_dp_arch_reo_cmd_send(struct ath12k_dp *dp,
+					      struct ath12k_dp_rx_tid *rx_tid,
+					      enum hal_reo_cmd_type type,
+					      struct ath12k_hal_reo_cmd *cmd,
+					      void (*cb)(struct ath12k_dp *dp, void *ctx,
+							 enum hal_reo_cmd_status status))
+{
+	return dp->ops->reo_cmd_send(dp->ab, rx_tid, type, cmd, cb);
+}
+
+static inline void ath12k_dp_arch_setup_pn_check_reo_cmd(struct ath12k_dp *dp,
+							 struct ath12k_hal_reo_cmd *cmd,
+							 struct ath12k_dp_rx_tid *rx_tid,
+							 u32 cipher,
+							 enum set_key_cmd key_cmd)
+{
+	dp->ops->setup_pn_check_reo_cmd(cmd, rx_tid, cipher, key_cmd);
+}
+
+static inline void ath12k_dp_arch_rx_peer_tid_delete(struct ath12k_dp *dp,
+						     struct ath12k_dp_link_peer *peer,
+						     u8 tid)
+{
+	dp->ops->rx_peer_tid_delete(dp->ab, peer, tid);
+}
+
+static inline void ath12k_dp_arch_reo_cache_flush(struct ath12k_dp *dp,
+						  struct ath12k_dp_rx_tid *rx_tid)
+{
+	dp->ops->reo_cache_flush(dp->ab, rx_tid);
+}
+
+static inline
+int ath12k_dp_arch_rx_link_desc_return(struct ath12k_dp *dp,
+				       struct ath12k_buffer_addr *buf_addr_info,
+				       enum hal_wbm_rel_bm_act action)
+{
+	return dp->ops->rx_link_desc_return(dp->ab, buf_addr_info, action);
+}
+
+static inline int ath12k_dp_arch_peer_rx_tid_reo_update(struct ath12k_dp *dp,
+							struct ath12k_dp_link_peer *peer,
+							struct ath12k_dp_rx_tid *rx_tid,
+							u32 ba_win_sz, u16 ssn,
+							bool update_ssn)
+{
+	return dp->ops->peer_rx_tid_reo_update(dp, peer, rx_tid,
+					       ba_win_sz, ssn, update_ssn);
+}
+
+static inline int ath12k_dp_arch_rx_assign_reoq(struct ath12k_dp *dp,
+						struct ath12k_dp_peer *dp_peer,
+						struct ath12k_dp_rx_tid *rx_tid,
+						u16 ssn, enum hal_pn_type pn_type)
+{
+	return dp->ops->rx_assign_reoq(dp->ab, dp_peer, rx_tid, ssn, pn_type);
+}
+
+static inline void ath12k_dp_arch_peer_rx_tid_qref_setup(struct ath12k_dp *dp,
+							 u16 peer_id, u16 tid,
+							 dma_addr_t paddr)
+{
+	dp->ops->peer_rx_tid_qref_setup(dp->ab, peer_id, tid, paddr);
+}
+
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
 {
 	memcpy(addr, &addr_l32, 4);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 12ad62b0ff5d..aa88f7cd1b56 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -431,7 +431,7 @@ void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 			 */
 			spin_unlock_bh(&dp->reo_cmd_lock);
 
-			ath12k_wifi7_dp_reo_cache_flush(ab, &elem->data);
+			ath12k_dp_arch_reo_cache_flush(dp, &elem->data);
 			kfree(elem);
 			spin_lock_bh(&dp->reo_cmd_lock);
 		}
@@ -449,18 +449,16 @@ void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
 				bool rel_link_desc)
 {
+	enum hal_wbm_rel_bm_act act = HAL_WBM_REL_BM_ACT_PUT_IN_IDLE;
 	struct ath12k_buffer_addr *buf_addr_info;
 	struct ath12k_dp *dp = rx_tid->dp;
-	struct ath12k_base *ab = dp->ab;
 
 	lockdep_assert_held(&dp->dp_lock);
 
 	if (rx_tid->dst_ring_desc) {
 		if (rel_link_desc) {
 			buf_addr_info = &rx_tid->dst_ring_desc->buf_addr_info;
-			ath12k_wifi7_dp_rx_link_desc_return
-				(ab, buf_addr_info,
-				 HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+			ath12k_dp_arch_rx_link_desc_return(dp, buf_addr_info, act);
 		}
 		kfree(rx_tid->dst_ring_desc);
 		rx_tid->dst_ring_desc = NULL;
@@ -487,7 +485,7 @@ void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_dp_link_peer
 	for (i = 0; i <= IEEE80211_NUM_TIDS; i++) {
 		rx_tid = &peer->dp_peer->rx_tid[i];
 
-		ath12k_wifi7_dp_rx_peer_tid_delete(ar, peer, i);
+		ath12k_dp_arch_rx_peer_tid_delete(dp, peer, i);
 		ath12k_dp_rx_frags_cleanup(rx_tid, true);
 
 		spin_unlock_bh(&dp->dp_lock);
@@ -539,8 +537,8 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	rx_tid = &peer->dp_peer->rx_tid[tid];
 	/* Update the tid queue if it is already setup */
 	if (peer->rx_tid_active_bitmask & (1 << tid)) {
-		ret = ath12k_wifi7_peer_rx_tid_reo_update(ar, peer, rx_tid,
-							  ba_win_sz, ssn, true);
+		ret = ath12k_dp_arch_peer_rx_tid_reo_update(dp, peer, rx_tid,
+							    ba_win_sz, ssn, true);
 		spin_unlock_bh(&dp->dp_lock);
 		if (ret) {
 			ath12k_warn(ab, "failed to update reo for rx tid %d\n", tid);
@@ -567,7 +565,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 
 	rx_tid->ba_win_sz = ba_win_sz;
 
-	ret = ath12k_wifi7_dp_rx_assign_reoq(ab, peer->dp_peer, rx_tid, ssn, pn_type);
+	ret = ath12k_dp_arch_rx_assign_reoq(dp, peer->dp_peer, rx_tid, ssn, pn_type);
 	if (ret) {
 		spin_unlock_bh(&dp->dp_lock);
 		ath12k_warn(ab, "failed to assign reoq buf for rx tid %u\n", tid);
@@ -582,11 +580,11 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		 * and tid with qaddr.
 		 */
 		if (peer->mlo)
-			ath12k_wifi7_peer_rx_tid_qref_setup(ab, peer->ml_id, tid,
-							    paddr_aligned);
+			ath12k_dp_arch_peer_rx_tid_qref_setup(dp, peer->ml_id, tid,
+							      paddr_aligned);
 		else
-			ath12k_wifi7_peer_rx_tid_qref_setup(ab, peer->peer_id, tid,
-							    paddr_aligned);
+			ath12k_dp_arch_peer_rx_tid_qref_setup(dp, peer->peer_id, tid,
+							      paddr_aligned);
 
 		spin_unlock_bh(&dp->dp_lock);
 	} else {
@@ -670,8 +668,8 @@ int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
 		return 0;
 	}
 
-	ret = ath12k_wifi7_peer_rx_tid_reo_update(ar, peer, peer->dp_peer->rx_tid,
-						  1, 0, false);
+	ret = ath12k_dp_arch_peer_rx_tid_reo_update(dp, peer, peer->dp_peer->rx_tid,
+						    1, 0, false);
 	spin_unlock_bh(&dp->dp_lock);
 	if (ret) {
 		ath12k_warn(ab, "failed to update reo for rx tid %d: %d\n",
@@ -720,11 +718,11 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 
 		rx_tid = &peer->dp_peer->rx_tid[tid];
 
-		ath12k_wifi7_dp_setup_pn_check_reo_cmd(&cmd, rx_tid, key->cipher,
-						       key_cmd);
-		ret = ath12k_wifi7_dp_reo_cmd_send(ab, rx_tid,
-						   HAL_REO_CMD_UPDATE_RX_QUEUE,
-						   &cmd, NULL);
+		ath12k_dp_arch_setup_pn_check_reo_cmd(dp, &cmd, rx_tid, key->cipher,
+						      key_cmd);
+		ret = ath12k_dp_arch_reo_cmd_send(dp, rx_tid,
+						  HAL_REO_CMD_UPDATE_RX_QUEUE,
+						  &cmd, NULL);
 		if (ret) {
 			ath12k_warn(ab, "failed to configure rx tid %d queue of peer %pM for pn replay detection %d\n",
 				    tid, peer_addr, ret);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index 976dfe1b9087..1fd7738a39b5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -138,7 +138,15 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 
 static struct ath12k_dp_arch_ops ath12k_wifi7_dp_arch_ops = {
 	.service_srng = ath12k_wifi7_dp_service_srng,
-	.dp_tx_get_vdev_bank_config = ath12k_wifi7_dp_tx_get_vdev_bank_config,
+	.tx_get_vdev_bank_config = ath12k_wifi7_dp_tx_get_vdev_bank_config,
+	.reo_cmd_send = ath12k_wifi7_dp_reo_cmd_send,
+	.setup_pn_check_reo_cmd = ath12k_wifi7_dp_setup_pn_check_reo_cmd,
+	.rx_peer_tid_delete = ath12k_wifi7_dp_rx_peer_tid_delete,
+	.reo_cache_flush = ath12k_wifi7_dp_reo_cache_flush,
+	.rx_link_desc_return = ath12k_wifi7_dp_rx_link_desc_return,
+	.peer_rx_tid_reo_update = ath12k_wifi7_peer_rx_tid_reo_update,
+	.rx_assign_reoq = ath12k_wifi7_dp_rx_assign_reoq,
+	.peer_rx_tid_qref_setup = ath12k_wifi7_peer_rx_tid_qref_setup,
 };
 
 /* TODO: remove export once this file is built with wifi7 ko */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index d24d0f12742e..f4855b001fda 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -68,7 +68,7 @@ static void ath12k_wifi7_peer_rx_tid_qref_reset(struct ath12k_base *ab,
 		      u32_encode_bits(tid, DP_REO_QREF_NUM);
 }
 
-void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k *ar,
+void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k_base *ab,
 					struct ath12k_dp_link_peer *peer, u8 tid)
 {
 	struct ath12k_hal_reo_cmd cmd = {};
@@ -82,22 +82,22 @@ void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k *ar,
 	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.upd0 = HAL_REO_CMD_UPD0_VLD;
-	ret = ath12k_wifi7_dp_reo_cmd_send(ar->ab, rx_tid,
+	ret = ath12k_wifi7_dp_reo_cmd_send(ab, rx_tid,
 					   HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
 					   ath12k_dp_rx_tid_del_func);
 	if (ret) {
-		ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
+		ath12k_err(ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
 			   tid, ret);
-		dma_unmap_single(ar->ab->dev, rx_tid->qbuf.paddr_aligned,
+		dma_unmap_single(ab->dev, rx_tid->qbuf.paddr_aligned,
 				 rx_tid->qbuf.size, DMA_BIDIRECTIONAL);
 		kfree(rx_tid->qbuf.vaddr);
 		rx_tid->qbuf.vaddr = NULL;
 	}
 
 	if (peer->mlo)
-		ath12k_wifi7_peer_rx_tid_qref_reset(ar->ab, peer->ml_id, tid);
+		ath12k_wifi7_peer_rx_tid_qref_reset(ab, peer->ml_id, tid);
 	else
-		ath12k_wifi7_peer_rx_tid_qref_reset(ar->ab, peer->peer_id, tid);
+		ath12k_wifi7_peer_rx_tid_qref_reset(ab, peer->peer_id, tid);
 
 	peer->rx_tid_active_bitmask &= ~(1 << tid);
 }
@@ -179,13 +179,14 @@ int ath12k_wifi7_dp_reo_cmd_send(struct ath12k_base *ab,
 	return 0;
 }
 
-int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k *ar,
+int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k_dp *dp,
 					struct ath12k_dp_link_peer *peer,
 					struct ath12k_dp_rx_tid *rx_tid,
 					u32 ba_win_sz, u16 ssn,
 					bool update_ssn)
 {
 	struct ath12k_hal_reo_cmd cmd = {};
+	struct ath12k_base *ab = dp->ab;
 	int ret;
 
 	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
@@ -199,11 +200,11 @@ int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k *ar,
 		cmd.upd2 = u32_encode_bits(ssn, HAL_REO_CMD_UPD2_SSN);
 	}
 
-	ret = ath12k_wifi7_dp_reo_cmd_send(ar->ab, rx_tid,
+	ret = ath12k_wifi7_dp_reo_cmd_send(ab, rx_tid,
 					   HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
 					   NULL);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to update rx tid queue, tid %d (%d)\n",
+		ath12k_warn(ab, "failed to update rx tid queue, tid %d (%d)\n",
 			    rx_tid->tid, ret);
 		return ret;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index ba319ff506f2..cb72b75526d4 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -33,7 +33,7 @@ int ath12k_wifi7_dp_rx_link_desc_return(struct ath12k_base *ab,
 					enum hal_wbm_rel_bm_act action);
 void ath12k_wifi7_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
 					 dma_addr_t paddr);
-void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k *ar,
+void ath12k_wifi7_dp_rx_peer_tid_delete(struct ath12k_base *ab,
 					struct ath12k_dp_link_peer *peer, u8 tid);
 int ath12k_wifi7_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
 				 enum hal_reo_cmd_type type,
@@ -42,7 +42,7 @@ int ath12k_wifi7_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid
 					    enum hal_reo_cmd_status status));
 void ath12k_wifi7_dp_reo_cache_flush(struct ath12k_base *ab,
 				     struct ath12k_dp_rx_tid *rx_tid);
-int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k *ar,
+int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k_dp *dp,
 					struct ath12k_dp_link_peer *peer,
 					struct ath12k_dp_rx_tid *rx_tid,
 					u32 ba_win_sz, u16 ssn,
-- 
2.34.1



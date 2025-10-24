Return-Path: <linux-wireless+bounces-28229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E451C07ADA
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C3A1C275D1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A812123D7D2;
	Fri, 24 Oct 2025 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FsVQrqOL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512CC2A1BB
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329776; cv=none; b=SP0RWlTgJwldidbaE6DdiL3UsCB7sdXJF7CAc3GPtL0g9XtdgfSMEfF0oGAIchu4sK8/6pP7U4pO0cvIB64qkiMM+bjHFcFwQrUAkG4LAVfIkKI593X1pIFhA1MKNLGwLyjJigy5px69fDkvVhYWJY2ohGdfec/qXgp0oKDNKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329776; c=relaxed/simple;
	bh=6Dv/c7KdJi2dJXYrPtdVvOuvj9LZMMocAIi4v1LB8Lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnebH+7neXSHBlMlLHsD0rZg0yjh5ZDXCsIPg/G6nIGm8/PL0bCgIxp0ZFmkkAh5a9D51lKyZkr7k8Nm3oKQEbNRSFF8rEkJtlW8c8bdi4vmy2Cj0z1lNFzj4xeDwORh45crij+N4Y6HcO8Hy2avWD7O4xA7oJfZuciXhvBtdps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FsVQrqOL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9DYE007009;
	Fri, 24 Oct 2025 18:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HkxzrNqMJAml/Pb5I9Lfpa/Q8CDaIETHdtrTRCoet9s=; b=FsVQrqOL+hkWZ9zT
	IrEAjPYm48FKNpgPE8K/entdpKQVnMmLYbV5j0NdHKsofgvDZpXIcgt1nam7+Rpr
	1xrk8tLaUGpYXvpsIVd0qLhyqnt+qLdijLrEWu71+qeC7ekcNU5PmNAiBu/UJR4R
	s/FsilkfJr8/zS6qJuvhHF3sv9sLkpa127IoJJSDRdBILyoNPq1LwFXkFAuz86lq
	np3NHptlWiDXFl9rMjK8DkTr2rItkpUN+35OHxn3GNUn2yA/mT9iMQL987xu7pD5
	rNLTuspIghO8JK+YdPbSVynXtBaea4a0uRQJwMNfhPrSKTSZC860LrdQTifwu75N
	OyK2zw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v344cwr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59OIG7OM009714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:07 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 24 Oct 2025 11:16:05 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 1/9] wifi: ath12k: Move DP related functions from peer.c to dp_peer.c file
Date: Fri, 24 Oct 2025 23:45:40 +0530
Message-ID: <20251024181548.3255166-2-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: 5i_dURaDZ351h9cWuyoMDvLd3wpwmyQU
X-Proofpoint-ORIG-GUID: 5i_dURaDZ351h9cWuyoMDvLd3wpwmyQU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX3UB5R7fACDcd
 MBdSCZsMc9hFAUzsaJxgXSoaFkAa1OwyRE/JEcEPhOPyXmNJc2u3ySPkX2hhJmUy1ZVv4HmF4GZ
 1QxkZU5hU8bdiZytGkY9IOUySQQ2PidUXF6eMWs8VoqzHKDwGvW6byoowEtt66PHSLR2g0RIDf6
 3qPjxeBgkzZCFmncXn3nVphTrAzxzQUX1mIEISLAci1A6TKf8CoFCP29PKAIA0cNGQXhU3NrUoq
 9h6aP7TP4VHGx9n/3k5xLZhcYsbSVUhvgJK0j8wktjGw76KgxsjaLg8/huRkfa6UTp/47SgG6FQ
 ELTMP31Fks4Gx/J86ChDgtUDPGqXRJdYSBy3xW9IYzrdBX5eruIdhGkhER7Gevw49NeX2/0TdfF
 K/Nn2MDWb+DcaTcXOzzDcybiAuPCAw==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fbc267 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=kdX1ESSSVhdokcZRwp4A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

Refactor the structures and APIs defined in files peer.h and peer.c in such a
way that the APIs making use of ath12k_peer are moved to newly introduced files
dp_peer.h and dp_peer.c.

Have this new file dp_peer.c compiled as part of kernel module ath12k.ko.

Move these APIs from peer.h and peer.c to dp_peer.h and dp_peer.c:
  ath12k_peer_find()
  ath12k_peer_find_by_pdev_idx()
  ath12k_peer_find_by_addr()
  ath12k_peer_find_by_ml_id()
  ath12k_peer_find_by_id()
  ath12k_peer_exist_by_vdev_id()
  ath12k_peer_find_by_ast()
  ath12k_peer_unmap_event()
  ath12k_peer_map_event()
  ath12k_peer_get_link_sta()

Background:

In current ath12k architecture, connected station is represented by struct
ath12k_sta.

struct ath12k_sta has an array of struct ath12k_link_sta wherein each index
represents one link of the connected station.

For each ath12k_link_sta, there is a corresponding data path peer which is
represented by struct ath12k_peer.

Diagrammatic view of the station is as below:

        ath12k_sta
            |
            |-> ath12k_link_sta <--> ath12k_peer
            |
            |-> ath12k_link_sta <--> ath12k_peer
            |
            |-> ath12k_link_sta <--> ath12k_peer

Currently, in control path, ath12k_link_sta and ath12k_peer are used
interchangeably, while the data path makes use of ath12k_peer only.

For ath12k next-generation driver framework, in order to have a clean
segregation between control and data path, use ath12k_link_sta only for control
path operations.

Station view for the data path is revamped as below:

        ath12k_dp_peer
               |
               |-> ath12k_dp_link_peer
               |
               |-> ath12k_dp_link_peer
               |
               |-> ath12k_dp_link_peer

Introduce the structure ath12k_dp_peer to represent the data path version of
corresponding ath12k_sta.

This ath12k_dp_peer contains the fields used in the per packet Tx Rx paths
applicable across all the links and maintains an array of ath12k_dp_link_peer.
Per packet Tx and Rx path operates on ath12k_dp_peer. This ath12k_dp_peer is a
standalone new object and has back pointer reference to ieee80211_sta.

Rename ath12k_peer to ath12k_dp_link_peer and move the fields which are common
across all the links to ath12k_dp_peer.

Add the fields specific to a link which are mostly for statistics and monitor
usage to ath12k_dp_link_peer.

Final view of station in ath12k next-generation driver is shown as below:

            Control Path                            Data Path
        -------------------------------------------------------------------
        ath12k_sta                            ath12k_dp_peer
            |                                       |
            |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
            |                                       |
            |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer
            |                                       |
            |-> ath12k_link_sta    <---->           |-> ath12k_dp_link_peer

This patch and the subsequent patches in this series are meant to achieve the
modularization of peer object as mentioned above.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile  |   1 +
 drivers/net/wireless/ath/ath12k/dp_peer.c | 207 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/dp_peer.h |  82 +++++++++
 drivers/net/wireless/ath/ath12k/peer.c    | 172 ------------------
 drivers/net/wireless/ath/ath12k/peer.h    |  97 +---------
 5 files changed, 292 insertions(+), 267 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.c
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 32a0f30faf92..d397bc494cf2 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -11,6 +11,7 @@ ath12k-y += core.o \
 	    dp_tx.o \
 	    dp_rx.o \
 	    dp_htt.o \
+	    dp_peer.o \
 	    debug.o \
 	    ce.o \
 	    peer.o \
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
new file mode 100644
index 000000000000..e32d3ea76a6f
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "core.h"
+#include "dp_peer.h"
+#include "debug.h"
+
+struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
+				     const u8 *addr)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (peer->vdev_id != vdev_id)
+			continue;
+		if (!ether_addr_equal(peer->addr, addr))
+			continue;
+
+		return peer;
+	}
+
+	return NULL;
+}
+
+struct ath12k_peer *ath12k_peer_find_by_pdev_idx(struct ath12k_base *ab,
+						 u8 pdev_idx, const u8 *addr)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (peer->pdev_idx != pdev_idx)
+			continue;
+		if (!ether_addr_equal(peer->addr, addr))
+			continue;
+
+		return peer;
+	}
+
+	return NULL;
+}
+
+struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
+					     const u8 *addr)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (!ether_addr_equal(peer->addr, addr))
+			continue;
+
+		return peer;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(ath12k_peer_find_by_addr);
+
+static struct ath12k_peer *ath12k_peer_find_by_ml_id(struct ath12k_base *ab,
+						     int ml_peer_id)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list)
+		if (ml_peer_id == peer->ml_id)
+			return peer;
+
+	return NULL;
+}
+
+struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
+					   int peer_id)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	if (peer_id == HAL_INVALID_PEERID)
+		return NULL;
+
+	if (peer_id & ATH12K_PEER_ML_ID_VALID)
+		return ath12k_peer_find_by_ml_id(ab, peer_id);
+
+	list_for_each_entry(peer, &ab->peers, list)
+		if (peer_id == peer->peer_id)
+			return peer;
+
+	return NULL;
+}
+
+bool ath12k_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id)
+{
+	struct ath12k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (vdev_id == peer->vdev_id) {
+			spin_unlock_bh(&ab->base_lock);
+			return true;
+		}
+	}
+	spin_unlock_bh(&ab->base_lock);
+	return false;
+}
+
+struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab,
+					    int ast_hash)
+{
+	struct ath12k_peer *peer;
+
+	lockdep_assert_held(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list)
+		if (ast_hash == peer->ast_hash)
+			return peer;
+
+	return NULL;
+}
+
+void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
+{
+	struct ath12k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+
+	peer = ath12k_peer_find_by_id(ab, peer_id);
+	if (!peer) {
+		ath12k_warn(ab, "peer-unmap-event: unknown peer id %d\n",
+			    peer_id);
+		goto exit;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt peer unmap vdev %d peer %pM id %d\n",
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
+void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
+			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id)
+{
+	struct ath12k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_peer_find(ab, vdev_id, mac_addr);
+	if (!peer) {
+		peer = kzalloc(sizeof(*peer), GFP_ATOMIC);
+		if (!peer)
+			goto exit;
+
+		peer->vdev_id = vdev_id;
+		peer->peer_id = peer_id;
+		peer->ast_hash = ast_hash;
+		peer->hw_peer_id = hw_peer_id;
+		ether_addr_copy(peer->addr, mac_addr);
+		list_add(&peer->list, &ab->peers);
+		wake_up(&ab->peer_mapping_wq);
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt peer map vdev %d peer %pM id %d\n",
+		   vdev_id, mac_addr, peer_id);
+
+exit:
+	spin_unlock_bh(&ab->base_lock);
+}
+
+struct ath12k_link_sta *ath12k_peer_get_link_sta(struct ath12k_base *ab,
+						 struct ath12k_peer *peer)
+{
+	struct ath12k_sta *ahsta;
+	struct ath12k_link_sta *arsta;
+
+	if (!peer->sta)
+		return NULL;
+
+	ahsta = ath12k_sta_to_ahsta(peer->sta);
+	if (peer->ml_id & ATH12K_PEER_ML_ID_VALID) {
+		if (!(ahsta->links_map & BIT(peer->link_id))) {
+			ath12k_warn(ab, "peer %pM id %d link_id %d can't found in STA link_map 0x%x\n",
+				    peer->addr, peer->peer_id, peer->link_id,
+				    ahsta->links_map);
+			return NULL;
+		}
+		arsta = rcu_dereference(ahsta->link[peer->link_id]);
+		if (!arsta)
+			return NULL;
+	} else {
+		arsta =  &ahsta->deflink;
+	}
+	return arsta;
+}
diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.h b/drivers/net/wireless/ath/ath12k/dp_peer.h
new file mode 100644
index 000000000000..19f01d69e5d3
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef ATH12K_DP_PEER_H
+#define ATH12K_DP_PEER_H
+
+#include "dp_rx.h"
+
+struct ppdu_user_delayba {
+	u16 sw_peer_id;
+	u32 info0;
+	u16 ru_end;
+	u16 ru_start;
+	u32 info1;
+	u32 rate_flags;
+	u32 resp_rate_flags;
+};
+
+#define ATH12K_PEER_ML_ID_VALID         BIT(13)
+
+struct ath12k_peer {
+	struct list_head list;
+	struct ieee80211_sta *sta;
+	int vdev_id;
+	u8 addr[ETH_ALEN];
+	int peer_id;
+	u16 ast_hash;
+	u8 pdev_idx;
+	u16 hw_peer_id;
+
+	/* protected by ab->data_lock */
+	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
+	struct ath12k_dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
+
+	/* Info used in MMIC verification of
+	 * RX fragments
+	 */
+	struct crypto_shash *tfm_mmic;
+	u8 mcast_keyidx;
+	u8 ucast_keyidx;
+	u16 sec_type;
+	u16 sec_type_grp;
+	struct ppdu_user_delayba ppdu_stats_delayba;
+	bool delayba_flag;
+	bool is_authorized;
+	bool mlo;
+	/* protected by ab->data_lock */
+	bool dp_setup_done;
+
+	u16 ml_id;
+
+	/* any other ML info common for all partners can be added
+	 * here and would be same for all partner peers.
+	 */
+	u8 ml_addr[ETH_ALEN];
+
+	/* To ensure only certain work related to dp is done once */
+	bool primary_link;
+
+	/* for reference to ath12k_link_sta */
+	u8 link_id;
+	bool ucast_ra_only;
+};
+
+void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
+void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
+			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id);
+struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
+				     const u8 *addr);
+struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
+					     const u8 *addr);
+struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab, int peer_id);
+bool ath12k_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id);
+struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash);
+struct ath12k_peer *ath12k_peer_find_by_pdev_idx(struct ath12k_base *ab,
+						 u8 pdev_idx, const u8 *addr);
+struct ath12k_link_sta *ath12k_peer_get_link_sta(struct ath12k_base *ab,
+						 struct ath12k_peer *peer);
+#endif
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index ce1564298656..1e2526bb1186 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -25,178 +25,6 @@ struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah, const u8 *addr)
 }
 EXPORT_SYMBOL(ath12k_peer_ml_find);
 
-struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
-				     const u8 *addr)
-{
-	struct ath12k_peer *peer;
-
-	lockdep_assert_held(&ab->base_lock);
-
-	list_for_each_entry(peer, &ab->peers, list) {
-		if (peer->vdev_id != vdev_id)
-			continue;
-		if (!ether_addr_equal(peer->addr, addr))
-			continue;
-
-		return peer;
-	}
-
-	return NULL;
-}
-
-static struct ath12k_peer *ath12k_peer_find_by_pdev_idx(struct ath12k_base *ab,
-							u8 pdev_idx, const u8 *addr)
-{
-	struct ath12k_peer *peer;
-
-	lockdep_assert_held(&ab->base_lock);
-
-	list_for_each_entry(peer, &ab->peers, list) {
-		if (peer->pdev_idx != pdev_idx)
-			continue;
-		if (!ether_addr_equal(peer->addr, addr))
-			continue;
-
-		return peer;
-	}
-
-	return NULL;
-}
-
-struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
-					     const u8 *addr)
-{
-	struct ath12k_peer *peer;
-
-	lockdep_assert_held(&ab->base_lock);
-
-	list_for_each_entry(peer, &ab->peers, list) {
-		if (!ether_addr_equal(peer->addr, addr))
-			continue;
-
-		return peer;
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL(ath12k_peer_find_by_addr);
-
-static struct ath12k_peer *ath12k_peer_find_by_ml_id(struct ath12k_base *ab,
-						     int ml_peer_id)
-{
-	struct ath12k_peer *peer;
-
-	lockdep_assert_held(&ab->base_lock);
-
-	list_for_each_entry(peer, &ab->peers, list)
-		if (ml_peer_id == peer->ml_id)
-			return peer;
-
-	return NULL;
-}
-
-struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab,
-					   int peer_id)
-{
-	struct ath12k_peer *peer;
-
-	lockdep_assert_held(&ab->base_lock);
-
-	if (peer_id == HAL_INVALID_PEERID)
-		return NULL;
-
-	if (peer_id & ATH12K_PEER_ML_ID_VALID)
-		return ath12k_peer_find_by_ml_id(ab, peer_id);
-
-	list_for_each_entry(peer, &ab->peers, list)
-		if (peer_id == peer->peer_id)
-			return peer;
-
-	return NULL;
-}
-
-bool ath12k_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id)
-{
-	struct ath12k_peer *peer;
-
-	spin_lock_bh(&ab->base_lock);
-
-	list_for_each_entry(peer, &ab->peers, list) {
-		if (vdev_id == peer->vdev_id) {
-			spin_unlock_bh(&ab->base_lock);
-			return true;
-		}
-	}
-	spin_unlock_bh(&ab->base_lock);
-	return false;
-}
-
-struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab,
-					    int ast_hash)
-{
-	struct ath12k_peer *peer;
-
-	lockdep_assert_held(&ab->base_lock);
-
-	list_for_each_entry(peer, &ab->peers, list)
-		if (ast_hash == peer->ast_hash)
-			return peer;
-
-	return NULL;
-}
-
-void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id)
-{
-	struct ath12k_peer *peer;
-
-	spin_lock_bh(&ab->base_lock);
-
-	peer = ath12k_peer_find_by_id(ab, peer_id);
-	if (!peer) {
-		ath12k_warn(ab, "peer-unmap-event: unknown peer id %d\n",
-			    peer_id);
-		goto exit;
-	}
-
-	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt peer unmap vdev %d peer %pM id %d\n",
-		   peer->vdev_id, peer->addr, peer_id);
-
-	list_del(&peer->list);
-	kfree(peer);
-	wake_up(&ab->peer_mapping_wq);
-
-exit:
-	spin_unlock_bh(&ab->base_lock);
-}
-
-void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
-			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id)
-{
-	struct ath12k_peer *peer;
-
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find(ab, vdev_id, mac_addr);
-	if (!peer) {
-		peer = kzalloc(sizeof(*peer), GFP_ATOMIC);
-		if (!peer)
-			goto exit;
-
-		peer->vdev_id = vdev_id;
-		peer->peer_id = peer_id;
-		peer->ast_hash = ast_hash;
-		peer->hw_peer_id = hw_peer_id;
-		ether_addr_copy(peer->addr, mac_addr);
-		list_add(&peer->list, &ab->peers);
-		wake_up(&ab->peer_mapping_wq);
-	}
-
-	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "htt peer map vdev %d peer %pM id %d\n",
-		   vdev_id, mac_addr, peer_id);
-
-exit:
-	spin_unlock_bh(&ab->base_lock);
-}
-
 static int ath12k_wait_for_peer_common(struct ath12k_base *ab, int vdev_id,
 				       const u8 *addr, bool expect_mapped)
 {
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index 44afc0b7dd53..81e9bcc067ff 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -1,69 +1,13 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_PEER_H
 #define ATH12K_PEER_H
 
-#include "dp_rx.h"
-
-struct ppdu_user_delayba {
-	u16 sw_peer_id;
-	u32 info0;
-	u16 ru_end;
-	u16 ru_start;
-	u32 info1;
-	u32 rate_flags;
-	u32 resp_rate_flags;
-};
-
-#define ATH12K_PEER_ML_ID_VALID         BIT(13)
-
-struct ath12k_peer {
-	struct list_head list;
-	struct ieee80211_sta *sta;
-	int vdev_id;
-	u8 addr[ETH_ALEN];
-	int peer_id;
-	u16 ast_hash;
-	u8 pdev_idx;
-	u16 hw_peer_id;
-
-	/* protected by ab->data_lock */
-	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
-	struct ath12k_dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
-
-	/* Info used in MMIC verification of
-	 * RX fragments
-	 */
-	struct crypto_shash *tfm_mmic;
-	u8 mcast_keyidx;
-	u8 ucast_keyidx;
-	u16 sec_type;
-	u16 sec_type_grp;
-	struct ppdu_user_delayba ppdu_stats_delayba;
-	bool delayba_flag;
-	bool is_authorized;
-	bool mlo;
-	/* protected by ab->data_lock */
-	bool dp_setup_done;
-
-	u16 ml_id;
-
-	/* any other ML info common for all partners can be added
-	 * here and would be same for all partner peers.
-	 */
-	u8 ml_addr[ETH_ALEN];
-
-	/* To ensure only certain work related to dp is done once */
-	bool primary_link;
-
-	/* for reference to ath12k_link_sta */
-	u8 link_id;
-	bool ucast_ra_only;
-};
+#include "dp_peer.h"
 
 struct ath12k_ml_peer {
 	struct list_head list;
@@ -71,14 +15,6 @@ struct ath12k_ml_peer {
 	u16 id;
 };
 
-void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
-void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
-			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id);
-struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
-				     const u8 *addr);
-struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
-					     const u8 *addr);
-struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab, int peer_id);
 void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id);
 int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr);
 int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
@@ -86,38 +22,9 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		       struct ath12k_wmi_peer_create_arg *arg);
 int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
 				     const u8 *addr);
-bool ath12k_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id);
-struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash);
 int ath12k_peer_ml_create(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta);
 struct ath12k_ml_peer *ath12k_peer_ml_find(struct ath12k_hw *ah,
 					   const u8 *addr);
-static inline
-struct ath12k_link_sta *ath12k_peer_get_link_sta(struct ath12k_base *ab,
-						 struct ath12k_peer *peer)
-{
-	struct ath12k_sta *ahsta;
-	struct ath12k_link_sta *arsta;
-
-	if (!peer->sta)
-		return NULL;
-
-	ahsta = ath12k_sta_to_ahsta(peer->sta);
-	if (peer->ml_id & ATH12K_PEER_ML_ID_VALID) {
-		if (!(ahsta->links_map & BIT(peer->link_id))) {
-			ath12k_warn(ab, "peer %pM id %d link_id %d can't found in STA link_map 0x%x\n",
-				    peer->addr, peer->peer_id, peer->link_id,
-				    ahsta->links_map);
-			return NULL;
-		}
-		arsta = rcu_dereference(ahsta->link[peer->link_id]);
-		if (!arsta)
-			return NULL;
-	} else {
-		arsta =  &ahsta->deflink;
-	}
-	return arsta;
-}
-
 #endif /* _PEER_H_ */
-- 
2.34.1



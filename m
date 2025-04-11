Return-Path: <linux-wireless+bounces-21421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D364BA85402
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C234B1B86820
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DD723A9;
	Fri, 11 Apr 2025 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hGJCrM9M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC176367
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352152; cv=none; b=jh5Wsnk4UNgmgH8S266nLagu6R0m0Fx1QGO4VUMIuH9/lIPHJRfzcR+Qhz0zxcz16LM1MNc/z3HeDs0Yzl2W9UxA6N6/jPszxVM8u5xdIX4N8xkpck9VU2SxJ9RiHwiNKV9/lAqeLrXqYNPdSKbxsB6YoMpW7v+ux9sMNZPU8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352152; c=relaxed/simple;
	bh=AYe48L2LMKWs4V0Wx+pe5E45g3tJUs1WhtbgQznaiOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iitVoZjP5abPBgHaacDRaSf4r7aB/AQQeUrAsibX1S1sYGGTcEUgSQt3F6I+errXqSYgsWrnEU71watkqFFIh9rtf5KFModem+sCIK/ZlOIk2vuUQ2DQ0aYwGCcP3sIxDbK4sNDtrJAkK+yk/fZfsA1B8mB9JZy6LW3ht2d7/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hGJCrM9M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B4Fmp2018718;
	Fri, 11 Apr 2025 06:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J9ZoQApU079gfuCpL8POne989ySw2O06qxhLZ48Kb0M=; b=hGJCrM9Mpe5waU3W
	nZZIjrVEh1b0ujyS0CDF4mh5ihyrGM437yvHOisv8hZIR7EUvEv+CMkmCJ1O3kA0
	poYMAJ0AB4APTqYpVNKWcb/zqJ/IbmN+xOgkCnUqHamkXKQD74978kjAYRR8BlsO
	4+6wjv4xCejz7C81JL+EhX3G6chh6gCxIeR84al+PBUgCKPe8uzQ/2j6WYbTmpn/
	6mVhOUSYW4M4KRGC+qVIYoJBaSjspAdVv5QJUCAtF/9+y1paoUHg6YqQyyVSOIgE
	QkI2ggOpf9hKy3vRCZbGu4TO2BRa5t00+vkVspRE4O63K/vDwCTVV6OXghhciRUU
	LpJiJg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgsj2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:15:47 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53B6Fk5L014005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 06:15:46 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 23:15:44 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v2 2/2] wifi: ath12k: correctly handle mcast packets for clients
Date: Fri, 11 Apr 2025 11:45:23 +0530
Message-ID: <20250411061523.859387-3-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411061523.859387-1-quic_sarishar@quicinc.com>
References: <20250411061523.859387-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f8b393 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=-3Xz3DnQPR30XhPCzLgA:9 a=RVmHIydaz68A:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DRm42iw7yWlZ0hPhthSH2J7dBhrMGPC6
X-Proofpoint-GUID: DRm42iw7yWlZ0hPhthSH2J7dBhrMGPC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=853 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110043

Currently, RX is_mcbc bit is set for packest send from client as
destination address (DA) is multicast/broadcast address, but packets
are actually unicast as receiver address (RA) is not multicast address.
Hence, packets are not handled properly due to this is_mcbc bit.

Therefore, reset the is_mcbc bit if interface type is AP.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 5 +++++
 drivers/net/wireless/ath/ath12k/peer.c  | 5 ++++-
 drivers/net/wireless/ath/ath12k/peer.h  | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index cffff66c5ec4..308d9656b57e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2269,6 +2269,11 @@ static void ath12k_dp_rx_h_mpdu(struct ath12k *ar,
 	spin_lock_bh(&ar->ab->base_lock);
 	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu);
 	if (peer) {
+		/* resetting mcbc bit because mcbc packets are unicast
+		 * packets only for AP as STA sends unicast packets.
+		 */
+		rxcb->is_mcbc = rxcb->is_mcbc && !peer->ucast_ra_only;
+
 		if (rxcb->is_mcbc)
 			enctype = peer->sec_type_grp;
 		else
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 792cca8a3fb1..ec7236bbccc0 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
@@ -383,6 +383,9 @@ int ath12k_peer_create(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		arvif->ast_idx = peer->hw_peer_id;
 	}
 
+	if (vif->type == NL80211_IFTYPE_AP)
+		peer->ucast_ra_only = true;
+
 	if (sta) {
 		ahsta = ath12k_sta_to_ahsta(sta);
 		arsta = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index 5870ee11a8c7..f3a5e054d2b5 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_PEER_H
@@ -62,6 +62,7 @@ struct ath12k_peer {
 
 	/* for reference to ath12k_link_sta */
 	u8 link_id;
+	bool ucast_ra_only;
 };
 
 struct ath12k_ml_peer {
-- 
2.34.1



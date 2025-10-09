Return-Path: <linux-wireless+bounces-27916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C1BC8B7A
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445D83B57C3
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ABC2DF154;
	Thu,  9 Oct 2025 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J1K+cqiY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD52E091C
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008291; cv=none; b=mrIxlD9Qc0H5j6xcNJeVlkxxbR2E4Zp7ULoEEe5nnI3vUilCZHUMsBU7OibeEhCDEhQ5SCGWl09AHgHSUuFD7XKzV4Hkr8QK1XG6lYBMW//G1KmCZFkdxSXbKMAyUqcMB3txn3AN0LHohdqkTQar5cL2x6AgXDf/B3uup26LjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008291; c=relaxed/simple;
	bh=99tk41XWFQOA497PWUEgOO8Mwh/GrLo+jxGwt0CN1l4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nG3+jAWJeVQTJ0mQPU8r9sf5BKFeiBonwWdTQDf6lw548KfG+R57qlx2uH3k6gmFJbPQt0CdlwWHG9aZlR7g65HP6qW37AM0sQlDQnOrvxXcNPhwIBF8Qaocn8OtM+stkcBT8v9FVOwoym78E7N2Xwd1p/mM7M9leR3D1tJtMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J1K+cqiY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EHlP004359;
	Thu, 9 Oct 2025 11:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lvsn5ZVN4q3ql68fpDhFl9ni3smzBZ8bJBJCUmneQrc=; b=J1K+cqiYSXBrH0fM
	9VTyTiS8FV7v8STjOTYccFb5CtSJC+ni0LSnNA8Zc0zJZ8Om6LY5Jra1nlY2kgM4
	2oEARtnsE2Z6OWyQUMvX+xEc4xB2KGHm01TWj6SeQLkm4m89zKz+fBTcgkzswCid
	gO1p8h5McbsJEyUeK+qB/LMMXobbcCnL8cR9KuOT9LCFXemZON9FWIee/p9IR6kX
	AzLgMPUOOAvd4GzucxQ3svms0sURzYVo27DXvPt17/ZtsBFbzIXNDVkAwgehk4Ro
	GAZOJcVrTtxHdyhMDxPRA6QhTR+zUOwTsfo/uEbbdqND51qps9LiBIm/DeOF7mYB
	hL4oiA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j2h4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 11:11:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599BBNJx011649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 11:11:24 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 04:11:22 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 15/18] wifi: ath12k: Segregate the common and wifi7 specific structures
Date: Thu, 9 Oct 2025 16:40:42 +0530
Message-ID: <20251009111045.1763001-16-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-GUID: g4ZCM7QHl3zU7sHdjvL2uIUh52T_6mCl
X-Proofpoint-ORIG-GUID: g4ZCM7QHl3zU7sHdjvL2uIUh52T_6mCl
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e7985c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=MZDez8V6H3QHhjYZ4AcA:9
 a=mZlv2jP704L7Acqj:21 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX8+z9IndmuJ27
 MYilNSrFXwCsbcl2y3g+2NbYP8ZBB3W5mOZPpOqgRfXPX0kgQfQybFRt9rFvTprscMrfMLck2Jp
 pGylizbOnWtUeouV7vkuBLxWwidN3hSS0dJT5oePCQYX9uo9+SdlaR/FooSMNOV4Gkxnnaq5HHf
 7zQyjCq8KbS3gW9a+O4IJjiW4hLCMQqHQXjgOCBR8DYAPaFrSSxQdnyV/jFQAFIOieKmClXIKgB
 hXWYaAq76rXA1sqU6dE+dcRS/soM0PGkDVjl7VjempnlNEUjccCZ+yDKCTe+FFPSKm6hvk9xq0a
 EiNTdpomwdE/J75CkwFthlE8YcbUCjVshnMaIKtMnCj0Kmp/3pfES1Ti/uAF2RzzhHuWdFOxJra
 oBA+QgUp2PBmY7ldBkFw3ShFgL8gZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Segregate the common and wifi7 specific structures in hal,
and move them to corresponding header files.

hal.h file in common directory is used by both common
and wifi7 directory files, while hal.h and other hal headers
are used only by files within the wifi7 directory since
these headers contain hw specific hal data.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/cmn_defs.h    |   1 +
 drivers/net/wireless/ath/ath12k/core.h        |   2 +-
 drivers/net/wireless/ath/ath12k/dbring.c      |   1 +
 drivers/net/wireless/ath/ath12k/debugfs.c     |   2 +-
 drivers/net/wireless/ath/ath12k/dp.c          |  54 +-
 drivers/net/wireless/ath/ath12k/dp.h          |  14 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h      |   1 +
 drivers/net/wireless/ath/ath12k/dp_rx.c       |   2 -
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   1 -
 drivers/net/wireless/ath/ath12k/dp_tx.h       |   1 -
 drivers/net/wireless/ath/ath12k/hal.c         |   5 -
 drivers/net/wireless/ath/ath12k/hal.h         | 609 +++---------------
 drivers/net/wireless/ath/ath12k/pci.c         |   2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c    |   1 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   3 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  52 ++
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   2 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.c   |   2 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal.h   | 512 +++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |  80 ---
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |   1 +
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |   1 +
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   4 +
 .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   2 +-
 .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |   2 +-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |   1 +
 drivers/net/wireless/ath/ath12k/wifi7/pci.c   |   1 +
 27 files changed, 695 insertions(+), 664 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/cmn_defs.h b/drivers/net/wireless/ath/ath12k/cmn_defs.h
index 1a531357271b..20208ffea1c9 100644
--- a/drivers/net/wireless/ath/ath12k/cmn_defs.h
+++ b/drivers/net/wireless/ath/ath12k/cmn_defs.h
@@ -16,4 +16,5 @@
 /* Define 1 scan link for each radio for parallel scan purposes */
 #define ATH12K_NUM_MAX_LINKS (IEEE80211_MLD_MAX_NUM_LINKS + ATH12K_SCAN_MAX_LINKS)
 
+#define MAX_MU_GROUP_ID 64
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 6764d81d0334..2bbe543bcf13 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -26,7 +26,7 @@
 #include "ce.h"
 #include "mac.h"
 #include "hw.h"
-#include "wifi7/hal_rx.h"
+#include "wifi7/hal_desc.h"
 #include "reg.h"
 #include "dbring.h"
 #include "fw.h"
diff --git a/drivers/net/wireless/ath/ath12k/dbring.c b/drivers/net/wireless/ath/ath12k/dbring.c
index a387cb9554d2..f71ec2a58469 100644
--- a/drivers/net/wireless/ath/ath12k/dbring.c
+++ b/drivers/net/wireless/ath/ath12k/dbring.c
@@ -6,6 +6,7 @@
 
 #include "core.h"
 #include "debug.h"
+#include "hal.h"
 
 static int ath12k_dbring_bufs_replenish(struct ath12k *ar,
 					struct ath12k_dbring *ring,
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 44c2402d70ca..5af7f27e2d8d 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -967,7 +967,7 @@ static int ath12k_open_link_stats(struct inode *inode, struct file *file)
 				 "\nlink[%d] Tx Frame descriptor Encrypt Type = ",
 				 link_id);
 
-		for (i = 0; i < HAL_ENCRYPT_TYPE_MAX; i++) {
+		for (i = 0; i < DP_ENCRYPT_TYPE_MAX; i++) {
 			len += scnprintf(buf + len, buf_len - len,
 					 " %d:%d", i,
 					 linkstat.tx_encrypt_type[i]);
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 0f02924ecdeb..98a1c879605a 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -7,8 +7,8 @@
 #include <crypto/hash.h>
 #include "core.h"
 #include "dp_tx.h"
-#include "wifi7/hal_tx.h"
 #include "hif.h"
+#include "hal.h"
 #include "debug.h"
 #include "wifi7/dp_rx.h"
 #include "peer.h"
@@ -333,56 +333,6 @@ int ath12k_dp_srng_setup(struct ath12k_base *ab, struct dp_srng *ring,
 	return 0;
 }
 
-static
-u32 ath12k_dp_tx_get_vdev_bank_config(struct ath12k_base *ab,
-				      struct ath12k_link_vif *arvif)
-{
-	u32 bank_config = 0;
-	u8 link_id = arvif->link_id;
-	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ath12k_dp_vif *dp_vif = &ahvif->dp_vif;
-	struct ath12k_dp_link_vif *dp_link_vif;
-
-	dp_link_vif = ath12k_dp_vif_to_dp_link_vif(dp_vif, link_id);
-
-	/* Only valid for raw frames with HW crypto enabled.
-	 * With SW crypto, mac80211 sets key per packet
-	 */
-	if (dp_vif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
-	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
-		bank_config |=
-			u32_encode_bits(ath12k_dp_tx_get_encrypt_type(dp_vif->key_cipher),
-					HAL_TX_BANK_CONFIG_ENCRYPT_TYPE);
-
-	bank_config |= u32_encode_bits(dp_vif->tx_encap_type,
-					HAL_TX_BANK_CONFIG_ENCAP_TYPE);
-	bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_SRC_BUFFER_SWAP) |
-			u32_encode_bits(0, HAL_TX_BANK_CONFIG_LINK_META_SWAP) |
-			u32_encode_bits(0, HAL_TX_BANK_CONFIG_EPD);
-
-	/* only valid if idx_lookup_override is not set in tcl_data_cmd */
-	if (ahvif->vdev_type == WMI_VDEV_TYPE_STA)
-		bank_config |= u32_encode_bits(1, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
-	else
-		bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
-
-	bank_config |= u32_encode_bits(dp_link_vif->hal_addr_search_flags &
-				       HAL_TX_ADDRX_EN,
-				       HAL_TX_BANK_CONFIG_ADDRX_EN) |
-			u32_encode_bits(!!(dp_link_vif->hal_addr_search_flags &
-					HAL_TX_ADDRY_EN),
-					HAL_TX_BANK_CONFIG_ADDRY_EN);
-
-	bank_config |= u32_encode_bits(ieee80211_vif_is_mesh(ahvif->vif) ? 3 : 0,
-					HAL_TX_BANK_CONFIG_MESH_EN) |
-			u32_encode_bits(dp_link_vif->vdev_id_check_en,
-					HAL_TX_BANK_CONFIG_VDEV_ID_CHECK_EN);
-
-	bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_DSCP_TIP_MAP_ID);
-
-	return bank_config;
-}
-
 static int ath12k_dp_tx_get_bank_profile(struct ath12k_base *ab,
 					 struct ath12k_link_vif *arvif,
 					 struct ath12k_dp *dp)
@@ -393,7 +343,7 @@ static int ath12k_dp_tx_get_bank_profile(struct ath12k_base *ab,
 	bool configure_register = false;
 
 	/* convert vdev params into hal_tx_bank_config */
-	bank_config = ath12k_dp_tx_get_vdev_bank_config(ab, arvif);
+	bank_config = dp->ops->dp_tx_get_vdev_bank_config(ab, arvif);
 
 	spin_lock_bh(&dp->tx_bank_lock);
 	/* TODO: implement using idr kernel framework*/
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 2655b4d96f43..8e7e4a7b582b 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -7,8 +7,6 @@
 #ifndef ATH12K_DP_H
 #define ATH12K_DP_H
 
-#include "wifi7/hal_desc.h"
-#include "wifi7/hal_rx.h"
 #include "hw.h"
 #include "dp_htt.h"
 #include "dp_cmn.h"
@@ -26,6 +24,10 @@ struct ath12k_ext_irq_grp;
 #define DP_MON_PURGE_TIMEOUT_MS     100
 #define DP_MON_SERVICE_BUDGET       128
 
+#define DP_ENCAP_TYPE_MAX	4
+#define DP_ENCRYPT_TYPE_MAX	12
+#define DP_DESC_TYPE_MAX	2
+
 struct dp_srng {
 	u32 *vaddr_unaligned;
 	u32 *vaddr;
@@ -373,9 +375,9 @@ struct ath12k_link_stats {
 	u32 tx_completed;
 	u32 tx_bcast_mcast;
 	u32 tx_dropped;
-	u32 tx_encap_type[HAL_TCL_ENCAP_TYPE_MAX];
-	u32 tx_encrypt_type[HAL_ENCRYPT_TYPE_MAX];
-	u32 tx_desc_type[HAL_TCL_DESC_TYPE_MAX];
+	u32 tx_encap_type[DP_ENCAP_TYPE_MAX];
+	u32 tx_encrypt_type[DP_ENCRYPT_TYPE_MAX];
+	u32 tx_desc_type[DP_DESC_TYPE_MAX];
 };
 
 /* DP arch ops to communicate from common module
@@ -385,6 +387,8 @@ struct ath12k_dp_arch_ops {
 	int (*service_srng)(struct ath12k_dp *dp,
 			    struct ath12k_ext_irq_grp *irq_grp,
 			    int budget);
+	u32 (*dp_tx_get_vdev_bank_config)(struct ath12k_base *ab,
+					  struct ath12k_link_vif *arvif);
 };
 
 struct ath12k_dp {
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 068df7400345..6110227a40dd 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -8,6 +8,7 @@
 #define ATH12K_DP_MON_H
 
 #include "core.h"
+#include "wifi7/hal_desc.h"
 
 #define ATH12K_MON_RX_DOT11_OFFSET	5
 #define ATH12K_MON_RX_PKT_OFFSET	8
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 424cf1d4a1fc..8e342ad4d678 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -10,11 +10,9 @@
 #include <crypto/hash.h>
 #include "core.h"
 #include "debug.h"
-#include "wifi7/hal_desc.h"
 #include "hw.h"
 #include "dp_rx.h"
 #include "wifi7/dp_rx.h"
-#include "wifi7/hal_rx.h"
 #include "dp_tx.h"
 #include "peer.h"
 #include "dp_mon.h"
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 0ecb96bc9054..327bf99afae2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -8,7 +8,6 @@
 
 #include <crypto/hash.h>
 #include "core.h"
-#include "wifi7/hal_rx_desc.h"
 #include "debug.h"
 
 #define DP_MAX_NWIFI_HDR_LEN	30
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
index 5b8fe280c32a..147409f9ac40 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -8,7 +8,6 @@
 #define ATH12K_DP_TX_H
 
 #include "core.h"
-#include "wifi7/hal_tx.h"
 
 struct ath12k_dp_htt_wbm_tx_status {
 	bool acked;
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 528138a1dc18..296bd7824ae2 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -4,13 +4,8 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/dma-mapping.h>
-#include "wifi7/hal_tx.h"
-#include "wifi7/hal_rx.h"
 #include "debug.h"
-#include "wifi7/hal_desc.h"
 #include "hif.h"
-#include "wifi7/hal_qcn9274.h"
-#include "wifi7/hal_wcn7850.h"
 
 static void ath12k_hal_ce_dst_setup(struct ath12k_base *ab,
 				    struct hal_srng *srng, int ring_num)
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 0de5e1aa6405..63ad67318b0e 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -7,8 +7,7 @@
 #ifndef ATH12K_HAL_H
 #define ATH12K_HAL_H
 
-#include "wifi7/hal_desc.h"
-#include "wifi7/hal_rx_desc.h"
+#include "hw.h"
 
 struct ath12k_base;
 
@@ -26,6 +25,10 @@ struct ath12k_base;
 #define HAL_RX_MAX_MPDU		256
 #define HAL_RX_NUM_WORDS_PER_PPDU_BITMAP	(HAL_RX_MAX_MPDU >> 5)
 
+/* TODO: 16 entries per radio times MAX_VAPS_SUPPORTED */
+#define HAL_DSCP_TID_MAP_TBL_NUM_ENTRIES_MAX	32
+#define HAL_DSCP_TID_TBL_SIZE			24
+
 #define EHT_MAX_USER_INFO	4
 #define HAL_RX_MON_MAX_AGGR_SIZE	128
 #define HAL_MAX_UL_MU_USERS	37
@@ -48,366 +51,19 @@ struct ath12k_base;
 #define HAL_RING_BASE_ALIGN	8
 #define HAL_REO_QLUT_ADDR_ALIGN 256
 
+#define HAL_ADDR_LSB_REG_MASK		0xffffffff
+#define HAL_ADDR_MSB_REG_SHIFT		32
+
+#define HAL_WBM2SW_REL_ERR_RING_NUM 3
+
+#define HAL_SHADOW_NUM_REGS_MAX	40
+
 #define HAL_WBM_IDLE_SCATTER_BUF_SIZE_MAX	32704
 /* TODO: Check with hw team on the supported scatter buf size */
 #define HAL_WBM_IDLE_SCATTER_NEXT_PTR_SIZE	8
 #define HAL_WBM_IDLE_SCATTER_BUF_SIZE (HAL_WBM_IDLE_SCATTER_BUF_SIZE_MAX - \
 				       HAL_WBM_IDLE_SCATTER_NEXT_PTR_SIZE)
 
-/* TODO: 16 entries per radio times MAX_VAPS_SUPPORTED */
-#define HAL_DSCP_TID_MAP_TBL_NUM_ENTRIES_MAX	32
-#define HAL_DSCP_TID_TBL_SIZE			24
-
-/* calculate the register address from bar0 of shadow register x */
-#define HAL_SHADOW_BASE_ADDR			0x000008fc
-#define HAL_SHADOW_NUM_REGS			40
-#define HAL_HP_OFFSET_IN_REG_START		1
-#define HAL_OFFSET_FROM_HP_TO_TP		4
-
-#define HAL_SHADOW_REG(x) (HAL_SHADOW_BASE_ADDR + (4 * (x)))
-#define HAL_REO_QDESC_MAX_PEERID		8191
-
-/* WCSS Relative address */
-#define HAL_SEQ_WCSS_CMEM_OFFSET		0x00100000
-#define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
-#define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
-#define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
-#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal) \
-	((hal)->regs->hal_umac_ce0_src_reg_base)
-#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) \
-	((hal)->regs->hal_umac_ce0_dest_reg_base)
-#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(hal) \
-	((hal)->regs->hal_umac_ce1_src_reg_base)
-#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) \
-	((hal)->regs->hal_umac_ce1_dest_reg_base)
-#define HAL_SEQ_WCSS_UMAC_WBM_REG		0x00a34000
-
-#define HAL_CE_WFSS_CE_REG_BASE			0x01b80000
-
-#define HAL_TCL_SW_CONFIG_BANK_ADDR		0x00a4408c
-
-/* SW2TCL(x) R0 ring configuration address */
-#define HAL_TCL1_RING_CMN_CTRL_REG		0x00000020
-#define HAL_TCL1_RING_DSCP_TID_MAP		0x00000240
-
-#define HAL_TCL1_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_tcl1_ring_base_lsb)
-#define HAL_TCL1_RING_BASE_MSB(hal) \
-	((hal)->regs->hal_tcl1_ring_base_msb)
-#define HAL_TCL1_RING_ID(hal)		((hal)->regs->hal_tcl1_ring_id)
-#define HAL_TCL1_RING_MISC(hal) \
-	((hal)->regs->hal_tcl1_ring_misc)
-#define HAL_TCL1_RING_TP_ADDR_LSB(hal) \
-	((hal)->regs->hal_tcl1_ring_tp_addr_lsb)
-#define HAL_TCL1_RING_TP_ADDR_MSB(hal) \
-	((hal)->regs->hal_tcl1_ring_tp_addr_msb)
-#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(hal) \
-	((hal)->regs->hal_tcl1_ring_consumer_int_setup_ix0)
-#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(hal) \
-	((hal)->regs->hal_tcl1_ring_consumer_int_setup_ix1)
-#define HAL_TCL1_RING_MSI1_BASE_LSB(hal) \
-	((hal)->regs->hal_tcl1_ring_msi1_base_lsb)
-#define HAL_TCL1_RING_MSI1_BASE_MSB(hal) \
-	((hal)->regs->hal_tcl1_ring_msi1_base_msb)
-#define HAL_TCL1_RING_MSI1_DATA(hal) \
-	((hal)->regs->hal_tcl1_ring_msi1_data)
-#define HAL_TCL2_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_tcl2_ring_base_lsb)
-#define HAL_TCL_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_tcl_ring_base_lsb)
-
-#define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
-	(HAL_TCL1_RING_MSI1_BASE_LSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
-#define HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(hal)	({ typeof(hal) _hal = (hal); \
-	(HAL_TCL1_RING_MSI1_BASE_MSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
-#define HAL_TCL1_RING_MSI1_DATA_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
-	(HAL_TCL1_RING_MSI1_DATA(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
-#define HAL_TCL1_RING_BASE_MSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
-	(HAL_TCL1_RING_BASE_MSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
-#define HAL_TCL1_RING_ID_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
-	(HAL_TCL1_RING_ID(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
-	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
-	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
-#define HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
-	(HAL_TCL1_RING_TP_ADDR_LSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
-#define HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
-	(HAL_TCL1_RING_TP_ADDR_MSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
-#define HAL_TCL1_RING_MISC_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
-	(HAL_TCL1_RING_MISC(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
-
-/* SW2TCL(x) R2 ring pointers (head/tail) address */
-#define HAL_TCL1_RING_HP			0x00002000
-#define HAL_TCL1_RING_TP			0x00002004
-#define HAL_TCL2_RING_HP			0x00002008
-#define HAL_TCL_RING_HP				0x00002028
-
-#define HAL_TCL1_RING_TP_OFFSET \
-		(HAL_TCL1_RING_TP - HAL_TCL1_RING_HP)
-
-/* TCL STATUS ring address */
-#define HAL_TCL_STATUS_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_tcl_status_ring_base_lsb)
-#define HAL_TCL_STATUS_RING_HP			0x00002048
-
-/* PPE2TCL1 Ring address */
-#define HAL_TCL_PPE2TCL1_RING_BASE_LSB		0x00000c48
-#define HAL_TCL_PPE2TCL1_RING_HP		0x00002038
-
-/* WBM PPE Release Ring address */
-#define HAL_WBM_PPE_RELEASE_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_ppe_rel_ring_base)
-#define HAL_WBM_PPE_RELEASE_RING_HP		0x00003020
-
-/* REO2SW(x) R0 ring configuration address */
-#define HAL_REO1_GEN_ENABLE			0x00000000
-#define HAL_REO1_MISC_CTRL_ADDR(hal) \
-	((hal)->regs->hal_reo1_misc_ctrl_addr)
-#define HAL_REO1_DEST_RING_CTRL_IX_0		0x00000004
-#define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
-#define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
-#define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
-#define HAL_REO1_QDESC_ADDR(hal)		((hal)->regs->hal_reo1_qdesc_addr)
-#define HAL_REO1_QDESC_MAX_PEERID(hal)	((hal)->regs->hal_reo1_qdesc_max_peerid)
-#define HAL_REO1_SW_COOKIE_CFG0(hal)	((hal)->regs->hal_reo1_sw_cookie_cfg0)
-#define HAL_REO1_SW_COOKIE_CFG1(hal)	((hal)->regs->hal_reo1_sw_cookie_cfg1)
-#define HAL_REO1_QDESC_LUT_BASE0(hal)	((hal)->regs->hal_reo1_qdesc_lut_base0)
-#define HAL_REO1_QDESC_LUT_BASE1(hal)	((hal)->regs->hal_reo1_qdesc_lut_base1)
-#define HAL_REO1_RING_BASE_LSB(hal)	((hal)->regs->hal_reo1_ring_base_lsb)
-#define HAL_REO1_RING_BASE_MSB(hal)	((hal)->regs->hal_reo1_ring_base_msb)
-#define HAL_REO1_RING_ID(hal)		((hal)->regs->hal_reo1_ring_id)
-#define HAL_REO1_RING_MISC(hal)		((hal)->regs->hal_reo1_ring_misc)
-#define HAL_REO1_RING_HP_ADDR_LSB(hal)	((hal)->regs->hal_reo1_ring_hp_addr_lsb)
-#define HAL_REO1_RING_HP_ADDR_MSB(hal)	((hal)->regs->hal_reo1_ring_hp_addr_msb)
-#define HAL_REO1_RING_PRODUCER_INT_SETUP(hal) \
-	((hal)->regs->hal_reo1_ring_producer_int_setup)
-#define HAL_REO1_RING_MSI1_BASE_LSB(hal)	\
-	((hal)->regs->hal_reo1_ring_msi1_base_lsb)
-#define HAL_REO1_RING_MSI1_BASE_MSB(hal)	\
-	((hal)->regs->hal_reo1_ring_msi1_base_msb)
-#define HAL_REO1_RING_MSI1_DATA(hal)	((hal)->regs->hal_reo1_ring_msi1_data)
-#define HAL_REO2_RING_BASE_LSB(hal)	((hal)->regs->hal_reo2_ring_base)
-#define HAL_REO1_AGING_THRESH_IX_0(hal)	((hal)->regs->hal_reo1_aging_thres_ix0)
-#define HAL_REO1_AGING_THRESH_IX_1(hal)	((hal)->regs->hal_reo1_aging_thres_ix1)
-#define HAL_REO1_AGING_THRESH_IX_2(hal)	((hal)->regs->hal_reo1_aging_thres_ix2)
-#define HAL_REO1_AGING_THRESH_IX_3(hal)	((hal)->regs->hal_reo1_aging_thres_ix3)
-
-/* REO2SW(x) R2 ring pointers (head/tail) address */
-#define HAL_REO1_RING_HP			0x00003048
-#define HAL_REO1_RING_TP			0x0000304c
-#define HAL_REO2_RING_HP			0x00003050
-
-#define HAL_REO1_RING_TP_OFFSET			(HAL_REO1_RING_TP - HAL_REO1_RING_HP)
-
-/* REO2SW0 ring configuration address */
-#define HAL_REO_SW0_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_reo2_sw0_ring_base)
-
-/* REO2SW0 R2 ring pointer (head/tail) address */
-#define HAL_REO_SW0_RING_HP			0x00003088
-
-/* REO CMD R0 address */
-#define HAL_REO_CMD_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_reo_cmd_ring_base)
-
-/* REO CMD R2 address */
-#define HAL_REO_CMD_HP				0x00003020
-
-/* SW2REO R0 address */
-#define	HAL_SW2REO_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_sw2reo_ring_base)
-#define HAL_SW2REO1_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_sw2reo1_ring_base)
-
-/* SW2REO R2 address */
-#define HAL_SW2REO_RING_HP			0x00003028
-#define HAL_SW2REO1_RING_HP			0x00003030
-
-/* CE ring R0 address */
-#define HAL_CE_SRC_RING_BASE_LSB                0x00000000
-#define HAL_CE_DST_RING_BASE_LSB		0x00000000
-#define HAL_CE_DST_STATUS_RING_BASE_LSB		0x00000058
-#define HAL_CE_DST_RING_CTRL			0x000000b0
-
-/* CE ring R2 address */
-#define HAL_CE_DST_RING_HP			0x00000400
-#define HAL_CE_DST_STATUS_RING_HP		0x00000408
-
-/* REO status address */
-#define HAL_REO_STATUS_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_reo_status_ring_base)
-#define HAL_REO_STATUS_HP			0x000030a8
-
-/* WBM Idle R0 address */
-#define HAL_WBM_IDLE_LINK_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm_idle_ring_base_lsb)
-#define HAL_WBM_IDLE_LINK_RING_MISC_ADDR(hal) \
-	((hal)->regs->hal_wbm_idle_ring_misc_addr)
-#define HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR(hal) \
-	((hal)->regs->hal_wbm_r0_idle_list_cntl_addr)
-#define HAL_WBM_R0_IDLE_LIST_SIZE_ADDR(hal) \
-	((hal)->regs->hal_wbm_r0_idle_list_size_addr)
-#define HAL_WBM_SCATTERED_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm_scattered_ring_base_lsb)
-#define HAL_WBM_SCATTERED_RING_BASE_MSB(hal) \
-	((hal)->regs->hal_wbm_scattered_ring_base_msb)
-#define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(hal) \
-	((hal)->regs->hal_wbm_scattered_desc_head_info_ix0)
-#define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1(hal) \
-	((hal)->regs->hal_wbm_scattered_desc_head_info_ix1)
-#define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0(hal) \
-	((hal)->regs->hal_wbm_scattered_desc_tail_info_ix0)
-#define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1(hal) \
-	((hal)->regs->hal_wbm_scattered_desc_tail_info_ix1)
-#define HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR(hal) \
-	((hal)->regs->hal_wbm_scattered_desc_ptr_hp_addr)
-
-/* WBM Idle R2 address */
-#define HAL_WBM_IDLE_LINK_RING_HP		0x000030b8
-
-/* SW2WBM R0 release address */
-#define HAL_WBM_SW_RELEASE_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm_sw_release_ring_base_lsb)
-#define HAL_WBM_SW1_RELEASE_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm_sw1_release_ring_base_lsb)
-
-/* SW2WBM R2 release address */
-#define HAL_WBM_SW_RELEASE_RING_HP		0x00003010
-#define HAL_WBM_SW1_RELEASE_RING_HP		0x00003018
-
-/* WBM2SW R0 release address */
-#define HAL_WBM0_RELEASE_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm0_release_ring_base_lsb)
-
-#define HAL_WBM1_RELEASE_RING_BASE_LSB(hal) \
-	((hal)->regs->hal_wbm1_release_ring_base_lsb)
-
-/* WBM2SW R2 release address */
-#define HAL_WBM0_RELEASE_RING_HP		0x000030c8
-#define HAL_WBM1_RELEASE_RING_HP		0x000030d0
-
-/* WBM cookie config address and mask */
-#define HAL_WBM_SW_COOKIE_CFG0			0x00000040
-#define HAL_WBM_SW_COOKIE_CFG1			0x00000044
-#define HAL_WBM_SW_COOKIE_CFG2			0x00000090
-#define HAL_WBM_SW_COOKIE_CONVERT_CFG		0x00000094
-
-#define HAL_WBM_SW_COOKIE_CFG_CMEM_BASE_ADDR_MSB	GENMASK(7, 0)
-#define HAL_WBM_SW_COOKIE_CFG_COOKIE_PPT_MSB		GENMASK(12, 8)
-#define HAL_WBM_SW_COOKIE_CFG_COOKIE_SPT_MSB		GENMASK(17, 13)
-#define HAL_WBM_SW_COOKIE_CFG_ALIGN			BIT(18)
-#define HAL_WBM_SW_COOKIE_CFG_RELEASE_PATH_EN		BIT(0)
-#define HAL_WBM_SW_COOKIE_CFG_ERR_PATH_EN		BIT(1)
-#define HAL_WBM_SW_COOKIE_CFG_CONV_IND_EN		BIT(3)
-
-#define HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN		BIT(1)
-#define HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW1_EN		BIT(2)
-#define HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN		BIT(3)
-#define HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW3_EN		BIT(4)
-#define HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN		BIT(5)
-#define HAL_WBM_SW_COOKIE_CONV_CFG_GLOBAL_EN		BIT(8)
-
-/* TCL ring field mask and offset */
-#define HAL_TCL1_RING_BASE_MSB_RING_SIZE		GENMASK(27, 8)
-#define HAL_TCL1_RING_BASE_MSB_RING_BASE_ADDR_MSB	GENMASK(7, 0)
-#define HAL_TCL1_RING_ID_ENTRY_SIZE			GENMASK(7, 0)
-#define HAL_TCL1_RING_MISC_MSI_RING_ID_DISABLE		BIT(0)
-#define HAL_TCL1_RING_MISC_MSI_LOOPCNT_DISABLE		BIT(1)
-#define HAL_TCL1_RING_MISC_MSI_SWAP			BIT(3)
-#define HAL_TCL1_RING_MISC_HOST_FW_SWAP			BIT(4)
-#define HAL_TCL1_RING_MISC_DATA_TLV_SWAP		BIT(5)
-#define HAL_TCL1_RING_MISC_SRNG_ENABLE			BIT(6)
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_INTR_TMR_THOLD   GENMASK(31, 16)
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_BATCH_COUNTER_THOLD GENMASK(14, 0)
-#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_LOW_THOLD	GENMASK(15, 0)
-#define HAL_TCL1_RING_MSI1_BASE_MSB_MSI1_ENABLE		BIT(8)
-#define HAL_TCL1_RING_MSI1_BASE_MSB_ADDR		GENMASK(7, 0)
-#define HAL_TCL1_RING_CMN_CTRL_DSCP_TID_MAP_PROG_EN	BIT(23)
-#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP		GENMASK(31, 0)
-#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP0		GENMASK(2, 0)
-#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP1		GENMASK(5, 3)
-#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP2		GENMASK(8, 6)
-#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP3		GENMASK(11, 9)
-#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP4		GENMASK(14, 12)
-#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP5		GENMASK(17, 15)
-#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP6		GENMASK(20, 18)
-#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP7		GENMASK(23, 21)
-
-/* REO ring field mask and offset */
-#define HAL_REO1_RING_BASE_MSB_RING_SIZE		GENMASK(27, 8)
-#define HAL_REO1_RING_BASE_MSB_RING_BASE_ADDR_MSB	GENMASK(7, 0)
-#define HAL_REO1_RING_ID_RING_ID			GENMASK(15, 8)
-#define HAL_REO1_RING_ID_ENTRY_SIZE			GENMASK(7, 0)
-#define HAL_REO1_RING_MISC_MSI_SWAP			BIT(3)
-#define HAL_REO1_RING_MISC_HOST_FW_SWAP			BIT(4)
-#define HAL_REO1_RING_MISC_DATA_TLV_SWAP		BIT(5)
-#define HAL_REO1_RING_MISC_SRNG_ENABLE			BIT(6)
-#define HAL_REO1_RING_PRDR_INT_SETUP_INTR_TMR_THOLD	GENMASK(31, 16)
-#define HAL_REO1_RING_PRDR_INT_SETUP_BATCH_COUNTER_THOLD GENMASK(14, 0)
-#define HAL_REO1_RING_MSI1_BASE_MSB_MSI1_ENABLE		BIT(8)
-#define HAL_REO1_RING_MSI1_BASE_MSB_ADDR		GENMASK(7, 0)
-#define HAL_REO1_MISC_CTL_FRAG_DST_RING			GENMASK(20, 17)
-#define HAL_REO1_MISC_CTL_BAR_DST_RING			GENMASK(24, 21)
-#define HAL_REO1_GEN_ENABLE_AGING_LIST_ENABLE		BIT(2)
-#define HAL_REO1_GEN_ENABLE_AGING_FLUSH_ENABLE		BIT(3)
-#define HAL_REO1_SW_COOKIE_CFG_CMEM_BASE_ADDR_MSB	GENMASK(7, 0)
-#define HAL_REO1_SW_COOKIE_CFG_COOKIE_PPT_MSB		GENMASK(12, 8)
-#define HAL_REO1_SW_COOKIE_CFG_COOKIE_SPT_MSB		GENMASK(17, 13)
-#define HAL_REO1_SW_COOKIE_CFG_ALIGN			BIT(18)
-#define HAL_REO1_SW_COOKIE_CFG_ENABLE			BIT(19)
-#define HAL_REO1_SW_COOKIE_CFG_GLOBAL_ENABLE		BIT(20)
-#define HAL_REO_QDESC_ADDR_READ_LUT_ENABLE		BIT(7)
-#define HAL_REO_QDESC_ADDR_READ_CLEAR_QDESC_ARRAY	BIT(6)
-
-/* CE ring bit field mask and shift */
-#define HAL_CE_DST_R0_DEST_CTRL_MAX_LEN			GENMASK(15, 0)
-
-#define HAL_ADDR_LSB_REG_MASK				0xffffffff
-
-#define HAL_ADDR_MSB_REG_SHIFT				32
-
-/* WBM ring bit field mask and shift */
-#define HAL_WBM_LINK_DESC_IDLE_LIST_MODE		BIT(1)
-#define HAL_WBM_SCATTER_BUFFER_SIZE			GENMASK(10, 2)
-#define HAL_WBM_SCATTER_RING_SIZE_OF_IDLE_LINK_DESC_LIST GENMASK(31, 16)
-#define HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32	GENMASK(7, 0)
-#define HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_MATCH_TAG	GENMASK(31, 8)
-
-#define HAL_WBM_SCATTERED_DESC_HEAD_P_OFFSET_IX1	GENMASK(20, 8)
-#define HAL_WBM_SCATTERED_DESC_TAIL_P_OFFSET_IX1	GENMASK(20, 8)
-
-#define HAL_WBM_IDLE_LINK_RING_MISC_SRNG_ENABLE		BIT(6)
-#define HAL_WBM_IDLE_LINK_RING_MISC_RIND_ID_DISABLE	BIT(0)
-
-#define BASE_ADDR_MATCH_TAG_VAL 0x5
-
-#define HAL_REO_REO2SW1_RING_BASE_MSB_RING_SIZE		0x000fffff
-#define HAL_REO_REO2SW0_RING_BASE_MSB_RING_SIZE		0x000fffff
-#define HAL_REO_SW2REO_RING_BASE_MSB_RING_SIZE		0x0000ffff
-#define HAL_REO_CMD_RING_BASE_MSB_RING_SIZE		0x0000ffff
-#define HAL_REO_STATUS_RING_BASE_MSB_RING_SIZE		0x0000ffff
-#define HAL_SW2TCL1_RING_BASE_MSB_RING_SIZE		0x000fffff
-#define HAL_SW2TCL1_CMD_RING_BASE_MSB_RING_SIZE		0x000fffff
-#define HAL_TCL_STATUS_RING_BASE_MSB_RING_SIZE		0x0000ffff
-#define HAL_CE_SRC_RING_BASE_MSB_RING_SIZE		0x0000ffff
-#define HAL_CE_DST_RING_BASE_MSB_RING_SIZE		0x0000ffff
-#define HAL_CE_DST_STATUS_RING_BASE_MSB_RING_SIZE	0x0000ffff
-#define HAL_WBM_IDLE_LINK_RING_BASE_MSB_RING_SIZE	0x000fffff
-#define HAL_SW2WBM_RELEASE_RING_BASE_MSB_RING_SIZE	0x0000ffff
-#define HAL_WBM2SW_RELEASE_RING_BASE_MSB_RING_SIZE	0x000fffff
-#define HAL_RXDMA_RING_MAX_SIZE				0x0000ffff
-#define HAL_RXDMA_RING_MAX_SIZE_BE			0x000fffff
-#define HAL_WBM2PPE_RELEASE_RING_BASE_MSB_RING_SIZE	0x000fffff
-
-#define HAL_WBM2SW_REL_ERR_RING_NUM 3
-/* Add any other errors here and return them in
- * ath12k_hal_rx_desc_get_err().
- */
-
-#define HAL_IPQ5332_CE_WFSS_REG_BASE	0x740000
-#define HAL_IPQ5332_CE_SIZE		0x100000
-
 enum hal_srng_ring_id {
 	HAL_SRNG_RING_ID_REO2SW0 = 0,
 	HAL_SRNG_RING_ID_REO2SW1,
@@ -637,11 +293,6 @@ enum hal_ring_type {
 	HAL_MAX_RING_TYPES,
 };
 
-#define HAL_RX_MAX_BA_WINDOW	256
-
-#define HAL_DEFAULT_BE_BK_VI_REO_TIMEOUT_USEC	(100 * 1000)
-#define HAL_DEFAULT_VO_REO_TIMEOUT_USEC		(40 * 1000)
-
 /**
  * enum hal_reo_cmd_type: Enum for REO command type
  * @HAL_REO_CMD_GET_QUEUE_STATS: Get REO queue status/stats
@@ -1053,6 +704,90 @@ struct hal_rx_desc_data {
 	u8 tid;
 };
 
+#define BUFFER_ADDR_INFO0_ADDR         GENMASK(31, 0)
+
+#define BUFFER_ADDR_INFO1_ADDR         GENMASK(7, 0)
+#define BUFFER_ADDR_INFO1_RET_BUF_MGR  GENMASK(11, 8)
+#define BUFFER_ADDR_INFO1_SW_COOKIE    GENMASK(31, 12)
+
+struct ath12k_buffer_addr {
+	__le32 info0;
+	__le32 info1;
+} __packed;
+
+/* ath12k_buffer_addr
+ *
+ * buffer_addr_31_0
+ *		Address (lower 32 bits) of the MSDU buffer or MSDU_EXTENSION
+ *		descriptor or Link descriptor
+ *
+ * buffer_addr_39_32
+ *		Address (upper 8 bits) of the MSDU buffer or MSDU_EXTENSION
+ *		descriptor or Link descriptor
+ *
+ * return_buffer_manager (RBM)
+ *		Consumer: WBM
+ *		Producer: SW/FW
+ *		Indicates to which buffer manager the buffer or MSDU_EXTENSION
+ *		descriptor or link descriptor that is being pointed to shall be
+ *		returned after the frame has been processed. It is used by WBM
+ *		for routing purposes.
+ *
+ *		Values are defined in enum %HAL_RX_BUF_RBM_
+ *
+ * sw_buffer_cookie
+ *		Cookie field exclusively used by SW. HW ignores the contents,
+ *		accept that it passes the programmed value on to other
+ *		descriptors together with the physical address.
+ *
+ *		Field can be used by SW to for example associate the buffers
+ *		physical address with the virtual address.
+ *
+ *		NOTE1:
+ *		The three most significant bits can have a special meaning
+ *		 in case this struct is embedded in a TX_MPDU_DETAILS STRUCT,
+ *		and field transmit_bw_restriction is set
+ *
+ *		In case of NON punctured transmission:
+ *		Sw_buffer_cookie[19:17] = 3'b000: 20 MHz TX only
+ *		Sw_buffer_cookie[19:17] = 3'b001: 40 MHz TX only
+ *		Sw_buffer_cookie[19:17] = 3'b010: 80 MHz TX only
+ *		Sw_buffer_cookie[19:17] = 3'b011: 160 MHz TX only
+ *		Sw_buffer_cookie[19:17] = 3'b101: 240 MHz TX only
+ *		Sw_buffer_cookie[19:17] = 3'b100: 320 MHz TX only
+ *		Sw_buffer_cookie[19:18] = 2'b11: reserved
+ *
+ *		In case of punctured transmission:
+ *		Sw_buffer_cookie[19:16] = 4'b0000: pattern 0 only
+ *		Sw_buffer_cookie[19:16] = 4'b0001: pattern 1 only
+ *		Sw_buffer_cookie[19:16] = 4'b0010: pattern 2 only
+ *		Sw_buffer_cookie[19:16] = 4'b0011: pattern 3 only
+ *		Sw_buffer_cookie[19:16] = 4'b0100: pattern 4 only
+ *		Sw_buffer_cookie[19:16] = 4'b0101: pattern 5 only
+ *		Sw_buffer_cookie[19:16] = 4'b0110: pattern 6 only
+ *		Sw_buffer_cookie[19:16] = 4'b0111: pattern 7 only
+ *		Sw_buffer_cookie[19:16] = 4'b1000: pattern 8 only
+ *		Sw_buffer_cookie[19:16] = 4'b1001: pattern 9 only
+ *		Sw_buffer_cookie[19:16] = 4'b1010: pattern 10 only
+ *		Sw_buffer_cookie[19:16] = 4'b1011: pattern 11 only
+ *		Sw_buffer_cookie[19:18] = 2'b11: reserved
+ *
+ *		Note: a punctured transmission is indicated by the presence
+ *		 of TLV TX_PUNCTURE_SETUP embedded in the scheduler TLV
+ *
+ *		Sw_buffer_cookie[20:17]: Tid: The TID field in the QoS control
+ *		 field
+ *
+ *		Sw_buffer_cookie[16]: Mpdu_qos_control_valid: This field
+ *		 indicates MPDUs with a QoS control field.
+ *
+ */
+
+struct hal_ce_srng_dest_desc;
+struct hal_ce_srng_dst_status_desc;
+struct hal_ce_srng_src_desc;
+struct hal_wbm_link_desc;
+
 /* srng flags */
 #define HAL_SRNG_FLAGS_MSI_SWAP			0x00000008
 #define HAL_SRNG_FLAGS_RING_PTR_SWAP		0x00000010
@@ -1062,9 +797,6 @@ struct hal_rx_desc_data {
 #define HAL_SRNG_FLAGS_HIGH_THRESH_INTR_EN	0x00080000
 #define HAL_SRNG_FLAGS_LMAC_RING		0x80000000
 
-#define HAL_SRNG_TLV_HDR_TAG		GENMASK(9, 1)
-#define HAL_SRNG_TLV_HDR_LEN		GENMASK(25, 10)
-
 /* Common SRNG ring structure for source and destination rings */
 struct hal_srng {
 	/* Unique SRNG ring ID */
@@ -1249,65 +981,6 @@ enum hal_rx_buf_return_buf_manager {
 	HAL_RX_BUF_RBM_SW6_BM,
 };
 
-#define HAL_SRNG_DESC_LOOP_CNT		0xf0000000
-
-#define HAL_REO_CMD_FLG_NEED_STATUS		BIT(0)
-#define HAL_REO_CMD_FLG_STATS_CLEAR		BIT(1)
-#define HAL_REO_CMD_FLG_FLUSH_BLOCK_LATER	BIT(2)
-#define HAL_REO_CMD_FLG_FLUSH_RELEASE_BLOCKING	BIT(3)
-#define HAL_REO_CMD_FLG_FLUSH_NO_INVAL		BIT(4)
-#define HAL_REO_CMD_FLG_FLUSH_FWD_ALL_MPDUS	BIT(5)
-#define HAL_REO_CMD_FLG_FLUSH_ALL		BIT(6)
-#define HAL_REO_CMD_FLG_UNBLK_RESOURCE		BIT(7)
-#define HAL_REO_CMD_FLG_UNBLK_CACHE		BIT(8)
-
-/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO0_UPD_* fields */
-#define HAL_REO_CMD_UPD0_RX_QUEUE_NUM		BIT(8)
-#define HAL_REO_CMD_UPD0_VLD			BIT(9)
-#define HAL_REO_CMD_UPD0_ALDC			BIT(10)
-#define HAL_REO_CMD_UPD0_DIS_DUP_DETECTION	BIT(11)
-#define HAL_REO_CMD_UPD0_SOFT_REORDER_EN	BIT(12)
-#define HAL_REO_CMD_UPD0_AC			BIT(13)
-#define HAL_REO_CMD_UPD0_BAR			BIT(14)
-#define HAL_REO_CMD_UPD0_RETRY			BIT(15)
-#define HAL_REO_CMD_UPD0_CHECK_2K_MODE		BIT(16)
-#define HAL_REO_CMD_UPD0_OOR_MODE		BIT(17)
-#define HAL_REO_CMD_UPD0_BA_WINDOW_SIZE		BIT(18)
-#define HAL_REO_CMD_UPD0_PN_CHECK		BIT(19)
-#define HAL_REO_CMD_UPD0_EVEN_PN		BIT(20)
-#define HAL_REO_CMD_UPD0_UNEVEN_PN		BIT(21)
-#define HAL_REO_CMD_UPD0_PN_HANDLE_ENABLE	BIT(22)
-#define HAL_REO_CMD_UPD0_PN_SIZE		BIT(23)
-#define HAL_REO_CMD_UPD0_IGNORE_AMPDU_FLG	BIT(24)
-#define HAL_REO_CMD_UPD0_SVLD			BIT(25)
-#define HAL_REO_CMD_UPD0_SSN			BIT(26)
-#define HAL_REO_CMD_UPD0_SEQ_2K_ERR		BIT(27)
-#define HAL_REO_CMD_UPD0_PN_ERR			BIT(28)
-#define HAL_REO_CMD_UPD0_PN_VALID		BIT(29)
-#define HAL_REO_CMD_UPD0_PN			BIT(30)
-
-/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO1_* fields */
-#define HAL_REO_CMD_UPD1_VLD			BIT(16)
-#define HAL_REO_CMD_UPD1_ALDC			GENMASK(18, 17)
-#define HAL_REO_CMD_UPD1_DIS_DUP_DETECTION	BIT(19)
-#define HAL_REO_CMD_UPD1_SOFT_REORDER_EN	BIT(20)
-#define HAL_REO_CMD_UPD1_AC			GENMASK(22, 21)
-#define HAL_REO_CMD_UPD1_BAR			BIT(23)
-#define HAL_REO_CMD_UPD1_RETRY			BIT(24)
-#define HAL_REO_CMD_UPD1_CHECK_2K_MODE		BIT(25)
-#define HAL_REO_CMD_UPD1_OOR_MODE		BIT(26)
-#define HAL_REO_CMD_UPD1_PN_CHECK		BIT(27)
-#define HAL_REO_CMD_UPD1_EVEN_PN		BIT(28)
-#define HAL_REO_CMD_UPD1_UNEVEN_PN		BIT(29)
-#define HAL_REO_CMD_UPD1_PN_HANDLE_ENABLE	BIT(30)
-#define HAL_REO_CMD_UPD1_IGNORE_AMPDU_FLG	BIT(31)
-
-/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO2_* fields */
-#define HAL_REO_CMD_UPD2_SVLD			BIT(10)
-#define HAL_REO_CMD_UPD2_SSN			GENMASK(22, 11)
-#define HAL_REO_CMD_UPD2_SEQ_2K_ERR		BIT(23)
-#define HAL_REO_CMD_UPD2_PN_ERR			BIT(24)
-
 struct ath12k_hal_reo_cmd {
 	u32 addr_lo;
 	u32 flag;
@@ -1353,93 +1026,6 @@ struct hal_reo_status_header {
 	u32 timestamp;
 };
 
-struct hal_reo_status_queue_stats {
-	u16 ssn;
-	u16 curr_idx;
-	u32 pn[4];
-	u32 last_rx_queue_ts;
-	u32 last_rx_dequeue_ts;
-	u32 rx_bitmap[8]; /* Bitmap from 0-255 */
-	u32 curr_mpdu_cnt;
-	u32 curr_msdu_cnt;
-	u16 fwd_due_to_bar_cnt;
-	u16 dup_cnt;
-	u32 frames_in_order_cnt;
-	u32 num_mpdu_processed_cnt;
-	u32 num_msdu_processed_cnt;
-	u32 total_num_processed_byte_cnt;
-	u32 late_rx_mpdu_cnt;
-	u32 reorder_hole_cnt;
-	u8 timeout_cnt;
-	u8 bar_rx_cnt;
-	u8 num_window_2k_jump_cnt;
-};
-
-struct hal_reo_status_flush_queue {
-	bool err_detected;
-};
-
-enum hal_reo_status_flush_cache_err_code {
-	HAL_REO_STATUS_FLUSH_CACHE_ERR_CODE_SUCCESS,
-	HAL_REO_STATUS_FLUSH_CACHE_ERR_CODE_IN_USE,
-	HAL_REO_STATUS_FLUSH_CACHE_ERR_CODE_NOT_FOUND,
-};
-
-struct hal_reo_status_flush_cache {
-	bool err_detected;
-	enum hal_reo_status_flush_cache_err_code err_code;
-	bool cache_controller_flush_status_hit;
-	u8 cache_controller_flush_status_desc_type;
-	u8 cache_controller_flush_status_client_id;
-	u8 cache_controller_flush_status_err;
-	u8 cache_controller_flush_status_cnt;
-};
-
-enum hal_reo_status_unblock_cache_type {
-	HAL_REO_STATUS_UNBLOCK_BLOCKING_RESOURCE,
-	HAL_REO_STATUS_UNBLOCK_ENTIRE_CACHE_USAGE,
-};
-
-struct hal_reo_status_unblock_cache {
-	bool err_detected;
-	enum hal_reo_status_unblock_cache_type unblock_type;
-};
-
-struct hal_reo_status_flush_timeout_list {
-	bool err_detected;
-	bool list_empty;
-	u16 release_desc_cnt;
-	u16 fwd_buf_cnt;
-};
-
-enum hal_reo_threshold_idx {
-	HAL_REO_THRESHOLD_IDX_DESC_COUNTER0,
-	HAL_REO_THRESHOLD_IDX_DESC_COUNTER1,
-	HAL_REO_THRESHOLD_IDX_DESC_COUNTER2,
-	HAL_REO_THRESHOLD_IDX_DESC_COUNTER_SUM,
-};
-
-struct hal_reo_status_desc_thresh_reached {
-	enum hal_reo_threshold_idx threshold_idx;
-	u32 link_desc_counter0;
-	u32 link_desc_counter1;
-	u32 link_desc_counter2;
-	u32 link_desc_counter_sum;
-};
-
-struct hal_reo_status {
-	struct hal_reo_status_header uniform_hdr;
-	u8 loop_cnt;
-	union {
-		struct hal_reo_status_queue_stats queue_stats;
-		struct hal_reo_status_flush_queue flush_queue;
-		struct hal_reo_status_flush_cache flush_cache;
-		struct hal_reo_status_unblock_cache unblock_cache;
-		struct hal_reo_status_flush_timeout_list timeout_list;
-		struct hal_reo_status_desc_thresh_reached desc_thresh_reached;
-	} u;
-};
-
 struct ath12k_hw_hal_params {
 	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
 	u32 wbm2sw_cc_enable;
@@ -1558,7 +1144,7 @@ struct ath12k_hal {
 	u8 current_blk_index;
 
 	/* shadow register configuration */
-	u32 shadow_reg_addr[HAL_SHADOW_NUM_REGS];
+	u32 shadow_reg_addr[HAL_SHADOW_NUM_REGS_MAX];
 	int num_shadow_reg_configured;
 
 	u32 hal_desc_sz;
@@ -1742,7 +1328,6 @@ struct hal_ops {
 		(*get_idle_link_rbm)(struct ath12k_hal *hal, u8 device_id);
 };
 
-u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
 dma_addr_t ath12k_hal_srng_get_tp_addr(struct ath12k_base *ab,
 				       struct hal_srng *srng);
 dma_addr_t ath12k_hal_srng_get_hp_addr(struct ath12k_base *ab,
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 6925abed190a..0509339d2122 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -15,7 +15,7 @@
 #include "hif.h"
 #include "mhi.h"
 #include "debug.h"
-#include "wifi7/dp.h"
+#include "hal.h"
 
 #define ATH12K_PCI_BAR_NUM		0
 #define ATH12K_PCI_DMA_MASK		36
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index 06d3690ff0c6..976dfe1b9087 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -138,6 +138,7 @@ static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
 
 static struct ath12k_dp_arch_ops ath12k_wifi7_dp_arch_ops = {
 	.service_srng = ath12k_wifi7_dp_service_srng,
+	.dp_tx_get_vdev_bank_config = ath12k_wifi7_dp_tx_get_vdev_bank_config,
 };
 
 /* TODO: remove export once this file is built with wifi7 ko */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index ece6a1311ef0..5ecbbf548b05 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -8,6 +8,9 @@
 
 #include "../core.h"
 #include "../dp_rx.h"
+#include "hal_rx_desc.h"
+
+struct ath12k_hal_reo_cmd;
 
 int ath12k_wifi7_dp_rx_process_wbm_err(struct ath12k_base *ab,
 				       struct napi_struct *napi, int budget);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
index b3c0f8a6a5ce..2f523ed00ded 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
@@ -9,6 +9,9 @@
 #include "../dp_tx.h"
 #include "../peer.h"
 #include "dp_tx.h"
+#include "hal_desc.h"
+#include "hal.h"
+#include "hal_tx.h"
 
 static void
 ath12k_wifi7_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
@@ -922,3 +925,52 @@ void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 		rcu_read_unlock();
 	}
 }
+
+u32 ath12k_wifi7_dp_tx_get_vdev_bank_config(struct ath12k_base *ab,
+					    struct ath12k_link_vif *arvif)
+{
+	u32 bank_config = 0;
+	u8 link_id = arvif->link_id;
+	struct ath12k_vif *ahvif = arvif->ahvif;
+	struct ath12k_dp_vif *dp_vif = &ahvif->dp_vif;
+	struct ath12k_dp_link_vif *dp_link_vif;
+
+	dp_link_vif = ath12k_dp_vif_to_dp_link_vif(dp_vif, link_id);
+
+	/* Only valid for raw frames with HW crypto enabled.
+	 * With SW crypto, mac80211 sets key per packet
+	 */
+	if (dp_vif->tx_encap_type == HAL_TCL_ENCAP_TYPE_RAW &&
+	    test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags))
+		bank_config |=
+			u32_encode_bits(ath12k_dp_tx_get_encrypt_type(dp_vif->key_cipher),
+					HAL_TX_BANK_CONFIG_ENCRYPT_TYPE);
+
+	bank_config |= u32_encode_bits(dp_vif->tx_encap_type,
+					HAL_TX_BANK_CONFIG_ENCAP_TYPE);
+	bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_SRC_BUFFER_SWAP) |
+			u32_encode_bits(0, HAL_TX_BANK_CONFIG_LINK_META_SWAP) |
+			u32_encode_bits(0, HAL_TX_BANK_CONFIG_EPD);
+
+	/* only valid if idx_lookup_override is not set in tcl_data_cmd */
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_STA)
+		bank_config |= u32_encode_bits(1, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
+	else
+		bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
+
+	bank_config |= u32_encode_bits(dp_link_vif->hal_addr_search_flags &
+				       HAL_TX_ADDRX_EN,
+				       HAL_TX_BANK_CONFIG_ADDRX_EN) |
+			u32_encode_bits(!!(dp_link_vif->hal_addr_search_flags &
+					HAL_TX_ADDRY_EN),
+					HAL_TX_BANK_CONFIG_ADDRY_EN);
+
+	bank_config |= u32_encode_bits(ieee80211_vif_is_mesh(ahvif->vif) ? 3 : 0,
+					HAL_TX_BANK_CONFIG_MESH_EN) |
+			u32_encode_bits(dp_link_vif->vdev_id_check_en,
+					HAL_TX_BANK_CONFIG_VDEV_ID_CHECK_EN);
+
+	bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_DSCP_TIP_MAP_ID);
+
+	return bank_config;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
index 524e23b8ed80..94a5c59289cc 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
@@ -11,4 +11,6 @@ int ath12k_wifi7_dp_tx(struct ath12k_pdev_dp *dp_pdev, struct ath12k_link_vif *a
 		       struct sk_buff *skb, bool gsn_valid, int mcbc_gsn,
 		       bool is_mcast);
 void ath12k_wifi7_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
+u32 ath12k_wifi7_dp_tx_get_vdev_bank_config(struct ath12k_base *ab,
+					    struct ath12k_link_vif *arvif);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index 4f9f1efbbfcf..e42970346e3d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -406,7 +406,7 @@ int ath12k_wifi7_hal_srng_update_shadow_config(struct ath12k_base *ab,
 	int shadow_cfg_idx = hal->num_shadow_reg_configured;
 	u32 target_reg;
 
-	if (shadow_cfg_idx >= HAL_SHADOW_NUM_REGS)
+	if (shadow_cfg_idx >= HAL_SHADOW_NUM_REGS_MAX)
 		return -EINVAL;
 
 	hal->num_shadow_reg_configured++;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
index b600b2e3cb78..8a40b9176406 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -7,6 +7,517 @@
 #ifndef ATH12K_HAL_WIFI7_H
 #define ATH12K_HAL_WIFI7_H
 
+#include "../core.h"
+#include "../hal.h"
+#include "hal_desc.h"
+#include "hal_tx.h"
+#include "hal_rx.h"
+#include "hal_rx_desc.h"
+
+/* calculate the register address from bar0 of shadow register x */
+#define HAL_SHADOW_BASE_ADDR			0x000008fc
+#define HAL_SHADOW_NUM_REGS			40
+#define HAL_HP_OFFSET_IN_REG_START		1
+#define HAL_OFFSET_FROM_HP_TO_TP		4
+
+#define HAL_SHADOW_REG(x) (HAL_SHADOW_BASE_ADDR + (4 * (x)))
+#define HAL_REO_QDESC_MAX_PEERID		8191
+
+/* WCSS Relative address */
+#define HAL_SEQ_WCSS_CMEM_OFFSET		0x00100000
+#define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
+#define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
+#define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
+#define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(hal) \
+	((hal)->regs->hal_umac_ce0_src_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE0_DST_REG(hal) \
+	((hal)->regs->hal_umac_ce0_dest_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(hal) \
+	((hal)->regs->hal_umac_ce1_src_reg_base)
+#define HAL_SEQ_WCSS_UMAC_CE1_DST_REG(hal) \
+	((hal)->regs->hal_umac_ce1_dest_reg_base)
+#define HAL_SEQ_WCSS_UMAC_WBM_REG		0x00a34000
+
+#define HAL_CE_WFSS_CE_REG_BASE			0x01b80000
+
+#define HAL_TCL_SW_CONFIG_BANK_ADDR		0x00a4408c
+
+/* SW2TCL(x) R0 ring configuration address */
+#define HAL_TCL1_RING_CMN_CTRL_REG		0x00000020
+#define HAL_TCL1_RING_DSCP_TID_MAP		0x00000240
+
+#define HAL_TCL1_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_tcl1_ring_base_lsb)
+#define HAL_TCL1_RING_BASE_MSB(hal) \
+	((hal)->regs->hal_tcl1_ring_base_msb)
+#define HAL_TCL1_RING_ID(hal)		((hal)->regs->hal_tcl1_ring_id)
+#define HAL_TCL1_RING_MISC(hal) \
+	((hal)->regs->hal_tcl1_ring_misc)
+#define HAL_TCL1_RING_TP_ADDR_LSB(hal) \
+	((hal)->regs->hal_tcl1_ring_tp_addr_lsb)
+#define HAL_TCL1_RING_TP_ADDR_MSB(hal) \
+	((hal)->regs->hal_tcl1_ring_tp_addr_msb)
+#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(hal) \
+	((hal)->regs->hal_tcl1_ring_consumer_int_setup_ix0)
+#define HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(hal) \
+	((hal)->regs->hal_tcl1_ring_consumer_int_setup_ix1)
+#define HAL_TCL1_RING_MSI1_BASE_LSB(hal) \
+	((hal)->regs->hal_tcl1_ring_msi1_base_lsb)
+#define HAL_TCL1_RING_MSI1_BASE_MSB(hal) \
+	((hal)->regs->hal_tcl1_ring_msi1_base_msb)
+#define HAL_TCL1_RING_MSI1_DATA(hal) \
+	((hal)->regs->hal_tcl1_ring_msi1_data)
+#define HAL_TCL2_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_tcl2_ring_base_lsb)
+#define HAL_TCL_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_tcl_ring_base_lsb)
+
+#define HAL_TCL1_RING_MSI1_BASE_LSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_MSI1_BASE_LSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_MSI1_BASE_MSB_OFFSET(hal)	({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_MSI1_BASE_MSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_MSI1_DATA_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_MSI1_DATA(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_BASE_MSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_BASE_MSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_ID_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_ID(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX0(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_CONSUMER_INT_SETUP_IX1(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_TP_ADDR_LSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_TP_ADDR_LSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_TP_ADDR_MSB_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_TP_ADDR_MSB(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+#define HAL_TCL1_RING_MISC_OFFSET(hal) ({ typeof(hal) _hal = (hal); \
+	(HAL_TCL1_RING_MISC(_hal) - HAL_TCL1_RING_BASE_LSB(_hal)); })
+
+/* SW2TCL(x) R2 ring pointers (head/tail) address */
+#define HAL_TCL1_RING_HP			0x00002000
+#define HAL_TCL1_RING_TP			0x00002004
+#define HAL_TCL2_RING_HP			0x00002008
+#define HAL_TCL_RING_HP				0x00002028
+
+#define HAL_TCL1_RING_TP_OFFSET \
+		(HAL_TCL1_RING_TP - HAL_TCL1_RING_HP)
+
+/* TCL STATUS ring address */
+#define HAL_TCL_STATUS_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_tcl_status_ring_base_lsb)
+#define HAL_TCL_STATUS_RING_HP			0x00002048
+
+/* PPE2TCL1 Ring address */
+#define HAL_TCL_PPE2TCL1_RING_BASE_LSB		0x00000c48
+#define HAL_TCL_PPE2TCL1_RING_HP		0x00002038
+
+/* WBM PPE Release Ring address */
+#define HAL_WBM_PPE_RELEASE_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_ppe_rel_ring_base)
+#define HAL_WBM_PPE_RELEASE_RING_HP		0x00003020
+
+/* REO2SW(x) R0 ring configuration address */
+#define HAL_REO1_GEN_ENABLE			0x00000000
+#define HAL_REO1_MISC_CTRL_ADDR(hal) \
+	((hal)->regs->hal_reo1_misc_ctrl_addr)
+#define HAL_REO1_DEST_RING_CTRL_IX_0		0x00000004
+#define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
+#define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
+#define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
+#define HAL_REO1_QDESC_ADDR(hal)		((hal)->regs->hal_reo1_qdesc_addr)
+#define HAL_REO1_QDESC_MAX_PEERID(hal)	((hal)->regs->hal_reo1_qdesc_max_peerid)
+#define HAL_REO1_SW_COOKIE_CFG0(hal)	((hal)->regs->hal_reo1_sw_cookie_cfg0)
+#define HAL_REO1_SW_COOKIE_CFG1(hal)	((hal)->regs->hal_reo1_sw_cookie_cfg1)
+#define HAL_REO1_QDESC_LUT_BASE0(hal)	((hal)->regs->hal_reo1_qdesc_lut_base0)
+#define HAL_REO1_QDESC_LUT_BASE1(hal)	((hal)->regs->hal_reo1_qdesc_lut_base1)
+#define HAL_REO1_RING_BASE_LSB(hal)	((hal)->regs->hal_reo1_ring_base_lsb)
+#define HAL_REO1_RING_BASE_MSB(hal)	((hal)->regs->hal_reo1_ring_base_msb)
+#define HAL_REO1_RING_ID(hal)		((hal)->regs->hal_reo1_ring_id)
+#define HAL_REO1_RING_MISC(hal)		((hal)->regs->hal_reo1_ring_misc)
+#define HAL_REO1_RING_HP_ADDR_LSB(hal)	((hal)->regs->hal_reo1_ring_hp_addr_lsb)
+#define HAL_REO1_RING_HP_ADDR_MSB(hal)	((hal)->regs->hal_reo1_ring_hp_addr_msb)
+#define HAL_REO1_RING_PRODUCER_INT_SETUP(hal) \
+	((hal)->regs->hal_reo1_ring_producer_int_setup)
+#define HAL_REO1_RING_MSI1_BASE_LSB(hal)	\
+	((hal)->regs->hal_reo1_ring_msi1_base_lsb)
+#define HAL_REO1_RING_MSI1_BASE_MSB(hal)	\
+	((hal)->regs->hal_reo1_ring_msi1_base_msb)
+#define HAL_REO1_RING_MSI1_DATA(hal)	((hal)->regs->hal_reo1_ring_msi1_data)
+#define HAL_REO2_RING_BASE_LSB(hal)	((hal)->regs->hal_reo2_ring_base)
+#define HAL_REO1_AGING_THRESH_IX_0(hal)	((hal)->regs->hal_reo1_aging_thres_ix0)
+#define HAL_REO1_AGING_THRESH_IX_1(hal)	((hal)->regs->hal_reo1_aging_thres_ix1)
+#define HAL_REO1_AGING_THRESH_IX_2(hal)	((hal)->regs->hal_reo1_aging_thres_ix2)
+#define HAL_REO1_AGING_THRESH_IX_3(hal)	((hal)->regs->hal_reo1_aging_thres_ix3)
+
+/* REO2SW(x) R2 ring pointers (head/tail) address */
+#define HAL_REO1_RING_HP			0x00003048
+#define HAL_REO1_RING_TP			0x0000304c
+#define HAL_REO2_RING_HP			0x00003050
+
+#define HAL_REO1_RING_TP_OFFSET			(HAL_REO1_RING_TP - HAL_REO1_RING_HP)
+
+/* REO2SW0 ring configuration address */
+#define HAL_REO_SW0_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_reo2_sw0_ring_base)
+
+/* REO2SW0 R2 ring pointer (head/tail) address */
+#define HAL_REO_SW0_RING_HP			0x00003088
+
+/* REO CMD R0 address */
+#define HAL_REO_CMD_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_reo_cmd_ring_base)
+
+/* REO CMD R2 address */
+#define HAL_REO_CMD_HP				0x00003020
+
+/* SW2REO R0 address */
+#define	HAL_SW2REO_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_sw2reo_ring_base)
+#define HAL_SW2REO1_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_sw2reo1_ring_base)
+
+/* SW2REO R2 address */
+#define HAL_SW2REO_RING_HP			0x00003028
+#define HAL_SW2REO1_RING_HP			0x00003030
+
+/* CE ring R0 address */
+#define HAL_CE_SRC_RING_BASE_LSB                0x00000000
+#define HAL_CE_DST_RING_BASE_LSB		0x00000000
+#define HAL_CE_DST_STATUS_RING_BASE_LSB		0x00000058
+#define HAL_CE_DST_RING_CTRL			0x000000b0
+
+/* CE ring R2 address */
+#define HAL_CE_DST_RING_HP			0x00000400
+#define HAL_CE_DST_STATUS_RING_HP		0x00000408
+
+/* REO status address */
+#define HAL_REO_STATUS_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_reo_status_ring_base)
+#define HAL_REO_STATUS_HP			0x000030a8
+
+/* WBM Idle R0 address */
+#define HAL_WBM_IDLE_LINK_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm_idle_ring_base_lsb)
+#define HAL_WBM_IDLE_LINK_RING_MISC_ADDR(hal) \
+	((hal)->regs->hal_wbm_idle_ring_misc_addr)
+#define HAL_WBM_R0_IDLE_LIST_CONTROL_ADDR(hal) \
+	((hal)->regs->hal_wbm_r0_idle_list_cntl_addr)
+#define HAL_WBM_R0_IDLE_LIST_SIZE_ADDR(hal) \
+	((hal)->regs->hal_wbm_r0_idle_list_size_addr)
+#define HAL_WBM_SCATTERED_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm_scattered_ring_base_lsb)
+#define HAL_WBM_SCATTERED_RING_BASE_MSB(hal) \
+	((hal)->regs->hal_wbm_scattered_ring_base_msb)
+#define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX0(hal) \
+	((hal)->regs->hal_wbm_scattered_desc_head_info_ix0)
+#define HAL_WBM_SCATTERED_DESC_PTR_HEAD_INFO_IX1(hal) \
+	((hal)->regs->hal_wbm_scattered_desc_head_info_ix1)
+#define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX0(hal) \
+	((hal)->regs->hal_wbm_scattered_desc_tail_info_ix0)
+#define HAL_WBM_SCATTERED_DESC_PTR_TAIL_INFO_IX1(hal) \
+	((hal)->regs->hal_wbm_scattered_desc_tail_info_ix1)
+#define HAL_WBM_SCATTERED_DESC_PTR_HP_ADDR(hal) \
+	((hal)->regs->hal_wbm_scattered_desc_ptr_hp_addr)
+
+/* WBM Idle R2 address */
+#define HAL_WBM_IDLE_LINK_RING_HP		0x000030b8
+
+/* SW2WBM R0 release address */
+#define HAL_WBM_SW_RELEASE_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm_sw_release_ring_base_lsb)
+#define HAL_WBM_SW1_RELEASE_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm_sw1_release_ring_base_lsb)
+
+/* SW2WBM R2 release address */
+#define HAL_WBM_SW_RELEASE_RING_HP		0x00003010
+#define HAL_WBM_SW1_RELEASE_RING_HP		0x00003018
+
+/* WBM2SW R0 release address */
+#define HAL_WBM0_RELEASE_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm0_release_ring_base_lsb)
+
+#define HAL_WBM1_RELEASE_RING_BASE_LSB(hal) \
+	((hal)->regs->hal_wbm1_release_ring_base_lsb)
+
+/* WBM2SW R2 release address */
+#define HAL_WBM0_RELEASE_RING_HP		0x000030c8
+#define HAL_WBM1_RELEASE_RING_HP		0x000030d0
+
+/* WBM cookie config address and mask */
+#define HAL_WBM_SW_COOKIE_CFG0			0x00000040
+#define HAL_WBM_SW_COOKIE_CFG1			0x00000044
+#define HAL_WBM_SW_COOKIE_CFG2			0x00000090
+#define HAL_WBM_SW_COOKIE_CONVERT_CFG		0x00000094
+
+#define HAL_WBM_SW_COOKIE_CFG_CMEM_BASE_ADDR_MSB	GENMASK(7, 0)
+#define HAL_WBM_SW_COOKIE_CFG_COOKIE_PPT_MSB		GENMASK(12, 8)
+#define HAL_WBM_SW_COOKIE_CFG_COOKIE_SPT_MSB		GENMASK(17, 13)
+#define HAL_WBM_SW_COOKIE_CFG_ALIGN			BIT(18)
+#define HAL_WBM_SW_COOKIE_CFG_RELEASE_PATH_EN		BIT(0)
+#define HAL_WBM_SW_COOKIE_CFG_ERR_PATH_EN		BIT(1)
+#define HAL_WBM_SW_COOKIE_CFG_CONV_IND_EN		BIT(3)
+
+#define HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN		BIT(1)
+#define HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW1_EN		BIT(2)
+#define HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW2_EN		BIT(3)
+#define HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW3_EN		BIT(4)
+#define HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW4_EN		BIT(5)
+#define HAL_WBM_SW_COOKIE_CONV_CFG_GLOBAL_EN		BIT(8)
+
+/* TCL ring field mask and offset */
+#define HAL_TCL1_RING_BASE_MSB_RING_SIZE		GENMASK(27, 8)
+#define HAL_TCL1_RING_BASE_MSB_RING_BASE_ADDR_MSB	GENMASK(7, 0)
+#define HAL_TCL1_RING_ID_ENTRY_SIZE			GENMASK(7, 0)
+#define HAL_TCL1_RING_MISC_MSI_RING_ID_DISABLE		BIT(0)
+#define HAL_TCL1_RING_MISC_MSI_LOOPCNT_DISABLE		BIT(1)
+#define HAL_TCL1_RING_MISC_MSI_SWAP			BIT(3)
+#define HAL_TCL1_RING_MISC_HOST_FW_SWAP			BIT(4)
+#define HAL_TCL1_RING_MISC_DATA_TLV_SWAP		BIT(5)
+#define HAL_TCL1_RING_MISC_SRNG_ENABLE			BIT(6)
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_INTR_TMR_THOLD   GENMASK(31, 16)
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX0_BATCH_COUNTER_THOLD GENMASK(14, 0)
+#define HAL_TCL1_RING_CONSR_INT_SETUP_IX1_LOW_THOLD	GENMASK(15, 0)
+#define HAL_TCL1_RING_MSI1_BASE_MSB_MSI1_ENABLE		BIT(8)
+#define HAL_TCL1_RING_MSI1_BASE_MSB_ADDR		GENMASK(7, 0)
+#define HAL_TCL1_RING_CMN_CTRL_DSCP_TID_MAP_PROG_EN	BIT(23)
+#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP		GENMASK(31, 0)
+#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP0		GENMASK(2, 0)
+#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP1		GENMASK(5, 3)
+#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP2		GENMASK(8, 6)
+#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP3		GENMASK(11, 9)
+#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP4		GENMASK(14, 12)
+#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP5		GENMASK(17, 15)
+#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP6		GENMASK(20, 18)
+#define HAL_TCL1_RING_FIELD_DSCP_TID_MAP7		GENMASK(23, 21)
+
+/* REO ring field mask and offset */
+#define HAL_REO1_RING_BASE_MSB_RING_SIZE		GENMASK(27, 8)
+#define HAL_REO1_RING_BASE_MSB_RING_BASE_ADDR_MSB	GENMASK(7, 0)
+#define HAL_REO1_RING_ID_RING_ID			GENMASK(15, 8)
+#define HAL_REO1_RING_ID_ENTRY_SIZE			GENMASK(7, 0)
+#define HAL_REO1_RING_MISC_MSI_SWAP			BIT(3)
+#define HAL_REO1_RING_MISC_HOST_FW_SWAP			BIT(4)
+#define HAL_REO1_RING_MISC_DATA_TLV_SWAP		BIT(5)
+#define HAL_REO1_RING_MISC_SRNG_ENABLE			BIT(6)
+#define HAL_REO1_RING_PRDR_INT_SETUP_INTR_TMR_THOLD	GENMASK(31, 16)
+#define HAL_REO1_RING_PRDR_INT_SETUP_BATCH_COUNTER_THOLD GENMASK(14, 0)
+#define HAL_REO1_RING_MSI1_BASE_MSB_MSI1_ENABLE		BIT(8)
+#define HAL_REO1_RING_MSI1_BASE_MSB_ADDR		GENMASK(7, 0)
+#define HAL_REO1_MISC_CTL_FRAG_DST_RING			GENMASK(20, 17)
+#define HAL_REO1_MISC_CTL_BAR_DST_RING			GENMASK(24, 21)
+#define HAL_REO1_GEN_ENABLE_AGING_LIST_ENABLE		BIT(2)
+#define HAL_REO1_GEN_ENABLE_AGING_FLUSH_ENABLE		BIT(3)
+#define HAL_REO1_SW_COOKIE_CFG_CMEM_BASE_ADDR_MSB	GENMASK(7, 0)
+#define HAL_REO1_SW_COOKIE_CFG_COOKIE_PPT_MSB		GENMASK(12, 8)
+#define HAL_REO1_SW_COOKIE_CFG_COOKIE_SPT_MSB		GENMASK(17, 13)
+#define HAL_REO1_SW_COOKIE_CFG_ALIGN			BIT(18)
+#define HAL_REO1_SW_COOKIE_CFG_ENABLE			BIT(19)
+#define HAL_REO1_SW_COOKIE_CFG_GLOBAL_ENABLE		BIT(20)
+#define HAL_REO_QDESC_ADDR_READ_LUT_ENABLE		BIT(7)
+#define HAL_REO_QDESC_ADDR_READ_CLEAR_QDESC_ARRAY	BIT(6)
+
+/* CE ring bit field mask and shift */
+#define HAL_CE_DST_R0_DEST_CTRL_MAX_LEN			GENMASK(15, 0)
+
+#define HAL_ADDR_LSB_REG_MASK				0xffffffff
+
+#define HAL_ADDR_MSB_REG_SHIFT				32
+
+/* WBM ring bit field mask and shift */
+#define HAL_WBM_LINK_DESC_IDLE_LIST_MODE		BIT(1)
+#define HAL_WBM_SCATTER_BUFFER_SIZE			GENMASK(10, 2)
+#define HAL_WBM_SCATTER_RING_SIZE_OF_IDLE_LINK_DESC_LIST GENMASK(31, 16)
+#define HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_39_32	GENMASK(7, 0)
+#define HAL_WBM_SCATTERED_DESC_MSB_BASE_ADDR_MATCH_TAG	GENMASK(31, 8)
+
+#define HAL_WBM_SCATTERED_DESC_HEAD_P_OFFSET_IX1	GENMASK(20, 8)
+#define HAL_WBM_SCATTERED_DESC_TAIL_P_OFFSET_IX1	GENMASK(20, 8)
+
+#define HAL_WBM_IDLE_LINK_RING_MISC_SRNG_ENABLE		BIT(6)
+#define HAL_WBM_IDLE_LINK_RING_MISC_RIND_ID_DISABLE	BIT(0)
+
+#define BASE_ADDR_MATCH_TAG_VAL 0x5
+
+#define HAL_REO_REO2SW1_RING_BASE_MSB_RING_SIZE		0x000fffff
+#define HAL_REO_REO2SW0_RING_BASE_MSB_RING_SIZE		0x000fffff
+#define HAL_REO_SW2REO_RING_BASE_MSB_RING_SIZE		0x0000ffff
+#define HAL_REO_CMD_RING_BASE_MSB_RING_SIZE		0x0000ffff
+#define HAL_REO_STATUS_RING_BASE_MSB_RING_SIZE		0x0000ffff
+#define HAL_SW2TCL1_RING_BASE_MSB_RING_SIZE		0x000fffff
+#define HAL_SW2TCL1_CMD_RING_BASE_MSB_RING_SIZE		0x000fffff
+#define HAL_TCL_STATUS_RING_BASE_MSB_RING_SIZE		0x0000ffff
+#define HAL_CE_SRC_RING_BASE_MSB_RING_SIZE		0x0000ffff
+#define HAL_CE_DST_RING_BASE_MSB_RING_SIZE		0x0000ffff
+#define HAL_CE_DST_STATUS_RING_BASE_MSB_RING_SIZE	0x0000ffff
+#define HAL_WBM_IDLE_LINK_RING_BASE_MSB_RING_SIZE	0x000fffff
+#define HAL_SW2WBM_RELEASE_RING_BASE_MSB_RING_SIZE	0x0000ffff
+#define HAL_WBM2SW_RELEASE_RING_BASE_MSB_RING_SIZE	0x000fffff
+#define HAL_RXDMA_RING_MAX_SIZE				0x0000ffff
+#define HAL_RXDMA_RING_MAX_SIZE_BE			0x000fffff
+#define HAL_WBM2PPE_RELEASE_RING_BASE_MSB_RING_SIZE	0x000fffff
+
+#define HAL_WBM2SW_REL_ERR_RING_NUM 3
+/* Add any other errors here and return them in
+ * ath12k_hal_rx_desc_get_err().
+ */
+
+#define HAL_IPQ5332_CE_WFSS_REG_BASE	0x740000
+#define HAL_IPQ5332_CE_SIZE		0x100000
+
+#define HAL_RX_MAX_BA_WINDOW	256
+
+#define HAL_DEFAULT_BE_BK_VI_REO_TIMEOUT_USEC	(100 * 1000)
+#define HAL_DEFAULT_VO_REO_TIMEOUT_USEC		(40 * 1000)
+
+#define HAL_SRNG_TLV_HDR_TAG		GENMASK(9, 1)
+#define HAL_SRNG_TLV_HDR_LEN		GENMASK(25, 10)
+
+#define HAL_SRNG_DESC_LOOP_CNT		0xf0000000
+
+#define HAL_REO_CMD_FLG_NEED_STATUS		BIT(0)
+#define HAL_REO_CMD_FLG_STATS_CLEAR		BIT(1)
+#define HAL_REO_CMD_FLG_FLUSH_BLOCK_LATER	BIT(2)
+#define HAL_REO_CMD_FLG_FLUSH_RELEASE_BLOCKING	BIT(3)
+#define HAL_REO_CMD_FLG_FLUSH_NO_INVAL		BIT(4)
+#define HAL_REO_CMD_FLG_FLUSH_FWD_ALL_MPDUS	BIT(5)
+#define HAL_REO_CMD_FLG_FLUSH_ALL		BIT(6)
+#define HAL_REO_CMD_FLG_UNBLK_RESOURCE		BIT(7)
+#define HAL_REO_CMD_FLG_UNBLK_CACHE		BIT(8)
+
+/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO0_UPD_* fields */
+#define HAL_REO_CMD_UPD0_RX_QUEUE_NUM		BIT(8)
+#define HAL_REO_CMD_UPD0_VLD			BIT(9)
+#define HAL_REO_CMD_UPD0_ALDC			BIT(10)
+#define HAL_REO_CMD_UPD0_DIS_DUP_DETECTION	BIT(11)
+#define HAL_REO_CMD_UPD0_SOFT_REORDER_EN	BIT(12)
+#define HAL_REO_CMD_UPD0_AC			BIT(13)
+#define HAL_REO_CMD_UPD0_BAR			BIT(14)
+#define HAL_REO_CMD_UPD0_RETRY			BIT(15)
+#define HAL_REO_CMD_UPD0_CHECK_2K_MODE		BIT(16)
+#define HAL_REO_CMD_UPD0_OOR_MODE		BIT(17)
+#define HAL_REO_CMD_UPD0_BA_WINDOW_SIZE		BIT(18)
+#define HAL_REO_CMD_UPD0_PN_CHECK		BIT(19)
+#define HAL_REO_CMD_UPD0_EVEN_PN		BIT(20)
+#define HAL_REO_CMD_UPD0_UNEVEN_PN		BIT(21)
+#define HAL_REO_CMD_UPD0_PN_HANDLE_ENABLE	BIT(22)
+#define HAL_REO_CMD_UPD0_PN_SIZE		BIT(23)
+#define HAL_REO_CMD_UPD0_IGNORE_AMPDU_FLG	BIT(24)
+#define HAL_REO_CMD_UPD0_SVLD			BIT(25)
+#define HAL_REO_CMD_UPD0_SSN			BIT(26)
+#define HAL_REO_CMD_UPD0_SEQ_2K_ERR		BIT(27)
+#define HAL_REO_CMD_UPD0_PN_ERR			BIT(28)
+#define HAL_REO_CMD_UPD0_PN_VALID		BIT(29)
+#define HAL_REO_CMD_UPD0_PN			BIT(30)
+
+/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO1_* fields */
+#define HAL_REO_CMD_UPD1_VLD			BIT(16)
+#define HAL_REO_CMD_UPD1_ALDC			GENMASK(18, 17)
+#define HAL_REO_CMD_UPD1_DIS_DUP_DETECTION	BIT(19)
+#define HAL_REO_CMD_UPD1_SOFT_REORDER_EN	BIT(20)
+#define HAL_REO_CMD_UPD1_AC			GENMASK(22, 21)
+#define HAL_REO_CMD_UPD1_BAR			BIT(23)
+#define HAL_REO_CMD_UPD1_RETRY			BIT(24)
+#define HAL_REO_CMD_UPD1_CHECK_2K_MODE		BIT(25)
+#define HAL_REO_CMD_UPD1_OOR_MODE		BIT(26)
+#define HAL_REO_CMD_UPD1_PN_CHECK		BIT(27)
+#define HAL_REO_CMD_UPD1_EVEN_PN		BIT(28)
+#define HAL_REO_CMD_UPD1_UNEVEN_PN		BIT(29)
+#define HAL_REO_CMD_UPD1_PN_HANDLE_ENABLE	BIT(30)
+#define HAL_REO_CMD_UPD1_IGNORE_AMPDU_FLG	BIT(31)
+
+/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO2_* fields */
+#define HAL_REO_CMD_UPD2_SVLD			BIT(10)
+#define HAL_REO_CMD_UPD2_SSN			GENMASK(22, 11)
+#define HAL_REO_CMD_UPD2_SEQ_2K_ERR		BIT(23)
+#define HAL_REO_CMD_UPD2_PN_ERR			BIT(24)
+
+struct hal_reo_status_queue_stats {
+	u16 ssn;
+	u16 curr_idx;
+	u32 pn[4];
+	u32 last_rx_queue_ts;
+	u32 last_rx_dequeue_ts;
+	u32 rx_bitmap[8]; /* Bitmap from 0-255 */
+	u32 curr_mpdu_cnt;
+	u32 curr_msdu_cnt;
+	u16 fwd_due_to_bar_cnt;
+	u16 dup_cnt;
+	u32 frames_in_order_cnt;
+	u32 num_mpdu_processed_cnt;
+	u32 num_msdu_processed_cnt;
+	u32 total_num_processed_byte_cnt;
+	u32 late_rx_mpdu_cnt;
+	u32 reorder_hole_cnt;
+	u8 timeout_cnt;
+	u8 bar_rx_cnt;
+	u8 num_window_2k_jump_cnt;
+};
+
+struct hal_reo_status_flush_queue {
+	bool err_detected;
+};
+
+enum hal_reo_status_flush_cache_err_code {
+	HAL_REO_STATUS_FLUSH_CACHE_ERR_CODE_SUCCESS,
+	HAL_REO_STATUS_FLUSH_CACHE_ERR_CODE_IN_USE,
+	HAL_REO_STATUS_FLUSH_CACHE_ERR_CODE_NOT_FOUND,
+};
+
+struct hal_reo_status_flush_cache {
+	bool err_detected;
+	enum hal_reo_status_flush_cache_err_code err_code;
+	bool cache_controller_flush_status_hit;
+	u8 cache_controller_flush_status_desc_type;
+	u8 cache_controller_flush_status_client_id;
+	u8 cache_controller_flush_status_err;
+	u8 cache_controller_flush_status_cnt;
+};
+
+enum hal_reo_status_unblock_cache_type {
+	HAL_REO_STATUS_UNBLOCK_BLOCKING_RESOURCE,
+	HAL_REO_STATUS_UNBLOCK_ENTIRE_CACHE_USAGE,
+};
+
+struct hal_reo_status_unblock_cache {
+	bool err_detected;
+	enum hal_reo_status_unblock_cache_type unblock_type;
+};
+
+struct hal_reo_status_flush_timeout_list {
+	bool err_detected;
+	bool list_empty;
+	u16 release_desc_cnt;
+	u16 fwd_buf_cnt;
+};
+
+enum hal_reo_threshold_idx {
+	HAL_REO_THRESHOLD_IDX_DESC_COUNTER0,
+	HAL_REO_THRESHOLD_IDX_DESC_COUNTER1,
+	HAL_REO_THRESHOLD_IDX_DESC_COUNTER2,
+	HAL_REO_THRESHOLD_IDX_DESC_COUNTER_SUM,
+};
+
+struct hal_reo_status_desc_thresh_reached {
+	enum hal_reo_threshold_idx threshold_idx;
+	u32 link_desc_counter0;
+	u32 link_desc_counter1;
+	u32 link_desc_counter2;
+	u32 link_desc_counter_sum;
+};
+
+struct hal_reo_status {
+	struct hal_reo_status_header uniform_hdr;
+	u8 loop_cnt;
+	union {
+		struct hal_reo_status_queue_stats queue_stats;
+		struct hal_reo_status_flush_queue flush_queue;
+		struct hal_reo_status_flush_cache flush_cache;
+		struct hal_reo_status_unblock_cache unblock_cache;
+		struct hal_reo_status_flush_timeout_list timeout_list;
+		struct hal_reo_status_desc_thresh_reached desc_thresh_reached;
+	} u;
+};
+
 int ath12k_wifi7_hal_init(struct ath12k_base *ab);
 void ath12k_wifi7_hal_ce_dst_setup(struct ath12k_base *ab,
 				   struct hal_srng *srng, int ring_num);
@@ -48,4 +559,5 @@ void ath12k_wifi7_hal_write_reoq_lut_addr(struct ath12k_base *ab,
 					  dma_addr_t paddr);
 void ath12k_wifi7_hal_write_ml_reoq_lut_addr(struct ath12k_base *ab,
 					     dma_addr_t paddr);
+u32 ath12k_wifi7_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
index 0e91410bdedf..17e46acc8e34 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
@@ -8,85 +8,6 @@
 #ifndef ATH12K_HAL_DESC_H
 #define ATH12K_HAL_DESC_H
 
-#define BUFFER_ADDR_INFO0_ADDR         GENMASK(31, 0)
-
-#define BUFFER_ADDR_INFO1_ADDR         GENMASK(7, 0)
-#define BUFFER_ADDR_INFO1_RET_BUF_MGR  GENMASK(11, 8)
-#define BUFFER_ADDR_INFO1_SW_COOKIE    GENMASK(31, 12)
-
-struct ath12k_buffer_addr {
-	__le32 info0;
-	__le32 info1;
-} __packed;
-
-/* ath12k_buffer_addr
- *
- * buffer_addr_31_0
- *		Address (lower 32 bits) of the MSDU buffer or MSDU_EXTENSION
- *		descriptor or Link descriptor
- *
- * buffer_addr_39_32
- *		Address (upper 8 bits) of the MSDU buffer or MSDU_EXTENSION
- *		descriptor or Link descriptor
- *
- * return_buffer_manager (RBM)
- *		Consumer: WBM
- *		Producer: SW/FW
- *		Indicates to which buffer manager the buffer or MSDU_EXTENSION
- *		descriptor or link descriptor that is being pointed to shall be
- *		returned after the frame has been processed. It is used by WBM
- *		for routing purposes.
- *
- *		Values are defined in enum %HAL_RX_BUF_RBM_
- *
- * sw_buffer_cookie
- *		Cookie field exclusively used by SW. HW ignores the contents,
- *		accept that it passes the programmed value on to other
- *		descriptors together with the physical address.
- *
- *		Field can be used by SW to for example associate the buffers
- *		physical address with the virtual address.
- *
- *		NOTE1:
- *		The three most significant bits can have a special meaning
- *		 in case this struct is embedded in a TX_MPDU_DETAILS STRUCT,
- *		and field transmit_bw_restriction is set
- *
- *		In case of NON punctured transmission:
- *		Sw_buffer_cookie[19:17] = 3'b000: 20 MHz TX only
- *		Sw_buffer_cookie[19:17] = 3'b001: 40 MHz TX only
- *		Sw_buffer_cookie[19:17] = 3'b010: 80 MHz TX only
- *		Sw_buffer_cookie[19:17] = 3'b011: 160 MHz TX only
- *		Sw_buffer_cookie[19:17] = 3'b101: 240 MHz TX only
- *		Sw_buffer_cookie[19:17] = 3'b100: 320 MHz TX only
- *		Sw_buffer_cookie[19:18] = 2'b11: reserved
- *
- *		In case of punctured transmission:
- *		Sw_buffer_cookie[19:16] = 4'b0000: pattern 0 only
- *		Sw_buffer_cookie[19:16] = 4'b0001: pattern 1 only
- *		Sw_buffer_cookie[19:16] = 4'b0010: pattern 2 only
- *		Sw_buffer_cookie[19:16] = 4'b0011: pattern 3 only
- *		Sw_buffer_cookie[19:16] = 4'b0100: pattern 4 only
- *		Sw_buffer_cookie[19:16] = 4'b0101: pattern 5 only
- *		Sw_buffer_cookie[19:16] = 4'b0110: pattern 6 only
- *		Sw_buffer_cookie[19:16] = 4'b0111: pattern 7 only
- *		Sw_buffer_cookie[19:16] = 4'b1000: pattern 8 only
- *		Sw_buffer_cookie[19:16] = 4'b1001: pattern 9 only
- *		Sw_buffer_cookie[19:16] = 4'b1010: pattern 10 only
- *		Sw_buffer_cookie[19:16] = 4'b1011: pattern 11 only
- *		Sw_buffer_cookie[19:18] = 2'b11: reserved
- *
- *		Note: a punctured transmission is indicated by the presence
- *		 of TLV TX_PUNCTURE_SETUP embedded in the scheduler TLV
- *
- *		Sw_buffer_cookie[20:17]: Tid: The TID field in the QoS control
- *		 field
- *
- *		Sw_buffer_cookie[16]: Mpdu_qos_control_valid: This field
- *		 indicates MPDUs with a QoS control field.
- *
- */
-
 enum hal_tlv_tag {
 	HAL_MACTX_CBF_START					= 0 /* 0x0 */,
 	HAL_PHYRX_DATA						= 1 /* 0x1 */,
@@ -1862,7 +1783,6 @@ struct hal_wbm_release_ring_cc_rx {
 #define HAL_WBM_RELEASE_INFO3_CONTINUATION		BIT(2)
 
 #define HAL_WBM_RELEASE_INFO5_LOOPING_COUNT		GENMASK(31, 28)
-#define HAL_ENCRYPT_TYPE_MAX 12
 
 struct hal_wbm_release_ring {
 	struct ath12k_buffer_addr buf_addr_info;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
index c48dd029f52e..08c0a0469474 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
@@ -11,6 +11,7 @@
 #include <linux/etherdevice.h>
 #include "../hal.h"
 #include "hal_rx.h"
+#include "hal.h"
 
 extern const struct hal_ops hal_qcn9274_ops;
 extern const struct ath12k_hw_regs qcn9274_v1_regs;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index d035996657fe..0f1bdd5425dc 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -10,6 +10,7 @@
 #include "hal_tx.h"
 #include "hal_rx.h"
 #include "hal_desc.h"
+#include "hal.h"
 
 static
 void ath12k_wifi7_hal_reo_set_desc_hdr(struct hal_desc_header *hdr,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index 39ae33ca17f4..c4fa2bee97b5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -7,6 +7,10 @@
 #ifndef ATH12K_HAL_RX_H
 #define ATH12K_HAL_RX_H
 
+#include "hal_desc.h"
+
+struct hal_reo_status;
+
 struct hal_rx_wbm_rel_info {
 	u32 cookie;
 	enum hal_wbm_rel_src_module err_rel_src;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
index 24f905c5b062..02d3cadf03fe 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c
@@ -4,10 +4,10 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include "hal_desc.h"
 #include "../hal.h"
 #include "hal_tx.h"
 #include "../hif.h"
+#include "hal.h"
 
 #define DSCP_TID_MAP_TBL_ENTRY_SIZE 64
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
index 07392b31d0ab..9d2b1552c2f5 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_tx.h
@@ -7,8 +7,8 @@
 #ifndef ATH12K_HAL_TX_H
 #define ATH12K_HAL_TX_H
 
+#include "../mac.h"
 #include "hal_desc.h"
-#include "../core.h"
 
 /* TODO: check all these data can be managed with struct ath12k_tx_desc_info for perf */
 struct hal_tx_info {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
index 7d0b0c985446..46047fd6a312 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
@@ -9,6 +9,7 @@
 
 #include "../hal.h"
 #include "hal_rx.h"
+#include "hal.h"
 
 extern const struct hal_ops hal_wcn7850_ops;
 extern const struct ath12k_hw_regs wcn7850_regs;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/pci.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
index f6dfdcf95025..dedc88858bb0 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/pci.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
@@ -15,6 +15,7 @@
 #include "../hal.h"
 #include "dp.h"
 #include "core.h"
+#include "hal.h"
 
 #define QCN9274_DEVICE_ID		0x1109
 #define WCN7850_DEVICE_ID		0x1107
-- 
2.34.1



Return-Path: <linux-wireless+bounces-28498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3BC2B4C5
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 12:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6600A4F2034
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 11:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D5530171A;
	Mon,  3 Nov 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HLk/KUaK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E682FC02C
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168912; cv=none; b=Z0kJKcB9ubb6+wyvkb+30M56vktllkvshCbR5Fn2fsvCqb0Je3MwskNxKkTIBJUbsiD1go+P8Drj3nSz7dg+yoZuRTpi0yP4dlOXheF+0C+V+8+aZv9g19KvRJ3AT64ZTiVOBqTZ0Jm+UasRkJH0V2/bXi5kD5uJYPMtnCx+EdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168912; c=relaxed/simple;
	bh=FuCguuVw0/IbRkgUFDoJR4q344nRJjtf0zCv3l2Db8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsvVYM9AHSgHHgOMy1oR/419d2zCEHAng+gfI/cepIefYXeeNjAVyGAF4WBWKlgri8dbSTmfvrgqdbSK+JqgpgbcDtsTGzBRTC8HRnh1SOfTt5gVBZAT8RxOGjEQK9w700HR/jSWLp+AiBO4xbd/SHmeL5eTbekzYYKnRMKiThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HLk/KUaK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3AS2qu2891119;
	Mon, 3 Nov 2025 11:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xJOH/+SFUZum+YSFw74X9vYDqq68ZNJqBMEw6eEU7a4=; b=HLk/KUaK9bdziI8s
	czdt/FKH2U8vBvncRUYnxahiMyO73VAdHQLhcBhrSPIy0a6mmQskyg1ZRH6fh0bJ
	v/FnnlkX1xeptM5B+jETYd0SiEoD3bwigttV4G4o7rMJcAVKD3O+A99XH7xh4tQg
	omAas8UwCeAHyuqs4PN5rrO9hoFzvMBf6k/EQtF6lVhqTXwcoDn/qfv3NPEtmcUC
	ph3zR+6ZvklMWCWCSXyhAXDBE8Q9AaSlF5nOz17kGK4MZxyUc03NjVeG6AgbIhJt
	2sQxoFXJYTzOfPVTwbaWVp9pfUGAFmMbckzFqL5BRU59VD2vUTK8giVYzyv8mDiC
	fTLZfA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6tnrg46s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 11:21:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3BLjMj018173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 11:21:45 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 3 Nov 2025 03:21:44 -0800
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 06/12] wifi: ath12k: Remove the wifi7 header inclusions in common code
Date: Mon, 3 Nov 2025 16:51:05 +0530
Message-ID: <20251103112111.2260639-7-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwNCBTYWx0ZWRfX6lOp1fVWYKMq
 WR1xczeCXAK6/SUAWQMZaqdfg0VJCR22nh37HmH1DY0g73KvSwXPCR6Rsh9at71JtUBY08nypeV
 Ak9ScTVepTxXbW3qiIRjvnMMbxzGRghgqvhg/hlDMJ79nQ4IzPnwRuVJ4m3MOnQTS4qjxa9OiBA
 83SqQiQwwu844Ux5rR32aX2SmZTGRVnihFn/EY5TwGzM4b3ecBrB8PS0S8PfMNYVyDi8IsAOlhQ
 PqGwDfBNAKA69dyh+YDT3sUiBGQSSIvVPdmpJHp4KIpU42tBpUsrSfmGXga/bLWykA3z9MWGsiG
 ikhL5Kd42o4Iz+2qag7kQvwOh3ZpKxBpddJpTagd1Hi9zVP0bmfAj+jUdg1YgZPXXDJLMDcQ3gW
 WLhxLPSo2s1YwE7mLFtOZ9nOwC9s0g==
X-Proofpoint-GUID: bbjM27KqBCRR9AcPWrHfdgIJkmaxb7qf
X-Proofpoint-ORIG-GUID: bbjM27KqBCRR9AcPWrHfdgIJkmaxb7qf
X-Authority-Analysis: v=2.4 cv=BrSQAIX5 c=1 sm=1 tr=0 ts=6908904b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=HqjiOTPDgp-KCCF9HYwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030104

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

As a precursor to the movement of wifi7 specific .c files to
ath12k_wifi7.ko module, remove the wifi7 headers included
in the common .c files except for dp_mon.c file, as the changes
for moving the code from common to wifi7 directory for monitor
will be coming incrementally.

Since, dp_mon.c continues to be part of ath12k.ko module,
add a few callbacks in hal_ops to facilitate calls from
dp_mon.c to reach hal APIs present in ath12k_wifi7.ko module

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c         |  1 -
 drivers/net/wireless/ath/ath12k/core.c        |  1 -
 drivers/net/wireless/ath/ath12k/core.h        |  1 -
 drivers/net/wireless/ath/ath12k/dp.h          |  1 -
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 45 ++++++++------
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  1 -
 drivers/net/wireless/ath/ath12k/dp_rx.h       | 14 -----
 drivers/net/wireless/ath/ath12k/hal.c         | 18 ++++++
 drivers/net/wireless/ath/ath12k/hal.h         | 60 +++++++++++++++++++
 drivers/net/wireless/ath/ath12k/mac.c         |  1 -
 .../net/wireless/ath/ath12k/wifi7/hal_desc.h  | 46 --------------
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  2 +
 .../net/wireless/ath/ath12k/wifi7/hal_rx.c    | 19 +++---
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    | 15 ++---
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  2 +
 15 files changed, 129 insertions(+), 98 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index 91ee962ebc24..e9126c5d7f0c 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -15,7 +15,6 @@
 #include "ahb.h"
 #include "debug.h"
 #include "hif.h"
-#include "wifi7/dp.h"
 
 #define ATH12K_IRQ_CE0_OFFSET 4
 #define ATH12K_MAX_UPDS 1
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 4439f0a98ec4..912832b6004c 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -15,7 +15,6 @@
 #include "core.h"
 #include "dp_tx.h"
 #include "dp_rx.h"
-#include "wifi7/dp_rx.h"
 #include "debug.h"
 #include "debugfs.h"
 #include "fw.h"
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index e32fc1355c04..b001cecac34f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -27,7 +27,6 @@
 #include "ce.h"
 #include "mac.h"
 #include "hw.h"
-#include "wifi7/hal_desc.h"
 #include "reg.h"
 #include "dbring.h"
 #include "fw.h"
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 7877e862010c..17c919213c6a 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -11,7 +11,6 @@
 #include "dp_htt.h"
 #include "dp_cmn.h"
 #include <linux/rhashtable.h>
-#include "wifi7/hal_desc.h"
 
 #define MAX_RXDMA_PER_PDEV     2
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index ded47015c1d0..04473b04a7b6 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -17,6 +17,16 @@
 #define ATH12K_LE64_DEC_ENC(value, dec_bits, enc_bits) \
 		u32_encode_bits(le64_get_bits(value, dec_bits), enc_bits)
 
+static bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
+					struct hal_rx_desc *rx_desc)
+{
+	u32 tlv_tag;
+
+	tlv_tag = ab->hal.ops->rx_desc_get_mpdu_start_tag(rx_desc);
+
+	return tlv_tag == HAL_RX_MPDU_START;
+}
+
 static void
 ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
 				   struct hal_rx_user_status *rx_user_status)
@@ -1812,7 +1822,7 @@ ath12k_dp_rx_mon_buf_done(struct ath12k_base *ab, struct hal_srng *srng,
 	if (!status_desc)
 		return DP_MON_STATUS_NO_DMA;
 
-	ath12k_wifi7_hal_rx_buf_addr_info_get(status_desc, &paddr, &cookie, &rbm);
+	ath12k_hal_rx_buf_addr_info_get(&ab->hal, status_desc, &paddr, &cookie, &rbm);
 
 	buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
@@ -1856,7 +1866,8 @@ static u32 ath12k_dp_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id)
 }
 
 static
-void ath12k_dp_mon_next_link_desc_get(struct hal_rx_msdu_link *msdu_link,
+void ath12k_dp_mon_next_link_desc_get(struct ath12k_base *ab,
+				      struct hal_rx_msdu_link *msdu_link,
 				      dma_addr_t *paddr, u32 *sw_cookie, u8 *rbm,
 				      struct ath12k_buffer_addr **pp_buf_addr_info)
 {
@@ -1864,7 +1875,7 @@ void ath12k_dp_mon_next_link_desc_get(struct hal_rx_msdu_link *msdu_link,
 
 	buf_addr_info = &msdu_link->buf_addr_info;
 
-	ath12k_wifi7_hal_rx_buf_addr_info_get(buf_addr_info, paddr, sw_cookie, rbm);
+	ath12k_hal_rx_buf_addr_info_get(&ab->hal, buf_addr_info, paddr, sw_cookie, rbm);
 
 	*pp_buf_addr_info = buf_addr_info;
 }
@@ -2746,7 +2757,7 @@ int ath12k_dp_mon_status_bufs_replenish(struct ath12k_base *ab,
 
 		num_remain--;
 
-		ath12k_wifi7_hal_rx_buf_addr_info_set(desc, paddr, cookie, mgr);
+		ath12k_hal_rx_buf_addr_info_set(&ab->hal, desc, paddr, cookie, mgr);
 	}
 
 	ath12k_hal_srng_access_end(ab, srng);
@@ -3947,8 +3958,8 @@ static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 			pmon->buf_state = DP_MON_STATUS_REPLINISH;
 			break;
 		}
-		ath12k_wifi7_hal_rx_buf_addr_info_get(rx_mon_status_desc, &paddr,
-						      &cookie, &rbm);
+		ath12k_hal_rx_buf_addr_info_get(&ab->hal, rx_mon_status_desc, &paddr,
+						&cookie, &rbm);
 		if (paddr) {
 			buf_id = u32_get_bits(cookie, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
@@ -4033,8 +4044,8 @@ static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 
 		if (!skb) {
 			ath12k_warn(ab, "failed to alloc buffer for status ring\n");
-			ath12k_wifi7_hal_rx_buf_addr_info_set(rx_mon_status_desc, 0, 0,
-							      hal_params->rx_buf_rbm);
+			ath12k_hal_rx_buf_addr_info_set(&ab->hal, rx_mon_status_desc,
+							0, 0, hal_params->rx_buf_rbm);
 			num_buffs_reaped++;
 			break;
 		}
@@ -4043,9 +4054,8 @@ static int ath12k_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 		cookie = u32_encode_bits(mac_id, DP_RXDMA_BUF_COOKIE_PDEV_ID) |
 			 u32_encode_bits(buf_id, DP_RXDMA_BUF_COOKIE_BUF_ID);
 
-		ath12k_wifi7_hal_rx_buf_addr_info_set(rx_mon_status_desc, rxcb->paddr,
-						      cookie,
-						      hal_params->rx_buf_rbm);
+		ath12k_hal_rx_buf_addr_info_set(&ab->hal, rx_mon_status_desc, rxcb->paddr,
+						cookie, hal_params->rx_buf_rbm);
 		ath12k_hal_srng_src_get_next_entry(ab, srng);
 		num_buffs_reaped++;
 	}
@@ -4083,7 +4093,7 @@ ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 	dma_addr_t paddr;
 	u8 rbm;
 
-	ath12k_hal_rx_reo_ent_buf_paddr_get(ring_entry, &paddr,
+	ath12k_hal_rx_reo_ent_buf_paddr_get(&ab->hal, ring_entry, &paddr,
 					    &sw_cookie,
 					    &p_last_buf_addr_info, &rbm,
 					    &msdu_cnt);
@@ -4119,7 +4129,7 @@ ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 			dp->link_desc_banks[desc_bank].vaddr +
 			(paddr - dp->link_desc_banks[desc_bank].paddr);
 
-		ath12k_hal_rx_msdu_list_get(ar, msdu_link_desc, &msdu_list,
+		ath12k_hal_rx_msdu_list_get(&ar->ab->hal, ar, msdu_link_desc, &msdu_list,
 					    &num_msdus);
 		desc_info = ath12k_dp_get_rx_desc(ar->ab,
 						  msdu_list.sw_cookie[num_msdus - 1]);
@@ -4216,14 +4226,15 @@ ath12k_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 			list_add_tail(&desc_info->list, used_list);
 		}
 
-		ath12k_wifi7_hal_rx_buf_addr_info_set(&buf_info, paddr, sw_cookie, rbm);
+		ath12k_hal_rx_buf_addr_info_set(&ab->hal, &buf_info, paddr,
+						sw_cookie, rbm);
 
-		ath12k_dp_mon_next_link_desc_get(msdu_link_desc, &paddr,
+		ath12k_dp_mon_next_link_desc_get(ab, msdu_link_desc, &paddr,
 						 &sw_cookie, &rbm,
 						 &p_buf_addr_info);
 
-		ath12k_wifi7_dp_rx_link_desc_return(ar->ab, &buf_info,
-						    HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+		ath12k_dp_arch_rx_link_desc_return(ar->ab->dp, &buf_info,
+						   HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 
 		p_last_buf_addr_info = p_buf_addr_info;
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 5bc2aa52dd48..01faa76f8e06 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -12,7 +12,6 @@
 #include "debug.h"
 #include "hw.h"
 #include "dp_rx.h"
-#include "wifi7/dp_rx.h"
 #include "dp_tx.h"
 #include "peer.h"
 #include "dp_mon.h"
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index d995774168e5..3c0d66855999 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -136,16 +136,6 @@ static inline u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
 	return ab->hal.ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
 }
 
-static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
-					       struct hal_rx_desc *rx_desc)
-{
-	u32 tlv_tag;
-
-	tlv_tag = ab->hal.ops->rx_desc_get_mpdu_start_tag(rx_desc);
-
-	return tlv_tag == HAL_RX_MPDU_START;
-}
-
 static inline void ath12k_dp_rx_desc_get_dot11_hdr(struct ath12k_base *ab,
 						   struct hal_rx_desc *desc,
 						   struct ieee80211_hdr *hdr)
@@ -244,10 +234,6 @@ u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
 int ath12k_dp_rx_crypto_mic_len(struct ath12k_dp *dp, enum hal_encrypt_type enctype);
 u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
 				struct hal_rx_desc *rx_desc);
-bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
-				 struct hal_rx_desc *rx_desc);
-bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
-				 struct hal_rx_desc *rx_desc);
 void ath12k_dp_rx_h_ppdu(struct ath12k_pdev_dp *dp_pdev,
 			 struct hal_rx_desc_data *rx_info);
 struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_list,
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 3f9c2183c9a6..08063d1094ae 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -116,6 +116,24 @@ void ath12k_hal_rx_buf_addr_info_get(struct ath12k_hal *hal,
 	hal->ops->rx_buf_addr_info_get(binfo, paddr, msdu_cookies, rbm);
 }
 
+void ath12k_hal_rx_msdu_list_get(struct ath12k_hal *hal, struct ath12k *ar,
+				 void *link_desc,
+				 void *msdu_list,
+				 u16 *num_msdus)
+{
+	hal->ops->rx_msdu_list_get(ar, link_desc, msdu_list, num_msdus);
+}
+
+void ath12k_hal_rx_reo_ent_buf_paddr_get(struct ath12k_hal *hal, void *rx_desc,
+					 dma_addr_t *paddr,
+					 u32 *sw_cookie,
+					 struct ath12k_buffer_addr **pp_buf_addr,
+					 u8 *rbm, u32 *msdu_cnt)
+{
+	hal->ops->rx_reo_ent_buf_paddr_get(rx_desc, paddr, sw_cookie,
+					   pp_buf_addr, rbm, msdu_cnt);
+}
+
 void ath12k_hal_cc_config(struct ath12k_base *ab)
 {
 	ab->hal.ops->cc_config(ab);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 69c2e8b318d5..29bcedca0a3b 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -927,6 +927,51 @@ struct hal_srng {
 	} u;
 };
 
+/* hal_wbm_link_desc
+ *
+ *	Producer: WBM
+ *	Consumer: WBM
+ *
+ * buf_addr_info
+ *		Details of the physical address of a buffer or MSDU
+ *		link descriptor.
+ */
+
+enum hal_wbm_rel_src_module {
+	HAL_WBM_REL_SRC_MODULE_TQM,
+	HAL_WBM_REL_SRC_MODULE_RXDMA,
+	HAL_WBM_REL_SRC_MODULE_REO,
+	HAL_WBM_REL_SRC_MODULE_FW,
+	HAL_WBM_REL_SRC_MODULE_SW,
+	HAL_WBM_REL_SRC_MODULE_MAX,
+};
+
+/* hal_wbm_rel_desc_type
+ *
+ * msdu_buffer
+ *	The address points to an MSDU buffer
+ *
+ * msdu_link_descriptor
+ *	The address points to an Tx MSDU link descriptor
+ *
+ * mpdu_link_descriptor
+ *	The address points to an MPDU link descriptor
+ *
+ * msdu_ext_descriptor
+ *	The address points to an MSDU extension descriptor
+ *
+ * queue_ext_descriptor
+ *	The address points to an TQM queue extension descriptor. WBM should
+ *	treat this is the same way as a link descriptor.
+ */
+enum hal_wbm_rel_desc_type {
+	HAL_WBM_REL_DESC_TYPE_REL_MSDU,
+	HAL_WBM_REL_DESC_TYPE_MSDU_LINK,
+	HAL_WBM_REL_DESC_TYPE_MPDU_LINK,
+	HAL_WBM_REL_DESC_TYPE_MSDU_EXT,
+	HAL_WBM_REL_DESC_TYPE_QUEUE_EXT,
+};
+
 /* Interrupt mitigation - Batch threshold in terms of number of frames */
 #define HAL_SRNG_INT_BATCH_THRESHOLD_TX 256
 #define HAL_SRNG_INT_BATCH_THRESHOLD_RX 128
@@ -1335,6 +1380,14 @@ struct hal_ops {
 	void (*cc_config)(struct ath12k_base *ab);
 	enum hal_rx_buf_return_buf_manager
 		(*get_idle_link_rbm)(struct ath12k_hal *hal, u8 device_id);
+	void (*rx_msdu_list_get)(struct ath12k *ar,
+				 void *link_desc,
+				 void *msdu_list,
+				 u16 *num_msdus);
+	void (*rx_reo_ent_buf_paddr_get)(void *rx_desc, dma_addr_t *paddr,
+					 u32 *sw_cookie,
+					 struct ath12k_buffer_addr **pp_buf_addr,
+					 u8 *rbm, u32 *msdu_cnt);
 };
 
 dma_addr_t ath12k_hal_srng_get_tp_addr(struct ath12k_base *ab,
@@ -1417,4 +1470,11 @@ void ath12k_hal_rx_buf_addr_info_get(struct ath12k_hal *hal,
 void ath12k_hal_cc_config(struct ath12k_base *ab);
 enum hal_rx_buf_return_buf_manager
 ath12k_hal_get_idle_link_rbm(struct ath12k_hal *hal, u8 device_id);
+void ath12k_hal_rx_msdu_list_get(struct ath12k_hal *hal, struct ath12k *ar,
+				 void *link_desc, void *msdu_list,
+				 u16 *num_msdus);
+void ath12k_hal_rx_reo_ent_buf_paddr_get(struct ath12k_hal *hal, void *rx_desc,
+					 dma_addr_t *paddr, u32 *sw_cookie,
+					 struct ath12k_buffer_addr **pp_buf_addr,
+					 u8 *rbm, u32 *msdu_cnt);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d04606559cdf..a079f80ef546 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -14,7 +14,6 @@
 #include "wmi.h"
 #include "hw.h"
 #include "dp_tx.h"
-#include "wifi7/dp_tx.h"
 #include "dp_rx.h"
 #include "testmode.h"
 #include "peer.h"
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
index 17e46acc8e34..81506adf156a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
@@ -1596,52 +1596,6 @@ struct hal_wbm_link_desc {
 	struct ath12k_buffer_addr buf_addr_info;
 } __packed;
 
-/* hal_wbm_link_desc
- *
- *	Producer: WBM
- *	Consumer: WBM
- *
- * buf_addr_info
- *		Details of the physical address of a buffer or MSDU
- *		link descriptor.
- */
-
-enum hal_wbm_rel_src_module {
-	HAL_WBM_REL_SRC_MODULE_TQM,
-	HAL_WBM_REL_SRC_MODULE_RXDMA,
-	HAL_WBM_REL_SRC_MODULE_REO,
-	HAL_WBM_REL_SRC_MODULE_FW,
-	HAL_WBM_REL_SRC_MODULE_SW,
-	HAL_WBM_REL_SRC_MODULE_MAX,
-};
-
-enum hal_wbm_rel_desc_type {
-	HAL_WBM_REL_DESC_TYPE_REL_MSDU,
-	HAL_WBM_REL_DESC_TYPE_MSDU_LINK,
-	HAL_WBM_REL_DESC_TYPE_MPDU_LINK,
-	HAL_WBM_REL_DESC_TYPE_MSDU_EXT,
-	HAL_WBM_REL_DESC_TYPE_QUEUE_EXT,
-};
-
-/* hal_wbm_rel_desc_type
- *
- * msdu_buffer
- *	The address points to an MSDU buffer
- *
- * msdu_link_descriptor
- *	The address points to an Tx MSDU link descriptor
- *
- * mpdu_link_descriptor
- *	The address points to an MPDU link descriptor
- *
- * msdu_ext_descriptor
- *	The address points to an MSDU extension descriptor
- *
- * queue_ext_descriptor
- *	The address points to an TQM queue extension descriptor. WBM should
- *	treat this is the same way as a link descriptor.
- */
-
 #define HAL_WBM_COMPL_RX_INFO0_REL_SRC_MODULE		GENMASK(2, 0)
 #define HAL_WBM_COMPL_RX_INFO0_BM_ACTION		GENMASK(5, 3)
 #define HAL_WBM_COMPL_RX_INFO0_DESC_TYPE		GENMASK(8, 6)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 3ccd689bbf1c..f13376b7faa1 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -1026,5 +1026,7 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_buf_addr_info_get = ath12k_wifi7_hal_rx_buf_addr_info_get,
 	.cc_config = ath12k_wifi7_hal_cc_config,
 	.get_idle_link_rbm = ath12k_wifi7_hal_get_idle_link_rbm,
+	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
+	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 };
 EXPORT_SYMBOL(hal_qcn9274_ops);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 47d047d87c34..b137967eba65 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -457,10 +457,10 @@ void ath12k_wifi7_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
 	*cookie = le32_get_bits(buff_addr->info1, BUFFER_ADDR_INFO1_SW_COOKIE);
 }
 
-void ath12k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr,
-					 u32 *sw_cookie,
-					 struct ath12k_buffer_addr **pp_buf_addr,
-					 u8 *rbm, u32 *msdu_cnt)
+void ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr,
+					       u32 *sw_cookie,
+					       struct ath12k_buffer_addr **pp_buf_addr,
+					       u8 *rbm, u32 *msdu_cnt)
 {
 	struct hal_reo_entrance_ring *reo_ent_ring =
 		(struct hal_reo_entrance_ring *)rx_desc;
@@ -488,11 +488,14 @@ void ath12k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr,
 	*pp_buf_addr = (void *)buf_addr_info;
 }
 
-void ath12k_hal_rx_msdu_list_get(struct ath12k *ar,
-				 struct hal_rx_msdu_link *link_desc,
-				 struct hal_rx_msdu_list *msdu_list,
-				 u16 *num_msdus)
+void ath12k_wifi7_hal_rx_msdu_list_get(struct ath12k *ar,
+				       void *link_desc_opaque,
+				       void *msdu_list_opaque, u16 *num_msdus)
 {
+	struct hal_rx_msdu_link *link_desc =
+				(struct hal_rx_msdu_link *)link_desc_opaque;
+	struct hal_rx_msdu_list *msdu_list =
+				(struct hal_rx_msdu_list *)msdu_list_opaque;
 	struct hal_rx_msdu_details *msdu_details = NULL;
 	struct rx_msdu_desc *msdu_desc_info = NULL;
 	u32 last = 0, first = 0;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index 23da5b871983..cdc9bb6db93c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -866,13 +866,14 @@ int ath12k_wifi7_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
 void ath12k_wifi7_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
 					   struct ath12k_buffer_addr *buff_addr,
 					   dma_addr_t *paddr, u32 *cookie);
-void ath12k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr, u32 *sw_cookie,
-					 struct ath12k_buffer_addr **pp_buf_addr,
-					 u8 *rbm, u32 *msdu_cnt);
-void ath12k_hal_rx_msdu_list_get(struct ath12k *ar,
-				 struct hal_rx_msdu_link *link_desc,
-				 struct hal_rx_msdu_list *msdu_list,
-				 u16 *num_msdus);
+void ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr,
+					       u32 *sw_cookie,
+					       struct ath12k_buffer_addr **pp_buf_addr,
+					       u8 *rbm, u32 *msdu_cnt);
+void ath12k_wifi7_hal_rx_msdu_list_get(struct ath12k *ar,
+				       void *link_desc,
+				       void *msdu_list_opaque,
+				       u16 *num_msdus);
 void ath12k_wifi7_hal_reo_init_cmd_ring(struct ath12k_base *ab,
 					struct hal_srng *srng);
 void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 8966de3d64a4..a73e7539a27a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -799,5 +799,7 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_buf_addr_info_get = ath12k_wifi7_hal_rx_buf_addr_info_get,
 	.cc_config = ath12k_wifi7_hal_cc_config,
 	.get_idle_link_rbm = ath12k_wifi7_hal_get_idle_link_rbm,
+	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
+	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 };
 EXPORT_SYMBOL(hal_wcn7850_ops);
-- 
2.34.1



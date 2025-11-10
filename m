Return-Path: <linux-wireless+bounces-28742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA9C45F7E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E42B4E4848
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13A301474;
	Mon, 10 Nov 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k09YL5j0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F73002D8
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771052; cv=none; b=N/l6LmoWLoU4w3U7Ex1oYCBXs14eRVZ5ahKm8132S9Lpe7VXCSlFCCmhmCJHK3FAkSls/X1/09EeU2N2SDPhlzzldSfJye1ldsXBZJoYLdKTXoks5XdHqMeH98GLWawVMVcOK+LD2VZM9UJfUCsxxPaLEpdqaDgTc8D23OeGJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771052; c=relaxed/simple;
	bh=2lYeZNCFaMbPyy20aIMrfpybvL8A354kexVynT5rZBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aEUNclaf4Lb7x0FSER7xiO1wom3cyv4SrVVn+9kw0C+ryWHrjkm+03M386TUQqI7bJjQjZsf5YvXm8CW3CkHuawQVWx7Ly03+IulRhzpUYfRMDGgQLYffVRmFafUhdFWNzxkK/pXTmR2U35rBYjcLosPLQ/8w7axNttrI1tvrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k09YL5j0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA7voEj1558322;
	Mon, 10 Nov 2025 10:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9+mgnS9mNSu
	/KofPDxUAvomwiROJskyc9zzY4Pk8kkA=; b=k09YL5j08MEs4EniruPzljaVRUi
	n5fwskpj//MXOEnnxx3G/MAFQNJmdWDyPBJnQ7Det2kQLOvSqVdefj+4ExnCYfIw
	RJ90AzHPxk+aOn3lwLOI3epQlUIuiiTgRXswVPN30qMe1lTvCbgwS+tWLsb5i9kQ
	Wr/7SBctl0C+/n2d5npI3k0xr1VTby6+cf3reTHX91A2+AK4xPtO3A4SWBVi7VAr
	vetme3ByPh7BzkGoYWVDR+i9Yko+FAweIGBFuUZYYqCktLasTisqJ9RyVVMJ0eFj
	X/hUC9ydayHNpMKgaiQEM+B6rwqT/TBV+0tCElDmzkMte+YF/QSzd7xvPqw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuemc22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAAbIFK008144;
	Mon, 10 Nov 2025 10:37:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a9xxkq1gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AAAbIca008100;
	Mon, 10 Nov 2025 10:37:18 GMT
Received: from hu-devc-blr-u22-c.qualcomm.com (hu-aloksing-blr.qualcomm.com [10.190.111.138])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5AAAbIt8008095
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:37:18 +0000
Received: by hu-devc-blr-u22-c.qualcomm.com (Postfix, from userid 2272527)
	id A5E4BB76; Mon, 10 Nov 2025 16:07:16 +0530 (+0530)
From: Alok Singh <quic_aloksing@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Alok Singh <quic_aloksing@quicinc.com>
Subject: [PATCH ath12k-ng 12/12] wifi: ath12k: Remove Wi-Fi 7 header dependencies from common ath12k module
Date: Mon, 10 Nov 2025 16:07:13 +0530
Message-Id: <20251110103713.3484779-13-quic_aloksing@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
References: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MiBTYWx0ZWRfXwgvjRQfWECqw
 4HGh1LLyBfqXE4q9bEF7J3jRGSxHW3GO+fjmdEPkMZ1EH/O5va7Pcazlv/J2+qoB0+ZPA3VPXFE
 CwKmx7uyQP1t9RMLOUjKCJCoe/El2jrhr8zFgeH9mCAt9oyEd+cvXNlOvQYaQSMjqXXeSp6UjSD
 AorK4RBVf7QwC6MUbGWmfPM9soDDsw/YjOsDS4w7/TZ0Gh+Ajdx/OQrn4yqBjNser2kvrcJ8ed6
 U9fYtbpjepat65fAkBdSPw56KDpBf2GP0xPUgTwqEci9uGC4P/jwG38rauAXX794N8gLB+cmEOI
 pSpc5VN3zWhoe05Wb3aVovMzgP0y1r+N/54iBPHkzSqAXQaFuuvkn7jPIg32PBbhF2R4ie+MVrS
 nApbOQ+q9rFtI1YKGTRwwNia++HWqA==
X-Proofpoint-GUID: W9t5cWB7NW5bEDoZL4A5Bz7BEmOjA9FD
X-Proofpoint-ORIG-GUID: W9t5cWB7NW5bEDoZL4A5Bz7BEmOjA9FD
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=6911c062 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=EKKoQqBRwk3AXvOLPQgA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100092

Remove all remaining Wi-Fi 7 header dependencies from dp_mon.c to
finalize separation of Wi-Fi 7 specific monitor mode functionality.

Remove these includes from dp_mon.c:
- wifi7/hal_desc.h
- wifi7/hal_qcn9274.h
- wifi7/dp_rx.h

Relocate hal_mon_buf_ring from wifi7/hal_desc.h to hal.h.

Relocate HAL_RX_UL_OFDMA_USER_INFO_V0_W0_VALID and HAL_RX_FCS_LEN
macros from wifi7/hal_rx.h to hal.h or dp_rx.h as appropriate.

Move the following functions to the new file wifi7/dp_mon.c
and add the ath12k_wifi7 prefix:
- ath12k_dp_mon_rx_merg_msdus()
- ath12k_dp_mon_update_radiotap()
- ath12k_dp_mon_rx_deliver_msdu()
- ath12k_dp_mon_get_buf_len()
- ath12k_dp_mon_rx_deliver()

Export several helper functions needed by the ath12k_wifi7 module.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Alok Singh <quic_aloksing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c      | 110 +++---------------
 drivers/net/wireless/ath/ath12k/dp_mon.h      |  27 +++--
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   9 ++
 drivers/net/wireless/ath/ath12k/hal.h         |  28 +++++
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    |  99 ++++++++++++++--
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |   8 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   8 --
 .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |  19 ---
 .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |  10 --
 9 files changed, 165 insertions(+), 153 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 4f7c7748be6c..23ddba557001 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -6,8 +6,6 @@
 
 #include "dp_mon.h"
 #include "debug.h"
-#include "wifi7/hal_qcn9274.h"
-#include "wifi7/dp_rx.h"
 #include "dp_tx.h"
 #include "peer.h"
 
@@ -205,7 +203,7 @@ static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k_base *ab,
 	skb_pull(head_msdu, total_offset);
 }
 
-static struct sk_buff *
+struct sk_buff *
 ath12k_dp_mon_rx_merg_msdus(struct ath12k_pdev_dp *dp_pdev,
 			    struct dp_mon_mpdu *mon_mpdu,
 			    struct hal_rx_mon_ppdu_info *ppdu_info,
@@ -333,6 +331,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k_pdev_dp *dp_pdev,
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_rx_merg_msdus);
 
 static void
 ath12k_dp_mon_rx_update_radiotap_he(struct hal_rx_mon_ppdu_info *rx_status,
@@ -382,10 +381,10 @@ ath12k_dp_mon_rx_update_radiotap_he_mu(struct hal_rx_mon_ppdu_info *rx_status,
 	rtap_buf[rtap_len] = rx_status->he_RU[3];
 }
 
-static void ath12k_dp_mon_update_radiotap(struct ath12k_pdev_dp *dp_pdev,
-					  struct hal_rx_mon_ppdu_info *ppduinfo,
-					  struct sk_buff *mon_skb,
-					  struct ieee80211_rx_status *rxs)
+void ath12k_dp_mon_update_radiotap(struct ath12k_pdev_dp *dp_pdev,
+				   struct hal_rx_mon_ppdu_info *ppduinfo,
+				   struct sk_buff *mon_skb,
+				   struct ieee80211_rx_status *rxs)
 {
 	struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
 	struct ieee80211_supported_band *sband;
@@ -487,12 +486,13 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k_pdev_dp *dp_pdev,
 
 	rxs->mactime = ppduinfo->tsft;
 }
+EXPORT_SYMBOL(ath12k_dp_mon_update_radiotap);
 
-static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
-					  struct napi_struct *napi,
-					  struct sk_buff *msdu,
-					  struct ieee80211_rx_status *status,
-					  u8 decap)
+void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
+				   struct napi_struct *napi,
+				   struct sk_buff *msdu,
+				   struct ieee80211_rx_status *status,
+				   u8 decap)
 {
 	struct ath12k_dp *dp = dp_pdev->dp;
 	struct ath12k_base *ab = dp->ab;
@@ -521,7 +521,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 		status->flag |= RX_FLAG_RADIOTAP_HE;
 	}
 
-	ath12k_wifi7_dp_extract_rx_desc_data(dp->hal, &rx_info, rx_desc, rx_desc);
+	ath12k_dp_extract_rx_desc_data(dp->hal, &rx_info, rx_desc, rx_desc);
 
 	rcu_read_lock();
 	spin_lock_bh(&dp->dp_lock);
@@ -581,62 +581,7 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
 
 	ieee80211_rx_napi(ath12k_pdev_dp_to_hw(dp_pdev), pubsta, msdu, napi);
 }
-
-int ath12k_dp_mon_rx_deliver(struct ath12k_pdev_dp *dp_pdev,
-			     struct dp_mon_mpdu *mon_mpdu,
-			     struct hal_rx_mon_ppdu_info *ppduinfo,
-			     struct napi_struct *napi)
-{
-	struct sk_buff *mon_skb, *skb_next, *header;
-	struct ieee80211_rx_status *rxs = &dp_pdev->rx_status;
-	u8 decap = DP_RX_DECAP_TYPE_RAW;
-
-	mon_skb = ath12k_dp_mon_rx_merg_msdus(dp_pdev, mon_mpdu, ppduinfo, rxs);
-	if (!mon_skb)
-		goto mon_deliver_fail;
-
-	header = mon_skb;
-	rxs->flag = 0;
-
-	if (mon_mpdu->err_bitmap & HAL_RX_MPDU_ERR_FCS)
-		rxs->flag = RX_FLAG_FAILED_FCS_CRC;
-
-	do {
-		skb_next = mon_skb->next;
-		if (!skb_next)
-			rxs->flag &= ~RX_FLAG_AMSDU_MORE;
-		else
-			rxs->flag |= RX_FLAG_AMSDU_MORE;
-
-		if (mon_skb == header) {
-			header = NULL;
-			rxs->flag &= ~RX_FLAG_ALLOW_SAME_PN;
-		} else {
-			rxs->flag |= RX_FLAG_ALLOW_SAME_PN;
-		}
-		rxs->flag |= RX_FLAG_ONLY_MONITOR;
-
-		if (!(rxs->flag & RX_FLAG_ONLY_MONITOR))
-			decap = mon_mpdu->decap_format;
-
-		ath12k_dp_mon_update_radiotap(dp_pdev, ppduinfo, mon_skb, rxs);
-		ath12k_dp_mon_rx_deliver_msdu(dp_pdev, napi, mon_skb, rxs, decap);
-		mon_skb = skb_next;
-	} while (mon_skb);
-	rxs->flag = 0;
-
-	return 0;
-
-mon_deliver_fail:
-	mon_skb = mon_mpdu->head;
-	while (mon_skb) {
-		skb_next = mon_skb->next;
-		dev_kfree_skb_any(mon_skb);
-		mon_skb = skb_next;
-	}
-	return -EINVAL;
-}
-EXPORT_SYMBOL(ath12k_dp_mon_rx_deliver);
+EXPORT_SYMBOL(ath12k_dp_mon_rx_deliver_msdu);
 
 int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len)
 {
@@ -657,33 +602,6 @@ int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len)
 }
 EXPORT_SYMBOL(ath12k_dp_pkt_set_pktlen);
 
-/* Hardware fill buffer with 128 bytes aligned. So need to reap it
- * with 128 bytes aligned.
- */
-#define RXDMA_DATA_DMA_BLOCK_SIZE 128
-
-void
-ath12k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
-			  bool *is_frag, u32 *total_len,
-			  u32 *frag_len, u32 *msdu_cnt)
-{
-	if (info->msdu_flags & RX_MSDU_DESC_INFO0_MSDU_CONTINUATION) {
-		*is_frag = true;
-		*frag_len = (RX_MON_STATUS_BASE_BUF_SIZE -
-			     sizeof(struct hal_rx_desc)) &
-			     ~(RXDMA_DATA_DMA_BLOCK_SIZE - 1);
-		*total_len += *frag_len;
-	} else {
-		if (*is_frag)
-			*frag_len = info->msdu_len - *total_len;
-		else
-			*frag_len = info->msdu_len;
-
-		*msdu_cnt -= 1;
-	}
-}
-EXPORT_SYMBOL(ath12k_dp_mon_get_buf_len);
-
 int
 ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
 			       struct ath12k_mon_data *pmon,
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index f5debe947ad6..394463ea19e0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -96,21 +96,32 @@ ath12k_dp_mon_rx_update_peer_mu_stats(struct ath12k_base *ab,
 void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k_dp_link_peer *peer,
 					   struct hal_rx_mon_ppdu_info *ppdu_info);
 int ath12k_dp_pkt_set_pktlen(struct sk_buff *skb, u32 len);
-int ath12k_dp_mon_rx_deliver(struct ath12k_pdev_dp *dp_pdev,
-			     struct dp_mon_mpdu *mon_mpdu,
-			     struct hal_rx_mon_ppdu_info *ppduinfo,
-			     struct napi_struct *napi);
 struct sk_buff
 *ath12k_dp_rx_alloc_mon_status_buf(struct ath12k_base *ab,
 				   struct dp_rxdma_mon_ring *rx_ring,
 				   int *buf_id);
-void
-ath12k_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
-			  bool *is_frag, u32 *total_len,
-			  u32 *frag_len, u32 *msdu_cnt);
 u32 ath12k_dp_mon_comp_ppduid(u32 msdu_ppdu_id, u32 *ppdu_id);
 int
 ath12k_dp_mon_parse_status_buf(struct ath12k_pdev_dp *dp_pdev,
 			       struct ath12k_mon_data *pmon,
 			       const struct dp_mon_packet_info *packet_info);
+void ath12k_dp_mon_update_radiotap(struct ath12k_pdev_dp *dp_pdev,
+				   struct hal_rx_mon_ppdu_info *ppduinfo,
+				   struct sk_buff *mon_skb,
+				   struct ieee80211_rx_status *rxs);
+void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
+				   struct napi_struct *napi,
+				   struct sk_buff *msdu,
+				   struct ieee80211_rx_status *status,
+				   u8 decap);
+void ath12k_dp_mon_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev,
+				   struct napi_struct *napi,
+				   struct sk_buff *msdu,
+				   struct ieee80211_rx_status *status,
+				   u8 decap);
+struct sk_buff *
+ath12k_dp_mon_rx_merg_msdus(struct ath12k_pdev_dp *dp_pdev,
+			    struct dp_mon_mpdu *mon_mpdu,
+			    struct hal_rx_mon_ppdu_info *ppdu_info,
+			    struct ieee80211_rx_status *rxs);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index a4ac67eb91d1..88651553120d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -165,6 +165,15 @@ static inline void ath12k_dp_clean_up_skb_list(struct sk_buff_head *skb_list)
 		dev_kfree_skb_any(skb);
 }
 
+static inline
+void ath12k_dp_extract_rx_desc_data(struct ath12k_hal *hal,
+				    struct hal_rx_desc_data *rx_info,
+				    struct hal_rx_desc *rx_desc,
+				    struct hal_rx_desc *ldesc)
+{
+	hal->ops->extract_rx_desc_data(rx_info, rx_desc, ldesc);
+}
+
 void ath12k_dp_rx_h_undecap(struct ath12k_pdev_dp *dp_pdev, struct sk_buff *msdu,
 			    struct hal_rx_desc *rx_desc,
 			    enum hal_encrypt_type enctype,
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 1d22173975f0..ce038906bd06 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -73,6 +73,16 @@ struct ath12k_base;
 #define HAL_RX_MAX_NSS         8
 #define HAL_RX_MAX_NUM_LEGACY_RATES 12
 
+#define HAL_RX_UL_OFDMA_USER_INFO_V0_W0_VALID		BIT(30)
+#define HAL_RX_UL_OFDMA_USER_INFO_V0_W0_VER		BIT(31)
+#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_NSS		GENMASK(2, 0)
+#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_MCS		GENMASK(6, 3)
+#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_LDPC		BIT(7)
+#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_DCM		BIT(8)
+#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_RU_START	GENMASK(15, 9)
+#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_RU_SIZE		GENMASK(18, 16)
+#define HAL_RX_FCS_LEN                          4
+
 enum hal_srng_ring_id {
 	HAL_SRNG_RING_ID_REO2SW0 = 0,
 	HAL_SRNG_RING_ID_REO2SW1,
@@ -597,6 +607,24 @@ struct hal_rx_msdu_desc_info {
 	u16 msdu_len; /* 14 bits for length */
 };
 
+/* hal_mon_buf_ring
+ *	Producer : SW
+ *	Consumer : Monitor
+ *
+ * paddr_lo
+ *	Lower 32-bit physical address of the buffer pointer from the source ring.
+ * paddr_hi
+ *	bit range 7-0 : upper 8 bit of the physical address.
+ *	bit range 31-8 : reserved.
+ * cookie
+ *	Consumer: RxMon/TxMon 64 bit cookie of the buffers.
+ */
+struct hal_mon_buf_ring {
+	__le32 paddr_lo;
+	__le32 paddr_hi;
+	__le64 cookie;
+};
+
 struct hal_rx_mon_ppdu_info {
 	u32 ppdu_id;
 	u32 last_ppdu_id;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index 6d829d3e1b0c..9878553289c4 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -31,6 +31,32 @@ ath12k_wifi7_dp_mon_rx_memset_ppdu_info(struct hal_rx_mon_ppdu_info *ppdu_info)
 	ppdu_info->peer_id = HAL_INVALID_PEERID;
 }
 
+/* Hardware fill buffer with 128 bytes aligned. So need to reap it
+ * with 128 bytes aligned.
+ */
+#define RXDMA_DATA_DMA_BLOCK_SIZE 128
+
+static void
+ath12k_wifi7_dp_mon_get_buf_len(struct hal_rx_msdu_desc_info *info,
+				bool *is_frag, u32 *total_len,
+				u32 *frag_len, u32 *msdu_cnt)
+{
+	if (info->msdu_flags & RX_MSDU_DESC_INFO0_MSDU_CONTINUATION) {
+		*is_frag = true;
+		*frag_len = (RX_MON_STATUS_BASE_BUF_SIZE -
+			     sizeof(struct hal_rx_desc)) &
+			     ~(RXDMA_DATA_DMA_BLOCK_SIZE - 1);
+		*total_len += *frag_len;
+	} else {
+		if (*is_frag)
+			*frag_len = info->msdu_len - *total_len;
+		else
+			*frag_len = info->msdu_len;
+
+		*msdu_cnt -= 1;
+	}
+}
+
 static void
 ath12k_wifi7_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
 					 struct hal_rx_user_status *rx_user_status)
@@ -2373,6 +2399,62 @@ ath12k_wifi7_dp_mon_tx_status_get_num_user(u16 tlv_tag,
 	return tlv_status;
 }
 
+static int
+ath12k_wifi7_dp_mon_rx_deliver(struct ath12k_pdev_dp *dp_pdev,
+			       struct dp_mon_mpdu *mon_mpdu,
+			       struct hal_rx_mon_ppdu_info *ppduinfo,
+			       struct napi_struct *napi)
+{
+	struct sk_buff *mon_skb, *skb_next, *header;
+	struct ieee80211_rx_status *rxs = &dp_pdev->rx_status;
+	u8 decap = DP_RX_DECAP_TYPE_RAW;
+
+	mon_skb = ath12k_dp_mon_rx_merg_msdus(dp_pdev, mon_mpdu, ppduinfo, rxs);
+	if (!mon_skb)
+		goto mon_deliver_fail;
+
+	header = mon_skb;
+	rxs->flag = 0;
+
+	if (mon_mpdu->err_bitmap & HAL_RX_MPDU_ERR_FCS)
+		rxs->flag = RX_FLAG_FAILED_FCS_CRC;
+
+	do {
+		skb_next = mon_skb->next;
+		if (!skb_next)
+			rxs->flag &= ~RX_FLAG_AMSDU_MORE;
+		else
+			rxs->flag |= RX_FLAG_AMSDU_MORE;
+
+		if (mon_skb == header) {
+			header = NULL;
+			rxs->flag &= ~RX_FLAG_ALLOW_SAME_PN;
+		} else {
+			rxs->flag |= RX_FLAG_ALLOW_SAME_PN;
+		}
+		rxs->flag |= RX_FLAG_ONLY_MONITOR;
+
+		if (!(rxs->flag & RX_FLAG_ONLY_MONITOR))
+			decap = mon_mpdu->decap_format;
+
+		ath12k_dp_mon_update_radiotap(dp_pdev, ppduinfo, mon_skb, rxs);
+		ath12k_dp_mon_rx_deliver_msdu(dp_pdev, napi, mon_skb, rxs, decap);
+		mon_skb = skb_next;
+	} while (mon_skb);
+	rxs->flag = 0;
+
+	return 0;
+
+mon_deliver_fail:
+	mon_skb = mon_mpdu->head;
+	while (mon_skb) {
+		skb_next = mon_skb->next;
+		dev_kfree_skb_any(mon_skb);
+		mon_skb = skb_next;
+	}
+	return -EINVAL;
+}
+
 static void
 ath12k_wifi7_dp_mon_tx_process_ppdu_info(struct ath12k_pdev_dp *dp_pdev,
 					 struct napi_struct *napi,
@@ -2385,8 +2467,8 @@ ath12k_wifi7_dp_mon_tx_process_ppdu_info(struct ath12k_pdev_dp *dp_pdev,
 		list_del(&mon_mpdu->list);
 
 		if (mon_mpdu->head)
-			ath12k_dp_mon_rx_deliver(dp_pdev, mon_mpdu,
-						 &tx_ppdu_info->rx_status, napi);
+			ath12k_wifi7_dp_mon_rx_deliver(dp_pdev, mon_mpdu,
+						       &tx_ppdu_info->rx_status, napi);
 
 		kfree(mon_mpdu);
 	}
@@ -2606,9 +2688,9 @@ ath12k_wifi7_dp_rx_mon_mpdu_pop(struct ath12k *ar, int mac_id,
 				pmon->mon_last_linkdesc_paddr = paddr;
 				is_first_msdu = false;
 			}
-			ath12k_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
-						  &is_frag, &total_len,
-						  &frag_len, &msdu_cnt);
+			ath12k_wifi7_dp_mon_get_buf_len(&msdu_list.msdu_info[i],
+							&is_frag, &total_len,
+							&frag_len, &msdu_cnt);
 			rx_buf_size = rx_pkt_offset + l2_hdr_offset + frag_len;
 
 			if (ath12k_dp_pkt_set_pktlen(msdu, rx_buf_size)) {
@@ -2748,8 +2830,8 @@ ath12k_wifi7_dp_rx_mon_dest_process(struct ath12k *ar, int mac_id,
 			tmp_mpdu->tail = tail_msdu;
 			tmp_mpdu->err_bitmap = pmon->err_bitmap;
 			tmp_mpdu->decap_format = pmon->decap_format;
-			ath12k_dp_mon_rx_deliver(&ar->dp, tmp_mpdu,
-						 &pmon->mon_ppdu_info, napi);
+			ath12k_wifi7_dp_mon_rx_deliver(&ar->dp, tmp_mpdu,
+						       &pmon->mon_ppdu_info, napi);
 			rx_mon_stats->dest_mpdu_done++;
 			kfree(tmp_mpdu);
 		}
@@ -2883,7 +2965,8 @@ ath12k_wifi7_dp_mon_rx_parse_mon_status(struct ath12k_pdev_dp *dp_pdev,
 		list_del(&mon_mpdu->list);
 
 		if (mon_mpdu->head && mon_mpdu->tail)
-			ath12k_dp_mon_rx_deliver(dp_pdev, mon_mpdu, ppdu_info, napi);
+			ath12k_wifi7_dp_mon_rx_deliver(dp_pdev, mon_mpdu,
+						       ppdu_info, napi);
 
 		kfree(mon_mpdu);
 	}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 08dcf170b801..af50dafc0349 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -524,7 +524,7 @@ static int ath12k_wifi7_dp_rx_process_msdu(struct ath12k_pdev_dp *dp_pdev,
 	rx_desc = (struct hal_rx_desc *)msdu->data;
 	lrx_desc = (struct hal_rx_desc *)last_buf->data;
 
-	ath12k_wifi7_dp_extract_rx_desc_data(hal, rx_info, rx_desc, lrx_desc);
+	ath12k_dp_extract_rx_desc_data(hal, rx_info, rx_desc, lrx_desc);
 	if (!rx_info->msdu_done) {
 		ath12k_warn(dp->ab, "msdu_done bit in msdu_end is not set\n");
 		ret = -EIO;
@@ -1035,7 +1035,7 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 	(ATH12K_SKB_RXCB(msdu))->is_first_msdu = true;
 	(ATH12K_SKB_RXCB(msdu))->is_last_msdu = true;
 
-	ath12k_wifi7_dp_extract_rx_desc_data(hal, rx_info, rx_desc, rx_desc);
+	ath12k_dp_extract_rx_desc_data(hal, rx_info, rx_desc, rx_desc);
 
 	rxs->flag |= RX_FLAG_MMIC_ERROR | RX_FLAG_MMIC_STRIPPED |
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
@@ -1333,7 +1333,7 @@ ath12k_wifi7_dp_process_rx_err_buf(struct ath12k_pdev_dp *dp_pdev,
 	}
 
 	rx_desc = (struct hal_rx_desc *)msdu->data;
-	ath12k_wifi7_dp_extract_rx_desc_data(hal, &rx_info, rx_desc, rx_desc);
+	ath12k_dp_extract_rx_desc_data(hal, &rx_info, rx_desc, rx_desc);
 
 	msdu_len = rx_info.msdu_len;
 	if ((msdu_len + hal_rx_desc_sz) > DP_RX_BUFFER_SIZE) {
@@ -1714,7 +1714,7 @@ static void ath12k_wifi7_dp_rx_wbm_err(struct ath12k_pdev_dp *dp_pdev,
 	rx_info.addr2_present = false;
 	rx_info.rx_status = &rxs;
 
-	ath12k_wifi7_dp_extract_rx_desc_data(dp->hal, &rx_info, rx_desc, rx_desc);
+	ath12k_dp_extract_rx_desc_data(dp->hal, &rx_info, rx_desc, rx_desc);
 
 	switch (rxcb->err_rel_src) {
 	case HAL_WBM_REL_SRC_MODULE_REO:
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index 2d3eb2313b2f..d15bffe223c7 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -52,12 +52,4 @@ int ath12k_wifi7_peer_rx_tid_reo_update(struct ath12k_dp *dp,
 bool
 ath12k_wifi7_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 				  struct hal_rx_desc *rx_desc);
-static inline
-void ath12k_wifi7_dp_extract_rx_desc_data(struct ath12k_hal *hal,
-					  struct hal_rx_desc_data *rx_info,
-					  struct hal_rx_desc *rx_desc,
-					  struct hal_rx_desc *ldesc)
-{
-	hal->ops->extract_rx_desc_data(rx_info, rx_desc, ldesc);
-}
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
index aecbf00ea87b..fb1bbe5c94cd 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
@@ -2681,25 +2681,6 @@ struct hal_tcl_entrance_from_ppe_ring {
 	__le32 info0;
 } __packed;
 
-struct hal_mon_buf_ring {
-	__le32 paddr_lo;
-	__le32 paddr_hi;
-	__le64 cookie;
-};
-
-/* hal_mon_buf_ring
- *	Producer : SW
- *	Consumer : Monitor
- *
- * paddr_lo
- *	Lower 32-bit physical address of the buffer pointer from the source ring.
- * paddr_hi
- *	bit range 7-0 : upper 8 bit of the physical address.
- *	bit range 31-8 : reserved.
- * cookie
- *	Consumer: RxMon/TxMon 64 bit cookie of the buffers.
- */
-
 #define HAL_MON_DEST_COOKIE_BUF_ID      GENMASK(17, 0)
 
 #define HAL_MON_DEST_INFO0_END_OFFSET		GENMASK(11, 0)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index c5a2125a04af..926fbcd2d8b8 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -45,7 +45,6 @@ struct hal_rx_mon_status_tlv_hdr {
 #define HAL_TLV_STATUS_PPDU_DONE                1
 #define HAL_TLV_STATUS_BUF_DONE                 2
 #define HAL_TLV_STATUS_PPDU_NON_STD_DONE        3
-#define HAL_RX_FCS_LEN                          4
 
 enum hal_rx_mon_status {
 	HAL_RX_MON_STATUS_PPDU_NOT_DONE,
@@ -365,15 +364,6 @@ struct hal_rx_resp_req_info {
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_2 0xBDBEEF
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_3 0xCDBEEF
 
-#define HAL_RX_UL_OFDMA_USER_INFO_V0_W0_VALID		BIT(30)
-#define HAL_RX_UL_OFDMA_USER_INFO_V0_W0_VER		BIT(31)
-#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_NSS		GENMASK(2, 0)
-#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_MCS		GENMASK(6, 3)
-#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_LDPC		BIT(7)
-#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_DCM		BIT(8)
-#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_RU_START	GENMASK(15, 9)
-#define HAL_RX_UL_OFDMA_USER_INFO_V0_W1_RU_SIZE		GENMASK(18, 16)
-
 /* HE Radiotap data1 Mask */
 #define HE_SU_FORMAT_TYPE 0x0000
 #define HE_EXT_SU_FORMAT_TYPE 0x0001
-- 
2.34.1



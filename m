Return-Path: <linux-wireless+bounces-29874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C724CCA051
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13D953034615
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD48E26ED59;
	Thu, 18 Dec 2025 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oab8U++j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B6m5Hf6g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2BC26E6F0
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022934; cv=none; b=goHE5ssEi0WzZUKZsSgUP8LWAc6R3rR05s9KRNQfS7oxH2bzPr4BAn05HBQb6ybpWs6/KQSlB+Pp+ghDLrbQCueE1R4wjGGSvjOXPgSgLzZhEeFhVmafoos0gK2g0Sk5l0t84ELcVyN3y0vz285nvV3vrx97KeRkvpfwbvx0MuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022934; c=relaxed/simple;
	bh=n+OSDQn9ODWN33E3X+uYd0VUYy09utKv5MW9wFkwnOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cV7xBGl/7UtcRTWce6kXfyzAUew713rQIPRsvcQbcdoUchoem1VMTcKLZ06CE4Pqj7bSxAUwlh08Qy16CO4TRbkMrVnGmCdd4Ng4GkkrVEJ+5bOb8cOKMznebl0G6K9a8nXiDV57ba1r48PTfOk9tp8NehljC2nRtmhZZ/+x1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oab8U++j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B6m5Hf6g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YUZf4057274
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f6RdSgZXj1yWlDovsnupc8A6+Yof29U8kequtY5oc4Q=; b=oab8U++jmxez6Ij5
	XR2s38T2pQdp8uPOMpKbkP47sKNivxqf3q4IJqeqWdMIar70HdrlQS8dzopwwFja
	IHR8EnxVWqljUFomxkztbsGEvJ+RvSI1cCkQbSKf+vGkhcB1EhyqbkaeMdvovwvT
	ENQWO99T9bg4X9akJ4yvCbsaQQ5WYKDZDC/yeJmOR/Vl9uWhWYvwGSQezm8m58PY
	6Trc6OXgl1j/mATwcTYIgVY680eQUEqjX+wUuuERYpHbC9J3B4JHaWmYy9MexpCR
	He9WnLH706lMYIPyBHaTRVq4968nwby1aKMzWf7re0cE+4J9glohJ3Qgmm2J250i
	zg0uGg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3xr59qn1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f1f69eec6so1822145ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022931; x=1766627731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6RdSgZXj1yWlDovsnupc8A6+Yof29U8kequtY5oc4Q=;
        b=B6m5Hf6g568HGWkZNgjhFrOWCfYgjw8txu5mpstB494P6Hv8x+p3Y3NtbBHjlFnxB+
         /a2tWg+zXKGmKN7wkvZ12jlh3TQ0fXjd5uTiPfM/SGd9kUUm/zRfZpepxXELm5UJZEy0
         mE4lnKNHyWPck9tU9HqZ+nuZl52Xgs2uiLQdu5sIIO1njV2c0LODAaKZ20XsOaaVZ2Gd
         r1AE4zR+QkFFvnIAG2Bis84hKpC4X8gEPfqeCGvk8DOFUn9AH5Gt0jYrAWQE7Y1hHBYP
         PD3erUSbD97qaF13F243IzymtnQgh4CYwkKn+VU5qf8/GC9cY/cVbkuDUbSt5L1phe2q
         cuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022931; x=1766627731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6RdSgZXj1yWlDovsnupc8A6+Yof29U8kequtY5oc4Q=;
        b=I/UhvygbnhCuCrIM8QP913ZATWBYjegrRoCjOitzx5C3LzTIArDMWxG3dwQm3tL0Vn
         Yxe2RcsCKySzNOfFtOnH0FTeVqfKnZqOa/4iU4xIBSJ+C+HCXbKkY2ebrokb83W3VS/T
         Vq3KoHPavGz8hfxVIq6A7XQBvs7AttYadIpEVTSgNex4IU9KuT2+DGktYzh6EIjX7BpJ
         FvxVhHwqr/wEgvw0IlpB443eujt3tjG0liu4eEQnac+SD/Ti13R2Mnr/pWy6qhH2F4xb
         F8OKNS+YSi2uOLZFE5MbFhoKJOBg99BXbTSH+jlSYP7pUPLHdGoavwcKWLXKxKvCl09x
         9JHQ==
X-Gm-Message-State: AOJu0YyUF1gCDCP3bcHdNDFZWpKJNEq29WXlCkp+47qLyIYaa5X+dSO0
	G1wqdIr++Fcbn1LshBD5so4PMVyTMjqVbGOyWj8oQ5QDYuocdRTxeRwQnbxyJXuhRGNvpNetE0K
	yMr2l7VnnlHZlzst3z0VFtxXDqrA4jqH29gJDr5L/bJJJHl391Dgu65l/Lv8xZYeb45dRCIju9J
	Q3xl6D
X-Gm-Gg: AY/fxX7PeaBw1vwrIrPwqFmTbZonxqKvs/2MUAz8uK7+NiQYYZBPnkoWI9LDdhjLQQX
	Nh6N61H0nTZdL3yXbnRJfXeIlDqKIndhZx+Wq+JQUvuV5XoWmMRlu0WTkXwykifakLLznR9iFkI
	bsmKZQerfuzmow3GPcgZtmmc0xmzEs1D7hwr0+em1CMGu+03UfRcqpRUd+VEIaytkfnhZC+B4Lm
	C2tHgY3kCUd9NdmuRmYH4IcU4hZ/66+Kfa9a5okW56m8vMXR23afLcL6hEEv+LTAAmzNUYfyqZE
	pZlu19Mw/PBi9NwuRmTAp0r5JE/kcnMPNYjKt8Gog8r0mKLJ90t36mooj0OjHbXMmORfxPb8gQU
	3hyrmWo2G69wAnqz61p6IjRS2H+32PlOt9Oivd9EP9V6ko6P6BWFtviUsLBCPAMM=
X-Received: by 2002:a17:902:cec7:b0:246:7a43:3f66 with SMTP id d9443c01a7336-29f23de4a8fmr206125535ad.7.1766022930553;
        Wed, 17 Dec 2025 17:55:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE0JBFDic937dc0W+SsYrBqU1p5SoIu1slPWGusjs5l82W2GoN00f2zLU+rfldt7IPpPn1fg==
X-Received: by 2002:a17:902:cec7:b0:246:7a43:3f66 with SMTP id d9443c01a7336-29f23de4a8fmr206125235ad.7.1766022930034;
        Wed, 17 Dec 2025 17:55:30 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:29 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:27 +0800
Subject: [PATCH ath-next 13/19] wifi: ath12k: add hardware ops support for
 QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-13-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: KnkwAe_Tt4UbdIDh0NzBtCr8UqOE56rI
X-Authority-Analysis: v=2.4 cv=DsBbOW/+ c=1 sm=1 tr=0 ts=69435f13 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=JvaljHK-8QMZ73MRPjUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfXxGIcQX+upV7Z
 bkqplKjNyZl+EBjdjqiERIHnYw49T4cjF+pHPr08UA0QYTHiSlAYajnZwK49wJF2ESbOk5ZIZjs
 wCCun9U5RDbjvgrJy9j7iC8kNCiSmmcOvDulMo8jPegVKp+fK4N6/FGCbFQoKex724ExOnnH2eN
 DZUSGtXsC6WdiVfuWea1JchtlK77FH4SoaE2IqEDrQk0+G/+4WNl404x5CT0OPpTveGKH4LZsW9
 HKgRoEvpRPx0yCTztxyo5xRO9kLPWb7OimmTXA3xMmb8nyZO24CQaZGJuICsZtbonlUirwR3jQe
 jiEz6Y7Fmj/hXmIB7NivvzY0Ge07Jdkn7rC6IFxNJOLj443oioSSWzMfTUU//MZPoKmFjlhJJKH
 92KXWw8q6oS38kgm5/+QFXmA8uyu3g==
X-Proofpoint-ORIG-GUID: KnkwAe_Tt4UbdIDh0NzBtCr8UqOE56rI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

Due to HAL descriptors, QCC2027 has different offsets of MPDU start tag
and MSDU end tag, compared with other chips. Hence add new hardware
ops structure for QCC2072. All ops are directly taken from WCN7850, with
the exception to rxdma_ring_sel_config, which needs a new function
ath12k_dp_rxdma_ring_sel_config_qcc2072() to handle the difference
mentioned above.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      | 44 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h      |  1 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    | 10 +++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.h    |  3 ++
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         | 12 +++++-
 5 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index dc8d72aeca45..7450938adf65 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -9,6 +9,7 @@
 #include "../peer.h"
 #include "hal_qcn9274.h"
 #include "hal_wcn7850.h"
+#include "hal_qcc2072.h"
 
 static u16 ath12k_wifi7_dp_rx_get_peer_id(struct ath12k_dp *dp,
 					  enum ath12k_peer_metadata_version ver,
@@ -2110,6 +2111,49 @@ int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab)
 	return ret;
 }
 
+int ath12k_dp_rxdma_ring_sel_config_qcc2072(struct ath12k_base *ab)
+{
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
+	u32 ring_id;
+	int ret = 0;
+	u32 hal_rx_desc_sz = ab->hal.hal_desc_sz;
+	int i;
+
+	ring_id = dp->rx_refill_buf_ring.refill_buf_ring.ring_id;
+
+	tlv_filter.rx_filter = HTT_RX_TLV_FLAGS_RXDMA_RING;
+	tlv_filter.pkt_filter_flags2 = HTT_RX_FP_CTRL_PKT_FILTER_TLV_FLAGS2_BAR;
+	tlv_filter.pkt_filter_flags3 = HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_MCAST |
+				       HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_UCAST |
+				       HTT_RX_FP_DATA_PKT_FILTER_TLV_FLASG3_NULL_DATA;
+	tlv_filter.offset_valid = true;
+	tlv_filter.rx_packet_offset = hal_rx_desc_sz;
+
+	tlv_filter.rx_header_offset = offsetof(struct hal_rx_desc_qcc2072, pkt_hdr_tlv);
+
+	tlv_filter.rx_mpdu_start_offset =
+		ath12k_hal_rx_desc_get_mpdu_start_offset_qcc2072();
+	tlv_filter.rx_msdu_end_offset =
+		ath12k_hal_rx_desc_get_msdu_end_offset_qcc2072();
+
+	/*
+	 * TODO: Selectively subscribe to required qwords within msdu_end
+	 * and mpdu_start and setup the mask in below msg
+	 * and modify the rx_desc struct
+	 */
+
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+		ring_id = dp->rx_mac_buf_ring[i].ring_id;
+		ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id, i,
+						       HAL_RXDMA_BUF,
+						       DP_RXDMA_REFILL_RING_SIZE,
+						       &tlv_filter);
+	}
+
+	return ret;
+}
+
 void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_dp *dp)
 {
 	struct ath12k_base *ab = dp->ab;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
index a98836b83f48..8aa79faf567f 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -22,6 +22,7 @@ int ath12k_wifi7_dp_rx_process(struct ath12k_dp *dp, int mac_id,
 void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_dp *dp);
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
+int ath12k_dp_rxdma_ring_sel_config_qcc2072(struct ath12k_base *ab);
 void ath12k_wifi7_dp_setup_pn_check_reo_cmd(struct ath12k_hal_reo_cmd *cmd,
 					    struct ath12k_dp_rx_tid *rx_tid,
 					    u32 cipher, enum set_key_cmd key_cmd);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
index 847484ece204..522b94b04f9f 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -454,3 +454,13 @@ const struct hal_ops hal_qcc2072_ops = {
 	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
 	.reo_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
 };
+
+u32 ath12k_hal_rx_desc_get_mpdu_start_offset_qcc2072(void)
+{
+	return offsetof(struct hal_rx_desc_qcc2072, mpdu_start_tag);
+}
+
+u32 ath12k_hal_rx_desc_get_msdu_end_offset_qcc2072(void)
+{
+	return offsetof(struct hal_rx_desc_qcc2072, msdu_end_tag);
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h
index 392bfbb6a412..6de943df7786 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h
@@ -8,3 +8,6 @@
 
 extern const struct ath12k_hw_regs qcc2072_regs;
 extern const struct hal_ops hal_qcc2072_ops;
+
+u32 ath12k_hal_rx_desc_get_mpdu_start_offset_qcc2072(void);
+u32 ath12k_hal_rx_desc_get_msdu_end_offset_qcc2072(void);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index 03732370b58e..610db63475cb 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -170,6 +170,16 @@ static const struct ath12k_hw_ops wcn7850_ops = {
 	.is_frame_link_agnostic = ath12k_wifi7_is_frame_link_agnostic_wcn7850,
 };
 
+static const struct ath12k_hw_ops qcc2072_ops = {
+	.get_hw_mac_from_pdev_id = ath12k_wifi7_hw_qcn9274_mac_from_pdev_id,
+	.mac_id_to_pdev_id = ath12k_wifi7_hw_mac_id_to_pdev_id_wcn7850,
+	.mac_id_to_srng_id = ath12k_wifi7_hw_mac_id_to_srng_id_wcn7850,
+	.rxdma_ring_sel_config = ath12k_dp_rxdma_ring_sel_config_qcc2072,
+	.get_ring_selector = ath12k_wifi7_hw_get_ring_selector_wcn7850,
+	.dp_srng_is_tx_comp_ring = ath12k_wifi7_dp_srng_is_comp_ring_wcn7850,
+	.is_frame_link_agnostic = ath12k_wifi7_is_frame_link_agnostic_wcn7850,
+};
+
 #define ATH12K_TX_RING_MASK_0 0x1
 #define ATH12K_TX_RING_MASK_1 0x2
 #define ATH12K_TX_RING_MASK_2 0x4
@@ -678,7 +688,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_WCN7850,
 		.internal_sleep_clock = true,
 
-		.hw_ops = &wcn7850_ops,
+		.hw_ops = &qcc2072_ops,
 		.ring_mask = &ath12k_wifi7_hw_ring_mask_wcn7850,
 
 		.host_ce_config = ath12k_wifi7_host_ce_config_wcn7850,

-- 
2.25.1



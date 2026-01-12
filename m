Return-Path: <linux-wireless+bounces-30684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EE2D10EAD
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB9693067066
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE99330B0E;
	Mon, 12 Jan 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J7DVajdI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cCO5m2En"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C930CD82
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203438; cv=none; b=pVnocan0wdgA9TNrczbfeccYCoZOZSE23dCpd8mj+WIGziDkmuc7GlLWjRyzN0j6f0kQdZUiwpovEBPO2+8H55Qx+d7rUuSdf+m2SF77IM3KPrdLBs9Jwzv3tP3ychjtRwkhfA2pB6n7d3iOwIJUxM4U+mvAGqCNU8XIJEBGXuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203438; c=relaxed/simple;
	bh=G82P5Rzo7lPEUSrPMBuvxL2iZNrIqNhPHTjYSxFwlFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4t4D4Ok98EtwJR20oGodgmqH34pbmelO9tyFLbpimxDfklU90zeBAhiZBXY+LbFyaNZ9BN1P5/GbLLgAOUXMGtfu4dM7V/9tKfFYo7wk5QGYiUGGF+hQIXpdJt6C9HVdB5OlwYHH9rj2jfTAbWFxv5oBzeKeD0HjhKJHbH3Bgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J7DVajdI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cCO5m2En; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNC88D3631311
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gux+YAeNwcnKrHcfx0XLVSy/UlMzXiR9/nR145kzg18=; b=J7DVajdIGAkpbPeZ
	tM3v6AP/85WgqTUDR8o6qDRAkSb/fJcQE7+nPBlI6BopE5RZURNRC4gGoGIH9jxO
	Np1IXi/SmDnmxTYJ2n6yzxVEArMfp/U0KJkLU7NxvmznUYOIariK+U+dUneCIWDG
	itFw05r6JbPNvtP9fWImSuuK17Y1YBva7sIEEmItB6S6E2G83ngd5WzzDsAmQE3i
	Uzm8I0rBjzrRCe9B1K21WNlkwqdWl3oulLPvMFLkzVvBLLmHlD109cVjbym9FFha
	RMDxM1fB/yNuCyz5C+z+ZpoyZnsNhM9Cia/+CQ8xYA9zKVQUiVE6ZKPZ+ReylJvX
	hlLoaQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkjvxumjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso4673193a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203436; x=1768808236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gux+YAeNwcnKrHcfx0XLVSy/UlMzXiR9/nR145kzg18=;
        b=cCO5m2EnqZyMIPrsFZfSw5ux00c5xd7+LHyPiLKxcAy8C7ePBdZF4WxXhSdSbQQGiF
         M4IufQeYsaCSIQCLyYPuNptqp0mTxGZ3jnV3rJkkJo428puzM8OfA4GOdw6bzonSQB8o
         o5/6eJpNBaW8S+L9gTMAVOtYpmu+V61l3I3KrR/Tr5IRa7rlJEZKQ4JcACtukbwKBCSd
         2Ts14AK9aFBSQSJHkstPRfM3dZAVzzizwMayeO2I2DobCrjh9HpZ0zhujC5jULmts0G+
         7pN8O86egdTK/K1J3RPQo5MFQbKbDGq+NBsMa73yQRb/1gv6523AyJbTJUsC2gzE+wbv
         anGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203436; x=1768808236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gux+YAeNwcnKrHcfx0XLVSy/UlMzXiR9/nR145kzg18=;
        b=nMij9JcBuZIPLZqd/s9BoKgWVPYOanCtV/nfhlLzKPamcdCrQrYFHtoeBNq1wL9hNn
         k0HwkQy/13mWtJSy2VOJVKh5W4BepyRq794VOctLkWZEzmx970uR5BE6/7IxtDOo8YIz
         rFR39wINGLjnDzdBqzR2ocCxXEskfmYdR1RhKJoNOlwq5wFvC8nmrF58WMhMqZiZ1WMI
         a36gTX++HkatRsEC3KSHYpxt5phm1UGqL7eWgK/g6f3kZDGzwJc9UsX4UE/+OgZLbB9g
         ZqBEPwYNeYMblhVQbfUdEA1k2WIwHJ/OAgDknjEpvN6bavjZId0UzskVIJ70CDalaEEA
         +4tA==
X-Gm-Message-State: AOJu0YzXr2o5Yq8WIG4O9w4AppTw2vVDvwkz1XcMUtjVi6aClF4aeopj
	BbyWp3svvQFXjWlCyd7frbnE6J3Tm8OUgQ9mOCsfz1Vc/qiGeduwex3znIWcoJlWs21y5RvOb/H
	hNbH/k7Wm6STcgDNdGOrFRFmoL3ZTT9lMEQ2pSLzt8N72nSGNPC41DVmJm5Y26uAMNVkEEg==
X-Gm-Gg: AY/fxX6rYOHuUFms5VC9tLRsGO4Mw/YAOHvia9tbg0t4hwrzI527QvB3KrixieaSYU2
	NuZvuHQRMdDWZNBhI72TEVaXfcDuk2eAqF5fick/QbB6VbuROUHIa+2ABgt1jP6WgHvxP3i7DqG
	EmlyfeAbexBvhyxfPD764tumb5ymSxgwC0CHX00WkSUdZgupWzwWbpPDsk9r85aCLL0HgNvocfE
	TbmFe8XokLB7XYCXFpCK5MMFum5kMWThzUT74R58xciEIaS7jL5eUGcY8BWxnYll30fdrrfXT+1
	8YUcTn6dCV5D+hxtdM9+F6GOB5956Gbyt48AI1HveZnoNFm4M/EuJrUC9MoXuBX3aElti68e0I8
	fu6O1djrjejhYpmLPSB2Mk/rElFgMaRTajFBGh2n8M6aC2DvxSbSf69z/zhpo5J8=
X-Received: by 2002:a05:6a20:939e:b0:2cf:afc1:cc3c with SMTP id adf61e73a8af0-3898e9f5a98mr15349420637.16.1768203435702;
        Sun, 11 Jan 2026 23:37:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU1ipMulfXL1gNlpo+dxtnYSolORyI9IdCUFLphGPJdYXH+3hpMdXhvg+vppkoPddP5JXkPg==
X-Received: by 2002:a05:6a20:939e:b0:2cf:afc1:cc3c with SMTP id adf61e73a8af0-3898e9f5a98mr15349405637.16.1768203435179;
        Sun, 11 Jan 2026 23:37:15 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:14 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:32 +0800
Subject: [PATCH ath-next v2 12/18] wifi: ath12k: add hardware ops support
 for QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-12-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Wrsm8Nfv c=1 sm=1 tr=0 ts=6964a4ac cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=JvaljHK-8QMZ73MRPjUA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: seWpaJOkoW2ylQ7MriNNiI9-O83rvqS-
X-Proofpoint-ORIG-GUID: seWpaJOkoW2ylQ7MriNNiI9-O83rvqS-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX7E+t5NB+obu8
 y0ajZn1CcD5jlZS3P5QPHzpCqVlFpsUfufaNi4h73kV9ziFAOJNH4xAv9jWced4oto2AW0XtHkC
 QwkAiEWFUUFGSI3ZdSuyi4qvxhmN+juTuKPOPYYz3PPCub/fC48AzZj3yLrtdei2k6fXxVcZHBr
 H1HrEFN5WaUh10LCzYUUwEQ6XCcpkHpaxcSir48aG1AIU4ebc3jSPPFeU/uTGwnCt3A9+1nB3U3
 RmjAQEtwaGxVtmASMApXtoHBJ6EwGYy65vXfoiynuNZcTpxRhZXv6Z5paH8P2tlFfWOioGPStlv
 VkAzpfk2VcVTF3S2UWXVqavzn0j1i3Exd/3vOCjQJpT212NbRLoPNeFT5rxC4iRoMr4rTMS4Ry1
 bplZq50w5vu/7UstlwXsqD30w6qvrAZHFI5xkODle+VUPTCQGLtlc2qQKEakulFmKao60LnxmrN
 CYEr38NniLu/JGOF8Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

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
index 38c388319e00..f75690f586cd 100644
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
@@ -673,7 +683,7 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_WCN7850,
 		.internal_sleep_clock = true,
 
-		.hw_ops = &wcn7850_ops,
+		.hw_ops = &qcc2072_ops,
 		.ring_mask = &ath12k_wifi7_hw_ring_mask_wcn7850,
 
 		.host_ce_config = ath12k_wifi7_host_ce_config_wcn7850,

-- 
2.25.1



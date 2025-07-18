Return-Path: <linux-wireless+bounces-25627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1A7B099F8
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 04:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F1F1C4525A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 02:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F61C84DD;
	Fri, 18 Jul 2025 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KZAh9+0k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BFBA923
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752807332; cv=none; b=unKuOf6oA3YRKKqLvM5XeVU4OJ/z0UQIXPVf63QvTOF4oDBkphoq4ZMHxl7VpDk0ckHsqDcDT9BZOWwwyqJT+oU5jcMlLatIn20N0IxoNWBCMgMPEbmc/NxHt/RxAhxtv1q/PZuHOd2gdSWFUdoXJLjzF17WltjHyL8Rk2ifYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752807332; c=relaxed/simple;
	bh=Q9IZPNFQYVpW0gUevIjplLPwwAeG/AwOhTE6TNtz+8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cQG8SbRabgw9G2ZPqzeUR8Z7AdKes6ERUZfKmCuYapl+eiat2mM08uxcgbYLcNdMhPseLsXy7VQ5BrRtDIMWXyJHc0r30HOtWNBLoqqqtLGeeTR87/lCQJ2Sbj18joZmO8zCUozF9iyQFY3ObYTYmQDJfrCE2lJHIYZLmTeBI8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KZAh9+0k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HNSYHB007293
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=ZAfqWAgTVp/NnDNsyZslnXqzroALmVm6Sk3ncdH7uvs=; b=KZ
	Ah9+0kGR5mGrTpYUE6j1e5ZiHHHk2lvUeVPK3Dn6BAnYbm/toyDvUzbGr7Mdfh7+
	DQWVFQn3e3zu+0PUNWcfgLiLZmaS1XyAq1/Zh+AKWFt39KP2JbY2hYGLoPaE96bi
	19i8HSIdtM7Vv9EVYL+ZKelyn2JvgzdiNMIJ/WLRpuYn23UB6/jE5MpcRi+40NGm
	Z/AFp3JrI5Njbm69lST+3x0XLdZFBWqdCBR3l5BdfceCE75yXaS7p8igq9zIoMxI
	jyGOjXg0yPQK7+jBr4NZQkKRyqwMnA5f6b05CKKoOpm+2ThFVXjMVcvtyXW5cORg
	MPmqAvkUelC6IlPqYayw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfcab2r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 02:55:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-756bb07b029so1528494b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 19:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752807328; x=1753412128;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAfqWAgTVp/NnDNsyZslnXqzroALmVm6Sk3ncdH7uvs=;
        b=vUqgAfE0YSgVBjV/nZAeFf20rTSzcsbEU9TiVMXAgFBLbamvkDYN7eRmh2Tbf48yHY
         F1JazgtRZDqkmLHMLVwJUEVG+JZOkegzamOsJZujm+7svaKTVHUNtFxFP3+5u6rUWkLb
         tp1HpeBZX6MgpY77QtEmFFg4BEhnL9Aj36VIpxAdGNuQI82HdKw0d78nS2FqKMfQ5fCz
         +dyhEbKGDZ80Ieq0ivVWnob45RUEPnMI1wwIDAjXA3nqCWw9t51KaCPluOQdxE9OIlqx
         g7Z8DQVSoON2F24CHJoFYBBd5CAa7vLFfDk55u3/QWxWwoq2vjmFsM+0MJiaqpPTQwXx
         zo+Q==
X-Gm-Message-State: AOJu0Yzsu/8UBXBzYVZmsvHLbdplTbmKudl8k5qDV/yABiTE/nH80TCM
	/POnCbkS35VV8Cm2j4jbgEKMflX0K3R9n1/k0fr2Y46clvCNOLxEbpICrw7iX2iN+c9B6h5AIX9
	551WILN2jS6b7EASDMU9oPFEAobDuVXQEkULmCNYPwm0szz3d2qnBZ4/0gKzyDovwD+hBUeYWI2
	PSCQ==
X-Gm-Gg: ASbGncu+4I06dFZXoT6okN3fl5HTK709HRncwTAfihKkpG8A4Yao3FtZaX3TVN6cHcO
	n9OjYznh7MgQWX0llf8xx6LKldU8Muqzqe0iay0Q+ev3XSSq5FoOCCw33liadYUQKJ52z45gltm
	bXQCuD5DFBPVfzLe11cqu9D3Jtetp0G2sGUpU0PYNVk4AHE/h+VnhGemHuWUsDTSrjuh7lR1AvV
	sORidOn0MZbEyqIXyr+LWCItHLEFzaqtFr53YfQN0DhNY5aps0Q0yS/DQN2VJIyJMRND33LlrPN
	KTZjOYqP3tJPfF6PYuhx1g0C9cjDNAVDY5ukbMdQkLoubvA1C1XG5eK7gf9U1J1sGyohi7ngkCc
	G9NkgX2aH5qXWdYoyr5AIsUFvzMKPS3UfVh2susIi0mxfozQ760adY9xsBt1QF9KJOqIegDk9ag
	==
X-Received: by 2002:a05:6a00:2384:b0:73e:23be:11fc with SMTP id d2e1a72fcca58-75725088c14mr10625307b3a.22.1752807328411;
        Thu, 17 Jul 2025 19:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJaxGMSo85A75leA05HTzStwaZIG0R5PNPtoGxVpVxbJnlscIkYklP+7z+1XlAhEFv9TfflA==
X-Received: by 2002:a05:6a00:2384:b0:73e:23be:11fc with SMTP id d2e1a72fcca58-75725088c14mr10625277b3a.22.1752807327830;
        Thu, 17 Jul 2025 19:55:27 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68095sm255334b3a.139.2025.07.17.19.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 19:55:27 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next v2 1/3] wifi: ath12k: Fix the handling of TX packets in Ethernet mode
Date: Fri, 18 Jul 2025 08:25:11 +0530
Message-Id: <20250718025513.32982-2-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDAyMSBTYWx0ZWRfX2LA53SgC8lPg
 9FYn4vrBK2V4+JlKi3C5TPTYNOYxtlJAtGGB3p8F71gZwppZunwo921qbKlUuK+7bHebbEGc1jW
 AfwVfo1ViidzwAR4yD8yG08Kwhu8yZAMwfJ0shUCgwjS1DpB8J5Q9OA+Y6y0MVRqhPZOb0hvJEu
 lj0BP3ot4SN1PtPR/XXcd5o7Dl3fosgcggt8XS9tNizy5J0HkD8A3o5+IYt+Oxk8As9RF33PIFZ
 kaF45SuGepbO3XA1lFyyEDcp2avSNapVe2/xX35hFtBSgjSsAlQNpbRp6PkCnMNDPc7VUq05vSb
 jeQAw1EHbUB7996jMknM2ZlM6Qukw61K4p8vip4IuFmADtFFbz01VtN9bPuiLCSyu89ASC8SwuA
 dGwBrMMhueRX2EmVAwxUAuYiVYjbHWmpHjMZ/OZbJbQd/Kyx+EQt0j6Ps0pM5URYXnGyGrdO
X-Proofpoint-GUID: rocRKTMsNqjPE9b5wR0SmpAjt9l3Z5aw
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=6879b7a2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=vl7YvmKCL5Z24jtCxAEA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: rocRKTMsNqjPE9b5wR0SmpAjt9l3Z5aw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180021
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, in the transmit (TX) direction, EAPOL, QoS NULL,
and multicast frames are sent in native Wi-Fi (802.11) format.
However, when the virtual interface is configured in Ethernet
mode, transmission fails for packets enqueued in native Wi-fi format.

To address this issue, the firmware should be instructed to
treat these packets as RAW type packets, ensuring proper
handling even when the interface operates in Ethernet mode.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00217-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 38 ++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.c   |  1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 1fa37cda1046..e8d3bcc90a2d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -244,6 +244,8 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 	bool msdu_ext_desc = false;
 	bool add_htt_metadata = false;
 	u32 iova_mask = ab->hw_params->iova_mask;
+	bool is_diff_encap = false;
+	bool is_null_frame = false;
 
 	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
 		return -ESHUTDOWN;
@@ -334,7 +336,19 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 
 	switch (ti.encap_type) {
 	case HAL_TCL_ENCAP_TYPE_NATIVE_WIFI:
-		ath12k_dp_tx_encap_nwifi(skb);
+		is_null_frame = ieee80211_is_nullfunc(hdr->frame_control);
+		if (ahvif->vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED) {
+			if (skb->protocol == cpu_to_be16(ETH_P_PAE) || is_null_frame)
+				is_diff_encap = true;
+
+			/* Firmware expects msdu ext descriptor for nwifi/raw packets
+			 * received in ETH mode. Without this, observed tx fail for
+			 * Multicast packets in ETH mode.
+			 */
+			msdu_ext_desc = true;
+		} else {
+			ath12k_dp_tx_encap_nwifi(skb);
+		}
 		break;
 	case HAL_TCL_ENCAP_TYPE_RAW:
 		if (!test_bit(ATH12K_FLAG_RAW_MODE, &ab->dev_flags)) {
@@ -378,15 +392,25 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 		goto fail_remove_tx_buf;
 	}
 
-	if (!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
-	    !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
-	    !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
-	    ieee80211_has_protected(hdr->frame_control)) {
-		/* Add metadata for sw encrypted vlan group traffic */
+	if ((!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
+	     !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
+	     !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
+	     ieee80211_has_protected(hdr->frame_control)) ||
+	     is_diff_encap) {
+		/* Firmware is not expecting meta data for qos null
+		 * nwifi packet received in ETH encap mode.
+		 */
+		if (is_null_frame && msdu_ext_desc)
+			goto skip_htt_meta;
+
+		/* Add metadata for sw encrypted vlan group traffic
+		 * and EAPOL nwifi packet received in ETH encap mode.
+		 */
 		add_htt_metadata = true;
 		msdu_ext_desc = true;
-		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TO_FW);
 		ti.meta_data_flags |= HTT_TCL_META_DATA_VALID_HTT;
+skip_htt_meta:
+		ti.flags0 |= u32_encode_bits(1, HAL_TCL_DATA_CMD_INFO2_TO_FW);
 		ti.encap_type = HAL_TCL_ENCAP_TYPE_RAW;
 		ti.encrypt_type = HAL_ENCRYPT_TYPE_OPEN;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 42eb9e8e14d1..3a33eccc0d1d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8869,6 +8869,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 		is_dvlan = true;
 
 	if (!vif->valid_links || !is_mcast || is_dvlan ||
+	    (skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) ||
 	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
 		ret = ath12k_dp_tx(ar, arvif, skb, false, 0, is_mcast);
 		if (unlikely(ret)) {
-- 
2.17.1



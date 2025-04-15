Return-Path: <linux-wireless+bounces-21562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC673A8A6F7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06A844303A
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A3224243;
	Tue, 15 Apr 2025 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVhmLOP1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9741F542E
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742473; cv=none; b=kx6tY9SMLAMgbltGEkOqu088gZ8RJ9stdgyuLa8rBCEitsH54pL3HquFaicz46bXmt8hdIPAIOLr1Skx8vCLKv7jBFl6FOe4Hih/m4D8T2o/7o5wIecVSBEpyEIqTndw8M2kucNTiECBHKaITpvIU8yW8dINLmwTcf/dUdmcvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742473; c=relaxed/simple;
	bh=duk9zi9xzyYBDtbnCJvTFubd92XYoU8Wq4ltf3UKn/E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BSh83MtrTkdpwkjOkN0gS8iDTtlhj23/yBEAmVJjndr4NLZCcZ87+zdS+gIw50hqDKKtkswKpELek4yoPih22wJ6wLzaMiSHg9P473rvDqRokjL/WY8nR295raPx6Fh+haX+NkftIa42jNDh1wYUijzplwK7RU1rJ1rxC0Lfoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVhmLOP1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tGrT005845
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 18:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=AnG8RaDQG0mN
	ElO4Ji4G4ZEUY33FUuDgfLM344hdeNI=; b=SVhmLOP1vhhY6Lcg+Kv/pGGdiWDt
	aiVgLdzjELNxfIBgxFv1+DJIm+OjJMU/8XqOtQN62Hsmci8fN0eBm9FxRgZBaxtK
	PST7I/elv7mI2O8nM1VBlE6kppEUdhFZjIlgKR/OPLRUeYXepYNk/WTrUQjfAnc5
	sb+6zFWp3sd8n2uXm14wI7ccbxNlCiW5zVTMPLseoPyfy3j88J8V6c5krZAnrCUx
	1qJo2AfMfhEXNwN30JNJZSakr5m3hFRkO4QpwauZnEHoEMaa8FSzmUSYawQ71Bnk
	/rrBrsfNEhfVWNAiDFCK7wv+cvZQPGc4BplXgDjUCAhndKqMNzc+2q7BeA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvj99jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 18:41:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-227a8cdd272so48934935ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 11:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744742468; x=1745347268;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnG8RaDQG0mNElO4Ji4G4ZEUY33FUuDgfLM344hdeNI=;
        b=UDA8eQFc3nGZARpGJNRXpck9s+ib7gpHKHIOopbWFbuj86KgrE6nyeayeWvnjaWiDo
         dlHPb2QxEbMYxLwai0I1QkS3NJNshvvj3B6lDic/GGmLgoKpm6d+FhryG2oXd4FqFCYa
         piQb4NQ9nV3wCcWvEfOshL+YcJENpvJyZ7PgkJDKJkQ12ZH0e0VNLJPHkuGUxdS63wkr
         esKdV69i29oLDFWe6kPOzKUR544QEptQypPCa1SEbeVXGALrlbx5CU2CoOJJnMnN1CKe
         5CH1XCotR+VQwGtuYpcTKUSaa7FJ2fCoWaagXxcvOpCcWkHF71C3hh+TzuBHKLVUkRny
         KXxA==
X-Gm-Message-State: AOJu0YwYbVE35q3QG44SK4YAYiZdQb369pNUaZg1jbgVR7WVE0yFC/AI
	CnIi2mPPGilE6lw3EvXoT0DC1rzAlq0x7oVPQCEfYSeATiI5G+e/GAxyXJm+yq41Pl/fh2jfFN/
	54n9Iuv5lFQX/9xORkY6SRdGS8C+t2Qwl9tHqb6cz+Ocjkz83ylLpwMMoYOSXox9O1Q==
X-Gm-Gg: ASbGncsY6zzxjo3Z7dSR4thExtqMm0iR/RWl2GWvUm5LS/v5orM++E3RR27Mti8HCTv
	KAKOxrbWNE8fILv9YeT2l9lOLAkunJEM216EFbhCeiDsJvMIpdwPRnCE63wyHTJKT1DjZ3K0n6o
	o04oxvpbisQTWks5TcLYaQr7REvvNUlMn+JTlrgLscIpzoz5QQOd1HWp9f1grAnDgL0qnbCg8LR
	qShJBl+7ZdjF6PiyoyezrHQoHvUObpgT1+1pAbLA1UOuDVA9T4pW3z+5etgzuyo90Pt1eJHPrGF
	eSU4ouQF1VkfbKX3OB6WymBLbfipwAtzyyybLnAppCRSWs4Be1va0w6Ya/2uNmkcXFF6t7Voy90
	a5U7/Og9gaF+CDHdzJCMVXJurw8+BxrS/YUtlnixxqsX3PA==
X-Received: by 2002:a17:902:e54b:b0:21f:85d0:828 with SMTP id d9443c01a7336-22c31abc38bmr2673055ad.41.1744742468488;
        Tue, 15 Apr 2025 11:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuYSe0Qgken9sfyrJV7IJYJtXKq4CQqbIoZJb7RCpQsz8F5cE1Y/xhyJlz7m0Nt+lSApbi0w==
X-Received: by 2002:a17:902:e54b:b0:21f:85d0:828 with SMTP id d9443c01a7336-22c31abc38bmr2672745ad.41.1744742468109;
        Tue, 15 Apr 2025 11:41:08 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b6284dsm121760265ad.38.2025.04.15.11.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:41:07 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix the QoS control field offset to build QoS header
Date: Wed, 16 Apr 2025 00:11:02 +0530
Message-Id: <20250415184102.2707300-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=67fea845 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=jThI9XsKaXDONeLtTJQA:9 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: TMT-FZdQ3WgV_bYL2QrS_BNV53w2zEKe
X-Proofpoint-ORIG-GUID: TMT-FZdQ3WgV_bYL2QrS_BNV53w2zEKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=893
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150130
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>

Currently, in the mac80211 layer, received EAPOL packets are dropped
when the HT control field is present in the QoS header. This issue
arises due to an incorrect QoS control field offset used to build
the QoS header in the MSDU data, leading to a corrupted header in the
mac80211 layer. This issue also applies to other frames that contain
the QoS control field, such as QoS data or Null frames. To resolve
this, use ieee80211_get_qos_ctl() to obtain the correct QoS control
offset from the MSDU data. Additionally, ensure the QoS control header
is copied in little-endian format within the MSDU data.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 96785d60d671..93f93639270e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2135,7 +2135,7 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 	struct ath12k_base *ab = ar->ab;
 	size_t hdr_len, crypto_len;
 	struct ieee80211_hdr hdr;
-	u16 qos_ctl;
+	__le16 qos_ctl;
 	u8 *crypto_hdr, mesh_ctrl;
 
 	ath12k_dp_rx_desc_get_dot11_hdr(ab, rx_desc, &hdr);
@@ -2156,13 +2156,13 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 
 	/* Add QOS header */
 	if (ieee80211_is_data_qos(hdr.frame_control)) {
-		qos_ctl = rxcb->tid;
+		struct ieee80211_hdr *qos_ptr = (struct ieee80211_hdr *)msdu->data;
+
+		qos_ctl = cpu_to_le16(rxcb->tid & IEEE80211_QOS_CTL_TID_MASK);
 		if (mesh_ctrl)
-			qos_ctl |= IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT;
+			qos_ctl |= cpu_to_le16(IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT);
 
-		/* TODO: Add other QoS ctl fields when required */
-		memcpy(msdu->data + (hdr_len - IEEE80211_QOS_CTL_LEN),
-		       &qos_ctl, IEEE80211_QOS_CTL_LEN);
+		memcpy(ieee80211_get_qos_ctl(qos_ptr), &qos_ctl, IEEE80211_QOS_CTL_LEN);
 	}
 }
 

base-commit: d0bcc5eaaa611aacbffe6b2cc2fb64bfc3bdfcbc
-- 
2.17.1



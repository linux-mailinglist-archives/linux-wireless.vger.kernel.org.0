Return-Path: <linux-wireless+bounces-10693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBB8941CED
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 19:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34AD1C23A99
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAC818454A;
	Tue, 30 Jul 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LFNlfBK7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4018A6B6
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359408; cv=none; b=N6Wrq7vBtp3s9a7I0+aJG292MqMuq2mZpV6UXF6suta73Dh/Qel6/Q2jua4tyZgYI2vzn6EYfCzeVT4Pr16XmlpHzU5b3dFqw734QTayiwEqGwO9yhGEiGnaSfyyo1JSnUYvwaYOpAHeQQBM0vGnxqNzTqYulqtcEZCzVIbunh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359408; c=relaxed/simple;
	bh=eZBsHfxHFp3xQ5FMA3KDHC46PHIpSTmvOJFWIVtlCUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDr7QDLlbo3GuzWxhNv+pWbA/Qi9SC5OHOTctirrLBzMN8L4siG8+LmQ4U/pzO4u+grm+vfAu++rI1jR38w1S/DonVrBL85VptDb4SMf7qWNXhgCNnKZ/QHt2VyNEA99uBsDMc4evPwiOggsQh5a9kGkbyWSD85rncfwXHppho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LFNlfBK7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UEZvde027549;
	Tue, 30 Jul 2024 17:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VRJICve9km9GMkDyqwPgk85TMbA5mtb5w4Sz9lgQGw4=; b=LFNlfBK7peCAY9/N
	g68JUPFrac+hoFWATJ7WgiebAn9mCNEQ9GEmk6skWi4tS1RHttXFZ8RYHtA8Nju4
	OTrYjLRu4C7eKwMN/VOBsVUybATUb6fstpq+PBlmpkCCwRQp93jcwIaLZkmjEZU3
	pjrp9jI/uSGKmSa+wzcZNCztwjubKkjM0G/ZNUoTLD7ktLNZrI45Inz2xis0GB0i
	4Ff4lV+2wTElaPAw7ixwXxygCiTWP5Et92CCrnNg6tdMENHVsVr+BTG5LoqjaAIf
	eaY+Cl26vFgSe008qYmRMzPtnDfjtoGhCDK5YMm6r+gD+Sr0Ry3MEYaeXc8xrtjS
	yUZcqg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40q232rhb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 17:09:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46UH9ksp026353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 17:09:46 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Jul 2024 10:09:44 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: Add support to allocate MLO global memory region
Date: Tue, 30 Jul 2024 22:39:10 +0530
Message-ID: <20240730170910.3281816-3-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730170910.3281816-1-quic_rajkbhag@quicinc.com>
References: <20240730170910.3281816-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Tkm2o04zbEYPzOfooTaOQsztsEg4iAhp
X-Proofpoint-ORIG-GUID: Tkm2o04zbEYPzOfooTaOQsztsEg4iAhp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_13,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407300117

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

To enable Multi Link Operation (MLO), QCN9274 firmware requests MLO
global memory (MLO_GLOBAL_MEM_REGION_TYPE). This memory region is
shared across all the firmware (SoC) that are participation in the
MLO.

Hence, add support to allocate and free MLO global memory region.
Allocate one MLO global memory per ath12k_hw_group and assign the same
memory to all firmware in the same ath12k_hw_group. WCN7850 firmware
does not request this memory type, therefore this change will have no
impact on WCN7850 device.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   7 ++
 drivers/net/wireless/ath/ath12k/qmi.c  | 118 ++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/qmi.h  |   1 +
 3 files changed, 116 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 27bd0a14b9f4..c8cd687847e7 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -758,6 +758,12 @@ struct ath12k_soc_dp_stats {
 	struct ath12k_soc_dp_tx_err_stats tx_err;
 };
 
+struct ath12k_mlo_memory {
+	struct target_mem_chunk chunk[ATH12K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01];
+	int mlo_mem_size;
+	bool init_done;
+};
+
 /* Holds info on the group of devices that are registered as a single wiphy */
 struct ath12k_hw_group {
 	struct list_head list;
@@ -786,6 +792,7 @@ struct ath12k_hw_group {
 	 */
 	struct ath12k_hw *ah[ATH12K_GROUP_MAX_RADIO];
 	u8 num_hw;
+	struct ath12k_mlo_memory mlo_mem;
 };
 
 /**
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 11bf16eaadd9..da61ea60e5f8 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2350,19 +2350,61 @@ static int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 	return ret;
 }
 
+static void ath12k_qmi_free_mlo_mem_chunk(struct ath12k_base *ab,
+					  struct target_mem_chunk *chunk,
+					  int idx)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+	struct target_mem_chunk *mlo_chunk;
+
+	lockdep_assert_held(&ag->mutex_lock);
+	if (!ag->mlo_mem.init_done || ag->num_started)
+		return;
+
+	if (idx >= ARRAY_SIZE(ag->mlo_mem.chunk)) {
+		ath12k_warn(ab, "invalid idx %d for MLO memory chunk free\n", idx);
+		return;
+	}
+
+	mlo_chunk = &ag->mlo_mem.chunk[idx];
+	if (mlo_chunk->v.addr) {
+		dma_free_coherent(ab->dev,
+				  mlo_chunk->size,
+				  mlo_chunk->v.addr,
+				  mlo_chunk->paddr);
+		mlo_chunk->v.addr = NULL;
+	}
+	mlo_chunk->paddr = 0;
+	mlo_chunk->size = 0;
+	chunk->v.addr = NULL;
+	chunk->paddr = 0;
+	chunk->size = 0;
+}
+
 static void ath12k_qmi_free_target_mem_chunk(struct ath12k_base *ab)
 {
-	int i;
+	struct ath12k_hw_group *ag = ab->ag;
+	int i, mlo_idx;
 
-	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+	for (i = 0, mlo_idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		if (!ab->qmi.target_mem[i].v.addr)
 			continue;
 
-		dma_free_coherent(ab->dev,
-				  ab->qmi.target_mem[i].prev_size,
-				  ab->qmi.target_mem[i].v.addr,
-				  ab->qmi.target_mem[i].paddr);
-		ab->qmi.target_mem[i].v.addr = NULL;
+		if (ab->qmi.target_mem[i].type == MLO_GLOBAL_MEM_REGION_TYPE) {
+			ath12k_qmi_free_mlo_mem_chunk(ab,
+						      &ab->qmi.target_mem[i],
+						      mlo_idx++);
+		} else {
+			dma_free_coherent(ab->dev,
+					  ab->qmi.target_mem[i].prev_size,
+					  ab->qmi.target_mem[i].v.addr,
+					  ab->qmi.target_mem[i].paddr);
+			ab->qmi.target_mem[i].v.addr = NULL;
+		}
+	}
+	if (!ag->num_started && ag->mlo_mem.init_done) {
+		ag->mlo_mem.init_done = false;
+		ag->mlo_mem.mlo_mem_size = 0;
 	}
 }
 
@@ -2409,12 +2451,21 @@ static int ath12k_qmi_alloc_chunk(struct ath12k_base *ab,
 
 static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 {
-	int i, ret = 0;
-	struct target_mem_chunk *chunk;
+	struct ath12k_hw_group *ag = ab->ag;
+	struct target_mem_chunk *chunk, *mlo_chunk;
+	int i, mlo_idx, ret;
+	int mlo_size = 0;
+
+	mutex_lock(&ag->mutex_lock);
+
+	if (!ag->mlo_mem.init_done) {
+		memset(ag->mlo_mem.chunk, 0, sizeof(ag->mlo_mem.chunk));
+		ag->mlo_mem.init_done = true;
+	}
 
 	ab->qmi.target_mem_delayed = false;
 
-	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+	for (i = 0, mlo_idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		chunk = &ab->qmi.target_mem[i];
 
 		/* Allocate memory for the region and the functionality supported
@@ -2427,6 +2478,37 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 		case PAGEABLE_MEM_REGION_TYPE:
 		case CALDB_MEM_REGION_TYPE:
 			ret = ath12k_qmi_alloc_chunk(ab, chunk);
+			if (ret)
+				goto out;
+			break;
+		case MLO_GLOBAL_MEM_REGION_TYPE:
+			mlo_size += chunk->size;
+			if (ag->mlo_mem.mlo_mem_size &&
+			    mlo_size > ag->mlo_mem.mlo_mem_size) {
+				ret = -EINVAL;
+				ath12k_err(ab, "qmi MLO mem err, req size %d is more than alloc size %d",
+					   mlo_size, ag->mlo_mem.mlo_mem_size);
+				goto out;
+			}
+			mlo_chunk = &ag->mlo_mem.chunk[mlo_idx];
+			if (mlo_chunk->paddr) {
+				if (chunk->size != mlo_chunk->size) {
+					ret = -EINVAL;
+					ath12k_err(ab, "qmi MLO mem err, mlo_idx %d, req chunk %d, alloc chunk %d",
+						   mlo_idx, chunk->size, mlo_chunk->size);
+					goto out;
+				}
+			} else {
+				mlo_chunk->size = chunk->size;
+				mlo_chunk->type = chunk->type;
+				ret = ath12k_qmi_alloc_chunk(ab, mlo_chunk);
+				if (ret)
+					goto out;
+				memset(mlo_chunk->v.addr, 0, mlo_chunk->size);
+			}
+			chunk->paddr = mlo_chunk->paddr;
+			chunk->v.addr = mlo_chunk->v.addr;
+			mlo_idx++;
 			break;
 		default:
 			ath12k_warn(ab, "memory type %u not supported\n",
@@ -2436,6 +2518,22 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 			break;
 		}
 	}
+
+	if (!ag->mlo_mem.mlo_mem_size) {
+		ag->mlo_mem.mlo_mem_size = mlo_size;
+	} else if (ag->mlo_mem.mlo_mem_size != mlo_size) {
+		ath12k_err(ab, "qmi MLO mem err, expected size %d, req size %d",
+			   ag->mlo_mem.mlo_mem_size, mlo_size);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_unlock(&ag->mutex_lock);
+	return 0;
+
+out:
+	ath12k_qmi_free_target_mem_chunk(ab);
+	mutex_unlock(&ag->mutex_lock);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 0dfcbd8cb59b..d8f78794e67e 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -167,6 +167,7 @@ enum ath12k_qmi_target_mem {
 	BDF_MEM_REGION_TYPE = 0x2,
 	M3_DUMP_REGION_TYPE = 0x3,
 	CALDB_MEM_REGION_TYPE = 0x4,
+	MLO_GLOBAL_MEM_REGION_TYPE = 0x8,
 	PAGEABLE_MEM_REGION_TYPE = 0x9,
 };
 
-- 
2.34.1



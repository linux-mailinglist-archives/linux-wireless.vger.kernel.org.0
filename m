Return-Path: <linux-wireless+bounces-24972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F468AFD62C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD5E1C257FA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D821C19F;
	Tue,  8 Jul 2025 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ses9odk9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7283F14A60D
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998276; cv=none; b=t0a8qpHluxIFYfMru9/+a1r7eg26CfBjspWectWw5V3XkqE6vnx/djkzg82yX3E1PqHrw7FZHaDS76uMFLNQ210wpzGwF+mv+1C/8VKu3Sc5UobLVYNiZOjdsNL6HLh8r75h/zUmJFqdbsSb3P8nD5o7YC9OtwBj4FQFRIdqZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998276; c=relaxed/simple;
	bh=bwIYqO7dnMEEntPU9y1xhJ9ziDnFQsGLwNRskVgJxxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ju4GiJ0awgdJCetj7h2cRuLJpb7fMw5yiN7sppGAM63rkXvj7FvvbeQ6Mw0QTzBj0N3WMMXAX9+0zWOO8nWGKyTf/Fp39hZOQIGsPUmRuqqT+oH0El3FtCQ0ApgkfL+Z1QNrRYMUpCkWBK8CAI+7KqS+37EAijruC4n8wG2YDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ses9odk9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAEva032719
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 18:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/1FAG17sRid
	FuF3rwaY6fJao8lQnUQusYs/ZoyKTlJ4=; b=Ses9odk91b8H6hPoCV4vecRgc1q
	bfnMy+qp5wagfW56a8npX2UJNRsnE3oC3JkJDlpmhzVrCn6csMOvwyKkUhVR7Ti2
	66FyOVFtQO/GxCVLUFSz70mLW7CR8zrojkgKHfeoXoSRZGpiPgcmIA4agC205YMO
	TYo5gIIPXSC5dNNYt3oQJQy8RIvLQ/SNHTOAv68+8A68XfAKbtG0B+8eeeKBeI2M
	qXstKKjPZyNO8paEOfmhT8wN0dhOahc3l7M2v2/0Y7ptX8BV0KiHpSsveGPV7ioq
	Jr8LP7Nnu0Qxi8YKSoDlIIvYg/x25CIbDFZc+Y9sHPUOgfyvuun/2kp1pmQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrkrp9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 18:11:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2355651d204so41573095ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 11:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751998274; x=1752603074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1FAG17sRidFuF3rwaY6fJao8lQnUQusYs/ZoyKTlJ4=;
        b=dxs3ESk5KiSVDMaoNn/ViDKFBKvZawf0CBiyerDCX/2WDUsKVgX35Q78QuCtwOUOIt
         D5zHhskareDwzOpz5D7xOBu2vTuQoHJ+hsPQGiH4Hs0t/eWVOkGYrWN0QiqrseqXRwLV
         4CYdJwoCiQIos7IeepIlQ/Qb61VaLVsIIGiUGZHrKfinQpK3BlmzXsuLIwxeGVs5cQUc
         jJA1MAHXR9TAtS3HtB5KU2ThtYzX76ppzbRVySihso2saTZZJKJ1r+J9sEF1zm7UK8m9
         isUi4v2yf09FGcU+vcWhq65vrZgdDoP9vPSAsgzbBopfg0NK1MPrjv8+q2Y3+ObW5Hu4
         teig==
X-Gm-Message-State: AOJu0YzaiAjytGTxA/rgMhd+GfhkAp+4FOn4zD0yt1Gw7UzTPjp4SbBH
	9gMKrO1jNrOvOF1FbfkVFEwnxir5VzBq/elIvITl1semr6VbXLAFztE3qToUAzHqw13lZgXX7HM
	SwvzArdvlS9GRxCgQC/FjYGPP5G7HeFIseSYdLla8do2O6nLJ/5KNXWy/U2N1YhATYoMsxg==
X-Gm-Gg: ASbGncvHhY6VHsa+8sf/F1I5bA/rOkcMXiYZIhGt0EN4t/xS8cN908HwESYNXyh3e8L
	IXf6Ah9Yy+iJourLHl19+ptft05twfFI+8THH0Zy1etDpeISdfdlNX9b8I6bYpM3GpCCbKr5HmZ
	xExL9BFK2NG9c8qmI62lWaO/Pj/YRZ1SmBD55BpKpcT2OnaYmyOnSmAHtb9m/d1VF8t+FETi9cD
	V1WU7F/FEZEfe4P1fiSEk8uy+F4LiZ1yNRM0FyuVC+LFHoh6mAaGNY8AGmmhHg8h8Pb3y1Fb/GR
	qAWakNk03ANBqQEv6PAPp+4Xe6dW0Z3AGDfYUlLt0A1SWsCsI6Zpk3Tc7TW87gCFWJs1Nt5grwq
	BuEpOFKf7c0QGK542BMDMHoTMLQj6p+eDxV6zsa9f4DFt9g==
X-Received: by 2002:a17:902:fc87:b0:23c:7c3b:4c61 with SMTP id d9443c01a7336-23dd98004f5mr4754805ad.8.1751998273658;
        Tue, 08 Jul 2025 11:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6Xl4nsQcuKW47kp9GCDqnPn/RwuMxnNZIBodXIoMAjx2JvQEKjsYcat+SWt+2Y9aL6ccetw==
X-Received: by 2002:a17:902:fc87:b0:23c:7c3b:4c61 with SMTP id d9443c01a7336-23dd98004f5mr4754585ad.8.1751998273250;
        Tue, 08 Jul 2025 11:11:13 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d0a9sm115980425ad.95.2025.07.08.11.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:11:12 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 2/4] wifi: ath12k: Remove redundant TID calculation for QCN9274
Date: Tue,  8 Jul 2025 23:41:00 +0530
Message-Id: <20250708181102.4111054-3-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708181102.4111054-1-aaradhana.sahu@oss.qualcomm.com>
References: <20250708181102.4111054-1-aaradhana.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yq7MSL3QBZ5b7aqbn-fPkO0eolaz1Ak2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MiBTYWx0ZWRfX0rgRsXPADYhU
 HMAaFz/loZduRopmNVdveuOg9T+ZP3ryJoxOPw9S8IBX8RkFOw8muuTBragQtZyD7qXtjGKUjPf
 tAvBFrHt7W8LAl0Q2CyXSeTG1vr8/ADCEyYN7otC/cNoJ4MI1dOijoBKejFH4DkGSMjwgu1Ia6u
 25YcnyI4kXC5cRbqo7Q9WT3eJjH1ELbjI5LeUZuTIIQOvY0wJF3C8GHGOkMH17FG6ftKfyH+9IJ
 lMf6/HYz76DMFBG1ZNteB20VdRzgRbrBK4VztsLGJ3uzI2a/5jXI1435mhWIX3Z74qRFO8ub/Pn
 vuJLhhQJ5fwMjvQtyiQVrQKJ0wG9G868zDe8MEVGfjcYsJKMoR87YLrEEQFurYQtDnNn3GfPDrc
 hpjm6AfW3+DP/2agFpfq8GFMBiP+HrqloTdvf98YZ2GKwCYxmzAiLJeO1ZobHxlH5q4Gs5FR
X-Proofpoint-GUID: yq7MSL3QBZ5b7aqbn-fPkO0eolaz1Ak2
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686d5f42 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Wa9tDcmNiZk3z8JJqtoA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080152

Currently, host sends num_tids (number of TID (Traffic Identifier))
value to firmware via WMI_INIT_CMD during WMI initialization. However,
the firmware does not use this value, as it determines the number of
TIDs using its own internal logic.

Hence, remove the redundant num_tids calculation logic for QCN9274.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 9 ---------
 drivers/net/wireless/ath/ath12k/core.h | 1 -
 drivers/net/wireless/ath/ath12k/hw.h   | 2 --
 drivers/net/wireless/ath/ath12k/wmi.c  | 1 -
 4 files changed, 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 8b0c67735171..037486553ba0 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -638,15 +638,6 @@ u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab)
 	return TARGET_NUM_PEERS_PDEV_SINGLE;
 }
 
-u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab)
-{
-	if (ab->num_radios == 2)
-		return TARGET_NUM_TIDS(DBS);
-	else if (ab->num_radios == 3)
-		return TARGET_NUM_TIDS(DBS_SBS);
-	return TARGET_NUM_TIDS(SINGLE);
-}
-
 struct reserved_mem *ath12k_core_get_reserved_mem(struct ath12k_base *ab,
 						  int index)
 {
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index b2dcb979dc75..272b7e9822ea 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1356,7 +1356,6 @@ const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *filename);
 u32 ath12k_core_get_max_station_per_radio(struct ath12k_base *ab);
 u32 ath12k_core_get_max_peers_per_radio(struct ath12k_base *ab);
-u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab);
 
 void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag);
 void ath12k_fw_stats_init(struct ath12k *ar);
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 0a75bc5abfa2..4e10d5df2919 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -45,8 +45,6 @@
 
 #define TARGET_NUM_PEERS(x)	TARGET_NUM_PEERS_##x
 #define TARGET_NUM_PEER_KEYS	2
-#define TARGET_NUM_TIDS(x)	(2 * TARGET_NUM_PEERS(x) + \
-				 4 * TARGET_NUM_VDEVS + 8)
 
 #define TARGET_AST_SKID_LIMIT	16
 #define TARGET_NUM_OFFLD_PEERS	4
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index b34f2c183312..facca29ee9e7 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -204,7 +204,6 @@ void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 	config->num_vdevs = ab->num_radios * TARGET_NUM_VDEVS;
 	config->num_peers = ab->num_radios *
 		ath12k_core_get_max_peers_per_radio(ab);
-	config->num_tids = ath12k_core_get_max_num_tids(ab);
 	config->num_offload_peers = TARGET_NUM_OFFLD_PEERS;
 	config->num_offload_reorder_buffs = TARGET_NUM_OFFLD_REORDER_BUFFS;
 	config->num_peer_keys = TARGET_NUM_PEER_KEYS;
-- 
2.34.1



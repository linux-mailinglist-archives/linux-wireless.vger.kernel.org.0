Return-Path: <linux-wireless+bounces-27739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F4BAC3BE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A54188FD93
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8B72F6574;
	Tue, 30 Sep 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YxehpsrY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598A2E9751
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223787; cv=none; b=KrnRKtOVd6IsVmKDMr2PnHdYWL5+TURmmLKGk/i2aXdnThkj/E2Q5yY4YtwVX+M8xG61ZGy3l3gBORaa2nZGG6VzqheRelgtzdQp6xpY3ILDco5QvwpkuhzXCUjDndEKJTvnv7mmjT/CIas0zJohz5vkhvebLP7n02ieCWkEpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223787; c=relaxed/simple;
	bh=EV8+2OWCX5OdUhSjqxZMqzzeFTO+TYRU2m1p//VX8iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAo0L8ULadbpb+fbR0tQlvz1hmO36gJCKeBhW1rhV/fnD7yXou8PP5lMVoBbn9VNgACUBsCwRXdszfDUPUT85FstdjHXCvG9ThcvHlmSRimO1J7BFMDy2WljkeOujlAdEB+yMk8oduJcyaI9b/EYg4yQ7YDJc6ctfD0yAt2VPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YxehpsrY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HMUk012433
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 09:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZJH/ZtkwOxo
	V8E6xs5G3pO8BZxsKdEzfnAjYiBZUsv8=; b=YxehpsrYLQp3bbuvCxG31q+M5bR
	PfIC5F8nxmQ+Mb9CiZxaIKEUKs8rNdLy8HrdgO3TYZItGVPtocPkqwVG0GGGSntr
	KDpWW0zHGsoqh5gKp9G010JqWyxnL5mpwZyNlH72H8VRIefCR1b2hpRL55NEKR1T
	MHVDDcuID42dc5+a6/4BXkiDjptBlDyUL8evTLPxtft9JSKqPBihiHxxIFg/lf/4
	ws+201J6CcklxkpVqflY/rEAangxYsKYO15LtlU5PxLp8TNC8YIH9iir2xpATokI
	z+NvkBbIcsT0HM9Y3Gg2tm5EnQlG5wfNRjLtgHMpBJ5a21DoqyaWllsC0Sw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a60ecb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 09:16:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7811a602576so5920147b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 02:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759223784; x=1759828584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJH/ZtkwOxoV8E6xs5G3pO8BZxsKdEzfnAjYiBZUsv8=;
        b=Y0236HP6gsI3J5m8ZDqkhigGaGjA+8o8xK5VdF5dTEvQyfgLGQ8BgZEqMe7mUVd5Bt
         a8UHAc69T76sVLWMJSICBjPZxjpuMz8A/iNsiXYSvsSBiYie5D6rLbxcLdO2sh832amG
         yzpK33BcwsH53O83M7siXRSSmBhJ2vKjaq1MSvfFgPj6D8vDjTApPX3B+xe8v0dTPwFR
         fWaJNzF8RIwf4PSr87rHKZrrFypregSdsw+a3unZ4J9IiRWrtUIbfNkSYwfs82rPOP5k
         Jy757jYvm4psqXzDgTXCjB6H/Pycn3MlmW8qOJjMVBaVE4A2vaJ8Mv4guHTMVp+tIyE+
         3xog==
X-Gm-Message-State: AOJu0YycoESA0R+68lyH0wMpT0hX/UYw/0JtLodIS2vECzNrh8RFaYxA
	EjBC9cOkk+jgw8RnPVFFwolPi0xcf0QD2xjLzjry9STXNApOIWCa5iVxJk3kofPICAhm10YFC7b
	HMNcC5tZgjadP8NwZ92tuk5tlLISjvJdX2gi5veJJHPBw7lUS2QAbivm7shHIA5s2BWZcCg==
X-Gm-Gg: ASbGnctXf1S81UeTUrOn6xJf1QCDHh8qTPtobUuR7GOI1gsD8Rf+6NhjMjwmhbsKFHX
	1HIm/4nfCp2Wgu0yGFCM3BgxNWt4hZIyTwpF9/5OTstg6ZB+Si9cGAUA+XytKDBY8UrKuui/7ss
	Q4uS63ITF8wPVi6IfUgGD2zg5Qgic2OmuFmoSVk6zLuy2c6pqOVM1yuR5ofUe1xfli0dBLVLjCu
	afzXNICoOP33poUQBYxL0IKIXC/TGB+h+FT2fhdMnl2YiHgjlF9nwDFsSzKkYoHJA/3Wg4aqymn
	4DWLbuZ1z4DYEUCVZC4KuueAOjLra7Pk6sFilF5boPfr1f9wyt5Kg3tu/YJnEgyRNsgyGJGdx27
	6df34fxi30X/C0dpLHd45jSEBJ1A4ZNl9gUXLOpolJpWKQg1fE/XOudUOFnHIkcZ2Lr8=
X-Received: by 2002:a05:6a00:2e1f:b0:781:1a62:4a30 with SMTP id d2e1a72fcca58-7811a624f87mr16511504b3a.4.1759223783807;
        Tue, 30 Sep 2025 02:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGibKp7B//qOqxI5zAQQqr5glMnnDl1vHh24fU8qvthO2SKNqMWMbB9NDwoG+iADv8nM231+w==
X-Received: by 2002:a05:6a00:2e1f:b0:781:1a62:4a30 with SMTP id d2e1a72fcca58-7811a624f87mr16511445b3a.4.1759223783306;
        Tue, 30 Sep 2025 02:16:23 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b26644sm13431963b3a.67.2025.09.30.02.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:16:23 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH ath-next 2/2] wifi: ath12k: track dropped MSDU buffer type packets in REO exception ring
Date: Tue, 30 Sep 2025 14:45:51 +0530
Message-Id: <20250930091551.3305312-3-sarika.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930091551.3305312-1-sarika.sharma@oss.qualcomm.com>
References: <20250930091551.3305312-1-sarika.sharma@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68db9fe9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YO4AT9S2ZIYcgAK9BHQA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: YXecxRBuWzN6oi1aRN5Pq5MfH5_Z-LNt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX7Ql9taV7a6cQ
 XlM/6xDNab2TBuQup5spJrZ9hOU6Ht+hg1Fhglb56KbOU0ad1wLrTN0xJmOgmDbIbYLDvah3TBZ
 grf3mjzsHM20o0fxuCliQjfGtcHRv/mCGNMMsWbY2bAzPpzsNWDWxrBGEDyVvpTvAkug/rxpyNJ
 2evx5iW2eQGUwAx5qQ3BjjhERmTl3HabO3S2PW9iaCRS+AoOU8/nmt/keSl8fxULHYytLcY1t2p
 1LIMIZ3JBR6w4U4kll1bccuxlA/uIM9MUPBBc16mASE6fT+7cVuZUB+fE2iKiGJE/PdAwnpk3Od
 l4+jkkpyWeHCpgN4YkzgttXqYAWxwStchQ6WDwsGwbsMtd3kLzfct4PqdjhKNQbwlRWljfjyzz+
 ILkZR21aG10epUVNMeuWxTE0H2ZlwQ==
X-Proofpoint-ORIG-GUID: YXecxRBuWzN6oi1aRN5Pq5MfH5_Z-LNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

Add a counter "reo_excep_msdu_buf_type" in
ath12k_debugfs_dump_device_dp_stats() to account for packets dropped
due to unexpected MSDU buffer types in the RX error path. These
packets are discarded to prevent incorrect parsing and potential
kernel crashes. This helps in debugging and monitoring RX error
handling behavior.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h    | 1 +
 drivers/net/wireless/ath/ath12k/debugfs.c | 5 ++++-
 drivers/net/wireless/ath/ath12k/dp_rx.c   | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 3d1956966a48..48d95ea7b3db 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -963,6 +963,7 @@ struct ath12k_device_dp_stats {
 	u32 tx_wbm_rel_source[HAL_WBM_REL_SRC_MODULE_MAX];
 	u32 tx_enqueued[DP_TCL_NUM_RING_MAX];
 	u32 tx_completed[DP_TCL_NUM_RING_MAX];
+	u32 reo_excep_msdu_buf_type;
 };
 
 struct ath12k_reg_freq {
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 16601a8c3644..15219429d4ed 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "core.h"
@@ -1178,6 +1178,9 @@ static ssize_t ath12k_debugfs_dump_device_dp_stats(struct file *file,
 		len += scnprintf(buf + len, size - len, "\n");
 	}
 
+	len += scnprintf(buf + len, size - len, "\nREO excep MSDU buf type:%u\n",
+			 device_stats->reo_excep_msdu_buf_type);
+
 	len += scnprintf(buf + len, size - len, "\nRx WBM REL SRC Errors:\n");
 
 	for (i = 0; i < HAL_WBM_REL_SRC_MODULE_MAX; i++) {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 99d29eda26cf..6c9f0839c83a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3790,6 +3790,8 @@ static int ath12k_dp_h_msdu_buffer_type(struct ath12k_base *ab,
 	struct sk_buff *msdu;
 	u64 desc_va;
 
+	ab->device_stats.reo_excep_msdu_buf_type++;
+
 	desc_va = (u64)le32_to_cpu(desc->buf_va_hi) << 32 |
 		  le32_to_cpu(desc->buf_va_lo);
 	desc_info = (struct ath12k_rx_desc_info *)(uintptr_t)desc_va;
-- 
2.34.1



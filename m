Return-Path: <linux-wireless+bounces-24971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E1FAFD62B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF7317D02A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 18:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5322E5403;
	Tue,  8 Jul 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OEduSNQP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391521C19F
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998275; cv=none; b=h5JAhVGw1zwPGzYHok/D8ONxvmu5EXL96hN4r9fwxZG6pBsHVPhcQ/Xcn5GggK8kbpmS5BJ2ITlcP2E5PLlKL8WbNhnqYMiIQdPis9Yu6JkP0GIY6pkCXXJYGG/mCfeaU7vgx2buD3MRF8338XjVGMTy1LGgouBIpKqfP1DBQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998275; c=relaxed/simple;
	bh=jCWeIWNz0YerJCJY/2osUHF5jQPMCwuOD8TJuIKhjnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gMcpeia+29Mf/N6lULnz4GzzjHlWW20xt/UVhn0ry2dcttOfE6Fwz1wsFYeofw7VckphoVKYGkWTSxPgEtZ1xLQaMVAmgpl7ckmyMBX9oE2nZekYeTVhwT5FxcL2feEVLPZ75dl1IXCvBBH/mXPmQ9GQm+TJoBrurmXcxaux4tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OEduSNQP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAFIJ000333
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 18:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BtaRafnT4SL
	ofo+kxnbIQyg617OEyZPWweMS75eYPyY=; b=OEduSNQP5mhA2okoCJ/5TrKmYkq
	qRIUclxLv5cNCqCCXg+BdizkBrn5IuFL+b4rKE0ENYP8DFLNwVZXqoHK0a1MnnYm
	Vk5A4iFYmJ76FxzkGrEj8f+SyCBVxpQz6mGJ+P7HfbwwsaUVC6pb9PItayrj1adr
	/sTsHgYoMe6OPjljNhRMs+pAglUGLEqU3nI702UmEx4N/hy6LN8lRllzZx6qGvjt
	JRqJlSawg9EoiDxdsjGQ+9hC8ZbKvNsatWTpTpk//0mSIKMZMCTd3tEQ/kGK5+DM
	zOSRYZiMKlGbf3O9dzievCjOgBed+KiB+7VSoyznBxjz4T75bSo89EA+sBQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrkrp9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 18:11:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2369dd58602so48867125ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 11:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751998272; x=1752603072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtaRafnT4SLofo+kxnbIQyg617OEyZPWweMS75eYPyY=;
        b=aFkkgA/nX5PgA5HNJrLtxri8Kd2GUEExVrAXZSKrJry72oQfClgm7Pjon9xV2Fmp65
         NFdfbUvyXhrpwqr6S+yQEgfOpvoS/9eIK/5675ZwnFvnG/+wDDd5E2KD07XUTrmAp8+d
         SeZiWYLE+d2E/vAZrw2exxaEzyaubSGvM9F+r7SWhTir+OeXL8VD7imxilfWXZlngH/P
         myAgjrZo5BLqef3/zTqgVfj6z6X7Uezzg8CtWwGZTL1ZjrDlNHYSCey/BKPuQ5jYTgvs
         sg+fiQe5UzrkAuYGyihOLDpXkCPbpN5zakYJIkomrTHUDzl76IlxE00JKRxaHVkl+iGm
         EBfQ==
X-Gm-Message-State: AOJu0YzuMDomoWLmQ1Ukv5WevsP8Hy/bv+pZi+ouHUjqdnEIj6N/EMs9
	dxHt6l9+TrX8blrQHjugzyqJcXWnE9MNFU2+VtyzH8aWS29vP10vnUXsfn1M10E5iVUJb7uA2k6
	Fkc95cIs03i0WkTBV8bYRq226aAFi11RSjJbCDfKF5TDcPQvqWXGpEoTLUKNXq7RfvqBbUQ==
X-Gm-Gg: ASbGnctD5MrB2EOwOIkKr9f/H2nSILBoXDclIt9wt6vv9pNl57pZ3UwzjFMKey49HvH
	G7ZcyLJ3QBOTtujW/pL+N+zfqWR8XVfEmreWPlF9xvTnKv4oWV9SO/7DqESQ6Fpo7j+auV5dF8P
	ktPBLoZxTiafR1gKUxIkg8VppQ1mZQ5ZYLqQ5iTuZdLmlMgmxJmnYw+33SNb3luxJ/baq7BImBj
	JarEFZndHt95+zyUIH43MKdI30/GJECnD16Bhg+AfFvTl6HrMK9zCMwpRK6Wf4HmBLYYClTR3+v
	HUjPR/aX2K03Bo7A370felX/N/tnJ3GbKc377lpdh4w+kRy40+Wktnx5NN9vNjO3u5v5RNNyGFQ
	fWZdZSA5gDqxDJPPDRxSe/dDfailvtv59fua9aKrpJlOKaQ==
X-Received: by 2002:a17:902:cf05:b0:21f:4649:fd49 with SMTP id d9443c01a7336-23c875db9d1mr247269325ad.49.1751998271896;
        Tue, 08 Jul 2025 11:11:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH64uIvd5da/OCOiagpE5GseRqXCxPYzYvQFtD4jDxOvMjCP0jI6ai+dMg6dFTvRtQfRKYZuA==
X-Received: by 2002:a17:902:cf05:b0:21f:4649:fd49 with SMTP id d9443c01a7336-23c875db9d1mr247268895ad.49.1751998271383;
        Tue, 08 Jul 2025 11:11:11 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d0a9sm115980425ad.95.2025.07.08.11.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:11:11 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 1/4] wifi: ath12k: Add a table of parameters entries impacting memory consumption
Date: Tue,  8 Jul 2025 23:40:59 +0530
Message-Id: <20250708181102.4111054-2-aaradhana.sahu@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ihnCDi2FGfUUBMvYIk_ik2dA4kjKMy9h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MiBTYWx0ZWRfXymDau2d+4EHw
 3hSOv91xqOTGpVdGZDk8CCNAx9FjxcL6s5Yw7rsPi4wNCp8wfM3H+JeSEx05URQpurRqJkhzrIn
 tcOdlQb7kC5mRnGEVEXWBmZ/VAAlOnFqXljay3PGdCFUwgNqHPBLlKSi778p4hJfh1qmUU9Zz0c
 UAtjNrx+4BLg4UbPsr45iGCzaY5EbzE4mAJ/PLqnU28cDvFzJf5/CHrYVOTDaenw6W5kSeiiDmY
 H+rOB6UyXUWUYWCtNA4gPWqrP9BsIbHPRZ1VXhcaB0ZpKO7KZU073wQaysmRBRSm7g33qixaEtq
 ARQKVmmnYEPb9FjzxaCPoz7TGmEeZ33dAabibbD7WBx6feHHIrJdFvD5POI7eGjwD5AH7c1mELc
 3IeiJ816mikQCA9KvVvRFulCVNLlVpIFYdwtHyEGeAVTJe+p5BnMvSC4neycjLiroAd3Lhe2
X-Proofpoint-GUID: ihnCDi2FGfUUBMvYIk_ik2dA4kjKMy9h
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686d5f40 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=stCEmeMjHWlYZu10FZ0A:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080152

Introduce ath12k_mem_profile_based_param structure to define
configuration parameters for both default and low-memory profiles.

Add support for enabling the low-memory profile in the follow-up
patch by making the following changes:
- Reduce sizes for transmit, receive, and monitor descriptor rings.
- Reduce transmit and receive descriptor count.
- Limit the maximum number of virtual devices (vdevs) to 9.
- Reduce the maximum number of client support per radio.

Centralize these parameters in the ath12k_mem_profile_based_param
structure to simplify switching between memory profiles.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 33 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/core.h | 17 +++++++++++++
 drivers/net/wireless/ath/ath12k/qmi.c  |  2 +-
 drivers/net/wireless/ath/ath12k/qmi.h  |  6 ++++-
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index ffc19a6b9485..8b0c67735171 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -37,6 +37,36 @@ static struct list_head ath12k_hw_group_list = LIST_HEAD_INIT(ath12k_hw_group_li
 
 static DEFINE_MUTEX(ath12k_hw_group_mutex);
 
+static const struct
+ath12k_mem_profile_based_param ath12k_mem_profile_based_param[] = {
+[ATH12K_QMI_MEMORY_MODE_DEFAULT] = {
+		.num_vdevs = 17,
+		.max_client_single = 512,
+		.max_client_dbs = 128,
+		.max_client_dbs_sbs = 128,
+		.dp_params = {
+			.tx_comp_ring_size = 32768,
+			.rxdma_monitor_buf_ring_size = 4096,
+			.rxdma_monitor_dst_ring_size = 8092,
+			.num_pool_tx_desc = 32768,
+			.rx_desc_count = 12288,
+		},
+	},
+[ATH12K_QMI_MEMORY_MODE_LOW_512_M] = {
+		.num_vdevs = 9,
+		.max_client_single = 128,
+		.max_client_dbs = 64,
+		.max_client_dbs_sbs = 64,
+		.dp_params = {
+			.tx_comp_ring_size = 16384,
+			.rxdma_monitor_buf_ring_size = 256,
+			.rxdma_monitor_dst_ring_size = 512,
+			.num_pool_tx_desc = 16384,
+			.rx_desc_count = 6144,
+		},
+	},
+};
+
 static int ath12k_core_rfkill_config(struct ath12k_base *ab)
 {
 	struct ath12k *ar;
@@ -1713,6 +1743,7 @@ static void ath12k_core_reset(struct work_struct *work)
 
 int ath12k_core_pre_init(struct ath12k_base *ab)
 {
+	const struct ath12k_mem_profile_based_param *param;
 	int ret;
 
 	ret = ath12k_hw_init(ab);
@@ -1721,6 +1752,8 @@ int ath12k_core_pre_init(struct ath12k_base *ab)
 		return ret;
 	}
 
+	param = &ath12k_mem_profile_based_param[ATH12K_QMI_MEMORY_MODE_DEFAULT];
+	ab->profile_param = param;
 	ath12k_fw_map(ab);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index afc8329980c8..b2dcb979dc75 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1010,6 +1010,22 @@ struct ath12k_wsi_info {
 	u32 hw_link_id_base;
 };
 
+struct ath12k_dp_profile_params {
+	u32 tx_comp_ring_size;
+	u32 rxdma_monitor_buf_ring_size;
+	u32 rxdma_monitor_dst_ring_size;
+	u32 num_pool_tx_desc;
+	u32 rx_desc_count;
+};
+
+struct ath12k_mem_profile_based_param {
+	u32 num_vdevs;
+	u32 max_client_single;
+	u32 max_client_dbs;
+	u32 max_client_dbs_sbs;
+	struct ath12k_dp_profile_params dp_params;
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath12k_base {
 	enum ath12k_hw_rev hw_rev;
@@ -1213,6 +1229,7 @@ struct ath12k_base {
 	struct ath12k_reg_freq reg_freq_2ghz;
 	struct ath12k_reg_freq reg_freq_5ghz;
 	struct ath12k_reg_freq reg_freq_6ghz;
+	const struct ath12k_mem_profile_based_param *profile_param;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 99e1fb2910d0..5e8943060443 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3856,7 +3856,7 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 	memset(&ab->qmi.target_mem, 0, sizeof(struct target_mem_chunk));
 	ab->qmi.ab = ab;
 
-	ab->qmi.target_mem_mode = ATH12K_QMI_TARGET_MEM_MODE_DEFAULT;
+	ab->qmi.target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
 	ret = qmi_handle_init(&ab->qmi.handle, ATH12K_QMI_RESP_LEN_MAX,
 			      &ath12k_qmi_ops, ath12k_qmi_msg_handlers);
 	if (ret < 0) {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 96e6c3daecfe..abdaade3b542 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -37,7 +37,6 @@
 
 #define QMI_WLANFW_MAX_DATA_SIZE_V01		6144
 #define ATH12K_FIRMWARE_MODE_OFF		4
-#define ATH12K_QMI_TARGET_MEM_MODE_DEFAULT	0
 
 #define ATH12K_BOARD_ID_DEFAULT	0xFF
 
@@ -602,6 +601,11 @@ struct qmi_wlanfw_wlan_ini_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
+enum ath12k_qmi_mem_mode {
+	ATH12K_QMI_MEMORY_MODE_DEFAULT = 0,
+	ATH12K_QMI_MEMORY_MODE_LOW_512_M,
+};
+
 static inline void ath12k_qmi_set_event_block(struct ath12k_qmi *qmi, bool block)
 {
 	lockdep_assert_held(&qmi->event_lock);
-- 
2.34.1



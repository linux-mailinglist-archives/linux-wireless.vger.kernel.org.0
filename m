Return-Path: <linux-wireless+bounces-27738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DDABAC3BB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 11:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1194B1893109
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A0D13A3F7;
	Tue, 30 Sep 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gaCa80nl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410F241CA2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223786; cv=none; b=el6AxNorli4VRtw5hR+w8yCaeMwQfEST+Pnyoa4QKQ9s0198Tb6/RU+QRgtL/MaAuTCmi7oWpL19Xc8yMOCeqoEuycDhlWpTetTgexNOr+7A16VyTG0rLGIuPfgRDODpWOgYi/5cteKwcZ/nGW+dfTe+XfY3vdFmIjQ6moRVMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223786; c=relaxed/simple;
	bh=3VVrnm+ds+uymYlbK3lFoz0oeDuua3I/QpKogvECHXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPnIl6VCOr00bHqen4jncSAsoA7d1XLEXW2jNUB4p6O5epIUPgZs4pj1GUQ9NynJZLlwNXi4q1LLF0zZZLvHfGM/qHTo3FgXOdgwedoOVQSd8jFnOhlVmSwdXV4J1ewWXHNUjAAF9M68bOPMLNy86JaC3JmA2msuFrUHfmxiGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gaCa80nl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HYEH020364
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 09:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hko3ZFl0bEz
	JNMgMOTQBflRu3baR4K6MWSD/7TDHLRo=; b=gaCa80nl97ivpFC1dFFJzz1bVpb
	4NDxmWUdmKb8cWuOjsvt3k2ao7SNzK2ol6+pmqo0DUWITF6zrd6akBWN9A84UONr
	x9JNCxKAMpP/KDcSWabQStHtwXqfB+RAZDCBt9Q74bRBkPIkR556vsOgYC8ElyQ5
	uUPfzlUAlPSXwB1vmxplJqU5u2IQwN1TEXEvBKDvCsIv+J7JcmPT/93usF7CChLy
	9SjxV9UDWXmQs8TXKyecUWmRmi6fs/SZF0MTT7jvr05vpVgWMKLBsHrRz9GUJvLJ
	r/BbqH/BUAGQTzTqXFixcDhfzUqGQZ8CyDKU+H9eumhrGcGvKsICFdk251g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6x5rhf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 09:16:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7810af03a63so9526382b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 02:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759223782; x=1759828582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hko3ZFl0bEzJNMgMOTQBflRu3baR4K6MWSD/7TDHLRo=;
        b=Tv+n/JrMD1sn/EBxOJDfBJ8xvRm+lCndxiyndDHmqRpT0Mfbey+wKYzluTtfeiw9oY
         2c3F75cGZSBldXHTQMhz0YXs8zkbu14ZJroiKv/6l+4Kq3V5mt5GLRX2c6HBBqhZ9Kde
         7TbLkKlCrJlTl0fhP0Jc8gRkxWmQ8gGlv4ZtRw6iySScClaLoN3ECTrL2oREN+AZGMxh
         k/ySxqfYzAva9MHRda6g9lHSGlvodmeDyNTNiBEdg2EoiHCN8onK0JDGNlf7j+fGJDd6
         VkrnxrF1HSlVFHt4D+GE6dJGI+fg46LX6OHKMZG7Jmb1pA3amk5P6MX8y1bIfvhHwelQ
         JQyg==
X-Gm-Message-State: AOJu0YwOtNd2cXge2o5I6rQko3YBvr79N7OJeHqAz2xuQb4MXJuLQBEF
	ckj5xnHLRWFAIgUfq9YVzwNVp6mVwxpsdtxjA6qygPgL5fok+J1pPQFpJqGaidajKtW8RSDo0tV
	th0P3wswsPRaioohYqrxILwn+MqaD1CYjHOsaVeB64WYkYE4fK4V/1SghtWKHY+idrmZGow1HKT
	ONOQ==
X-Gm-Gg: ASbGncseYBajcIqtwdT/gA2HhVZZDF/w8Gxjd+GQtDa6bPZcumf5hRAVjBtiZNs1iQC
	dnk1/yyVla/agzcqxZgBCaTonSoz2c1UhcUe/NRXbb0rjwYbMAtJkhCVQT7zD9cHdi/4t8HZspp
	2QvioHOGamynUQuQAF8+rc1rwwO2KuZOUO8JWaCLnCC403YM3e/hYhxMkC86X+6cXzXsPDT5hTW
	W/kkufxXQ68G+rtksUNUPtQDCOrb4waKJyVz5mmCfnms3cjTkHpdGh8UF1PIfXeBtaOjjeWmefh
	qU6BlzJa699nEc7+c45Mg4GSwpg4xA86KDxAj+9O56Is+3kMspLnkPQFq4cxWExQ/CLHkxEtOAj
	Naypxfw/yhCuY2kXbDvwwGS5/R7oss5vtKhjXsf7tFOBagVzWKNJ6tAZ7Z3Afifvh86A=
X-Received: by 2002:a05:6a00:1792:b0:782:cc55:be67 with SMTP id d2e1a72fcca58-782cc55c00fmr8780654b3a.20.1759223782018;
        Tue, 30 Sep 2025 02:16:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtMrFnBmX79yekIRbfrIUmm/McZQhDVzZxrKUGHXqG62pky4T0tu8eofU6mtc0ilmgQURhXQ==
X-Received: by 2002:a05:6a00:1792:b0:782:cc55:be67 with SMTP id d2e1a72fcca58-782cc55c00fmr8780631b3a.20.1759223781548;
        Tue, 30 Sep 2025 02:16:21 -0700 (PDT)
Received: from hu-sarishar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b26644sm13431963b3a.67.2025.09.30.02.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:16:21 -0700 (PDT)
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Subject: [PATCH ath-next 1/2] wifi: ath12k: Fix MSDU buffer types handling in RX error path
Date: Tue, 30 Sep 2025 14:45:50 +0530
Message-Id: <20250930091551.3305312-2-sarika.sharma@oss.qualcomm.com>
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
X-Proofpoint-GUID: LRMIs7TSp2WhAOBTG7BL56sMK7faPKeC
X-Proofpoint-ORIG-GUID: LRMIs7TSp2WhAOBTG7BL56sMK7faPKeC
X-Authority-Analysis: v=2.4 cv=ZtPg6t7G c=1 sm=1 tr=0 ts=68db9fe7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=FUVsxDsjtWu2R0VvNmgA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxOCBTYWx0ZWRfXy+PW33kpUWT3
 CmB9jM1XZPemXhYGS9cfkGpyVNvqMTFmCKmVVCSWbsoIfedE6yAMSJBmg776HJjXr5VdOgyMYZ0
 EDpkd3xi1sOUZwnp8EFWgqnnz+C0sg8z+chTJuoGrQ3VKyl/EAMpCXuU3MrxahnyrgRtIociQ/4
 VaZRjIF8Nu9ZSA6ykm9vwtqn+fR6h0acuvbjYv6qSXqJv6aRI+Ofrc2ZqmK/QGgN83C4yHp4gS/
 Wp7oqYuPmtm/erAI00kYmZQBjPAO12yurarfJifPVmhEdNIOPWnaLQwgJ/T/DyNww2u/WSF5sFK
 yIFAmqu645w2XpY0JVlY5aeY7PP4YRhu3gPnuuF+tWhcH2hThQ9j2e849OjP4uPtzLfomAWBJ5R
 CAQqTDJtxvESyTLL5dknD6yeL6tsyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270018

Currently, packets received on the REO exception ring from
unassociated peers are of MSDU buffer type, while the driver expects
link descriptor type packets. These packets are not parsed further due
to a return check on packet type in ath12k_hal_desc_reo_parse_err(),
but the associated skb is not freed. This may lead to kernel
crashes and buffer leaks.

Hence to fix, update the RX error handler to explicitly drop
MSDU buffer type packets received on the REO exception ring.
This prevents further processing of invalid packets and ensures
stability in the RX error handling path.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 70 ++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/hal_rx.c | 10 +---
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 5e5c14a70316..99d29eda26cf 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/ieee80211.h>
@@ -3781,6 +3781,48 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 	return 0;
 }
 
+static int ath12k_dp_h_msdu_buffer_type(struct ath12k_base *ab,
+					struct list_head *list,
+					struct hal_reo_dest_ring *desc)
+{
+	struct ath12k_rx_desc_info *desc_info;
+	struct ath12k_skb_rxcb *rxcb;
+	struct sk_buff *msdu;
+	u64 desc_va;
+
+	desc_va = (u64)le32_to_cpu(desc->buf_va_hi) << 32 |
+		  le32_to_cpu(desc->buf_va_lo);
+	desc_info = (struct ath12k_rx_desc_info *)(uintptr_t)desc_va;
+	if (!desc_info) {
+		u32 cookie;
+
+		cookie = le32_get_bits(desc->buf_addr_info.info1,
+				       BUFFER_ADDR_INFO1_SW_COOKIE);
+		desc_info = ath12k_dp_get_rx_desc(ab, cookie);
+		if (!desc_info) {
+			ath12k_warn(ab, "Invalid cookie in manual descriptor retrieval: 0x%x\n",
+				    cookie);
+			return -EINVAL;
+		}
+	}
+
+	if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC) {
+		ath12k_warn(ab, "rx exception, magic check failed with value: %u\n",
+			    desc_info->magic);
+		return -EINVAL;
+	}
+
+	msdu = desc_info->skb;
+	desc_info->skb = NULL;
+	list_add_tail(&desc_info->list, list);
+	rxcb = ATH12K_SKB_RXCB(msdu);
+	dma_unmap_single(ab->dev, rxcb->paddr, msdu->len + skb_tailroom(msdu),
+			 DMA_FROM_DEVICE);
+	dev_kfree_skb_any(msdu);
+
+	return 0;
+}
+
 int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			     int budget)
 {
@@ -3825,6 +3867,26 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 		drop = false;
 		ab->device_stats.err_ring_pkts++;
 
+		hw_link_id = le32_get_bits(reo_desc->info0,
+					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
+		device_id = hw_links[hw_link_id].device_id;
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+
+		/* Below case is added to handle data packet from un-associated clients.
+		 * As it is expected that AST lookup will fail for
+		 * un-associated station's data packets.
+		 */
+		if (le32_get_bits(reo_desc->info0, HAL_REO_DEST_RING_INFO0_BUFFER_TYPE) ==
+		    HAL_REO_DEST_RING_BUFFER_TYPE_MSDU) {
+			if (!ath12k_dp_h_msdu_buffer_type(partner_ab,
+							  &rx_desc_used_list[device_id],
+							  reo_desc)) {
+				num_buffs_reaped[device_id]++;
+				tot_n_bufs_reaped++;
+			}
+			goto next_desc;
+		}
+
 		ret = ath12k_hal_desc_reo_parse_err(ab, reo_desc, &paddr,
 						    &desc_bank);
 		if (ret) {
@@ -3833,11 +3895,6 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			continue;
 		}
 
-		hw_link_id = le32_get_bits(reo_desc->info0,
-					   HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
-		device_id = hw_links[hw_link_id].device_id;
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-
 		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
 						      hw_links[hw_link_id].pdev_idx);
 		ar = partner_ab->pdevs[pdev_id].ar;
@@ -3886,6 +3943,7 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			}
 		}
 
+next_desc:
 		if (tot_n_bufs_reaped >= quota) {
 			tot_n_bufs_reaped = quota;
 			goto exit;
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index 669096278fdd..c4443ca05cd6 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "debug.h"
@@ -323,7 +323,7 @@ int ath12k_hal_desc_reo_parse_err(struct ath12k_base *ab,
 {
 	enum hal_reo_dest_ring_push_reason push_reason;
 	enum hal_reo_dest_ring_error_code err_code;
-	u32 cookie, val;
+	u32 cookie;
 
 	push_reason = le32_get_bits(desc->info0,
 				    HAL_REO_DEST_RING_INFO0_PUSH_REASON);
@@ -338,12 +338,6 @@ int ath12k_hal_desc_reo_parse_err(struct ath12k_base *ab,
 		return -EINVAL;
 	}
 
-	val = le32_get_bits(desc->info0, HAL_REO_DEST_RING_INFO0_BUFFER_TYPE);
-	if (val != HAL_REO_DEST_RING_BUFFER_TYPE_LINK_DESC) {
-		ath12k_warn(ab, "expected buffer type link_desc");
-		return -EINVAL;
-	}
-
 	ath12k_hal_rx_reo_ent_paddr_get(ab, &desc->buf_addr_info, paddr, &cookie);
 	*desc_bank = u32_get_bits(cookie, DP_LINK_DESC_BANK_MASK);
 
-- 
2.34.1



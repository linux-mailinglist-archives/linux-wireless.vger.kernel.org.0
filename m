Return-Path: <linux-wireless+bounces-15514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDA9D2BE1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 17:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02956B2CB2A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B111D61A2;
	Tue, 19 Nov 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J+Qrgqm7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA31D63F8
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034769; cv=none; b=Tv7sLn40fz2MhHf2Y6hiQsjU5NI96SBGa+1nyYF/pBVn3KEWEsKnD0Gc2phziAuxXUM69sIQ4A3qfyrBqGQ+XwGImFPYxzn/ZBXE0oD5Qxn508UEnW2YMDri9MrGI58Cci7NR3Yog5ONoVrBn0sfXanVa4N9v62OisaL07/+fvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034769; c=relaxed/simple;
	bh=oGbqUl888DTllu0sly02RqgHTRTs85VOTZeuqbNyvqg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h1AAcfeNPl15Ac3s0Slq3/6EXTEmiESjgJQzjWSjLQOHKbyUR2ISKq15TqBM1Zz6Rvy/5mSQjuW9XyyiDZXczLl/RXECYwlUmnFceejL5KuyGY/F/PSyUdu7sPWG/ADnYfhbjCYsIYXn1evYZqD+leIak3JaGMxLaHjhCnm3vus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J+Qrgqm7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7XbKG010489;
	Tue, 19 Nov 2024 16:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vlJvG730gygx5McVjoi1/8
	8ZhVN8drGvUk3A94EcRyk=; b=J+Qrgqm7tSZz374CPbYcg9UoXQn7SzsUpv1nqy
	v13krBioxEp/qSjlvxn8p+lu45r46ujrJWIiasYoP1PhzZoOHfXJk7VnL5c65eKt
	SY0ct530tBAJUKEZzbtOKigttouJPC6Bc15ThmNR0XrVgK/uMxjE6+zVGdKWBA7k
	FP5SO/m4EF5DBgW7BnP15CGlhqtMcMFsQGgb4PtRuT/y1Nz+0h1bZFn/M0W/wNSG
	fgeSsmIwUTV/nNX35CmhZnWs+SaTq4oMI0f66Xa+cMtNb+ScHUaBw5VdRUk5FyYF
	LhdwlwnP0qjyxI2lFqFwCcrvGnNIIxoEHzW2eEOCS5XNOAHQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y9353e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 16:46:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJGk190004361
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 16:46:01 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 19 Nov 2024 08:45:59 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH] wifi: ath12k: Fix endianness issue in struct hal_tlv_64_hdr
Date: Tue, 19 Nov 2024 22:15:16 +0530
Message-ID: <20241119164516.756478-1-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: onQRulFWjw1UA2zrSnREwye8T-fNFPYe
X-Proofpoint-GUID: onQRulFWjw1UA2zrSnREwye8T-fNFPYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411190124

struct hal_tlv_64_hdr has a 64-bit member that should be in little-endian
format, but the current definition uses host byte order. Fix this by
changing the definition and updating the corresponding helper functions
used for the byte order conversion.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c    |  2 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h |  2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c   | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 9ae579e50557..0fb39c174475 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3912,7 +3912,7 @@ void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
 	ath12k_hal_srng_access_begin(ab, srng);
 
 	while ((hdr = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
-		tag = u64_get_bits(hdr->tl, HAL_SRNG_TLV_HDR_TAG);
+		tag = le64_get_bits(hdr->tl, HAL_SRNG_TLV_HDR_TAG);
 
 		switch (tag) {
 		case HAL_REO_GET_QUEUE_STATS_STATUS:
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 739f73370015..a460d432288f 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -581,7 +581,7 @@ struct hal_tlv_hdr {
 #define HAL_TLV_64_HDR_LEN		GENMASK(21, 10)
 
 struct hal_tlv_64_hdr {
-	u64 tl;
+	__le64 tl;
 	u8 value[];
 } __packed;
 
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index f7c1aaa3b5d4..ac17d6223fa7 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -26,8 +26,8 @@ static int ath12k_hal_reo_cmd_queue_stats(struct hal_tlv_64_hdr *tlv,
 {
 	struct hal_reo_get_queue_stats *desc;
 
-	tlv->tl = u32_encode_bits(HAL_REO_GET_QUEUE_STATS, HAL_TLV_HDR_TAG) |
-		  u32_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
+	tlv->tl = le64_encode_bits(HAL_REO_GET_QUEUE_STATS, HAL_TLV_HDR_TAG) |
+		  le64_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
 
 	desc = (struct hal_reo_get_queue_stats *)tlv->value;
 	memset_startat(desc, 0, queue_addr_lo);
@@ -59,8 +59,8 @@ static int ath12k_hal_reo_cmd_flush_cache(struct ath12k_hal *hal,
 		hal->current_blk_index = avail_slot;
 	}
 
-	tlv->tl = u32_encode_bits(HAL_REO_FLUSH_CACHE, HAL_TLV_HDR_TAG) |
-		  u32_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
+	tlv->tl = le64_encode_bits(HAL_REO_FLUSH_CACHE, HAL_TLV_HDR_TAG) |
+		  le64_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
 
 	desc = (struct hal_reo_flush_cache *)tlv->value;
 	memset_startat(desc, 0, cache_addr_lo);
@@ -97,8 +97,8 @@ static int ath12k_hal_reo_cmd_update_rx_queue(struct hal_tlv_64_hdr *tlv,
 {
 	struct hal_reo_update_rx_queue *desc;
 
-	tlv->tl = u32_encode_bits(HAL_REO_UPDATE_RX_REO_QUEUE, HAL_TLV_HDR_TAG) |
-		  u32_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
+	tlv->tl = le64_encode_bits(HAL_REO_UPDATE_RX_REO_QUEUE, HAL_TLV_HDR_TAG) |
+		  le64_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
 
 	desc = (struct hal_reo_update_rx_queue *)tlv->value;
 	memset_startat(desc, 0, queue_addr_lo);

base-commit: 0ea161de5e5afa1323e982adc8f59bf4af99a84b
-- 
2.34.1



Return-Path: <linux-wireless+bounces-10653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF62940617
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 05:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5804F1C2116F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 03:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2CA146A79;
	Tue, 30 Jul 2024 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OHLymZ/P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE76BE5D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311544; cv=none; b=CwudKNxqNUCDbL6ima0BwvWqUQhicBdTio+bhH5OdBKAvcC5jUMSsl0d838FhH5K428UfQAYeaz/9RK6biQDbMGbdhSKT+H0eUZIxiyt/3ZH5DIE2JCDeCsFN18jVg9ZaTffkJVrAX6fGiXZgH6M2e6witmImAb41u3NCzEEeU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311544; c=relaxed/simple;
	bh=8qwdBaI71dzq1axrenR5rDFDaBRMLtVCMi5IqaBzKEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X0R6JYdrVBIoWkZKdWf/8unuGgtVfapVJ0htNZRaYfSYLgGNv/puX4YapTlOmHpVDJDxDYx3R/s/sWuM5rNbtQxcQB33iQXAQIqXby2aBHtUP5ufO2qm5OKWxptGEXeMGnFlIiiL9MZpLahkNh6TFh8E9HnyuEOs+B+5xUOFS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OHLymZ/P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U1ECrS002796;
	Tue, 30 Jul 2024 03:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QlOXAqIAke/i/+55iXYKdr
	6UqllRFLxYXFdthomviN4=; b=OHLymZ/PmcfSgFnmrjlcOO+nzt4zW+fgDYDLXs
	jTEfyucZhCFyuvsSbV0c+c6bFcr0woIzVV6xtefATRXjZcnlpvs/g8SvdnSSzWjQ
	L/9anpJv8BEUDYdIyeWLF1sINmovTDREkEhFGNBUh9nottNE+jXxUaE4GMQNe3PB
	O0tISedVTU9S2854wgAvfuXuHFOgkoCF2WMECIngXANY8BBag2d/E4dJ4SwrlTji
	kEsMfIGb3LHyBJ+Whu2nmvSdjcHPPoBqw9iiD1y0ONzjxmxYug9QQD+kME8I+Uc7
	R7dgckKlBJGL33KczH5Ai9tKPr064rTSPDoIMnB+MevTIF2A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mpkex7bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 03:52:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U3qJJ7012122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 03:52:19 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 20:52:17 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Date: Tue, 30 Jul 2024 09:21:54 +0530
Message-ID: <20240730035154.3723773-1-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GvE_CJRyAPnzzbGZCh-GvfYPKFh-0uVF
X-Proofpoint-GUID: GvE_CJRyAPnzzbGZCh-GvfYPKFh-0uVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_03,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=900 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300027

The API print_array_to_buf() currently supports printing
arrays with 0 indexing. In some cases, a few arrays need
to be printed with 1-based indexing, i.e., array should be
printed, starting with 1.

Add a new version of print_array_to_buf(), named
print_array_to_buf_v2(), which implements the functionality
of print_array_to_buf(), but with an extra variable,
pointing to the index starting with which the array should
be printed. Modify print_array_to_buf() to call
print_array_to_buf_v2() with 0 as the starting index.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index f1b7e74aefe4..4d7fe4b4f320 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -12,8 +12,8 @@
 #include "dp_rx.h"
 
 static u32
-print_array_to_buf(u8 *buf, u32 offset, const char *header,
-		   const __le32 *array, u32 array_len, const char *footer)
+print_array_to_buf_v2(u8 *buf, u32 offset, const char *header, u32 stats_index,
+		      const __le32 *array, u32 array_len, const char *footer)
 {
 	int index = 0;
 	u8 i;
@@ -26,7 +26,7 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
 	for (i = 0; i < array_len; i++) {
 		index += scnprintf(buf + offset + index,
 				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
-				   " %u:%u,", i, le32_to_cpu(array[i]));
+				   " %u:%u,", stats_index++, le32_to_cpu(array[i]));
 	}
 	/* To overwrite the last trailing comma */
 	index--;
@@ -40,6 +40,13 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
 	return index;
 }
 
+static u32
+print_array_to_buf(u8 *buf, u32 offset, const char *header,
+		   const __le32 *array, u32 array_len, const char *footer)
+{
+	return print_array_to_buf_v2(buf, offset, header, 0, array, array_len, footer);
+}
+
 static void
 htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
 				struct debug_htt_stats_req *stats_req)

base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
-- 
2.25.1



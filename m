Return-Path: <linux-wireless+bounces-15879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFE29E33E9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 08:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19704B2737B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 07:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5A318C011;
	Wed,  4 Dec 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ErBrG0Nz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632818C01D
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296391; cv=none; b=FpPPsAcv91oGTlK7jCi5GaaLNO4LFDngMSL/yh3sD2q6zf9vbxb48ZpI5Dnit6UdWHfcIXeYCws59wSQ90lMHWBvIEZz4Tny0MC/FxVk27JYhhp7RVr4K5gdD+/cSLn/5DKCPXqL3LjRLA1cOvGbJEwRTuAoJVsaY3DyaLxzbVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296391; c=relaxed/simple;
	bh=gJxoJJ7UYnxGSHuBdIk7BGXFMoniv+5T9IhKr9BXT/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E8N0XHS9LRAIp1ZGcyPkw4Pnx5tK80W4cb3iZ7O15nQjJRhhXp7UmOoe1mijkmT4sgelWPKhsIZj+qVHJ1lwAUgJu/yBGWdMQkWhNdGDPaapISSBBdIfkIQZGRgrJwMDAVicyBtmso0c+DHbHSXBO73kf3413g25M/K5X2UUfnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ErBrG0Nz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B45xtLW010494;
	Wed, 4 Dec 2024 07:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7sGOD67PyyE1wk6exvRwuW
	JEfYcSPOVVzhpon+BR3l0=; b=ErBrG0NzmYfM5tJ4EPs8RhUotuQcksB5AAjoiX
	P/jbYRcoFTVTUFwd9iyVNQaKBT5PkokUvwh/kxBgzYdsibKeGQNvSGeOIXUnJuI6
	wGRjDRK84LA3fM/YlsxZGnw2YkTIQVxZC2Z6DTHMg/wLjv0s/EYUxU4K5hc37pZA
	zjjP3zie/p5AI6tppg2pG2D64hnWseAtWsrP01omsl1LTfiHbjLkIVykSQvNnKuE
	mV32+MHLmqaRcsjaGMg+asgeXdv4ALLaIweHrGBJZa/LKAiDALQ5DBNPQs/QyZUr
	3xkoUNiHShhaPJVqL3tIiI2u+DuA/wyWIlTEMCeSn0mR7uFQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439v7yuhfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 07:13:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B47D3PF026362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 07:13:03 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Dec 2024 23:13:01 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH] wifi: ath12k: Add support for parsing 64-bit TLVs
Date: Wed, 4 Dec 2024 12:42:38 +0530
Message-ID: <20241204071238.948885-1-quic_ppranees@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y0LzFXmufgx-_EPKqb6DsHqs3z_cPsfw
X-Proofpoint-GUID: y0LzFXmufgx-_EPKqb6DsHqs3z_cPsfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040056

There is mismatch between the format of monitor destination TLVs received
and the expected format by the current implementation. The received TLVs
are in 64-bit format, while the implementation is designed to handle
32-bit TLVs. This leads to incorrect parsing. Fix it by adding support
for parsing 64-bit TLVs.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c   | 14 +++++++-------
 drivers/net/wireless/ath/ath12k/hal_desc.h |  2 ++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 494984133a91..dff14f77f504 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1199,19 +1199,19 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k_base *ab, struct ath12k_mon_data *pmon
 			    struct sk_buff *skb)
 {
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	struct hal_tlv_hdr *tlv;
+	struct hal_tlv_64_hdr *tlv;
 	enum hal_rx_mon_status hal_status;
-	u32 tlv_userid = 0;
+	u32 tlv_userid;
 	u16 tlv_tag, tlv_len;
 	u8 *ptr = skb->data;
 
 	memset(ppdu_info, 0, sizeof(struct hal_rx_mon_ppdu_info));
 
 	do {
-		tlv = (struct hal_tlv_hdr *)ptr;
-		tlv_tag = le32_get_bits(tlv->tl, HAL_TLV_HDR_TAG);
-		tlv_len = le32_get_bits(tlv->tl, HAL_TLV_HDR_LEN);
-		tlv_userid = le32_get_bits(tlv->tl, HAL_TLV_USR_ID);
+		tlv = (struct hal_tlv_64_hdr *)ptr;
+		tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
+		tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
+		tlv_userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
 		ptr += sizeof(*tlv);
 
 		/* The actual length of PPDU_END is the combined length of many PHY
@@ -1226,7 +1226,7 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k_base *ab, struct ath12k_mon_data *pmon
 		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ab, pmon,
 							       tlv_tag, ptr, tlv_userid);
 		ptr += tlv_len;
-		ptr = PTR_ALIGN(ptr, HAL_TLV_ALIGN);
+		ptr = PTR_ALIGN(ptr, HAL_TLV_64_ALIGN);
 
 		if ((ptr - skb->data) >= DP_RX_BUFFER_SIZE)
 			break;
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index a460d432288f..b90a6da72e29 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -579,6 +579,8 @@ struct hal_tlv_hdr {
 
 #define HAL_TLV_64_HDR_TAG		GENMASK(9, 1)
 #define HAL_TLV_64_HDR_LEN		GENMASK(21, 10)
+#define HAL_TLV_64_USR_ID		GENMASK(31, 26)
+#define HAL_TLV_64_ALIGN		8
 
 struct hal_tlv_64_hdr {
 	__le64 tl;
-- 
2.34.1



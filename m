Return-Path: <linux-wireless+bounces-16564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930669F7140
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 01:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D2318908CE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72DD2111;
	Thu, 19 Dec 2024 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j4qUoTdI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461163C0C
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734567036; cv=none; b=n8GfSFVVU8w+nC7tX8yG+68QsVUnlv7g2LZy666C2WQk8LaBwPaBdaLMXCNyCsIX/PB4wmiDFWOfUgGDsw7S5Bqg+USjWBtmQ2n1WMa9oHKRPQA1W1lTjGnvKtZXdjtZ93O23dT+4oW6Un+gLbQJAEoDVb5gaR+N2aXw0BNDiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734567036; c=relaxed/simple;
	bh=Yd/yP2Z5BRaWlGuNHMQSGn1d132C2mEXovuk1JepF1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I30tXJ/YNY0nbl63K8gFiN5qTaUpqKzGPm2typDOlynZZixRgUBeeIvdS3DK+Wl+9sYY/BhQVRjv0IjMauuNClf8C1VdsiDG9kTIHl8wNzNgrwjcTBunicDPHukE0QOIDyzELQ81BqJY/WpxLmZ2xSRqeQI25ah8aPoNyJGCbss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j4qUoTdI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIGQvmq013076;
	Thu, 19 Dec 2024 00:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7mQSRfnWmcbm954WJglRcWKAdR0wI1ssuOnoCXGUcN8=; b=j4qUoTdIY2jeHwQ/
	+AcY3DA8unjWUUxlSU3bANtWHNzF8hzix7TsnZcXD49ZkFr6mTJ/LUd0V+LhA+hS
	dwm4WccYr1dKmJhigLzL7POx87cVa0ezO6tX0SFQVASYtnxB6S7l1MmWr5vIIK+P
	tJjihD8WFwQQpBSJiNGvdyjmAsyrHSfgtY2Rzn9vhr9f74WvPWBba06RyIXN6VWx
	uWs9ck4MDaSMn7Uw3lb+Lwscx+HKE7jiffONny1iTpmLeF2DSG5j23FHlaRlMVb1
	97lYVQxTuJYYVDrVakbULH3lAv5b+Cknq9qqz/+dj8YbHsOB5AQKSxalnRMGi6Jm
	NLttLg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43kyjx9cfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 00:10:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJ0AWht016823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 00:10:32 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 18 Dec 2024 16:10:30 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: Refactor Rx status TLV parsing procedure argument
Date: Thu, 19 Dec 2024 05:40:06 +0530
Message-ID: <20241219001006.1036495-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
References: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: TjRHxDoDC6fbfxTVadc8nOT4NO85JC2l
X-Proofpoint-GUID: TjRHxDoDC6fbfxTVadc8nOT4NO85JC2l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180188

Currently, ath12k_dp_mon_rx_parse_status_tlv() takes the TLV tag, TLV data
and TLV userid as separate arguments from the caller. These argument can
be fetched from the TLV header itself. Therefore, pass the TLV header and
retrieve the necessary fields from the header instead of passing them from
the caller.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index ae2f6847bc88..53f8e8f8959a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -565,12 +565,16 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
 static enum hal_rx_mon_status
 ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
 				  struct ath12k_mon_data *pmon,
-				  u32 tlv_tag, const void *tlv_data,
-				  u32 userid)
+				  const struct hal_tlv_64_hdr *tlv)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	u32 info[7];
+	const void *tlv_data = tlv->value;
+	u32 info[7], userid;
+	u16 tlv_tag;
+
+	tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
+	userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
 
 	switch (tlv_tag) {
 	case HAL_RX_PPDU_START: {
@@ -1187,7 +1191,6 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 	struct hal_tlv_64_hdr *tlv;
 	enum hal_rx_mon_status hal_status;
-	u32 tlv_userid;
 	u16 tlv_tag, tlv_len;
 	u8 *ptr = skb->data;
 
@@ -1196,9 +1199,6 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 	do {
 		tlv = (struct hal_tlv_64_hdr *)ptr;
 		tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
-		tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
-		tlv_userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
-		ptr += sizeof(*tlv);
 
 		/* The actual length of PPDU_END is the combined length of many PHY
 		 * TLVs that follow. Skip the TLV header and
@@ -1208,10 +1208,11 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k *ar, struct ath12k_mon_data *pmon,
 
 		if (tlv_tag == HAL_RX_PPDU_END)
 			tlv_len = sizeof(struct hal_rx_rxpcu_classification_overview);
+		else
+			tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
 
-		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ar, pmon,
-							       tlv_tag, ptr, tlv_userid);
-		ptr += tlv_len;
+		hal_status = ath12k_dp_mon_rx_parse_status_tlv(ar, pmon, tlv);
+		ptr += sizeof(*tlv) + tlv_len;
 		ptr = PTR_ALIGN(ptr, HAL_TLV_64_ALIGN);
 
 		if ((ptr - skb->data) >= DP_RX_BUFFER_SIZE)
-- 
2.34.1



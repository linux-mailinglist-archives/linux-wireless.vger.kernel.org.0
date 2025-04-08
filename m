Return-Path: <linux-wireless+bounces-21269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B383BA80BE4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 15:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588DB4A72FE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73B2169397;
	Tue,  8 Apr 2025 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NlFCx+70"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DA15A85E
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117321; cv=none; b=hHd2Snei7YO7ZROBT/Y0PJvvUOuH/UDXTzNtDoA/sf+RGlnlhMc99a0pCEEeFo9599rR/KRly7jPprEzpE6XGYrMfJbDhNZ7VgRxCOoCefEjbe5bQ9x/UIp33VVDHfTe7/z6AQQtVAo3DqmzTlupDXHNyK+NyggjTXipixoUAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117321; c=relaxed/simple;
	bh=X4GNIfMm/Y3gwacj2uCIsakB8UkMt752RnqrJpcqBcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvTVUJsSEtL+Seo5BnKvACr0U1VzCIgaVbhp4VpLp6mUp8SFCxb/XxRIoAR7V1bWBMlbd8wMSS5DxcM7Q44/Ufoy/ZhzK2xaaBT287cs98D1kUZQ3LgvK0ubEsytxIIzLxbwJnBft5AHu5cxqo2jKi4p2f6J/+CEC181WDYj/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NlFCx+70; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538ApV35015100;
	Tue, 8 Apr 2025 13:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ttofQOL+WMMFfjJMOx2TVh7aF1mo2VIiAL6x/kLeGKg=; b=NlFCx+704zdl+tCd
	KVwjuC194480VFjAvWRRE9Z8kJaBZ++RYTQqIl+8sFJzxVSAr1szAT5PeEzKC6Ou
	vcldip/WzgbpY1lJUre8Rfll3Gqu73tGmnY7yu264BQca7+aTqfkQUcqNiN6jmG8
	SDRED7YR6WkMzQgsD/Xnqm5sLjNa/qEmkW0PDyPXIy/xAJp3sFOql6rTUDArMDlW
	PD2TE2SWhGZMUH68yhhJ8vFhGBeNBQ5ps8vXX+Ri7F1VdHe8VmwTpZPYzQcpcWGQ
	CO6Vns8e87r4+XkE5yf7n+7QkGWFcVLXRlYoOi0VcoM7G7EA4AaHuCm0ynwD9CPP
	QzDI6A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbufu0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 13:01:56 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 538D1ujg011024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 13:01:56 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Apr 2025 06:01:54 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next 1/2] wifi: ath12k: using msdu end descriptor to check for rx multicast packets
Date: Tue, 8 Apr 2025 18:31:31 +0530
Message-ID: <20250408130132.2919329-2-quic_sarishar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408130132.2919329-1-quic_sarishar@quicinc.com>
References: <20250408130132.2919329-1-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XuwSweyJsX4T2xzZmjc9vACk8m7Anr2b
X-Proofpoint-ORIG-GUID: XuwSweyJsX4T2xzZmjc9vACk8m7Anr2b
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f51e45 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=nNR53KzduslkgKGKa6YA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_05,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=672 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080092

Currently, the RX multicast broadcast packet check is performed using
bit 15 from the info6 field of the MPDU start descriptor. This check
can also be done using bit 9 from the info5 field of the MSDU end
descriptor. However, in some scenarios multicast bit is not set when
fetched from MPDU start descriptor.
Therefore, checking the RX multicast broadcast packet from the MSDU
end descriptor is more reliable as it is per MSDU.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index d00869a33fea..d961392bb981 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -449,8 +449,8 @@ static u8 *ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
 
 static bool ath12k_hw_qcn9274_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le32_to_cpu(desc->u.qcn9274.mpdu_start.info6) &
-	       RX_MPDU_START_INFO6_MCAST_BCAST;
+	return __le16_to_cpu(desc->u.qcn9274.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
 }
 
 static void ath12k_hw_qcn9274_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
@@ -902,8 +902,8 @@ static u8 *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc
 
 static bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
 {
-	return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info6) &
-	       RX_MPDU_START_INFO6_MCAST_BCAST;
+	return __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info5) &
+	       RX_MSDU_END_INFO5_DA_IS_MCBC;
 }
 
 static void ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
-- 
2.34.1



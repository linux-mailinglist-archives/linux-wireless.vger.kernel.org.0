Return-Path: <linux-wireless+bounces-15909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFCA9E4B9F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 02:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F4286260
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 01:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662DC84A22;
	Thu,  5 Dec 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SA12zbYB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE378C6D
	for <linux-wireless@vger.kernel.org>; Thu,  5 Dec 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733360902; cv=none; b=Rm7rDg/71oij0P+XJdp9s4CvH8jVpZBpYUbkub2hnxSXGQ6bagZWk6cH1qmeuZ9/5GfRy1gIWaHjqY1i1su2jK134Toc/s4IrX9zDHfL1xP0gZZskY9kKxVLtGqnsoJqe4/CjAphxRddEVlBV1GEP7YSs6LekpJzwPbsAnq1gyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733360902; c=relaxed/simple;
	bh=nSkT+pPcj42vvhLmyT5jke9S45zzT+kD6pnz/oX6xJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwAKFxY0vcbmXAaUtgplQcfcxZSh6x/1ppkV5iEY3IMY8ISAMuKqZmTzYgHkfq6Wr3qmIYNoNFmveSMhJv4YR6XKUD+2FjOB1GcPP++avJuFY2MXNsRFZL3/BeYOBWPWX7Vk8mx0jpM7sKYSa6+AqGDoMZwgK8iXXHyWgCIIfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SA12zbYB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4I0Jao024747;
	Thu, 5 Dec 2024 01:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T2gaLgWNFft4iK51m0VNrU4LZQ1b2jyDreSTwO7NR+8=; b=SA12zbYBRaxVyGqY
	slNh0+PhUYhQB3/eOO4yjwu1O7lAP//oVZ3mGZp7Pi/1l1fcwwbFlOWBIHmOQTkW
	gUGXVBRXJqvdKxioLd6GgoQ9ZVqoayZsKRFAJSuzeoG8GQUV8F1muYVsUtpYXmrC
	8G4jLj37pCQEhQWRuCOc6dyXqbsI1fR3MTxKS0VzfOGwuMOVoIvbJHa41iKbyiic
	ioaP4bU0rr+Be24noydIRhQhxkUig2/Y7jbMHXLyRR5qmbSzgkaJonDKRak9db1G
	N2VFeP9QQILeDkQ//M+2kiamwRpW+XZGHyKJy6D9rabN3mS4pxEMOJRrVCFbOQb8
	96pJeg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439vnyww6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 01:08:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B518GIP023945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 01:08:16 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 17:08:14 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 3/8] wifi: ath12k: cleanup Rx peer statistics structure
Date: Thu, 5 Dec 2024 06:37:49 +0530
Message-ID: <20241205010754.2846603-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205010754.2846603-1-quic_periyasa@quicinc.com>
References: <20241205010754.2846603-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 463_uWKHD1iVELMFj31cymzYIBEwtyh6
X-Proofpoint-GUID: 463_uWKHD1iVELMFj31cymzYIBEwtyh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=858 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050006

Currently, unused fields are present in the Rx peer statistics
structure. These fields are already present in the same structure
under the ath12k_rx_peer_rate_stats container structure. Therefore,
remove the unused fields from the Rx peer statistics structure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 9ddced140056..faab3329e15f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -375,10 +375,6 @@ struct ath12k_rx_peer_stats {
 	u64 non_ampdu_msdu_count;
 	u64 stbc_count;
 	u64 beamformed_count;
-	u64 mcs_count[HAL_RX_MAX_MCS + 1];
-	u64 nss_count[HAL_RX_MAX_NSS];
-	u64 bw_count[HAL_RX_BW_MAX];
-	u64 gi_count[HAL_RX_GI_MAX];
 	u64 coding_count[HAL_RX_SU_MU_CODING_MAX];
 	u64 tid_count[IEEE80211_NUM_TIDS + 1];
 	u64 pream_cnt[HAL_RX_PREAMBLE_MAX];
-- 
2.34.1



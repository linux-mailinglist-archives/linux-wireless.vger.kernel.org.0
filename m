Return-Path: <linux-wireless+bounces-16633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131FF9F83CE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 20:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72451882B52
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72491A704C;
	Thu, 19 Dec 2024 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EcFQrg+M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A2C1A76CB
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734635344; cv=none; b=tUYIeWhCwmbQoxZUkroBDBoeScUjxqwlvnFtdXgzcfOlF2oaBrgaffizDkvnCRDIeNLVWftySsRR3CIr51Lw1BNYCTLRIjAylaTW+d/+BvZSTcvTKyHeHvGXaZ8o3i+3Y3lBFpcT5BCfQVck3Ny3ykaYuBF0lE/GJ0Bn+FRrgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734635344; c=relaxed/simple;
	bh=WIMID/G/JbmjNUP8I25RgPU31SnEIrctLG+JgLp6usg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJxs+uGPIxdvXHPjC1CAnxS2PO+DgoDsgSQ2FRfiO6LC3hLPPzFg7sdPJvi2xGISMDzbm0fndc2fKjvnL9+gLKcCvCoao3esWG3LIlVVAZVX2TGeqGigWYaaBCqaPxYzw/ibes1GpwLEXwaqJDGLoK7yxopjabEYwShLUGZRCLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EcFQrg+M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJHKmIp015057;
	Thu, 19 Dec 2024 19:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Y9feI2JUBwkJCvzz6V1r9y
	Fr0fx6Vk4uQjBQj063kCI=; b=EcFQrg+MOtW8nFF99Dxc2FmkTzD1/YIsOE7tV7
	i4CT50tpyEUkuKSzesGXj5C2RHKR+sW+MR/UkkahgOX3hat9PqbRG/V/kyXDQKCY
	7GnKf5NYptlEUhYlRa+8znlNnTXySqeT1q+f7t+sAeqIQQ7D9MT1D8Zi1e1ULXDz
	vzYRsg+Gvn8UnkQO4dWejROdzng6hBpLbPkS3ms+BGXsYGUownB4RzqV7K6z9wsK
	JPp5p9rOa8lM2MwQLySLtg20CFknUVV6yf2HdrZgAGGWqzOARaL+BzNC9qCkK9LC
	tDFNmjuArdyL+ivmYn40XSdbsA7cvZXn0UhDbkmeVN0ybyAw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mqt80821-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 19:08:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJJ8xnk009132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 19:08:59 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Dec 2024 11:08:58 -0800
From: Muna Sinada <quic_msinada@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Ramya Gnanasekar
	<quic_rgnanase@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH] wifi: ath12k: set flag for mgmt no-ack frames in Tx completion
Date: Thu, 19 Dec 2024 11:08:45 -0800
Message-ID: <20241219190845.605116-1-quic_msinada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NiuqUt-k5_1UNvCvZLHUTOOBWvFou5hO
X-Proofpoint-GUID: NiuqUt-k5_1UNvCvZLHUTOOBWvFou5hO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412190152

From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>

IEEE80211_TX_STAT_NOACK_TRANSMITTED flag signifies that frame was
successfully transmitted without any errors when no-ack is requested.

In WMI Tx management completion path, driver is not setting
IEEE80211_TX_STAT_NOACK_TRANSMITTED flag for the frames with
IEEE80211_TX_CTL_NO_ACK. Without this flag, the management frame
statistics will not track such frames.

Add IEEE80211_TX_STAT_NOACK_TRANSMITTED flag as part of the flags in
skb transmit information when WMI is processing Tx completion for
management frames.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 562b0615ed06..a098d4303a63 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5362,6 +5362,9 @@ static int wmi_process_mgmt_tx_comp(struct ath12k *ar, u32 desc_id,
 	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status)
 		info->flags |= IEEE80211_TX_STAT_ACK;
 
+	if ((info->flags & IEEE80211_TX_CTL_NO_ACK) && !status)
+		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
+
 	ieee80211_tx_status_irqsafe(ath12k_ar_to_hw(ar), msdu);
 
 	num_mgmt = atomic_dec_if_positive(&ar->num_pending_mgmt_tx);
-- 
2.34.1



Return-Path: <linux-wireless+bounces-5245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6C988B100
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 21:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6143030DF
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197F54279;
	Mon, 25 Mar 2024 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MrAbmCcY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A7B45025
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397460; cv=none; b=c/4Z80C0ZPeYXHy35v7igHcY0WpU1Tc2a7bWEqKy+mDTOzvP9UjRvTY4ZjBXiqetOefgEgFQNoNnlyA5/tp3ihzKoyoUSqoYFV4wAL2auc89sKM0qBr6cKjBNzaGn8l/eLdZMhK6qmjxs+0gDODaBo7T4D5bVFCHDQuytotGviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397460; c=relaxed/simple;
	bh=+kpIzwE7p/69lCuC7Jz7Mc/qR2Y4Qx6gE84bxs7ZLNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YARjWTGeO9Iyhn2+yUufuuWdW0NzQPix006WeN64ObuNPLB0T9Nsk7Ayxl8ZTKtX8ZAU68+UIWIrOGI7yI3HCCjQnZxG8BC4CYAKJVvFxLGUdmEOc0t6+u+NjlDTZjJzSZTxHs0NuLoFqXEPIdRGh266TMlYWBsY/zw3LhGkcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MrAbmCcY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PJ9POA010263;
	Mon, 25 Mar 2024 20:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=z3/lnMI5E9kXNMHD4HDV
	kf5R8rR8Yl+LoOUITg35Y+4=; b=MrAbmCcY2gvd5DH4WrzNl8sCl/Gu9Veh/hMd
	ZF2lcadStEU2CD/m5cf7o6dHUMF8oOUL2JcnBhy2SNSU0olIqNiuFL/3411oCbtq
	fIMtOhnP1FQRjwM1w8A0w0AfUIZOrkMlJVR3AQFwsMSUgBN0lIn0YGG6jdZc9EO3
	yYqvFzjW+GFNgd97oqTXxmoHMOfBV9zhB6/fFTDQXaEUS3JOztdJvsoBoSDPq+up
	nYDi1hZcmvXrwIY9KY5PqnBdftPnzQoIvvvM+mbZs3lIsOFn01MoiDKo2SYUoNhy
	4VSnfooNM5Kb0K6ckeZxX4EPsfIA8ys3WyLQ5hrcIJscNyf9fg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x34hp1t3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:10:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PKAqVa007404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 20:10:52 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 13:10:51 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH 06/10] wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
Date: Mon, 25 Mar 2024 13:10:27 -0700
Message-ID: <20240325201031.10837-7-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
References: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YYVkBTP9mdwReybHbw8AqwALqY9_Tz2V
X-Proofpoint-GUID: YYVkBTP9mdwReybHbw8AqwALqY9_Tz2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_19,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=998
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250123

Currently, the TX and RX MCS rate configurations per peer are
reversed when sent to the firmware. As a result, RX MCS rates
are configured for TX, and vice versa. This commit rectifies
the configuration to match what the firmware expects.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 ++--
 drivers/net/wireless/ath/ath12k/wmi.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 34de3d16efc0..c550ced42084 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2112,8 +2112,8 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		he_mcs->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_HE_RATE_SET,
 							    sizeof(*he_mcs));
 
-		he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
-		he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
+		he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
+		he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
 		ptr += sizeof(*he_mcs);
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 752fc2d53d8f..cf273298227d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3863,7 +3863,9 @@ struct ath12k_wmi_vht_rate_set_params {
 
 struct ath12k_wmi_he_rate_set_params {
 	__le32 tlv_header;
+	/* MCS at which the peer can receive */
 	__le32 rx_mcs_set;
+	/* MCS at which the peer can transmit */
 	__le32 tx_mcs_set;
 } __packed;
 
-- 
2.17.1



Return-Path: <linux-wireless+bounces-17456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8108DA0FD74
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 01:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E787A37AF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB283596A;
	Tue, 14 Jan 2025 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SBwzNDNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACCCF9D9
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736815112; cv=none; b=lNi/uLtE3gpWdk7kAxVyMUTBtISSDCd4JCDP9CrTNtWvbbRZXODywZgm1Clg0IckOz2xOGGr7Jj2h1yr/KihCgJaCN2+GhLYvezLXCS6o80BJOMIOw0+nY04w+UXN44KiAsfMB7/8f++UcKIzXT30u6EcwvtYypma/IKey/5niA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736815112; c=relaxed/simple;
	bh=C1aLwziabLr+z0QXLmg2OqtoFW2/C39L/hxkNx6Nopo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G423FrssHpkzt+Yvs0g1oo57s66KF3gDkD6KPY3I2FUSD55y7R/DZdQqcjxj0ZHvxCQiIvLpbYNPRijdFQIM79zBZdQ7aM2FCPGAwiZYpGv1SVXNg6M4KFotW2xtrHnLSVYbDMedErwCf31w+0SoFvuP6hwadUoOUry0LPwvQq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SBwzNDNl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DH3nsh020388;
	Tue, 14 Jan 2025 00:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ouGlQEbhsQNs0UFUFLi2gF6gczK+6auE8D0OYYfB/gw=; b=SBwzNDNltctaVMpo
	MJ3ZYH/qAV5F/WA0RiIX7wwg76bUaL7FihThz4zEuPSbPUEzb6kBEIbEnQexzjh5
	xk+SJ30LJ1OSF4kYT4NzC75zGqdX0MQRJq4p5lqmBFdL6D7uEqcaBBWw6VWqTroJ
	+VDyakD7SoxaKeGxQ77HClGqwj1wRV29bBNZOE5ILptNHsN9s8t53k3wldCYzOrY
	ZSvJ15g17BESevfYospK/idF9hrPvh6gtjm/P2dU7lOlCAtBml2RPg31S5/KjUPC
	KUYjc3ECDlf6igPa1hLAp2tP6nAxBguxMABPh3Q39fKCZ3JOPB8wlnmU7vUnDoC+
	EF/f6Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4456wa8wp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 00:38:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50E0cPAx005938
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 00:38:25 GMT
Received: from ath12k-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 13 Jan 2025 16:38:24 -0800
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v9 5/9] wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
Date: Mon, 13 Jan 2025 16:38:09 -0800
Message-ID: <20250114003813.2783550-6-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
References: <20250114003813.2783550-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-GUID: 84LWyqgGhNOSBxMXHLaFd11frZG1fktP
X-Proofpoint-ORIG-GUID: 84LWyqgGhNOSBxMXHLaFd11frZG1fktP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140002

Currently, the TX and RX MCS rate configurations per peer are
reversed when sent to the firmware. As a result, RX MCS rates
are configured for TX, and vice versa. This commit rectifies
the configuration to match what the firmware expects.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 ++--
 drivers/net/wireless/ath/ath12k/wmi.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4dd6cdf84571..8e95b000e339 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2246,8 +2246,8 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 		he_mcs->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_HE_RATE_SET,
 							    sizeof(*he_mcs));
 
-		he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
-		he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
+		he_mcs->rx_mcs_set = cpu_to_le32(arg->peer_he_tx_mcs_set[i]);
+		he_mcs->tx_mcs_set = cpu_to_le32(arg->peer_he_rx_mcs_set[i]);
 		ptr += sizeof(*he_mcs);
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 1c2c99f765a2..eeef4613bc9f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4059,7 +4059,9 @@ struct ath12k_wmi_vht_rate_set_params {
 
 struct ath12k_wmi_he_rate_set_params {
 	__le32 tlv_header;
+	/* MCS at which the peer can receive */
 	__le32 rx_mcs_set;
+	/* MCS at which the peer can transmit */
 	__le32 tx_mcs_set;
 } __packed;
 
-- 
2.34.1



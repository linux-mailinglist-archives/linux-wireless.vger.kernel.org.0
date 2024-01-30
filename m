Return-Path: <linux-wireless+bounces-2757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF50841ACB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 05:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413441C24D3C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 04:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54561381AB;
	Tue, 30 Jan 2024 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GuOFJCQ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB004374EE
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706587416; cv=none; b=nHz7qZncrHLoF53kLyDSfBNO2pVsVIeB9vi2gSn3hZ/GAmhPFH9rK0HSKerQzFy6MQAhd28bbxTMFZDllsccCy4MrYK6YhcIyDF2kHTrobtmuUdsf3L+NWrNL57VCYSGejyFN3Bm+6wFjF9g4k+2bgY6LmOhgqk6lBM3xVyP160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706587416; c=relaxed/simple;
	bh=jyBuPHAa5MKQwIsOB+8YP+M4DlEVuuml9GY85rYy+SA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAqLRoVDdznRRFpU2f5c47BbAR+mixgCA9VydGllibhXobjcmQNJpoAyIZnWAZafBtIa0OaS7FWX+8237DfNbLPOHjWHdnaLD6tGV0vJwuE1BE7gepflGkUYBl5Wwx1+AQClJlEEJOcZSXv4AKrTSNnFSQWp/SrkQIWdvn4Q354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GuOFJCQ4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U39QAr031253;
	Tue, 30 Jan 2024 04:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=W1VUNmG6wbllzrjC4m4yVIll8yVU1HsReJ5dOnF6xGQ=; b=Gu
	OFJCQ4N90VAzGluLoW12l0HkIoGNIUqisZOeKRdtIqhSuA1FMl8+Wwi9o6IDdinm
	y6y2l6o4TwT4JkMZyIRO8tP+6o4iarS5O0Qh27U0m0fz4iN/HZoUFjxJKTUMqkPt
	EkF1tKqtD6ssqGi0Zy2EsoXZPVUYY6XgN4OycWqlexKEzxNX7+tQupG8culjA3mQ
	59yKVL+8FwdIrzuYPWt6XQcrKvEMtIJUatTtHoVAYBWYliugve4+Eiyn2da8PH2F
	6i1I+rp5V8XjUrhAu/c0u280xcWbiYDM7b5RaWbAupIt1RWH1/hvPbnks3pTg6Cs
	1zeOah1YiYt894QgXDcA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxhjrrxfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:03:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U43ReU026811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:03:27 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 20:03:26 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 01/11] wifi: ath12k: fix broken structure wmi_vdev_create_cmd
Date: Tue, 30 Jan 2024 12:02:53 +0800
Message-ID: <20240130040303.370590-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130040303.370590-1-quic_kangyang@quicinc.com>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3ji_OkL6gE0MmlMJBswXdkX4KlgbPs42
X-Proofpoint-ORIG-GUID: 3ji_OkL6gE0MmlMJBswXdkX4KlgbPs42
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=1 spamscore=0
 mlxlogscore=566 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300025

Current structure wmi_vdev_create_cmd is not matched to the firmware
definition. So update it.

And update vdev_stats_id_valid for vdev_stats_id.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v6: position adjustment.
v5: no change.
v4: no change.
v3: no change.
v2:
    1. add Tested-on tag of QCN9274.
    2. update copyright.

---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 +++
 drivers/net/wireless/ath/ath12k/wmi.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 2fa724e5851a..d8ebaf4b8359 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -826,6 +826,9 @@ int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
 	cmd->vdev_stats_id = cpu_to_le32(args->if_stats_id);
 	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
 
+	if (args->if_stats_id != ATH12K_INVAL_VDEV_STATS_ID)
+		cmd->vdev_stats_id_valid = cpu_to_le32(true);
+
 	ptr = skb->data + sizeof(*cmd);
 	len = WMI_NUM_SUPPORTED_BAND_MAX * sizeof(*txrx_streams);
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 06e5b9b4049b..4afc6ca15c91 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2716,6 +2716,9 @@ struct wmi_vdev_create_cmd {
 	struct ath12k_wmi_mac_addr_params vdev_macaddr;
 	__le32 num_cfg_txrx_streams;
 	__le32 pdev_id;
+	__le32 mbssid_flags;
+	__le32 mbssid_tx_vdev_id;
+	__le32 vdev_stats_id_valid;
 	__le32 vdev_stats_id;
 } __packed;
 
-- 
2.34.1



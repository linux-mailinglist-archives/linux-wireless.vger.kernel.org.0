Return-Path: <linux-wireless+bounces-1801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7282BD3E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 10:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1073B2884D9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D535DF1D;
	Fri, 12 Jan 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ChDxvlOT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575A5DF2A
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C5lpnb005337;
	Fri, 12 Jan 2024 09:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=lVMgMvxEOyJ4VTIYaRbQ24Qpnzw5Zg8S0Ixh0HT920g=; b=Ch
	DxvlOTaiaXTfjlcCAYljikCg2Kc4xflmPrm7Pl2AjE8RTsTQoysUZ7rKqqp68oGU
	opGSlQeIi0DHQzSqua89W+cnkzQ7+woL+3q+L8lNUZC42lK2MrWpF1DHYiB+9ogG
	WYCXYWqfk30+nshFbY4i4Db5liHjmXXl2P4z/DWyiKWnQyUKRI2hB2tuyRGPYcfS
	AkLNUszR+4YNwetAB1Oi3jf/ImPWOw1mPzl9RHSv2JT5lCdSnCDCx1q8HDG76B0n
	/slAr2i4Mungy6qorEb+NZjYwCNn/+ewa+sXdDKTrRsA4NDwtRxxrB2XVYv3teGT
	V/UIfTdLAaTozqN5Cujw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjyk88nw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 09:28:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C9SmJA026704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 09:28:48 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Jan 2024 01:28:47 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 07/10] wifi: ath12k: fix broken structure wmi_vdev_create_cmd
Date: Fri, 12 Jan 2024 17:28:21 +0800
Message-ID: <20240112092824.7664-8-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112092824.7664-1-quic_kangyang@quicinc.com>
References: <20240112092824.7664-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ewo5eHka7IpsN2Mg8m98KJqM4XIxuSy0
X-Proofpoint-GUID: ewo5eHka7IpsN2Mg8m98KJqM4XIxuSy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=634 impostorscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=1 bulkscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401120072

Current structure wmi_vdev_create_cmd is not matched to the firmware
definition. So update it.

And update vdev_stats_id_valid for vdev_stats_id.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v2: add Tested-on tag of QCN9274.

---
 drivers/net/wireless/ath/ath12k/wmi.c | 5 +++++
 drivers/net/wireless/ath/ath12k/wmi.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index e10289de84c1..b036f0e07f69 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -828,7 +828,12 @@ int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
 	cmd->vdev_subtype = cpu_to_le32(args->subtype);
 	cmd->num_cfg_txrx_streams = cpu_to_le32(WMI_NUM_SUPPORTED_BAND_MAX);
 	cmd->pdev_id = cpu_to_le32(args->pdev_id);
+	if (args->if_stats_id != ATH12K_INVAL_VDEV_STATS_ID)
+		cmd->vdev_stats_id_valid = cpu_to_le32(true);
+	else
+		cmd->vdev_stats_id_valid = cpu_to_le32(false);
 	cmd->vdev_stats_id = cpu_to_le32(args->if_stats_id);
+
 	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
 
 	ptr = skb->data + sizeof(*cmd);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 0efed12dd7ab..74b0ee9f86bf 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2712,6 +2712,9 @@ struct wmi_vdev_create_cmd {
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



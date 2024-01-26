Return-Path: <linux-wireless+bounces-2556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB7483D9AB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 12:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57EC4B26ADC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA871B275;
	Fri, 26 Jan 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nxpP+P1e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5F1A29C
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269985; cv=none; b=h4+fm450I6qNmiSQC3uaTQtoyQqEPdwggHwkGRApCheOH8fWPgKTXCOBJGQY+l7xKeDWddhF+rUm6cD4qDh6Q8xk+0hj6SGzP53XkHVWzHSpII9hRTNdSeRsyk1zkMtCITdIS3Mgq+BdAgJUoKSVeYLftoT58x5DnbVOc0lbJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269985; c=relaxed/simple;
	bh=IcoRDjGE98RDo1mkmeR/DeUcWPnKcPL9fED6F5HWAPE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a10HsLfjGvm0PALvRkVpiOfKSOtZog56bDA+6xOsOwIWXtfj0gaiuEaKFPGXG1sRvBfUCIvv2SPKvJT1DOXVWOKEpkwWbQjN07PUY9/WEB2gzE68PA+FRAWpmGv87A8DkUaRBUyql39mRCBLAT5/hL3t4f82HhGYVt7KBTGVOl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nxpP+P1e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QBgRjM010715;
	Fri, 26 Jan 2024 11:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=UXEoQzd7j0T0GOxdyRmmhL/HKPVFvHfh0fbQ71wksrE=; b=nx
	pP+P1e6lgF4srKy75feGEQVEhEXeOtD6cqKTwOQbmyXZ3pqQ9XUqxFWweEzN6owy
	wjgI6wjQZEDlIWb8yEB7rWNZBafq2WawRebTvZxnwA4hWEFDBqihQo09Gv88gEZm
	CcmgJ4fsFGQjsOA9XMGqxlWESkIQ5wFGvmIBNjyuRG84wtqMzl1NRokMjOmSksNS
	FPWPt0YhhxM3Q8v5exBdoec5CIa/ZesuvvRJMsYds1BXZ3TTI8NIP0QK52J7Usu6
	1kjt78YbIX8Ti6MvAGaS7o5xAlUuqs8HJKKmOvLHIj8GvV1h8TMDgwbnvJKd97/b
	jhfVHIZQFk1BKa55W3Yg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4f9h0k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 11:53:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QBqxDa016281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 11:52:59 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 03:52:58 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 07/11] wifi: ath12k: fix broken structure wmi_vdev_create_cmd
Date: Fri, 26 Jan 2024 19:52:27 +0800
Message-ID: <20240126115231.356658-8-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126115231.356658-1-quic_kangyang@quicinc.com>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 7NBYUWv2ZPhx3fAybYUvA4j1NfKLGaiC
X-Proofpoint-GUID: 7NBYUWv2ZPhx3fAybYUvA4j1NfKLGaiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=635 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260087

Current structure wmi_vdev_create_cmd is not matched to the firmware
definition. So update it.

And update vdev_stats_id_valid for vdev_stats_id.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v4: no change.
v3: no change.
v2: add Tested-on tag of QCN9274.

---
 drivers/net/wireless/ath/ath12k/wmi.c | 5 +++++
 drivers/net/wireless/ath/ath12k/wmi.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index c7e732c6c145..34e676799616 100644
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



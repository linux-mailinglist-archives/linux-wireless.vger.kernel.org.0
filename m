Return-Path: <linux-wireless+bounces-6036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EAE89E1F6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F40B23F84
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107B156866;
	Tue,  9 Apr 2024 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gAEEQ1vK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB313D88A
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 17:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685394; cv=none; b=Rbz2anbMBLeYNkWonTxyyVDoytDK69OFAyEXNAip5xCus2KWyNGniqXx3TgFN71IBxTMpV1o4A2pgwaJakXpfsWoMHIjCZvioPefmG/bycURN5UN12TfKmV03SU5PhUH+8pM6QLvgDy16unhe7wGxuxdUvEzpq4TSpRulPG3X8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685394; c=relaxed/simple;
	bh=s7NfE9p6JBxZeAT3EiDZU48m71HbcMAwoNnj1rJ69gY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=asw4khqFYvCDa3nik0KfQ6p2TBplpMkOIUp3/ES3rb/3AW7N8p8BI3PQdU2RcT/dTZBhc45GBXVWkfFEfY5vv8YkOcYuX1aObMLp1lcS9kkUsRHtOk6BgjA/bK1L4sE1ML/TF89NOhy5F6WpWxmHHEcFBy0Q80XRRfAf7cUyDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gAEEQ1vK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439DcJFl019256;
	Tue, 9 Apr 2024 17:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=6s9K6Qs
	Eck2nQm9qkipPNtzVHEZ8qy8/W+wJH0yI+bE=; b=gAEEQ1vK2WDoiCe7TmbLPSN
	GIJ4MFvfP3Tm7ik3zuoSO2CbofL8VjtxAAzm40RX2FqfHHF5KYH6wRc5bZhBKOEy
	fSABLGpTsMTFaTY2bY3yccNKXjfIrzK5MsVSZCYijvBQVPIUyugofz9fRp619K4G
	OAEib/tL5sZQMHoD74cWSTw8Ywci1b1alOwdBesTSiNHlvqsueRy+ePBvNjXLg/6
	uFRZ6dcuMq5YkbO8EVOMYnfj48p0oYABD+XsoiuMYzw50SLh3RyWuUws975ftKGq
	7jMCLEO7YkTB3lp5rMHpv2Gbdyy1nZcQHmLn6WNdC56snnSh3dbS+XEDaR63IRg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcv3khuw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 17:56:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439HuLYs007942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 17:56:21 GMT
Received: from hu-kathirve-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 10:56:19 -0700
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan
	<quic_tmariyap@quicinc.com>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
Subject: [PATCH] wifi: ath12k: enable service flag for survey dump stats
Date: Tue, 9 Apr 2024 23:26:04 +0530
Message-ID: <20240409175604.3299752-1-quic_kathirve@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tDZY6GAuSjWKNnckQqed8npaojvoxt6A
X-Proofpoint-GUID: tDZY6GAuSjWKNnckQqed8npaojvoxt6A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090118

From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>

The survey dump statistics does not display channel RX and TX time
properly because the survey flag is not enabled in the firmware service
flag.

If firmware supports enable the service flag "bss_chan_info" in
wmi_resource_config to fetch and print the stats for specific pdev.

Enabling WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 does not have any impact
on WCN7850 since this bit is not utilized by the WCN7850 firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 ++-
 drivers/net/wireless/ath/ath12k/wmi.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index a5575ce9eed4..16504786735a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3324,7 +3324,8 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
 	wmi_cfg->bpf_instruction_size = cpu_to_le32(tg_cfg->bpf_instruction_size);
 	wmi_cfg->max_bssid_rx_filters = cpu_to_le32(tg_cfg->max_bssid_rx_filters);
 	wmi_cfg->use_pdev_id = cpu_to_le32(tg_cfg->use_pdev_id);
-	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config);
+	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config) |
+				     WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64;
 	wmi_cfg->peer_map_unmap_version = cpu_to_le32(tg_cfg->peer_map_unmap_version);
 	wmi_cfg->sched_params = cpu_to_le32(tg_cfg->sched_params);
 	wmi_cfg->twt_ap_pdev_count = cpu_to_le32(tg_cfg->twt_ap_pdev_count);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 78afc94a815d..1283d25b5cc4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2400,6 +2400,7 @@ struct wmi_init_cmd {
 
 #define WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT 4
 #define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
+#define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64	BIT(5)
 
 struct ath12k_wmi_resource_config_params {
 	__le32 tlv_header;

base-commit: b36766befd306a606f287b0c0f0e53d994516acb
-- 
2.34.1



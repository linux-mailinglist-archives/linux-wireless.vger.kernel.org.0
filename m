Return-Path: <linux-wireless+bounces-6077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7189EE06
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F30D1C21164
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBA313C9C2;
	Wed, 10 Apr 2024 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nXumstzv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5F13D51C
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739238; cv=none; b=Awl4eKqWxVQsdyeeByMhy+jzAxLaaKuKYlgc8rX5vYhj+cILnSSyTIJUPWcohyZtnbGCRj/mGKSvW9UlBBznzxLeN/Z6lKUggU0OwEDPMCHWNFIWJNjduLc6CCMEL1q3EhJqF5pI1m6+K5Up0svJT+JC66/8flWiqWM6+Sa2iks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739238; c=relaxed/simple;
	bh=FGnVi4tOUEMISCjKIfeREi/QGMp3aiR0UbAFWvLvk3s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C2ubAOVKVPUZ1LyTEeLgOM7IEo2xG6lSO+0zerpGya4K+06vriTGteBovWfLUP7TPM/Dwd0sCCR9cBdo4g9o1ge1iIoY7sMKvJy+Um35YET85bOtgFK+QVsn3UCPuJCdajzLdiHdVH9mJU6FL46TXqNoA26W2bMH5dQUWzGXo0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nXumstzv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A7ZiIt013190;
	Wed, 10 Apr 2024 08:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=NL38PFD
	VifPe6rBqFEZuo7JHXUoUdg88+nSbbR/F9SA=; b=nXumstzvPmQ9ZFpW/rxlOXY
	5lxyIxIY2HJdV4tSodtTKjneYGq8KzroRgx00dFVzP6hlrz7L5Okqz7FTGvIiGxU
	SE0hvHO1BfdSpfnNEmGpNLA6V99i4Kper83INC9eRm7naKqapI3BwFJ2M+scgdBp
	d98S/gYS9NAEUZKDnzvDHNZ32SmOJU0SZCORF0YP87i0ZMICUELGR/TThZ9bC5V8
	fAQb68QRZzK52Yq8bM6uBLVowzdcc969K8pu9S3t6xhJYzPhhtmrbO11+FThJMyq
	1PjxLu2z2DQtJcwpBP6+pn5G26joOZxW+20DAM9EwVdx+FjjD18E8iYkqeAPMJw=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdkv8hnq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 08:53:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43A8rmoY014549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 08:53:48 GMT
Received: from hu-kathirve-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Apr 2024 01:53:46 -0700
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan
	<quic_tmariyap@quicinc.com>,
        Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: enable service flag for survey dump stats
Date: Wed, 10 Apr 2024 14:23:29 +0530
Message-ID: <20240410085329.3649572-1-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: Hqpgfvd54zl1dfPuRbsUd1_Gq_mXjqM1
X-Proofpoint-GUID: Hqpgfvd54zl1dfPuRbsUd1_Gq_mXjqM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100063

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
v2:
	Addressed Jeff's review comment
---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 ++-
 drivers/net/wireless/ath/ath12k/wmi.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index a5575ce9eed4..276b28f669ab 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3324,7 +3324,8 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
 	wmi_cfg->bpf_instruction_size = cpu_to_le32(tg_cfg->bpf_instruction_size);
 	wmi_cfg->max_bssid_rx_filters = cpu_to_le32(tg_cfg->max_bssid_rx_filters);
 	wmi_cfg->use_pdev_id = cpu_to_le32(tg_cfg->use_pdev_id);
-	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config);
+	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config |
+				     WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64);
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



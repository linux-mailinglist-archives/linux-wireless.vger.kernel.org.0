Return-Path: <linux-wireless+bounces-18614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C6A2BAF8
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 07:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E2B7A3940
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 05:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3BB13CFA6;
	Fri,  7 Feb 2025 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nNEIH2xC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27404D26D
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908031; cv=none; b=OLRDT3blcXmvhNEWOrqpmFdSY6VZbFE//fjk5kZQ5jGy/b6kGIDjrz3YKJIgq+GZvR2IBOSSvGqGhpeqp6mG801+8KgAld51drtEeB4DygfhiFdV+5gk3NqRrYoWBzVwbUXuXZRJ5PbFnEwhmxRDRppPTYGUog5foe5uOYYG0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908031; c=relaxed/simple;
	bh=JTmzaDobH2PG0Rv/d/hpMzgDDhJmuUi5R4Lb3TmfS/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cUV21aKNAlj1VkJaZH8K5zHxyaqfY5qHYc9iETKm1gakgzKcGMa8zMjmWp+sG5s5QU48ZXq4lpw3b8wjP3xbXmR53bQHsIbMabkcgxcflndSMlPEUzgVueSvwx3NV62RzVRXWR1NFCghz9UqzEbaREM4cbhq2OXTK+Oq7sh027I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nNEIH2xC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5172JFCE004711;
	Fri, 7 Feb 2025 06:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=biYhsnGalxYWzJup55bhKA
	kHdtnGmpjuhASD3ofX7pY=; b=nNEIH2xCsgpBmS99ze5xj5alOpOQpol8lZqH6O
	S+4DyYjyZe40wP4dM0zlxaKrcCxqB4bIskRRyMQ/f4T2yJBebSd36JspeM4DwTAg
	bJ8MBcIl01+3q/UNfVYuoYqs+qtjSHsqx6MRL/tnJ4C49NWF4XECPt8oWjTg0cjh
	i3EMDxBWVQMu1blTgiBOhQN9vtgo3V3dmZWcH3WCHlq7Ra8+hfrzQ5D4BERi1n56
	k4B+AMgfwECAGm31fVpzZwLPVkcklPqfZZSbZ6cAZSrC/zU4XMvOVqtHEruA3Bby
	Pnm23qG0LumhAIAZ0VVSswbUsWS1DqxoneptpO6khxz+WfdA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44n99e8egk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 06:00:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51760Okd004415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 06:00:24 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 6 Feb 2025 22:00:20 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Ramasamy Kaliappan
	<quic_rkaliapp@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH] wifi: ath12k: Improve BSS discovery with hidden SSID in 6 GHz band
Date: Fri, 7 Feb 2025 11:30:05 +0530
Message-ID: <20250207060005.153835-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0c7LYwPg4o_GYn_crw1NWl1M6Y3ffipQ
X-Proofpoint-GUID: 0c7LYwPg4o_GYn_crw1NWl1M6Y3ffipQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_03,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxlogscore=807 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070046

From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>

Currently, sometimes, the station is unable to identify the configured
AP SSID in its scan results when the AP is not broadcasting its name
publicly and has a hidden SSID.

Currently, channel dwell time for an ath12k station is 30 ms. Sometimes,
station can send broadcast probe request to AP close to the end of dwell
time. In some of these cases, before AP sends a response to the received
probe request, the dwell time on the station side would come to an end.
So, the station will move to scan next channel and will not be able to
acknowledge the unicast probe response.

Resolve this issue by increasing station's channel dwell time to 70 ms,
so that the it remains on the same channel for a longer period. This
would increase the station's chance of receiving probe response from the
AP. The station will then send a response acknowledgment back to the AP,
thus leading to successful scan and BSS discovery.

With an increased dwell time, scan would take longer than it takes now.
But, this fix is an improvement for hidden SSID scan issue.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index f934d49acee6..0faf1674f9a2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2433,8 +2433,8 @@ void ath12k_wmi_start_scan_init(struct ath12k *ar,
 	arg->dwell_time_active = 50;
 	arg->dwell_time_active_2g = 0;
 	arg->dwell_time_passive = 150;
-	arg->dwell_time_active_6g = 40;
-	arg->dwell_time_passive_6g = 30;
+	arg->dwell_time_active_6g = 70;
+	arg->dwell_time_passive_6g = 70;
 	arg->min_rest_time = 50;
 	arg->max_rest_time = 500;
 	arg->repeat_probe_time = 0;

base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9
-- 
2.25.1



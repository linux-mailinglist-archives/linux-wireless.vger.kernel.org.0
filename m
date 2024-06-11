Return-Path: <linux-wireless+bounces-8786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC02690369A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2191C20B90
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2E4175573;
	Tue, 11 Jun 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oFdIkNfE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D053172BD8
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094899; cv=none; b=sd6h/6WHZVe/ExrhSErLmy5FtPXcJcXe5vc0tNBCnSbHN1AJNjUdH4dxdQyYLb88qbEavbaVIu7bHhBD81unL27/v+by6KG8y4okop8lfwKsupXmABDw4VFvkRPlgZr+7ctmxpL6hzV0jPDmkUs8QUUCKcignqCvoHR/UPWYSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094899; c=relaxed/simple;
	bh=AHDOOKeSNpFJZPUk4b2bHHr1h88i2SrE55n5JZu14Gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyyuJqynUkzsWC5YfBZJJhCJjFoBHsi8uBjY1bCLEAC6+vvIhi8/kmKEn/GA/uSiYR5GA9Hfk96+FCeUIjzEhLVnaHlEuIt9/3xKsPzhd18dZmD64qKpN/zCLR4Q5hoSlnrbAX5NHdYS/3Qmm5/QKC6BagCb4nH3PZmO2fbR4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oFdIkNfE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B4aGF1002353;
	Tue, 11 Jun 2024 08:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5D4JUtYiHbyXhZMZ/G05+h3lIKqxR/mqbSqqmgSTN8E=; b=oFdIkNfEqlzoZ9h7
	BqvOLkLz/nVyDNRXFHfDy3qc9wvyh1SkdDtaXu2XhuqAP0N7qQKvaWQl/jBMUVOo
	aknvJ9Qh4MhuIiq89/7sT5WlPg7zZhRho2QY9aNRkizDLwpd6GAuAi+Vl+HN5E25
	Il4GFZVjwt1cCxCQhvY6oqoAsQiri9dDWAjgkegxYjpGn8vaeMvK3ofmhv5B2Pue
	8lPZRgFM1uBmqpBSN+ofGa/sd246yAcYVA2BPISEo9gOGUBpH8sZDcEqggFpJu/+
	4VzYKzM9WMfmkkmEQYv3Z/ZKTLkPpMya2h8ZGsIANgcGs+5hBR1/jpUWGSfDrbTT
	7OpXAQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymevxdutn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 08:34:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B8YqPA011565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 08:34:52 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Jun 2024 01:34:50 -0700
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH v3 4/4] wifi: ath12k: Fill pdev id for fw test cmd
Date: Tue, 11 Jun 2024 14:04:27 +0530
Message-ID: <20240611083427.881443-5-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611083427.881443-1-quic_aarasahu@quicinc.com>
References: <20240611083427.881443-1-quic_aarasahu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UkMxBfdUb6yqxEzntmA9eRKXInL8m9zk
X-Proofpoint-GUID: UkMxBfdUb6yqxEzntmA9eRKXInL8m9zk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_04,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110062

From: Rajat Soni <quic_rajson@quicinc.com>

Currently pdev id is not set properly that can cause crash
if pdev id is not equal to the pdev id when firmware test
command is run during AP bring up or ping.

Set pdev id in function ath12k_tm_cmd_wmi to resolve this
issue.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Co-developed-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/testmode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/testmode.c b/drivers/net/wireless/ath/ath12k/testmode.c
index 4289e8f8d974..dc391b986301 100644
--- a/drivers/net/wireless/ath/ath12k/testmode.c
+++ b/drivers/net/wireless/ath/ath12k/testmode.c
@@ -320,9 +320,10 @@ static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
 {
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct sk_buff *skb;
-	u32 cmd_id, buf_len;
-	int ret;
+	struct wmi_pdev_set_param_cmd *cmd;
+	int ret, tag;
 	void *buf;
+	u32 cmd_id, buf_len;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -347,6 +348,12 @@ static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
 
 	cmd_id = nla_get_u32(tb[ATH_TM_ATTR_WMI_CMDID]);
 
+	cmd = buf;
+	tag = le32_get_bits(cmd->tlv_header, WMI_TLV_TAG);
+
+	if (tag == WMI_TAG_PDEV_SET_PARAM_CMD)
+		cmd->pdev_id = cpu_to_le32(ar->pdev->pdev_id);
+
 	ath12k_dbg(ar->ab, ATH12K_DBG_TESTMODE,
 		   "testmode cmd wmi cmd_id %d  buf length %d\n",
 		   cmd_id, buf_len);
-- 
2.34.1



Return-Path: <linux-wireless+bounces-17313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62953A08EFF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 12:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833F33A465D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 11:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C726918787A;
	Fri, 10 Jan 2025 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n1qhEJXC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DC820B21C
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507954; cv=none; b=PkbqO31Ds/DHjJ1kubCFnxu0GCBqKAF+ts76u+JPx0OPmhryx/H6lGpdzQ/25w2Vx4wbmNPIwlHL3BDYWUeFi+8tTOyvi+W+epbaJLjvFVTNmc0HCBW+gvxgudbksX9i+S+Tl29r6sMHiiJOawcvLSKekuKf7eav7Xb13Cb8XAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507954; c=relaxed/simple;
	bh=YUv72+4xpSe5wMO7sKUWJI73MNUodrm+vjUL5RCfjH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOcpZ0b10DTOXZnEZHXp7APesrTKtRTItxWJZAipe8au/fBHGSmnRt2xjeBQy4MYJ5BnULVSEyOMFxvha87YEZPJuwSoMs4o3aOd+wg1myW8pf/zMYr+n4h0+s1vYOtZ6bJqGHZqvbwKDFNyvqKnB2AjHp6Ihw9HmybkepigmvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n1qhEJXC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A67VCh009608;
	Fri, 10 Jan 2025 11:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eIL7ueByHD0px9a2UImpi/RFfI6tawt4b1lWCTaL0KM=; b=n1qhEJXC4Qxntxi9
	lK9PU/0H+aPfJJw7L3wMFwxrKjfU4381QNg2GKn5ZkBs3TRqwGJRxh7g93TcEJtD
	bwbRhmyFCgnRTELwXw9PhiN8XSQHLFJv0xCf8xRZsQMjPAb7o4b1wlc4eCQfEiIx
	74yz5Nz3E3i2UMB6bbEM8rg/y9MxixtMm1inejhoYaPDAEz46vJ04vhk/Yu5FIpV
	tCYNW2MDP0ritn4lj8qhIILP7zw2YmvvLgLx00OkaJr9RFStHPh8+4UgicLk7hPi
	0iLUUPbhWmsZ0MESegI7XGM5ynj3pmMbWqdP/nqyBj9yVv2ZMKLQiqWcVMe9wLnh
	+v3LdQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442x0r8t1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:19:11 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50ABJAs4019644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:19:10 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 10 Jan 2025 03:19:08 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>,
        Rajat Soni <quic_rajson@quicinc.com>
Subject: [PATCH v8 4/5] wifi: ath12k: Fill pdev id for fw test cmd
Date: Fri, 10 Jan 2025 16:48:44 +0530
Message-ID: <20250110111845.2920741-5-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110111845.2920741-1-quic_aarasahu@quicinc.com>
References: <20250110111845.2920741-1-quic_aarasahu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rFxKIyErEZrujBP3W9zrgXoFBFDgLqsI
X-Proofpoint-ORIG-GUID: rFxKIyErEZrujBP3W9zrgXoFBFDgLqsI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100088

Currently pdev id is not set properly. That can cause a crash
if pdev id is not equal to the pdev id when firmware test
command is run during AP bring up or ping.

Set pdev id in function ath12k_tm_cmd_wmi to resolve this
issue.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Co-developed-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/testmode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/testmode.c b/drivers/net/wireless/ath/ath12k/testmode.c
index ac9ffa765ef6..18d56a976dc7 100644
--- a/drivers/net/wireless/ath/ath12k/testmode.c
+++ b/drivers/net/wireless/ath/ath12k/testmode.c
@@ -301,9 +301,10 @@ static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
 {
 	struct ath12k_wmi_pdev *wmi = ar->wmi;
 	struct sk_buff *skb;
-	u32 cmd_id, buf_len;
-	int ret = 0;
+	struct wmi_pdev_set_param_cmd *cmd;
+	int ret = 0, tag;
 	void *buf;
+	u32 cmd_id, buf_len;
 
 	if (!tb[ATH_TM_ATTR_DATA])
 		return -EINVAL;
@@ -321,6 +322,12 @@ static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
 
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



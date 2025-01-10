Return-Path: <linux-wireless+bounces-17292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07918A08819
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 07:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B66B18818E9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 06:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4492080DD;
	Fri, 10 Jan 2025 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dhj+sm2d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7A207E19
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489576; cv=none; b=X6X7mLcyBrvg9xp3kvhkFEEJIYG3/zBRwadbcR2EkRr90LPn9h8GxFtkrR39VnjMXP5rhQichfn6yaLY1g4SmgUt5SCQcOIlCm6EEhAuCLIL1T5Bxy85iSLJF230mDmmsGSGh7eQ0COcP3qx8ck7y8KfnkLaU5gvEXaTht4qFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489576; c=relaxed/simple;
	bh=+ueeha6gypkzlYZfxr7+k0JYVxMSwwtySX33KbCc/lI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzHtuo8+9/8+4wXG5dkqlpJSVUwgBdZj4jzZPQKHWUEuMqLd6k2lKWwBXbRWi/rkgeHUCcjuRqyS/mhsIlTRAyKjzyJ0ZGKwM6NgSAdFA2aK0ZoDYAgBC7EV+VK8mcGdtfkHTZDgagYM5moj2F6Mqfn7L7D0JC79f63IIPU8jvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dhj+sm2d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A0XRlB028277;
	Fri, 10 Jan 2025 06:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/zdUt1YYkYhRwvBYEMWKLXRDxBOBzya3759Vb0mJtRI=; b=dhj+sm2dnahD2cX8
	QLwlBQb6fyR4MqGorLszEy9XjXtLQApi6NN1OBsmOU/b6LKw+1VqENSJ7w/QTOSf
	2NgzzmSA8dP8vBsDTGOWWhHkOZJA3e3F+G8jTKOqGVy8e+MZ96jyFEqNvp9KwzIM
	Q2kARbX8kN6yfe9evSNTgV6NtxAPHwDETSyoNVOn1Wf6D19oix9A5kwjnEjQfKSK
	SlnRXVB32zIDL1j6YXhKbOAfx2t1RbmMvV8soVVC1bE1+dmuXbjkguFVHkvxZbS2
	kt+im2h/kyjXK98Slq6WUhJAy8aV6SfX+HQoXpxAsmkZN+L9sVmhGD5c68GVQtXS
	E60hHg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442s450mu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:12:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A6Co5F010617
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:12:50 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 22:12:49 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>,
        Rajat Soni <quic_rajson@quicinc.com>
Subject: [PATCH v7 4/5] wifi: ath12k: Fill pdev id for fw test cmd
Date: Fri, 10 Jan 2025 11:42:23 +0530
Message-ID: <20250110061224.1839547-5-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110061224.1839547-1-quic_aarasahu@quicinc.com>
References: <20250110061224.1839547-1-quic_aarasahu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: eYw06IduipC8Boi0XAC7Nl5WgEiXWBlH
X-Proofpoint-GUID: eYw06IduipC8Boi0XAC7Nl5WgEiXWBlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100049

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
index 71fc4fb4274f..70e817d3d28e 100644
--- a/drivers/net/wireless/ath/ath12k/testmode.c
+++ b/drivers/net/wireless/ath/ath12k/testmode.c
@@ -300,9 +300,10 @@ static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
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
@@ -320,6 +321,12 @@ static int ath12k_tm_cmd_wmi(struct ath12k *ar, struct nlattr *tb[])
 
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



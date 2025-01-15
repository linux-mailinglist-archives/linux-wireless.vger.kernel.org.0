Return-Path: <linux-wireless+bounces-17527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CFBA1187A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 05:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 982327A2124
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 04:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4114B22DFBA;
	Wed, 15 Jan 2025 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lnuS8Vtq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD764157485
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915162; cv=none; b=cbex83BsdFIyf3Cxe9L9i1VWkPN/3MF/qWv3Lm1Dj+jfHcA4Zy3J87U+TqEDPnGdNrcF89HFAfc87GT8OfwlNXHd6rwMXjcYH1ESfT2Vr4B6MujQ6Guc2XRcIFbZqvhc0GmNfBo0oyfGbnoqyWP6CotmomtS8Wh3/C3IgDrh10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915162; c=relaxed/simple;
	bh=YUv72+4xpSe5wMO7sKUWJI73MNUodrm+vjUL5RCfjH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sI1AAOJnfWa46fGc9TKNPivaZGpwz3Mc75URmmVcpwioiaDwy98G/FOmwUN/RZEpO20HLgMlNOqqZ6h3omrmNNApd2yeBzH+5adAdE1zYMinsn6ZKNamWFnPKTJiTQ8CBkbi3z5Z+xe24bKOJ3c2iQSu4phRm/faofMEtCYtKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lnuS8Vtq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ELe8kD017681;
	Wed, 15 Jan 2025 04:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eIL7ueByHD0px9a2UImpi/RFfI6tawt4b1lWCTaL0KM=; b=lnuS8Vtqaq29dSXq
	okSBTh51D1H/MNEIael11vb4/k1tO7Evf3xZPtmu2SWQ5RPj9LUzAk3brgG8r5Gy
	8KA93CVnhsRbGXgOxrAIJDsQWuC7zZ4XL6DoOwTHT3ZgHm7sVgl6KgrxzIBxvULC
	Qth4hhqORPGwZ2Ok7QRjUOjQLctbhojmnAVmjbkgZuDljyAAryeq84IsIY55l6Dw
	QLbC59Tzfn3lRhVAMZtArv0vg50zoDzRRPOvz78N+XsCkXqsF2Hq2NnIqDjnXXTS
	dkwddu2L8609SbmKmnxljoq0bOYYTRVFs4MeIC68X9Wh0vQN7Cor9+2C5Xuyf8XJ
	AK9wbQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44600p0rmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 04:25:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F4PvJk020051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 04:25:57 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 20:25:55 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>,
        Rajat Soni <quic_rajson@quicinc.com>
Subject: [PATCH v9 4/5] wifi: ath12k: Fill pdev id for fw test cmd
Date: Wed, 15 Jan 2025 09:55:31 +0530
Message-ID: <20250115042532.1509956-5-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115042532.1509956-1-quic_aarasahu@quicinc.com>
References: <20250115042532.1509956-1-quic_aarasahu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: viGNam3GUnuzfgO4RJ6DDvoyh3GAKFaD
X-Proofpoint-GUID: viGNam3GUnuzfgO4RJ6DDvoyh3GAKFaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_01,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150028

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



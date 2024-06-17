Return-Path: <linux-wireless+bounces-9046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4190A354
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 07:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6914B1C21039
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 05:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50A8180A71;
	Mon, 17 Jun 2024 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CMg0YYq1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5D181315
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 05:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602173; cv=none; b=DzupZhTvjIpmcX0qMC1rYsRxTAjciX3vU6zTZKcF/3BeKAgYESEkrWQHZz3IS9yECyxQt6Ukbt7ClWxlzwtBYfufYVGrbE0HTOhXY3/U8prD4s2DvsUxoWmoP6IIJyqBCHHOuZ9qQKtL9ojG8F7s8/xQDwZnsXrEkf3YQv9DQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602173; c=relaxed/simple;
	bh=T7hzm2yUdI7HuyxMDoK7ECVjuoIy9LUD+1hHfpfnhL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBvxOYAKF2D9huKUWi3wL3MARGbqIRIGkDDGgEvNEN6qaYvPj5yw/RaxNNDFnkejO9AgyeVcPzG87VhKbxvaAHZCGfLbdRkdL4561Y6wfgVN/m2sF8nEcUGI3S0dLDUFk0j1YGLRz6GZlq/q1koF1j7cATvPqpS3XiqrQZjF3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CMg0YYq1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H0jV91028361;
	Mon, 17 Jun 2024 05:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TftXsexHwlNr/eiKluY8/jhtXMQ5P9CbjSkXdwk9PJ4=; b=CMg0YYq1j1hdg1rj
	Lc2Wjk7hjijDE1RCfRsbAvpaGfvC1pBMFsrg5iGf10w7CZq+1X+qjQ1CtVPU6yNX
	lOJ5zAeBfaVMl4Qk+Z1mYOoh7VLUkQpye+8ewGp4jrFVESxfrXHASBrv/a+PIk6W
	3U3TIAH7bCKbhH1RrTydFalPw3MMt2NUSgoi4GuIT9og6p9UayexMdFjTXjj+Mc8
	hTMtHr5t6oCy6pNYiQGKDvV6AlM/zJq+RY3c1uzgVgwNgNLgvMzVjGErObg/Vio8
	Cd/TPZYzkfcXb+9ihE6UMNjP26Y/sAMiwYctJV5oqZjqhzFrC6oZHmGM5Zt8xMb1
	TVQLag==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys44jtmfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 05:29:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45H5TTJ2003621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 05:29:29 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 16 Jun 2024 22:29:27 -0700
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
Subject: [PATCH v4 4/4] wifi: ath12k: Fill pdev id for fw test cmd
Date: Mon, 17 Jun 2024 10:59:03 +0530
Message-ID: <20240617052903.2720292-5-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617052903.2720292-1-quic_aarasahu@quicinc.com>
References: <20240617052903.2720292-1-quic_aarasahu@quicinc.com>
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
X-Proofpoint-GUID: 9pj719xop0oW2m-lgIIiRijoDgaIt-lc
X-Proofpoint-ORIG-GUID: 9pj719xop0oW2m-lgIIiRijoDgaIt-lc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_04,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406170039

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
index aa9904de296f..f81564a4e6de 100644
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



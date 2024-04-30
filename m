Return-Path: <linux-wireless+bounces-7064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E58B7E0E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 19:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637151F24D1C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88441A0AE0;
	Tue, 30 Apr 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m4y5nBL0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98A19DF71
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496322; cv=none; b=gbFwefvpOukEEHzwP4AVe01CtJZVxotcDWZIQQ7NRrYBpkFsdNp502mVPVbvOt8Y7hV9JZHf6qlZ5ZtAT7hA8sWdNGp95DR8+GItrC9kSeMVqE3BPg7nsb8FIsKQ4YSCmjDRfE6kxYYfBm6uKc4Pkh3/M9XH2D72xUhVH0rU+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496322; c=relaxed/simple;
	bh=QyjD5oiEjQP4oDdUnDSrmhWRRuAfPySogKIhFlDIruU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZDjiT6yLucA6bTbE63Vv3dYP46iMLNVexMc0Nk6mt9rUqQNsGXr9wHv4I+CFFvbUABpibx8tyYTqt2jDePENwomFuJOgMNJua98Ngfm9J3rpelk9KyXtkU9UEH97Rrax2XoQbLU9aEgxJN2kTX9zKamfmRoL+So2yKhfouozvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m4y5nBL0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UDhqxr007544;
	Tue, 30 Apr 2024 16:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=BR2S1D+7zab4VhFFndHQwPkoeFx0rCa61KfvTBUrGVo=; b=m4
	y5nBL0a6afHwoxxLHZ9mCPYVupOBKkJMjF1ZxT9RgKKEFDeY9r5Z21929htDCBjl
	LTIQg+1ez2mVvI/DgQYWof4KASSloilqO+m2qKH4waIweQLlYnt9SgjCvwW1f21g
	dmmcQ5iYxnjhk82SAceVK66a5KpHmVKu+LP5TH6E81L4ojMn5L8XxXIy97BTspz1
	fSC8BTJAgtfNG3p71o5rdvwdAVTdOd6cB9rEe5GYkftzDqj1mQKy81GeBAkfGY7D
	QNmTZ/wlqkfoLULRdCfg7al7Phr0z7LOfHik+4VyaN9KcIj4WmvaDLCywyvve3ZK
	ds3KCy4AMoBZgVYp2QPg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtm3uk0yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:58:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UGwaUj024737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 16:58:36 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Apr 2024 09:58:34 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 4/4] wifi: ath12k: add multi device support for WBM idle ring buffer setup
Date: Tue, 30 Apr 2024 22:28:11 +0530
Message-ID: <20240430165811.1377182-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
References: <20240430165811.1377182-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: a47X6v1pBIoYfg7ECHu3Of7ZKIXZNYsD
X-Proofpoint-GUID: a47X6v1pBIoYfg7ECHu3Of7ZKIXZNYsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_10,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=869 adultscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300121

Currently, inter device MLO is not supported. Therefore, the WBM idle ring
buffers choose the implicit return buffer manager (DEV0_IDLE_DESC_LIST).
However, this implicit return buffer manager design not meeting the
requirements to support inter device MLO. In inter device MLO, multiple
devices participate. The device specific WBM idle ring buffers transmit
to multiple device REO rings. To distinguish between device specific WBM
idle buffers, the setup configuration need to choose a different return
buffer manager based on the unique identifier (device index).

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index f41b3f9dac3d..72ea9baaf8d7 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1589,6 +1589,24 @@ static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
 	return 0;
 }
 
+static enum hal_rx_buf_return_buf_manager
+ath12k_dp_get_idle_link_rbm(struct ath12k_base *ab)
+{
+	switch (ab->device_id) {
+	case 0:
+		return HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST;
+	case 1:
+		return HAL_RX_BUF_RBM_WBM_DEV1_IDLE_DESC_LIST;
+	case 2:
+		return HAL_RX_BUF_RBM_WBM_DEV2_IDLE_DESC_LIST;
+	default:
+		ath12k_warn(ab, "invalid %d device id, so choose default rbm\n",
+			    ab->device_id);
+		WARN_ON(1);
+		return HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST;
+	}
+}
+
 int ath12k_dp_alloc(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
@@ -1605,7 +1623,7 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 	spin_lock_init(&dp->reo_cmd_lock);
 
 	dp->reo_cmd_cache_flush_count = 0;
-	dp->idle_link_rbm = HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST;
+	dp->idle_link_rbm = ath12k_dp_get_idle_link_rbm(ab);
 
 	ret = ath12k_wbm_idle_ring_setup(ab, &n_link_desc);
 	if (ret) {
-- 
2.34.1



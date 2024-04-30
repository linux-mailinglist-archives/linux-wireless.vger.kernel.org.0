Return-Path: <linux-wireless+bounces-7024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5C38B6A06
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 07:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F6E1C21006
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D9E175BD;
	Tue, 30 Apr 2024 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TFHvqNzE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2338175A7
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456107; cv=none; b=TQMgAGYEZt8pWJZttY6FO0H75mM904KPX2tI7ZaOspT9RYtuKsRPo5q0xUhLUgduTPud9wyuz/aRcL6dsn67hTvrrKsFX6wImBoULMb61FRTGPJ6Zx6kRP51PeZ0KnL+ScGRCFNmdFT58Yy4jUVcf/EUhglL0I9u/MNTqUe7UT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456107; c=relaxed/simple;
	bh=tj8ZHXdmVjjkmzfTTEgXjndv6kXaRku5inSgU4XQAUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPNeXyGln43oW+aec8OcZ1eiezlY1y+ckpwUtlluogUpB6Pdr4KfZXB8kWO9iZRJeaU0mtzeOSlUjJlyCgHK5DtcK0JvTJPdxfivJDUpa9Z0/ayObDQYN/VkahCSIXt8NCHGIhVrZz5Lcf1xawQcOa+SECl01w1YqIz52doFWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TFHvqNzE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U4T7tu032242;
	Tue, 30 Apr 2024 05:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=2/3ZE7OKDAMMRzmdSaJRPraIPqXd9bNiUxmfhwEheS8=; b=TF
	HvqNzEyODf7/nOrLBNL7gSu9hss/dXx7ncV2WfskDZllbQCyPB+KCUQJgJPNc2jr
	A+f4myrBJ724W/Tmq7o9DpzBomiiLWr5uLiGd79F+44AI/HcyyWSte7mPvD02M+7
	iI11o5LyAMAgOtMJ6vvzURotnG4CLZmAU/bYqLSvC7tQVn0/YaydJ9OQfm38r3VO
	vcjQJugwWYrONYgXEAMilsScqzJ8FQt0jbIhnl8T6j1T5RmXqeTPxi2L0Z0rAbJs
	e/+Vslcj/H0lCy6qRSUO0e5GcMzsADs6uyXXhB40Sf77ifkEwbEMS1yBGMNlKNv8
	XypvHBZmpeLvCzwB1RNQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtsnm86qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 05:48:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U5mM1d013474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 05:48:22 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 22:48:20 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 4/4] wifi: ath12k: add multi device support for WBM idle ring buffer setup
Date: Tue, 30 Apr 2024 11:17:59 +0530
Message-ID: <20240430054759.722620-5-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430054759.722620-1-quic_periyasa@quicinc.com>
References: <20240430054759.722620-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 18cwh1pTeIiJbfYCi865oOBF-b8xMb6K
X-Proofpoint-ORIG-GUID: 18cwh1pTeIiJbfYCi865oOBF-b8xMb6K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=869 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300040

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
index 9b9e86cdb380..5812df436d53 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1582,6 +1582,24 @@ static int ath12k_dp_reoq_lut_setup(struct ath12k_base *ab)
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
@@ -1598,7 +1616,7 @@ int ath12k_dp_alloc(struct ath12k_base *ab)
 	spin_lock_init(&dp->reo_cmd_lock);
 
 	dp->reo_cmd_cache_flush_count = 0;
-	dp->idle_link_rbm = HAL_RX_BUF_RBM_WBM_DEV0_IDLE_DESC_LIST;
+	dp->idle_link_rbm = ath12k_dp_get_idle_link_rbm(ab);
 
 	ret = ath12k_wbm_idle_ring_setup(ab, &n_link_desc);
 	if (ret) {
-- 
2.34.1



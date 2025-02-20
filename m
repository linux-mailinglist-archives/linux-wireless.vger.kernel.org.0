Return-Path: <linux-wireless+bounces-19176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D556A3D319
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B317177AD8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 08:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78C21EA7D3;
	Thu, 20 Feb 2025 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m0KfsroN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFFF1EB19A
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039908; cv=none; b=Bvh33HFgb5cwGQYcuvigJTyVW9PlUmTnuRhOvppFc7FaoSAMjAFsquen9K05dYMtIEho1D4ToQFkdUFiMjkrSBy9r9nRTntkxo7Qw+XecF/QffK4eQiQMsQIkPSy16OdFsq5entGqJPFmq+aUTUwpkT0Tm6OAhNXLQOjbc4nuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039908; c=relaxed/simple;
	bh=X5k6NqBbIGoFjpMXvRs9Hh1LpXEnwSRhoE/nB0baqxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXfjWDXlwGNOC2SvNqlmQz8tlVoGUb9xJzGAzRXeWAJorPWK+FT6l6OacsMjIJcOtg33IE5lTvLc/r0naHVc6dUamWCQ1DWQCa5w1w9y25UTno4d8KD3N8QmB4VI7d2TzpexkQN0HqfoNqehxTrGldoOr3YJrGa/D6Ppg8wMjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m0KfsroN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7dNT8020007;
	Thu, 20 Feb 2025 08:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UuiSDsR+Hlhp/bUWNjGNmpuxJ0XEtFIFIT2dZ/dTXdk=; b=m0KfsroNT01MszFM
	vCxmN56JA5dotJf3Qgv/hQCykrJLWzHimTUAbLlenfuXYHffYJwX3N9EVeSA7u7E
	tn4Pgocsl78MpOcbtJO7FlE2jG+fMAeUtmZk89UqnVRqTSzzsVjgc5nsiI6UvLwm
	NYWoF4OXm1kA8ieqLtj1KNCqMPlXWgx68zP1z9nYlhagmyBhiWrG/4l/kRbHCC+w
	19uT35d4QSBEiH3xvx4yiYyKlawun021IrmNWRxQBuGNULYgU1GifX6yVdWQSTHo
	l6AGRRA5kISdrzjDRJkbNUgUTMlDAVMy7u7Phssnknvxm2NtB4B1TJhj1ew80Aj4
	u5u0og==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x06t04dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K8P47O014559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:25:04 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Feb
 2025 00:25:02 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 3/7] wifi: ath11k: don't wait when there is no vdev started
Date: Thu, 20 Feb 2025 16:24:44 +0800
Message-ID: <20250220082448.31039-4-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220082448.31039-1-quic_bqiang@quicinc.com>
References: <20250220082448.31039-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: T-_73ZqJTSzjkN1TiCgLALaH-iXZ9Lv-
X-Proofpoint-GUID: T-_73ZqJTSzjkN1TiCgLALaH-iXZ9Lv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=805 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200060

For WMI_REQUEST_VDEV_STAT request, firmware might split response into
multiple events dut to buffer limit, hence currently in
ath11k_debugfs_fw_stats_process() we wait until all events received.
In case there is no vdev started, this results in that below condition
would never get satisfied

	((++ar->fw_stats.num_vdev_recvd) == total_vdevs_started)

finally the requestor would be blocked until wait time out.

The same applies to WMI_REQUEST_BCN_STAT request as well due to:

	((++ar->fw_stats.num_bcn_recvd) == ar->num_started_vdevs)

Change to check the number of started vdev first: if it is zero, finish
wait directly; if not, follow the old way.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 27c93c0b4c22..ccf0e62c7d7a 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -107,7 +107,7 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_pdev *pdev;
-	bool is_end;
+	bool is_end = true;
 	size_t total_vdevs_started = 0;
 	int i;
 
@@ -132,7 +132,9 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 				total_vdevs_started += ar->num_started_vdevs;
 		}
 
-		is_end = ((++ar->fw_stats.num_vdev_recvd) == total_vdevs_started);
+		if (total_vdevs_started)
+			is_end = ((++ar->fw_stats.num_vdev_recvd) ==
+				  total_vdevs_started);
 
 		list_splice_tail_init(&stats->vdevs,
 				      &ar->fw_stats.vdevs);
@@ -151,7 +153,9 @@ void ath11k_debugfs_fw_stats_process(struct ath11k *ar, struct ath11k_fw_stats *
 		/* Mark end until we reached the count of all started VDEVs
 		 * within the PDEV
 		 */
-		is_end = ((++ar->fw_stats.num_bcn_recvd) == ar->num_started_vdevs);
+		if (ar->num_started_vdevs)
+			is_end = ((++ar->fw_stats.num_bcn_recvd) ==
+				  ar->num_started_vdevs);
 
 		list_splice_tail_init(&stats->bcn,
 				      &ar->fw_stats.bcn);
-- 
2.25.1



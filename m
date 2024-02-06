Return-Path: <linux-wireless+bounces-3210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28D384B109
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 10:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FDCCB2400B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0234712D167;
	Tue,  6 Feb 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PN+aYy5x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4012D152
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211351; cv=none; b=APzwTFnufd/fADaXrJR0ZtiuFa74ScqKhkOhghrMfrr+0vHXKMdCmRq2ZmLY4qPSHH32n9doy9OGy1DXA0jsrunbam0XXV8DaqLOv0FLIewjV25r2DTJpZaO4tq/JKOUFrgGwXylXH5XNs1YsU8V+++dDEe6yq5VxA3hyCIgef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211351; c=relaxed/simple;
	bh=ayhqjCPrpIeQnDNSqERwqsXomlhpfpW17liDiNLt6PY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4dMF92d7Tm/Ehp6RKcL2CHhqCp5Dox+wA+TKhuT0KHI3Tlg0eNHqqNnvSy7kHE0LMCkUJL33IvIO7rnNv8gacu3TNUbwW/xcjedBA3CTQVNpiwgYmJh61eXCwQkn25IW3Z0bWyPNiCMuOx1cwvhDME+QqAs4EmR7FwWUQU1bvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PN+aYy5x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4168NiIL018044;
	Tue, 6 Feb 2024 09:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=iqzwNh6n8/rOaJXI1v/YDFdWAXqXCCPPLM46xMXriYI=; b=PN
	+aYy5xcQ8yshsoPL/PppKPRxA6ywGgIBsMYeMNd757ycMepIq1KYd5ogbVzZOcOr
	o30eTBGBP9xyFP2GatdWwYIb5/+un/Qtvlh4Po7BcZCgWfB6Uwuwuf9YtD1tVMoP
	chwnhBIs1/eIV//fJSytM2e85Hh+FgxEEQVae2mAZ5BvGfqGCfi+u4iOS1Aztzf1
	nkKHTVZt0p/deFCIRql/4tjmrHZKgeU7j9RugCOpF4qrvjAb8lbyL0/xAd6lgWYk
	2UKLAW20qKv2KAo+MZMy7Jm+tIHVQLnKmEiUa2cs3y/g6qhJ1iNyy0W/9sxl9XYD
	/1Pm4H3Uuwu/D/PcZfEA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3h7hr3t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 09:22:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4169LxGk021348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 09:21:59 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 01:21:57 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 11/12] wifi: ath12k: Modify rts threshold mac op for single wiphy
Date: Tue, 6 Feb 2024 14:49:53 +0530
Message-ID: <20240206091954.4144454-12-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206091954.4144454-1-quic_ramess@quicinc.com>
References: <20240206091954.4144454-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: Q6uVqVXkw2GJyHHAwNAq0ptMA3YMgsmO
X-Proofpoint-ORIG-GUID: Q6uVqVXkw2GJyHHAwNAq0ptMA3YMgsmO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=765 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060066

From: Sriram R <quic_srirrama@quicinc.com>

Since multiple radios are abstracted under a single wiphy,
apply the rts threshold value to all the vdevs of the radios
combined under single wiphy.

This also implies that vif specific rts threshold support
needs to be added in future from cfg80211/mac80211.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a85468cc63da..1e1de27e5d14 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7153,11 +7153,24 @@ static int ath12k_mac_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
-	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD, ret;
+	int param_id = WMI_VDEV_PARAM_RTS_THRESHOLD, ret, i;
 
 	ar = ath12k_ah_to_ar(ah, 0);
 
-	ret = ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
+	/* Currently we set the rts threshold value to all the vifs across
+	 * all radios of the single wiphy.
+	 * TODO Once support for vif specific RTS threshold in mac80211 is
+	 * available, ath12k can make use of it.
+	 */
+	for (i = 0; i < ah->num_radio; i++) {
+		ret = ath12k_set_vdev_param_to_all_vifs(ar, param_id, value);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set RTS config for all vdevs of pdev %d",
+				    ar->pdev->pdev_id);
+			break;
+		}
+		ar++;
+	}
 
 	return ret;
 }
-- 
2.25.1



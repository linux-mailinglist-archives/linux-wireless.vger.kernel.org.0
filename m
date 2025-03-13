Return-Path: <linux-wireless+bounces-20337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93598A5FB65
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 17:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFE57AF7E0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85305269CF4;
	Thu, 13 Mar 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FsABZJbI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B706269836
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882901; cv=none; b=EO7Zrgsvt6NOis5AQTq54N0A6b9PJEEjY+h8//NZ6znZUaXQeg5IieZ4LaMwsRY7v7Pd2YKcycHuP3uxce7Dk1A6CrdeqIKAf0YChiFatA4m6Ex2Z98LMapg2iMv6/izv9FENPqrafscMmm68cc5vX846od5n5atYdM9BymXA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882901; c=relaxed/simple;
	bh=JO/aLfWwxQeJO/s1kHlqV4yvw12x5j2UJqSMKgjTqZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AX2H8Ysz7WmqasOLD+5J/FI74srgwx8TwAHOQZpfxnlhWr82iuEzz8TYc2z72bKvcGP1Cv/1eOiO+Z008s7bnGDHHkIKDYaBZUZQE4sZp/iosq8pCXemLPvIZ+6cUB3c46CWrU09mH5cxKMarlo0t6oOYNNfwObUeEoKN7TMIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FsABZJbI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DA57dP016250;
	Thu, 13 Mar 2025 16:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	trhAx7gj3oFDcuv2GSzeqcX3ro9FbeBPsaw0WhNGBIA=; b=FsABZJbI/Q9vNKy7
	2uuuLcSTCClSYjudMXjp3uCNxdRtNtUiR8v/zMtbd1njedtwvMxJagZ9XR/5+H0e
	vfkb8ucPN3GFywwd+hvlG0rgTbgfXUZxS+s7DPW6tdSvnZ+Rub+PdjMv150OyLgR
	v4vCLIGrogKOiZ8yOmMr2a06ZzimUYfwvgPuol4tFUwtpGQQpH6RJJSs3StGbGQs
	+t/vkd5dET44j3ugRGjYW+xVeO+MwUnNE+0yvD1gC5g84lQCixiLFwYalayEbT0+
	/4CM+/yGPGAJDcHClrFaE6pu+3ypNtChBK7V5Kpub2pME57srx44XbkgsYBUrGCi
	zAj8TQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nxg8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 16:21:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52DGLaDr004823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 16:21:36 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Mar 2025 09:21:34 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH v9 8/9] wifi: ath12k: Refactor the monitor channel context procedure
Date: Thu, 13 Mar 2025 21:50:59 +0530
Message-ID: <20250313162100.2364049-9-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313162100.2364049-1-quic_periyasa@quicinc.com>
References: <20250313162100.2364049-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: o2rfwy4KAXL8YHGBfNCTvq_oMRiz3pl2
X-Authority-Analysis: v=2.4 cv=ZObXmW7b c=1 sm=1 tr=0 ts=67d30611 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=ix54J4PnvFNUGTDFoFUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: o2rfwy4KAXL8YHGBfNCTvq_oMRiz3pl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_07,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=749 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130127

Currently, the monitor start procedure use the iteration callback to pick
the last available channel definition in the mac80211 hardware. This
approach is incorrect for the single wiphy model, as it holds multiple
radio/link channel contexts within the same mac80211 hardware. To fix this,
change the iteration callback to pick the specific channel context for the
given radio/link. This approach makes the monitor start procedure
compatible with both multi wiphy and single wiphy models.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index acc775960adf..302db61710bf 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1336,19 +1336,9 @@ static int ath12k_mac_monitor_vdev_delete(struct ath12k *ar)
 	return ret;
 }
 
-static void
-ath12k_mac_get_any_chandef_iter(struct ieee80211_hw *hw,
-				struct ieee80211_chanctx_conf *conf,
-				void *data)
-{
-	struct cfg80211_chan_def **def = data;
-
-	*def = &conf->def;
-}
-
 static int ath12k_mac_monitor_start(struct ath12k *ar)
 {
-	struct cfg80211_chan_def *chandef = NULL;
+	struct ath12k_mac_get_any_chanctx_conf_arg arg;
 	int ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
@@ -1356,13 +1346,16 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
 	if (ar->monitor_started)
 		return 0;
 
+	arg.ar = ar;
+	arg.chanctx_conf = NULL;
 	ieee80211_iter_chan_contexts_atomic(ath12k_ar_to_hw(ar),
-					    ath12k_mac_get_any_chandef_iter,
-					    &chandef);
-	if (!chandef)
+					    ath12k_mac_get_any_chanctx_conf_iter,
+					    &arg);
+	if (!arg.chanctx_conf)
 		return 0;
 
-	ret = ath12k_mac_monitor_vdev_start(ar, ar->monitor_vdev_id, chandef);
+	ret = ath12k_mac_monitor_vdev_start(ar, ar->monitor_vdev_id,
+					    &arg.chanctx_conf->def);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to start monitor vdev: %d\n", ret);
 		ath12k_mac_monitor_vdev_delete(ar);
-- 
2.34.1



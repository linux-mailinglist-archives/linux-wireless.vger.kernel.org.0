Return-Path: <linux-wireless+bounces-20392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA54A6141E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 15:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8089017D765
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 14:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158C8201027;
	Fri, 14 Mar 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X8am5mzP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FF1FF7BB
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963879; cv=none; b=nDqZDPrQdk306cn9Qogb7FFLqE1MDbDCGADK3kHKG03HnWy69vYRORXhRlq6whS1PXTEFbCoKuobdhtAmb3voADNaimGNqiTakePqWm/shX0pGGcwbju188RhFMtLkN5JeO5DbSTULcfZFAqu6hN3aUiWw+dlNTYa4ULowmjXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963879; c=relaxed/simple;
	bh=JO/aLfWwxQeJO/s1kHlqV4yvw12x5j2UJqSMKgjTqZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4ZPpvTx21JR44WAH8WBW8PSS8tkY4W4roZMrYDFlyZ4/FGUuUcRjcGYh3IE+CiZ6qX+ueWfvGykyb09CzdGBVC7LPPzkMXr+cMOWUM53LObVuvImFAThwaFV56ptLTsXH0UvEHea1OsWjrDD8UfIo7TjMJ9WGIQpyjjseEXMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X8am5mzP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EA5D59027610;
	Fri, 14 Mar 2025 14:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	trhAx7gj3oFDcuv2GSzeqcX3ro9FbeBPsaw0WhNGBIA=; b=X8am5mzPcgfz/6wy
	NaYIJ7ihGaBgefAxVmyRrwKBVfrOKReLD6Eb2i7wUtKSkdkB73rBzBN0wOgWpsZQ
	50FrGkWweb9zWArAKaUjbGuT1lqsUG6U385Zmnhqj4ndu9+NnPNoOL1x7fD8oel0
	nEu5RFujkRlyuqFKlAGwkVEWiz4chbn55I0IQW7e88JX2zIRdGs6g9kZkzV9Q6J9
	rbjiJIyQrlYRYkelfbayKF+xNrlrmvJDhfG7sYJmi01Pv/d3RcEj+0cBInV8J87S
	4PSBVLWJ5jHAhHfrh9EXRvNbWnOCjGBaN3WeMtZ9FSGdYxwOABlY2PY3oiBwFeU4
	RmVOvQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45c6732h1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:51:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52EEpEvj005251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 14:51:14 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 14 Mar 2025 07:51:12 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH v10 8/9] wifi: ath12k: Refactor the monitor channel context procedure
Date: Fri, 14 Mar 2025 20:20:36 +0530
Message-ID: <20250314145037.3678649-9-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
References: <20250314145037.3678649-1-quic_periyasa@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=67d44262 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=ix54J4PnvFNUGTDFoFUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Bcj9-Utq-VtG5cHhv70SivyA1AMn88iB
X-Proofpoint-ORIG-GUID: Bcj9-Utq-VtG5cHhv70SivyA1AMn88iB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=749
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140117

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



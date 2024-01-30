Return-Path: <linux-wireless+bounces-2756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE06841AC9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 05:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACC01C24C53
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 04:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C0D3771F;
	Tue, 30 Jan 2024 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SZtiwORP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1D376F7
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706587415; cv=none; b=m6gJNGM1jaKbuZh+hpKvCBQbxnGozofuplkrexTQfdpWXIdd9uBU+BR52uj0HGQ5AnONZ20pxEWP4xQzXjbMYtObEIqP1kVtRBm+77wnIQgoHGLq19cablGRgW8nzo3tbRYpuZkHJR9P4aMAhHU5Sw6ln9KKjcoQr+nfo8G1wUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706587415; c=relaxed/simple;
	bh=WrkOuX0rCjkaYIFvjRWTMgAtX6Wb52wBMvKPEyIL59I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2VZcinFZcgPLPoTZc3wApF+2cgErUGSxCviERGHJqp8ICzxlIacVXM7ZgB/VuB+r5crjCJSpnYVVC+efLT6QedbIYFBfNRaFGta/Sk5+UVu0z1dvZd8erFhpISh71zQwC4i+ZUx599yHhyCKoTJeR5H6oap4jG0Z6kZaOrOqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SZtiwORP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U3Fiqr006379;
	Tue, 30 Jan 2024 04:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=mXahEYF6LWZRIvmoGt5ZgUHokkGBgoI68HUqngEQgtc=; b=SZ
	tiwORPr1j5V6jmQQmZaR2mRo+nAFI5HxGZ6sQxk5TUOWmsrciLECW/57WE07jqiB
	cYPx2/Kznd3oSMziAX3llE3vzm5MuSx6WfT38kzYU7SwfRevgLEDJcEKgoAKNJG3
	tz/6BHnlZKSNaVGLX+N2SlmeVs3iRnGJ5yBMfRMCN7QIx4WAI34TNggZBuTJzyqW
	Gsdx9KxaTGTh0fDuGE93On34vMFc7xuuvbmMTaL32gDi90KE9URKbtQD7aPahOXZ
	etcshKwyEBo1gU+SvtBap+ryK8A+x7nV5pkLI2m1VnL375dBANs7wyEVUDA2NHQ9
	P+Lm2ryHWTJXCoiOFLaQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx9ya2cak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:03:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U43TwV026864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:03:29 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 20:03:27 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 02/11] wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
Date: Tue, 30 Jan 2024 12:02:54 +0800
Message-ID: <20240130040303.370590-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130040303.370590-1-quic_kangyang@quicinc.com>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 91J7QY-qfgjys1vR_xD2ZPAdbkuqZhAX
X-Proofpoint-ORIG-GUID: 91J7QY-qfgjys1vR_xD2ZPAdbkuqZhAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=904 lowpriorityscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401300026

During calculate vdev_stats_id, will compare vdev_stats_id with
ATH12K_INVAL_VDEV_STATS_ID by '<='. If vdev_stats_id is relatively
small, then assign ATH12K_INVAL_VDEV_STATS_ID to vdev_stats_id.

This logic is incorrect. Firstly, should use '>=' instead of '<=' to
check if this u8 variable exceeds the max valid range.

Secondly, should use the maximum value as comparison value.

Correct comparison symbols and use the maximum value
ATH12K_MAX_VDEV_STATS_ID for comparison.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v6: position adjustment.
v5: no change.
v4: no change.
v3: no change.
v2:
    1. add Tested-on tag of QCN9274.
    2. update copyright.

---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a27480a69b27..6d9660f68074 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5366,7 +5366,7 @@ ath12k_mac_get_vdev_stats_id(struct ath12k_vif *arvif)
 	do {
 		if (ab->free_vdev_stats_id_map & (1LL << vdev_stats_id)) {
 			vdev_stats_id++;
-			if (vdev_stats_id <= ATH12K_INVAL_VDEV_STATS_ID) {
+			if (vdev_stats_id >= ATH12K_MAX_VDEV_STATS_ID) {
 				vdev_stats_id = ATH12K_INVAL_VDEV_STATS_ID;
 				break;
 			}
-- 
2.34.1



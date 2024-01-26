Return-Path: <linux-wireless+bounces-2560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DAB83D9AD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 12:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E980F1C23AC5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19971B802;
	Fri, 26 Jan 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zc41BYJd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317E1B7F7
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269989; cv=none; b=c4vCOmHt4hnIS+dAuOIqQHh97zd6p8DxWEROia3Jueg8iMOQyauYlzD8kz6ATTI3uhFU9XtTfESeIH14pb9RKhS4n1UVNYXnbOo/MUb0ARZjmLzj1Q9OBqsuqMpb/g0uW3N5FJhr9+pPTroBKKQdLZPqqbRg1sqcH5LXe8H2GfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269989; c=relaxed/simple;
	bh=ax6YTzdjTO0hQGa1khJWrdR1hrKflKai2/K8i/xaeHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMAB2dEMiHBIPWSLNi3qTInK4w7jhcSC+aXCc31owKnvMeltvuj8iOVvH76BiTzhnWAgncPTCH3Z11X2+6u28xDeO4ZuoGl0Mi6DwrkWVmzG7KqjpDK8xnD9DLl17dm+i+KtkDK1QGoacuEdmM28kZ5wd1+1sVJyJk06G5USQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zc41BYJd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40Q3SdKA022473;
	Fri, 26 Jan 2024 11:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=wwNQ1hC2q3wKWkatICKj0qukLTSwyQUTijUHRiQSwNc=; b=Zc
	41BYJdX+NTCnzeUUp2ofRcdqf6t7Uq/YhRcv9cWnH3jgEW46GynSUBXO4gJJeNOO
	LY2rxUkZBIIrsQgi578ogj54UpLIWjHJPQMcadRtgkSQ7AcQ9MfvLKZ7AWT1eJUo
	LA4HDpT0cywckGpcDxh3uPpF+KY8EM1NrthAITv6EF4qANW2k0Qxz3h+1QKXXcpp
	K9kgiEmo/YzBqq7tDXQhr5jZnglw1Gge9XRy7y1Q/63NXoZyx+hzAOCgc/plSKC6
	HqukqgfujdOBoI0is525kCch4RLXOstKV3vMFLhLVHxf2jnqd6PNy0f+vbQnJnmh
	jfGvfoAiM5f89gV2OcqQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4v810b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 11:53:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QBr4nw026969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 11:53:04 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 03:53:02 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 10/11] wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
Date: Fri, 26 Jan 2024 19:52:30 +0800
Message-ID: <20240126115231.356658-11-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126115231.356658-1-quic_kangyang@quicinc.com>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: HkBg5B8a6_e-ofpzhnT1W2DQ07PAKf2n
X-Proofpoint-ORIG-GUID: HkBg5B8a6_e-ofpzhnT1W2DQ07PAKf2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=990
 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260087

During calculate vdev_stats_id, will copmare vdev_stats_id with
ATH12K_INVAL_VDEV_STATS_ID. If vdev_stats_id is relatively small, then
assign ATH12K_INVAL_VDEV_STATS_ID to vdev_stats_id.

Obviously, this logic is incorrect. ATH12K_INVAL_VDEV_STATS_ID is 0xff,
and the data type of this variable is u8. Which means this judgement
will always be true. So will get 0xff for every vdev except the first
one.

Correct this logic and replace it with the maximum value
ATH12K_MAX_VDEV_STATS_ID.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v4: new patch.

---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d8c8bd420aa2..6b8b92d22553 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5520,7 +5520,7 @@ ath12k_mac_get_vdev_stats_id(struct ath12k_vif *arvif)
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



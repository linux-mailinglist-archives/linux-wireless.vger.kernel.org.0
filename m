Return-Path: <linux-wireless+bounces-5511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C982A891051
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 02:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3501F22EE0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B753179B1;
	Fri, 29 Mar 2024 01:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K4U0mUBj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B776B179AD
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675464; cv=none; b=WSW+/ttuCkoHQtW8RfAYPG110e5Od1VXfzeh9E4BE8nWfzdV/UfjXG+Cgx9KbX/8/eEXunBzbjBI6MlpNyaoBoWUC8EHXEGBTxfSlhrQYfca+4drhvRItleguRP8MxSmykKHJ3MqJAve7EB8LkOWAkNdso7PggDf7HQlyb4B08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675464; c=relaxed/simple;
	bh=LgQzKiNTOpKdRTyyU17H+NvlQQr8Iut0LOVtUUjw+hY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qoa4ndhLrZhBo/l3xAonJPwasGNrZoEuKvwr/E2cW+MWmURoDACAuFCJyaeO7YzE7hpWaoZtuErX8q2eXMJoz0L/kCQs4luilA84oZ9fe2FCDFv1PGXcDyDGs6hbo9NOUXp0yXCeSaGZdEDl5H3/Q/dRXYIgJo7iTuWXfrgfzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K4U0mUBj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T01cY6013914;
	Fri, 29 Mar 2024 01:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=EegkrLJ0Q1CME0DgtPAwFh0g+7lVxuyikd/jJD7CxZk=; b=K4
	U0mUBj0mP3UgCVD7YL51ZAGIGWytPd1lWgGenFSS8weCihFhoDBvGJr1MORY89mQ
	dnSLwOF4QduCAlEwcn+cOJA3nlFLK/nNtuQ4a2VqQ41xrCROPwr3zepBt2+cW2P+
	TxDlSB+AlOygU9OFGo+A1c84baLamFrzujoJZ1N37duEBfNsvDINZTZEgUQ6ZC6R
	0IE5LUpTx6W4tx62XVg4O8jvmBvzb5qNCUnGaXNlN/OMXUXkg3zgd+i6qsYxsUW1
	a51236vSzw4CG0UGX1XJewQVP9+XtyR94jrom3OeL1jy1wFVI3K/75d+JEaPX3ht
	IhL1a/KwZhPdm+Rb5aXw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5fs88emp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:24:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T1OHlH011790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:24:17 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 18:24:15 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: fix link capable flags
Date: Fri, 29 Mar 2024 06:53:58 +0530
Message-ID: <20240329012358.2242354-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329012358.2242354-1-quic_periyasa@quicinc.com>
References: <20240329012358.2242354-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: CWsaVf2OTbQsJ1syaufSFnLSiV8UyflY
X-Proofpoint-ORIG-GUID: CWsaVf2OTbQsJ1syaufSFnLSiV8UyflY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290010

By default driver supports intra-chip SLO/MLO, the link capability flags
reflect this. When the QMI PHY capability learning fails driver not enable
the MLO parameter in the host capability QMI request message. In this case,
reset the chip link capability flags to zero (SLO/MLO not support) to
accurately represent the capabilities.

Found in code review.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 3f0d2b99127a..db8ba5fec2ae 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2006,6 +2006,8 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	int i;
 
 	if (!ab->qmi.num_radios || ab->qmi.num_radios == U8_MAX) {
+		ab->mlo_capable_flags = 0;
+
 		ath12k_dbg(ab, ATH12K_DBG_QMI,
 			   "skip QMI MLO cap due to invalid num_radio %d\n",
 			   ab->qmi.num_radios);
-- 
2.34.1



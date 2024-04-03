Return-Path: <linux-wireless+bounces-5786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 138FF89636C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 06:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E54EB2107B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ED044C97;
	Wed,  3 Apr 2024 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XMslPulG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDBC43AD2
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118078; cv=none; b=axtCIG+pB1Lv9qlwA3ZRePZbm3FAYPtYxxDIPya0djJVCFU6GdWSPC9JdnWUamSZhfiAdXsi6SFmkgmaSN6385vaL9icAPnwTt6vHmwnw9uNMfr8XG84ZlimKsDt1Wq1mf6P7tmaJq7/443/pFfPY164Jhe/W/1qhr27xOH8vX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118078; c=relaxed/simple;
	bh=kwnLjkCFqaCWtK+wZaVC2z+/f4vtJAHS7QXKooJcDIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aymg6UHUnNqafe9FVOLojIbRVVk7JPx5u4F+QRB6nZTDCbvw7Typ/V11jkwtB/7GtlXD/dK89B+7AtvNTBhaj1ootGreZOgJ5VmvAibNk62uR48wpX+cHS/B/plvbukMiUy4xGU98YBubwhGMhQwl/r436hsSyHDaiuTpYNIBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XMslPulG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4334C6Sk005553;
	Wed, 3 Apr 2024 04:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cNedL5Sjf5QiOTnKSHGfDYYWLwCZ8FVoOFYmCVKLYtk=; b=XM
	slPulGhezioI9dMUNK1i+DSTXxL3l0Fp7gUFmpBcQrhKvZ9tlfEvSkF8WbNXfP1S
	RXtTy1D95KPsYx70cS4kdq4r6+D0murRnaZ+CekXkausw7lrcFRoDgjVKkbi2MMh
	0sTIk7T9xLsBmfLHk8yBQDtDer2eQhgzIeP4nMDfG/oGklnYtdFQtlqodqo37PT9
	aln0TJxXjg7AI68zjbeW+mCfE/qrlstxCiEPGhY9bjCMJsQRgnsTZGNfyilG8EsB
	7C9e1s6qko9uQWbkVrI2tEx4SvXkjXO+ICoeOz/6y2kj4oNWQiWgaagr1uiOW8UA
	TW3gHbMCRzzTvLC/xq6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8va68cq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 04:21:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4334LEBW031833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 04:21:14 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 21:21:12 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 2/2] [RESEND] wifi: ath12k: fix link capable flags
Date: Wed, 3 Apr 2024 09:50:56 +0530
Message-ID: <20240403042056.1504209-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403042056.1504209-1-quic_periyasa@quicinc.com>
References: <20240403042056.1504209-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mUn_Qn9ffVVry_NXnTysy4yAOcDB0i8L
X-Proofpoint-GUID: mUn_Qn9ffVVry_NXnTysy4yAOcDB0i8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030027

By default driver supports intra-device SLO/MLO, the link capability flags
reflect this. When the QMI PHY capability learning fails driver not enable
the MLO parameter in the host capability QMI request message. In this case,
reset the device link capability flags to zero (SLO/MLO not support) to
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



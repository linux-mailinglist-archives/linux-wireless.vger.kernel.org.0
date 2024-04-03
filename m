Return-Path: <linux-wireless+bounces-5784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B67289635A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 06:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF161F24086
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 04:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAD744C86;
	Wed,  3 Apr 2024 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kHdLBaT5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E39543ACC
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712117077; cv=none; b=CHVtfnE+bbCFq3yKF1zhTxtLCDcnNLKdvkqV6iik7wMXwQbCEed9jP+o6eqhTQQoqmOhnD79YHatQCEn+ioIVxSzmaJQ/62OVWYbeoyuzH6pG+3t7g6wA51x1GlxC9I6OS21L0sWHX80J9U6mjn6ObBh2F9LU7Y7EkTq2/f7OV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712117077; c=relaxed/simple;
	bh=kwnLjkCFqaCWtK+wZaVC2z+/f4vtJAHS7QXKooJcDIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfnTLsZDIS6JhnsGyterc0AfFxjfcn44AyrbWvTyK2fTBESsBl8QwqzMG9Mz25VTweXkFgEY4/kvpTUgXx4UDlB/QsOO7jGeLQC9Pjr/NW9JIlmSho3mJs7mIPZRJGCef3a36IedqBPzAL26hfCINTIXVC5ey21TrlCUyMUx2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kHdLBaT5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4333Muoe007347;
	Wed, 3 Apr 2024 04:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cNedL5Sjf5QiOTnKSHGfDYYWLwCZ8FVoOFYmCVKLYtk=; b=kH
	dLBaT5gA1aejJ1Hj+9q1PxUXGdqc22db4AV7jFjTbeG81sQ2Mmo26J7EYwQe983F
	zw/7rigrFDVzScwBow0LiOmrERwb4MkwhS+I6IdGl0ZuaweT48Y1H+Cl1JA4aOGY
	4Cny9TWBGEA05cxBxIGkM3PU/wLLSy/SODTTnwfj1DQVrSTcnrDVanqa4diRitqO
	IhEBFSj2rv+S3SePY4DqJ1XzxP/VicKP9BG/ifUYMs4zbeEDnhsv4JWBQVNIND+4
	PkfG/TBhoZSSCa56cv0bf6YB33zy71tfl97xR9OvKj5d51Zux5cZkCuVJLeviRah
	T/UjMbthryzllBcKH+ag==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8gn5j760-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 04:04:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43344VCe014159
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 04:04:31 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 21:04:29 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 2/2] wifi: ath12k: fix link capable flags
Date: Wed, 3 Apr 2024 09:34:12 +0530
Message-ID: <20240403040412.1488095-3-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403040412.1488095-1-quic_periyasa@quicinc.com>
References: <20240403040412.1488095-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 9H_iokhnHF8TueNEYWzu1NdYVm9nSMQn
X-Proofpoint-ORIG-GUID: 9H_iokhnHF8TueNEYWzu1NdYVm9nSMQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030025

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



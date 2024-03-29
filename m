Return-Path: <linux-wireless+bounces-5606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061138922E2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5222288F6F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C856653E28;
	Fri, 29 Mar 2024 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HyxsCn0C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367AF482E9
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733995; cv=none; b=dA/0bSU4av4yn6JKnx5l+pYPL+Epq3+9DPHA9BONriJzLHYmvztW2QOD+75/55RIni+46mUwkLQX/7tdk5HFHjB2LfxTflIBbR9Kn5JnF1+JNeSCRFbPf8/ziyJKnBWZ+F5EznL34bHuLU9h17CqcSPqKDXw0u0orP81yChaHJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733995; c=relaxed/simple;
	bh=wb9fvPDH47rDciL++Ck6RhmxK9BjJ5Embe3V6lE8v0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VyhTxnk6CxINHaE1QoQFZbmt3hq4yA9kpFIFJE6hIra84+R4a621utZ8Qq5KdC5Q2lIFFAoEAZ5IMwlFTEJSH4FzX7kGRcTAdqS/JfGPom0zUpsLkIXJST0gM5mOWyX8cZFoDVkD/qOfB3f8ijDznApcqzSIh+1GeUvz3ufY/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HyxsCn0C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TFrICk000705;
	Fri, 29 Mar 2024 17:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=E8oQRDGuEcy6xgDLO33ZcwMy8LosrJKiqrkozrYurEs=; b=Hy
	xsCn0CYXFrBwTu4K63LNZ4KmJN1CFi4h/dbyA9fA8ohp8RpF6DrQcte65j9B8jSg
	NTmQQjZdoOariSDg//MKi9HNDpSJH7/dA8vIdKOnHYXylOZZVQxCHRMqxr4XOfwb
	G2d2SxzLYDuXSt//IJNRFUbLq7HF+IXHVOHfLJl3b22+BIOxeqgibcgBVRVD/Jb4
	hqc/FGCUSeOhPT4CH4HG9LNQBYY1gR6lNPoRjfoq0skyKDI/bVDfVUUJkmrqHbAo
	T8uR0qW9ZhEjFEI6BbHMyUeL34nUiJd5Yzo1OEnRmyvnWI+L/YqnE0pc2jugtnmr
	1C9ztAqqsvLgY4A/la6g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5dkyk1vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:39:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THdb8V007399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:39:37 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 10:39:36 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH v2 0/6] bug fixes and enhancements to 6 GHz band support
Date: Fri, 29 Mar 2024 10:39:20 -0700
Message-ID: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: snszDSUWHmk6YveMmSHbmbsjN30zHoQo
X-Proofpoint-GUID: snszDSUWHmk6YveMmSHbmbsjN30zHoQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290157

In 6 GHz band, add support for
1. channel 2.
2. Fix packet drop issues.
3. AMPDU aggregation
4. SMPS configuration

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

changes in v2:
 - Disable smps for WCN7850 after review comment from Boachen
 - Added Tested-on tag for WCN7850

Pradeep Kumar Chitrapu (6):
  wifi: ath12k: add channel 2 into 6 GHz channel list
  wifi: ath12k: Correct 6 GHz frequency value in rx status
  wifi: ath12k: fix survey dump collection in 6 GHz
  wifi: ath12k: add 6 GHz params in peer assoc command
  wifi: ath12k: refactor smps configuration
  wifi: ath12k: support SMPS configuration for 6 GHz

 drivers/net/wireless/ath/ath12k/core.h  |   2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c |   9 +-
 drivers/net/wireless/ath/ath12k/hw.c    |   3 +
 drivers/net/wireless/ath/ath12k/hw.h    |   1 +
 drivers/net/wireless/ath/ath12k/mac.c   | 116 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/wmi.c   |  10 +-
 6 files changed, 116 insertions(+), 25 deletions(-)


base-commit: fe7e1b830cf3c0272aa4eaf367c4c7b29c169c3d
-- 
2.17.1



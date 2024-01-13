Return-Path: <linux-wireless+bounces-1849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40B82C841
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 01:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465D41F23164
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 00:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5236F195;
	Sat, 13 Jan 2024 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O6fTP8+l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23232CA6
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CLTef7023820;
	Sat, 13 Jan 2024 00:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=nj3uCmE
	hK6vA4FWBqxM9U8NjlK52grLTPrAiSnDTfMQ=; b=O6fTP8+lHN5TSuJETZdkphq
	iGjqZhE5aEeBSS/CWlF43IpMzh48xJB4YECX8u5MFW9+92AMMnTI1gncaaqGucWm
	9dI/9KQeEuDBD7TvKMKOcD8xePAN03DsUyD9/1oN2dDbopEAWccmPkTleV6v+QF0
	8zLIeu5KHMVz9YYSmQZkuW/HiR2YkPV1f29jmaW7AD7IWQzxQupsFuo/BCs3+lJi
	SmkdRftBvrmJbioZ25AfzSOcq0jO9DT61mVcvjaqKdfcPSA/uwaqmrcVG6uFxLLZ
	pKJX5G5tQqHPhSyDIdHrw/ceNymTpr0uJIdIwgI/QElv5HAM47svpw+WNKjArGg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkb74gkau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 00:17:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40D0HFpJ009715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 00:17:15 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Jan 2024 16:17:14 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Enable QMI MLO helper function on QCN9274
Date: Sat, 13 Jan 2024 05:46:57 +0530
Message-ID: <20240113001659.1022465-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: U-6OyepdyNLulrBYsDmVTZ9KWVGH3VrN
X-Proofpoint-ORIG-GUID: U-6OyepdyNLulrBYsDmVTZ9KWVGH3VrN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=506
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401130000

Currently, the MLO parameter is not enabled in the QMI host capability
message for the QCN9274 platform due to hardware specific constraints.
To address this, refactor the ath12k_host_cap_parse_mlo() function and
introduce a new QMI PHY message to allow for enabling the MLO parameter
in the QMI host capability request message.

Karthikeyan Periyasamy (2):
  wifi: ath12k: Refactor QMI MLO host capability helper function
  wifi: ath12k: Add QMI PHY capability learn support

 drivers/net/wireless/ath/ath12k/core.c |   1 +
 drivers/net/wireless/ath/ath12k/hw.c   |   9 ++
 drivers/net/wireless/ath/ath12k/hw.h   |   3 +
 drivers/net/wireless/ath/ath12k/qmi.c  | 154 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/qmi.h  |  17 +++
 5 files changed, 174 insertions(+), 10 deletions(-)


base-commit: dc1702f7b1340dd741bca1005ab52a2c92cc6c84
-- 
2.34.1



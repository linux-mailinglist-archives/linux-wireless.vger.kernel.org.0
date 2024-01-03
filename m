Return-Path: <linux-wireless+bounces-1422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B184F822806
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B489281FBC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 05:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED95A1802F;
	Wed,  3 Jan 2024 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jyRn2kd8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CBF1803A
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 05:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4032oFfo013290;
	Wed, 3 Jan 2024 05:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=OlhOUdL
	q+cGfppRS6u0LovKMuQ4HaUfJARI1h41+tq4=; b=jyRn2kd8n5JYRQ/cvSYS+53
	NLk4A3yePzU8rfVCbGzFbyubSGi+NFkFoNQiXUUlBXo7495RkjOzedvACVJTXuIt
	d3YivuGM9UxiJiI9Dp3ftSTJmmpUdsT+zD9r3hhSXEvY+m4eEQDN3UelVayOUIoD
	XMtlKfnzqDCwJWRRbhIWlm/UA4eqN0RVvc0tRO/IDQEJIhYESSu1xSbRC7JFL6zt
	+P0zlFNNY3FYWjhzFEgs9JlphTlUqTD+tH3Rbb4cPgj6xQeQlz7rbq6gadAec7e6
	/H5gIGe2jIQfPh/nGNBBAE/HMXPRAh+CtnnuVzA6zrEBiJNBFfeS3NUYhHq5qDQ=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vc9nn2q7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 05:10:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4035AQmI003078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 05:10:26 GMT
Received: from lingbok-Latitude-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 21:10:25 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/2] wifi: ath12k: add processing for TWT enable/disable event
Date: Wed, 3 Jan 2024 00:09:24 -0500
Message-ID: <20240103050926.14115-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KTtGUJNMcwqnWG7Nxz3lSix8aJyeSJJO
X-Proofpoint-ORIG-GUID: KTtGUJNMcwqnWG7Nxz3lSix8aJyeSJJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=394 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401030040

From: Wen Gong <quic_wgong@quicinc.com>

This patch set is used for processing TWT enable/disable event. It can be
more convenient to debug TWT.

The patches work with WCN7850 and QCN9274.

Lingbo Kong (2):
  wifi: ath12k: add processing for TWT enable event
  wifi: ath12k: add processing for TWT disable event

 drivers/net/wireless/ath/ath12k/wmi.c | 72 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.h | 12 ++++-
 2 files changed, 80 insertions(+), 4 deletions(-)


base-commit: 2cd4e3f91f264926a6b11df948417b74d52ca9b9
-- 
2.34.1



Return-Path: <linux-wireless+bounces-1424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03BB822872
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 07:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E461C22F49
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A71802B;
	Wed,  3 Jan 2024 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CqeIrfgw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC518021
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4034Zh1F026011;
	Wed, 3 Jan 2024 06:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=bTlnlk7
	P/RJFrzfh3ecH2z9RKBFwJwFi7etU3pSJkrQ=; b=CqeIrfgw1wdijy7ylbQ2sP2
	ClxCy7/9z5ahRPoN3rvK/gqEN+TAAB7DZ68Mp6lPghoQs4i6ZkueBrNr8SG08Xmw
	L6f05Uwj+2iBB7hnOb32TX4WY/y3f3y4zU1twcKyDg+ohsT2AUbf2sxh/OWyKobD
	vIP5UG9gtpSOpTREMlDnT5jQ3IKKe3qu9x5BKvoT4IL2ADY2sgCdBszog7Djz1Ie
	schrAMgwVzWS/uflBnPb7YphMSWy42bgcR/+mw3BD0FQbTvxYV6kruRn6hfKfT+X
	5qjc0bkXUtmZxDdul4TbCDm9J+oDzxOL0HlWQUjXRnp6IQ68gF2A6Qq2ioM6tCw=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcgkuab2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 06:37:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4036bmFp023428
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 06:37:48 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 22:37:47 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 00/10] wifi: ath12k: Refactor mac80211 callback operation functions
Date: Wed, 3 Jan 2024 12:07:21 +0530
Message-ID: <20240103063731.3356060-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: lMq3ws7MSesYh_pVqvM-vosEh9XdI2JO
X-Proofpoint-ORIG-GUID: lMq3ws7MSesYh_pVqvM-vosEh9XdI2JO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=418
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030053

Currently, the existing mac80211 callback functions are defined assuming
each link/radio is represented by a single mac80211 hw. In order to
support multi link operation (MLO), need to move from the multi wiphy
model to a single wiphy model. However, the single wiphy model allows
multiple link/radio to be exposed by the same mac80211 hw. Therefore, we
need to separate the link/radio specific handling within the mac80211
callback operations. This way, the callback can be extended to support
multiple link/radio in the future.

			Current Multi wiphy Model

+---------------+            +---------------+            +-------------+
|  Mac80211 hw  |            | Mac80211 hw   |            |Mac80211 hw  |
|  private data |            | private data  |            |private data |
|               |            |               |            |             |
|               |            |               |            |             |
|               |            |               |            |             |
|   ar (2GHz)   |            |   ar (5GHz)   |            |  ar (6GHz)  |
|               |            |               |            |             |
|               |            |               |            |             |
|               |            |               |            |             |
+---------------+            +---------------+            +-------------+




			  Single wiphy Model

                           +--------------+
                           | Mac80211 hw  |
                           | private data |
                           |              |
                           |ath12k hw (ah)|
                           | +----------+ |
                           | |ar (2GHz) | |
                           | +----------+ |
                           | |          | |
                           | |ar (5GHz) | |
                           | +----------+ |
                           | |          | |
                           | |ar (6GHz) | |
                           | |          | |
                           | +----------+ |
                           +--------------+


Karthikeyan Periyasamy (10):
  wifi: ath12k: Refactor mac callback of config
  wifi: ath12k: Refactor mac callback of bss info changed
  wifi: ath12k: Refactor mac callback of conf tx
  wifi: ath12k: Refactor mac callback of start
  wifi: ath12k: Refactor mac callback of stop
  wifi: ath12k: Refactor mac callback of update vif offload
  wifi: ath12k: Refactor mac callback of configure filter
  wifi: ath12k: Refactor mac callback of ampdu action
  wifi: ath12k: Refactor mac callback of flush
  wifi: ath12k: Refactor start vdev delay function

 drivers/net/wireless/ath/ath12k/mac.c | 250 ++++++++++++++++++--------
 1 file changed, 173 insertions(+), 77 deletions(-)


base-commit: 2cd4e3f91f264926a6b11df948417b74d52ca9b9
-- 
2.34.1



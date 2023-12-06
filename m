Return-Path: <linux-wireless+bounces-452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EDD8065D5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 04:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB58D1F21785
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 03:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D259FDDC1;
	Wed,  6 Dec 2023 03:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bXhaAgTS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A271BD
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 19:49:47 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B60r3Ma029407;
	Wed, 6 Dec 2023 03:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=kWQ9vh5Oolddv24J/mlNbuH3YsWFHczIn/9y2YYavDc=;
 b=bXhaAgTSDSsDFM4/Y0GGk86FALX4EML9jrggRo3wgE4qME2d+83ABNYQVaC3nQk218T5
 SRHZ4iw3Q5EHMx07NX0dH65QOfzQL0ViAReW56g3AsLZHW1aAcpynh5EkjG0QI4fS3MJ
 LyBXCZ0Oy0XT4TYI/TyTnhGCdOwYmM+6e78ocN53lsw/6lM/B99MZOzvo3a9vj7US3Kw
 Twf1n6iwdLEjVBImdPLjSbqDZNUUKZKo3YRz8BjecR58lrNoR9E5OilI5WGhITTDOmHv
 fZztgzu8/9/rpfRG+WF4K7zT8jkebDXnau/oM8pFpc7yr/mrg6fjA7WM8hvBudkm3qH1 Xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utdadre7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 03:49:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B63neh3024939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Dec 2023 03:49:41 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 19:49:39 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/4] wifi: ath12k: Refactor MAC alloc/destroy/un/register helper functions
Date: Wed, 6 Dec 2023 09:19:16 +0530
Message-ID: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: T0kaEHC1QG4IDEAf-Z0u-t0IR4rMalUo
X-Proofpoint-ORIG-GUID: T0kaEHC1QG4IDEAf-Z0u-t0IR4rMalUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=463 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060030

Currently, the driver does not support single/multi link operation in 11be
mode. Also, each link/radio gets registered as a separate wiphy through
mac80211. In order to support multi link operation (MLO), the current
separate wiphy registration approach brings a lot of complexity in cfg80211
and mac80211, such as synchronization across the multiple wiphy/hw.
Determining the compatibility of the hw across multiple wiphy/hw is another
challenge for userspace. To reduce these complexities in
userspace/cfg80211/mac80211, need to move from the multi wiphy model to a
single wiphy model. To support the single wiphy registration, we have to
decouple the wiphy/mac80211 hw data from the link/radio (ar) structure. So
refactor the MAC helper functions.

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

Karthikeyan Periyasamy (4):
  wifi: ath12k: Refactor the DP pdev pre alloc call sequence
  wifi: ath12k: Refactor the MAC allocation and destroy
  wifi: ath12k: Refactor MAC setup channel helper function
  wifi: ath12k: Refactor MAC un/register helper function

 drivers/net/wireless/ath/ath12k/core.c |  96 +++++++++--
 drivers/net/wireless/ath/ath12k/mac.c  | 216 +++++++++++--------------
 drivers/net/wireless/ath/ath12k/mac.h  |   8 +-
 3 files changed, 184 insertions(+), 136 deletions(-)


base-commit: 22d737065b8c4fbb29a3a818adcf88004ea7d5bb
-- 
2.34.1



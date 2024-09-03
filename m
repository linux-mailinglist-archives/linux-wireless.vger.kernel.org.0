Return-Path: <linux-wireless+bounces-12395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A639C96A2EA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE26BB26EC7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 15:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1316F8EF;
	Tue,  3 Sep 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SYqheX2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3218890C
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377740; cv=none; b=aaxR5sei2vFiGRBNl9N0l9RlDwiCSMWRgXeCezHA+ze5HvEnptrsvJjJ6Xd/hq4RDh9KJzERUh9D6vPq4/MkhIXNlMZD1Si/1LuLV23tEmFaeJKmPcvd49fI+qXuj7fPpzqdhfhWNVUKTpApkWyZj1abRc5i+HBPgpy/QOQgeEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377740; c=relaxed/simple;
	bh=/PYLIKbNlqHDrOIslLF07+W8xRWRF+qr/rE0Cx2KJmg=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=BqXjve3ObF9SKlGUshnWHICiAhzEqfWnxbULSbeMEIygfFKy7vQ7IblhvX1ExlbcrJtmsQzXKQJOYw/zwy7ruWPepsSbM7dqR0HAnls6XRUUpj88y3Fbfct36O9P4R6pFTUmboanb0VEUK/b5LEJSmdEMBHDyO79GFodZSiKxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SYqheX2h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483BWBIP028129;
	Tue, 3 Sep 2024 15:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GTtRFXUdKiuqNiu7gVBEbg
	8Hx8FJe/fi91/4XyGN214=; b=SYqheX2h726YAT8/SqnchmJElBmtRBpnA3gVom
	2pXr6KT4Kdia2hYx00LyO4zTp3m7ArFALcd6NyNXyzQTOAk7kkAd2CwHoFR/M9BC
	DjubjMvaBqTK20aYPjdf2XybxT9hxKqnKbCa7IIZgGFEo3N3DVt7PB36hzs3KB5O
	MDlzfKog4+YMzRvaaScHbWQBXE2ToPo6rAm7AlnfdwSrip9avXIoA3LWeFZBjE8C
	u2BCUmWCwyfA2O7pJIiRW9roKRiXXS2Br7nRtOE21DQMFknLxRJqMARkmtp5OmWc
	Jbke3HhCvGvMCrGMVzrF68uqagj+3XB7gaND9RQcTNtiPmow==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bvbkfqq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 15:35:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 483FZ7Ex005357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 15:35:07 GMT
Received: from [10.111.180.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 08:35:07 -0700
Message-ID: <8a9375eb-3205-4a78-a8c1-bd85df106ec9@quicinc.com>
Date: Tue, 3 Sep 2024 08:35:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <linux-wireless@vger.kernel.org>
CC: <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>,
        <quic_kvalo@quicinc.com>
Subject: pull-request: ath-current-20240903
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1Q3TZxKd_18OmTZB7ZXE6qbn8s5oQl1u
X-Proofpoint-GUID: 1Q3TZxKd_18OmTZB7ZXE6qbn8s5oQl1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_03,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011
 mlxlogscore=557 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030127

The following changes since commit 38055789d15155109b41602ad719d770af507030:

  wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850 (2024-08-05 12:28:07 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20240903

for you to fetch changes up to 2f833e8948d6c88a3a257d4e426c9897b4907d5a:

  Revert "wifi: ath11k: support hibernation" (2024-09-02 19:33:00 +0300)

----------------------------------------------------------------
ath.git patches for v6.11-rc7

We have three patch which address two issues in the ath11k driver
which should be addressed for 6.11-rc7:

One patch fixes a NULL pointer dereference while parsing transmit
power envelope (TPE) information, and the other two patches revert the
hibernation support since it is interfering with suspend on some
platforms. Note the cause of the suspend wakeups is still being
investigated, and it is hoped this can be addressed and hibernation
support can be restored in the near future.

----------------------------------------------------------------
Baochen Qiang (3):
      wifi: ath11k: fix NULL pointer dereference in ath11k_mac_get_eirp_power()
      Revert "wifi: ath11k: restore country code during resume"
      Revert "wifi: ath11k: support hibernation"

 drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
 drivers/net/wireless/ath/ath11k/core.c | 115 +++++++++------------------------
 drivers/net/wireless/ath/ath11k/core.h |   4 --
 drivers/net/wireless/ath/ath11k/hif.h  |  12 +---
 drivers/net/wireless/ath/ath11k/mac.c  |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  12 +---
 drivers/net/wireless/ath/ath11k/mhi.h  |   3 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  44 ++-----------
 drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
 9 files changed, 49 insertions(+), 148 deletions(-)


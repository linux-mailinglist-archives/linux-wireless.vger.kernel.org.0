Return-Path: <linux-wireless+bounces-17260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D96A08021
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 19:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98813A6AF7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BCB19EEBF;
	Thu,  9 Jan 2025 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jo1uDb2B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4FCA52
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448590; cv=none; b=DZpe/tj+wwSCUrO7/yebm3UDzQrXlIOAmStG5ElUkG4yvd4fbuOoD/m/CYCvGHTBRnXkSVyQ3I4vpl8JImPNqePgPf2Vzdj2S+a5Fxz9c7MBch8lG2sGYL1pjyCG//BluuAe0AViedKks441Zrj+jiXuzTcgcRVl60EySWFnzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448590; c=relaxed/simple;
	bh=7ccL/SceaXz8ruEQn2LmaO+vGazpPOnA8zj7opX2gOE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p1eZkjZgm+pRVjUPtQRFrjh1+f5abuRRHu7gOqu9FWhbu7mpSb9sAwJMkaSKPVQFi+deBU5nqwSdkR1YjNgtsfL713uKkt6FGsczPFVY9OI0cWI74XnWPG6EkooYxJat2U8KQEbR92mSn/PWJ7dafCFv2rumFo/Dt53M26CN6xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jo1uDb2B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509D7h4r009940;
	Thu, 9 Jan 2025 18:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=B/LCTg3XJh0Wcb9c4/1xP8
	6SlFilcykgLLR/kf90Psw=; b=jo1uDb2BxpmD/SfNUMUL6uRJPfx2OpMEScrzn4
	8w1tnti37VVf7iRkJ7yk2On24DO0Zph+094yF1qwJegiNxLn2D9jEj3T8EKRSVFr
	R98Vg7IruoNDI/+/Goj5TAoUOYjztaBzMuhecdp/MT//SPvKIO87rsy2KRaHtZ6k
	PoQnn5ghP+vD2kMUeGVPhuQKbbP41g9qqrshpF4AxazaqOHFFxygUwffqg4zW00j
	UwDQWAabHaSTHM0Hayi4wtVrpwIKGiM5fQw/0dRlacz/pvqg6jpR2ZPGVdfnt9CI
	BDUL1+8mDvc3oRx6ITE9xCuRj7wm10MLqXYwCyXGc+ux4lkg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442f2krtkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 18:49:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 509Ini5C025318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 18:49:45 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 10:49:44 -0800
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Add support for MLO Multicast Handling
Date: Thu, 9 Jan 2025 10:49:30 -0800
Message-ID: <20250109184932.1593157-1-quic_bmahalin@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2EzUZTYD1qhgcpm_OZj6S1rfQp4oKk0I
X-Proofpoint-ORIG-GUID: 2EzUZTYD1qhgcpm_OZj6S1rfQp4oKk0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=774 clxscore=1011 lowpriorityscore=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090149

Patch 1 updates the HTT TCL metadata version to use the new bit definitions
	of the field to pass additional information from Host to Firmware.

Patch 2 moves the MLO Multicast frame duplication logic to the driver to
	have more flexibility to update the HTT TCL metadata with the global
	sequence and with a special vdev id to indicate Multicast handling

Note: ath12k-check verified and it lists one exception for length.
      Exception has been fixed separately.

Balamurugan Mahalingam (2):
  wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
  wifi: ath12k: Add support for MLO Multicast handling in driver

 drivers/net/wireless/ath/ath12k/core.h  |  3 +-
 drivers/net/wireless/ath/ath12k/dp.h    | 27 +++++--
 drivers/net/wireless/ath/ath12k/dp_tx.c | 27 +++++--
 drivers/net/wireless/ath/ath12k/dp_tx.h |  4 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 94 +++++++++++++++++++++++--
 5 files changed, 135 insertions(+), 20 deletions(-)


base-commit: dbe50a7420e22954c747e79e72df2750d795ea77
-- 
2.34.1



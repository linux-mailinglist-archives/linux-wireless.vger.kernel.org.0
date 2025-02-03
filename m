Return-Path: <linux-wireless+bounces-18285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD56A2535C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 08:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4D216286E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 07:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182541F76A5;
	Mon,  3 Feb 2025 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GiCsftvM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC91E7C34
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569368; cv=none; b=qBr6gOhIqYr8QHUKW3rcso3hVtXU53tYrp2LDdAJ5a+H+vVxc4oCBehhxxxxYTYWvHPdv0KvfgVojWcgt1XcR1HLlzCVTmt7ATwPd4swL1etBCbU1t4WL+4BiYS7kX92EuILsEt7NHe+hHA9Z5PNIOVQyGzer95JND4YcGoVGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569368; c=relaxed/simple;
	bh=CEJpjcxSbO0fJhi98dQGGvrwSS8BJsqTJRSDF24wZz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQFlLk/eoj7rTuVh+F0lcF/wW6n9hpBGLc5gXT+vvN3SuZcwOf6Bart9J7hgOkBqyk30k6JThvoPusnOwy9Osee0C+zs9kKlxQngsKOZgoXzNKxgjU1oByuEawUWDmnudtpLDpYOdHhFYctj0o2BMDHroNW/gmEOGD1z+DejP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GiCsftvM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513673iq009303;
	Mon, 3 Feb 2025 07:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rIKVqs6srmjXj89c0Lhu5H
	KpeL5yplUu6T2wV1qKBHw=; b=GiCsftvMEP0laGtEuIBKW0usJe9RXl7KWVxpbl
	rPuNhODRT5ydxX5O9BdSGzWEcRHqYWdd/Yd9gfjZjFtER7vFpojHKDXaIauYFHwh
	7VBd2jiXCINkXDjTiE/PWUN6WVhimGGDA0qCqf0jgqmoV2o2hB0TTYoLFJ1DnZ38
	H05GhceZtA1OdfjKT0JqSGv5Z2dYNudNKbHCmo6bP9VKPMzDcH56jNvP7PYAiOws
	31aiH7Zcb7LMkWB5tvnEAs/9OZkboXm1a8Dakon5xLuGBFBFFTv2a6CzMIBgDn1+
	8aIUAKXBlmLJHO49+mbHt4nk0Q3i7YDXxmWK15TEfCdqjxjA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jr888776-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 07:56:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5137u0tD009516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 07:56:00 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 2 Feb 2025 23:55:59 -0800
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>
Subject: [PATCH v3 0/2]  wifi: ath12k: Add support for MLO Multicast Handling
Date: Sun, 2 Feb 2025 23:55:36 -0800
Message-ID: <20250203075538.3982875-1-quic_bmahalin@quicinc.com>
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
X-Proofpoint-ORIG-GUID: H4GippJyAqvAt-xMMC-IxE-H94yFG-rd
X-Proofpoint-GUID: H4GippJyAqvAt-xMMC-IxE-H94yFG-rd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 mlxlogscore=749 lowpriorityscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030064

Patch 1 updates the HTT TCL metadata version to use the new bit definitions
	of the field to pass additional information from Host to Firmware.

Patch 2 moves the MLO Multicast frame duplication logic to the driver to
	have more flexibility to update the HTT TCL metadata with the global
	sequence and with a special vdev id to indicate Multicast handling

v3:
	Updated the code to handle the ARP transmit failure from AP side during secure mode.

v2: https://patchwork.kernel.org/project/linux-wireless/patch/20250203025016.3851279-3-quic_bmahalin@quicinc.com/
	Optimized vdev id arithmetic for more readability based on feedback.
	Updated code documentation on intentional reset of meta_data_flag value.
	Rebased on top of master branch.

v1: https://patchwork.kernel.org/project/linux-wireless/patch/20250109184932.1593157-3-quic_bmahalin@quicinc.com/

Balamurugan Mahalingam (2):
  wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
  wifi: ath12k: Add support for MLO Multicast handling in driver

 drivers/net/wireless/ath/ath12k/core.h  |   1 +
 drivers/net/wireless/ath/ath12k/dp.h    |  27 ++++--
 drivers/net/wireless/ath/ath12k/dp_tx.c |  28 +++++-
 drivers/net/wireless/ath/ath12k/dp_tx.h |   4 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 124 +++++++++++++++++++++++-
 5 files changed, 167 insertions(+), 17 deletions(-)


base-commit: a10b8b584b8bcb7559f068ce247fc27d0c4850ca
-- 
2.34.1



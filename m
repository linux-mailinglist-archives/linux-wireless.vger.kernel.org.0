Return-Path: <linux-wireless+bounces-18271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC5A25175
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 03:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C599D1883E41
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 02:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ACE1C695;
	Mon,  3 Feb 2025 02:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dEApRWBD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2777AD23
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738551046; cv=none; b=PtQpblnwtyvkmU2jKWu0rA4nbfCCL6ORnMyhXvSMUgErFfQeEyF3+CjA7adhSduQpDcnPyPnsjsJGSq7jdQwuUVA2hMlyvKtdGWUdefixX+tIOdJaVrfSOFqdhV/xBWfFiyhUz+qnd4+spQfoAM3ell1QjUpf9TFE22CLgH+Vu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738551046; c=relaxed/simple;
	bh=dNJEfxxEsJ0M7NlmS1brttLHMsCoe8GNpKqfA/HW8nQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f0OETcsVx4k1Zltaag+fCWkjdr9SGjrO7HTwvE574kW4BYXz9xP21qmfjm5Qu9VHIGz6gQ9ZaKXI6GS3xUzid6EEDN5xN/gmgwzyGF4PLncU5rHM/KZDo1bdtnFgxMkE+4mp4mSg+BwkLR2GkZpNQBY7iQ79wKeYi9gJDNPyceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dEApRWBD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 512MW9qO025956;
	Mon, 3 Feb 2025 02:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9Ym76d43NUrtoZHrSGCxkH
	bJFUzSiHaZaXiTy6AGUy0=; b=dEApRWBDa+GRcdtyYYfVQlaGPeyQr1tx3aOhSX
	yl+oz8I3jhWGhLOk7KvBZSraObtoGZ2ocs0C6djGZ1vMT6TZ6Ejlkib1uvWwfsyM
	lYbP+pDkArwrkffMZ5CRaGaQ1ZyR3Hr1dPipf+9qzl9QlvW5+UIDKZROgZpdGX3/
	CDTS23xzg38osN0/S8GiXHq53BD/8VUmKme/qrDz9VGKIKWFn+BLpcAQVW5myABs
	fedR9x3+odU3Wr2P7hlcbe6kR1VejnTn2hW2YefjviIQUOA/sAPy0OiwQLiOuQbf
	WlB9hSshDZ2QYW20K6+55p9g6/GBKx8UqLtXM8yRPTnB2vJA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44hd8wb24m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 02:50:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5132ochF010555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 02:50:38 GMT
Received: from hu-bmahalin-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 2 Feb 2025 18:50:38 -0800
From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bmahalin@quicinc.com>
Subject: [PATCH v2 0/2]  wifi: ath12k: Add support for MLO Multicast Handling
Date: Sun, 2 Feb 2025 18:50:14 -0800
Message-ID: <20250203025016.3851279-1-quic_bmahalin@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hnZR0n6OeeMohDiFvMCw6r0aZHi_FoaD
X-Proofpoint-ORIG-GUID: hnZR0n6OeeMohDiFvMCw6r0aZHi_FoaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-02_11,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=789
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030022

Patch 1 updates the HTT TCL metadata version to use the new bit definitions
	of the field to pass additional information from Host to Firmware.

Patch 2 moves the MLO Multicast frame duplication logic to the driver to
	have more flexibility to update the HTT TCL metadata with the global
	sequence and with a special vdev id to indicate Multicast handling

v2
	Optimized vdev id arithmetic for more readability based on feedback.
	Updated code documentation on intentional reset of meta_data_flag value.
	Rebased on top of master branch.

v1: https://patchwork.kernel.org/project/linux-wireless/patch/20250109184932.1593157-3-quic_bmahalin@quicinc.com/

Balamurugan Mahalingam (2):
  wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
  wifi: ath12k: Add support for MLO Multicast handling in driver

 drivers/net/wireless/ath/ath12k/core.h  |  1 +
 drivers/net/wireless/ath/ath12k/dp.h    | 27 +++++--
 drivers/net/wireless/ath/ath12k/dp_tx.c | 28 +++++++-
 drivers/net/wireless/ath/ath12k/dp_tx.h |  4 +-
 drivers/net/wireless/ath/ath12k/mac.c   | 93 +++++++++++++++++++++++--
 5 files changed, 136 insertions(+), 17 deletions(-)


base-commit: a10b8b584b8bcb7559f068ce247fc27d0c4850ca
-- 
2.34.1



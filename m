Return-Path: <linux-wireless+bounces-8333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524A8D58AC
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 04:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EFB1C22423
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 02:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF6377F1B;
	Fri, 31 May 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cAayvBnL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89E1F16B
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123218; cv=none; b=Yo8OBvgIAa2mFZ0r9u4v1WmnYMqZX7kZSJNNpETC+9rDS3HOg8eBTBPoFBitzCYGvmMCaTaTHmETbvYrpGVr7ZBlIcOZNyUfEPZcrPHMo2tTeHRFdnCqxhXmxlOeXLFNdDn5mHfguOWyBAchtNFaw6WCfKMiqvztnxbfOtQGcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123218; c=relaxed/simple;
	bh=HZimZAbkrDokM+Mqvu3mXxi/NL3/poa8bXrHQCV4x+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mtS1vL3GMTR3oiTZLwY4lBn91LiQfwIFkOwTLpLoyI0hR1EN4g5XeZm6iF7ZdCSx4Ar+lJO1iQmGVvTUhdJG9h06YBHNC0AitBXemWRjx/a5xM6y2T58ZsvYp1ruwmvzPmV/MM+lSy+pWW/UTNo47D0QmW3haSjU3WUPBorETj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cAayvBnL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V1m07a003487;
	Fri, 31 May 2024 02:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WIJ3LBCrK0EpHcJ4m1/nQV
	mXfst4QqoPOaaoka2iaRw=; b=cAayvBnLrqk5rnfM+XXAj2wgIm+N8OmGsyK6EI
	iP7zmEccBED1kgWUKz5p00+ogHnuHEAfNggVaNP/Wnmq+gVQnoq8v9/b8dDdcJXV
	kshYYKFk9FGYzrmTkSaw549Hvh2P6WD6500VNzJffwo4UqxVAy+jwPrVGK7vUyb/
	eW/C0zM6sg2jJ6Yev6lxjqOSnUxmXeQ3rsjsXUZdJ5R23jTGyF0zyRqRWI8b44aF
	ckNXkaqdc1L3TesRpBEsMfmDzXqlD0Hh7SXrLXaWsGGV9FWf4SRGxBq8Um3AudtY
	S5GDg/aOckJqEiBRpUwsvypY/Us/kRGitnzCh1AB+eOdLlCw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yesw5hmj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 02:40:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V2eBeP019630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 02:40:11 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 30 May 2024 19:40:10 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix ACPI warning when resume
Date: Fri, 31 May 2024 10:40:00 +0800
Message-ID: <20240531024000.9291-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: XlvVy4vUr7IVBBvdQlKV3N0gkxPjJkEy
X-Proofpoint-GUID: XlvVy4vUr7IVBBvdQlKV3N0gkxPjJkEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310019

Currently ACPI notification handler is installed when driver loads and only
gets removed when driver unloads. During resume after firmware is reloaded,
ath12k tries to install it by default. Since it is installed already, ACPI
subsystem rejects it and returns an error:

[   83.094206] ath12k_pci 0000:03:00.0: failed to install DSM notify callback: 7

Fix it by removing that handler when going to suspend. This also avoid any
possible ACPI call to firmware before firmware is reloaded/reinitialized.

Note ab->acpi also needs to be cleared in ath12k_acpi_stop() such that we
are in a clean state when ACPI structures are reinitialized in
ath12k_acpi_start().

Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 576771c9fa21 ("wifi: ath12k: ACPI TAS support")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/acpi.c | 2 ++
 drivers/net/wireless/ath/ath12k/core.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/acpi.c b/drivers/net/wireless/ath/ath12k/acpi.c
index 443ba12e01f3..0555d35aab47 100644
--- a/drivers/net/wireless/ath/ath12k/acpi.c
+++ b/drivers/net/wireless/ath/ath12k/acpi.c
@@ -391,4 +391,6 @@ void ath12k_acpi_stop(struct ath12k_base *ab)
 	acpi_remove_notify_handler(ACPI_HANDLE(ab->dev),
 				   ACPI_DEVICE_NOTIFY,
 				   ath12k_acpi_dsm_notify);
+
+	memset(&ab->acpi, 0, sizeof(ab->acpi));
 }
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index e7f628e935e4..92f442f8e03a 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -83,6 +83,8 @@ int ath12k_core_suspend_late(struct ath12k_base *ab)
 	if (!ab->hw_params->supports_suspend)
 		return -EOPNOTSUPP;
 
+	ath12k_acpi_stop(ab);
+
 	ath12k_hif_irq_disable(ab);
 	ath12k_hif_ce_irq_disable(ab);
 

base-commit: 6e7a5c6d5e38b93f9cc3289d66a597b9a4ca0403
-- 
2.25.1



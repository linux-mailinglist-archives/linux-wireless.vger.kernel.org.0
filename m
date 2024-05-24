Return-Path: <linux-wireless+bounces-8035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F28CDF87
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 04:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8C428242F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A1D21103;
	Fri, 24 May 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RLUiM60i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780D1E884
	for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716518222; cv=none; b=E91IIhcF6dchsh9LUopUyfx2LtTlKmg9lcFcU+RmQeUWm3vqEUMxq5XZOkjDVLXsnfePvVc26Jft5pThenPVIVfrPgCPdEaS+wISNxXJcsThZknOX+DI4KlizeRaTxw1Hy3Hc6dQE8ruT6jr1Zl6bPQ860C3lswIoaaHev+GCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716518222; c=relaxed/simple;
	bh=IwqiY/Y3wc5WHlVA9Lk6ehoqfM0XO9oZViinhKRPEtU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ri6nyD9cqZPfHSAGQi0KUJpeKAwcNxD1cwSge6dTOBcGzbVAvLYf6rAr8Ol+0Q8Yh+CTvsNmPlrReB/NJ1j08pJOkC8xr2fOeLVCKOjp5jncvHjF3MI7MMt6X9uXUuwm26452q4fMqsiRq5RAvbwEypRnSGh8Vddkd9R6lSjnd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RLUiM60i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NNQks3023667;
	Fri, 24 May 2024 02:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uQn+T/EMfzff9DRLEGG4a3
	XpLdiQQhF+wEH1ZsZ0KeQ=; b=RLUiM60is82iR1WPYuQgu+nkeOManpeVeU5nge
	ZImEP/a+G+94g6lT0MaLrodXq8qGtkmyBo96/06Ckdb2sQGNJtdypqn9kW9KGqIT
	HGKBNZo92rmyffLaG/e9hY0R7fwPWsewTeDZCz7l3yaN3mvdTNDaOFq/eNDaZMLG
	5k7+mTK8Q1tQ33qV5Jnkc9I6dVVPi5fPlPMAaBbQYF9IYwDCZpYQ4dl9mqZKRIPz
	nBPWmWjIjmAZgXoowo3GZ7FiaBxV+jXuG3W2ORfUXkqUw7sQff5s3+TlDgLY2oX5
	KFjJTJmffa4owzM2yZsFkIA97Rf83vkHSvPNt3gQJzXjYk7g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa9u0xv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 02:36:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44O2aqcu030545
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 02:36:52 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 May 2024 19:36:50 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix race due to setting ATH12K_FLAG_EXT_IRQ_ENABLED too early
Date: Fri, 24 May 2024 10:36:42 +0800
Message-ID: <20240524023642.37030-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: pKBQiQfpHmABER4iKJVZTm4_SbzbrsAX
X-Proofpoint-ORIG-GUID: pKBQiQfpHmABER4iKJVZTm4_SbzbrsAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=654 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240017

Commit 5082b3e3027e ("wifi: ath11k: fix race due to setting
ATH11K_FLAG_EXT_IRQ_ENABLED too early") fixes a race in ath11k
driver. Since ath12k shares the same logic as ath11k, currently
the race also exists in ath12k: in ath12k_pci_ext_irq_enable(),
ATH12K_FLAG_EXT_IRQ_ENABLED is set before NAPI is enabled.
In cases where only one MSI vector is allocated, this results
in a race condition: after ATH12K_FLAG_EXT_IRQ_ENABLED is set
but before NAPI enabled, CE interrupt breaks in. Since IRQ is
shared by CE and data path, ath12k_pci_ext_interrupt_handler()
is also called where we call disable_irq_nosync() to disable
IRQ. Then napi_schedule() is called but it does nothing because
NAPI is not enabled at that time, meaning that
ath12k_pci_ext_grp_napi_poll() will never run, so we have
no chance to call enable_irq() to enable IRQ back. Since IRQ
is shared, all interrupts are disabled and we would finally
get no response from target.

So port ath11k fix here, this is done by setting
ATH12K_FLAG_EXT_IRQ_ENABLED after all NAPI and IRQ work are
done. With the fix, we are sure that by the time
ATH12K_FLAG_EXT_IRQ_ENABLED is set, NAPI is enabled.

Note that the fix above also introduce some side effects:
if ath12k_pci_ext_interrupt_handler() breaks in after NAPI
enabled but before ATH12K_FLAG_EXT_IRQ_ENABLED set, nothing
will be done by the handler this time, the work will be
postponed till the next time the IRQ fires.

This is found during code review.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index ac75e8e3916b..11b95d037051 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1107,14 +1107,14 @@ void ath12k_pci_ext_irq_enable(struct ath12k_base *ab)
 {
 	int i;
 
-	set_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
-
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
 		napi_enable(&irq_grp->napi);
 		ath12k_pci_ext_grp_enable(irq_grp);
 	}
+
+	set_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
 }
 
 void ath12k_pci_ext_irq_disable(struct ath12k_base *ab)

base-commit: fae0804439b5833308ab7d8563c643edb0fa174c
-- 
2.25.1



Return-Path: <linux-wireless+bounces-6800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20AD8B18CE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 04:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9121C217B9
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 02:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2EAD2D;
	Thu, 25 Apr 2024 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TI2/rnlN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320984C89
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714011486; cv=none; b=Y5If/dVJnWrJs2qLHKOL43dCYR55MKl0J7aoi2Zt95qgg3lFcAhRVxjyvq1WX4SVqApNLysCKWLFwoXSkOvnBGcLzW3rrjWyztmarMl/q+LP8gyIG3Mnm6MDLQgY6AMLjyTKbZNLOU9U/oQWS61C+odXH8vG58NKmoJ4C0KJDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714011486; c=relaxed/simple;
	bh=9LNzf7L9KE4ZLhTknlIQC8GzXqW2mMf9xTIzR6KctDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V9KmnK065phIUgF9fHwKnG1cwKKW2lyieACi13KnyxKSUTq/4YIvr7Kvupw9lB8R87pQpqnNPuT8cRE3Vw+hk0NwzNvCr+LaDUyjrClQH9vnI2VbJajYfVSJo0NtnTYC/wV5Efn1XpiLq5Xo3lIgwFGhfa4lci3wsgWK0VoIPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TI2/rnlN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P0ptm5023461;
	Thu, 25 Apr 2024 02:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=H8ALftP
	QXLRH0ze9zCdPkHlsjFM3UteZjyxWml5x9rU=; b=TI2/rnlNQ+06LV4uE9VRXUn
	4byrZjV9/hCEIrFvAfK+zPhEYp+X3tebpUQnUG8y1LMTuemmDqN8lBWsxBCxHdmN
	+F33HqFcApJJo513BXBLuYWqpa1vZ/VzgzuIxUKqfsq5/GL8kVXHYokjeytpo23u
	RKopEDBO6tE7tnZxYrwETU5+lk/8/YwOLkFNrb8CcGc5Cfu2ytiobn1XgpyAXcoq
	wG6yDKE+GJOHBoI0TaTdJtsZbnBMXiWfbfsod9I9/jWI0JOX8DMyPYQk66iDllol
	uvYxmdVpcmmZX8OrcPl5r6ujLxJK+MATVIRxwIWR6xCg409sBSKp7/rfri5zUcA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xq893rkrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 02:17:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P2Hpah007355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 02:17:51 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 19:17:50 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: check M3 buffer size as well whey trying to reuse it
Date: Thu, 25 Apr 2024 10:17:40 +0800
Message-ID: <20240425021740.29221-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: 9F7_vopMMsCZg5R1U_iquw1oCBwGzPv1
X-Proofpoint-ORIG-GUID: 9F7_vopMMsCZg5R1U_iquw1oCBwGzPv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_01,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250015

Currently in recovery/resume cases, we do not free M3 buffer but
instead will reuse it. This is done by checking m3_mem->vaddr: if it
is not NULL we believe M3 buffer is ready and go ahead to reuse it.

Note that m3_mem->size is not checked. This is safe for now because
currently M3 reuse logic only gets executed in recovery/resume cases
and the size keeps unchanged in either of them.

However ideally the size should be checked as well, to make the code
safer. So add the check there. Now if that check fails, free old M3
buffer and reallocate a new one.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: 303c017821d8 ("wifi: ath12k: fix kernel crash during resume")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 36 ++++++++++++++++-----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index ebb20fc8e3ba..5484112859a6 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2717,6 +2717,19 @@ static int ath12k_qmi_load_bdf_qmi(struct ath12k_base *ab,
 	return ret;
 }
 
+static void ath12k_qmi_m3_free(struct ath12k_base *ab)
+{
+	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
+
+	if (!m3_mem->vaddr)
+		return;
+
+	dma_free_coherent(ab->dev, m3_mem->size,
+			  m3_mem->vaddr, m3_mem->paddr);
+	m3_mem->vaddr = NULL;
+	m3_mem->size = 0;
+}
+
 static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
@@ -2747,8 +2760,14 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 		m3_len = fw->size;
 	}
 
-	if (m3_mem->vaddr)
-		goto skip_m3_alloc;
+	/* In recovery/resume cases, M3 buffer is not freed, try to reuse that */
+	if (m3_mem->vaddr) {
+		if (m3_mem->size >= m3_len)
+			goto skip_m3_alloc;
+
+		/* Old buffer is too small, free and reallocate */
+		ath12k_qmi_m3_free(ab);
+	}
 
 	m3_mem->vaddr = dma_alloc_coherent(ab->dev,
 					   m3_len, &m3_mem->paddr,
@@ -2772,19 +2791,6 @@ static int ath12k_qmi_m3_load(struct ath12k_base *ab)
 	return ret;
 }
 
-static void ath12k_qmi_m3_free(struct ath12k_base *ab)
-{
-	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
-
-	if (!m3_mem->vaddr)
-		return;
-
-	dma_free_coherent(ab->dev, m3_mem->size,
-			  m3_mem->vaddr, m3_mem->paddr);
-	m3_mem->vaddr = NULL;
-	m3_mem->size = 0;
-}
-
 static int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;

base-commit: 326f8f68f28b0b831233acfabffb486a5b0f4717
-- 
2.25.1



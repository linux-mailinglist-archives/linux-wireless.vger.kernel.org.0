Return-Path: <linux-wireless+bounces-21122-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A018A7A09E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 12:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C020E7A3BF3
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBCE224891;
	Thu,  3 Apr 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YmpXCYSv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17903C0B;
	Thu,  3 Apr 2025 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674700; cv=none; b=e1+ROevHt6P1MJakutE1sc2EUbO/m7oQXu9kU31RiviFzA4d9PM3J7k16Kejq0K5gL8VEUI0oEs442oXgs2M+ZueLoXRiNrNW7P+ZOdg5orCVvY/UHfUFxl/pbSOVjywFwFfoho6tWLJXXqIL/jNG/144837ssDydc9zrdJup3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674700; c=relaxed/simple;
	bh=6TPulnYtAiORK9jNRV3kKjVicMssQCkIc+220wQrMvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jcMQ1F4HG/PQ8i58lOrmYPe0DeW7nvSz0o8UaO3gVcBJ+rq2gXpBdrZm7eU9HDNWxWfqVqLfkx1jM3fPu2WuJWqZuGs1QIBhBLmyky9Q/mlarIT75TS8Ym7G8MOtbNE/n9MuqbqMBCdqc9Stwrh/YI9W7huDjRAXy7EOkseMSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YmpXCYSv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5339s17g013669;
	Thu, 3 Apr 2025 10:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vD9hWD4n2aJM0+NpJoWfA+
	3ijVJmtaSWO2xbxMunyMo=; b=YmpXCYSvXkXdZnUjBWX3P409XXwpA0EGWj/ISy
	Gh7KnBp+hAZ1iqx9/JhZpiTNXxKWIOMUbgGfJOTQN+9RO7rbl4XhSdxbSoZzvYes
	6wJMI4VMbFECPNthBz3OHDD+VeZAiJSq9uhanHYXWEY0dsltUQIUEeY+W9arVl+D
	zWRhyubm8rhQvHuy0zxwe69q/EZ6ooPe/mKWRiBxuPdTpA7zmnh5pA86yiRDVMGr
	juqiqY/4BIja8Xu1AAsnbeZ/ITEc8BVb58ZC+gRii84/4CqAza83NM4wL9ZIEoyP
	C/j8A6I6xrZhu1HnGN4PQHJWOzzTa860OyQM6xJ0ziQ3DamQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45spnp0a1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 10:04:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 533A4mdI020500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Apr 2025 10:04:48 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 3 Apr 2025 03:04:45 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Date: Thu, 3 Apr 2025 15:34:29 +0530
Subject: [PATCH ath-next] wifi: ath12k: fix cleanup path after mhi init
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250403-ath12k-cleanup-v1-1-ad8f67b0e9cf@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAC1d7mcC/x2MSQqAMAwAvyI5G0jrcvAr4qGkUYNSpVURxL9bP
 A7MzANJokqCrnggyqVJt5DBlAXw7MIkqD4zWLIN1VShO2ZjF+RVXDh3tNy0TGSc8Qw52qOMev/
 DHrKLQe4Dhvf9AMGh3JdqAAAA
X-Change-ID: 20250403-ath12k-cleanup-2c56c001a1dc
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Kang Yang
	<quic_kangyang@quicinc.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d0EL3m6pxSUE0g61rW8D6xCndBoNlMc-
X-Authority-Analysis: v=2.4 cv=N/gpF39B c=1 sm=1 tr=0 ts=67ee5d41 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=hDZruuR0RIJL45ME4G0A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: d0EL3m6pxSUE0g61rW8D6xCndBoNlMc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_04,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030035

Currently, the 'err_pci_msi_free' label is misplaced, causing the cleanup
sequence to be incorrect. Fix this by moving the 'err_pci_msi_free' label
to the correct position after 'err_irq_affinity_cleanup'.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00209-QCAHKSWPL_SILICONZ-1

Fixes: a3012f206d07 ("wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector")
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 7f1bb150f326b317157f6721d990d61a27f38d6a..fcb9c40b227b7baaf49f6a590c495f47ca8d2f55 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1706,12 +1706,12 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 err_mhi_unregister:
 	ath12k_mhi_unregister(ab_pci);
 
-err_pci_msi_free:
-	ath12k_pci_msi_free(ab_pci);
-
 err_irq_affinity_cleanup:
 	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
 
+err_pci_msi_free:
+	ath12k_pci_msi_free(ab_pci);
+
 err_pci_free_region:
 	ath12k_pci_free_region(ab_pci);
 

---
base-commit: c0d45354abf5763f3de37d0c59fd863d193c7275
change-id: 20250403-ath12k-cleanup-2c56c001a1dc



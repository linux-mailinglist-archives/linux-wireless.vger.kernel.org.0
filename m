Return-Path: <linux-wireless+bounces-8252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B48D2BBC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 06:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD14286F33
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 04:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C28A55;
	Wed, 29 May 2024 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ExYIU4Ny"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28743ACC
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 04:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716957078; cv=none; b=R+NXNwNTteFfzwHcg0HeD0sDiW0+BBRGif/BSUTiI/H4RYZyOn+bJ2s47w7naQni8aoKooD+agVNgiZZ1w16L5200xA1vV8gEzX0+MNbnXrEJBJaMXtFTOUXPoQfSUiQUzphrT0nyf5y1iIVnuQ42QeF1S5VLMRoU/i73zMUA8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716957078; c=relaxed/simple;
	bh=VPiaJKpFXRmyw+k7gFGPS6fHHC0IhN2d0T09FhvbU28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1qG/iNAiioeGvH2WuMtvRFAqdza/NuLzelMWWjOc7A+sIEBdfVSO2eAGQFDo2YDkjL9BX2UvO7Wb8y+FUHua4f8nT8V62n7E9UVmUfkf17OCierp485hT8Q48K/0W2XBjpvys/fCwxQj/92FzaRaMVJurZK7xlC++uUryUxmr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ExYIU4Ny; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SLlh1b030864;
	Wed, 29 May 2024 04:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XqV/OMrOhbJVxSfLWE6KiaAMCXjZncyUMWZDNF36pVU=; b=ExYIU4NyygBgxL0m
	1q9hqnu7Whe4w3xloAbUlrSUR/sedl9eSvqiKDkxbZJdE1nqf+CFvAnY90+hTnNU
	NbNeyNVsFoC49BvHQ91Y/MQWtXCrHITfBXK7NXH+X/SisDtGH0cxMge46oF/CrNG
	DikA6+sofmDQKnX+2z38W0XUcQ2o7nEMZDkqdOb2ZztFzXxDyJ1gHIrkE+t3rFdt
	JXvT4DZTAsAOZfCwxsVCB2Q628T+j7jG6yUl1k3fTMuzI0gQnQVOnuoSZ9qVQbLn
	Xo27TbRKYKpObC2ksu055+l4m6rmrCvocv/dwPsbsKPkcOb17SboaUvplztJxhXu
	TPdQFA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2pr1u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 04:31:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44T4V9s9010670
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 04:31:09 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 21:31:08 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 2/3] wifi: ath12k: unregister per pdev debugfs
Date: Wed, 29 May 2024 10:00:42 +0530
Message-ID: <20240529043043.2488031-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529043043.2488031-1-quic_adisi@quicinc.com>
References: <20240529043043.2488031-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: lcm4Dvgl27ZMcn_LGpLw63P_lpesYe6j
X-Proofpoint-ORIG-GUID: lcm4Dvgl27ZMcn_LGpLw63P_lpesYe6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=992
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290025

During normal de-initialization path or if any error happens while
registering the hardware, there is no support to unregister the per pdev
debugfs. Add support for the same.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/debugfs.c | 10 ++++++++++
 drivers/net/wireless/ath/ath12k/debugfs.h |  6 +++++-
 drivers/net/wireless/ath/ath12k/mac.c     |  7 ++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 8d8ba951093b..3b464cd40da6 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -88,3 +88,13 @@ void ath12k_debugfs_register(struct ath12k *ar)
 				    &fops_simulate_radar);
 	}
 }
+
+void ath12k_debugfs_unregister(struct ath12k *ar)
+{
+	if (!ar->debug.debugfs_pdev)
+		return;
+
+	/* TODO: Remove symlink under ieee80211/phy* */
+	debugfs_remove_recursive(ar->debug.debugfs_pdev);
+	ar->debug.debugfs_pdev = NULL;
+}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index a62f2a550b23..8d64ba03aa9a 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -11,7 +11,7 @@
 void ath12k_debugfs_soc_create(struct ath12k_base *ab);
 void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
 void ath12k_debugfs_register(struct ath12k *ar);
-
+void ath12k_debugfs_unregister(struct ath12k *ar);
 #else
 static inline void ath12k_debugfs_soc_create(struct ath12k_base *ab)
 {
@@ -25,6 +25,10 @@ static inline void ath12k_debugfs_register(struct ath12k *ar)
 {
 }
 
+static inline void ath12k_debugfs_unregister(struct ath12k *ar)
+{
+}
+
 #endif /* CONFIG_ATH12K_DEBUGFS */
 
 #endif /* _ATH12K_DEBUGFS_H_ */
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index beec42d4ec24..381fee8ca748 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8836,8 +8836,10 @@ static void ath12k_mac_hw_unregister(struct ath12k_hw *ah)
 	struct ath12k *ar;
 	int i;
 
-	for_each_ar(ah, ar, i)
+	for_each_ar(ah, ar, i) {
 		cancel_work_sync(&ar->regd_update_work);
+		ath12k_debugfs_unregister(ar);
+	}
 
 	ieee80211_unregister_hw(hw);
 
@@ -9084,6 +9086,9 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	return 0;
 
 err_unregister_hw:
+	for_each_ar(ah, ar, i)
+		ath12k_debugfs_unregister(ar);
+
 	ieee80211_unregister_hw(hw);
 
 err_free_if_combs:
-- 
2.34.1



Return-Path: <linux-wireless+bounces-8253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8758D2BBD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 06:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A571B237A8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 04:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBF115B158;
	Wed, 29 May 2024 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lOh7WaxD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0613D899
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 04:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716957078; cv=none; b=iFuO+wn+6b/RftB4ODMs+YMEltDcMKlqZgwAOyZ7Ky8+zL80wSDjL9Vs04ANOrT28nY/tRuYlWHq32nOD56yYTMblUpPpgjsqO2CGFXUtxN9JlrHno+42wk8NgwdwFiNeX/smkahdIVPlftVeraWe/M/GZZhzgmejj0H7ev29KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716957078; c=relaxed/simple;
	bh=UmSIwMM8vYBUxnX8Kub7+tNBnqVlPwhVAnhMDN+CeZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkhN6O5liGkRjNrE199eVBuLHBXBVYLyhRuw1UuhUqZk3L9L/NPH6hQDewrYWl0ZbT5C9nAGI/l90uhyTZHE7hjwxEJmWQHP/GLXtcq0Kn0QwSLYI0/Uot/cy8LbfdJ0yXvybRfr6d2taYyKZNBTrLwqP/YoTvgznLihqDg4lN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lOh7WaxD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SMGtQu010169;
	Wed, 29 May 2024 04:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QhKvaLf+cz/0/SwEWuvLpjy1RgvayoIRI+//7DEZS38=; b=lOh7WaxDC8EHfqZ1
	R9qmDZBohZaAQloMSnqy+msV4uDD7CVOzO5IW5R0Y2qRD2zvXoo5OFqWOHmaofZm
	rbG/mJGfWRxAmdOLMdFVUWqfeFomHHjffEQ/qykcNkyM1n9FHNLKTv8KtR30C2IG
	0J+mae7BbYs/95vHpeFsV8JnEQejSE2/v3/6aSTx/dyqA19YIh9cJNyNJsN2jfhZ
	dPppCJ6JWf55RMlI8JFp/jWPLMtDbZD86QdyOhf+1arjzMuUvuAQY8Qad34R2Kuy
	hB4QlpUBKS1UMfOZ2Ox5IcLZs/lCn4gNXv+CMce26MuDMbgZ62zUE5dKmFoR4R6l
	PkBV4A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2myx5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 04:31:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44T4VCY4030593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 04:31:12 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 21:31:10 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: handle symlink cleanup for per pdev debugfs dentry
Date: Wed, 29 May 2024 10:00:43 +0530
Message-ID: <20240529043043.2488031-4-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: ozb3t9v81kMWpiU6DGDLSf_sJauKa4gP
X-Proofpoint-ORIG-GUID: ozb3t9v81kMWpiU6DGDLSf_sJauKa4gP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290025

Whenever per pdev debugfs directory is created, a symlink to it is also
placed in ieee80211/phy* directory. During clean up of per pdev debugfs,
this symlink also needs to be cleaned up.

Add changes to clean up the symlink whenever the per pdev debugfs is
removed.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h    | 1 +
 drivers/net/wireless/ath/ath12k/debugfs.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7d20b09c52e6..87cb3fde68c2 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -473,6 +473,7 @@ struct ath12k_fw_stats {
 
 struct ath12k_debug {
 	struct dentry *debugfs_pdev;
+	struct dentry *debugfs_pdev_symlink;
 };
 
 struct ath12k_per_peer_tx_stats {
diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
index 3b464cd40da6..751a9b04386a 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs.c
@@ -80,7 +80,9 @@ void ath12k_debugfs_register(struct ath12k *ar)
 
 	/* Create a symlink under ieee80211/phy* */
 	scnprintf(buf, sizeof(buf), "../../ath12k/%pd2", ar->debug.debugfs_pdev);
-	debugfs_create_symlink("ath12k", hw->wiphy->debugfsdir, buf);
+	ar->debug.debugfs_pdev_symlink = debugfs_create_symlink("ath12k",
+								hw->wiphy->debugfsdir,
+								buf);
 
 	if (ar->mac.sbands[NL80211_BAND_5GHZ].channels) {
 		debugfs_create_file("dfs_simulate_radar", 0200,
@@ -94,7 +96,9 @@ void ath12k_debugfs_unregister(struct ath12k *ar)
 	if (!ar->debug.debugfs_pdev)
 		return;
 
-	/* TODO: Remove symlink under ieee80211/phy* */
+	/* Remove symlink under ieee80211/phy* */
+	debugfs_remove(ar->debug.debugfs_pdev_symlink);
 	debugfs_remove_recursive(ar->debug.debugfs_pdev);
+	ar->debug.debugfs_pdev_symlink = NULL;
 	ar->debug.debugfs_pdev = NULL;
 }
-- 
2.34.1



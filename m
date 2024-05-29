Return-Path: <linux-wireless+bounces-8251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F051D8D2BBB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 06:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C491C21B39
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 04:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D036615B14E;
	Wed, 29 May 2024 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ALn8jDp6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35820311
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 04:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716957078; cv=none; b=mfHhDhGe7PheaLrUjhz/zbJjPIk2H5hAjULWodNaBcbvZH0Gwom3oGSDWOrsvI96PFfN+VcNYUBvgpFCX70mHeJvMXmIRQOoi6gqQt18N5O4pqKcPki+CqAh709ldbRFoU7qYH55Sxbz/Xw5LHJnoDACpsm07DHTQG04yeCzTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716957078; c=relaxed/simple;
	bh=TsbdgBIuXkaiYXuCGblAZt7F8d1QCaRIZ3qWNogR26E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzASM+d5f1nGtOSF27FMT1nNsYFqAlMQHZ9HZhTq/mGHk+59/0pMCrUvamCYmshjNG06dQ1LKUcsdZCTPdoKTlyRR67ggMSqIgnumCJnjyTprNmHtQ5vok0KDP6F7Wynph+bgP/umN1o/EAxgXKlEsUaDtAIollfAMTRVqcVCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ALn8jDp6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T0VGw0015671;
	Wed, 29 May 2024 04:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iN3HAAv6f7vBHYns3kVLpDsY7GbzgoD9/Rl7ps1uS+Q=; b=ALn8jDp60i7Az823
	f4KfKVkXBwBMAoZN+A0ZuJ1gudU2+df6FWVrCvtT+l6KXHyI3xOvHUhV8z0w0vgm
	VwKQ4164LkcbnbeFphYN/7k/O35jP9Sng/SPSPyhpQWyMqWqlBBuv9nnvCpx+Iiz
	X9Yf7dKYNV6GkVs5AhWh1Umi48so9NFrF/SB/WwHnzOaoPTDlWa5BTBPlwXD5bsS
	qXIsQAC52meHnphJA3ncoaxBktXgJvrBRxzUjJ6sedTs8rcSRJ/heEwSWGxzJhpO
	ZsSvmyjSXeDJfBHo/h0z/Yk+XGuTj85wNkWgdoa4dqMQT1vaKM+oy+IgoNLcktya
	QefBng==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yj81ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 04:31:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44T4V8lU030539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 04:31:08 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 21:31:06 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 1/3] wifi: ath12k: fix per pdev debugfs registration
Date: Wed, 29 May 2024 10:00:41 +0530
Message-ID: <20240529043043.2488031-2-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: r0M6-jbi88Lct5DEgkLPJO84FcKuOGy9
X-Proofpoint-ORIG-GUID: r0M6-jbi88Lct5DEgkLPJO84FcKuOGy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290025

Function ath12k_debugfs_register() is called once inside the function
ath12k_mac_hw_register(). However, with single wiphy model, there could
be multiple pdevs registered under single hardware. Hence, need to register
debugfs for each one of them.

Move the caller inside the loop which iterates over all underlying pdevs.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: f8bde02a26b9 ("wifi: ath12k: initial debugfs support")
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 784964ae03ec..beec42d4ec24 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9077,9 +9077,9 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 			ath12k_err(ar->ab, "ath12k regd update failed: %d\n", ret);
 			goto err_unregister_hw;
 		}
-	}
 
-	ath12k_debugfs_register(ar);
+		ath12k_debugfs_register(ar);
+	}
 
 	return 0;
 
-- 
2.34.1



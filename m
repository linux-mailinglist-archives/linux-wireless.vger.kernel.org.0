Return-Path: <linux-wireless+bounces-5963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8359B89B6B1
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 06:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C920281335
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 04:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34DF8827;
	Mon,  8 Apr 2024 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q+Vn4h+n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F97470
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712549172; cv=none; b=m+D6v/i2rrRAV2yAEjpLwYKJTuljKFPzinPW7C3RuA/emSmLSUKDjI4h9xZTRRCRhJccyeWxLCNPGuOB3rSAB3fVvfpKHWZPI5h35+8kw6SR4KkbBhWXtW72IAwpPGRNHE2FIcdT8yrWmtiy3iFXIrzaCk70hPQeGVp2kaVqglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712549172; c=relaxed/simple;
	bh=XyRSnU1soOB4PwvvVHJImCES4hSseYMgjuXEHsgH+/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhAqYdSnq6LWbAFd+eAp43akuREPkmkjaRdy3Fr/7/81o2lvCF4IVg7R+EBhYM1+Q45ZbKSEfbAuWk3vH6e+nN8WE/S0vNXJvv7uTrpxWDiNPak/TVh2/OyZNA/wE6qqK5M09DlWgabW7ih+9gOG3Scq85/yJvtDTglzMR8ogRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q+Vn4h+n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4381urCE011166;
	Mon, 8 Apr 2024 04:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=rHBV247EuHATE0zFQjuvlztrdxonKSO4FBN2eFp4Wmo=; b=Q+
	Vn4h+nIqGcVtrvc6Qpk3SGEgh586FOOgFC0+1t9gpQveHN1dC+7ji6fXpqi9FY0J
	fNzHmFYS/LoAuyVJDwb67mxKDWfgrEOtWvoqzXiGyPQD2v7EYDgkovsK0eDzo6pk
	SzVSgdBZAXOEyIQxO1woCIIF5nddlimRZqp/E6RFUDRor6RBUSP5V24zLjaz8lxW
	wZ+F5BXSkoRFI9PzuOAACw5BMWB4e0VHDJxNk4Yww9TP+0QG/zjg//cZOn7NRam6
	My39DgrP6qN/Cj5VcSG5EfT5qKoZrxGo6tfbz3aWZeSK1oJvMLkn+1T66PbDuQpK
	d8vMsNf0CtgNj90Xm7Aw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaypdajuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 04:06:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438468AW025115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 04:06:08 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Apr 2024 21:06:06 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 3/4] wifi: ath12k: displace the Tx and Rx descriptor in cookie conversion table
Date: Mon, 8 Apr 2024 09:35:46 +0530
Message-ID: <20240408040547.837639-4-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408040547.837639-1-quic_periyasa@quicinc.com>
References: <20240408040547.837639-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: tSStcAqYig14nK4a7OzE57CEna6qygQQ
X-Proofpoint-ORIG-GUID: tSStcAqYig14nK4a7OzE57CEna6qygQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=579
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404080029

In the hardware cookie conversion table configuration, place the Rx
descriptor at the end. This will allow for easier addition of partner
device Rx descriptors in the future to support multi-device MLO.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 57aba97cbdce..5cf0d21ef184 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -223,8 +223,8 @@ struct ath12k_pdev_dp {
 #define ATH12K_NUM_TX_SPT_PAGES	(ATH12K_TX_SPT_PAGES_PER_POOL * ATH12K_HW_MAX_QUEUES)
 #define ATH12K_NUM_SPT_PAGES	(ATH12K_NUM_RX_SPT_PAGES + ATH12K_NUM_TX_SPT_PAGES)
 
-#define ATH12K_TX_SPT_PAGE_OFFSET ATH12K_NUM_RX_SPT_PAGES
-#define ATH12K_RX_SPT_PAGE_OFFSET 0
+#define ATH12K_TX_SPT_PAGE_OFFSET 0
+#define ATH12K_RX_SPT_PAGE_OFFSET ATH12K_NUM_TX_SPT_PAGES
 
 /* The SPT pages are divided for RX and TX, first block for RX
  * and remaining for TX
-- 
2.34.1



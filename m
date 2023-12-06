Return-Path: <linux-wireless+bounces-451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B638065D4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 04:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CDB2820BE
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 03:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5198BD528;
	Wed,  6 Dec 2023 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f9IiPKSj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9F51B9
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 19:49:47 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B61gIrr009539;
	Wed, 6 Dec 2023 03:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=tOb0i94BXrphYlWkVqGJbav+T8VJNdzoLbiXPs7lrwA=;
 b=f9IiPKSjeoqu24P07MJqXJuVfQX5poj7ahZqtpioPEkXO6e40oSN+NhklQYp0aq8aeaT
 YvNN5plsQOglIH9h1HP4t1D/uiiPo6+P1lGHOj3TWoYzzbkdmO+nRazpaZFoVpuxaZK4
 AO5mqrzmH9M9iIDcsmBKV/KtuHWyNXky4P62eul+jY9j2OJXTY4kj3fRxgjPl6YsJysT
 cY3g/sV7GEkYaIafpfm5ZPehKvfik8JCU4WEgFo4ApIcl79ei/kYoEF0k1XU/8opR/jF
 MAw6fXerwccNdCOBaBFxmexFKdeuWsYESj8lQH6vPh2KWr099kbxwaT9hJhxLakuYeRw oQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utddjrehf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 03:49:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B63ngnj000822
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Dec 2023 03:49:42 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 19:49:41 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 1/4] wifi: ath12k: Refactor the DP pdev pre alloc call sequence
Date: Wed, 6 Dec 2023 09:19:17 +0530
Message-ID: <20231206034920.1037449-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: q35iMVU68DYXvXc_fPljYu4NWKTCY5c5
X-Proofpoint-GUID: q35iMVU68DYXvXc_fPljYu4NWKTCY5c5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=789 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060031

Currently, the data path pdev pre alloc and mac allocate are called
separately from the core start procedure. The data path pdev pre alloc
can be called from the mac allocate procedure itself since initialization
related to pdev happens in the mac allocate procedure. So move the caller
of DP pdev pre alloc from the core start procedure to the mac allocate
procedure. This change helps in the future to easily decouple the mac
allocate procedure from core start handling in order to support MLO in
multi chip.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 2 --
 drivers/net/wireless/ath/ath12k/mac.c  | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 6c01b282fcd3..6f634b57dde8 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -592,8 +592,6 @@ static int ath12k_core_start(struct ath12k_base *ab,
 
 	ath12k_dp_cc_config(ab);
 
-	ath12k_dp_pdev_pre_alloc(ab);
-
 	ret = ath12k_dp_rx_pdev_reo_setup(ab);
 	if (ret) {
 		ath12k_err(ab, "failed to initialize reo destination rings: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88cec54c6c2e..49d56f5d8896 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7667,6 +7667,8 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
 		clear_bit(ATH12K_FLAG_MONITOR_ENABLED, &ar->monitor_flags);
 	}
 
+	ath12k_dp_pdev_pre_alloc(ab);
+
 	return 0;
 
 err_free_mac:
-- 
2.34.1



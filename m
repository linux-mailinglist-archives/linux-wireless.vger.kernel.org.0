Return-Path: <linux-wireless+bounces-141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC007FB03F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 03:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D235BB2127B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 02:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3986FBA;
	Tue, 28 Nov 2023 02:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e512bmAU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D5BD
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 18:55:03 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS0NTvF019760;
	Tue, 28 Nov 2023 02:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=rIW3Rw3NKTsnVifloDxgmuLkl37xQyfmBmHOLPHTjzg=;
 b=e512bmAUl4bRzGYYbMlfUyXcrTX7guFvMWH2QTqyWlpPYDDSZ5S0wwzGenT4bD4MLiOk
 PN5JRgJDCi3PRVqF5eriSU3D8MXLQW+jcdkerQ2uy3wVGlGyqVQbUpc3XgYYqP+9vxDl
 HO1YcAcj4mw8HzUGhV7JgzsDukzKv4StcMobo3B4bFmdqhcF6B0HH0SXhtLjPB2tJ9vw
 yqtlFPshDpEO/yVe2FTnyRNqpNut2H96YPwaum3OCwqYpds/dW+AHF/1R+REec36ZvL4
 /DgG31aA9cAaJw4/YL1PV3yH/5klpwZWfNkxQSzXft3ZLdoX6vNi8GNTXUk4vpzfm2er nQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umt6323ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 02:54:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS2suE2019618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 02:54:56 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 18:54:55 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
Date: Tue, 28 Nov 2023 10:54:38 +0800
Message-ID: <20231128025440.46988-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128025440.46988-1-quic_bqiang@quicinc.com>
References: <20231128025440.46988-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: YaEMebpBWvRJfpnMj0SWXVfX21c7HI0l
X-Proofpoint-ORIG-GUID: YaEMebpBWvRJfpnMj0SWXVfX21c7HI0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_01,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=737 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280021

Some fields of hal_reo_update_rx_queue structure are wrongly
defined, so fix it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal_desc.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 6c17adc6d60b..ec204939e50c 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -2500,13 +2500,13 @@ struct hal_rx_reo_queue {
 #define HAL_REO_UPD_RX_QUEUE_INFO1_PN_HANDLE_ENABLE		BIT(30)
 #define HAL_REO_UPD_RX_QUEUE_INFO1_IGNORE_AMPDU_FLG		BIT(31)
 
-#define HAL_REO_UPD_RX_QUEUE_INFO2_BA_WINDOW_SIZE		GENMASK(7, 0)
-#define HAL_REO_UPD_RX_QUEUE_INFO2_PN_SIZE			GENMASK(9, 8)
-#define HAL_REO_UPD_RX_QUEUE_INFO2_SVLD				BIT(10)
-#define HAL_REO_UPD_RX_QUEUE_INFO2_SSN				GENMASK(22, 11)
-#define HAL_REO_UPD_RX_QUEUE_INFO2_SEQ_2K_ERR			BIT(23)
-#define HAL_REO_UPD_RX_QUEUE_INFO2_PN_ERR			BIT(24)
-#define HAL_REO_UPD_RX_QUEUE_INFO2_PN_VALID			BIT(25)
+#define HAL_REO_UPD_RX_QUEUE_INFO2_BA_WINDOW_SIZE		GENMASK(9, 0)
+#define HAL_REO_UPD_RX_QUEUE_INFO2_PN_SIZE			GENMASK(11, 10)
+#define HAL_REO_UPD_RX_QUEUE_INFO2_SVLD				BIT(12)
+#define HAL_REO_UPD_RX_QUEUE_INFO2_SSN				GENMASK(24, 13)
+#define HAL_REO_UPD_RX_QUEUE_INFO2_SEQ_2K_ERR			BIT(25)
+#define HAL_REO_UPD_RX_QUEUE_INFO2_PN_ERR			BIT(26)
+#define HAL_REO_UPD_RX_QUEUE_INFO2_PN_VALID			BIT(27)
 
 struct hal_reo_update_rx_queue {
 	struct hal_reo_cmd_hdr cmd;
-- 
2.25.1



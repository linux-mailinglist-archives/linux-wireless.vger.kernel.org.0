Return-Path: <linux-wireless+bounces-27703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE1BA9201
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 13:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881CC188216E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0B126B77B;
	Mon, 29 Sep 2025 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YoxOdE9p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B8305051
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146692; cv=none; b=bA+STG44Fm9Us2o/NcIKvRR/76SxGr8yumz4+gdbJ8KSraYepXxmGLVIcif0O1m3kClLngCzH7EtmSc9O2jU/MS5iLO86zZupWTvvSy7pGD9oveYjgX5F7/THfnww2Osch6achfTn3iiNmYkIsrXei/g5YURqrMbLQ+ZEzKFXn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146692; c=relaxed/simple;
	bh=CDyI17FTmGGcSAatFjXLDhz4UVMJZbicHRSODF8iyJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pziVv0KxGKvWsXh1/7lYv4NM3iVBEN7O5bVgWi3x8O+qMUkV81jykgMOiaz3891CqMKR7wFpkHuk3KTZOLeDyxcSK1HT47vkWKFLv3cjr0FngmE91asDMG+RczMN/eAIxstuSkr/NuTk2Ra3K5UFrRmZoC8IYtP9Fi3t88iFPO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YoxOdE9p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T9ef6U024781;
	Mon, 29 Sep 2025 11:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yln7dO4iJNJGxI8za3vnDZvBr8+fJN+1cFdtJzHRshY=; b=YoxOdE9pIX3u5d8I
	DVFm9PD+ogFlu//YLyPdWcGQhrpuvkvYqQrpb2Se03kZQrV9g7RXYEO5Lq2Cvlka
	WpFtZKWisvTYJFZEF3t3HsUhBErfGXWpm+dTnLHY+ovP2YHHGM5xUQqtGzCnp/22
	9NTTYfLp91HnXib649goflVsDN88fIBMfyPKiBBAP9TlE4FlsT5QSnd3wMmo+/u3
	9y9ONxRjwkjseKLFCsC3RM7COaSJ+P8lYOcXCbzQ3SJcfgxk+uNC7GEY+EgynGxi
	569HaJzQ1lgyJVSYWyliYqDcTP+id59E4hrod4ElD/ErfXdGU681iujV4fPsdlbf
	Jjx9Iw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e78fw316-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 11:51:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58TBpQQG008423
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 11:51:26 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Mon, 29 Sep 2025 04:51:25 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng v3 5/6] wifi: ath12k: Add framework for hardware specific DP interrupt handler
Date: Mon, 29 Sep 2025 17:21:01 +0530
Message-ID: <20250929115102.512719-6-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929115102.512719-1-quic_rdeuri@quicinc.com>
References: <20250929115102.512719-1-quic_rdeuri@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=DZAaa/tW c=1 sm=1 tr=0 ts=68da72bf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=qyWg75-0Mf4LNtTtF2YA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMiBTYWx0ZWRfX5CWu3HC7Wh+3
 DmXPpqS2oXhLwAIcB1FUU++CsoP+0fm4ojvOMjsEWjykvyDLvZAtnMZSQ4cQFNYSgyZoKhhQeb/
 MzoZNnletVrQHSthj/JoebONr2XxGSiEtXdSEnzHf9tOMMjSbDS6qMteejqtjDQOT5hl8aNIL8d
 wi/zoj0P5C+KnvwWlnJQt+0v+yBG0cb68Zap+F7PPHnTHs8zT3nc2RtnhxFrcWXFzesdzmw8oMD
 qjoWd/Y187riDY/vEZ6oNtpGylIlsx9osW+NjWsnM4TRhQ7Xw4a19t+HOij5IiYbVwcKiG71XaP
 CtMIhnTqbxV6Sp5JNFK3+Q7pMFL/uExhdjlaVlrikIFVQnl8351EETdaKhUaPYLpilOgBnhrN80
 19Envf3p7HpIV8ypir1RcCn02/7yDQ==
X-Proofpoint-GUID: AOAfIA0F_SUxXrX5_VT7GfDEGRqcytzt
X-Proofpoint-ORIG-GUID: AOAfIA0F_SUxXrX5_VT7GfDEGRqcytzt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270022

Currently, the DP service SRNG handler is invoked directly from the NAPI
poll handler, which prevents using different handlers for different
architectures. To fix this, introduce a DP architecture-ops table to
invoke architecture specific handler from NAPI poll handler. Future patches
will leverage this framework to invoke architecture-specific handlers from
common code.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/ahb.c      |  3 ++-
 drivers/net/wireless/ath/ath12k/dp.h       | 18 ++++++++++++++++++
 drivers/net/wireless/ath/ath12k/pci.c      |  3 ++-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c | 13 ++++++++++---
 drivers/net/wireless/ath/ath12k/wifi7/dp.h |  2 --
 5 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
index c545bea18935..7eb8dedaa947 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.c
+++ b/drivers/net/wireless/ath/ath12k/ahb.c
@@ -525,9 +525,10 @@ static int ath12k_ahb_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 						struct ath12k_ext_irq_grp,
 						napi);
 	struct ath12k_base *ab = irq_grp->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int work_done;
 
-	work_done = ath12k_wifi7_dp_service_srng(ab, irq_grp, budget);
+	work_done = ath12k_dp_service_srng(dp, irq_grp, budget);
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
 		ath12k_ahb_ext_grp_enable(irq_grp);
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 05f48b461774..546f73e46c41 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -367,6 +367,15 @@ struct ath12k_link_stats {
 	u32 tx_desc_type[HAL_TCL_DESC_TYPE_MAX];
 };
 
+/* DP arch ops to communicate from common module
+ * to arch specific module
+ */
+struct ath12k_dp_arch_ops {
+	int (*service_srng)(struct ath12k_dp *dp,
+			    struct ath12k_ext_irq_grp *irq_grp,
+			    int budget);
+};
+
 struct ath12k_dp {
 	struct ath12k_base *ab;
 	u32 mon_dest_ring_stuck_cnt;
@@ -430,6 +439,8 @@ struct ath12k_dp {
 
 	struct ath12k_hw_group *ag;
 	u8 device_id;
+
+	struct ath12k_dp_arch_ops *ops;
 };
 
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
@@ -444,6 +455,13 @@ ath12k_dp_hw_grp_to_dp(struct ath12k_dp_hw_group *dp_hw_grp, u8 device_id)
 	return dp_hw_grp->dp[device_id];
 }
 
+static inline int
+ath12k_dp_service_srng(struct ath12k_dp *dp, struct ath12k_ext_irq_grp *irq_grp,
+		       int budget)
+{
+	return dp->ops->service_srng(dp, irq_grp, budget);
+}
+
 void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif);
 void ath12k_dp_cc_config(struct ath12k_base *ab);
 void ath12k_dp_partner_cc_init(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 672cf2899681..6925abed190a 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -479,10 +479,11 @@ static int ath12k_pci_ext_grp_napi_poll(struct napi_struct *napi, int budget)
 						struct ath12k_ext_irq_grp,
 						napi);
 	struct ath12k_base *ab = irq_grp->ab;
+	struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
 	int work_done;
 	int i;
 
-	work_done = ath12k_wifi7_dp_service_srng(ab, irq_grp, budget);
+	work_done = ath12k_dp_service_srng(dp, irq_grp, budget);
 	if (work_done < budget) {
 		napi_complete_done(napi, work_done);
 		for (i = 0; i < irq_grp->num_irq; i++)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.c b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
index adc3480b282b..4465a9e93bf8 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.c
@@ -13,10 +13,11 @@
 #include "dp.h"
 #include "dp_tx.h"
 
-int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
-				 struct ath12k_ext_irq_grp *irq_grp,
-				 int budget)
+static int ath12k_wifi7_dp_service_srng(struct ath12k_dp *dp,
+					struct ath12k_ext_irq_grp *irq_grp,
+					int budget)
 {
+	struct ath12k_base *ab = dp->ab;
 	struct napi_struct *napi = &irq_grp->napi;
 	int grp_id = irq_grp->grp_id;
 	int work_done = 0;
@@ -134,6 +135,10 @@ int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
 	return tot_work_done;
 }
 
+static struct ath12k_dp_arch_ops ath12k_wifi7_dp_arch_ops = {
+	.service_srng = ath12k_wifi7_dp_service_srng,
+};
+
 /* TODO: remove export once this file is built with wifi7 ko */
 struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
 {
@@ -148,6 +153,8 @@ struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab)
 	dp->dev = ab->dev;
 	dp->hw_params = ab->hw_params;
 
+	dp->ops = &ath12k_wifi7_dp_arch_ops;
+
 	return dp;
 }
 EXPORT_SYMBOL(ath12k_wifi7_dp_device_alloc);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp.h b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
index 2300fda65786..72fdfb368c99 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp.h
@@ -13,8 +13,6 @@
 struct ath12k_base;
 struct ath12k_dp;
 
-int ath12k_wifi7_dp_service_srng(struct ath12k_base *ab,
-				 struct ath12k_ext_irq_grp *irq_grp, int budget);
 struct ath12k_dp *ath12k_wifi7_dp_device_alloc(struct ath12k_base *ab);
 void ath12k_wifi7_dp_device_free(struct ath12k_dp *dp);
 
-- 
2.34.1



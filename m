Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0E707DDD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 12:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjERKRf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjERKRL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 06:17:11 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6812D54
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 03:16:29 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I9MxTo026082;
        Thu, 18 May 2023 10:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rpmEIYxXCDxhhPomE9hejfykQvD6GzLywlaE+uZgHv0=;
 b=c2uiEjCpW1NBCey+dh0hZW+IWYPVNm96T17E2S95GTIucaOaWAfmlb5z5DxGFSV7ufdw
 lywXjL+ii01WvB9EyiIwdv/D2b+BXwg1ysWjJekOqzgq2PxUZP5kQ8xxuEfmR5Y/zcGV
 gzzamOHWWWtxa9souh5V+nf7HOBJh57ZB4wztWIbiihpVcQOm1fu82WWOxpTqq7OGhja
 nAK6lp/JCBlSbqp2tTs6nEcZfTclbRZ775DsQ42xQX1v7CRbmvKZmYCupWdIsMySl2g9
 cYrHkH4x6wS4Wrs5iJzPrM5NBGOBW/Tsj5Suvta22Z6S7emLi1pphdtXVCbP/9PoWWFP 3w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qned30eeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:16:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IAGAlt024356
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:16:10 GMT
Received: from hu-mpubbise-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 03:16:09 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 2/2] wifi: ath11k: Add coredump support of MSA region for WCN6750
Date:   Thu, 18 May 2023 15:45:46 +0530
Message-ID: <20230518101546.27998-3-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518101546.27998-1-quic_mpubbise@quicinc.com>
References: <20230518101546.27998-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wj8VnKiv9-6flzPi_elPSV70BBtrUBGO
X-Proofpoint-GUID: Wj8VnKiv9-6flzPi_elPSV70BBtrUBGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_07,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the context of WCN6750, MSA is a 12MB reserved memory region
entirely used by WCN6750 firmware for it's operation. This memory
carries useful information required to debug firmware/hardware
issues. Therefore add coredump support to dump MSA region during
firmware assert for WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c      | 127 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/ahb.h      |   8 +-
 drivers/net/wireless/ath/ath11k/coredump.c |  18 ++-
 3 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 5cbba9a8b6ba..e404466ab049 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -18,6 +18,8 @@
 #include "pcic.h"
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
+#include <linux/remoteproc/qcom_rproc.h>
+#include "coredump.h"
 
 static const struct of_device_id ath11k_ahb_of_match[] = {
 	/* TODO: Should we change the compatible string to something similar
@@ -935,6 +937,114 @@ static int ath11k_ahb_setup_resources(struct ath11k_base *ab)
 	return 0;
 }
 
+static void ath11k_ahb_coredump_msa(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	const struct ath11k_hw_mem_layout *mem_layout;
+	struct ath11k_fw_crash_data *crash_data;
+	const struct ath11k_mem_region *current_region;
+	struct ath11k_ramdump_hdr *hdr;
+	size_t buf_len;
+	u8 *buf;
+
+	mutex_lock(&ab->dump_mutex);
+
+	crash_data = ath11k_coredump_new(ab);
+	if (!crash_data)
+		goto out_unlock;
+
+	if (!crash_data->ramdump_buf)
+		goto out_unlock;
+
+	mem_layout = ath11k_coredump_get_mem_layout(ab);
+	if (!mem_layout)
+		goto out_unlock;
+
+	current_region = &mem_layout->region_table.regions[0];
+
+	buf = crash_data->ramdump_buf;
+	buf_len = crash_data->ramdump_buf_len;
+	memset(buf, 0, buf_len);
+
+	/* Reserve space for the header. */
+	hdr = (void *)buf;
+	buf += sizeof(*hdr);
+	buf_len -= sizeof(*hdr);
+
+	hdr->region_type = cpu_to_le32(current_region->type);
+	hdr->start = cpu_to_le64((u64)ab_ahb->fw.msa_vaddr);
+
+	if (current_region->len < ab_ahb->fw.msa_size) {
+		memcpy(buf, ab_ahb->fw.msa_vaddr, current_region->len);
+		hdr->length = cpu_to_le32(current_region->len);
+
+		ath11k_warn(ab, "msa dump length is less than msa size %x, %x\n",
+			    current_region->len, ab_ahb->fw.msa_size);
+	} else {
+		memcpy(buf, ab_ahb->fw.msa_vaddr, ab_ahb->fw.msa_size);
+		hdr->length = cpu_to_le32(ab_ahb->fw.msa_size);
+	}
+
+out_unlock:
+	mutex_unlock(&ab->dump_mutex);
+}
+
+static int ath11k_ahb_ssr_notifier(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct ath11k_ahb *ab_ahb = container_of(nb, struct ath11k_ahb, nb);
+	struct ath11k_base *ab = ab_ahb->ab;
+	struct qcom_ssr_notify_data *notify_data = data;
+
+	switch (action) {
+	case QCOM_SSR_BEFORE_POWERUP:
+		break;
+	case QCOM_SSR_AFTER_POWERUP:
+		break;
+	case QCOM_SSR_BEFORE_SHUTDOWN:
+		if (notify_data->crashed)
+			ath11k_ahb_coredump_msa(ab);
+		break;
+	case QCOM_SSR_AFTER_SHUTDOWN:
+		break;
+	default:
+		ath11k_err(ab, "received unrecognized event %lu\n", action);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int ath11k_ahb_register_ssr_notifier(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	void *notifier;
+	int ret;
+
+	ab_ahb->nb.notifier_call = ath11k_ahb_ssr_notifier;
+
+	notifier = qcom_register_ssr_notifier("wpss", &ab_ahb->nb);
+	if (IS_ERR(notifier)) {
+		ret = PTR_ERR(notifier);
+		ath11k_err(ab, "failed to initialize SSR notifier: %d\n", ret);
+		return ret;
+	}
+
+	ab_ahb->notifier = notifier;
+
+	return 0;
+}
+
+static void ath11k_ahb_unregister_ssr_notifier(struct ath11k_base *ab)
+{
+	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
+	int ret;
+
+	ret = qcom_unregister_ssr_notifier(ab_ahb->notifier, &ab_ahb->nb);
+	if (ret)
+		ath11k_err(ab, "error %d unregistering notifier\n", ret);
+}
+
 static int ath11k_ahb_setup_msa_resources(struct ath11k_base *ab)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
@@ -956,6 +1066,14 @@ static int ath11k_ahb_setup_msa_resources(struct ath11k_base *ab)
 
 	ab_ahb->fw.msa_paddr = r.start;
 	ab_ahb->fw.msa_size = resource_size(&r);
+	ab_ahb->fw.msa_vaddr = devm_memremap(dev, ab_ahb->fw.msa_paddr,
+					     ab_ahb->fw.msa_size,
+					     MEMREMAP_WB);
+	if (IS_ERR(ab_ahb->fw.msa_vaddr)) {
+		dev_err(dev, "failed to map memory region: %pa\n",
+			&r.start);
+		return PTR_ERR(ab_ahb->fw.msa_vaddr);
+	}
 
 	node = of_parse_phandle(dev->of_node, "memory-region", 1);
 	if (!node)
@@ -971,7 +1089,7 @@ static int ath11k_ahb_setup_msa_resources(struct ath11k_base *ab)
 	ab_ahb->fw.ce_paddr = r.start;
 	ab_ahb->fw.ce_size = resource_size(&r);
 
-	return 0;
+	return ath11k_ahb_register_ssr_notifier(ab);
 }
 
 static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
@@ -1087,6 +1205,8 @@ static int ath11k_ahb_fw_resource_deinit(struct ath11k_base *ab)
 	if (ab_ahb->fw.use_tz)
 		return 0;
 
+	ath11k_ahb_unregister_ssr_notifier(ab);
+
 	iommu = ab_ahb->fw.iommu_domain;
 
 	unmapped_size = iommu_unmap(iommu, ab_ahb->fw.msa_paddr, ab_ahb->fw.msa_size);
@@ -1110,6 +1230,7 @@ static int ath11k_ahb_fw_resource_deinit(struct ath11k_base *ab)
 static int ath11k_ahb_probe(struct platform_device *pdev)
 {
 	struct ath11k_base *ab;
+	struct ath11k_ahb *ab_ahb;
 	const struct of_device_id *of_id;
 	const struct ath11k_hif_ops *hif_ops;
 	const struct ath11k_pci_ops *pci_ops;
@@ -1156,6 +1277,8 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	ab->pdev = pdev;
 	ab->hw_rev = hw_rev;
 	platform_set_drvdata(pdev, ab);
+	ab_ahb = ath11k_ahb_priv(ab);
+	ab_ahb->ab = ab;
 
 	ret = ath11k_pcic_register_pci_ops(ab, pci_ops);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/ahb.h b/drivers/net/wireless/ath/ath11k/ahb.h
index 415ddfd26654..812d5aa8e87c 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.h
+++ b/drivers/net/wireless/ath/ath11k/ahb.h
@@ -1,11 +1,12 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef ATH11K_AHB_H
 #define ATH11K_AHB_H
 
+#include <linux/notifier.h>
 #include "core.h"
 
 #define ATH11K_AHB_RECOVERY_TIMEOUT (3 * HZ)
@@ -23,11 +24,13 @@ struct ath11k_base;
 
 struct ath11k_ahb {
 	struct rproc *tgt_rproc;
+	struct ath11k_base *ab;
 	struct {
 		struct device *dev;
 		struct iommu_domain *iommu_domain;
 		dma_addr_t msa_paddr;
 		u32 msa_size;
+		void *msa_vaddr;
 		dma_addr_t ce_paddr;
 		u32 ce_size;
 		bool use_tz;
@@ -37,6 +40,9 @@ struct ath11k_ahb {
 		unsigned int smem_bit;
 		struct qcom_smem_state *smem_state;
 	} smp2p_info;
+
+	struct notifier_block nb;
+	void *notifier;
 };
 
 static inline struct ath11k_ahb *ath11k_ahb_priv(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/coredump.c b/drivers/net/wireless/ath/ath11k/coredump.c
index 1e5a58ec673e..1253b07806f4 100644
--- a/drivers/net/wireless/ath/ath11k/coredump.c
+++ b/drivers/net/wireless/ath/ath11k/coredump.c
@@ -12,8 +12,24 @@
 #include "coredump.h"
 #include "debug.h"
 
+static const struct ath11k_mem_region wcn6750_hw10_mem_regions[] = {
+	{
+		/* MSA region start is not fixed, hence it is assigned at runtime */
+		.type = ATH11K_MEM_REGION_TYPE_MSA,
+		.len = 0xC00000,
+		.name = "MSA",
+	},
+};
+
 static const struct ath11k_hw_mem_layout hw_mem_layouts[] = {
-	/* HW memory layouts shall be defined here */
+	{
+		.hw_rev = ATH11K_HW_WCN6750_HW10,
+		.bus = ATH11K_BUS_AHB,
+		.region_table = {
+			.regions = wcn6750_hw10_mem_regions,
+			.size = ARRAY_SIZE(wcn6750_hw10_mem_regions),
+		},
+	}
 };
 
 const struct ath11k_hw_mem_layout *
-- 
2.17.1


Return-Path: <linux-wireless+bounces-16090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8189E9C45
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 17:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D841888817
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD551E9B2F;
	Mon,  9 Dec 2024 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d+w7DfaA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FC1D63FD;
	Mon,  9 Dec 2024 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763458; cv=none; b=cqrk65FEIjaP/dIudGdwdSkyZh6vPxxi4EEmKkoRw2eIinMxX28YwihahdMPne6DO+rUwMeNNlutxGVF40d7yUYzvqOqB6hQgKkosI8E2DK1IPS9Zfw1NBnCExHflpjaginA6BS+lSX1q+Ojc8I1702MZengnKaj8d86Aq3Xwlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763458; c=relaxed/simple;
	bh=9Wu1RfPOKIaNWaYh3FvRR7ER2UcpAV6qZy2KHkVDvN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERuXfARkBWkYHcVxHfflfQspzGCgokxVM715ZRRCUyMWV4v/keitRj3akoUG1AMykI9is3nyEYcd3SNi0RGecUWCZKgOr9mko4fT7G8sbJji5QCuIDOkmdrYLnnrB2jem+ikImLEAePmfwSd5Jcfe2YITAL4LbLKZklKuuWjTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d+w7DfaA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9E6u5O007101;
	Mon, 9 Dec 2024 16:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yl2jGQGupozAv4/ovMWYLVpQY3b41Kbl3JoAMxpN4Fg=; b=d+w7DfaAR6Hc38Q+
	54lPlHBY+ZHtdlha03Ww2gfJYKOUHwOp+FBSkyAdxcOG5EX545uF236EwCJXwNiU
	Bp9EHuWGC84kg28JRzmz5DDoYd7h6qI1tGgmAUsLbRKzH+I7enj2HBoByauxcQo+
	B3SYJ++Rk6rNzaV8DA6IRJqg72yaaIQEjQVKhYJWimf2MZgOhdx6PxhEMws428T8
	WL/OYxK8iTstQ5PIytyTSkg/TAcXFw0PQWi9E+QBm+8BE93XiKVji6YA62cX21Me
	iPbMfrQB1keU+I+uutg66Bhpw4pfheNtaGEBl+nDA5xpdeOAQt0j6Q/SF4l1Praj
	lK2t2A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e21bgj4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 16:57:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9GvVOd018524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 16:57:31 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 08:57:28 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 07/13] wifi: ath12k: add support for fixed QMI firmware memory
Date: Mon, 9 Dec 2024 22:26:38 +0530
Message-ID: <20241209165644.1680167-8-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209165644.1680167-1-quic_rajkbhag@quicinc.com>
References: <20241209165644.1680167-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g5P5HBtNvHqcEhneZHF-_RDra0SO6uNN
X-Proofpoint-ORIG-GUID: g5P5HBtNvHqcEhneZHF-_RDra0SO6uNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090132

IPQ5332 firmware supports only fixed QMI firmware memory.

Hence, add support to read reserved fixed memory region from
device-tree and provide the reserved memory segments for
firmware to use during QMI firmware memory request.

Note that the ability to set the fixed memory will be introduced in
a subsequent patch. Currently, the flag remains unset by default,
ensuring that existing chipsets are unaffected.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |   1 +
 drivers/net/wireless/ath/ath12k/hw.c   |   4 +
 drivers/net/wireless/ath/ath12k/hw.h   |   1 +
 drivers/net/wireless/ath/ath12k/qmi.c  | 141 +++++++++++++++++++++++--
 4 files changed, 141 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index e45ff85b675d..5e49fd6c8bc9 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -235,6 +235,7 @@ enum ath12k_dev_flags {
 	ATH12K_FLAG_CE_IRQ_ENABLED,
 	ATH12K_FLAG_EXT_IRQ_ENABLED,
 	ATH12K_FLAG_QMI_FW_READY_COMPLETE,
+	ATH12K_FLAG_FIXED_MEM_REGION,
 };
 
 struct ath12k_tx_conf {
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 494963b19fe9..4db4bb1bea95 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1318,6 +1318,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.needs_m3_fw = true,
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
+		.bdf_addr = 0,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1402,6 +1403,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.needs_m3_fw = true,
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
+		.bdf_addr = 0,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1482,6 +1484,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.needs_m3_fw = true,
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
+		.bdf_addr = 0,
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -1557,6 +1560,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.needs_m3_fw = false,
 		.ce_ie_addr = &ath12k_ce_ie_addr_ipq5332,
 		.ce_remap = &ath12k_ce_remap_ipq5332,
+		.bdf_addr = 0x4B500000,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index ee37e50476a4..524fab05768f 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -224,6 +224,7 @@ struct ath12k_hw_params {
 	bool needs_m3_fw;
 	const struct ce_ie_addr *ce_ie_addr;
 	const struct ce_remap *ce_remap;
+	u32 bdf_addr;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 7a29a24b9268..337347035605 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -11,6 +11,8 @@
 #include "debug.h"
 #include <linux/of.h>
 #include <linux/firmware.h>
+#include <linux/of_address.h>
+#include <linux/ioport.h>
 
 #define SLEEP_CLOCK_SELECT_INTERNAL_BIT	0x02
 #define HOST_CSTATE_BIT			0x04
@@ -2295,7 +2297,8 @@ int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 	 * failure to firmware and firmware then request multiple blocks of
 	 * small chunk size memory.
 	 */
-	if (ab->qmi.target_mem_delayed) {
+	if (!test_bit(ATH12K_FLAG_FIXED_MEM_REGION, &ab->dev_flags) &&
+	    ab->qmi.target_mem_delayed) {
 		delayed = true;
 		ath12k_dbg(ab, ATH12K_DBG_QMI, "qmi delays mem_request %d\n",
 			   ab->qmi.mem_seg_count);
@@ -2358,6 +2361,11 @@ static void ath12k_qmi_free_target_mem_chunk(struct ath12k_base *ab)
 	int i;
 
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+		if (test_bit(ATH12K_FLAG_FIXED_MEM_REGION, &ab->dev_flags) &&
+		    ab->qmi.target_mem[i].v.ioaddr) {
+			iounmap(ab->qmi.target_mem[i].v.ioaddr);
+			ab->qmi.target_mem[i].v.ioaddr = NULL;
+		}
 		if (!ab->qmi.target_mem[i].v.addr)
 			continue;
 
@@ -2436,6 +2444,118 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 	return 0;
 }
 
+static int ath12k_qmi_assign_target_mem_chunk(struct ath12k_base *ab)
+{
+	struct device *dev = ab->dev;
+	struct device_node *mem_node, *dev_node;
+	struct resource res, m3_res;
+	int i, idx, ret;
+
+	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
+		switch (ab->qmi.target_mem[i].type) {
+		case HOST_DDR_REGION_TYPE:
+			mem_node = of_parse_phandle(dev->of_node, "memory-region", 0);
+			if (!mem_node) {
+				ath12k_dbg(ab, ATH12K_DBG_QMI,
+					   "memory-region not defined in device-tree\n");
+				ret = -ENODEV;
+				goto out;
+			}
+
+			ret = of_address_to_resource(mem_node, 0, &res);
+			of_node_put(mem_node);
+			if (ret) {
+				ath12k_dbg(ab, ATH12K_DBG_QMI,
+					   "fail to get reg from memory-region\n");
+				goto out;
+			}
+
+			if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
+				ath12k_dbg(ab, ATH12K_DBG_QMI,
+					   "failed to assign mem type %d req size %d avail size %lld\n",
+					   ab->qmi.target_mem[i].type,
+					   ab->qmi.target_mem[i].size,
+					   (res.end - res.start + 1));
+				ret = -EINVAL;
+				goto out;
+			}
+
+			ab->qmi.target_mem[idx].paddr = res.start;
+			ab->qmi.target_mem[idx].v.ioaddr =
+				ioremap(ab->qmi.target_mem[idx].paddr,
+					ab->qmi.target_mem[i].size);
+			if (!ab->qmi.target_mem[idx].v.ioaddr) {
+				ret = -EIO;
+				goto out;
+			}
+			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
+			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
+			idx++;
+			break;
+		case BDF_MEM_REGION_TYPE:
+			ab->qmi.target_mem[idx].paddr = ab->hw_params->bdf_addr;
+			ab->qmi.target_mem[idx].v.ioaddr = NULL;
+			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
+			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
+			idx++;
+			break;
+
+		case CALDB_MEM_REGION_TYPE:
+			/* Cold boot calibration is not enabled in Ath12k. Hence,
+			 * assign paddr = 0.
+			 * Once cold boot calibration is enabled add support to
+			 * assign reserved memory from DT.
+			 */
+			ab->qmi.target_mem[idx].paddr = 0;
+			ab->qmi.target_mem[idx].v.ioaddr = NULL;
+			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
+			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
+			idx++;
+			break;
+		case M3_DUMP_REGION_TYPE:
+			dev_node = of_find_node_by_name(NULL, "m3_dump");
+			if (!dev_node || of_address_to_resource(dev_node, 0, &m3_res)) {
+				ath12k_err(ab, "m3_dump not defined in device-tree\n");
+				ret = -EINVAL;
+				goto out;
+			}
+
+			if (m3_res.end - m3_res.start + 1 < ab->qmi.target_mem[i].size) {
+				ath12k_dbg(ab, ATH12K_DBG_QMI,
+					   "failed to assign mem type %d req size %d avail size %lld\n",
+					   ab->qmi.target_mem[i].type,
+					   ab->qmi.target_mem[i].size,
+					   (m3_res.end - m3_res.start + 1));
+				ret = -EINVAL;
+				goto out;
+			}
+
+			ab->qmi.target_mem[idx].paddr = m3_res.start;
+			ab->qmi.target_mem[idx].v.ioaddr =
+				ioremap(ab->qmi.target_mem[idx].paddr,
+					ab->qmi.target_mem[i].size);
+			if (!ab->qmi.target_mem[idx].v.ioaddr) {
+				ret = -EIO;
+				goto out;
+			}
+			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
+			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
+			idx++;
+			break;
+		default:
+			ath12k_warn(ab, "qmi ignore invalid mem req type %d\n",
+				    ab->qmi.target_mem[i].type);
+			break;
+		}
+	}
+	ab->qmi.mem_seg_count = idx;
+
+	return 0;
+out:
+	ath12k_qmi_free_target_mem_chunk(ab);
+	return ret;
+}
+
 /* clang stack usage explodes if this is inlined */
 static noinline_for_stack
 int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
@@ -3270,11 +3390,20 @@ static void ath12k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 			   msg->mem_seg[i].type, msg->mem_seg[i].size);
 	}
 
-	ret = ath12k_qmi_alloc_target_mem_chunk(ab);
-	if (ret) {
-		ath12k_warn(ab, "qmi failed to alloc target memory: %d\n",
-			    ret);
-		return;
+	if (test_bit(ATH12K_FLAG_FIXED_MEM_REGION, &ab->dev_flags)) {
+		ret = ath12k_qmi_assign_target_mem_chunk(ab);
+		if (ret) {
+			ath12k_warn(ab, "failed to assign qmi target memory: %d\n",
+				    ret);
+			return;
+		}
+	} else {
+		ret = ath12k_qmi_alloc_target_mem_chunk(ab);
+		if (ret) {
+			ath12k_warn(ab, "qmi failed to alloc target memory: %d\n",
+				    ret);
+			return;
+		}
 	}
 
 	ath12k_qmi_driver_event_post(qmi, ATH12K_QMI_EVENT_REQUEST_MEM, NULL);
-- 
2.34.1



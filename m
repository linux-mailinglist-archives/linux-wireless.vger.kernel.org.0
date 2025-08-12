Return-Path: <linux-wireless+bounces-26327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBBB22EC0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 19:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCEC626F9F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5966E2FAC1B;
	Tue, 12 Aug 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HcQMQTYZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E342FD1C2
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018761; cv=none; b=jZZgKRb5mFtB1+x5kPuwGneBiF0qRBjYEriwoyxTDAXXV387uHZytP+r0lMbv2AbGQzzVD2HP/fKGCrQA58A1NS1+5T9N6JmcbExUqevz5ttk7MMn0zY+aZYap3HRLgYfS+Jmrdo49bdDrgVfn/eWB7eQjrQxskrMzvzU6CvZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018761; c=relaxed/simple;
	bh=e6/gB3J/HF2N3g6Y5lHk3GPccG1AHM5jw5tHh8lMq/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=S5hwmvvU1BqNYNMup/IrnfeOsJQUFJTjy0m1/HUDYDZhEO94mN+0sBsbCZJR9qFCTz6pYxy5GSGpfQFWPSkaIVeeEOwo5UROjF2E7KTuDT/n1AJXU4SwB9qj9UPc5ezS66mAeTphil2JLPmtEBtsTCfx4DiAFuVuWmC8HzhRmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HcQMQTYZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvgRU029556;
	Tue, 12 Aug 2025 17:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aiTBVoSSX+mqbCI7gGKLiA7aeNzk6TzIu4JC4nz8SSo=; b=HcQMQTYZ9Zf843AU
	rE7gW7o5BAICdCpxKyy6cPhzk/IRn4x/Kk4ytortLkZ8wCKKACY/XlsImln8RXx3
	vBRm7Z+X/SMPDWwoA56gVRhgPHrOlf55X4KyDPHxOiXjdsW0axYfTLMyquJvXAE7
	6nKMnKyyDhD0hkRwTQJHbbKkULn2kjlKHjmyGv6Hs4A0Gtr8OFhd1xqHXIiIpXxk
	vj9vsidewQZi2oLLXjJaqCdA+a/S0eIKZkTtmh9HRlVdERhqZpa99tbd6MNJcU51
	/4I+yjv6mQ7doK46gT1fMVZqosUF1W1P8I1nqg9M3swyKLHlx6zPtXL1yJv7OYhf
	VQJ0Hg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g8x3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:36 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CHCZKU001506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 17:12:35 GMT
Received: from hu-kiranv-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 10:12:34 -0700
From: Kiran Venkatappa <quic_kiranv@quicinc.com>
Date: Tue, 12 Aug 2025 22:39:27 +0530
Subject: [PATCH ath12k-ng 01/13] wifi: ath12k: Restructure PCI code to
 common and Wi-Fi 7 specific logic
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-ath12k-mod-v1-1-8c9b0eb9335d@quicinc.com>
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689b7604 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=U9p1R3DoLONZFzZhjYwA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX/gjFQtLIPaQ3
 5ZbsqyqIaUd55yR2nQOHFSZnWFvR0lGjHjEaUY8nwqgeJteqdT+WSvX0NoS5FCbp0/kvxRZIOp+
 ywfccngq/bUOhmj/WylFqysnqxgCdyBqmPHEXmMyxtGoy8fM6CpNls9PGP+fzUo4ppadPHec8JM
 W89T1WoTfQBPLkNLndg9iMAtXiInnkOxMwn/ATRYHC6ydQmxlhOawcs0U+oYrcFWrN5jF5dBGRF
 uiNu1blP1d17d++2Z30WlY1xMfywjCi+QJgQ9cVK3ALmzlEuxWlSZc2rfyrizW/vRZ4cs+Zm0wW
 Ls0DMBUbgCeGXju7tjo4pk6bam/CmfF5twfwvKjCiQoTji4Be4SJkY20NF2ucGNKCDKOTyAaiZO
 8WzpRoHk
X-Proofpoint-GUID: 5fMVSl27Bax_cqkYbO87tv3nG1LWvD6k
X-Proofpoint-ORIG-GUID: 5fMVSl27Bax_cqkYbO87tv3nG1LWvD6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

Refactor pci.c to split common and hardware family specific components.
Retain shared logic such as probe and initialization sequences in common
pci.c to support reuse across device families and move Wi-Fi 7 specific
initialization and configuration to a new pci_wifi7.c file. Register
device specific routines via callbacks to keep the common PCI code
generic and extensible for future hardware families.
This improves maintainability and prepare the codebase for additional
device family support.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kiran Venkatappa <quic_kiranv@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile    |   1 +
 drivers/net/wireless/ath/ath12k/core.c      |   5 +-
 drivers/net/wireless/ath/ath12k/core.h      |   6 +
 drivers/net/wireless/ath/ath12k/pci.c       | 200 ++++++++++------------------
 drivers/net/wireless/ath/ath12k/pci.h       |  21 ++-
 drivers/net/wireless/ath/ath12k/pci_wifi7.c | 173 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/pci_wifi7.h |  12 ++
 7 files changed, 278 insertions(+), 140 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index d95ee525a6cd06c13755e7f396151373244e0c39..1a26e00627b0a3d631ddfa62ef70a9b29b426a3f 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -19,6 +19,7 @@ ath12k-y += core.o \
 	    hw.o \
 	    mhi.o \
 	    pci.o \
+	    pci_wifi7.o \
 	    dp_mon.o \
 	    fw.o \
 	    p2p.o
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 5d494c5cdc0da3189640751b8d191fa939ac3ff5..b723d7d28cdac48934d621338d6a623781c86b73 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -22,6 +22,7 @@
 #include "hif.h"
 #include "pci.h"
 #include "wow.h"
+#include "pci_wifi7.h"
 
 static int ahb_err, pci_err;
 unsigned int ath12k_debug_mask;
@@ -2287,7 +2288,7 @@ static int ath12k_init(void)
 	if (ahb_err)
 		pr_warn("Failed to initialize ath12k AHB device: %d\n", ahb_err);
 
-	pci_err = ath12k_pci_init();
+	pci_err = ath12k_wifi7_pci_init();
 	if (pci_err)
 		pr_warn("Failed to initialize ath12k PCI device: %d\n", pci_err);
 
@@ -2298,7 +2299,7 @@ static int ath12k_init(void)
 static void ath12k_exit(void)
 {
 	if (!pci_err)
-		ath12k_pci_exit();
+		ath12k_wifi7_pci_exit();
 
 	if (!ahb_err)
 		ath12k_ahb_exit();
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 519f826f56c8ebb871997777261dbd1f2e5482de..fa04aaa836fcba9d647b2127651cb366046e2e73 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1028,6 +1028,12 @@ struct ath12k_mem_profile_based_param {
 	struct ath12k_dp_profile_params dp_params;
 };
 
+enum ath12k_device_family {
+	ATH12K_DEVICE_FAMILY_START,
+	ATH12K_DEVICE_FAMILY_WIFI7 = ATH12K_DEVICE_FAMILY_START,
+	ATH12K_DEVICE_FAMILY_MAX,
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath12k_base {
 	enum ath12k_hw_rev hw_rev;
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index c729d5526c753d2b7b7542b6f2a145e71b335a43..93e2189ec68704598ce401ed4fe4f5981fc3cece 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -28,44 +28,17 @@
 #define WINDOW_RANGE_MASK		GENMASK(18, 0)
 #define WINDOW_STATIC_MASK		GENMASK(31, 6)
 
-#define TCSR_SOC_HW_VERSION		0x1B00000
-#define TCSR_SOC_HW_VERSION_MAJOR_MASK	GENMASK(11, 8)
-#define TCSR_SOC_HW_VERSION_MINOR_MASK	GENMASK(7, 4)
-
 /* BAR0 + 4k is always accessible, and no
  * need to force wakeup.
  * 4K - 32 = 0xFE0
  */
 #define ACCESS_ALWAYS_OFF 0xFE0
 
-#define QCN9274_DEVICE_ID		0x1109
-#define WCN7850_DEVICE_ID		0x1107
-
 #define PCIE_LOCAL_REG_QRTR_NODE_ID	0x1E03164
 #define DOMAIN_NUMBER_MASK		GENMASK(7, 4)
 #define BUS_NUMBER_MASK			GENMASK(3, 0)
 
-static const struct pci_device_id ath12k_pci_id_table[] = {
-	{ PCI_VDEVICE(QCOM, QCN9274_DEVICE_ID) },
-	{ PCI_VDEVICE(QCOM, WCN7850_DEVICE_ID) },
-	{}
-};
-
-MODULE_DEVICE_TABLE(pci, ath12k_pci_id_table);
-
-/* TODO: revisit IRQ mapping for new SRNG's */
-static const struct ath12k_msi_config ath12k_msi_config[] = {
-	{
-		.total_vectors = 16,
-		.total_users = 3,
-		.users = (struct ath12k_msi_user[]) {
-			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
-			{ .name = "CE", .num_vectors = 5, .base_vector = 3 },
-			{ .name = "DP", .num_vectors = 8, .base_vector = 8 },
-		},
-	},
-};
-
+static struct ath12k_pci_driver *ath12k_pci_family_drivers[ATH12K_DEVICE_FAMILY_MAX];
 static const struct ath12k_msi_config msi_config_one_msi = {
 	.total_vectors = 1,
 	.total_users = 4,
@@ -136,30 +109,6 @@ static const char *irq_name[ATH12K_IRQ_NUM_MAX] = {
 	"tcl2host-status-ring",
 };
 
-static int ath12k_pci_bus_wake_up(struct ath12k_base *ab)
-{
-	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
-
-	return mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
-}
-
-static void ath12k_pci_bus_release(struct ath12k_base *ab)
-{
-	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
-
-	mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
-}
-
-static const struct ath12k_pci_ops ath12k_pci_ops_qcn9274 = {
-	.wakeup = NULL,
-	.release = NULL,
-};
-
-static const struct ath12k_pci_ops ath12k_pci_ops_wcn7850 = {
-	.wakeup = ath12k_pci_bus_wake_up,
-	.release = ath12k_pci_bus_release,
-};
-
 static void ath12k_pci_select_window(struct ath12k_pci *ab_pci, u32 offset)
 {
 	struct ath12k_base *ab = ab_pci->ab;
@@ -1531,28 +1480,34 @@ static const struct ath12k_hif_ops ath12k_pci_hif_ops = {
 #endif
 };
 
-static
-void ath12k_pci_read_hw_version(struct ath12k_base *ab, u32 *major, u32 *minor)
+static enum ath12k_device_family
+ath12k_get_device_family(const struct pci_device_id *pci_dev)
 {
-	u32 soc_hw_version;
+	enum ath12k_device_family device_family_id;
+	const struct pci_device_id *id;
 
-	soc_hw_version = ath12k_pci_read32(ab, TCSR_SOC_HW_VERSION);
-	*major = FIELD_GET(TCSR_SOC_HW_VERSION_MAJOR_MASK,
-			   soc_hw_version);
-	*minor = FIELD_GET(TCSR_SOC_HW_VERSION_MINOR_MASK,
-			   soc_hw_version);
+	for (device_family_id = ATH12K_DEVICE_FAMILY_START;
+	     device_family_id < ATH12K_DEVICE_FAMILY_MAX; device_family_id++) {
+		if (!ath12k_pci_family_drivers[device_family_id])
+			continue;
+
+		id = ath12k_pci_family_drivers[device_family_id]->id_table;
+		while (id->device) {
+			if (id->device == pci_dev->device)
+				return device_family_id;
+			id += 1;
+		}
+	}
 
-	ath12k_dbg(ab, ATH12K_DBG_PCI,
-		   "pci tcsr_soc_hw_version major %d minor %d\n",
-		    *major, *minor);
+	return ATH12K_DEVICE_FAMILY_MAX;
 }
 
 static int ath12k_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *pci_dev)
 {
-	struct ath12k_base *ab;
+	enum ath12k_device_family device_id;
 	struct ath12k_pci *ab_pci;
-	u32 soc_hw_version_major, soc_hw_version_minor;
+	struct ath12k_base *ab;
 	int ret;
 
 	ab = ath12k_core_alloc(&pdev->dev, sizeof(*ab_pci), ATH12K_BUS_PCI);
@@ -1587,56 +1542,24 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
 	ab->id.subsystem_vendor = pdev->subsystem_vendor;
 	ab->id.subsystem_device = pdev->subsystem_device;
 
-	switch (pci_dev->device) {
-	case QCN9274_DEVICE_ID:
-		ab_pci->msi_config = &ath12k_msi_config[0];
-		ab->static_window_map = true;
-		ab_pci->pci_ops = &ath12k_pci_ops_qcn9274;
-		ab->hal_rx_ops = &hal_rx_qcn9274_ops;
-		ath12k_pci_read_hw_version(ab, &soc_hw_version_major,
-					   &soc_hw_version_minor);
-		ab->target_mem_mode = ath12k_core_get_memory_mode(ab);
-		switch (soc_hw_version_major) {
-		case ATH12K_PCI_SOC_HW_VERSION_2:
-			ab->hw_rev = ATH12K_HW_QCN9274_HW20;
-			break;
-		case ATH12K_PCI_SOC_HW_VERSION_1:
-			ab->hw_rev = ATH12K_HW_QCN9274_HW10;
-			break;
-		default:
-			dev_err(&pdev->dev,
-				"Unknown hardware version found for QCN9274: 0x%x\n",
-				soc_hw_version_major);
-			ret = -EOPNOTSUPP;
-			goto err_pci_free_region;
-		}
-		break;
-	case WCN7850_DEVICE_ID:
-		ab->id.bdf_search = ATH12K_BDF_SEARCH_BUS_AND_BOARD;
-		ab_pci->msi_config = &ath12k_msi_config[0];
-		ab->static_window_map = false;
-		ab_pci->pci_ops = &ath12k_pci_ops_wcn7850;
-		ab->hal_rx_ops = &hal_rx_wcn7850_ops;
-		ath12k_pci_read_hw_version(ab, &soc_hw_version_major,
-					   &soc_hw_version_minor);
-		ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
-		switch (soc_hw_version_major) {
-		case ATH12K_PCI_SOC_HW_VERSION_2:
-			ab->hw_rev = ATH12K_HW_WCN7850_HW20;
-			break;
-		default:
-			dev_err(&pdev->dev,
-				"Unknown hardware version found for WCN7850: 0x%x\n",
-				soc_hw_version_major);
-			ret = -EOPNOTSUPP;
-			goto err_pci_free_region;
-		}
-		break;
+	device_id = ath12k_get_device_family(pci_dev);
+	if (device_id >= ATH12K_DEVICE_FAMILY_MAX) {
+		ath12k_err(ab, "failed to get device family id\n");
+		ret = -EINVAL;
+		goto err_pci_free_region;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_PCI, "PCI device family id: %d\n", device_id);
+
+	ab_pci->device_family_ops = &ath12k_pci_family_drivers[device_id]->ops;
 
-	default:
-		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
-			pci_dev->device);
-		ret = -EOPNOTSUPP;
+	/* Call device specific probe. This is the callback that can
+	 * be used to override any ops in future
+	 * probe is validated for NULL during registration.
+	 */
+	ret = ab_pci->device_family_ops->probe(pdev, pci_dev);
+	if (ret) {
+		ath12k_err(ab, "failed to probe device: %d\n", ret);
 		goto err_pci_free_region;
 	}
 
@@ -1844,30 +1767,41 @@ static const struct dev_pm_ops __maybe_unused ath12k_pci_pm_ops = {
 				     ath12k_pci_pm_resume_early)
 };
 
-static struct pci_driver ath12k_pci_driver = {
-	.name = "ath12k_pci",
-	.id_table = ath12k_pci_id_table,
-	.probe = ath12k_pci_probe,
-	.remove = ath12k_pci_remove,
-	.shutdown = ath12k_pci_shutdown,
-	.driver.pm = &ath12k_pci_pm_ops,
-};
-
-int ath12k_pci_init(void)
+int ath12k_pci_register_driver(const enum ath12k_device_family device_id,
+			       struct ath12k_pci_driver *driver)
 {
-	int ret;
+	struct pci_driver *pci_driver;
 
-	ret = pci_register_driver(&ath12k_pci_driver);
-	if (ret) {
-		pr_err("failed to register ath12k pci driver: %d\n",
-		       ret);
-		return ret;
+	if (device_id >= ATH12K_DEVICE_FAMILY_MAX)
+		return -EINVAL;
+
+	if (!driver || !driver->ops.probe)
+		return -EINVAL;
+
+	if (ath12k_pci_family_drivers[device_id]) {
+		pr_err("Driver already registered for %d\n", device_id);
+		return -EALREADY;
 	}
 
-	return 0;
+	ath12k_pci_family_drivers[device_id] = driver;
+
+	pci_driver = &ath12k_pci_family_drivers[device_id]->driver;
+	pci_driver->name = driver->name;
+	pci_driver->id_table = driver->id_table;
+	pci_driver->probe = ath12k_pci_probe;
+	pci_driver->remove = ath12k_pci_remove;
+	pci_driver->shutdown = ath12k_pci_shutdown;
+	pci_driver->driver.pm = &ath12k_pci_pm_ops;
+
+	return pci_register_driver(pci_driver);
 }
 
-void ath12k_pci_exit(void)
+void ath12k_pci_unregister_driver(const enum ath12k_device_family device_id)
 {
-	pci_unregister_driver(&ath12k_pci_driver);
+	if (device_id >= ATH12K_DEVICE_FAMILY_MAX ||
+	    !ath12k_pci_family_drivers[device_id])
+		return;
+
+	pci_unregister_driver(&ath12k_pci_family_drivers[device_id]->driver);
+	ath12k_pci_family_drivers[device_id] = NULL;
 }
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index d1ec8aad7f6c3b6f5cbdf8ce57a4106733686521..1b7ecc329a017cafa84780f3f6e634163ead59bb 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -7,6 +7,7 @@
 #define ATH12K_PCI_H
 
 #include <linux/mhi.h>
+#include <linux/pci.h>
 
 #include "core.h"
 
@@ -70,9 +71,6 @@
 #define QRTR_PCI_DOMAIN_NR_MASK		GENMASK(7, 4)
 #define QRTR_PCI_BUS_NUMBER_MASK	GENMASK(3, 0)
 
-#define ATH12K_PCI_SOC_HW_VERSION_1	1
-#define ATH12K_PCI_SOC_HW_VERSION_2	2
-
 struct ath12k_msi_user {
 	const char *name;
 	int num_vectors;
@@ -97,6 +95,10 @@ struct ath12k_pci_ops {
 	void (*release)(struct ath12k_base *ab);
 };
 
+struct ath12k_pci_device_family_ops {
+	int (*probe)(struct pci_dev *pdev, const struct pci_device_id *pci_dev);
+};
+
 struct ath12k_pci {
 	struct pci_dev *pdev;
 	struct ath12k_base *ab;
@@ -119,6 +121,14 @@ struct ath12k_pci {
 	const struct ath12k_pci_ops *pci_ops;
 	u32 qmi_instance;
 	u64 dma_mask;
+	const struct ath12k_pci_device_family_ops *device_family_ops;
+};
+
+struct ath12k_pci_driver {
+	const char *name;
+	const struct pci_device_id *id_table;
+	struct ath12k_pci_device_family_ops ops;
+	struct pci_driver driver;
 };
 
 static inline struct ath12k_pci *ath12k_pci_priv(struct ath12k_base *ab)
@@ -148,6 +158,7 @@ void ath12k_pci_stop(struct ath12k_base *ab);
 int ath12k_pci_start(struct ath12k_base *ab);
 int ath12k_pci_power_up(struct ath12k_base *ab);
 void ath12k_pci_power_down(struct ath12k_base *ab, bool is_suspend);
-int ath12k_pci_init(void);
-void ath12k_pci_exit(void);
+int ath12k_pci_register_driver(const enum ath12k_device_family device_id,
+			       struct ath12k_pci_driver *driver);
+void ath12k_pci_unregister_driver(const enum ath12k_device_family device_id);
 #endif /* ATH12K_PCI_H */
diff --git a/drivers/net/wireless/ath/ath12k/pci_wifi7.c b/drivers/net/wireless/ath/ath12k/pci_wifi7.c
new file mode 100644
index 0000000000000000000000000000000000000000..8c7718153534ca0f30d33ef954d6c542ae70154a
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/pci_wifi7.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/pci.h>
+
+#include "pci.h"
+#include "pci_wifi7.h"
+#include "core.h"
+#include "hif.h"
+#include "mhi.h"
+
+#define QCN9274_DEVICE_ID		0x1109
+#define WCN7850_DEVICE_ID		0x1107
+
+#define ATH12K_PCI_W7_SOC_HW_VERSION_1	1
+#define ATH12K_PCI_W7_SOC_HW_VERSION_2	2
+
+#define TCSR_SOC_HW_VERSION		0x1B00000
+#define TCSR_SOC_HW_VERSION_MAJOR_MASK	GENMASK(11, 8)
+#define TCSR_SOC_HW_VERSION_MINOR_MASK	GENMASK(7, 4)
+
+static const struct pci_device_id ath12k_wifi7_pci_id_table[] = {
+	{ PCI_VDEVICE(QCOM, QCN9274_DEVICE_ID) },
+	{ PCI_VDEVICE(QCOM, WCN7850_DEVICE_ID) },
+	{}
+};
+
+MODULE_DEVICE_TABLE(pci, ath12k_wifi7_pci_id_table);
+
+/* TODO: revisit IRQ mapping for new SRNG's */
+static const struct ath12k_msi_config ath12k_wifi7_msi_config[] = {
+	{
+		.total_vectors = 16,
+		.total_users = 3,
+		.users = (struct ath12k_msi_user[]) {
+			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+			{ .name = "CE", .num_vectors = 5, .base_vector = 3 },
+			{ .name = "DP", .num_vectors = 8, .base_vector = 8 },
+		},
+	},
+};
+
+static const struct ath12k_pci_ops ath12k_pci_ops_qcn9274 = {
+	.wakeup = NULL,
+	.release = NULL,
+};
+
+static int ath12k_wifi7_pci_bus_wake_up(struct ath12k_base *ab)
+{
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+
+	return mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+}
+
+static void ath12k_wifi7_pci_bus_release(struct ath12k_base *ab)
+{
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
+
+	mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+}
+
+static const struct ath12k_pci_ops ath12k_pci_ops_wcn7850 = {
+	.wakeup = ath12k_wifi7_pci_bus_wake_up,
+	.release = ath12k_wifi7_pci_bus_release,
+};
+
+static
+void ath12k_wifi7_pci_read_hw_version(struct ath12k_base *ab,
+				      u32 *major, u32 *minor)
+{
+	u32 soc_hw_version;
+
+	soc_hw_version = ath12k_pci_read32(ab, TCSR_SOC_HW_VERSION);
+	*major = u32_get_bits(soc_hw_version, TCSR_SOC_HW_VERSION_MAJOR_MASK);
+	*minor = u32_get_bits(soc_hw_version, TCSR_SOC_HW_VERSION_MINOR_MASK);
+}
+
+static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
+				  const struct pci_device_id *pci_dev)
+{
+	u32 soc_hw_version_major, soc_hw_version_minor;
+	struct ath12k_pci *ab_pci;
+	struct ath12k_base *ab;
+
+	ab = pci_get_drvdata(pdev);
+	if (!ab)
+		return -EINVAL;
+
+	ab_pci = ath12k_pci_priv(ab);
+	if (!ab_pci)
+		return -EINVAL;
+
+	switch (pci_dev->device) {
+	case QCN9274_DEVICE_ID:
+		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
+		ab->static_window_map = true;
+		ab_pci->pci_ops = &ath12k_pci_ops_qcn9274;
+		ab->hal_rx_ops = &hal_rx_qcn9274_ops;
+		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
+						 &soc_hw_version_minor);
+		ab->target_mem_mode = ath12k_core_get_memory_mode(ab);
+		switch (soc_hw_version_major) {
+		case ATH12K_PCI_W7_SOC_HW_VERSION_2:
+			ab->hw_rev = ATH12K_HW_QCN9274_HW20;
+			break;
+		case ATH12K_PCI_W7_SOC_HW_VERSION_1:
+			ab->hw_rev = ATH12K_HW_QCN9274_HW10;
+			break;
+		default:
+			dev_err(&pdev->dev,
+				"Unknown hardware version found for QCN9274: 0x%x\n",
+				soc_hw_version_major);
+			return -EOPNOTSUPP;
+		}
+		break;
+	case WCN7850_DEVICE_ID:
+		ab->id.bdf_search = ATH12K_BDF_SEARCH_BUS_AND_BOARD;
+		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
+		ab->static_window_map = false;
+		ab_pci->pci_ops = &ath12k_pci_ops_wcn7850;
+		ab->hal_rx_ops = &hal_rx_wcn7850_ops;
+		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
+						 &soc_hw_version_minor);
+		ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;
+		switch (soc_hw_version_major) {
+		case ATH12K_PCI_W7_SOC_HW_VERSION_2:
+			ab->hw_rev = ATH12K_HW_WCN7850_HW20;
+			break;
+		default:
+			dev_err(&pdev->dev,
+				"Unknown hardware version found for WCN7850: 0x%x\n",
+				soc_hw_version_major);
+			return -EOPNOTSUPP;
+		}
+		break;
+
+	default:
+		dev_err(&pdev->dev, "Unknown Wi-Fi 7 PCI device found: 0x%x\n",
+			pci_dev->device);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static struct ath12k_pci_driver ath12k_pci_wifi7_driver = {
+	.name = "ath12k_wifi7_pci",
+	.id_table = ath12k_wifi7_pci_id_table,
+	.ops.probe = ath12k_wifi7_pci_probe,
+};
+
+int ath12k_wifi7_pci_init(void)
+{
+	int ret;
+
+	ret = ath12k_pci_register_driver(ATH12K_DEVICE_FAMILY_WIFI7,
+					 &ath12k_pci_wifi7_driver);
+	if (ret) {
+		pr_err("Failed to register ath12k Wi-Fi 7 driver: %d\n",
+		       ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ath12k_wifi7_pci_exit(void)
+{
+	ath12k_pci_unregister_driver(ATH12K_DEVICE_FAMILY_WIFI7);
+}
diff --git a/drivers/net/wireless/ath/ath12k/pci_wifi7.h b/drivers/net/wireless/ath/ath12k/pci_wifi7.h
new file mode 100644
index 0000000000000000000000000000000000000000..662a8bab0ce7fa8c6d0c440333a7c23e649bdf6e
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/pci_wifi7.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef ATH12K_PCI_WIFI7_H
+#define ATH12K_PCI_WIFI7_H
+
+int ath12k_wifi7_pci_init(void);
+void ath12k_wifi7_pci_exit(void);
+
+#endif /* ATH12K_PCI_WIFI7_H */

-- 
2.34.1



Return-Path: <linux-wireless+bounces-14003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D81C99F596
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 20:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E79C1F255BD
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9220263E;
	Tue, 15 Oct 2024 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZN93WkGo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323C202635;
	Tue, 15 Oct 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016944; cv=none; b=LKM5Vqb3LHPQYhiyZhTAOHZLyxRrJARFRXPUiuTwLI9zeaZVEifOGkLSLeg4vp/TaxvlXSGwe0CdtOhE/iM9nptwIdbo/h0z7N9HJUsNd1lsjrbxD63I+RlK1xAXYEkdMQZRq/XoRD+TrYW+iY9XQLH674XWVuzV3BYk6zS/aTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016944; c=relaxed/simple;
	bh=tALa2Xl/6YpNhtreGEaBlCojmfql/HqZC9jEO7NqOmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbxJarKdJ/3UY5qP+ke+CK+39qOHfOlFw1VXKlP/XBAx1NEAKrBsCfUTyJaiGvL/Rex3mRzwK7y0L90YDDSDpfPiv8z5uZDc6kxpKh7wzjynf2TQ81Eb+nPGE90Ju2TzrRq15xESNeCqDMuQkxMJbr6sw/1mWhZs6rndYB8hQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZN93WkGo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FB6fTe024391;
	Tue, 15 Oct 2024 18:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uh7in1cEQi+MiTKT+tIWP9LVgtorvwkBZ+/qPYRB9zQ=; b=ZN93WkGoSiHwIlcT
	n2S6GbDBeE/hi/9UbVvtNV68j8x2aytnYlrAaWg+tigPo4z7M98FVCDgzkfOMBww
	ViICAZ9rjEznAMbTMm/JciPVFY6dM8xJVNeR79ApyxlCsDic8cbSYzJ25hkTn2jr
	vMCmP/TWBfsclkdo1dxZ3zXX5I2q4oTEkLWp5YqsVNSoFzNq4UFoi1AeiJVcVKdO
	2A0mdgIDWRc1nqXuRXrKg0jyQX8WaK6VKqekGun3nFColRg6rWfsEl2oPHXdUih1
	RyUP91TBb1SGVmQivyDAvaFbNL6IZuYMsWp4xumpSTULZ8lxq2OWT/zvneXw6bwF
	n+7KNg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427jd90k1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FISwBK009224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:28:58 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 11:28:53 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        "P Praneesh" <quic_ppranees@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 22/22] wifi: ath12k: enable ath12k AHB support
Date: Tue, 15 Oct 2024 23:56:37 +0530
Message-ID: <20241015182637.955753-23-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: klYlI7e7TqV5yjkepF-awb3UG5Rye5Hi
X-Proofpoint-ORIG-GUID: klYlI7e7TqV5yjkepF-awb3UG5Rye5Hi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150125

From: Balamurugan S <quic_bselvara@quicinc.com>

Currently only PCI devices is supported in Ath12k driver. Refactor
Ath12k module_init and module_exit to include Ath12k AHB support.

Add Ath12k AHB support in Kconfig with dependency on Remoteproc
driver. Ath12k AHB support relies on remoteproc driver for firmware
download, power up/down etc.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1

Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Kconfig  |  6 ++++
 drivers/net/wireless/ath/ath12k/Makefile |  1 +
 drivers/net/wireless/ath/ath12k/ahb.h    | 12 ++++++++
 drivers/net/wireless/ath/ath12k/core.c   | 35 ++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/pci.c    | 12 ++------
 drivers/net/wireless/ath/ath12k/pci.h    |  2 ++
 6 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index f64e7c322216..58837a6dec9a 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -15,6 +15,12 @@ config ATH12K
 
 	  If you choose to build a module, it'll be called ath12k.
 
+config ATH12K_AHB
+	bool "QTI ath12k AHB support"
+	depends on ATH12K && REMOTEPROC && QCOM_Q6V5_WCSS_SEC
+	help
+	  Enable support for Ath12k AHB bus chipsets, example IPQ5332.
+
 config ATH12K_DEBUG
 	bool "ath12k debugging"
 	depends on ATH12K
diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 5a1ed20d730e..4b7b9404d0c6 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -23,6 +23,7 @@ ath12k-y += core.o \
 	    fw.o \
 	    p2p.o
 
+ath12k-$(CONFIG_ATH12K_AHB) += ahb.o
 ath12k-$(CONFIG_ATH12K_DEBUGFS) += debugfs.o debugfs_htt_stats.o
 ath12k-$(CONFIG_ACPI) += acpi.o
 ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
diff --git a/drivers/net/wireless/ath/ath12k/ahb.h b/drivers/net/wireless/ath/ath12k/ahb.h
index 0dbbbfd45eab..fc21211c01dd 100644
--- a/drivers/net/wireless/ath/ath12k/ahb.h
+++ b/drivers/net/wireless/ath/ath12k/ahb.h
@@ -65,4 +65,16 @@ static inline struct ath12k_ahb *ath12k_ab_to_ahb(struct ath12k_base *ab)
 	return (struct ath12k_ahb *)ab->drv_priv;
 }
 
+#ifdef CONFIG_ATH12K_AHB
+int ath12k_ahb_init(void);
+void ath12k_ahb_exit(void);
+#else
+static inline int ath12k_ahb_init(void)
+{
+	return 0;
+}
+
+static inline void ath12k_ahb_exit(void) {};
+#endif
+
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 9cd485ed42ab..97450726b59d 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -9,15 +9,18 @@
 #include <linux/remoteproc.h>
 #include <linux/firmware.h>
 #include <linux/of.h>
+#include "ahb.h"
 #include "core.h"
 #include "dp_tx.h"
 #include "dp_rx.h"
 #include "debug.h"
-#include "hif.h"
-#include "fw.h"
 #include "debugfs.h"
+#include "fw.h"
+#include "hif.h"
+#include "pci.h"
 #include "wow.h"
 
+static int ahb_err, pci_err;
 unsigned int ath12k_debug_mask;
 module_param_named(debug_mask, ath12k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
@@ -1341,5 +1344,31 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	return NULL;
 }
 
-MODULE_DESCRIPTION("Core module for Qualcomm Atheros 802.11be wireless LAN cards.");
+static int ath12k_init(void)
+{
+	ahb_err = ath12k_ahb_init();
+	if (ahb_err)
+		pr_warn("Failed to initialize ath12k AHB device: %d\n", ahb_err);
+
+	pci_err = ath12k_pci_init();
+	if (pci_err)
+		pr_warn("Failed to initialize ath12k PCI device: %d\n", pci_err);
+
+	/* If both failed, return one of the failures (arbitrary) */
+	return ahb_err && pci_err ? ahb_err : 0;
+}
+
+static void ath12k_exit(void)
+{
+	if (!pci_err)
+		ath12k_pci_exit();
+
+	if (!ahb_err)
+		ath12k_ahb_exit();
+}
+
+module_init(ath12k_init)
+module_exit(ath12k_exit)
+
+MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11be WLAN devices");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 9a50d813e9b4..f4a868c2275e 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1627,7 +1627,7 @@ static struct pci_driver ath12k_pci_driver = {
 	.driver.pm = &ath12k_pci_pm_ops,
 };
 
-static int ath12k_pci_init(void)
+int ath12k_pci_init(void)
 {
 	int ret;
 
@@ -1638,16 +1638,10 @@ static int ath12k_pci_init(void)
 		return ret;
 	}
 
-	return 0;
+	return ret;
 }
-module_init(ath12k_pci_init);
 
-static void ath12k_pci_exit(void)
+void ath12k_pci_exit(void)
 {
 	pci_unregister_driver(&ath12k_pci_driver);
 }
-
-module_exit(ath12k_pci_exit);
-
-MODULE_DESCRIPTION("Driver support for Qualcomm Technologies PCIe 802.11be WLAN devices");
-MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 31584a7ad80e..18648ca11dfc 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -145,4 +145,6 @@ void ath12k_pci_stop(struct ath12k_base *ab);
 int ath12k_pci_start(struct ath12k_base *ab);
 int ath12k_pci_power_up(struct ath12k_base *ab);
 void ath12k_pci_power_down(struct ath12k_base *ab, bool is_suspend);
+int ath12k_pci_init(void);
+void ath12k_pci_exit(void);
 #endif /* ATH12K_PCI_H */
-- 
2.34.1



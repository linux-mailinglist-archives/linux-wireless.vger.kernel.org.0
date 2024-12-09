Return-Path: <linux-wireless+bounces-16097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E419E9C60
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2832E1886E30
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6525223C54;
	Mon,  9 Dec 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IXhqE4ed"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D301015534B;
	Mon,  9 Dec 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763481; cv=none; b=VqDPeIqui17jryKw4+r712UuqyNtt5O0rwX4eqeLApyGNdPlBFbRb7JrINZsk9dAP8uAmUfMHG06RKQ+Ai/W7krsSXmw8lVpYb8jWbZ7xvQ+UY3Ll9BZIfgW/7uKR/X9rw31bTXJ6BCrBgq8g5bevBLi+d9LDx3TROdBRa2ZZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763481; c=relaxed/simple;
	bh=wQnGWxW/lsCQklEB8sPLffgLUWX4VCLMzTrRwYYaBlM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8OlRQ+YofqCVr21oZBO7Eg5NTQ/eOxT3/3q8Bf1Ej3uIjdQOnQvVP4zcnw1rV/Ml2OzuGjifuJJsPTvrMy64C/H7Q0QZqQQrIRZlRqrz+H+mwwcFQ/FXXeE9Ep/P3aAybA6QOFxwkbXUaREjLhXHT93L8W0g1ayM8PE2MTyYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IXhqE4ed; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Gnpff001738;
	Mon, 9 Dec 2024 16:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8F6IIIUDruDCqpHYbeb8jF26ziBHJJCbUJR/ebXKLX8=; b=IXhqE4edXpWyQzvH
	93YA6h0T/O+F7b9belOgvFbR9sC1VyJ1yGalEwgs5WXQeakLxjd4K9KvcilyqLnU
	czoVGIpJ+lyDhs42emcJiBOQpB6usAZLXyqYchGyq0T4kqqIgwRCEqAR2rcsURPg
	l7yKMYAQjVg8gIARIUUV3ZbfiTRn84sjQAokqOyJnI+QkoxUoT8GFeofZIUCfXLf
	aQp7fExj5dThO+OyNRHzL86s00Ga65F3kONlbdDa+II+UiW+h9GO0bmjcSga5sJV
	pJTNibJy3rqwk3xeDO0fM6ppvBahHIUagd7qXEkqhCGSB9yqgKc01qjeH8A7bFWp
	aMh44w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdc6dnuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 16:57:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9GvrRJ019445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 16:57:53 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 08:57:49 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-kernel@vger.kernel.org>,
        Balamurugan S <quic_bselvara@quicinc.com>,
        "P
 Praneesh" <quic_ppranees@quicinc.com>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 13/13] wifi: ath12k: enable ath12k AHB support
Date: Mon, 9 Dec 2024 22:26:44 +0530
Message-ID: <20241209165644.1680167-14-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: CSsKsfVAGmJqoy_5ZHE7N9rjovRlb9IY
X-Proofpoint-GUID: CSsKsfVAGmJqoy_5ZHE7N9rjovRlb9IY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090132

From: Balamurugan S <quic_bselvara@quicinc.com>

Currently only PCI devices are supported in Ath12k driver. Refactor
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
index 52a1bb19e3da..b2bfcaca00b3 100644
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
index b5bb3e2599cd..4aeb6b95baa4 100644
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
index 49d1ac15cb7a..941924630bcb 100644
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
@@ -1685,5 +1688,31 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
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
index 06cff3849ab8..a5ae66f0ee1f 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -1821,7 +1821,7 @@ static struct pci_driver ath12k_pci_driver = {
 	.driver.pm = &ath12k_pci_pm_ops,
 };
 
-static int ath12k_pci_init(void)
+int ath12k_pci_init(void)
 {
 	int ret;
 
@@ -1832,16 +1832,10 @@ static int ath12k_pci_init(void)
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



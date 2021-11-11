Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961E044D213
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 07:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhKKG4q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 01:56:46 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:17304 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbhKKG4q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 01:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636613637; x=1668149637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3dZWcq9UD5b52Xq1UuiU6fkON15a4UIjdGgWcvMR+k0=;
  b=BwhYzeIw3QlCyKJrJNF0jM63PMWZqoWlhQjSQADE4RLkh8LX2J9eqPQF
   pBI+ZeZTHVYJ1e+4A/ofX4JCFkY6HwG5OYZqsOO45gy5xAuSBatNlZ2Rd
   K//RK87tCK83PJbikmkHcqhpYgVPDsE2VCMYVVTI39tlMDCnvVU3GKinn
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Nov 2021 22:53:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 22:53:57 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 22:53:57 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 22:53:55 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] ath11k: add string type to search board data in board-2.bin for WCN6855
Date:   Thu, 11 Nov 2021 01:53:40 -0500
Message-ID: <20211111065340.20187-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently ath11k only support string type with bus, chip id and board id
such as "bus=ahb,qmi-chip-id=1,qmi-board-id=4" for ahb bus chip and
"bus=pci,qmi-chip-id=0,qmi-board-id=255" for PCIe bus chip in
board-2.bin. For WCN6855, it is not enough to distinguish all different
chips.

This is to add a new string type which include bus, chip id, board id,
vendor, device, subsystem-vendor and subsystem-device for WCN6855.

ath11k will first load board-2.bin and search in it for the board data
with the above parameters, if matched one board data, then download it
to firmware, if not matched any one, then ath11k will download the file
board.bin to firmware.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Jouni Malinen <quic_jouni@quicinc.com>
---
v2: remove the mask of chip id and board id in ath11k_core_create_board_name()

 drivers/net/wireless/ath/ath11k/core.c | 27 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/core.h | 13 +++++++++++++
 drivers/net/wireless/ath/ath11k/pci.c  | 10 ++++++++++
 3 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 2012b0170e3c..3ac0dca997e1 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -473,11 +473,26 @@ static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 		scnprintf(variant, sizeof(variant), ",variant=%s",
 			  ab->qmi.target.bdf_ext);
 
-	scnprintf(name, name_len,
-		  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d%s",
-		  ath11k_bus_str(ab->hif.bus),
-		  ab->qmi.target.chip_id,
-		  ab->qmi.target.board_id, variant);
+	switch (ab->id.bdf_search) {
+	case ATH11K_BDF_SEARCH_BUS_AND_BOARD:
+		scnprintf(name, name_len,
+			  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%04x,qmi-board-id=%04x%s",
+			  ath11k_bus_str(ab->hif.bus),
+			  ab->id.vendor, ab->id.device,
+			  ab->id.subsystem_vendor,
+			  ab->id.subsystem_device,
+			  ab->qmi.target.chip_id,
+			  ab->qmi.target.board_id,
+			  variant);
+		break;
+	default:
+		scnprintf(name, name_len,
+			  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d%s",
+			  ath11k_bus_str(ab->hif.bus),
+			  ab->qmi.target.chip_id,
+			  ab->qmi.target.board_id, variant);
+		break;
+	}
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot using board name '%s'\n", name);
 
@@ -716,7 +731,7 @@ int ath11k_core_fetch_board_data_api_1(struct ath11k_base *ab,
 	return 0;
 }
 
-#define BOARD_NAME_SIZE 100
+#define BOARD_NAME_SIZE 200
 int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 {
 	char boardname[BOARD_NAME_SIZE];
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index dcc54d4cc096..81680da96156 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -54,6 +54,11 @@ enum ath11k_supported_bw {
 	ATH11K_BW_160	= 3,
 };
 
+enum ath11k_bdf_search {
+	ATH11K_BDF_SEARCH_DEFAULT,
+	ATH11K_BDF_SEARCH_BUS_AND_BOARD,
+};
+
 enum wme_ac {
 	WME_AC_BE,
 	WME_AC_BK,
@@ -893,6 +898,14 @@ struct ath11k_base {
 
 	struct completion htc_suspend;
 
+	struct {
+		enum ath11k_bdf_search bdf_search;
+		u32 vendor;
+		u32 device;
+		u32 subsystem_vendor;
+		u32 subsystem_device;
+	} id;
+
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index f262950ee414..a2acda28d35f 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1430,6 +1430,15 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_free_core;
 	}
 
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pci probe %04x:%04x %04x:%04x\n",
+		   pdev->vendor, pdev->device,
+		   pdev->subsystem_vendor, pdev->subsystem_device);
+
+	ab->id.vendor = pdev->vendor;
+	ab->id.device = pdev->device;
+	ab->id.subsystem_vendor = pdev->subsystem_vendor;
+	ab->id.subsystem_device = pdev->subsystem_device;
+
 	switch (pci_dev->device) {
 	case QCA6390_DEVICE_ID:
 		ath11k_pci_read_hw_version(ab, &soc_hw_version_major,
@@ -1452,6 +1461,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		ab->hw_rev = ATH11K_HW_QCN9074_HW10;
 		break;
 	case WCN6855_DEVICE_ID:
+		ab->id.bdf_search = ATH11K_BDF_SEARCH_BUS_AND_BOARD;
 		ath11k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
-- 
2.31.1


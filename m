Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B42473A8
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFPHeR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:34:17 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:36718 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbfFPHeR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:34:17 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 16 Jun 2019 09:26:15 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9289"; a="8499836"
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg02-ams.qualcomm.com with ESMTP; 16 Jun 2019 09:26:13 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Maya Erez <merez@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com, Tzahi Sabo <stzahi@codeaurora.org>
Subject: [PATCH 06/11] wil6210: clear FW and ucode log address
Date:   Sun, 16 Jun 2019 10:26:02 +0300
Message-Id: <1560669967-23706-7-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
References: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Clear the FW and ucode log address on device initialization to allow
user space app identify when the address was set by FW/ucode and it can
start read.

Signed-off-by: Tzahi Sabo <stzahi@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/main.c     | 15 +++++++++++++++
 drivers/net/wireless/ath/wil6210/pcie_bus.c |  1 +
 drivers/net/wireless/ath/wil6210/wil6210.h  |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 3c30076..f7b9e6b 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -1522,6 +1522,7 @@ int wil_ps_update(struct wil6210_priv *wil, enum wmi_ps_profile_type ps_profile)
 
 static void wil_pre_fw_config(struct wil6210_priv *wil)
 {
+	wil_clear_fw_log_addr(wil);
 	/* Mark FW as loaded from host */
 	wil_s(wil, RGF_USER_USAGE_6, 1);
 
@@ -1579,6 +1580,20 @@ static int wil_restore_vifs(struct wil6210_priv *wil)
 }
 
 /*
+ * Clear FW and ucode log start addr to indicate FW log is not ready. The host
+ * driver clears the addresses before FW starts and FW initializes the address
+ * when it is ready to send logs.
+ */
+void wil_clear_fw_log_addr(struct wil6210_priv *wil)
+{
+	/* FW log addr */
+	wil_w(wil, RGF_USER_USAGE_1, 0);
+	/* ucode log addr */
+	wil_w(wil, RGF_USER_USAGE_2, 0);
+	wil_dbg_misc(wil, "Cleared FW and ucode log address");
+}
+
+/*
  * We reset all the structures, and we reset the UMAC.
  * After calling this routine, you're expected to reload
  * the firmware.
diff --git a/drivers/net/wireless/ath/wil6210/pcie_bus.c b/drivers/net/wireless/ath/wil6210/pcie_bus.c
index 4e2d922..9f5a914 100644
--- a/drivers/net/wireless/ath/wil6210/pcie_bus.c
+++ b/drivers/net/wireless/ath/wil6210/pcie_bus.c
@@ -420,6 +420,7 @@ static int wil_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 	/* rollback to bus_disable */
 
+	wil_clear_fw_log_addr(wil);
 	rc = wil_if_add(wil);
 	if (rc) {
 		wil_err(wil, "wil_if_add failed: %d\n", rc);
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 75abec2..afbc524 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1425,4 +1425,5 @@ int wmi_addba_rx_resp_edma(struct wil6210_priv *wil, u8 mid, u8 cid,
 
 void update_supported_bands(struct wil6210_priv *wil);
 
+void wil_clear_fw_log_addr(struct wil6210_priv *wil);
 #endif /* __WIL6210_H__ */
-- 
1.9.1


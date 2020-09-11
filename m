Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70F42667E3
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgIKRyx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:54:53 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50266 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbgIKRyu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 13:54:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kGn6M-0028eU-Iu; Fri, 11 Sep 2020 20:44:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 20:44:34 +0300
Message-Id: <iwlwifi.20200911204056.37d90f9ceb0c.I8dfe8a7d3a7ac9f0bc9d93e4a03f8165d8c999d2@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911174439.163225-1-luca@coelho.fi>
References: <20200911174439.163225-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/11] iwlwifi: msix: limit max RX queues for 9000 family
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

There is an issue in the HW DMA engine in the 9000 family of devices
when more than 6 RX queues are used.  The issue is that the FW may
hang when IWL_MVM_RXQ_NSSN_SYNC notifications are sent.

Fix this by limiting the number of RX queues to 6 in the 9000 family
of devices.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h  | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 34788e7afc7b..32ea4c3c7d23 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -316,6 +316,7 @@ static inline void iwl_free_rxb(struct iwl_rx_cmd_buffer *r)
 #define IWL_MGMT_TID		15
 #define IWL_FRAME_LIMIT	64
 #define IWL_MAX_RX_HW_QUEUES	16
+#define IWL_9000_MAX_RX_HW_QUEUES	6
 
 /**
  * enum iwl_wowlan_status - WoWLAN image/device status
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index e5160d620868..a59684e82713 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1607,11 +1607,15 @@ iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int max_irqs, num_irqs, i, ret;
 	u16 pci_cmd;
+	u32 max_rx_queues = IWL_MAX_RX_HW_QUEUES;
 
 	if (!cfg_trans->mq_rx_supported)
 		goto enable_msi;
 
-	max_irqs = min_t(u32, num_online_cpus() + 2, IWL_MAX_RX_HW_QUEUES);
+	if (cfg_trans->device_family <= IWL_DEVICE_FAMILY_9000)
+		max_rx_queues = IWL_9000_MAX_RX_HW_QUEUES;
+
+	max_irqs = min_t(u32, num_online_cpus() + 2, max_rx_queues);
 	for (i = 0; i < max_irqs; i++)
 		trans_pcie->msix_entries[i].entry = i;
 
-- 
2.28.0


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8ED34FC59
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 11:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhCaJPI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 05:15:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43754 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234697AbhCaJO7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 05:14:59 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lRWwC-00087q-OO; Wed, 31 Mar 2021 12:14:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Mar 2021 12:14:45 +0300
Message-Id: <iwlwifi.20210331121101.5b807533b0c0.I07b58a5c9238f75413a91198452ba1268ee79425@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210331091452.543321-1-luca@coelho.fi>
References: <20210331091452.543321-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 05/12] iwlwifi: pcie: try to grab NIC access early
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Sometimes some NICs may fail to initialize, but if we have
such a scenario we may only see an alive timeout (i.e. the
firmware doesn't send us the alive message), and that will
only cause us to fail the interface up.

Try to once grab NIC access during device probe to ensure
we can properly talk to the hardware at all, and to do all
the potential workarounds in that function.

Since we now finish NIC init here, we can remove it from
the later potential read of the RF ID.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 8e3fc160e083..3186de93d769 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1112,6 +1112,24 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(iwl_trans);
 
+	/*
+	 * Let's try to grab NIC access early here. Sometimes, NICs may
+	 * fail to initialize, and if that happens it's better if we see
+	 * issues early on (and can reprobe, per the logic inside), than
+	 * first trying to load the firmware etc. and potentially only
+	 * detecting any problems when the first interface is brought up.
+	 */
+	ret = iwl_finish_nic_init(iwl_trans, trans);
+	if (ret)
+		goto out_free_trans;
+	if (iwl_trans_grab_nic_access(iwl_trans)) {
+		/* all good */
+		iwl_trans_release_nic_access(iwl_trans);
+	} else {
+		ret = -EIO;
+		goto out_free_trans;
+	}
+
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
 
 	for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
-- 
2.31.0


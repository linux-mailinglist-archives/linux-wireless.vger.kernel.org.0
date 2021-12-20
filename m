Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5343047A9B8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 13:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhLTMd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 07:33:27 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51532 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230089AbhLTMd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 07:33:26 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mzHr2-001OhV-Bu; Mon, 20 Dec 2021 14:33:25 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 20 Dec 2021 14:33:17 +0200
Message-Id: <iwlwifi.20211220142940.c7bb5b7644df.I48498d9fd6e3959562205af67aa5f1a822eb762d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211220123318.345841-1-luca@coelho.fi>
References: <20211220123318.345841-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 1/2] iwlwifi: mei: clear the ownership when the driver goes down
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When the driver is unregistered, CSME will take ownership on the
device. Reflect this in the iwlmei object so that we will remember
to re-ask for ownership when the driver will register again.

Not doing so will cause CSME not to give the host ownership and
we will see the following error message when trying to bring up
the interface:

iwlwifi 0000:a9:00.0: iwl_pcie_prepare_card_hw iwl_trans_prepare_card_hw enter
iwlwifi 0000:a9:00.0: iwl_pcie_set_hw_ready hardware not ready
iwlwifi 0000:a9:00.0: iwl_pcie_set_hw_ready hardware not ready
iwlwifi 0000:a9:00.0: iwl_pcie_prepare_card_hw Couldn't prepare the card but SAP is connected
iwlwifi 0000:a9:00.0: Error while preparing HW: -16

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 4453cd2571c2..787d64276f36 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1703,6 +1703,7 @@ void iwl_mei_unregister_complete(void)
 			mei_cldev_get_drvdata(iwl_mei_global_cldev);
 
 		iwl_mei_send_sap_msg(mei->cldev, SAP_MSG_NOTIF_WIFIDR_DOWN);
+		mei->got_ownership = false;
 	}
 
 	mutex_unlock(&iwl_mei_mutex);
-- 
2.34.1


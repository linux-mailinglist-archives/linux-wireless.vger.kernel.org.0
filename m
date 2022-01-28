Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4498E49F967
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348436AbiA1MbX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:31:23 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37828 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348453AbiA1MbX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:31:23 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDQPN-0002A0-U6;
        Fri, 28 Jan 2022 14:31:22 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:30:55 +0200
Message-Id: <iwlwifi.20220128142706.cc51e6a6d635.I4b74a082eb8d89f9e4f556a27c4339c15444dc6c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128123057.524038-1-luca@coelho.fi>
References: <20220128123057.524038-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.17 6/8] iwlwifi: mei: retry mapping the shared area
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The shared area is a DMA memory allocated in the host and
mapped so that the host and the CSME firmware can
exchange data. It is mapped through a dedicated PCI device
that is driven by the mei bus driver.

The bus driver is in charge of allocating and mapping this
memory. It also needs to configure the CSME firmware with
a specific set of commands, so that the CSME firmware will
know that this memory is meant to be used by its internal
WLAN module.

For this, the CSME firmware first needs to completely
initialize its WLAN module and only then get the mapping
request.

The problem is that the mei bus enumeration completes
before the WLAN is completely ready. This means that
the WLAN module's initialization is racing with iwlmei's
allocation and mapping flow.

Testing showed a problem in resume flows where iwlmei
was too fast and the DMA mapping failed.

Add a retry mechanism to make sure that we will succeed
to map the memory.

Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: bcbddc4f9d02 ("iwlwifi: mei: wait before mapping the shared area")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 35 ++++++++++++++-----
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index d9733aaf6f6e..6cc5553027a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -229,8 +229,6 @@ static int iwl_mei_alloc_shared_mem(struct mei_cl_device *cldev)
 	if (IS_ERR(mem->ctrl)) {
 		int ret = PTR_ERR(mem->ctrl);
 
-		dev_err(&cldev->dev, "Couldn't allocate the shared memory: %d\n",
-			ret);
 		mem->ctrl = NULL;
 
 		return ret;
@@ -1784,6 +1782,8 @@ static void iwl_mei_dbgfs_unregister(struct iwl_mei *mei) {}
 
 #endif /* CONFIG_DEBUG_FS */
 
+#define ALLOC_SHARED_MEM_RETRY_MAX_NUM	3
+
 /*
  * iwl_mei_probe - the probe function called by the mei bus enumeration
  *
@@ -1795,6 +1795,7 @@ static void iwl_mei_dbgfs_unregister(struct iwl_mei *mei) {}
 static int iwl_mei_probe(struct mei_cl_device *cldev,
 			 const struct mei_cl_device_id *id)
 {
+	int alloc_retry = ALLOC_SHARED_MEM_RETRY_MAX_NUM;
 	struct iwl_mei *mei;
 	int ret;
 
@@ -1812,15 +1813,31 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 	mei_cldev_set_drvdata(cldev, mei);
 	mei->cldev = cldev;
 
-	/*
-	 * The CSME firmware needs to boot the internal WLAN client. Wait here
-	 * so that the DMA map request will succeed.
-	 */
-	msleep(20);
+	do {
+		ret = iwl_mei_alloc_shared_mem(cldev);
+		if (!ret)
+			break;
+		/*
+		 * The CSME firmware needs to boot the internal WLAN client.
+		 * This can take time in certain configurations (usually
+		 * upon resume and when the whole CSME firmware is shut down
+		 * during suspend).
+		 *
+		 * Wait a bit before retrying and hope we'll succeed next time.
+		 */
 
-	ret = iwl_mei_alloc_shared_mem(cldev);
-	if (ret)
+		dev_dbg(&cldev->dev,
+			"Couldn't allocate the shared memory: %d, attempt %d / %d\n",
+			ret, alloc_retry, ALLOC_SHARED_MEM_RETRY_MAX_NUM);
+		msleep(100);
+		alloc_retry--;
+	} while (alloc_retry);
+
+	if (ret) {
+		dev_err(&cldev->dev, "Couldn't allocate the shared memory: %d\n",
+			ret);
 		goto free;
+	}
 
 	iwl_mei_init_shared_mem(mei);
 
-- 
2.34.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591D647A9B9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 13:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhLTMd2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 07:33:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51538 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229596AbhLTMd1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 07:33:27 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mzHr3-001OhV-Hg; Mon, 20 Dec 2021 14:33:26 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 20 Dec 2021 14:33:18 +0200
Message-Id: <iwlwifi.20211220142940.8b6279e3d0be.I6fe128b0b86149a85535104822c8355b367887c8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211220123318.345841-1-luca@coelho.fi>
References: <20211220123318.345841-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 2/2] iwlwifi: mei: wait before mapping the shared area
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

Add a delay to avoid this. This is still racy, but our
measurements showed that we have a good margin and we
should now be safe.

Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 787d64276f36..bee3415ef460 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1810,6 +1810,12 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 	mei_cldev_set_drvdata(cldev, mei);
 	mei->cldev = cldev;
 
+	/*
+	 * The CSME firmware needs to boot the internal WLAN client. Wait here
+	 * so that the DMA map request will succeed.
+	 */
+	msleep(20);
+
 	ret = iwl_mei_alloc_shared_mem(cldev);
 	if (ret)
 		goto free;
-- 
2.34.1


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B181331660B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhBJMHa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:07:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45036 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230360AbhBJMFA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 07:05:00 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9o6v-0049Ur-EY; Wed, 10 Feb 2021 13:56:45 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 13:56:37 +0200
Message-Id: <iwlwifi.20210210135352.a97272169e3f.Ic4acfb3f7b4e9d7b49c9c0b9a31c9a305d4d9fcc@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210115637.276676-1-luca@coelho.fi>
References: <20210210115637.276676-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 12/12] iwlwifi: pcie: Change Ma device ID
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matti Gottlieb <matti.gottlieb@intel.com>

The Ma device ID needs to be 0x7E40 instead of 0x7E80.

Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index edd1a0fe19c3..3e149141fec5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -488,7 +488,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 
 /* Ma devices */
 	{IWL_PCI_DEVICE(0x2729, PCI_ANY_ID, iwl_ma_trans_cfg)},
-	{IWL_PCI_DEVICE(0x7E80, PCI_ANY_ID, iwl_ma_trans_cfg)},
+	{IWL_PCI_DEVICE(0x7E40, PCI_ANY_ID, iwl_ma_trans_cfg)},
 
 #endif /* CONFIG_IWLMVM */
 
-- 
2.30.0


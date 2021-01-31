Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE34A309C6C
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 15:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhAaNo5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 08:44:57 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:42892 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231434AbhAaL2p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 06:28:45 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6AY2-004131-A7; Sun, 31 Jan 2021 13:05:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 13:05:29 +0200
Message-Id: <iwlwifi.20210131125922.455e59ba3a4c.I49ebb07382e6d11dc8f50e6a58d579681209cb1d@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131110533.887130-1-luca@coelho.fi>
References: <20210131110533.887130-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/12] iwlwifi: pcie: add support for SnJ with Hr1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add an entry for SnJ with Hr1.  This device should use the
tx_with_siso_diversity option, but that doesn't work at the moment.
So we leave it disabled for now (and use the same struct as Hr2).

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 462ff6114c69..f0acf7fe59fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -958,6 +958,12 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      iwl_cfg_snj_a0_jf_b0, iwl9560_name),
 
 /* SnJ with Hr */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_snj_hr_b0, iwl_ax101_name),
+
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-- 
2.29.2


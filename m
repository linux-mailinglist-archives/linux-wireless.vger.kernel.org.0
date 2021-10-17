Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45143098C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbhJQOCR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 10:02:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53970 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343805AbhJQOCP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 10:02:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6hm-000Yi6-2y; Sun, 17 Oct 2021 17:00:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:59:51 +0300
Message-Id: <iwlwifi.20211017165728.d931a48ad8bd.I9b027837cba3478c9bb74c3f07df48eaef70a197@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017135954.504836-1-luca@coelho.fi>
References: <20211017135954.504836-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/10] wlwifi: add new device id 7F70
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yaara Baruch <yaara.baruch@intel.com>

Add new 7F70 device to cards id struct.
Add new 7F70 DID killers devices.

Signed-off-by: Yaara Baruch <yaara.baruch@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 677c2249b13f..c85775554576 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -499,6 +499,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 /* Ma devices */
 	{IWL_PCI_DEVICE(0x2729, PCI_ANY_ID, iwl_ma_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7E40, PCI_ANY_ID, iwl_ma_trans_cfg)},
+	{IWL_PCI_DEVICE(0x7F70, PCI_ANY_ID, iwl_ma_trans_cfg)},
 
 /* Bz devices */
 	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
@@ -668,6 +669,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2726, 0x1672, iwlax211_cfg_snj_gf_a0, iwl_ax211_killer_1675i_name),
 	IWL_DEV_INFO(0x2726, 0x1691, iwlax411_2ax_cfg_sosnj_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x2726, 0x1692, iwlax411_2ax_cfg_sosnj_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7F70, 0x1691, iwlax411_2ax_cfg_sosnj_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7F70, 0x1692, iwlax411_2ax_cfg_sosnj_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
-- 
2.33.0


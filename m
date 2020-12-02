Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65D2CBD36
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 13:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgLBMmn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 07:42:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33968 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726736AbgLBMmn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 07:42:43 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kkRSG-0037gb-I2; Wed, 02 Dec 2020 14:41:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  2 Dec 2020 14:41:51 +0200
Message-Id: <iwlwifi.20201202143859.a06ba7540449.I7390305d088a49c1043c9b489154fe057989c18f@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202124151.55050-1-luca@coelho.fi>
References: <20201202124151.55050-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 3/3] iwlwifi: pcie: add some missing entries for AX210
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Golan Ben Ami <golan.ben.ami@intel.com>

Some subsytem device IDs were missing from the list, so some AX210
devices were not recognized.  Add them.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 466a967da39c..7b5ece380fbf 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -540,6 +540,11 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x0510, iwlax210_2ax_cfg_ty_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x0A10, iwlax210_2ax_cfg_ty_gf_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0xE020, iwlax210_2ax_cfg_ty_gf_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0xE024, iwlax210_2ax_cfg_ty_gf_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0x4020, iwlax210_2ax_cfg_ty_gf_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0x6020, iwlax210_2ax_cfg_ty_gf_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0x6024, iwlax210_2ax_cfg_ty_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0)},
 	{IWL_PCI_DEVICE(0x2726, 0x0070, iwlax201_cfg_snj_hr_b0)},
 	{IWL_PCI_DEVICE(0x2726, 0x0074, iwlax201_cfg_snj_hr_b0)},
-- 
2.29.2


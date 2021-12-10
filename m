Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492CE46FB12
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhLJHKG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50828 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233193AbhLJHKG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:06 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZzB-001F9v-J1; Fri, 10 Dec 2021 09:06:29 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:16 +0200
Message-Id: <iwlwifi.20211210090244.27fe6abf2e4c.I806e4b47dabddaa8ac27172e7cfa3d719c100e8f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210070621.236783-1-luca@coelho.fi>
References: <20211210070621.236783-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/11] iwlwifi: mvm: Add list of OEMs allowed to use TAS
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Barazani <ayala.barazani@intel.com>

Add list of vendors that are allowed to use TAS and check it
against the value provided in the SMBIOS manufacturer field.
Initially add the following approved vendors: HP, Dell, Lenovo and Samsung.

Signed-off-by: Ayala Barazani <ayala.barazani@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 45 +++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 72227c87c6b9..19a18b626069 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1153,11 +1153,38 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 	return iwl_mvm_ppag_send_cmd(mvm);
 }
 
+static const struct dmi_system_id dmi_tas_approved_list[] = {
+	{ .ident = "HP",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+		},
+	},
+	{ .ident = "SAMSUNG",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD"),
+		},
+	},
+		{ .ident = "LENOVO",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lenovo"),
+		},
+	},
+	{ .ident = "DELL",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+	},
+
+	/* keep last */
+	{}
+};
+
 static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 {
 	int ret;
 	struct iwl_tas_config_cmd_v3 cmd = {};
 	int cmd_size;
+	const struct ieee80211_regdomain *regd;
 
 	BUILD_BUG_ON(ARRAY_SIZE(cmd.block_list_array) <
 		     APCI_WTAS_BLACK_LIST_MAX);
@@ -1167,6 +1194,24 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 	}
 
+	/* Get the MCC from cfg80211 */
+	regd = wiphy_dereference(mvm->hw->wiphy, mvm->hw->wiphy->regd);
+
+	if (!regd) {
+		IWL_DEBUG_RADIO(mvm, "MCC is unavailable\n");
+		return;
+	}
+
+	if ((regd->alpha2[0] == 'U' && regd->alpha2[1] == 'S') ||
+	    (regd->alpha2[0] == 'C' && regd->alpha2[1] == 'A')) {
+		if (!dmi_check_system(dmi_tas_approved_list)) {
+			IWL_DEBUG_RADIO(mvm,
+					"System vendor '%s' is not in the approved list, disabling TAS.\n",
+					dmi_get_system_info(DMI_SYS_VENDOR));
+			return;
+		}
+	}
+
 	ret = iwl_acpi_get_tas(&mvm->fwrt, &cmd);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
-- 
2.34.1


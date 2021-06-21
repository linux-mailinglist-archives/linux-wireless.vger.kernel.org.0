Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5C3AE43D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 09:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFUHkC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 03:40:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48406 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229618AbhFUHkC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 03:40:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvEV5-001aFa-SK; Mon, 21 Jun 2021 10:37:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 21 Jun 2021 10:37:32 +0300
Message-Id: <iwlwifi.20210621103449.73eceb822890.I37347afbc01497a8a9e4d4afe4fa9a965abd31ac@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621073740.1105911-1-luca@coelho.fi>
References: <20210621073740.1105911-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 1/9] iwlwifi: mvm: update iwl_wowlan_patterns_cmd
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We need to pass the station id to tell the firmware
on which station we want to configure the patterns.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h | 14 ++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c    | 13 ++++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index a9e8f30ef91d..4dbf24128a98 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -318,13 +318,23 @@ struct iwl_wowlan_patterns_cmd {
 	/**
 	 * @n_patterns: number of patterns
 	 */
-	__le32 n_patterns;
+	u8 n_patterns;
+
+	/**
+	 * @n_patterns: sta_id
+	 */
+	u8 sta_id;
+
+	/**
+	 * @reserved: reserved for alignment
+	 */
+	__le16 reserved;
 
 	/**
 	 * @patterns: the patterns, array length in @n_patterns
 	 */
 	struct iwl_wowlan_pattern_v2 patterns[];
-} __packed; /* WOWLAN_PATTERN_ARRAY_API_S_VER_2 */
+} __packed; /* WOWLAN_PATTERN_ARRAY_API_S_VER_3 */
 
 enum iwl_wowlan_wakeup_filters {
 	IWL_WOWLAN_WAKEUP_MAGIC_PACKET			= BIT(0),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 7b13c4fc1b58..8e5814a3b178 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -393,14 +393,19 @@ static int iwl_mvm_send_patterns_v1(struct iwl_mvm *mvm,
 }
 
 static int iwl_mvm_send_patterns(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
 				 struct cfg80211_wowlan *wowlan)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_wowlan_patterns_cmd *pattern_cmd;
 	struct iwl_host_cmd cmd = {
 		.id = WOWLAN_PATTERNS,
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
 	};
 	int i, err;
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					WOWLAN_PATTERNS,
+					IWL_FW_CMD_VER_UNKNOWN);
 
 	if (!wowlan->n_patterns)
 		return 0;
@@ -408,11 +413,13 @@ static int iwl_mvm_send_patterns(struct iwl_mvm *mvm,
 	cmd.len[0] = sizeof(*pattern_cmd) +
 		wowlan->n_patterns * sizeof(struct iwl_wowlan_pattern_v2);
 
-	pattern_cmd = kmalloc(cmd.len[0], GFP_KERNEL);
+	pattern_cmd = kzalloc(cmd.len[0], GFP_KERNEL);
 	if (!pattern_cmd)
 		return -ENOMEM;
 
-	pattern_cmd->n_patterns = cpu_to_le32(wowlan->n_patterns);
+	pattern_cmd->n_patterns = wowlan->n_patterns;
+	if (ver >= 3)
+		pattern_cmd->sta_id = mvmvif->ap_sta_id;
 
 	for (i = 0; i < wowlan->n_patterns; i++) {
 		int mask_len = DIV_ROUND_UP(wowlan->patterns[i].pattern_len, 8);
@@ -887,7 +894,7 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
 		       IWL_UCODE_TLV_API_WOWLAN_TCP_SYN_WAKE))
-		ret = iwl_mvm_send_patterns(mvm, wowlan);
+		ret = iwl_mvm_send_patterns(mvm, vif, wowlan);
 	else
 		ret = iwl_mvm_send_patterns_v1(mvm, wowlan);
 	if (ret)
-- 
2.32.0


Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D757549FACD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348922AbiA1Nep (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:45 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37852 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348905AbiA1Neo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:44 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROk-0002DK-65;
        Fri, 28 Jan 2022 15:34:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:26 +0200
Message-Id: <iwlwifi.20220128153014.eb696eb56bf6.Ide1dd041f9b908c5154a600286a7453750b0704a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/13] iwlwifi: de-const properly where needed
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: "Bjoern A. Zeeb" <bz@FreeBSD.ORG>

In order to de-const variables simply casting through (void *) is
not enough: "cast from 'const .. *' to 'void *' drops const qualifier".
Cast through (uintptr_t) as well [1] to make this compile on systems
with more strict requirements.
In addition passing const void *data to dma_map_single() also
drops the (const) qualifier.  De-constify on variable on assignment
which may be overwritten later.  In either case the (void *) cast
to dma_map_single() is not needed (anymore) either.

[1] See __DECONST() in sys/sys/cdefs.h in FreeBSD

Sponsored by:  The FreeBSD Foundation
Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c      | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c1dfc4702b5b..6808445f80e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3195,7 +3195,7 @@ static void iwl_mvm_reset_cca_40mhz_workaround(struct iwl_mvm *mvm,
 
 	if (he_cap) {
 		/* we know that ours is writable */
-		struct ieee80211_sta_he_cap *he = (void *)he_cap;
+		struct ieee80211_sta_he_cap *he = (void *)(uintptr_t)he_cap;
 
 		he->he_cap_elem.phy_cap_info[0] |=
 			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 1d2a4b711e5e..ba19ed30f85a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -191,7 +191,7 @@ static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 
 	if (he_cap) {
 		/* we know that ours is writable */
-		struct ieee80211_sta_he_cap *he = (void *)he_cap;
+		struct ieee80211_sta_he_cap *he = (void *)(uintptr_t)he_cap;
 
 		WARN_ON(!he->has_he);
 		WARN_ON(!(he->he_cap_elem.phy_cap_info[0] &
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 34bde8c87324..c72a84d8bb4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -213,7 +213,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 
 	/* map the remaining (adjusted) nocopy/dup fragments */
 	for (i = 0; i < IWL_MAX_CMD_TBS_PER_TFD; i++) {
-		const void *data = cmddata[i];
+		void *data = (void *)(uintptr_t)cmddata[i];
 
 		if (!cmdlen[i])
 			continue;
@@ -222,7 +222,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 			continue;
 		if (cmd->dataflags[i] & IWL_HCMD_DFL_DUP)
 			data = dup_buf;
-		phys_addr = dma_map_single(trans->dev, (void *)data,
+		phys_addr = dma_map_single(trans->dev, data,
 					   cmdlen[i], DMA_TO_DEVICE);
 		if (dma_mapping_error(trans->dev, phys_addr)) {
 			idx = -ENOMEM;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index d54a8df280a5..3c8415f95808 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1114,7 +1114,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 
 	/* map the remaining (adjusted) nocopy/dup fragments */
 	for (i = 0; i < IWL_MAX_CMD_TBS_PER_TFD; i++) {
-		const void *data = cmddata[i];
+		void *data = (void *)(uintptr_t)cmddata[i];
 
 		if (!cmdlen[i])
 			continue;
@@ -1123,7 +1123,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
 			continue;
 		if (cmd->dataflags[i] & IWL_HCMD_DFL_DUP)
 			data = dup_buf;
-		phys_addr = dma_map_single(trans->dev, (void *)data,
+		phys_addr = dma_map_single(trans->dev, data,
 					   cmdlen[i], DMA_TO_DEVICE);
 		if (dma_mapping_error(trans->dev, phys_addr)) {
 			iwl_txq_gen1_tfd_unmap(trans, out_meta, txq,
-- 
2.34.1


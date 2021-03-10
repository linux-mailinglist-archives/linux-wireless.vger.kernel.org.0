Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AB8334076
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 15:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhCJOkS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 09:40:18 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:30191 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhCJOjt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 09:39:49 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 112367B83E;
        Wed, 10 Mar 2021 14:39:48 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DwZVC6mbbz3NmF;
        Wed, 10 Mar 2021 14:39:47 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mx1.sbone.de (cross.sbone.de [195.201.62.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id C60A81EBE;
        Wed, 10 Mar 2021 14:39:47 +0000 (UTC)
        (envelope-from bz@FreeBSD.ORG)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id AC4FD8D4A156;
        Wed, 10 Mar 2021 14:39:46 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id 2EA08E707E0;
        Wed, 10 Mar 2021 14:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id fScZqXgwYCL5; Wed, 10 Mar 2021 14:39:44 +0000 (UTC)
Received: from nv.sbone.de (nv.sbone.de [IPv6:fde9:577b:c1a9:31::2013:138])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id CCE71E707DE;
        Wed, 10 Mar 2021 14:39:43 +0000 (UTC)
Date:   Wed, 10 Mar 2021 14:39:43 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.ORG>
To:     linux-wireless@vger.kernel.org
cc:     luciano.coelho@intel.com
Subject: [PATCH v2 iwlwifi-next] iwlwifi: de-const properly where needed
Message-ID: <alpine.BSF.2.00.2103101439380.72241@ai.fobar.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
---
changes since v1 - reduce diff context
---
  drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
  drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 2 +-
  drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 4 ++--
  drivers/net/wireless/intel/iwlwifi/pcie/tx.c      | 4 ++--
  4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index baf7404c137d..3cad9c1d6814 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3047,7 +3047,7 @@ static void iwl_mvm_reset_cca_40mhz_workaround(struct iwl_mvm *mvm,

  	if (he_cap) {
  		/* we know that ours is writable */
-		struct ieee80211_sta_he_cap *he = (void *)he_cap;
+		struct ieee80211_sta_he_cap *he = (void *)(uintptr_t)he_cap;

  		he->he_cap_elem.phy_cap_info[0] |=
  			IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index ebed82c590e5..e79ca96e5844 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -198,7 +198,7 @@ static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,

  	if (he_cap) {
  		/* we know that ours is writable */
-		struct ieee80211_sta_he_cap *he = (void *)he_cap;
+		struct ieee80211_sta_he_cap *he = (void *)(uintptr_t)he_cap;

  		WARN_ON(!he->has_he);
  		WARN_ON(!(he->he_cap_elem.phy_cap_info[0] &
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 4456abb9a074..afd3e69d629b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -212,7 +212,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,

  	/* map the remaining (adjusted) nocopy/dup fragments */
  	for (i = 0; i < IWL_MAX_CMD_TBS_PER_TFD; i++) {
-		const void *data = cmddata[i];
+		void *data = (void *)(uintptr_t)cmddata[i];

  		if (!cmdlen[i])
  			continue;
@@ -221,7 +221,7 @@ int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
  			continue;
  		if (cmd->dataflags[i] & IWL_HCMD_DFL_DUP)
  			data = dup_buf;
-		phys_addr = dma_map_single(trans->dev, (void *)data,
+		phys_addr = dma_map_single(trans->dev, data,
  					   cmdlen[i], DMA_TO_DEVICE);
  		if (dma_mapping_error(trans->dev, phys_addr)) {
  			idx = -ENOMEM;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 94ff80a2b8cd..c4d3eaf840f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1127,7 +1127,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,

  	/* map the remaining (adjusted) nocopy/dup fragments */
  	for (i = 0; i < IWL_MAX_CMD_TBS_PER_TFD; i++) {
-		const void *data = cmddata[i];
+		void *data = (void *)(uintptr_t)cmddata[i];

  		if (!cmdlen[i])
  			continue;
@@ -1136,7 +1136,7 @@ int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
  			continue;
  		if (cmd->dataflags[i] & IWL_HCMD_DFL_DUP)
  			data = dup_buf;
-		phys_addr = dma_map_single(trans->dev, (void *)data,
+		phys_addr = dma_map_single(trans->dev, data,
  					   cmdlen[i], DMA_TO_DEVICE);
  		if (dma_mapping_error(trans->dev, phys_addr)) {
  			iwl_txq_gen1_tfd_unmap(trans, out_meta, txq,

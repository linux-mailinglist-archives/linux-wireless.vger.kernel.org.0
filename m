Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C033BD0EF
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jul 2021 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhGFLhj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jul 2021 07:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237417AbhGFLgI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jul 2021 07:36:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56CFD61D8B;
        Tue,  6 Jul 2021 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570852;
        bh=xGHE1GzfeUaCbq123ZkdknOkaKgkF8UPgtE/Z3QZN1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHBu/vuWp7ELIClXkB90UWnjknVQ5lo3LODzTO0dAJXCAUsRFAhSw2zkN4G90nfn3
         F1fjuPFBruQcJleIDRuj0ZTmK2GeaBACE9esB7WnZW/IoBv0WYaXGPgF06iwZAb/V4
         JoRSxjfO0bsQD+W5nHkDTfzDNP3BaPgsmdzjHfoNt+ZHtCcYCJvMX13ZWCNWNBWptS
         C8llcAuJTLY7DYe6b1nCI7+no0IGpb38K49VIyny/EYWFyJGLrBJOQ0dEi+cbEEjB8
         MMMxMp8QBG6sT+3O8wAzzKbVkQAnNffXVHvoLI1kbxHmCMpj0Wwrl27AokSxxGzugx
         rI7vaHVnfIPmA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 42/55] iwlwifi: mvm: don't change band on bound PHY contexts
Date:   Tue,  6 Jul 2021 07:26:25 -0400
Message-Id: <20210706112638.2065023-42-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112638.2065023-1-sashal@kernel.org>
References: <20210706112638.2065023-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 8835a64f74c46baebfc946cd5a2c861b866ebcee ]

When we have a P2P Device active, we attempt to only change the
PHY context it uses when we get a new remain-on-channel, if the
P2P Device is the only user of the PHY context.

This is fine if we're switching within a band, but if we're
switching bands then the switch implies a removal and re-add
of the PHY context, which isn't permitted by the firmware while
it's bound to an interface.

Fix the code to skip the unbind/release/... cycle only if the
band doesn't change (or we have old devices that can switch the
band on the fly as well.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20210612142637.e9ac313f70f3.I713b9d109957df7e7d9ed0861d5377ce3f8fccd3@changeid
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 2fad20c845b4..697a66acba9c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3496,6 +3496,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct cfg80211_chan_def chandef;
 	struct iwl_mvm_phy_ctxt *phy_ctxt;
+	bool band_change_removal;
 	int ret, i;
 
 	IWL_DEBUG_MAC80211(mvm, "enter (%d, %d, %d)\n", channel->hw_value,
@@ -3565,19 +3566,30 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 	cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
 
 	/*
-	 * Change the PHY context configuration as it is currently referenced
-	 * only by the P2P Device MAC
+	 * Check if the remain-on-channel is on a different band and that
+	 * requires context removal, see iwl_mvm_phy_ctxt_changed(). If
+	 * so, we'll need to release and then re-configure here, since we
+	 * must not remove a PHY context that's part of a binding.
 	 */
-	if (mvmvif->phy_ctxt->ref == 1) {
+	band_change_removal =
+		fw_has_capa(&mvm->fw->ucode_capa,
+			    IWL_UCODE_TLV_CAPA_BINDING_CDB_SUPPORT) &&
+		mvmvif->phy_ctxt->channel->band != chandef.chan->band;
+
+	if (mvmvif->phy_ctxt->ref == 1 && !band_change_removal) {
+		/*
+		 * Change the PHY context configuration as it is currently
+		 * referenced only by the P2P Device MAC (and we can modify it)
+		 */
 		ret = iwl_mvm_phy_ctxt_changed(mvm, mvmvif->phy_ctxt,
 					       &chandef, 1, 1);
 		if (ret)
 			goto out_unlock;
 	} else {
 		/*
-		 * The PHY context is shared with other MACs. Need to remove the
-		 * P2P Device from the binding, allocate an new PHY context and
-		 * create a new binding
+		 * The PHY context is shared with other MACs (or we're trying to
+		 * switch bands), so remove the P2P Device from the binding,
+		 * allocate an new PHY context and create a new binding.
 		 */
 		phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
 		if (!phy_ctxt) {
-- 
2.30.2


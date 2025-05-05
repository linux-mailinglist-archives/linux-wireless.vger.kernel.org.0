Return-Path: <linux-wireless+bounces-22496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535DEAAA261
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399B516E198
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690C2DAF67;
	Mon,  5 May 2025 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV4C+cUX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E770280A46;
	Mon,  5 May 2025 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483692; cv=none; b=Jh8JroejA/8STVjw77sW+lGThq83YxQlFoO5tm8+f8/oQbDNwyH+VgBmGMz/QT9BcX/0/D3AKaBw9Zn4+d9zgZLsRaYTCh8+u0dZACt4ABv8E7N/5JHVD+WrvDbvYWMg7A/hGDfDjNID+4PAS1217NHIZ1JnhKqx2QNjLWqPLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483692; c=relaxed/simple;
	bh=0Ehhq6ZLfaoGSMn1iIEozrPKoZu2t4uXZ43XmQknaIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTiOAu5PKbASisk0Q8QTahdq1SuMJMqzTLe3K/ZBqHkf+roXyHWuJRvi5irNPnMNM0HgEBxJGtc2B9jP6qsrVaqmKex2okS1VXNVoxJ38jExPYPmlTdAjVst2nVHxuK3KUgofaCK3fszHtw17ofrENH+DfLyqgtkPLICptfce9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV4C+cUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852FFC4CEE4;
	Mon,  5 May 2025 22:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483692;
	bh=0Ehhq6ZLfaoGSMn1iIEozrPKoZu2t4uXZ43XmQknaIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gV4C+cUXHJdENsYf0de5LqFKP2twdjhdOvlcgHhsVOk0llW0sRpeVewLi+xU3XeTY
	 h7hnRcd2gDD41kd8vOD/3vwIjEPpPYPBZLmJcFqNDB4M5qvEiEZo2XGUYEdIpivfXD
	 ZvUF8rP/kXvL6GNJQeoHoSjp+cftrvtAfT1bnFvtFfLCpZxvjQ3jwNwQMt8W3YGD3N
	 suxF+Eo70wNsmGH2cQOkYvY1ueozxaxvQ7XeUQWGvOvmr3QW1jxXh23Y2Y4LBNftOB
	 Di63pdFVTSFT7/cXiaKg9djnbbC44s5nG2Jh4huwhGMqT/VCEh+MYq6eCfAci9ULaA
	 ZWWjP47qXgcBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	emmanuel.grumbach@intel.com,
	ilan.peer@intel.com,
	benjamin.berg@intel.com,
	shaul.triebitz@intel.com,
	yedidya.ben.shimol@intel.com,
	quic_adisi@quicinc.com,
	linux@treblig.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 182/642] wifi: iwlwifi: w/a FW SMPS mode selection
Date: Mon,  5 May 2025 18:06:38 -0400
Message-Id: <20250505221419.2672473-182-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit b2e709805ce955f80803b7cab3421813c79e1df4 ]

The FW is now responsible of determining the SMPS mode.
If the user disabled power save in a certain vif, we send the vif-level
power command to clear out the POWER_FLAGS_POWER_MANAGEMENT_ENA_MSK bit
for that vif.
But erroneously, the FW checks DEVICE_POWER_FLAGS_POWER_SAVE_ENA_MSK in
the device-level command to determine the SMPS mode.

To W/A this, send also the device-level command when the power save of a
vif changes, and disable power save if there is any vif that has power
save disabled.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250308231427.7bf205efa027.I2c793ff1fc2a6779a95faaee1ded348100fd97f1@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 15 +++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  3 +++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index af6644b7e95fb..e17ad647da48c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4099,6 +4099,20 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 	return 0;
 }
 
+void iwl_mvm_smps_workaround(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     bool update)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (!iwl_mvm_has_rlc_offload(mvm))
+		return;
+
+	mvmvif->ps_disabled = !vif->cfg.ps;
+
+	if (update)
+		iwl_mvm_power_update_mac(mvm);
+}
+
 /* Common part for MLD and non-MLD modes */
 int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
@@ -4191,6 +4205,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 		   new_state == IEEE80211_STA_AUTHORIZED) {
 		ret = iwl_mvm_sta_state_assoc_to_authorized(mvm, vif, sta,
 							    callbacks);
+		iwl_mvm_smps_workaround(mvm, vif, true);
 	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
 		   new_state == IEEE80211_STA_ASSOC) {
 		ret = iwl_mvm_sta_state_authorized_to_assoc(mvm, vif, sta,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 341a2a7a49ec9..78d7153a0cfca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022-2024 Intel Corporation
+ * Copyright (C) 2022-2025 Intel Corporation
  */
 #include "mvm.h"
 
@@ -887,6 +887,7 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 	}
 
 	if (changes & BSS_CHANGED_PS) {
+		iwl_mvm_smps_workaround(mvm, vif, false);
 		ret = iwl_mvm_power_update_mac(mvm);
 		if (ret)
 			IWL_ERR(mvm, "failed to update power mode\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ee769da72e68c..211f542ec8557 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -3043,4 +3043,7 @@ iwl_mvm_send_ap_tx_power_constraint_cmd(struct iwl_mvm *mvm,
 					struct ieee80211_vif *vif,
 					struct ieee80211_bss_conf *bss_conf,
 					bool is_ap);
+
+void iwl_mvm_smps_workaround(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			     bool update);
 #endif /* __IWL_MVM_H__ */
-- 
2.39.5



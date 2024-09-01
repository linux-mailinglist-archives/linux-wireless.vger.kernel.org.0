Return-Path: <linux-wireless+bounces-12292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216759674EF
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 06:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B171F21CA6
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 04:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2822E416;
	Sun,  1 Sep 2024 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0RG+xWs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5F2C6B6
	for <linux-wireless@vger.kernel.org>; Sun,  1 Sep 2024 04:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164293; cv=none; b=UOzcLxjcRuVT2W4MwL8s6Ci+t9GDtDWNsKvxzrGxaYQ2R2kzmxe0P24BuinJN5Cy7IxY1LBS2mQ9fkNyz8CgJVRQ8PIzT3WC72fpy+6OH3nkksboiLi73h/3uSagSIxm2HyPPUu+AjVOyOk2MBv944WSCvM4CA2KGm50649gC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164293; c=relaxed/simple;
	bh=4w2bdmgOO7lKNi8xcyEd5nXPwjg2g0UmbPoepCnfDGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NAnPUGmE1tKtgDciwWruhQtnxPdNn7xwyqEtYR0+XJhBvY4t3EDu8O+BHD1iRtWL2+36pIWBCKlqJsnyglRluEnh2QpsUQnJyGnHBvaVkrdXc3ooKpSGJp9eQzceaA68x1uJy9x9XJmknRnV9yr219Mfh2sAa4sRIoI8sNfWSt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0RG+xWs; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725164291; x=1756700291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4w2bdmgOO7lKNi8xcyEd5nXPwjg2g0UmbPoepCnfDGw=;
  b=a0RG+xWstvD91I3HbY8xaeCJcTZS/j+XydPy2AqnhgytzN/q54PYSRP2
   53NywnvDg0GtiHnIZMq4t0LZheElntj9wexSmSEqyeLbPQQqEub+I9Hg2
   98xKa0NEYQmqKvWu9YKiu3XQeNPg9QMrUnuyN1H/CZdwatia4kxqLqAfD
   ZNtJtLd5oWRu2AMKgZHs5phNps64nkbg6uEutUP8ipZ8R7xOFQfCV1N7Q
   G9mZaig3F6zF5vIvjyHtrG9BnSZjp3rEcJRoZX2k//m3OtFhl/GQ8mS5X
   VfiVu8V+tOJ9inJEn3CY0CzNknvRDzz04jpJYrjpIeSGNES4SSq/cA9BK
   g==;
X-CSE-ConnectionGUID: UvFlQZTLR4SsltGe+NeY4Q==
X-CSE-MsgGUID: ttpEWdlFT9a6Jt1K1lvSvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="27559517"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="27559517"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:10 -0700
X-CSE-ConnectionGUID: QjVg3uDzSkWXPzGmSb9zBQ==
X-CSE-MsgGUID: xj58fErzS0yXtJl+D2Rgvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64276301"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 2/8] wifi: iwlwifi: mvm: tell the firmware about CSA with mode=1
Date: Sun,  1 Sep 2024 07:17:51 +0300
Message-Id: <20240901071542.4bef89d438d4.If7147a7a84054e67c05414c753d73f4e2e0e6e37@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
References: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we de-activate a link because it started a CSA with mode=1, we want
to tell the firmware it can no longer transmit any frame for that link.
The firmware will do that on its own if the CSA indication (beacon /
action frame) was  received on that same link, but with MLO, things got
more complex and the firmware can't track cross link CSA.

Tell the firmware if we de-activate a link because of CSA with mode=1 to
prevent it from transmitting, even if it is only an NDP PM=1 frame that
is part of the de-activation flow.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h  | 10 ++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c    |  9 +++++++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c    | 16 ++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h     |  2 ++
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 7af580d1c99c..73586e547e57 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -454,6 +454,9 @@ enum iwl_link_ctx_flags {
  * @listen_lmac: indicates whether the link should be allocated on the Listen
  *	Lmac or on the Main Lmac. Cannot be changed on an active Link.
  *	Relevant only for eSR.
+ * @block_tx: tell the firmware that this link can't Tx. This should be used
+ *	only when a link is de-activated because of CSA with mode = 1.
+ *	Available since version 5.
  * @reserved1: in version 2, listen_lmac became reserved
  * @cck_rates: basic rates available for CCK
  * @ofdm_rates: basic rates available for OFDM
@@ -498,7 +501,10 @@ struct iwl_link_config_cmd {
 	__le32 active;
 	union {
 		__le32 listen_lmac;
-		__le32 reserved1;
+		struct {
+			u8 block_tx;
+			u8 reserved1[3];
+		};
 	};
 	__le32 cck_rates;
 	__le32 ofdm_rates;
@@ -529,7 +535,7 @@ struct iwl_link_config_cmd {
 	u8 ibss_bssid_addr[6];
 	__le16 reserved_for_ibss_bssid_addr;
 	__le32 reserved3[8];
-} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3, _VER_4 */
+} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3, _VER_4, _VER_5 */
 
 /* Currently FW supports link ids in the range 0-3 and can have
  * at most two active links for each vif.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index d151d935e12a..bc8d06127747 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -234,10 +234,15 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		WARN_ON_ONCE(active == link_info->active);
 
 		/* When deactivating a link session protection should
-		 * be stopped
+		 * be stopped. Also let the firmware know if we can't Tx.
 		 */
-		if (!active && vif->type == NL80211_IFTYPE_STATION)
+		if (!active && vif->type == NL80211_IFTYPE_STATION) {
 			iwl_mvm_stop_session_protection(mvm, vif);
+			if (link_info->csa_block_tx) {
+				cmd.block_tx = 1;
+				link_info->csa_block_tx = false;
+			}
+		}
 	}
 
 	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 72bb6865dd63..f2378e0fb2fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1341,6 +1341,22 @@ iwl_mvm_mld_mac_pre_channel_switch(struct ieee80211_hw *hw,
 		else
 			selected = primary;
 
+		/*
+		 * remembers to tell the firmware that this link can't tx
+		 * Note that this logic seems to be unrelated to esr, but it
+		 * really is needed only when esr is active. When we have a
+		 * single link, the firmware will handle all this on its own.
+		 * In multi-link scenarios, we can learn about the CSA from
+		 * another link and this logic is too complex for the firmware
+		 * to track.
+		 * Since we want to de-activate the link that got a CSA, we
+		 * need to tell the firmware not to send any frame on that link
+		 * as the firmware may not be aware that link is under a CSA
+		 * with mode=1 (no Tx allowed).
+		 */
+		if (chsw->block_tx && mvmvif->link[chsw->link_id])
+			mvmvif->link[chsw->link_id]->csa_block_tx = true;
+
 		iwl_mvm_exit_esr(mvm, vif, IWL_MVM_ESR_EXIT_CSA, selected);
 		mutex_unlock(&mvm->mutex);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 68464f892e85..26adf9f9b8c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -299,6 +299,7 @@ struct iwl_probe_resp_data {
  * @active: indicates the link is active in FW (for sanity checking)
  * @cab_queue: content-after-beacon (multicast) queue
  * @listen_lmac: indicates this link is allocated to the listen LMAC
+ * @csa_block_tx: we got CSA with mode=1
  * @mcast_sta: multicast station
  * @phy_ctxt: phy context allocated to this link, if any
  * @bf_data: beacon filtering data
@@ -324,6 +325,7 @@ struct iwl_mvm_vif_link_info {
 	bool he_ru_2mhz_block;
 	bool active;
 	bool listen_lmac;
+	bool csa_block_tx;
 
 	u16 cab_queue;
 	/* Assigned while mac80211 has the link in a channel context,
-- 
2.34.1



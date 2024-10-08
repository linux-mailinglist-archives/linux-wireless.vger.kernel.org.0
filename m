Return-Path: <linux-wireless+bounces-13665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE02993DF1
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1BC1C24582
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED801136327;
	Tue,  8 Oct 2024 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4tdnUpg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE43C0C
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361545; cv=none; b=cyJaLqKuRMMEIxCuKwWUeIaPeGippXWJrwHS0a17dpsvNPTS6PkDqyQd5LavAjCcy23XVC0Zj+EnRnsvdfFXxdEdzVp+JPKZLPyjXwvydYwvBXRSOICElzJNmC0djhDBGXPOOsiyje9X8v69mDiQc+4GBMjdoLY18kz5EtNY5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361545; c=relaxed/simple;
	bh=57OQ+bOo+K8uR+gyDkq+23AYOtECQvt/iRffbqS1NNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iEAaVCVbXQMqWjz9OkdMiVxFgnt3fwhcpsiJjIVcWRzErR5GOeE2tHK12sz3w31Z79Mu1Wzcx2fak000qsPugAURkN33ncjbGn3DKyGI8uRKLh3TBdh1fg6kihdz3ISa3Zzg35YaW8of6g0mWg1tGRAXlwR6drhf0ZQrP/ChPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4tdnUpg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361544; x=1759897544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57OQ+bOo+K8uR+gyDkq+23AYOtECQvt/iRffbqS1NNQ=;
  b=D4tdnUpgN2qePahGulaCavijXcBBZgZmnyAdCaZKI1n/vZy8r+S6mABc
   c5cynODmli67EPY/sKyLbsm97msstWbVdL+rgPZ6fCVRlNJOKZfq2VW7O
   kCPrgwhr/GEw5cXBZkFrtxgYXlNZho1H2tc/s1BaQSpHJI04T0HZgANZd
   x7ugu5RMNRY+rXRLZPH/noJdsehttXvoKZYpqN9iep8lV1JIAdy7IZcgN
   eBHH67Z1GTr2v2aG58cYchkALhPH83XgWeOxlP193ACNj284gM4dXBJTM
   hRMQ7nE0DCDP7/2xx6dqv24Hm7TgTMLvW7kGLWRbyjttk89DIeO1otHYe
   g==;
X-CSE-ConnectionGUID: YQOMHvAGSkK3f1grjqO5QQ==
X-CSE-MsgGUID: 1ALFgnJ0TQGzkwDoLHezeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024254"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024254"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:44 -0700
X-CSE-ConnectionGUID: x3sZzRVYSRKnm/LcktfITg==
X-CSE-MsgGUID: USgB1MtQRmucJdTrSb4x3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486301"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 02/14] wifi: iwlwifi: mvm: exit EMLSR earlier if bss_param_ch_cnt is updated
Date: Tue,  8 Oct 2024 07:25:16 +0300
Message-Id: <20241008072037.9c5ad120b937.Ibdde0b3770d0821e802009d4684b617220dd6e1a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

If we lose beacons and bss_param_ch_cnt gets updated on the other link,
we need to exit EMLSR earlier.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
This needs "wifi: mac80211: make bss_param_ch_cnt available for the low
level driver"

 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  | 13 ++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index ddf484027d4f..fdccdea918bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -17,7 +17,8 @@
 #define IWL_MVM_TRIGGER_LINK_SEL_TIME_SEC	30
 #define IWL_MVM_TPT_COUNT_WINDOW_SEC		5
 #define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS	5
-#define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH	11
+#define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH	15
+#define IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED	11
 
 #define IWL_MVM_DEFAULT_PS_TX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
 #define IWL_MVM_DEFAULT_PS_RX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index a7a10e716e65..9a43df49493f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1605,6 +1605,7 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 					       0);
 	u8 new_notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
 						   MISSED_BEACONS_NOTIF, 0);
+	struct ieee80211_bss_conf *bss_conf;
 
 	/* If the firmware uses the new notification (from MAC_CONF_GROUP),
 	 * refer to that notification's version.
@@ -1617,9 +1618,9 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 	/* before version four the ID in the notification refers to mac ID */
 	if (notif_ver < 4) {
 		vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, false);
+		bss_conf = &vif->bss_conf;
 	} else {
-		struct ieee80211_bss_conf *bss_conf =
-			iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, id, false);
+		bss_conf = iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, id, false);
 
 		if (!bss_conf)
 			return;
@@ -1664,6 +1665,8 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 				 rx_missed_bcon, rx_missed_bcon_since_rx);
 		}
 	} else if (link_id >= 0 && hweight16(vif->active_links) > 1) {
+		u32 bss_param_ch_cnt_link_id =
+			bss_conf->bss_param_ch_cnt_link_id;
 		u32 scnd_lnk_bcn_lost = 0;
 
 		if (notif_ver >= 5 &&
@@ -1677,10 +1680,14 @@ iwl_mvm_handle_missed_beacons_notif(struct iwl_mvm *mvm,
 		/* Exit EMLSR if we lost more than
 		 * IWL_MVM_MISSED_BEACONS_EXIT_ESR_THRESH beacons on boths links
 		 * OR more than IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH on any link.
+		 * OR more than IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED
+		 * and the link's bss_param_ch_count has changed.
 		 */
 		if ((rx_missed_bcon >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS &&
 		     scnd_lnk_bcn_lost >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS) ||
-		    rx_missed_bcon >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH)
+		    rx_missed_bcon >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH ||
+		    (bss_param_ch_cnt_link_id != link_id &&
+		     rx_missed_bcon >= IWL_MVM_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED))
 			iwl_mvm_exit_esr(mvm, vif,
 					 IWL_MVM_ESR_EXIT_MISSED_BEACON,
 					 iwl_mvm_get_primary_link(vif));
-- 
2.34.1



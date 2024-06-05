Return-Path: <linux-wireless+bounces-8554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00448FCA2E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E084285607
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAC6192B6E;
	Wed,  5 Jun 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3+fYTSc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F219414B
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586248; cv=none; b=nu//yUcx7JngBQH59L6k3TzzNjj9J67CpfNpHTNmHz9dbOxRH3rEvWm/W/Vbcsr9OUbCH4I4XoVsTt7sLJohx3/ylAE3XVf8+JptqvSAiZDLZlT/SrR9ycJziK7kxOZCBxUqOtaYtLgCNf7eVGvaUMgExDejEion9159ene/Lro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586248; c=relaxed/simple;
	bh=rsqu2F15KJKIkLpQDGPzykhys3r6UMNDbc7D2EiaZus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ArLTGKR0gzIH2oQkfd3jOUCES4Bgft+aFrCiSi0VQIuSEGy+RdmetUCTxE6s1+6oZUflKlS2IrJ3Utb4Q5NaGFaa8/eZjf9mEa22+jktXuvWcF2+jiilI4OGUPrT1Y5oZH0w8ci7na27baBlpbcoYeowImrXOV6EgcDlA3ZnnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3+fYTSc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717586247; x=1749122247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rsqu2F15KJKIkLpQDGPzykhys3r6UMNDbc7D2EiaZus=;
  b=f3+fYTScs1RwAo4G5EoFks3SoxvH8rcKXh0LVw6ONEGf54gOI4LwfHiJ
   nlMZZg0NzHO2hi3SH6chD2ArVv2p9xjYokblnG0em5pPxmECA0C8BrwVn
   fOuL0y4Z1TgSbXid2zTzUsufMWMqPPI4MWJwrGnagAdsr46h03SH5gwvY
   nHt/HMYzgCl3YxbbqKZB58OYkCcOYCVsHXvXKRyzR4SfBrehSSk5UTthk
   gAGRzb+w34POB/lKgWAa+O87+oxyLcUtDxHVhg7vwD84DFOeZBDkysdqL
   kz8iTDtN1w+cGnNEIgQ9PyH4hw+GEcukps3AGnwwNn1348YoiU4OXcOOo
   A==;
X-CSE-ConnectionGUID: sbbbKcSKTj+XSFw8+D9wDA==
X-CSE-MsgGUID: BP2wDQYUS/ien9dUGPbx6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36718067"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="36718067"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:07:55 -0700
X-CSE-ConnectionGUID: 9xbOboA6SWuuHBYvRSg7dQ==
X-CSE-MsgGUID: UBmgVUHiSKyUHg+pvcBBFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37433814"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:07:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/5] wifi: iwlwifi: mvm: Add support for interface usage notification
Date: Wed,  5 Jun 2024 14:07:40 +0300
Message-Id: <20240605140556.21582e74a0e0.I7c423d03b4412d77509bd31bd41e4573f76c0e84@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110740.2046411-1-miriam.rachel.korenblit@intel.com>
References: <20240605110740.2046411-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When an interface usage notification indicates that a P2P group
interface is about to be started and there is an ongoing MLD
connection with active EMLSR, exit EMLSR.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
depends on the patchs adding this API in the mac80211 patchset

 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index d972fcbc2cf7..68cd5b621ed8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1354,6 +1354,20 @@ iwl_mvm_mld_mac_pre_channel_switch(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static void iwl_mvm_mld_iface_usage(struct ieee80211_hw *hw,
+				    struct cfg80211_iface_usage *iface_usage)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	u32 p2p_iftypes = BIT(NL80211_IFTYPE_P2P_GO) |
+		BIT(NL80211_IFTYPE_P2P_CLIENT);
+
+	IWL_DEBUG_MAC80211(mvm, "iface_usage_notif: mask=0x%x\n",
+			   iface_usage->types_mask);
+
+	if (iface_usage->types_mask & p2p_iftypes)
+		iwl_mvm_esr_non_bss_link(mvm, NULL, 0, true);
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
@@ -1450,4 +1464,5 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.change_sta_links = iwl_mvm_mld_change_sta_links,
 	.can_activate_links = iwl_mvm_mld_can_activate_links,
 	.can_neg_ttlm = iwl_mvm_mld_can_neg_ttlm,
+	.iface_usage = iwl_mvm_mld_iface_usage,
 };
-- 
2.34.1



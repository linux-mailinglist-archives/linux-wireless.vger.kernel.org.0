Return-Path: <linux-wireless+bounces-9917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E16E9257A0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0111F2711A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251BA142E77;
	Wed,  3 Jul 2024 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eq8hNMDF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594213DDA3
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000781; cv=none; b=Quegl0SOjiYgmbH09xaxKMTSOau5X3Tqz6vPFMSBBq7BIvqXkRbFwjHcTTp7LLRfy6KrMnJdC2kgdLfmN5PUYyjgD34k/T6uqeI1snwtpsZYUduYd8waijDhzDsMWXfC2YIxaDUJxEpqbST08ITjv3AjE9D9V3wv+MAbAHrwOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000781; c=relaxed/simple;
	bh=vgaZUVJiz1OcN8AfykXl+tpykgZDs+FbcKFxCCj2kx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HqvuIvu7t0D3rAIKEL5aiYGmGrANn6EYEr0I+xEa+hGCKRy8M2drtcrs66L6lSmrvv9wt7dwrhmDvs+KvwHDMhWGlePDqVgu7rqNyeXlVyp0JihtdU+Wrda7BV56uD4opaBGOQjBvLt7LCPJmDsDrx4exmkao7SF8t3iS8UdMlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eq8hNMDF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000779; x=1751536779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vgaZUVJiz1OcN8AfykXl+tpykgZDs+FbcKFxCCj2kx0=;
  b=Eq8hNMDFpOZvQ2iTRFAFbC+Mul0dkIqlA4WHW5Hyj2MLhzrVoy5qIJH3
   e7BWjavhwBnc+1xDa44yqoR1hWnsYeffn9BjQHeCmVAjvJT+uNAi9NLHB
   a0g4dDPfN8Rw7h6p205rAWNW2cKtCcojHQ27apPmp0+eyrrqn3Gwz5vEe
   zEXtFZtr/3S0yAveI3HxY5U1DE+2Ut9bSFO6y6Gc59edQ8sxHpgDSuzVB
   82vxOM8LKe4L4ObuDg37SnVC/HMCLuPDJF7B1/TiWkdmcNEHOudANcSgO
   HvlsmcxiC8WzElJQoRqRBjMCoDXApab/UQN0rPK0tIOPqygdahCqmNvBQ
   A==;
X-CSE-ConnectionGUID: 2pWg/Jg4Qlm9/kW6747xHg==
X-CSE-MsgGUID: GxtrWpKbSPmg2lWIZ2xxbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837565"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837565"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:39 -0700
X-CSE-ConnectionGUID: rA5qyNuJT8iuewPf64EhiA==
X-CSE-MsgGUID: kZTeSMnCQZO+4YOuIGphig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987867"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/18] wifi: iwlwifi: mvm: document remaining mvm data
Date: Wed,  3 Jul 2024 12:59:04 +0300
Message-Id: <20240703125541.371664e5e8cd.I593ebee1ab984554b6d269dc2dddc67fbf3bb537@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Many iwl_mvm_vif members are not documented, add that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 056fdc42e253..22f48b66d79c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -453,6 +453,35 @@ struct iwl_mvm_esr_exit {
  * @session_prot_connection_loss: the connection was lost due to session
  *	protection ending without receiving a beacon, so we need to now
  *	protect the deauth separately
+ * @ap_early_keys: The firmware cannot install keys before stations etc.,
+ *	but higher layers work differently, so we store the keys here for
+ *	later installation.
+ * @ap_sta: pointer to the AP STA data structure
+ * @csa_count: CSA counter (old CSA implementation w/o firmware)
+ * @csa_misbehave: CSA AP misbehaviour flag (old implementation)
+ * @csa_target_freq: CSA target channel frequency (old implementation)
+ * @csa_work: CSA work (old implementation)
+ * @dbgfs_bf: beamforming debugfs data
+ * @dbgfs_dir: debugfs directory for this vif
+ * @dbgfs_pm: power management debugfs data
+ * @dbgfs_quota_min: debugfs value for minimal quota
+ * @dbgfs_slink: debugfs symlink for this interface
+ * @ftm_unprotected: unprotected FTM debugfs override
+ * @hs_time_event_data: hotspot/AUX ROC time event data
+ * @mac_pwr_cmd: debugfs override for MAC power command
+ * @target_ipv6_addrs: IPv6 addresses on this interface for offload
+ * @num_target_ipv6_addrs: number of @target_ipv6_addrs
+ * @tentative_addrs: bitmap of tentative IPv6 addresses in @target_ipv6_addrs
+ * @rekey_data: rekeying data for WoWLAN GTK rekey offload
+ * @seqno: storage for seqno for older firmware D0/D3 transition
+ * @seqno_valid: indicates @seqno is valid
+ * @time_event_data: session protection time event data
+ * @tsf_id: the TSF resource ID assigned in firmware (for firmware needing that)
+ * @tx_key_idx: WEP transmit key index for D3
+ * @uapsd_misbehaving_ap_addr: MLD address/BSSID of U-APSD misbehaving AP, to
+ *	not use U-APSD on reconnection
+ * @uapsd_nonagg_detected_wk: worker for handling detection of no aggregation
+ *	in U-APSD
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
-- 
2.34.1



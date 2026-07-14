Return-Path: <linux-wireless+bounces-39073-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nJr9NbNBVmoz2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39073-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:03:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96576755767
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:03:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HxYijmXM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39073-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39073-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFF09300DED5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BF147D92B;
	Tue, 14 Jul 2026 14:03:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E7441022
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:03:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037802; cv=none; b=FBsdQ27U9FjkzJDQ2KzuMJHZbX7GfMMiLRwE9lO5uXbgbnAJBG/05y03c3vDQxtHusOwBwJIlMix2+UkfiLfnmyPX0Y0mcsYEF4NTvIKew0KIPr14/ChsMuCQTu2LST3EMA7dJEoa9sdRxp97k1GUx+wrGVsP0UwLQTU5d8QECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037802; c=relaxed/simple;
	bh=HBu8PlSRn2ZR8PsmR4sfTdOq2xxnJD5YP8it0W0I7hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OqJ6rKB9MaR4L86WThCqg7VLoubcE8ifGpUr6tqA9KIuGxVTzShAbIw+C2whiX/VZ5kfVWOXBzDDBTrTXcctGngZKxbqWAFc6bqu5xKtWHxCuTaCMtq/BerkLBLyj+G5uc85f1rxU28uBW4ajL//T3X+mlFC54rVJ3K7OvG+OxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxYijmXM; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037799; x=1815573799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HBu8PlSRn2ZR8PsmR4sfTdOq2xxnJD5YP8it0W0I7hM=;
  b=HxYijmXM3FTRFjpiaO8GtH3WrkHhgmZcNQ3FVE3ysW+MdotCabH3yaz5
   0nILgZw3tmRie/zEB1KRopIjtSBAOd04vSTdrAXXTrQ1yVG9/JvBpFftG
   baOreTUdZ2GPEeR+6xa9PjvVRS4GgA90ACW0z9j13jwQuiY0tm22lE/nz
   JM8R8GE6h99PY2UioU2NOxd+Q4cfXFmlnz1ihSg0PDi/8UjtUo5zVyGte
   yfr751XTwTeaeQAZtZSQ4ZWzRQnRDrXSVGvawjAULyyYNGljvebemTDah
   Sct/6XrMnPdX2+L+hpTyGmIvv3Po2/5KaTKIAng+wR0O2jXEdx+nAIbUG
   w==;
X-CSE-ConnectionGUID: zD68bmfNSFSV9BP1334P9w==
X-CSE-MsgGUID: ytyM1cFnQ4aBEfviLugCZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855166"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855166"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:03:03 -0700
X-CSE-ConnectionGUID: +b8g4M2SRGy2JcVLpuVPMA==
X-CSE-MsgGUID: wDZZF4jkSC6RoAyNZ4cBoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254737978"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:03:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 14/15] wifi: iwlwifi: mvm: cleanup the driver state after device_powered_off
Date: Tue, 14 Jul 2026 17:02:17 +0300
Message-Id: <20260714165826.dc33533ac962.I6d7cca9c4e5643a477eae1d0a4f5fc83a10d0ee7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
References: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39073-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,changeid:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96576755767

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

If the device was powered off during suspend, we need to reload the
firmware in resume which also means that we need to reconfigure it.

It could be tempting to just set IWL_MVM_STATUS_HW_RESTART_REQUESTED
but that would leave IWL_MVM_STATUS_IN_HW_RESTART set forever since that
recovery is not managed by mac80211.

Just call iwl_mvm_restart_cleanup() from device_powered_off().

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 74bd4038fd56..fd2a50563ab5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1129,7 +1129,7 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
 }
 
-static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
+void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 {
 	iwl_mvm_stop_device(mvm);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 979b39314981..d6bed2c08606 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1660,6 +1660,7 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 u8 iwl_mvm_rate_idx_to_fw_idx(const struct iwl_fw *fw, int rate_idx);
 u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac);
 bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm);
 
 static inline void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 09150feb330d..6ae9f87d5221 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -2091,7 +2091,7 @@ static void iwl_op_mode_mvm_device_powered_off(struct iwl_op_mode *op_mode)
 
 	mutex_lock(&mvm->mutex);
 	clear_bit(IWL_MVM_STATUS_IN_D3, &mvm->status);
-	iwl_mvm_stop_device(mvm);
+	iwl_mvm_restart_cleanup(mvm);
 	mvm->fast_resume = false;
 	mutex_unlock(&mvm->mutex);
 }
-- 
2.34.1



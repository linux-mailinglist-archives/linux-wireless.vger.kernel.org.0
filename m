Return-Path: <linux-wireless+bounces-33634-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D2SEpnVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33634-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FBD2E6893
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEAEC300B50F
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955633B6D5;
	Sat, 21 Mar 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiNACLHL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAA33B97D
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114185; cv=none; b=OUZ9bzj652iEPgFvx9QbAQSWP9rad4hGiNckbRNX2LqRxrxKFEDrlixOkGtTJpY8XPE9OJAZWHgwMjUpcOkql9bxf8rLUhfAcKmuf/Pmu6gK00fWEi5xc/iGvu3wUrRFmFXVMJUkzHjWyTKx86GtalM8ATTHB0pNnqcId3P1oNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114185; c=relaxed/simple;
	bh=JD4DWzQnJ+ZUikoLDdQkV/qQgDRpyBtWPXrYDwz7xXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EpbHvpbmL6/vaWUOMeuy9tO3DGxqxAnOo21aF7HEx3JDNVotGYcDB94jYXn+Xk0A7oOQ+/eg0QQeS7iESrd5iHI5Stx5UzztRu3RZJGKsJgioGLKQqGVbjjW1LAcEmnyUwTUiM8CplAfICMLGC+5XJnnu6JfEwnNR2t6wZBEeE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiNACLHL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114183; x=1805650183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JD4DWzQnJ+ZUikoLDdQkV/qQgDRpyBtWPXrYDwz7xXk=;
  b=GiNACLHLHJVRD13unXHxEzEK/NIJ/pne5xDg2939X2OJWveVh4iAAonW
   en8BGudmc6hxqaieTas1cke0UaW4rOHvFGqnU9WmAhU9+3xZJAkjJof4b
   i0lUackZ8aOPsfzXo4XgKCeuhPcNBzN9xWr8MOftECIpyZlgjMvjAV7/r
   cZs2MUEPRiJGUxEDXJzPtxEGpRcUxEJbu725QZC/KzjJxF9NWHHmBTrbL
   HWIpk3uvDu+XnDOly8WvZNhcZdB0oy9pXRt46iDO5SFfz9DCO7B7+W3dZ
   k+wsLxnHtQgHdxm2i+CSg6moENetzlZFfuQUJspRudBFb6YOAn5PasYY+
   g==;
X-CSE-ConnectionGUID: wxtFGC3dRgyu6O0OJCF/4w==
X-CSE-MsgGUID: v4sZQpFwREGFuOKBRSvbQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244591"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244591"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:42 -0700
X-CSE-ConnectionGUID: MfzaVhBTS4eMvywagQczNA==
X-CSE-MsgGUID: w2t3xCOZQEW5WIiWRT9fcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813592"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: always assign a fw id to a vif
Date: Sat, 21 Mar 2026 19:29:14 +0200
Message-Id: <20260321192637.f3b5cc59098f.I3d1dbe66bd224cbb786c2b0ab3d1c9f7ec9003e4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
References: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33634-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67FBD2E6893
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We used to have a fw id assignment in iwl_mld_init_vif since all interface
types that were added to the driver was immediately added to the FW as
well.
Since NAN was introduced, this is no longer the case - the NAN interface
is not added to the fw until a local schedule is configured.

For this vif we don't assign a fw id so it is 0 by default.
But later, when the vif is removed from the driver, we think that it has
a valid fw id (0) and we point fw_id_to_vif[0] to NULL.
fw_id_to_vif[0] might actually point to another vif with a valid fw id
0. In this case, we end up messing fw_id_to_vif.

Fix this by initializing a vif with a special invalid fw id, and by
exiting iwl_mld_rm_vif early for NAN interfaces.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index d3b850259569..5c435d6ffa90 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -445,6 +445,7 @@ iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 	lockdep_assert_wiphy(mld->wiphy);
 
 	mld_vif->mld = mld;
+	mld_vif->fw_id = IWL_MLD_INVALID_FW_ID;
 	mld_vif->roc_activity = ROC_NUM_ACTIVITIES;
 
 	if (!mld->fw_status.in_hw_restart) {
@@ -492,6 +493,10 @@ void iwl_mld_rm_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 
 	lockdep_assert_wiphy(mld->wiphy);
 
+	/* NAN interface type is not known to FW */
+	if (vif->type == NL80211_IFTYPE_NAN)
+		return;
+
 	iwl_mld_mac_fw_action(mld, vif, FW_CTXT_ACTION_REMOVE);
 
 	if (WARN_ON(mld_vif->fw_id >= ARRAY_SIZE(mld->fw_id_to_vif)))
-- 
2.34.1



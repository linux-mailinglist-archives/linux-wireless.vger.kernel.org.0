Return-Path: <linux-wireless+bounces-21982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ADDA9ADA9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538E0466861
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB62143C69;
	Thu, 24 Apr 2025 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IFEGO0st"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C627B4E2
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498333; cv=none; b=OVF7fdXDyNldMibQMXcmoSA8spAuq6SdddSsZvWkOmmUyk8Zxn2/Kv7JH8n7AIAZXPyVV8ZuO2ioaALWKo4KYM2hogpNCyFW7XPLn4+58NDV4j6lSJVLWb1AGEriamk149NZwVEykJdCHMOQ8XJ1kHxW9ykbOZBlkb4wzNMnFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498333; c=relaxed/simple;
	bh=xP4HLQHDlDtsi/sp4+jUtFNz3qqpFfcL3OUGC7G0ukY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VlGu16UKxdbJlsMv1HlHa667+kK6ixYQ88Y5S49y7S92Y4bM6AjHKnIpaClffHAeGtLC3gJ3OHnF+iOLIJqzLyTKhVAVDqt5C3ROsn+eGfIQg+ule8y1CAFxLmywuk9WL5s50BC38x9N5Fi6uVT+2zHATYChJvc8D4hMw6Vf1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IFEGO0st; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498332; x=1777034332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xP4HLQHDlDtsi/sp4+jUtFNz3qqpFfcL3OUGC7G0ukY=;
  b=IFEGO0stXyoS0FdzqDuuKx6cHYMDhqwHQr2HWsqAof4M+a3n0Ya4+shk
   J9vFKmFYpxap9MyXEjIIddoYISXJu6WEmBVXPncFqBB6ZlGAmPCWJ3X+E
   EvqrNoe6nJIIiVUHY0otEiD8rrmJAXq5E3Xr2cWvc32MD59QzQ6Tk6urs
   BvgKNtVYGQLftjlCs5MTyB7FlljTS5hjntrKUyRu2oiWuGHsuewHA6Cky
   92vlp/CjjqRdHw0IYHBIzL1T4QMR3EIFk1DybPi4mvAN0W7jw8/q2LFiD
   2j2L9R28qOVhj6833dMgdnXMrKO9GnYKq2tRgTqo1rkUSfTBLJ51YwbEa
   A==;
X-CSE-ConnectionGUID: xZ73jNdHQgyr8fWs1hLQLA==
X-CSE-MsgGUID: gXHVUeLRSPeNM9YZjRxegQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302408"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302408"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:51 -0700
X-CSE-ConnectionGUID: TOKRb5XuSJSAU6pIQsZ78Q==
X-CSE-MsgGUID: geQ+nwMRRiSxhFw7Gc0ZFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137393"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 03/14] wifi: iwlwifi: mld: fix iwl_mld_emlsr_disallowed_with_link() return
Date: Thu, 24 Apr 2025 15:38:20 +0300
Message-Id: <20250424153620.d1f8465e2b5e.I58c463c70801231a79b04c1ff600f41afcbb04f5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The return type of iwl_mld_emlsr_disallowed_with_link() is a u32
bitmap of exit reasons, but in the data structure confusion case
where the warning triggers, it returns false. Add a new reason
bit for this case so it doesn't return that EMLSR is possible.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c   | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index ec14d0736cee..1ae522431f3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -59,6 +59,7 @@ enum iwl_mld_emlsr_blocked {
  *	loaded enough to justify EMLSR.
  * @IWL_MLD_EMLSR_EXIT_RFI: Exit EMLSR due to RFI
  * @IWL_MLD_EMLSR_EXIT_FW_REQUEST: Exit EMLSR because the FW requested it
+ * @IWL_MLD_EMLSR_EXIT_INVALID: internal exit reason due to invalid data
  */
 enum iwl_mld_emlsr_exit {
 	IWL_MLD_EMLSR_EXIT_BLOCK		= 0x1,
@@ -72,6 +73,7 @@ enum iwl_mld_emlsr_exit {
 	IWL_MLD_EMLSR_EXIT_CHAN_LOAD		= 0x100,
 	IWL_MLD_EMLSR_EXIT_RFI			= 0x200,
 	IWL_MLD_EMLSR_EXIT_FW_REQUEST		= 0x400,
+	IWL_MLD_EMLSR_EXIT_INVALID		= 0x800,
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index bf158af5f6f3..5c92c0a6818d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -52,7 +52,8 @@ static void iwl_mld_print_emlsr_blocked(struct iwl_mld *mld, u32 mask)
 	HOW(BT_COEX)			\
 	HOW(CHAN_LOAD)			\
 	HOW(RFI)			\
-	HOW(FW_REQUEST)
+	HOW(FW_REQUEST)			\
+	HOW(INVALID)
 
 static const char *
 iwl_mld_get_emlsr_exit_string(enum iwl_mld_emlsr_exit exit)
@@ -647,7 +648,7 @@ iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
 
 	conf = wiphy_dereference(wiphy, vif->link_conf[link->link_id]);
 	if (WARN_ON_ONCE(!conf))
-		return false;
+		return IWL_MLD_EMLSR_EXIT_INVALID;
 
 	if (link->chandef->chan->band == NL80211_BAND_2GHZ && mld->bt_is_active)
 		ret |= IWL_MLD_EMLSR_EXIT_BT_COEX;
-- 
2.34.1



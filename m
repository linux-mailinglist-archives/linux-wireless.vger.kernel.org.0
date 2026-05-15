Return-Path: <linux-wireless+bounces-36480-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB1gAO4bB2rnrgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36480-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:13:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5C5504B5
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F110309ABEC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B547F2CB;
	Fri, 15 May 2026 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VffF5aG1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD0478E53
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847025; cv=none; b=mpzvwJ6Np1NtRi+w3s5DWqx4MUQLgnd00zKnulPMOSZb8AQaHctD6L4xPicOMknFoZq94EMV3zVFPGtPSOsE3Hw8HkDuItURKgZjVQrs72KlkO1MEdl8b4OFuvl+t9aM2rpILcJMktD8W/HU9s9UO2/WZQXAEbBgtgrorKy/L50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847025; c=relaxed/simple;
	bh=wClORBy9VhIJ4YdlVpnz6KvNJUTeSqLAp75ElW4c9O4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S35xYr6CWPPgCrawDoxPfJPN1oMKzwEqUkh45BStL/8mwyxC+41Rz9BSeTTiQH5wRb9qPm2BNKr09mzsjKHa3mc1eBc8z3AZo2XPCqSDFiAlKalsq6Fz3nAeFahAxoERyBGWx1RPVX3lnc28VvNCIyILeQ5/+/B52EpnsdrSQ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VffF5aG1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847024; x=1810383024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wClORBy9VhIJ4YdlVpnz6KvNJUTeSqLAp75ElW4c9O4=;
  b=VffF5aG1BFx7u7wl4HiK2aEPaeR1wtYYiJmxodzuZ9DoGKyTYcTv7Kdu
   ACesXe8TEYSzCSDHrDp0lAlL/AAyaG3ndNynrSJJCrzEieb3LVnw+98l5
   dmEj1FzS1kUjuVNzDpGmRIPM7RY9gRxRkKf+18CjphbbcP6kQT3U/dUVm
   vyoBnjA23P4o6J4tAClgRcShKSwQlRZEubG5Cmv4pQUHYtisKhgt6JZ5B
   vKWxvNBwyU6UjoNQIuetHdrBwC6FG1+kTVXcarsGGjpOGdnswrtV93ikk
   qzLSOD5KMgn/n9E/6yuwJt9vUwaBOrxbpiT+goj+8JmLK3OoUchRTvHcY
   g==;
X-CSE-ConnectionGUID: Gh0Iv5fwQlm8fGF8krAEGg==
X-CSE-MsgGUID: RHxaJ+lNTSOzG8SUxEG3gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185696"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185696"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:23 -0700
X-CSE-ConnectionGUID: MdunyVhNQS6hp/aWcMVhFg==
X-CSE-MsgGUID: 7Slcdj+YRiuNzuoEwLA+7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243650084"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 15/15] wifi: iwlwifi: mld: disallow puncturing in US/CA for WH
Date: Fri, 15 May 2026 15:09:48 +0300
Message-Id: <20260515150751.df1f1fdd141f.I900c9e2e3dd722619db12ba10d0879a56a2a55f2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
References: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EFB5C5504B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36480-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

FM continues to follow the BIOS/MCC policy, while WH sets
DISALLOW_PUNCTURING for US/CA and clears it for other MCC values.
Update the MCC handling accordingly.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
index 16bb1b4904f9..8502129abe49 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include <net/cfg80211.h>
@@ -129,7 +129,7 @@ iwl_mld_get_regdomain(struct iwl_mld *mld,
 
 	mld->mcc_src = resp->source_id;
 
-	/* FM is the earliest supported and later always do puncturing */
+	/* FM follows BIOS/MCC policy, WH disallows puncturing only in US/CA. */
 	if (CSR_HW_RFID_TYPE(mld->trans->info.hw_rf_id) == IWL_CFG_RF_TYPE_FM) {
 		if (!iwl_puncturing_is_allowed_in_bios(mld->bios_enable_puncturing,
 						       le16_to_cpu(resp->mcc)))
@@ -137,6 +137,15 @@ iwl_mld_get_regdomain(struct iwl_mld *mld,
 		else
 			__clear_bit(IEEE80211_HW_DISALLOW_PUNCTURING,
 				    mld->hw->flags);
+	} else if (CSR_HW_RFID_TYPE(mld->trans->info.hw_rf_id) ==
+			IWL_CFG_RF_TYPE_WH) {
+		u16 mcc = le16_to_cpu(resp->mcc);
+
+		if (mcc == IWL_MCC_US || mcc == IWL_MCC_CANADA)
+			ieee80211_hw_set(mld->hw, DISALLOW_PUNCTURING);
+		else
+			__clear_bit(IEEE80211_HW_DISALLOW_PUNCTURING,
+				    mld->hw->flags);
 	}
 
 out:
-- 
2.34.1



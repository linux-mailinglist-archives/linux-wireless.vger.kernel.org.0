Return-Path: <linux-wireless+bounces-33631-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCUgBpDVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33631-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:29:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F72E6876
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9454D3014687
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B233ADB9;
	Sat, 21 Mar 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jA+uzx9d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E733B6D5
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114181; cv=none; b=DOxygavISOqVkVLQf4VfRRZSK0wRVC212pgTMHXTdde9HcazOhqwLvwSxArgboPTiyAg87ghZTzz5ZXTfF0trErhQ/ydWME6NIL72+hfOVsWtWqlasA1tz/a6Kf8epR+cr3pHT/w+t7vk+dh79xTeJPb72PkYLgkjgbQbq4x8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114181; c=relaxed/simple;
	bh=RYDVsSS88eb853/WH9CvJvU6hlcVuEIPS4HIjkfMsO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtaHhaqgixv1u11RFB7v3ivRpYURV4ZTXE/Ex8JvUrNKGjsIloLvxEhjPJ/HoOcJ2cpeN0aSf5oXrfrqWqKuGslen2QVsm43UKXHp0PThd142mex4NiEtIvJrN9ZCL0C+9W9mbVICpfFJ6NcYTkciUhiHi2mKlhR1zs0cHFEBw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jA+uzx9d; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114179; x=1805650179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RYDVsSS88eb853/WH9CvJvU6hlcVuEIPS4HIjkfMsO8=;
  b=jA+uzx9ddbtAe2fO/G9TYdV3ZWDqM3lseOjrjPZoYRNNJEROnJbKCy9x
   cTqTF4fgEDb1WjvKfCc1isFegtwfBiYv3DyjWZoZOx6FeUKi1mt4aUKc+
   khu46su54keG1mNRO1byQDr9O5qSMf+x2pLxsli1Zoei9pK8epcmRj1MT
   gxVJPAWHTVNPgE2g/NOgxnv4AFr01TzEaP03UcetC4QJ2FJyCq/9ZssWo
   Vz4+R938koC6nTyQZiJ5Ez0KMltk7SDyeW9XPsKtqZy7YxdghW2qC0byr
   txBa61HMQ6zwGTBrG4aQLd39HyF9dUhXTA8WxMtCE+8SsHAH/wMllUryd
   w==;
X-CSE-ConnectionGUID: Fmscl5rDT0uT4Id5T3JrbQ==
X-CSE-MsgGUID: eGdRKiBGSt+iQyYgA9vXOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244588"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244588"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:38 -0700
X-CSE-ConnectionGUID: Qn5BNxZrS7e5Spu3aDRotg==
X-CSE-MsgGUID: SWF5ose0SuaroWmHJGu0JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813573"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: handle NULL/ERR returns from ptp_clock_register()
Date: Sat, 21 Mar 2026 19:29:11 +0200
Message-Id: <20260321192637.adea594600e8.I0e3d3f7ce897c54fff8ace6dd0faf55b4f39832b@changeid>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33631-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 7D4F72E6876
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avinash Bhatt <avinash.bhatt@intel.com>

ptp_clock_register() returns NULL when PTP support is disabled and may
return an ERR_PTR() on other failures. Reduce Log severity for NULL
return cases to avoid misleading errors when PTP is unavailable.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
index 231920425c06..c65f4b56a327 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -301,10 +301,12 @@ void iwl_mld_ptp_init(struct iwl_mld *mld)
 	mld->ptp_data.ptp_clock =
 		ptp_clock_register(&mld->ptp_data.ptp_clock_info, mld->dev);
 
-	if (IS_ERR_OR_NULL(mld->ptp_data.ptp_clock)) {
+	if (IS_ERR(mld->ptp_data.ptp_clock)) {
 		IWL_ERR(mld, "Failed to register PHC clock (%ld)\n",
 			PTR_ERR(mld->ptp_data.ptp_clock));
 		mld->ptp_data.ptp_clock = NULL;
+	} else if (!mld->ptp_data.ptp_clock) {
+		IWL_DEBUG_INFO(mld, "PTP module unavailable on this kernel\n");
 	} else {
 		IWL_DEBUG_INFO(mld, "Registered PHC clock: %s, with index: %d\n",
 			       mld->ptp_data.ptp_clock_info.name,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
index ad156b82eaa9..f7b620136c85 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -304,7 +304,9 @@ void iwl_mvm_ptp_init(struct iwl_mvm *mvm)
 		IWL_ERR(mvm, "Failed to register PHC clock (%ld)\n",
 			PTR_ERR(mvm->ptp_data.ptp_clock));
 		mvm->ptp_data.ptp_clock = NULL;
-	} else if (mvm->ptp_data.ptp_clock) {
+	} else if (!mvm->ptp_data.ptp_clock) {
+		IWL_DEBUG_INFO(mvm, "PTP module unavailable on this kernel\n");
+	} else {
 		IWL_DEBUG_INFO(mvm, "Registered PHC clock: %s, with index: %d\n",
 			       mvm->ptp_data.ptp_clock_info.name,
 			       ptp_clock_index(mvm->ptp_data.ptp_clock));
-- 
2.34.1



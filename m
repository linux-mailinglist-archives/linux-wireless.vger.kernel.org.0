Return-Path: <linux-wireless+bounces-37033-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePyzJ8FOF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37033-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6025E9E73
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ED6030696E1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A0A3B6379;
	Wed, 27 May 2026 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3Shz+Kw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65A3B6374
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912339; cv=none; b=bH41tHLLS3VlYMaE6G4RVygvEh2OIife6TOsPCokCUJQFBhb9LfQ2SGCabSTQ7w5YEaO0cfrTlrMSepjXvPCDt8abkPWh5SWYwAma2cJd6USZccaFilz440j01pb7HGzhgHxSw8VikAmhU073bB65yW1l1WdAPLy1chdUojH/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912339; c=relaxed/simple;
	bh=rKSHZbPZg0rJ4sOy97VCFtnnC87BtJAfdYzI4/sNn3Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGxY51qwFwurzBsFfP8RM2sI7sLSvzEwuCQcHnb9EGtF4oS2qDEzlyFXk8Et0BlP3AxqhZVKLwzK2tOHAzZb+8XcEgkdH1ZDtlXQOI0mPw9fwZfYZQTdE/aN89vBdxgSkWOXr+M50s4v/BEgdU82bwl/rjqzLrprIbypGT/zJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3Shz+Kw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912339; x=1811448339;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=rKSHZbPZg0rJ4sOy97VCFtnnC87BtJAfdYzI4/sNn3Q=;
  b=e3Shz+KwxFc5jlPe2c5iONkScJLD4SUm3MrMhWCtPPY/uikWwZK7BBQ4
   zQtzMtLIa1JbqzvfnuaNsvr9aZQIj7E+Nr5hiQYLsdd7uxGkQ/Q7oTd8F
   wbgZCAzQm8z0lkBTWbqEBoUQlWCgG5RkIioH/EYcX3cfjdBp8X3wOAxcG
   OeQWPZwdHeo//7OOQFMidcn1oSCsw2PbNcIkTo8iJ2B9CwjwU7H1OubB0
   mvdb48IAyi+p8PkQtj7gChxr+BzyXbhriuIOghPOSVhp5q8Qg8ihbyCTb
   fNI4uBBY7nUsMuoGYQYksJeIkt5E96mubjUerrhatwkPhu0hDurbRzCqM
   A==;
X-CSE-ConnectionGUID: gaDDlzCYSm6yGNbn76HSLA==
X-CSE-MsgGUID: aXnJwt4zTBG7Fcu6kVj49w==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940870"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940870"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:38 -0700
X-CSE-ConnectionGUID: cG/csnSiRJ2dEIubQZBuOA==
X-CSE-MsgGUID: IKeeSEJeQ3+RbUvxpDwyCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286964"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: always allow mimo in NAN
Date: Wed, 27 May 2026 23:05:05 +0300
Message-Id: <20260527230313.abd136be474e.I9eb663d953b482236345ffbcb611f28facea83c1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37033-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 0D6025E9E73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mimo field of the sta command is badly named. It really carries the
initial SMPS value as it is in the association request of the client
station (when we are the AP).

In NAN we don't have this information, just mark SMPS as disabled.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/sta.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 77eeeed66116..e18d86f021dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -538,6 +538,12 @@ int iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
 		break;
 	}
 
+	/* In NAN, there is no association request so no initial SMPS info */
+	if (mld_sta->vif->type == NL80211_IFTYPE_NAN_DATA) {
+		cmd.mimo = cpu_to_le32(1);
+		cmd.mimo_protection = cpu_to_le32(0);
+	}
+
 	iwl_mld_fill_ampdu_size_and_dens(link_sta, is_6ghz,
 					 &cmd.tx_ampdu_max_size,
 					 &cmd.tx_ampdu_spacing);
-- 
2.34.1



Return-Path: <linux-wireless+bounces-36474-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAhzIT0VB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36474-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:44:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773A54FD34
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4B543140423
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606453FE363;
	Fri, 15 May 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/a3FwhI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929F47DF8D
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847017; cv=none; b=YKueDHjyg5G6h46OwfsS5wS1LI4Dbg9Tk1uJMdzuCJxH5OQsGMZ4tF9REL/8bZIO7MfPAMgzB1V3Jab2ypndDBwud85HT7i4INjnUieGkRWQ7ybxv9kp+NA56W+iBhfpbp/34C1oBYo3zd4+i0aq6wfx5KWzPMUWIrpD0gcCGoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847017; c=relaxed/simple;
	bh=H/BR6vVAxgALlYGNh4PSMQHWm5CefTxpF6lG80lT6yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DL1F/l+I2haGxg7yKClFb04zWZPn3vtsxd4aCqCsLICL11jX6YNNuY4s43gUGlrBQjr+kyRWHEIlWjp0pxr9eJBFKiQ+DkFaZIDJyWfewtY2HyKphnnBapzF29/PT3qRQiaZMmrn/48B2cnDbsLQdHzT0o5A8AifdeT+ozaI5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/a3FwhI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847016; x=1810383016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H/BR6vVAxgALlYGNh4PSMQHWm5CefTxpF6lG80lT6yA=;
  b=S/a3FwhItG8+cJCJXmNzM0a2dHdeT4397PYrFgzU6tH7RdQLl18PPya+
   GPcRUnPiy7M0vnOKSjNpyLv7eUQ9grBItV0tdslT6h3UFs3tt3LOJMQFd
   9BSi60CmKEPog6G0EENvO5A0hK+QStNjPEWxvzquRr4nJRSvbNNgUPd7t
   M/79xQcStoXHT8TEKhCw8oCbOB7zxIqUjO2+0ZpMWOKjQQfoqsuak9hnf
   7sprxq0h93rqmHsBQK/K20y0AfLEBfMQWYsSqFamkeA18jpmIVuFF4cGu
   ocWWKb3j8pqJ0k0y97voThfgD2uX1yed5ek2ztuoNxjH6TcCkBCALynWZ
   g==;
X-CSE-ConnectionGUID: f709ANexQzC2OR3sZ369aw==
X-CSE-MsgGUID: 184pnKEHS1SyDkKcIyqviQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185681"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185681"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:15 -0700
X-CSE-ConnectionGUID: K/G497v+RYK/KzIRcHQHeg==
X-CSE-MsgGUID: M4TEUjE+RE+2rKevk/q5wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243650025"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 09/15] wifi: iwlwifi: mld: rename LINK_DEBUGFS_WRITE_FILE_OPS
Date: Fri, 15 May 2026 15:09:42 +0300
Message-Id: <20260515150751.5bff36ea7dd0.I62b01f83b622f281257fb842d9cc00b28dc2f5e1@changeid>
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
X-Rspamd-Queue-Id: 0773A54FD34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36474-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

These are with wiphy mutex held, so rename the macro to
LINK_DEBUGFS_WIPHY_WRITE_FILE_OPS indicating that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
tested: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index ba5a47519aa1..afe972834cb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -979,7 +979,8 @@ void iwl_mld_add_vif_debugfs(struct ieee80211_hw *hw,
 	VIF_DEBUGFS_ADD_FILE(twt_operation, mld_vif_dbgfs, 0200);
 	VIF_DEBUGFS_ADD_FILE(int_mlo_scan, mld_vif_dbgfs, 0200);
 }
-#define LINK_DEBUGFS_WRITE_FILE_OPS(name, bufsz)			\
+
+#define LINK_DEBUGFS_WIPHY_WRITE_FILE_OPS(name, bufsz)			\
 	WIPHY_DEBUGFS_WRITE_FILE_OPS(link_##name, bufsz, bss_conf)
 
 #define LINK_DEBUGFS_ADD_FILE_ALIAS(alias, name, parent, mode)		\
-- 
2.34.1



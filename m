Return-Path: <linux-wireless+bounces-2870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF08438E5
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148471C2543D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7BE5C5E3;
	Wed, 31 Jan 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7oi4h3J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17A6025C
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689507; cv=none; b=ccEUa0wbWDuixiK/6l7WDHyFlGD1U/FkzqLJb3O+bkVuesDfYT9WnFrfKVkL3QbsappBgR53FJ67VvUU1c9DzaMzUnYTk+3Es1VWZgWkXSw5yaQH58rQhGbkLXuq/e8wK8XcJsn5TGTiVlrAxt8kK1ZP2T1dCRWvE3mKNdfW+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689507; c=relaxed/simple;
	bh=cVc1agd6Nl/hFRxEG3e4btBkKzKBjNWmffLZBaREe74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dI4CwHPLa2pQGljF2hPpLUHUEi4GceWAoiJj8IpancPBUcfChc/j3m1f6NsVoDFm1/ASTx/Uikfo8TkRYZH4ebIqfRntPZvRtOarKKInCWB0kH0dvUf2oK8OFk2xF0HQRstmTxEA7N3EfhInSW38n7y73c2+4/UD8xZa4eBkKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7oi4h3J; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689505; x=1738225505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cVc1agd6Nl/hFRxEG3e4btBkKzKBjNWmffLZBaREe74=;
  b=i7oi4h3J1rDEzB3XcFJE/pJxtinBUuC/ARG+hQVnHo4lqnTkeydQj+P1
   IkQLxzhSuN7NubuMvsLtUh7rjpC2gVsSHj2qEwGjYGwJbnd+jR5YDH/Rx
   BrAOz+agx19HG8YDas7FwNHi/7EZU6QVn/1OpDZmSNIyQlt897U93Y29p
   I1RbElgNFVjrv2X75L/1739AaI4HXco5Hpikv+XPUCj7ZtYNUqQJL16j6
   TRIQTPzoyTSlR5AMHuHCur2LuQoSgNGlNjILj2bh4YZyWZhQp7IL6FSIB
   UTWz3a6KGbu1Y1k3DFJQq74CXbSaN4MyHFQlHFX9suiMlMGVI6D4Yd/vP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249902"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249902"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968850"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/14] wifi: iwlwifi: mvm: check AP supports EMLSR
Date: Wed, 31 Jan 2024 10:24:36 +0200
Message-Id: <20240131091413.edaac352488d.Ic3533afc6848591e8977391ae39c144d5e794d26@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
References: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Before using EMLSR check the AP actually advertises
support for it, otherwise reject the link activation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 9653d335d573..35ce84cc0194 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1281,6 +1281,9 @@ static bool iwl_mvm_can_enter_esr(struct iwl_mvm *mvm,
 	if (primary_link < 0)
 		return false;
 
+	if (!(vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP))
+		return false;
+
 	for_each_set_bit(link_id, &desired_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf =
 			link_conf_dereference_protected(vif, link_id);
-- 
2.34.1



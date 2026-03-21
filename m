Return-Path: <linux-wireless+bounces-33630-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULUNGrHVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33630-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD62E68B9
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB0373021712
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5EE339705;
	Sat, 21 Mar 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpS73kPW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E233B6D4
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114179; cv=none; b=DVFJSU7UOIVlPdqaPZhlk2QNFmuIW2UwXm+hzSmdT2t/uE9IyWxCS1i3WNBeAcsQkWBm0AFNMi/iwl7iF0efTyXoYsJMrAv8ph02xoWQs2P/aaXRuVt/a2HFiYJCwP6dBakrCizv+SF1AIZwplvnYQBh4BzsYL3b2e58HGYchDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114179; c=relaxed/simple;
	bh=n7vkyxdUFc3YIiEb/A8iBmTnu8otikYQwf/+Osrw0Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T25qsBQWpBPOBFGKNbxRMRiOsVmYV1RgzPOIavS/0x3dSLMxeKKMi8blwHy1eu+elLtFYrzt0rnYH3rvY9IHKx7/0bvhPkq7cZAeJ581+cc4oi/FG4KGpsDbBVHsrfGIQo8ts8cQOIqAs156aA98TLbcSVYkgZwACeEWY62gWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpS73kPW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114177; x=1805650177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n7vkyxdUFc3YIiEb/A8iBmTnu8otikYQwf/+Osrw0Sg=;
  b=ZpS73kPWmr81rzkFO3/7UNC6ZhvcFXSTBXI9dVvS0lXsFAUCt8RYjzT4
   Kq0DhsSqtEPmV+VHmqfJf3wHrPXtXC4qmqo9AWdz9iOLRR1Pk5ADcOLD+
   QubsGcv+OC6b3LoK/NEpnvFAcNQUPwjsNBng0q/UhA8C+l2hR9dHNw43i
   kURMDjBbq1M2t5CWxbb9j0FLzD09oWMuvq0vi84PkBaGX87ZzBVFKZwS+
   fBXuRvzSvTR+rOSs+gNgQFFNJF0JFAfRZVIL10oKN9Yvq+bJCApHi71XT
   gtkLoHIYeQub9jmdQCx28e5CBhFt8TSiRC1hJvbZTP5/itfdJVxUiQzCf
   g==;
X-CSE-ConnectionGUID: FqHIB62TTi+cRJEMNwKjWg==
X-CSE-MsgGUID: 2gxgKXRSTRK1Cefnwgqe4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244587"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244587"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:37 -0700
X-CSE-ConnectionGUID: uQNEd9gGSReMV3NwMdypsA==
X-CSE-MsgGUID: oqEJLFEGSZO/hFYx3lZ76A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813570"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: add double-include guards to nan.h
Date: Sat, 21 Mar 2026 19:29:10 +0200
Message-Id: <20260321192637.4e09d461db6a.If5c14c495b14a20ce7abadc72be57a40d3462bfb@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33630-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: BACD62E68B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

This is missing, but needed when we want to add data structures
to this file.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/nan.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index c9c83d1012f0..c04d77208971 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -2,7 +2,8 @@
 /*
  * Copyright (C) 2025 Intel Corporation
  */
-
+#ifndef __iwl_mld_nan_h__
+#define __iwl_mld_nan_h__
 #include <net/cfg80211.h>
 #include <linux/etherdevice.h>
 
@@ -26,3 +27,5 @@ bool iwl_mld_cancel_nan_cluster_notif(struct iwl_mld *mld,
 bool iwl_mld_cancel_nan_dw_end_notif(struct iwl_mld *mld,
 				     struct iwl_rx_packet *pkt,
 				     u32 obj_id);
+
+#endif /* __iwl_mld_nan_h__ */
-- 
2.34.1



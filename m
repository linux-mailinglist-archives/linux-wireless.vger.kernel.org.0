Return-Path: <linux-wireless+bounces-39065-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SAMDHhVDVmqr2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39065-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:09:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB867558C0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:09:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Y8ybZLZC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39065-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39065-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EC8A30F66FB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54D47B425;
	Tue, 14 Jul 2026 14:02:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B047CC7E
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:02:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037770; cv=none; b=mrMKrTXGoDNnf6BMcyKSqNOzLFOkKtf0KaSS5b1MomEs9hj7xODT+Q6CnZcYSgID2qJMt/ItA2BexNeNqW7TsswJokw+XDu00b5hdT3Eodr91FHErfDt3lhjHncPzbe4yxrA6HRujzxTt4OLGwO3knXYT/NmbuAPvB+BBV4yrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037770; c=relaxed/simple;
	bh=S9V2CGgXTfY9sZnVk5ism3Adjgx7xGDoqZ/ZT7D46C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/WA2bXo/90Sn6X4oGqlmkIbjfG2h9zuXLZ2ZEqwGkLkbN/DQtq+gT/6E+Re0DqiK1o6CYFhCdcC15frk4QdZaroxTdR+pp5EVwleu7cYzTU3QsuZlwrpl1s1HKwVrubf+XJ/Ix24ek6mdjNzgs9/PyFQLuZ+U2oORL8adJ+fKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8ybZLZC; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037768; x=1815573768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9V2CGgXTfY9sZnVk5ism3Adjgx7xGDoqZ/ZT7D46C8=;
  b=Y8ybZLZC6ZsY8wX3DaMtwbzeLNH+OpVBJMvr5nIRUkwa91W3V8gOXpP0
   TKkrGHBIwc5zA4J64nmEY8wWK6RjW80G5Li4j+WxBrUT8B9UnuwbNjywh
   RrT3O5zU2Q8KXEU3rIci36k8f8zjGT3qKhXpOxBo+6GrPcwtiBKCBcBdk
   Ekm09wvL6s7SWluNKp9a+LWRDDnMK/OQzucWfDa+IngYhU6L6KGenm9g1
   pVsk9WmmqGlddwbHiqhgwsB4ZNuidHtL3xs8+hV/6Hh1tYs5GN873Wd9w
   Ne+lnG/4OMJNzzB1pbOWjeTJp+4ovMLVAMrBrtpyUiuxdcqABO79y1JSH
   A==;
X-CSE-ConnectionGUID: ucONs0oFQyyc2EjNhFQMsg==
X-CSE-MsgGUID: Jd839LluQ+OHJO2YAy62rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855086"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855086"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:48 -0700
X-CSE-ConnectionGUID: 9YL8BHuDTnmAGstgKpwJYw==
X-CSE-MsgGUID: QkpC1mH/Q8iSPxgwcKmz7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254737853"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 05/15] wifi: iwlwifi: mvm: fix the FCS truncation logic in d3
Date: Tue, 14 Jul 2026 17:02:08 +0300
Message-Id: <20260714165826.a7d094168ed3.I1a4d13f276c7e75514ab2032ae387873337470b8@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39065-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,changeid:mid,intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDB867558C0

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Fix a harmless mistake in the wake packet management code in the d3
wakeup flow. If the FCS is truncated, we want to detect it, but we
cleared the icvlen before updating the truncated variable that holds the
number of bytes having been truncated.
Fix that.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 9a74f60c9185..d7ceb385ae0b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1539,8 +1539,8 @@ static void iwl_mvm_report_wakeup_reasons(struct iwl_mvm *mvm,
 
 			/* if truncated, FCS/ICV is (partially) gone */
 			if (truncated >= icvlen) {
-				icvlen = 0;
 				truncated -= icvlen;
+				icvlen = 0;
 			} else {
 				icvlen -= truncated;
 				truncated = 0;
-- 
2.34.1



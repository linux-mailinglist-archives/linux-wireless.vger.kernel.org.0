Return-Path: <linux-wireless+bounces-33878-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ30F99QxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33878-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629F32C53A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4C78307F523
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE837C90C;
	Wed, 25 Mar 2026 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lx+Lr1OM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43064378D79
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473361; cv=none; b=oIcQnsv+cLxCa0QgDd5C7TUWBRUi79H97XxNLj3FDSetRfhgw3OLnZSKvVYwOqeaB8Jy4JS3FX2TzdxMCBlbPFX0L/VM37qPGdSRC7H7/Em0ZxssoqOLSj+DsjIUIu29JYXc8SmQXFk7GiP8szBxaTZfqU3E5uAK/6C4cqm4jUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473361; c=relaxed/simple;
	bh=VbqwXgle74f0RuloSkw11VWzoivAgdhV1tqAvI/aSVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIdrrYzpW2CSBG3nCr0SzqOQakgnE/wsDRNUv3iG/gV9D0CvqkOM6M/7qRDjJx4Nv9uMvIPAKDHKyydkVtrZyEPWeGpDaGocjBb9xHgqJaduqjLIXXOJStJMjcPG6SIxCQXnYsqAN4DkhMzJX2lLfdSMTMBArKQlQJ926f4Bha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lx+Lr1OM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473361; x=1806009361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VbqwXgle74f0RuloSkw11VWzoivAgdhV1tqAvI/aSVE=;
  b=Lx+Lr1OMDq4CinKH+sZ8nIWOCfdEb0gySj8HBEZIC/p3rqXrmyJvC2vz
   tCjGX5IpxPbw/iqAMVryducdycRVaQyAI0FBnvSXLVmq5nl8ba7WMICX4
   tdRlEDUtV8AzsM1y1wgX+F3mRdF5HepAvxh8eVCo2iwID1WlnAU4z0m7k
   Ku8eByz7QMsrA8z2bNxq2GAlLmkRXB/GxdLJIdFpUaQd7EU1I7oDh9UAs
   7bfujxHOKVdAtpob0QBl2WreJ6C57iOi5vEjS2AViz743ql8t517iv3fh
   m2SoWkjV2TaFCzDLzV4dYY3SKKKqlUIfsK99S3mBhkCg0HfVP4zJTA7LY
   Q==;
X-CSE-ConnectionGUID: E9p0cZ1bRaKhMYbaoBhFZw==
X-CSE-MsgGUID: o/EqTso+Rpqgu66nfW+xHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485367"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485367"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:00 -0700
X-CSE-ConnectionGUID: AtQSocKJSjuuVLAwYejNXA==
X-CSE-MsgGUID: q86nq6HrQPaHgVPlWRMW6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747499"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:15:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 07/15] wifi: mac80211: handle reconfig for NAN DATA interfaces
Date: Wed, 25 Mar 2026 23:15:28 +0200
Message-Id: <20260325230443.65b544062079.I2ba3bfcd93e47e48d7f7c74007c70cca52d46896@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
References: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33878-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1629F32C53A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure these interfaces are added to the driver only after the NAN
one was, and after NAN operation was started.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 19ac778b704d..925a09246ad9 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1780,10 +1780,11 @@ ieee80211_reconfig_nan_offload_de(struct ieee80211_sub_if_data *sdata)
 
 static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 {
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *ndi_sdata;
 	int res;
 
-	res = drv_start_nan(sdata->local, sdata,
-			    &sdata->u.nan.conf);
+	res = drv_start_nan(local, sdata, &sdata->u.nan.conf);
 	if (WARN_ON(res))
 		return res;
 
@@ -1792,6 +1793,15 @@ static int ieee80211_reconfig_nan(struct ieee80211_sub_if_data *sdata)
 
 	drv_vif_cfg_changed(sdata->local, sdata, BSS_CHANGED_NAN_LOCAL_SCHED);
 
+	/* Now we can add all the NDIs to the driver */
+	list_for_each_entry(ndi_sdata, &local->interfaces, list) {
+		if (ndi_sdata->vif.type == NL80211_IFTYPE_NAN_DATA) {
+			res = drv_add_interface(local, ndi_sdata);
+			if (WARN_ON(res))
+				return res;
+		}
+	}
+
 	return 0;
 }
 
@@ -1945,6 +1955,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
 		    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 			continue;
+		/* These vifs can't be added before NAN was started */
+		if (sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+			continue;
 		if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
 		    ieee80211_sdata_running(sdata)) {
 			res = drv_add_interface(local, sdata);
@@ -1962,6 +1975,8 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
 			    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 				continue;
+			if (sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
+				continue;
 			if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
 			    ieee80211_sdata_running(sdata))
 				drv_remove_interface(local, sdata);
-- 
2.34.1



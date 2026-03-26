Return-Path: <linux-wireless+bounces-33953-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCetNEkMxWn05wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33953-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E67F333841
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA49331A33C7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00B23C197A;
	Thu, 26 Mar 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJQS54t2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179C38736E
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520113; cv=none; b=DNK8bgTLIlYteNpWf3QMjONJ1hvYPevdRCxcorh7UXJpiGowUKF7e4c5HkGeNYflvG+3VZ6G2q7KSLEuIUjGuoddzpGMRe+yw1wVtQxhpjLfkck+S4nPFfX0ERNL5gc/iM9eU6xaJDzvgFN3TxQAFoAU4cBFnCfx/SepLMZ4+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520113; c=relaxed/simple;
	bh=v/pEsNc7JVGlS+yMdEvQt9CNPYJCH41hZ98QqUxfLMU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DmlmGBROCaM98xMeeQkVA0Iiw4xQChq/+qe7mMUsVeQdDDu4JB0hgfoH34cBTIqXirf66R1aISTAOZhY6B9HL5aQWgAVF4SekE0bBanSwO75cRKK7zzuzkbRZXaB2Eyy/yqEsQWbN9dPk6NYQXnMdGmDECqISDmgR+9y/JAeecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJQS54t2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520113; x=1806056113;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=v/pEsNc7JVGlS+yMdEvQt9CNPYJCH41hZ98QqUxfLMU=;
  b=jJQS54t29oLsWCzHr34LQ+YnH1fcAMz8D50PaZViBaDutC6O0a+ba3eP
   m3SoF77e57utgwQ9nkOfI4CEva2lSojDok5Rd/jVw+28n5kwBKtq2YrM/
   5tmfGzJT85XZAhBpKAr/IPb7z52yv3/RttMnS15UArA6yoNVDQINiTUpr
   BCMvaLsQP1Lg/BSAb8gU5n1rdphuVWS7OC7EeIXT20+wN6ktAgplEHq38
   viMD7FLUWx/cG2MCUf+FrKcjLXXVKeegDPG3u4rZ65rCs6HkofG1lC9pz
   uY08MQV61fmU9oH8ze3Ev2OzwPhkTNSWKappcbTYHoVJmyckk9P9OFHeL
   g==;
X-CSE-ConnectionGUID: SvjzQdk8RN2I51/9FAwYSQ==
X-CSE-MsgGUID: wjHSNkFNQ2ihFB04CNKM6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048563"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048563"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:10 -0700
X-CSE-ConnectionGUID: cgNynML0TuqV91k90XAEiw==
X-CSE-MsgGUID: Qv6oroa3TMGWuuRdG0G66w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653178"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 07/15] wifi: mac80211: handle reconfig for NAN DATA interfaces
Date: Thu, 26 Mar 2026 12:14:37 +0200
Message-Id: <20260326121156.b14392ce99d6.I2ba3bfcd93e47e48d7f7c74007c70cca52d46896@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
References: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33953-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E67F333841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure these interfaces are added to the driver only after the NAN
one was, and after NAN operation was started.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
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



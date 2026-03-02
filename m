Return-Path: <linux-wireless+bounces-32340-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJzSInc4pWnt5wUAu9opvQ
	(envelope-from <linux-wireless+bounces-32340-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 08:12:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F54C1D3B12
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 08:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B14E63019837
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190CA383C60;
	Mon,  2 Mar 2026 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwTYYSID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3B37FF62
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435522; cv=none; b=PfNxeGFnAgCvQ+gD2mrLvZdLV4cXnog0K4GRUPLjbqxuwPS8hy/Laapr8FmzSBPFavyvbZ3yYAQbYnEAZ6iDOnFvaMxdLkinCerBoBexlvJ7oONDmaRic2LATaoNUC7tsXvl3NMpjZRBPfgiKiqiBYyoBCUgEOtBwqaqxPV4Bm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435522; c=relaxed/simple;
	bh=446xDw1i5LOuLep3IN5xEpvBCkXhvd+Nc6e3bC+cLuc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mBTASHp01Ith0pZnXmTE+pr2nj7U5NqmGd/0nkRf4PbLV3wDaJbSNfo+MmaHKiZxodbWQPg4vD5YwKyZ0/GnFrP0o3LNciecEyxaqJJDeYjDrJH7Po59uAeWwSs9ry8DRfSvTe8lvAXQbAf0mTgFep+Y88MupQ6WMgZyFegVUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwTYYSID; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772435519; x=1803971519;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=446xDw1i5LOuLep3IN5xEpvBCkXhvd+Nc6e3bC+cLuc=;
  b=CwTYYSIDB+jYcfjtTdxXpGsBe/kaeTha2jTHtZ+JFLEnZNeIM8HrRpOC
   /hIi7t8BTQnB18QWVI9kbjlhWssKApGySxysf/tkEbOWVOerytuaMoacR
   VVw29g7r9cZprP/1iWPMOWe5G4tdxLC0Q2UVNN9oe4WpF6qPEs9ob2vrL
   Lx6xSa44SSb6QtPKXH6w8fA8tBdFV0bBwXDkltOOMT2kSdbpACbhcWlea
   gQ40FmXPVBHItlUxYn4Vstd5uXweWzek65rgS4De3WPxJalaL1qfenAm+
   npCf29w/yHHzz8eUxRzmd2dK46ffj8Kf+A1C305OTlA7QIhhTlh0pGew1
   w==;
X-CSE-ConnectionGUID: TOd/9QYXSoCpiTcW32nDhQ==
X-CSE-MsgGUID: EqYwSTlmSqunjf85/3bjeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73547110"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73547110"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:11:58 -0800
X-CSE-ConnectionGUID: PhGX6jxETt6Z4mZsPiuJqQ==
X-CSE-MsgGUID: 7+mT0feTT5ymUnCALzZKdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="217581968"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:11:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next] wifi: cfg80211: make cluster id an array
Date: Mon,  2 Mar 2026 09:11:46 +0200
Message-Id: <20260302091108.2b12e4ccf5bb.Ib16bf5cca55463d4c89e18099cf1dfe4de95d405@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32340-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 0F54C1D3B12
X-Rspamd-Action: no action

cfg80211_nan_conf::cluster_id is currently a pointer, but there is no real
reason to not have it an array. It makes things easier as there is no
need to check the pointer validity each time.
If a cluster ID wasn't provided by user space it will be randomized.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: fixed hwsim to not check if cluster_id is not NULL.

 drivers/net/wireless/intel/iwlwifi/mld/nan.c  |  5 ++---
 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +-
 include/net/cfg80211.h                        |  3 +--
 net/mac80211/cfg.c                            | 12 ++----------
 net/wireless/nl80211.c                        | 14 +++++++++++---
 5 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 2dbd3d58b0c6..4d8e85f2bd7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -54,9 +54,8 @@ static int iwl_mld_nan_config(struct iwl_mld *mld,
 	ether_addr_copy(cmd.nmi_addr, vif->addr);
 	cmd.master_pref = conf->master_pref;
 
-	if (conf->cluster_id)
-		memcpy(cmd.cluster_id, conf->cluster_id + 4,
-		       sizeof(cmd.cluster_id));
+	memcpy(cmd.cluster_id, conf->cluster_id + 4,
+	       sizeof(cmd.cluster_id));
 
 	cmd.scan_period = conf->scan_period < 255 ? conf->scan_period : 255;
 	cmd.dwell_time =
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index e89173f91637..b69e730108ea 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4078,7 +4078,7 @@ static int mac80211_hwsim_start_nan(struct ieee80211_hw *hw,
 		      ns_to_ktime(until_dw * NSEC_PER_USEC),
 		      HRTIMER_MODE_REL_SOFT);
 
-	if (conf->cluster_id && !is_zero_ether_addr(conf->cluster_id) &&
+	if (!is_zero_ether_addr(conf->cluster_id) &&
 	    is_zero_ether_addr(hwsim_nan_cluster_id)) {
 		memcpy(hwsim_nan_cluster_id, conf->cluster_id, ETH_ALEN);
 	} else if (is_zero_ether_addr(hwsim_nan_cluster_id)) {
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc01de19c798..73f4aa15c956 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4020,7 +4020,6 @@ struct cfg80211_nan_band_config {
  *	(i.e. BIT(NL80211_BAND_2GHZ)).
  * @cluster_id: cluster ID used for NAN synchronization. This is a MAC address
  *	that can take a value from 50-6F-9A-01-00-00 to 50-6F-9A-01-FF-FF.
- *	If NULL, the device will pick a random Cluster ID.
  * @scan_period: period (in seconds) between NAN scans.
  * @scan_dwell_time: dwell time (in milliseconds) for NAN scans.
  * @discovery_beacon_interval: interval (in TUs) for discovery beacons.
@@ -4036,7 +4035,7 @@ struct cfg80211_nan_band_config {
 struct cfg80211_nan_conf {
 	u8 master_pref;
 	u8 bands;
-	const u8 *cluster_id;
+	u8 cluster_id[ETH_ALEN] __aligned(2);
 	u16 scan_period;
 	u16 scan_dwell_time;
 	u8 discovery_beacon_interval;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b92b4a5c2636..490e2d9b1720 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -330,7 +330,6 @@ static void ieee80211_stop_p2p_device(struct wiphy *wiphy,
 
 static void ieee80211_nan_conf_free(struct cfg80211_nan_conf *conf)
 {
-	kfree(conf->cluster_id);
 	kfree(conf->extra_nan_attrs);
 	kfree(conf->vendor_elems);
 	memset(conf, 0, sizeof(*conf));
@@ -372,9 +371,6 @@ static int ieee80211_nan_conf_copy(struct cfg80211_nan_conf *dst,
 		memcpy(&dst->band_cfgs, &src->band_cfgs,
 		       sizeof(dst->band_cfgs));
 
-		kfree(dst->cluster_id);
-		dst->cluster_id = NULL;
-
 		kfree(dst->extra_nan_attrs);
 		dst->extra_nan_attrs = NULL;
 		dst->extra_nan_attrs_len = 0;
@@ -383,12 +379,8 @@ static int ieee80211_nan_conf_copy(struct cfg80211_nan_conf *dst,
 		dst->vendor_elems = NULL;
 		dst->vendor_elems_len = 0;
 
-		if (src->cluster_id) {
-			dst->cluster_id = kmemdup(src->cluster_id, ETH_ALEN,
-						  GFP_KERNEL);
-			if (!dst->cluster_id)
-				goto no_mem;
-		}
+		if (is_zero_ether_addr(dst->cluster_id))
+			ether_addr_copy(dst->cluster_id, src->cluster_id);
 
 		if (src->extra_nan_attrs && src->extra_nan_attrs_len) {
 			dst->extra_nan_attrs = kmemdup(src->extra_nan_attrs,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b94231c8441c..e220ccbba91b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21,6 +21,7 @@
 #include <linux/nospec.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/random.h>
 #include <net/net_namespace.h>
 #include <net/genetlink.h>
 #include <net/cfg80211.h>
@@ -15725,9 +15726,16 @@ static int nl80211_parse_nan_conf(struct wiphy *wiphy,
 		return err;
 
 	changed |= CFG80211_NAN_CONF_CHANGED_CONFIG;
-	if (attrs[NL80211_NAN_CONF_CLUSTER_ID] && start)
-		conf->cluster_id =
-			nla_data(attrs[NL80211_NAN_CONF_CLUSTER_ID]);
+	if (attrs[NL80211_NAN_CONF_CLUSTER_ID] && start) {
+		ether_addr_copy(conf->cluster_id,
+				nla_data(attrs[NL80211_NAN_CONF_CLUSTER_ID]));
+	} else if (start) {
+		conf->cluster_id[0] = 0x50;
+		conf->cluster_id[1] = 0x6f;
+		conf->cluster_id[2] = 0x9a;
+		conf->cluster_id[3] = 0x01;
+		get_random_bytes(&conf->cluster_id[4], 2);
+	}
 
 	if (attrs[NL80211_NAN_CONF_EXTRA_ATTRS]) {
 		conf->extra_nan_attrs =
-- 
2.34.1



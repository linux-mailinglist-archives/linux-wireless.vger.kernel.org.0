Return-Path: <linux-wireless+bounces-33576-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIqzH5cCvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33576-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:17:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C02D7129
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95EF23061B5D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D094371894;
	Fri, 20 Mar 2026 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2hHajdw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DB37416F
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994195; cv=none; b=HxgJZQBtoAAzIVnBwE4UsVz1/2RrpzExxluF6Hl8Q9LGXgFeNb0JTrw40uPbeHK2gliSzJvGS0GSpiTKvkou1Q8Bzn2VVNwK9DMSvvyZW7vZTteSkPKC2A5uOCvjHvK+fuz9DTJHErhY1bAYKONjDonW46CU13DMSs8qxt3uTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994195; c=relaxed/simple;
	bh=5MBuoZZhJ+HLBIAgrrliXB02HayYDAE6CJ5NmT3QQiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnCijEknncIVy2srvAChgnP05gpKJS2UARzgROGc5iSC5kWnz/46YI8eDMfnDIdR/xKcZrHqCYkrZhFsHO1GlR7LR7GC2kMQAhaw521YCSxx7ZaoIP4zhScee/8JTuNSECwPvvptAL1paSBs32gPxkrkQV+PRXPFvlMKvU0QCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2hHajdw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994193; x=1805530193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5MBuoZZhJ+HLBIAgrrliXB02HayYDAE6CJ5NmT3QQiA=;
  b=L2hHajdwhc78AILDfnVA+sWzDivEaDnEFILq8hhK9b2cLpQ47o0qSbbv
   qSTTytaVKvHQ3R33uQDde+T2eyI+Cd5VnnoSsZBNF+Tzn7zyamZ9ZBLkO
   x+wwx1twyrTmu15o/iTYd9UvI64g8oqvUqdcN+9IN3DtZgBHZ8+wgRyW5
   rC74DqjOP1bxOG0QN9ZJD+beoqrZTzn8aR9aNhVkPFDaPVWXLsU7I8vkK
   zlrP4c0X56aFNRGmokb6WFSqtEbG/yDVnvNd4KDHXb0AiODdqyL4WjYYS
   HH+pJEv5mpUVRA/ClK93b6HeymXCv5Q4UB7HUaelfS0nozjx13w4aBAkJ
   g==;
X-CSE-ConnectionGUID: wNjBVkQ/Rs6c2SPBD4ZkWg==
X-CSE-MsgGUID: Y9S98UeYQzunLuNnrCXziw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154158"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154158"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:52 -0700
X-CSE-ConnectionGUID: hu8Bcm6jRDCBgSWm4Y4FIw==
X-CSE-MsgGUID: i7zIrZymQoKsnmxTwW7Qfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692635"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: remove type argument from iwl_mld_add_sta()
Date: Fri, 20 Mar 2026 10:09:18 +0200
Message-Id: <20260320100746.71841a054f16.I1851148e582eb710261740459a46d22720788926@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33576-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8E5C02D7129
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

This is used only in a single place, and the caller always sets
the type to STATION_TYPE_PEER right now. We need to change some
of this for NAN in the future, removing the type argument will
simplify that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c      | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mld/sta.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 5cd3cdffb570..358320051d1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1751,7 +1751,7 @@ static int iwl_mld_move_sta_state_up(struct iwl_mld *mld,
 				return -EBUSY;
 		}
 
-		ret = iwl_mld_add_sta(mld, sta, vif, STATION_TYPE_PEER);
+		ret = iwl_mld_add_sta(mld, sta, vif);
 		if (ret)
 			return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index f40c49377466..619f302076ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -755,14 +755,14 @@ iwl_mld_init_sta(struct iwl_mld *mld, struct ieee80211_sta *sta,
 }
 
 int iwl_mld_add_sta(struct iwl_mld *mld, struct ieee80211_sta *sta,
-		    struct ieee80211_vif *vif, enum iwl_fw_sta_type type)
+		    struct ieee80211_vif *vif)
 {
 	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
 	struct ieee80211_link_sta *link_sta;
 	int link_id;
 	int ret;
 
-	ret = iwl_mld_init_sta(mld, sta, vif, type);
+	ret = iwl_mld_init_sta(mld, sta, vif, STATION_TYPE_PEER);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.h b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
index 1897b121aae2..5f6c440bf058 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
@@ -190,7 +190,7 @@ iwl_mld_link_sta_from_mac80211(struct ieee80211_link_sta *link_sta)
 }
 
 int iwl_mld_add_sta(struct iwl_mld *mld, struct ieee80211_sta *sta,
-		    struct ieee80211_vif *vif, enum iwl_fw_sta_type type);
+		    struct ieee80211_vif *vif);
 void iwl_mld_remove_sta(struct iwl_mld *mld, struct ieee80211_sta *sta);
 int iwl_mld_fw_sta_id_from_link_sta(struct iwl_mld *mld,
 				    struct ieee80211_link_sta *link_sta);
-- 
2.34.1



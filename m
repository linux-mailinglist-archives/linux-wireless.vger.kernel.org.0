Return-Path: <linux-wireless+bounces-33395-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPpgEF2eumngZgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33395-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:45:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A45F72BBBE9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C4831C58E9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 12:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE2C3D6CB7;
	Wed, 18 Mar 2026 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmvRpT3s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F23D6682
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837594; cv=none; b=egEqoZZ62dcUXJLFGCaT/ytmXP5+K6laHyrBbzfO5qiFohOIxZBVi4UsZprBn+a7RbM2rXhgTU6+G8WVhnLO4NTxnGEapXDXfKlDHFxgDkbx9CR8fHCiDSfLVAdB97Y5uCwQpvtSQuMGQAR3mj5iueUupK1e4+o+zrpfpuZ9Sl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837594; c=relaxed/simple;
	bh=s6oYdJS+5EH5AJT+o97s5q+mADLvek6Z0FNRezWrKEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BGZgMAb1Svl6UAOJiqZDOe2W/kP2aHw+GDewK+NWfZXjPALFfKTZ2Vv4UIuYWgit91U0h/DuhFZ8ypuBggXLf4IzPgmnwsyelD9jQrghIlNCnPOwS34nSXbPIVRA6fMywf7sL9hRUjaUFm3EYjSWq/tVwh5vgZxXscJ0F/y40eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmvRpT3s; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773837593; x=1805373593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s6oYdJS+5EH5AJT+o97s5q+mADLvek6Z0FNRezWrKEs=;
  b=dmvRpT3sPmclF1L6xiDsijm4dGMhb2ch5Tvp3Z2RdriFqxjp/wlWswXv
   k1bi4SvAXW7U3KrRkDOTX7n/IGdCwsLZTVnd8bEnixrEDMdGMBHiWqMqH
   PdNlUhZHsEP8+QS0OlGwMah72YPu7Ml0+XjYz6PNoCKY0407tlCSQC+cN
   5DME8rVPhp7AksZxPRSG12TY3iuHPcqkmqOd5sIIjSWf3Vhsc7zSW/VnR
   Y9eQcHeXkADQk5zbAayio1FZveU6qzaSXGAawVWYhYK0wDSkRxgPBjLlK
   ZbawXoNk7RXQsxR5w3IY1uV3B8G7OFbj1UpWsBQ77bS9wl2JEUuYLYmHc
   g==;
X-CSE-ConnectionGUID: itJ/VOLdTZOdgT/+rI7oOw==
X-CSE-MsgGUID: 01NiuVzURzC7+lz+wmm2Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85519288"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85519288"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:53 -0700
X-CSE-ConnectionGUID: t95FiCmITjGAD6jo6IIH7Q==
X-CSE-MsgGUID: SwO0m+jHRaelVtU6ECwJrw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v5 wireless-next 12/12] wifi: cfg80211: allow protected action frame TX for NAN
Date: Wed, 18 Mar 2026 14:39:26 +0200
Message-Id: <20260318143604.73801a92180c.I16000c3e1e2bbc320457db1ac728d789bb2f36c6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
References: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33395-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: A45F72BBBE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avraham Stern <avraham.stern@intel.com>

Allow transmitting protected dual of public action frames on
NAN device and NAN data interfaces, since NAN action frames
may be protected and can be sent on both.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/mlme.c    | 9 +++++++--
 net/wireless/nl80211.c | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index e817ee297df0..bd72317c4964 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2009, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2015		Intel Deutschland GmbH
- * Copyright (C) 2019-2020, 2022-2025 Intel Corporation
+ * Copyright (C) 2019-2020, 2022-2026 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -933,12 +933,17 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			 * cfg80211 doesn't track the stations
 			 */
 			break;
+		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_NAN_DATA:
+			if (mgmt->u.action.category !=
+			    WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION)
+				err = -EOPNOTSUPP;
+			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 			/*
 			 * fall through, P2P device only supports
 			 * public action frames
 			 */
-		case NL80211_IFTYPE_NAN:
 		default:
 			err = -EOPNOTSUPP;
 			break;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0c4d6e8b45b2..9e7f02d1c7ef 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14207,6 +14207,7 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_P2P_DEVICE:
 		break;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		if (!wiphy_ext_feature_isset(wdev->wiphy,
 					     NL80211_EXT_FEATURE_SECURE_NAN) &&
 		    !(wdev->wiphy->nan_capa.flags &
@@ -14270,6 +14271,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_P2P_GO:
 		break;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		if (!wiphy_ext_feature_isset(wdev->wiphy,
 					     NL80211_EXT_FEATURE_SECURE_NAN) &&
 		    !(wdev->wiphy->nan_capa.flags &
-- 
2.34.1



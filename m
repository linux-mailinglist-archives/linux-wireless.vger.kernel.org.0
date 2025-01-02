Return-Path: <linux-wireless+bounces-16991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A60879FFA66
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D501883751
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8711B4F3F;
	Thu,  2 Jan 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFEDoUa3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2B1799B
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827645; cv=none; b=ap6dtPAkDTz0SQfSs4yNXvMh5ELcfeDBWwhrrKtJwKX3QUK+6gChlR7flHnAML4yXnZIuWI5Ib5j/5rgG+Zs21KJIrNKwH4c2vXMIhuMjMApLL/YUKwUTFrqHRPoo3Ij22g72oFKeeAzHuctLImHwiZpJxzlafwD2XpI/NFNJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827645; c=relaxed/simple;
	bh=X3ZuXp0PSMf9YH+GoKHDmAf0KnIU6Zs97ZI3kEoz4kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSMGr5KJDj2XBREXFR66u9lMPjKbE9QlglJuF4dxG3EoTpUjgvb0lpYwbjG5koHijXDl/PwFNbWzQm88cZxeNlM/yBdgLciJBWvpurFkcE9W77MB26SxTe0lHKGjbJ3AFkig9SK6O0TgVe4hGXst2Z5LowO2wCOKR5z6d3oLXXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFEDoUa3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827643; x=1767363643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3ZuXp0PSMf9YH+GoKHDmAf0KnIU6Zs97ZI3kEoz4kU=;
  b=kFEDoUa39iOm28HGJQYO2ogcrIcJU0yhJqFL3Y3TCoHZQP3Ff4VF2USs
   jPuCCCxxq0DUIzSNY0YzaVGChTlPvRx6OFgWR/Ok+hYV6vUp3qLUg39AR
   X74Vl6Nf61lUfBCNzTpZjvLrWOztrORINlj17woVRf5iQNpWZoRAfVpZi
   xpQYNuh9TaR+0e7yyCk5U8my6AwsBaJVdtlg/coYbxR0Yyq80rlTNfQGw
   o4ShjOzRryEa1y6Esl2qKiFZHfWBD/6b2xqfEx1Gan8AiLjvrzuL8Biv0
   +5nzB2gqvwAyXe2a48YVUVEQ4i7W+bvIC5N/aFdr8duI87aLOq4RBDZoB
   Q==;
X-CSE-ConnectionGUID: 18UYuOPlRZ2eKZ7hf+c87w==
X-CSE-MsgGUID: f6SyHmfGRhWQEX8+qFzk3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735125"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735125"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:43 -0800
X-CSE-ConnectionGUID: Gm/y4wOyRLaLmusEygD1Wg==
X-CSE-MsgGUID: E/MFT5OzRa+b2II3UF+Fhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357428"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 13/17] wifi: mac80211: set key link ID to the deflink one
Date: Thu,  2 Jan 2025 16:20:05 +0200
Message-Id: <20250102161730.0c066f084677.I4a5c288465e75119edb6a0df90dddf6f30d14a02@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When in non-MLO mode, the key ID was set to -1 even for keys that are
not pairwise. Change the link ID to be the link ID of the deflink in
this case so that drivers do not need to special cases for this.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h |  2 +-
 net/mac80211/cfg.c     | 11 ++++++++---
 net/mac80211/key.c     |  2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 34382d014c8b..92e18419f061 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2225,7 +2225,7 @@ enum ieee80211_key_flags {
  * 	- Temporal Authenticator Rx MIC Key (64 bits)
  * @icv_len: The ICV length for this key type
  * @iv_len: The IV length for this key type
- * @link_id: the link ID for MLO, or -1 for non-MLO or pairwise keys
+ * @link_id: the link ID, 0 for non-MLO, or -1 for pairwise keys
  */
 struct ieee80211_key_conf {
 	atomic64_t tx_pn;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 1a912cb8ae8d..6199b5f6035c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -503,6 +503,9 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	if (IS_ERR(link))
 		return PTR_ERR(link);
 
+	if (WARN_ON(pairwise && link_id >= 0))
+		return -EINVAL;
+
 	if (pairwise && params->mode == NL80211_KEY_SET_TX)
 		return ieee80211_set_tx(sdata, mac_addr, key_idx);
 
@@ -525,10 +528,12 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
-	key->conf.link_id = link_id;
-
-	if (pairwise)
+	if (pairwise) {
 		key->conf.flags |= IEEE80211_KEY_FLAG_PAIRWISE;
+		key->conf.link_id = -1;
+	} else {
+		key->conf.link_id = link->link_id;
+	}
 
 	if (params->mode == NL80211_KEY_NO_TX)
 		key->conf.flags |= IEEE80211_KEY_FLAG_NO_AUTO_TX;
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 67ecfea22982..dcf8643a0baa 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -1409,7 +1409,7 @@ ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
 	if (sdata->u.mgd.mfp != IEEE80211_MFP_DISABLED)
 		key->conf.flags |= IEEE80211_KEY_FLAG_RX_MGMT;
 
-	key->conf.link_id = link_id;
+	key->conf.link_id = link_data->link_id;
 
 	err = ieee80211_key_link(key, link_data, NULL);
 	if (err)
-- 
2.34.1



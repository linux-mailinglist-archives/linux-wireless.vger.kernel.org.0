Return-Path: <linux-wireless+bounces-13587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E81B992AEC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FDAB23CAB
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB901D26E0;
	Mon,  7 Oct 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcrirI3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448D18B483
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302477; cv=none; b=jxpY4wGZFrth8hdPoDHAVLw44en1ajWnLa87NlfmO89byAqzi3YHvCg+mu6dkSa51pr8hxRiB31gpXaNKBwFmbzBgvhAZ85OlYGINpZfimfJADiCxNVWaE60twOKsN8XotvLDvSyQKHAE7Mk91EEJqZ90YX3djx42KFgwItzxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302477; c=relaxed/simple;
	bh=z8fhY9s4+wMsKs8l7kO4ngasxocXRbHgKO+pZTcIz48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7RJpa1ZOy3v+FyTqX2UF8w/LHndxXAnHyB0qEHPiy7BBADNttotnLXc49w51YRAx/8qCFX7Slyt2HL8KZPg2lDDhy9a639pMoV+cZP/Nf5e1Ga/5rhzvRH9t57FI2xicLGOO7yf4etH6GMGrkhIo7qTnuzUh6GJBgSWYy2HycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcrirI3D; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302475; x=1759838475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z8fhY9s4+wMsKs8l7kO4ngasxocXRbHgKO+pZTcIz48=;
  b=FcrirI3Dh4CtSahx5SG6p2MeyPGouuIg9oNxjy8nqqw6TAob8wqD+Eu+
   z1M6p1QWu1hQis8C+4GHjxwPRWZNVWPHFAyDfRmxCi5Kxb5/rvi76LSjr
   +5UcfIuCAmtmKix8W3c2tHLnOCM8KR0nnPhDm2Ht3tGSQa8q5mVjwlqTR
   QpJXeHzgbgVdjYyN8PY2KAfXb9K72NtoDeMOH9r/0fRVhkUZ1YLmnbrjs
   j/ITGLsjbVy5NTirrJajjeDp8pQ8YWkp32eVS7jcXWATpE92hYkPiO7AU
   ZhtIOYdV1aD/Sskk8PTQKo+l5I5uwhw4q98cJunqJTUG41jIg3AhtJu+I
   g==;
X-CSE-ConnectionGUID: MiXXJLFcQCePa3xX77+MRw==
X-CSE-MsgGUID: K+i+cM4OR120ZS+O0pTP+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099373"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099373"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:15 -0700
X-CSE-ConnectionGUID: 6VRhbvJ2TASDxG1jGQmw8Q==
X-CSE-MsgGUID: 7102S+S6QZel9zRfQw/LQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019236"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/14] wifi: cfg80211: disallow SMPS in AP mode
Date: Mon,  7 Oct 2024 15:00:46 +0300
Message-Id: <20241007144851.fe1fc46484cf.I8676fb52b818a4bedeb9c25b901e1396277ffc0b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In practice, userspace hasn't been able to set this for many
years, and mac80211 has already rejected it (which is now no
longer needed), so reject SMPS mode (other than "OFF" to be
a bit more compatible) in AP mode. Also remove the parameter
from the AP settings struct.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/quantenna/qtnfmac/commands.c |  2 +-
 include/net/cfg80211.h                        |  2 --
 net/mac80211/cfg.c                            |  3 --
 net/wireless/nl80211.c                        | 30 ++-----------------
 4 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index 9540ad6196d7..956c5763662f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -257,7 +257,7 @@ int qtnf_cmd_send_start_ap(struct qtnf_vif *vif,
 	cmd->beacon_interval = cpu_to_le16(s->beacon_interval);
 	cmd->hidden_ssid = qlink_hidden_ssid_nl2q(s->hidden_ssid);
 	cmd->inactivity_timeout = cpu_to_le16(s->inactivity_timeout);
-	cmd->smps_mode = s->smps_mode;
+	cmd->smps_mode = NL80211_SMPS_OFF;
 	cmd->p2p_ctwindow = s->p2p_ctwindow;
 	cmd->p2p_opp_ps = s->p2p_opp_ps;
 	cmd->pbss = s->pbss;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 69ec1eb41a09..c8ce5c2e14f4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1460,7 +1460,6 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @crypto: crypto settings
  * @privacy: the BSS uses privacy
  * @auth_type: Authentication type (algorithm)
- * @smps_mode: SMPS mode
  * @inactivity_timeout: time in seconds to determine station's inactivity.
  * @p2p_ctwindow: P2P CT Window
  * @p2p_opp_ps: P2P opportunistic PS
@@ -1498,7 +1497,6 @@ struct cfg80211_ap_settings {
 	struct cfg80211_crypto_settings crypto;
 	bool privacy;
 	enum nl80211_auth_type auth_type;
-	enum nl80211_smps_mode smps_mode;
 	int inactivity_timeout;
 	u8 p2p_ctwindow;
 	bool p2p_opp_ps;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ce9558cd1576..548b9bbdac04 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1312,9 +1312,6 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (old)
 		return -EALREADY;
 
-	if (params->smps_mode != NL80211_SMPS_OFF)
-		return -EOPNOTSUPP;
-
 	link->smps_mode = IEEE80211_SMPS_OFF;
 
 	link->needed_rx_chains = sdata->local->rx_chains;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9ab777e0bd4d..3a434f4654ab 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6227,33 +6227,9 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
-	if (info->attrs[NL80211_ATTR_SMPS_MODE]) {
-		params->smps_mode =
-			nla_get_u8(info->attrs[NL80211_ATTR_SMPS_MODE]);
-		switch (params->smps_mode) {
-		case NL80211_SMPS_OFF:
-			break;
-		case NL80211_SMPS_STATIC:
-			if (!(rdev->wiphy.features &
-			      NL80211_FEATURE_STATIC_SMPS)) {
-				err = -EINVAL;
-				goto out;
-			}
-			break;
-		case NL80211_SMPS_DYNAMIC:
-			if (!(rdev->wiphy.features &
-			      NL80211_FEATURE_DYNAMIC_SMPS)) {
-				err = -EINVAL;
-				goto out;
-			}
-			break;
-		default:
-			err = -EINVAL;
-			goto out;
-		}
-	} else {
-		params->smps_mode = NL80211_SMPS_OFF;
-	}
+	if (info->attrs[NL80211_ATTR_SMPS_MODE] &&
+	    nla_get_u8(info->attrs[NL80211_ATTR_SMPS_MODE]) != NL80211_SMPS_OFF)
+		return -EOPNOTSUPP;
 
 	params->pbss = nla_get_flag(info->attrs[NL80211_ATTR_PBSS]);
 	if (params->pbss && !rdev->wiphy.bands[NL80211_BAND_60GHZ]) {
-- 
2.34.1



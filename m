Return-Path: <linux-wireless+bounces-30933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE68D3932D
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 08:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48C9A3004EE3
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1115650096A;
	Sun, 18 Jan 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXYuaUyO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EFA13C8EA
	for <linux-wireless@vger.kernel.org>; Sun, 18 Jan 2026 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768722690; cv=none; b=fkp1VF/MJLJDCy9Htyyejlpg1Cga+5ST6hkFuJXuzr8UNhfUKa1T19jEB2/c67NzhbMyrC07vvTD5csji6L4SVfKKRuq58HbFMGCD42IbQtBDbwr2P3fFhWOKysHHQ84fJ9yKU3LQIxi5txrfBld5zZ1TsEuvE5rswfF4wg2jr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768722690; c=relaxed/simple;
	bh=Wzh9vxLBl9umDMCKY+G2mP7Xj/548EJ8gG7fmw8Qg6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LEFhuBHf/lfCkCN1SDtOkPytrttLcyn3k1b6iB8Jdb9Dsu9SNU8Lrv4iEHqy1C0aSx7i+brxdXD7UYNAqq5dJ63tGz/Ngd7CfzDNRUYHsGTdjje1EujUEeUX1qbh3eoXrqLW1bCKvrJ4zhIS5iNhQveljN012AwMVFzCAqFs6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXYuaUyO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768722688; x=1800258688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wzh9vxLBl9umDMCKY+G2mP7Xj/548EJ8gG7fmw8Qg6w=;
  b=JXYuaUyOjOgLrNbq14MtGzX8qKFUyLQGVtKesReDmytf+WTtHc6VPatj
   mGLhRLhgqECGbF07VYMFcjVteNKUpNhn7kTfEUCod7/5bJb2nAFnh2m5l
   gG9N8UdbydFpq0gHzpcwYBC0yX7f5i9g2iz2HlMar76R5DzIvR13u0DLE
   MFVfnMD0s7dCquaLNDtB0lm9seBRwTNqVkeF8JvElCUKHiKoA66iGY5tO
   WBoA0XJvqrG6e1xg4SOOUXMpDrR0VBNHoMRUqwh5+lZ3AyDgjJSnoPeWp
   CPtMz8Hlr9Q6p11NOa8/KXz6Mf2QyO4VqeF3eu0chBI8T7MaEl3nJv7Lb
   A==;
X-CSE-ConnectionGUID: SKQBDhF0T06OeSfwjJqFRQ==
X-CSE-MsgGUID: fd7Vxj9yRWqoajt/mZ01YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="87546808"
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="87546808"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:51:27 -0800
X-CSE-ConnectionGUID: FVvv4OP+SJmfw2EYI/vlBA==
X-CSE-MsgGUID: dQA3SQ8IQ6akVGw+t3iEhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="236278496"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2026 23:51:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi 1/3] wifi: mac80211: parse all TTLM entries
Date: Sun, 18 Jan 2026 09:51:13 +0200
Message-Id: <20260118093904.ccd324e2dd59.I69f0bee0a22e9b11bb95beef313e305dab17c051@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118075115.808517-1-miriam.rachel.korenblit@intel.com>
References: <20260118075115.808517-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

For the follow up patch, we need to properly parse TTLM entries that do
not have a switch time. Change the logic so that ieee80211_parse_adv_t2l
returns usable values in all non-error cases. Before the values filled
in were technically incorrect but enough for ieee80211_process_adv_ttlm.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ad53dedd929c..3f6bbe4e0175 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7015,10 +7015,6 @@ ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
 	pos = (void *)ttlm->optional;
 	control	= ttlm->control;
 
-	if ((control & IEEE80211_TTLM_CONTROL_DEF_LINK_MAP) ||
-	    !(control & IEEE80211_TTLM_CONTROL_SWITCH_TIME_PRESENT))
-		return 0;
-
 	if ((control & IEEE80211_TTLM_CONTROL_DIRECTION) !=
 	    IEEE80211_TTLM_DIRECTION_BOTH) {
 		sdata_info(sdata, "Invalid advertised T2L map direction\n");
@@ -7028,21 +7024,28 @@ ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
 	link_map_presence = *pos;
 	pos++;
 
-	ttlm_info->switch_time = get_unaligned_le16(pos);
+	if (control & IEEE80211_TTLM_CONTROL_SWITCH_TIME_PRESENT) {
+		ttlm_info->switch_time = get_unaligned_le16(pos);
 
-	/* Since ttlm_info->switch_time == 0 means no switch time, bump it
-	 * by 1.
-	 */
-	if (!ttlm_info->switch_time)
-		ttlm_info->switch_time = 1;
+		/* Since ttlm_info->switch_time == 0 means no switch time, bump
+		 * it by 1.
+		 */
+		if (!ttlm_info->switch_time)
+			ttlm_info->switch_time = 1;
 
-	pos += 2;
+		pos += 2;
+	}
 
 	if (control & IEEE80211_TTLM_CONTROL_EXPECTED_DUR_PRESENT) {
 		ttlm_info->duration = pos[0] | pos[1] << 8 | pos[2] << 16;
 		pos += 3;
 	}
 
+	if (control & IEEE80211_TTLM_CONTROL_DEF_LINK_MAP) {
+		ttlm_info->map = 0xffff;
+		return 0;
+	}
+
 	if (control & IEEE80211_TTLM_CONTROL_LINK_MAP_SIZE)
 		map_size = 1;
 	else
-- 
2.34.1



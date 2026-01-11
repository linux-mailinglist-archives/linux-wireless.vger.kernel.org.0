Return-Path: <linux-wireless+bounces-30640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DE9D0F22A
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 15:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B1DB300423F
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C4C341AAF;
	Sun, 11 Jan 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/zRahpE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE933D6C7
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142342; cv=none; b=nR+WlBDKrQ/VnvWQAecIIww835RoymWKZL3yRuDPqMH+HYJZnCDcLUFoG16V2yUrZTowquHMrR0rS88uNVYMHzGOxUIgjA1qM1W6v/MhvSUd8cqsIPME+Qu3uesuM+f9wrLcozKZHdN1laKwsyW7hXI/ERZ0Riuz6ObiN+IoOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142342; c=relaxed/simple;
	bh=Wzh9vxLBl9umDMCKY+G2mP7Xj/548EJ8gG7fmw8Qg6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oFeTLRSSL978PG6VBc3UtWdA+2r+QiUDTuYhNT+Q5ADWlcQ/aHxIqFZcH9gxNNlyD8/jMaNJsleCt1lVl0JakPdcjftzw4BWebViyD73KxZxOvwh1GZMhNIWKlt2lQFx4SUJOW36qoaDvgbJSZTpU7Iy9TbzR+A74SzqNvqoDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/zRahpE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768142342; x=1799678342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wzh9vxLBl9umDMCKY+G2mP7Xj/548EJ8gG7fmw8Qg6w=;
  b=U/zRahpEyHneAd7cjpgu1htdyZCoqXkddRiohik4SvlNRbv07VYkB/4a
   FXXMwPonkq2pt+Qc6tpHXbPlcho/dYRSCs405E+M/zDADfddmfSfCSZFg
   f/ORFkglEUwueerX5he5wFKZKYg6rI9vL2k4k/zUmICcFDarqOhT/SgcB
   2ONcKgkEAnjx3DXPrsxxOn6Hcaenpc0NWsylcVy5/ZfuONI6uxqE14c8M
   glNVhUjQQQYJbheRkqdhGhHsyhDZLxKdk6cq+imKFRNRbGNol/9UmmO1T
   ZUsbMBklU4M3ReGyu7IscWDzm9s3HukeRxVhBUxeZbKEWV9PkAv7oMZBv
   w==;
X-CSE-ConnectionGUID: tjSWGpp3R9+huoOWy4cYoA==
X-CSE-MsgGUID: WI24uREjRR2K+1XSByqo5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="86859268"
X-IronPort-AV: E=Sophos;i="6.21,218,1763452800"; 
   d="scan'208";a="86859268"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 06:39:01 -0800
X-CSE-ConnectionGUID: 6LBgDJLpRIKY8h/tOM78Rg==
X-CSE-MsgGUID: EqYdy2+jQZq66YHIyzCfQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,218,1763452800"; 
   d="scan'208";a="203034215"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 06:38:59 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: parse all TTLM entries
Date: Sun, 11 Jan 2026 16:38:50 +0200
Message-Id: <20260111163845.768b9733c553.I69f0bee0a22e9b11bb95beef313e305dab17c051@changeid>
X-Mailer: git-send-email 2.34.1
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



Return-Path: <linux-wireless+bounces-30644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C42D0F7CB
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20DDD3071A17
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317B34C13B;
	Sun, 11 Jan 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+vMi4/1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93F34CFAB
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151052; cv=none; b=jNw4IrYISoHqcV5A6uXrjHbhehefn9L9yT93SkhnDyBHQYaTy+olXNAI1ptDAw9LyX+hsvOz6YV7iYjay7n155GLVyIMLBa+C/Lsig2Ps7Ig0I38sAJU+jrWcPhlgUGZ7RxveghqryS7rfPw6jq+zZtKC8Jt+/r04EHBng+WoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151052; c=relaxed/simple;
	bh=1OOt4VqRpbJ0g84oB9m3jkkYpJ/Hm/RttYrHKFPc0To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWdqvfoXuHOGzir5rp8Du37U+GOm/krZGO2/a2YgVwaRksdDQ02/6E0+22YFjwkgIWZDUSgIwV56Wz/ehRgiCV/QpWGlTLwbR0f2Zkym0DXnk3dnXpzslI1KACp/mmKaihERC2Y+ZCR71G5Abn/g9PruWQkxw5JWb1ZBReUM24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+vMi4/1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768151044; x=1799687044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1OOt4VqRpbJ0g84oB9m3jkkYpJ/Hm/RttYrHKFPc0To=;
  b=e+vMi4/1t3xnGWbD9BsFPlogAdKXncNMQ2ICX8rsyPB9nrCv0Vfo0wiG
   Y0imPjxkoUuRV4ZpFMPqf0IZfCs5UtQA6rCZCng58avyAC0XZlpROW3BU
   m0vTouFOccd63IF1olNA/qGrPndUHZuVcQ6kfAidWAA05ql6rO0iKAucZ
   lVkhqsteo/wjcQatptMwkxkiHVj5/losWmeRCS8BBSftIjBvOvbOSlE/6
   z5hxN9SmFvq3KgCwscD42xRud29g6k+j0eC5C8kDaBQqIl0526Fc4HYk2
   3FagFWVCf+GrSHERykatmFiDBq8DsTTR4LCMf4CCGm4R2GIvn9GYfWaMh
   Q==;
X-CSE-ConnectionGUID: mEOIsZuWTM+miUazAv9jhw==
X-CSE-MsgGUID: NBPZodf1Qj+AvhmxyuI6+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68650779"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68650779"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:04:04 -0800
X-CSE-ConnectionGUID: VN/Zf6UsSGqKNRR58wZ+qQ==
X-CSE-MsgGUID: qyCDrBrIRiK7Es0iiOvzQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208433289"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:04:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/4] wifi: nl80211/cfg80211: clarify periodic FTM parameters for non-EDCA based ranging
Date: Sun, 11 Jan 2026 19:03:49 +0200
Message-Id: <20260111190221.b89cb3f68e1a.I7a9d8c6d1c66c77f1b43120a841101c96c3f19ad@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111170351.2093318-1-miriam.rachel.korenblit@intel.com>
References: <20260111170351.2093318-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Periodic FTM request attributes are defined based on the periodic
parameters used in EDCA-based ranging negotiation. However, non-EDCA
based ranging (trigger-based/non-trigger-based) does not include
periodic parameters in the negotiation protocol, even though upper
layers may still request periodic measurements.

Clarify the semantics of periodic ranging attributes when used with
non-EDCA based ranging.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       |  4 +++-
 include/uapi/linux/nl80211.h |  7 +++++--
 net/wireless/pmsr.c          | 11 ++++++-----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9c80ee0c0357..614ffc4969f0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4293,7 +4293,9 @@ struct cfg80211_pmsr_result {
  * @burst_period: burst period to use
  * @asap: indicates to use ASAP mode
  * @num_bursts_exp: number of bursts exponent
- * @burst_duration: burst duration
+ * @burst_duration: burst duration. If @trigger_based or @non_trigger_based is
+ *	set, this is the burst duration in milliseconds, and zero means the
+ *	device should pick an appropriate value based on @ftms_per_burst.
  * @ftms_per_burst: number of FTMs per burst
  * @ftmr_retries: number of retries for FTM request
  * @request_lci: request LCI information
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 34dc047a172f..7b5463168324 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7827,12 +7827,15 @@ enum nl80211_peer_measurement_ftm_capa {
  *	&enum nl80211_preamble), optional for DMG (u32)
  * @NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP: number of bursts exponent as in
  *	802.11-2016 9.4.2.168 "Fine Timing Measurement Parameters element"
- *	(u8, 0-15, optional with default 15 i.e. "no preference")
+ *	(u8, 0-15, optional with default 15 i.e. "no preference". No limit for
+ *	 non-EDCA ranging)
  * @NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD: interval between bursts in units
  *	of 100ms (u16, optional with default 0)
  * @NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION: burst duration, as in 802.11-2016
  *	Table 9-257 "Burst Duration field encoding" (u8, 0-15, optional with
- *	default 15 i.e. "no preference")
+ *	default 15 i.e. "no preference"). For non-EDCA ranging, this is the
+ *	burst duration in milliseconds (optional with default 0, i.e. let the
+ *	device decide).
  * @NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST: number of successful FTM frames
  *	requested per burst
  *	(u8, 0-31, optional with default 0 i.e. "no preference")
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index a117f5093ca2..795683a81303 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -85,11 +85,6 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
-	out->ftm.burst_duration = 15;
-	if (tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION])
-		out->ftm.burst_duration =
-			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION]);
-
 	out->ftm.ftms_per_burst = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST])
 		out->ftm.ftms_per_burst =
@@ -164,6 +159,12 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION])
+		out->ftm.burst_duration =
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION]);
+	else if (!out->ftm.non_trigger_based && !out->ftm.trigger_based)
+		out->ftm.burst_duration = 15;
+
 	out->ftm.lmr_feedback =
 		!!tb[NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK];
 	if (!out->ftm.trigger_based && !out->ftm.non_trigger_based &&
-- 
2.34.1



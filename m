Return-Path: <linux-wireless+bounces-30643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1383CD0F7BC
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78D163036C6E
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AFD500963;
	Sun, 11 Jan 2026 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4g9hCn5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88A34CFDD
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151052; cv=none; b=t/KFgzOq9gDwtrsrVYXjeLaBHm5Ii6lVVai1flIozYtgqNiUtis7uEVwe5S5u6RQcncRrK/jVZaRQ2RK9BbDuhPbv6vAI0f0+3clnfMIro4f+zwDWGCA0VuhvklpxPrUcSVvdEWJDMBtEi3gO/bS/H45hLQDhOJmsm1GYtaQKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151052; c=relaxed/simple;
	bh=KTnJVo2NM0lZ1opbMmLovTKnbRRA3C8Eud8jHXAmkJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BisRJo5n9z6eHvq043lXHypB5fvalBVMlIhsW2VDLstEOVoRzQGt6T0nBOZ0c7xt9svf/h3RXxxXeANgsRlsb6ozj0bhGR1fxqL8NMcprYTYpfN8Za0Gi2RdgKebWOT/J+cM9ySU/neJalsHIj71ha1/Ked8zZVgKGIJ8c3qoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4g9hCn5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768151045; x=1799687045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KTnJVo2NM0lZ1opbMmLovTKnbRRA3C8Eud8jHXAmkJ4=;
  b=m4g9hCn5r6zfBnR3cz+4ylGeobUAeHLEY4Tv/9qkHg43r+Sxj/0M/udT
   HOmnTioCVayHQUeE9FnvyM88yg4q1VIR3o503aJgtZAmAyMyUdsHbhh5k
   oCuyjkvZSUdYp1z6MqXfFGX4/derfL9ge9sxSJHMeLbIqF4ZmpuAhxAJq
   JA+AegbMCLGNzGReiOSgrP//JQvAe4iB49cMzxOiPgzbMquSIEA71sDSD
   Io6+XKdLscnPF7uRix1uaR31S+WXFfW5veTGR2UFYTNuyIGON6abYve4j
   zoullqZolFR6QXD1BVMnYsz/JjPyTeep4OAVRfD+cski3gi5ByUiQM1vE
   w==;
X-CSE-ConnectionGUID: x5KUtOk4QJO/5wCeML+jWA==
X-CSE-MsgGUID: ZgomSat8QoGeL1Cy3d2PSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68650781"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68650781"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:04:05 -0800
X-CSE-ConnectionGUID: TL3iPgtERyO3iAihn4Fp9Q==
X-CSE-MsgGUID: HFSSaGucRS6VgSR3hpesTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208433295"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:04:04 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 3/4] wifi: nl80211/cfg80211: add negotiated burst period to FTM result
Date: Sun, 11 Jan 2026 19:03:50 +0200
Message-Id: <20260111190221.e0778f86edef.I3c98c1933eb639963bc3ffdef81a8788b59f2188@changeid>
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

The FTM result includes some of the periodic measurement negotiated
parameters (like the burst duration and number of bursts), but it
doesn't include the burst period. Add it to the FTM result
notification.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 3 +++
 net/wireless/pmsr.c          | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 614ffc4969f0..f6ac7af030dc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4190,6 +4190,7 @@ struct cfg80211_ftm_responder_stats {
  * @num_bursts_exp: actual number of bursts exponent negotiated
  * @burst_duration: actual burst duration negotiated
  * @ftms_per_burst: actual FTMs per burst negotiated
+ * @burst_period: actual burst period negotiated in units of 100ms
  * @lci_len: length of LCI information (if present)
  * @civicloc_len: length of civic location information (if present)
  * @lci: LCI data (may be %NULL)
@@ -4231,6 +4232,7 @@ struct cfg80211_pmsr_ftm_result {
 	u8 num_bursts_exp;
 	u8 burst_duration;
 	u8 ftms_per_burst;
+	u16 burst_period;
 	s32 rssi_avg;
 	s32 rssi_spread;
 	struct rate_info tx_rate, rx_rate;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 7b5463168324..44e3468cc985 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7968,6 +7968,8 @@ enum nl80211_peer_measurement_ftm_failure_reasons {
  *	9.4.2.22.1) starting with the Measurement Token, with Measurement
  *	Type 11.
  * @NL80211_PMSR_FTM_RESP_ATTR_PAD: ignore, for u64/s64 padding only
+ * @NL80211_PMSR_FTM_RESP_ATTR_BURST_PERIOD: actual burst period used by
+ *	the responder (similar to request, u16)
  *
  * @NUM_NL80211_PMSR_FTM_RESP_ATTR: internal
  * @NL80211_PMSR_FTM_RESP_ATTR_MAX: highest attribute number
@@ -7996,6 +7998,7 @@ enum nl80211_peer_measurement_ftm_resp {
 	NL80211_PMSR_FTM_RESP_ATTR_LCI,
 	NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC,
 	NL80211_PMSR_FTM_RESP_ATTR_PAD,
+	NL80211_PMSR_FTM_RESP_ATTR_BURST_PERIOD,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_RESP_ATTR,
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 795683a81303..d5077d320098 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -454,6 +454,7 @@ static int nl80211_pmsr_send_ftm_res(struct sk_buff *msg,
 	PUT(u8, NUM_BURSTS_EXP, num_bursts_exp);
 	PUT(u8, BURST_DURATION, burst_duration);
 	PUT(u8, FTMS_PER_BURST, ftms_per_burst);
+	PUT(u16, BURST_PERIOD, burst_period);
 	PUTOPT(s32, RSSI_AVG, rssi_avg);
 	PUTOPT(s32, RSSI_SPREAD, rssi_spread);
 	if (res->ftm.tx_rate_valid &&
-- 
2.34.1



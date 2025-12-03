Return-Path: <linux-wireless+bounces-29466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6569C9E97E
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 10:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42446345F0F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622CC2DFA25;
	Wed,  3 Dec 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBtgHhYZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55877299AB3
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755586; cv=none; b=lrQhK1ASFCOyiUJcbCumE6VUxTIE9SEwXpXrrOh3JKqzh1LLHse6u53icgmRpPxhsFi03S8DQaB0rOot+90vAlbjexAES8s3LId7B65zDHClscoudmKtulHy7jhbxf5CFS4YuYQwPe/lauTO8Yg4VKyYHriJ09XCCAPZ74FDvm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755586; c=relaxed/simple;
	bh=BRCV1m9v7Dz4x7fwRcXCU5C3vwatwtCb2yp8nc8/sUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Do2eooUpD6CmC105kh8QUYVqg3hUou6YG5b4fqKKdO+x4SP+MXvijZwXuP4+Uc65JGBOjZVEMNIJJFFVPoSisxVhwrGgTKvmAYgk7JCuA5tGbW6poWe4SP+zNbZiyVaWmhxk7qcPRGluTJhZz0KYArwWGdegeSiMr+Ipq+en3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBtgHhYZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764755585; x=1796291585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BRCV1m9v7Dz4x7fwRcXCU5C3vwatwtCb2yp8nc8/sUU=;
  b=DBtgHhYZQq0ohetUBV1ITX5HbOznlcwaS6z5bG9eSH7K6WAN8SzsqTp5
   Rn89EYLuURoy3gzJOIxzbT1ru45a2kI0Z33DiRaWFAJAwxt7B48r2waQs
   yp4WwGwzKELXWuvyazsnRRHi4Ge5cSnAYLCPSYpzVadPM5am6LWhH9ejF
   DWoQGi8UI3kwaUYG9Wzrw1G+/EXy9ZY/kghm9iGIW9fWRXmOBuVuce5Iz
   pwSMKbZWgV82SvoJldRPa0nguDt3lDZqEhIvkLMIX0etEo4Nr9naWhpmI
   MneDyjSz9Pr4+T09QKZlFDVFK0EtmdWooW1sBQ7fcbSSxYldryxgvU6QM
   w==;
X-CSE-ConnectionGUID: W6xbR4tcQQeaNj8rw3jLaA==
X-CSE-MsgGUID: nBX4xNtfTpKhJbLGTBb2+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65931523"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="65931523"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:53:03 -0800
X-CSE-ConnectionGUID: Yh9EuyE/TPCVe57agrA6LQ==
X-CSE-MsgGUID: 6XPmdtI5Q/m//iiXwnpAyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="193916145"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:53:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 2/4] wifi: nl80211/cfg80211: clarify periodic FTM parameters for non-EDCA based ranging
Date: Wed,  3 Dec 2025 11:52:36 +0200
Message-Id: <20251203115155.89659d82d678.I7a9d8c6d1c66c77f1b43120a841101c96c3f19ad@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203095238.3121859-1-miriam.rachel.korenblit@intel.com>
References: <20251203095238.3121859-1-miriam.rachel.korenblit@intel.com>
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
index 50a1737e3382..82e453c764c9 100644
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



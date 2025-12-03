Return-Path: <linux-wireless+bounces-29469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F08C9E987
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74EE24E1306
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BAD2E11C7;
	Wed,  3 Dec 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQu1vmtO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49A2E0415
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755588; cv=none; b=JRJAssvjspakBs03p8ol2QROs0TkwUttUN4lArJwjcEz4YHIwHBBKyTVr9KgYZm+Pd9js1rECWG8kG5ab3eoOOn/WEAS1XWMprJEHUd1vl597m/dMdTxe0kV4eT6gRzgKO/ldUPLYnmlOxLiY3r5FIHgdJXuMTxQPTIkRubdJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755588; c=relaxed/simple;
	bh=RMy4h+hWj9nWPpBMR77X3BZJ/PqZzdCCAKvlWaJN+d0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FwbPb+hZUv9cH8CoN1Mt6rSmFI5DFbWBUHo0ouerSXcH28K17MeaV6JXOB29bQgTSkrYJ04Fi8LwYXkd0kr+7Ck3Ms9e1lD1+XMY/yb8ukeAojGBI5Qlx7a9KBoVqYShScSrRqpClga/H9ZAlrvupXzLxtxdsfU1i86EFiBgyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQu1vmtO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764755586; x=1796291586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RMy4h+hWj9nWPpBMR77X3BZJ/PqZzdCCAKvlWaJN+d0=;
  b=nQu1vmtO3f+qTZ8dwkDu9K6NZGSGJ5n/X2cUMhlsnyQtSd9F1pVdzymW
   1Y4CCxwbfzt5w0FVbfyISiyAIsRpa3hqViKBJaHsYqoGhJw3ArdaTYUmZ
   ikWH68/yEciZpOe4DwtUQfGuVALQKCtuQstnhdSNKWhnH8TMMdrDQcgzf
   N6/e/jnImeReiRoiMCOfQ16WaO5AkmOSfR2rzBvQG4VwFNqRL0OhMlNfo
   cwUo9RwOuGoTnOaokdRUWyZzA9Ox98rNw8upnoNEAWJmM6sRk0PEKCktm
   A2QqI8ArOoJyxOnnm9k+wk+//C4hN6IcYaP5Q7mqHdWQoh5R4YS0snsEP
   g==;
X-CSE-ConnectionGUID: r7GmBLgrRHODFxqUuIXa1w==
X-CSE-MsgGUID: EQce/731SgGuPSG64WU2FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65931526"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="65931526"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:53:05 -0800
X-CSE-ConnectionGUID: HQl/RQERQiGXp3ZgtCccAQ==
X-CSE-MsgGUID: +EnsLEO+RQG8I9yxf5aDFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="193916151"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:53:04 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 3/4] wifi: nl80211/cfg80211: add negotiated burst period to FTM result
Date: Wed,  3 Dec 2025 11:52:37 +0200
Message-Id: <20251203115155.4ce8474e0a87.I3c98c1933eb639963bc3ffdef81a8788b59f2188@changeid>
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
index 82e453c764c9..ddc579b5179c 100644
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



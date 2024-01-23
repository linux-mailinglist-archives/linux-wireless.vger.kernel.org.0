Return-Path: <linux-wireless+bounces-2404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFEE83974F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46801F2CE8D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996EC8121C;
	Tue, 23 Jan 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jXN6X2zv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF081AC1
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033349; cv=none; b=flPLI0Cv9a3U9hCzBU20CZhJxmWCbTyftuEh7FTtZ/dGhlp8k9iv7HwEBRZK4q81m+TLmKLBPiLog/OlT6IfUKPGGgY4zgCNdPABSB3gzOiVyEK5LAgfBxvYOkvAHsC8f9hK34mvfc7EPz77IFN3JTGNg3AcJ7Rz/uXjykA4q4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033349; c=relaxed/simple;
	bh=7cTcf1wP2mkoIhaY8pt4N9WJc5u+7RoY+n6lY558ovw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fipoF0F7Q2b1ADD4s+0Yfydn8bfMZba4wfppC86pspvOHs35g8kNJHVF0amzM4v5jTNZ1SxxC01s5EqOhaEmXyFma8wF0gbI0/DZ9F5jq0r8dr/OawecALQe1b0wSE6C+SGaNkkGC5fWeE3SbK5FSWuawYymugqsPfZNfezgN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jXN6X2zv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033348; x=1737569348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7cTcf1wP2mkoIhaY8pt4N9WJc5u+7RoY+n6lY558ovw=;
  b=jXN6X2zv/sKii4rCx0rtrYiWfStbj9G9ejhD47kq8YwrM5rnrXEn8FJI
   evbM7nmCsHrbX9rjHGIIuohkELn8y+wp58mX4Irt9OEpwSvUPPUEo41kB
   VAfeJaNhL7pwCXWR7iNvhdrRQrIqTy79xFJifWeHGKsydwDg95C8Jp6bB
   0Si+ELQddY9xdBOaXZtf4wefLNLDuO7SmUQXHeSTn0kC//bhL4PtkaU/R
   DEOSVvbA3+LjdasBODv/IqzVzS7Rk+HLyW1hHHAHzBLr9hVv+OhILOEhZ
   25mGmk8F2toVizWEnCpZLVQPROPAVPzwJsQY/m9rcPq3s+Rua60zpwvNT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501871"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501871"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666573"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: nvm-parse: advertise common packet padding
Date: Tue, 23 Jan 2024 20:08:17 +0200
Message-Id: <20240123200528.4312e176dfdc.Ide75980ff57257a31e86e6ac5948a8f97aaab577@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We should - at least for now - advertise common nominal packet
padding of 16µs instead of the more specific PPE thresholds.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 8e6ce484db87..a7152d65eefa 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -696,10 +696,11 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 					IEEE80211_EHT_PHY_CAP4_POWER_BOOST_FACT_SUPP |
 					IEEE80211_EHT_PHY_CAP4_EHT_MU_PPDU_4_EHT_LTF_08_GI,
 				.phy_cap_info[5] =
+					FIELD_PREP_CONST(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK,
+							 IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US) |
 					IEEE80211_EHT_PHY_CAP5_NON_TRIG_CQI_FEEDBACK |
 					IEEE80211_EHT_PHY_CAP5_TX_LESS_242_TONE_RU_SUPP |
-					IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP |
-					IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT,
+					IEEE80211_EHT_PHY_CAP5_RX_LESS_242_TONE_RU_SUPP,
 				.phy_cap_info[6] =
 					IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK |
 					IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP,
@@ -733,6 +734,9 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			/*
 			 * PPE thresholds for NSS = 2, and RU index bitmap set
 			 * to 0xc.
+			 * Note: just for stating what we want, not present in
+			 * the transmitted data due to not including
+			 * IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT.
 			 */
 			.eht_ppe_thres = {0xc1, 0x0e, 0xe0 }
 		},
@@ -801,7 +805,8 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 					IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ |
 					IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI,
 				.phy_cap_info[5] =
-					IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT,
+					FIELD_PREP_CONST(IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK,
+							 IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US),
 			},
 
 			/* For all MCS and bandwidth, set 2 NSS for both Tx and
@@ -829,6 +834,9 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			/*
 			 * PPE thresholds for NSS = 2, and RU index bitmap set
 			 * to 0xc.
+			 * Note: just for stating what we want, not present in
+			 * the transmitted data due to not including
+			 * IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT.
 			 */
 			.eht_ppe_thres = {0xc1, 0x0e, 0xe0 }
 		},
-- 
2.34.1



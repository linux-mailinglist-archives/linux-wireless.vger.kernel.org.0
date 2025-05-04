Return-Path: <linux-wireless+bounces-22394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FA5AA85F7
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DC0178AD7
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7F1A3146;
	Sun,  4 May 2025 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBVME60r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE31A5BB6
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354425; cv=none; b=gu6yszYE7+YbPl+KACIG0SvGNCMob7ebgqm3dZ2gyE/G3rE5wqJZtZq8qJA7FcgDSZR44AlFXdojmBh+oM11TekTlcHF6d8ITynDOpVLbOfGwRwdgTI4v684zZE9IcYxjb+wwddlcLeY/Itsqm53AkVnr0Px7JsUa89XoutmvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354425; c=relaxed/simple;
	bh=39c6kvIGg+pdhEzxgNHPeuijOhbEfg6gaPckzk8WZQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqst/Fg3XrWSs7tC0kZkopOOSJiOwve3Gbc4EozzhpnyDU2LPX9ldrYY78ZhgjjJmVlOvUZM3eFbjIM2bpsUifgyfXMq2LUtce9IxsziKxbs9Bq8W77VSm8MptJpCr3l/JNbXHDY2L0DkZzCEKGON/HufENcFR/kMbskxYBoBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBVME60r; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354424; x=1777890424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=39c6kvIGg+pdhEzxgNHPeuijOhbEfg6gaPckzk8WZQ8=;
  b=lBVME60rGQt/OgakOScavrMDVU8v+RALX8gUS/UmJeTaqeFCe5DMkZm9
   W1oqa7WXGBYYcGtVAuCP/3xTo+22ma3qf1DDf3Oonf3HmR+5Oo0qQSX5U
   hXyyRXI92ZQgLOPH/RNLWBOSjfzO9D0OAhLdT5aXYuIPsSoAMu4p1H6nZ
   nOkV1Css8SXhj94KaA7Ou+PtBRxXxWKrPab7oHN5OzWYpgg+4jiBMCCO3
   wIotIbhCXxrnxUC4cOIZUMgFodzhEr7XX8LqH/D4keLyFAYBuC2bX55lb
   qBpg5XziLQXTFyvCOq5PMK55S5ig4YpYMqbiy2LFxw5r3xBszdhcAvZnM
   w==;
X-CSE-ConnectionGUID: kDOEetKrQhKd3JkVODBcmg==
X-CSE-MsgGUID: s8XgaKenSLultErsdg21bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511497"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511497"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:03 -0700
X-CSE-ConnectionGUID: ljczVlwnR3m981hOrHmrCA==
X-CSE-MsgGUID: e23OKaNYTeGU4IqR3u2DCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778889"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mvm: don't report bad EHT rate to mac80211
Date: Sun,  4 May 2025 13:26:24 +0300
Message-Id: <20250504132447.325d7ba6905f.I3bdd8854e1a784856a4973ff4d532c74f992af00@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In EHT, we shouldn't report a legacy rate to mac80211, that
might just be confusing. Set it to zero, since it's only
really relevant for radiotap.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ee4b5cfc57d3..a9b2b846ab37 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1489,6 +1489,7 @@ void iwl_mvm_hwrate_to_tx_rate(u32 rate_n_flags,
 		r->flags |= IEEE80211_TX_RC_VHT_MCS;
 		break;
 	case RATE_MCS_MOD_TYPE_HE:
+	case RATE_MCS_MOD_TYPE_EHT:
 		/* mac80211 cannot do this without ieee80211_tx_status_ext()
 		 * but it only matters for radiotap */
 		r->idx = 0;
-- 
2.34.1



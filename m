Return-Path: <linux-wireless+bounces-21864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B68A97E4D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 07:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9C4189E4C2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 05:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A58266B51;
	Wed, 23 Apr 2025 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYzZgUoM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A4266EE0
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387457; cv=none; b=a1XmFwJGdk4zY2RNw95SVncNAsn/WhyDW2/Z6eiXRZ4w92ho/Ta4XYv7E1eww0o47faz5aJbibwy/9Vl8ChB3fCeZAG8oJHI+KNSdT90uoLPRuHiM1GlOIe4Qgx1S+d2WXUPi0ce5znFWzCo0Ih+3I1WsaVRnfs4ktTzqqZ5h0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387457; c=relaxed/simple;
	bh=9R/p5e27pnoiAY42Zg51kvE3IwL5/rlJmnxIW0GQFG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=giE/J/qT8tKp1e004i4kYCa8G5lVjmFw4/ixJ831NhhgXcTgGOneKbsJwwB/5S5+GLewyJieupRt8MNba28xi8kgbh1kggCx6ixKw4XXp5WQClIuZ9BPnHhKDqKmx8OOHrXtZMME1ddSG1AwNW/4JhHtKLpSgXlyAqKdvJFLlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYzZgUoM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745387456; x=1776923456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9R/p5e27pnoiAY42Zg51kvE3IwL5/rlJmnxIW0GQFG4=;
  b=CYzZgUoMdXiojx5fJ7vm9y7FgsepByBps5YfN+Q61TbokTZadTR1jK+m
   sIyiIED/edYb1joFBOAg43m+T8MiS8TzcMMNK/CcyQM45rVAuW8TLevgv
   i2hfcwiAhKxAMPfN92zY0B+ZCt/oD261z76xMgOmTLYzAkLRGzCzrdrN7
   inJ6xmEibNtDKkvXA6dPoq1w+roIOJ6DLTi2ePgQx3uzjVzI/iHIAnhmt
   6RT0EzTIv6LRGLh3wZL6QST894SyAadBvZQwlTupPGCZyLLzJBCwWJHpC
   bCGJys+Ex6sWjfSaxwPBAge1myp/k6jKJBlME3TrIBSUhMOT2aUbTe4Bl
   A==;
X-CSE-ConnectionGUID: GoXLEESuRkKZzqf2DgrihQ==
X-CSE-MsgGUID: zIDYhFlfQOuAuneYWVLujw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46844621"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46844621"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:55 -0700
X-CSE-ConnectionGUID: igL8ZEROTGKBuUKZtk91Bg==
X-CSE-MsgGUID: 7nhnUPBCTX+bzyg4poxeIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="133164319"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 22:50:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH wireless 04/17] wifi: iwlwifi: parse active and 20 MHz AP NVM channel flag
Date: Wed, 23 Apr 2025 08:50:23 +0300
Message-Id: <20250423084826.897d826a8612.I1f7f84f4485ed3928070c97a031110ccb608bda8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
References: <20250423055036.2262960-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Configure 20 MHz AP mode based on NVM settings, set the
NL80211_RRF_ALLOW_20MHZ_ACTIVITY flag, when the NVM indicates
that an access point can operate in 20 MHz only.

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
Depends on commit: "wifi: cfg80211: allow AP operations in 20 MHz
configuration"
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 36 +++++++++++--------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index cd1b0048bb6d..018752b8c4d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -143,6 +143,9 @@ static struct ieee80211_rate iwl_cfg80211_rates[] = {
  * @NVM_CHANNEL_VALID: channel is usable for this SKU/geo
  * @NVM_CHANNEL_IBSS: usable as an IBSS channel and deprecated
  *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
+ * @NVM_CHANNEL_ALLOW_20MHZ_ACTIVITY: active scanning allowed and
+ *	AP allowed only in 20 MHz. Valid only
+ *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
  * @NVM_CHANNEL_ACTIVE: active scanning allowed and allows IBSS
  *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
  * @NVM_CHANNEL_RADAR: radar detection required
@@ -159,20 +162,21 @@ static struct ieee80211_rate iwl_cfg80211_rates[] = {
  * @NVM_CHANNEL_AFC: client support connection to UHB AFC AP
  */
 enum iwl_nvm_channel_flags {
-	NVM_CHANNEL_VALID		= BIT(0),
-	NVM_CHANNEL_IBSS		= BIT(1),
-	NVM_CHANNEL_ACTIVE		= BIT(3),
-	NVM_CHANNEL_RADAR		= BIT(4),
-	NVM_CHANNEL_INDOOR_ONLY		= BIT(5),
-	NVM_CHANNEL_GO_CONCURRENT	= BIT(6),
-	NVM_CHANNEL_UNIFORM		= BIT(7),
-	NVM_CHANNEL_20MHZ		= BIT(8),
-	NVM_CHANNEL_40MHZ		= BIT(9),
-	NVM_CHANNEL_80MHZ		= BIT(10),
-	NVM_CHANNEL_160MHZ		= BIT(11),
-	NVM_CHANNEL_DC_HIGH		= BIT(12),
-	NVM_CHANNEL_VLP			= BIT(13),
-	NVM_CHANNEL_AFC			= BIT(14),
+	NVM_CHANNEL_VALID                   = BIT(0),
+	NVM_CHANNEL_IBSS                    = BIT(1),
+	NVM_CHANNEL_ALLOW_20MHZ_ACTIVITY    = BIT(2),
+	NVM_CHANNEL_ACTIVE                  = BIT(3),
+	NVM_CHANNEL_RADAR                   = BIT(4),
+	NVM_CHANNEL_INDOOR_ONLY             = BIT(5),
+	NVM_CHANNEL_GO_CONCURRENT           = BIT(6),
+	NVM_CHANNEL_UNIFORM                 = BIT(7),
+	NVM_CHANNEL_20MHZ                   = BIT(8),
+	NVM_CHANNEL_40MHZ                   = BIT(9),
+	NVM_CHANNEL_80MHZ                   = BIT(10),
+	NVM_CHANNEL_160MHZ                  = BIT(11),
+	NVM_CHANNEL_DC_HIGH                 = BIT(12),
+	NVM_CHANNEL_VLP                     = BIT(13),
+	NVM_CHANNEL_AFC                     = BIT(14),
 };
 
 /**
@@ -1659,6 +1663,10 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 	if (nvm_flags & NVM_CHANNEL_INDOOR_ONLY)
 		flags |= NL80211_RRF_NO_OUTDOOR;
 
+	if (nvm_flags & NVM_CHANNEL_ALLOW_20MHZ_ACTIVITY &&
+	    flags & NL80211_RRF_NO_IR)
+		flags |= NL80211_RRF_ALLOW_20MHZ_ACTIVITY;
+
 	/* Set the GO concurrent flag only in case that NO_IR is set.
 	 * Otherwise it is meaningless
 	 */
-- 
2.34.1



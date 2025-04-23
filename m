Return-Path: <linux-wireless+bounces-21885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BBBA97F03
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA19D3B2BC3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126F2676D5;
	Wed, 23 Apr 2025 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvcJ5C0I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06852267397
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389021; cv=none; b=lKbo4lTyLddwDdMeAJ2u6GGHGhTBSQzp3xY7prvpjjHurxJbI8XTUa41UYc2PADPES+Cob///2ClMKJ11TQkXZPt/xbvcLs6fYhpLvUEgoRSbl7GiaajyLSmCDkMifMs+QcO6qHZgEHS9BtQgTVYnlvJflUJS5gZn9Br4DGJs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389021; c=relaxed/simple;
	bh=9R/p5e27pnoiAY42Zg51kvE3IwL5/rlJmnxIW0GQFG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJtn0U6Pm7RZBYAicG0qG+so4kGIA3ivZrl6V3MzFVSjW07Pq8xEbeqAQEJatZ24DXdd1kra2TL8VOmSvHJB+BZ93WiyFsxM6IP58fCcyXn0t8wUPmPUUOphdMlGvuToXeV+N966yMPS/PbpvIBYJXveY6IsOfFZwkUUdPWX5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvcJ5C0I; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389020; x=1776925020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9R/p5e27pnoiAY42Zg51kvE3IwL5/rlJmnxIW0GQFG4=;
  b=lvcJ5C0Iqxj9sDUE3Y2ilh1HWH/HGqlmdnOpKN+Sr7xqKZcBnqpnTI7O
   tqYHfD5mWlFPhmqtIf2fuBnVJfC/3yJtaDagReYYP4Dnm/g3OonF6KA+M
   EUes/s+mqk4S03p3UU27xaqJF2MQWnPz/AX96SLnYD2xwS3yaQK/fcatY
   rnApmU7nhe5rljQXnMbj/xzCG1NpvLQOMc++GyDYoDJaDaJSR+mHaCJLR
   +Uq5gOhTJ5AzV/GJVIx2g2EPrurmZRX5FN9u46hr8g1+FOmq80sn4Mz3V
   GRx/QF+q3hK5ZNcs3cSOfnSrC1eMCihyxiSMbKxMPaotPYtIugeWUix7Y
   A==;
X-CSE-ConnectionGUID: lF2C8QV1RDOQdGezr0327A==
X-CSE-MsgGUID: sagXBEuLSL6d3zY4LJWZtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843625"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843625"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:00 -0700
X-CSE-ConnectionGUID: qhUqqkKzT6aHcBRFnOTjKA==
X-CSE-MsgGUID: QMiLISxoT9qPX2rZ2xZVrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269024"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:16:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH wireless-next 04/15] wifi: iwlwifi: parse active and 20 MHz AP NVM channel flag
Date: Wed, 23 Apr 2025 09:16:30 +0300
Message-Id: <20250423091408.897d826a8612.I1f7f84f4485ed3928070c97a031110ccb608bda8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
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



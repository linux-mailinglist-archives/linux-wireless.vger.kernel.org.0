Return-Path: <linux-wireless+bounces-19898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCD6A549F1
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A25C7A4FCE
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C08204590;
	Thu,  6 Mar 2025 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eG+XXV/2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6C20B1F2
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261758; cv=none; b=a/zb10Clt1dfBeruQqDcyJBgIguYjzBxZYpHWXvv2bME9LKMbWdc/bblmIBrj1RgTPadSOJpODatzsJ94qygClJuMqCxEL1GwGnCqbzFF+rG+OlgWAye2xE3LGOx1PsHrBMGTFSuCrn8GZ0YRbuREP0DsPGO6lYTddoPl+YeN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261758; c=relaxed/simple;
	bh=9R/p5e27pnoiAY42Zg51kvE3IwL5/rlJmnxIW0GQFG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3gEkNlBbBMuRJV1duQ70I0WEUZoK0+Y9cofg3cs/k9UShJYHjLWbocKkUUA6ekM2YgG+26PGgni9RACUi6z4fpnJMZaROeHo/xyxQV0qPfKt8kNzeLOHS0l0m+Can/KObXuCL7wq2KKcrnlB7bszvLKvpPuazyOX1njlTml09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eG+XXV/2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261757; x=1772797757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9R/p5e27pnoiAY42Zg51kvE3IwL5/rlJmnxIW0GQFG4=;
  b=eG+XXV/2q3dvRlHiKJLF9BDvvNDFiSSHTVcy/OwwfoaMWA6wr7dulSVk
   uld7ue3aEoCO9ORtggzZ0eeJPVXZvCfZJAUvMJxB8DIdzD6BTatTI3ThY
   GeyzU66sQNSWTJEHNIlGEMr+Zr/Tq516h1OnAEXX00XwocImthGl/+C4V
   7P8EueExZv/PfVzZvQ9qLF3QLSlUAw0gOItfAz1fyk+MB/KXf1Np8dQIu
   GkW+8ymBf6ClP0uiRWi7mtxDskbfvaLgFWHqVGVgiNVm+AJ2qyWz/dhb1
   3+Uoni8u4zPzqF/O/zRPq/PqJNKrCVDVQ1Rf0FoUeI4P8OcMaB90BWPmT
   Q==;
X-CSE-ConnectionGUID: 5gw4D+kySzK6fyu0BW/kmw==
X-CSE-MsgGUID: JFgJeKR4TkmEnfvyKV2xjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474520"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474520"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:17 -0800
X-CSE-ConnectionGUID: lnwdsGYbQfuvpPy3pvUT2A==
X-CSE-MsgGUID: KIFmAmYVQcOgBeaKCZY5YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915538"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH wireless-next 05/19] wifi: iwlwifi: parse active and 20 MHz AP NVM channel flag
Date: Thu,  6 Mar 2025 13:48:41 +0200
Message-Id: <20250306134559.fa17d6e2f19a.I1f7f84f4485ed3928070c97a031110ccb608bda8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
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



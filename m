Return-Path: <linux-wireless+bounces-18504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53998A286CD
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8FA167A4B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ABF21A452;
	Wed,  5 Feb 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBl5gTvu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15E22ACF7
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748403; cv=none; b=BNYobeKSUyWb/EHhRo5i6QuX6CMUyPWY/vuA/zatKk9vJKGelqT+o4wfTkcMeKLAOmTwWJJ2xsefuc98cLFv5LDSDJJBpi2QqLO1siPEEcuxyvbeaHXLMLkZ34N+TmWmYvjoPPFU1Ksw5u3DSRaY5+fiUMPrDv9KNdNLq+okEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748403; c=relaxed/simple;
	bh=O8+DP+uqn8vcf6KQ5CT0HBH/jl/+vYtBXL5lxyiC0rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hFD6Q1SfVVnto0hOW5eocDS8pIRyw3c+L/tpW+SSCckn4x38ZiwnVwxFydSKcsD4TjWq0hQUuY93QWu9xR2hDOxK0kDDMLP8mjI3nrsM1vpxGV3xLVuCKn/nAHDRJ9I4tRPMbrz9Z7mEDvWNR77CJzhyhmkOJbDZAy/o5kO5WE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBl5gTvu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748402; x=1770284402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O8+DP+uqn8vcf6KQ5CT0HBH/jl/+vYtBXL5lxyiC0rw=;
  b=aBl5gTvuW81pGmjAaPZghKVsTyQQt2gDwHIyIazyDp9I7qLcC9K9eMO0
   w/I4HcaHVZDoO0gaFJbRhzFx3zCOzqaI8VdGCel5y1iMBiYtJ2pelHv0/
   mWRkbsQryulXBo63Fm4hZ8lLsr24cGBcuYMY80SB4bBAKcPygmkfkP4a7
   oR8RLPGfWOlCv9cCJG+4bcKG9iH+sC2TpLZjfZqOpvcHBK0KrDh8Ch+tN
   kIWP7ynPRVbLqiw0D4Bg+TdKl1qIoX38fDAVp+JUvqPT7XzMnwpkrLzTx
   Yh/ixg7ci60nLT+vDrINUzbVXpN4dx/4AwffuAk9uKj/RVTLRpTis4ZHd
   A==;
X-CSE-ConnectionGUID: GNouZ1OnRsqjn0/cG+aGWA==
X-CSE-MsgGUID: 68D+w92+TO68pJ6Sq1YWWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225237"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225237"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:01 -0800
X-CSE-ConnectionGUID: d5WtIhOvRlqlO+1KTZGYog==
X-CSE-MsgGUID: MfFseO+GRmeAaf4Lk3qh8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845305"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 10/17] wifi: mac80211: set ieee80211_prep_tx_info::link_id upon Auth Rx
Date: Wed,  5 Feb 2025 11:39:20 +0200
Message-Id: <20250205110958.6a590f189ce5.I1fc5c0da26b143f5b07191eb592f01f7083d55ae@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will be used by the low level driver.
Note that link_id  will be 0 in case of a non-MLO authentication.
Also fix a call-site of mgd_prepare_tx() where the link_id was not
populated.

Update the documentation to reflect the current state
ieee80211_prep_tx_info::link_id is also available in mgd_complete_tx().

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h    | 4 ++--
 net/mac80211/driver-ops.h | 3 ++-
 net/mac80211/mlme.c       | 4 +++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 398d4e30b0db..22d32419e8a0 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7,7 +7,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
  */
 
 #ifndef MAC80211_H
@@ -3830,7 +3830,7 @@ enum ieee80211_reconfig_type {
  * @was_assoc: set if this call is due to deauth/disassoc
  *	while just having been associated
  * @link_id: the link id on which the frame will be TX'ed.
- *	Only used with the mgd_prepare_tx() method.
+ *	0 for a non-MLO connection.
  */
 struct ieee80211_prep_tx_info {
 	u16 duration;
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 5acecc7bd4a9..307587c8a003 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -2,7 +2,7 @@
 /*
 * Portions of this file
 * Copyright(c) 2016 Intel Deutschland GmbH
-* Copyright (C) 2018-2019, 2021-2024 Intel Corporation
+* Copyright (C) 2018-2019, 2021-2025 Intel Corporation
 */
 
 #ifndef __MAC80211_DRIVER_OPS
@@ -955,6 +955,7 @@ static inline void drv_mgd_complete_tx(struct ieee80211_local *local,
 		return;
 	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION);
 
+	info->link_id = info->link_id < 0 ? 0 : info->link_id;
 	trace_drv_mgd_complete_tx(local, sdata, info->duration,
 				  info->subtype, info->success);
 	if (local->ops->mgd_complete_tx)
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 686b33654b52..184b328d92cb 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8,7 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -4725,6 +4725,8 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	auth_transaction = le16_to_cpu(mgmt->u.auth.auth_transaction);
 	status_code = le16_to_cpu(mgmt->u.auth.status_code);
 
+	info.link_id = ifmgd->auth_data->link_id;
+
 	if (auth_alg != ifmgd->auth_data->algorithm ||
 	    (auth_alg != WLAN_AUTH_SAE &&
 	     auth_transaction != ifmgd->auth_data->expected_transaction) ||
-- 
2.34.1



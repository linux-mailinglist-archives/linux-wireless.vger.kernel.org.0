Return-Path: <linux-wireless+bounces-25188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B025B0094F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F357A4A16
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB625B1D2;
	Thu, 10 Jul 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZR40Gyy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C31275B18
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166512; cv=none; b=DQPTop2ukMnaK10P8sz1wqufNE3/DF3lsGqNfhNbjB0V+ONXeWDGtcWNqYl53nA08GRz0focamy2EYqr+tBq+lNxT6qoD51vYFi6xqxIVMMFJUBzjWtGZICgCTYknQwAQ2GG+aQnTDt0Rp6JQMKCtoEBaAf8We5OHWQOzxU2IgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166512; c=relaxed/simple;
	bh=6y2zzFGdzpz2vwqtH0uISVpei0e6a9cecyoRhSlNKsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hl8w4IrxjE+W96UpQBhdvXcQgqKk6PBfbKauQ8lgi/IcKelOsy4k6UgPthYTJyP0WLzSqPsoQBDV7GVhUXqURryCFu86VaCMF7DFbaP0f+xgtgulXkqjem/HG1MkNreb1SuwVAwIu0gNhx6cISkowZesTEf574iV0P6TITr/nW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZR40Gyy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166511; x=1783702511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6y2zzFGdzpz2vwqtH0uISVpei0e6a9cecyoRhSlNKsU=;
  b=WZR40GyySZ3ITkYEF7kiRuDK57IQIzzVyJrXonRXhicKw/2NgFUo//Dc
   q9nAFtEEmS7FG6JRueebhE9YE8le66X6QNYx7NG2ok+utgQueQDGRFac+
   oNeLdjhFNve3ztNmzv7jggbGfRMQ8PQds3ODgKeog4Huw58Sf359rdn4d
   Pc4LOgIlXPUV6VGPiokz+Zx6CyIUbdfSsoceVIdoaK4iU95hLbfjHFmRp
   gwbZpto61jOCdadKbpfvjzizJGqx9p1e/01v1RzhRJ1REaA+thcEhCsMx
   w/7xWtMU09I2tjbi2nuXZl9g3s8+gFOdW66afRk4VAWkiv9SxkDAS++pi
   w==;
X-CSE-ConnectionGUID: KRG6KRbQTqOaeARMl27fWw==
X-CSE-MsgGUID: WdEtzun0QQydKyNho/eu7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54609985"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54609985"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:10 -0700
X-CSE-ConnectionGUID: dWj4R1qQQTqjdNYbwYUaEg==
X-CSE-MsgGUID: KBPnB7XPTX2l7yV09bIpTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156276983"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 01/15] wifi: iwlwifi: mld: fix scan request validation
Date: Thu, 10 Jul 2025 19:54:34 +0300
Message-Id: <20250710195219.ec7d665f56a4.I416816b491fafa5d3efdf0a4be78356eedf2bd95@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

The scan request validation function uses bitwise and instead
of logical and. Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 63d5d39bb083..479a76a94aa8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -359,7 +359,7 @@ iwl_mld_scan_fits(struct iwl_mld *mld, int n_ssids,
 		  struct ieee80211_scan_ies *ies, int n_channels)
 {
 	return ((n_ssids <= PROBE_OPTION_MAX) &&
-		(n_channels <= mld->fw->ucode_capa.n_scan_channels) &
+		(n_channels <= mld->fw->ucode_capa.n_scan_channels) &&
 		(ies->common_ie_len + ies->len[NL80211_BAND_2GHZ] +
 		 ies->len[NL80211_BAND_5GHZ] + ies->len[NL80211_BAND_6GHZ] <=
 		 iwl_mld_scan_max_template_size()));
-- 
2.34.1



Return-Path: <linux-wireless+bounces-25206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF440B00B5C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C061888A89
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD9B2FCE1A;
	Thu, 10 Jul 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8S34lIL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E12FCE13
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172137; cv=none; b=JiTO7c+pfIj5dyfpmWfWR59SbvgYnZfavf5OVOxcm4f/vCJUh9wrLgyTwsMt5oU5c4frrO6x/qtVX6tMsp4MOH4Y1kcwtSzS2w0tr+jdS4JyhdkdXg1AKHale/j++xl7C2tK20R/kzsilbDZhGp8yhPGawhPTDo8ayolxsgxNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172137; c=relaxed/simple;
	bh=LO7huGSL163+cY+C5ddUIBKoGInm0+2nmxJstvnm46w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=olFpYnamNWksEI0/7bYDQMzfYoO/LLTXHzD8PJLrhm5qQnbqmvoxfvfrFk6vgt6YvVrD39kuCObPNQVY3ngufXF2rSfjjmRswqxNwe1nrfce0GJyFRySregYL8RG8bL76ld1zbt/Ns4secFtapORX/LaDULuv+3n/yA+BRlN4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8S34lIL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172136; x=1783708136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LO7huGSL163+cY+C5ddUIBKoGInm0+2nmxJstvnm46w=;
  b=n8S34lILGx/O9yxYzoIuy263gUTtTCEOnUY2uGiHZBtbmYlKyMWRwrzL
   b8br1RfGuatum7TO4a8Y5NRblU6PUhtrpK3uJAZqEAjfd2aYTzzH19j9X
   //mF/+m45KalynADidjeWhjimRmbznvWxvNrM2mYzoIz36O7Yal6fetyP
   z8F/zxM9bcE2WG6iV5onmePQuA/TcK13s9Zl38j6D/WXIqb0U8myBaYD+
   ctYfCGFWz5R++RUUpq07veRd1IWxno0T6mElpN+pCev5KDak5DdfsTtuB
   au+lXBBUBKJa2eCETe+VluFj7hgGZdXinOp5LQBqP9rJL8hxa7UDHn3r8
   Q==;
X-CSE-ConnectionGUID: 6FQ7olDNTwaLmjAsd6BEZw==
X-CSE-MsgGUID: WBmwOdC8TiugteOKx6gWng==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077790"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077790"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:56 -0700
X-CSE-ConnectionGUID: jVgoPEvzSYCOvB3JK37BLQ==
X-CSE-MsgGUID: od5mVyo2Sea0TSkxugs5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718672"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mld: update the P2P device mac before starting the GO
Date: Thu, 10 Jul 2025 21:28:19 +0300
Message-Id: <20250710212632.463a0ad545f9.I85a25484d787b65f6a27e794285911e319df0b2d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

When a GO is started, the P2P device mac is updated to indicate
that frames for the P2P device mac should be filtered in while
the GO is active. However, this configuration is done after the GO is
already started so it doesn't take effect. Fix it by updating the
P2P device mac before adding the broadcast station, which actually
starts the GO.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ap.c | 24 +++++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ap.c b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
index 26511b49d89a..5c59acc8c4c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ap.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ap.c
@@ -294,9 +294,20 @@ int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	if (ret)
 		return ret;
 
+	mld_vif->ap_ibss_active = true;
+
+	if (vif->p2p && mld->p2p_device_vif) {
+		ret = iwl_mld_mac_fw_action(mld, mld->p2p_device_vif,
+					    FW_CTXT_ACTION_MODIFY);
+		if (ret) {
+			mld_vif->ap_ibss_active = false;
+			goto rm_mcast;
+		}
+	}
+
 	ret = iwl_mld_add_bcast_sta(mld, vif, link);
 	if (ret)
-		goto rm_mcast;
+		goto update_p2p_dev;
 
 	/* Those keys were configured by the upper layers before starting the
 	 * AP. Now that it is started and the bcast and mcast sta were added to
@@ -310,12 +321,6 @@ int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 		iwl_mld_vif_update_low_latency(mld, vif, true,
 					       LOW_LATENCY_VIF_TYPE);
 
-	mld_vif->ap_ibss_active = true;
-
-	if (vif->p2p && mld->p2p_device_vif)
-		return iwl_mld_mac_fw_action(mld, mld->p2p_device_vif,
-					     FW_CTXT_ACTION_MODIFY);
-
 	/* When the channel context was added, the link is not yet active, so
 	 * min_def is always used. Update the PHY again here in case def should
 	 * actually be used.
@@ -326,6 +331,11 @@ int iwl_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	return 0;
 rm_bcast:
 	iwl_mld_remove_bcast_sta(mld, vif, link);
+update_p2p_dev:
+	mld_vif->ap_ibss_active = false;
+	if (vif->p2p && mld->p2p_device_vif)
+		iwl_mld_mac_fw_action(mld, mld->p2p_device_vif,
+				      FW_CTXT_ACTION_MODIFY);
 rm_mcast:
 	iwl_mld_remove_mcast_sta(mld, vif, link);
 	return ret;
-- 
2.34.1



Return-Path: <linux-wireless+bounces-23890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43531AD25BB
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0601891467
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AB021CC71;
	Mon,  9 Jun 2025 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYpmcrvk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBF421A457
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494168; cv=none; b=R1sLLmnXUOlkY+T9eljatSbjHk8EFJ67euOJsLaHFkbhb6DNtA51vnTh30+kia27uaBqD4saMv13V95R1YcCYZ/L2jFJrE8Mja8NVOuxEvE4ATEPG22uh1JYfPPLj3TNg2nfxxIImMt0hqD+k4FvP60rGk4OUP4uKWy7W+sMOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494168; c=relaxed/simple;
	bh=ZlRgxX/8ZKpoKdBbmR8C7c9R0qy4arKEmySXhY61huE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qb5vNA3JLnM1Aa3H9PU+2qrgtYK/DsO0aqO1viTUoDwu7MwGhLz+uudvpKk2xcaZdtYsqzHS8BiD7FWNVMmYdK1kIgjJXYRuDrCAz2D7UVfN57D+oVDPJd7/5+DHHVifcO4bVB2f4JagrhGGSM4L8GdFHGpM+3ejaIg7b9r9krM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYpmcrvk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494167; x=1781030167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZlRgxX/8ZKpoKdBbmR8C7c9R0qy4arKEmySXhY61huE=;
  b=ZYpmcrvk6iGmLiQevatjJTSslHQXAiy9KPEsgPF45f3nf2VVU6dy+7T+
   VIYNjSWc5mVwrk22D0RjhmGCBY9JlAH5QE0YDfjnq9+zzItw0bTStlcVZ
   gYYcdVchLTAn9b9fpY03mhUbquxXMtiWHuMQPYGJYN+AL8okhzEHR3z2G
   z6NloWvjzJlkW7W8i4O1JzlAe9eXt3eoIc7/F6UKjuOSIzYuBb/R2VXBc
   3fTqL8ofbyCEJOuD34uPPln98AfxRd3KqDSYryFzxdg86EF+k0NHWIjx2
   Sog4mFvTU2mC3M6RTzUTzfSIzT3nQCiSScGPQ7hCKJrYjQQeoE4GIPBjn
   g==;
X-CSE-ConnectionGUID: EtvC5WhLSOCj06ldKBQw2g==
X-CSE-MsgGUID: pFUuf+QER5SmhZaiccifaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249787"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249787"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:36:04 -0700
X-CSE-ConnectionGUID: Bh+A95RBSSKi7py77dz1OQ==
X-CSE-MsgGUID: EKZoQMdhRSirekwM1cpdlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732583"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:36:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>
Subject: [PATCH wireless-next 15/15] wifi: mac80211: don't complete management TX on SAE commit
Date: Mon,  9 Jun 2025 21:35:27 +0300
Message-Id: <20250609213232.12691580e140.I3f1d3127acabcd58348a110ab11044213cf147d3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When SAE commit is sent and received in response, there's no
ordering for the SAE confirm messages. As such, don't call
drivers to stop listening on the channel when the confirm
message is still expected.

This fixes an issue if the local confirm is transmitted later
than the AP's confirm, for iwlwifi (and possibly mt76) the
AP's confirm would then get lost since the device isn't on
the channel at the time the AP transmit the confirm.

For iwlwifi at least, this also improves the overall timing
of the authentication handshake (by about 15ms according to
the report), likely since the session protection won't be
aborted and rescheduled.

Note that even before this, mgd_complete_tx() wasn't always
called for each call to mgd_prepare_tx() (e.g. in the case
of WEP key shared authentication), and the current drivers
that have the complete callback don't seem to mind. Document
this as well though.

Reported-by: Jan Hendrik Farr <kernel@jfarr.cc>
Closes: https://lore.kernel.org/all/aB30Ea2kRG24LINR@archlinux/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h | 2 ++
 net/mac80211/mlme.c    | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4a4c9019805e..48c82078d606 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4299,6 +4299,8 @@ struct ieee80211_prep_tx_info {
  * @mgd_complete_tx: Notify the driver that the response frame for a previously
  *	transmitted frame announced with @mgd_prepare_tx was received, the data
  *	is filled similarly to @mgd_prepare_tx though the duration is not used.
+ *	Note that this isn't always called for each mgd_prepare_tx() call, for
+ *	example for SAE the 'confirm' messages can be on the air in any order.
  *
  * @mgd_protect_tdls_discover: Protect a TDLS discovery session. After sending
  *	a TDLS discovery-request, we expect a reply to arrive on the AP's
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8a86e5bc152b..6cc4a9a909ec 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4779,6 +4779,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_prep_tx_info info = {
 		.subtype = IEEE80211_STYPE_AUTH,
 	};
+	bool sae_need_confirm = false;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -4824,6 +4825,8 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 				jiffies + IEEE80211_AUTH_WAIT_SAE_RETRY;
 			ifmgd->auth_data->timeout_started = true;
 			run_again(sdata, ifmgd->auth_data->timeout);
+			if (auth_transaction == 1)
+				sae_need_confirm = true;
 			goto notify_driver;
 		}
 
@@ -4866,6 +4869,9 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 	     ifmgd->auth_data->expected_transaction == 2)) {
 		if (!ieee80211_mark_sta_auth(sdata))
 			return; /* ignore frame -- wait for timeout */
+	} else if (ifmgd->auth_data->algorithm == WLAN_AUTH_SAE &&
+		   auth_transaction == 1) {
+		sae_need_confirm = true;
 	} else if (ifmgd->auth_data->algorithm == WLAN_AUTH_SAE &&
 		   auth_transaction == 2) {
 		sdata_info(sdata, "SAE peer confirmed\n");
@@ -4874,7 +4880,8 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 
 	cfg80211_rx_mlme_mgmt(sdata->dev, (u8 *)mgmt, len);
 notify_driver:
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (!sae_need_confirm)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 }
 
 #define case_WLAN(type) \
-- 
2.34.1



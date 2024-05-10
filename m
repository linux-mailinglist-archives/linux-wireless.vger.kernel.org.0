Return-Path: <linux-wireless+bounces-7461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A038C2659
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884CB1F232FE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71331708A8;
	Fri, 10 May 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7SW7+oM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937D136E0C
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350015; cv=none; b=u6mGNXKz+pL/yNX/gMKM676o7Mqjf+2eEPLjTUE33SO9VqsBNDQDywR59pttjVLNMBxiq/l3GmX7LgOjIxOSgTyoU1HZva7SLn2tv9oEq/WYFoY/a+QgO6Mmi4KY3JlCLZ1JI0X+qVl3dhqiTEtmrkT98L/ZKbGXXxbywjCbQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350015; c=relaxed/simple;
	bh=2eYnwjii5TY0WonVlBXB1ItTcIGPYGSOvIvYYeqnqZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5A32IrdQmsIWiMyBGgtf36BNqAq6zUAMCFpDZ15xla4Xx1s2MxPUQkV91Vk9sJ3UmQ1v3nJbDKdX/hfpcgupIurwe7DVkiVqJ1klb6OYLdvlg36LQByFwT2SXizjLx+rhe8j8F/vN9klyWD/dxZeoZGa5QejPo6kVZlfGpRQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7SW7+oM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350014; x=1746886014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2eYnwjii5TY0WonVlBXB1ItTcIGPYGSOvIvYYeqnqZg=;
  b=k7SW7+oM1d8S8hWzRsBWwtsftQyIJEQHu9YHINTBLcJ0EgCF1LWejXOP
   1sTtvnpV7Jh3+ySkftzIUyJJBFSF1P0aP4SCzllsRX1xjLUdxL7wRcOGf
   +Y6MVXsAiwEqc8Q8JOwB+E+x+chxutZlMx+RVkQ/b7Vp4ozktochofd11
   aA8QhoIY5mdw2uGI0HTzGmlG34Ibc9k01LITSb0LPvMCJ7r033gq1Utjx
   O39gZWpDdZXJLurMdeB94obIlsDQV48+kUznw1KQdLq4GAmhidH7jzuzq
   0hkihsGr45QshCfOaD6omfsQlVex+XCya21g9oZQYr/yNx7+5tV0zPXV9
   A==;
X-CSE-ConnectionGUID: o6b8ELmRQrK4g8ZD+h+4Tg==
X-CSE-MsgGUID: 5+M1rJiET424KG85xyH8Kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125518"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125518"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:06:54 -0700
X-CSE-ConnectionGUID: T49YHlbxSGmG0sw/LvEHwQ==
X-CSE-MsgGUID: ALSkBiQyREm3oUzZ9zOIlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101808"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:06:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 01/14] iwlwifi: dvm: clean up rs_get_rate() logic
Date: Fri, 10 May 2024 17:06:28 +0300
Message-Id: <20240510170500.a4cdb41825eb.Id202bcc967c32829f70ab1412f8893b6eb7f78e2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The logic here is rather convoluted - we cannot get here with
lq_sta being NULL as mac80211 will (no longer) call us like
that, and since I removed the rate_control_send_low() call in
this function there's no longer any point in setting priv_sta
to NULL either.

So the only thing that remains to check is if we have actually
initialized our lq_sta->drv pointer, and exit if we didn't in
which case we'll use the data mac80211 already set up for the
low rate usage.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index f4a6f76cf193..8879e668ef0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2673,20 +2673,16 @@ static void rs_get_rate(void *priv_r, struct ieee80211_sta *sta, void *priv_sta,
 	IWL_DEBUG_RATE_LIMIT(priv, "rate scale calculate new rate for skb\n");
 
 	/* Get max rate if user set max rate */
-	if (lq_sta) {
-		lq_sta->max_rate_idx = fls(txrc->rate_idx_mask) - 1;
-		if ((sband->band == NL80211_BAND_5GHZ) &&
-		    (lq_sta->max_rate_idx != -1))
-			lq_sta->max_rate_idx += IWL_FIRST_OFDM_RATE;
-		if ((lq_sta->max_rate_idx < 0) ||
-		    (lq_sta->max_rate_idx >= IWL_RATE_COUNT))
-			lq_sta->max_rate_idx = -1;
-	}
+	lq_sta->max_rate_idx = fls(txrc->rate_idx_mask) - 1;
+	if (sband->band == NL80211_BAND_5GHZ && lq_sta->max_rate_idx != -1)
+		lq_sta->max_rate_idx += IWL_FIRST_OFDM_RATE;
+	if (lq_sta->max_rate_idx < 0 || lq_sta->max_rate_idx >= IWL_RATE_COUNT)
+		lq_sta->max_rate_idx = -1;
 
-	/* Treat uninitialized rate scaling data same as non-existing. */
-	if (lq_sta && !lq_sta->drv) {
+	if (!lq_sta->drv) {
 		IWL_DEBUG_RATE(priv, "Rate scaling not initialized yet.\n");
-		priv_sta = NULL;
+		/* mac80211 already set up the data for using low rates */
+		return;
 	}
 
 	rate_idx  = lq_sta->last_txrate_idx;
@@ -2756,7 +2752,6 @@ void iwl_rs_rate_init(struct iwl_priv *priv, struct ieee80211_sta *sta, u8 sta_i
 	lq_sta = &sta_priv->lq_sta;
 	sband = hw->wiphy->bands[conf->chandef.chan->band];
 
-
 	lq_sta->lq.sta_id = sta_id;
 
 	for (j = 0; j < LQ_SIZE; j++)
-- 
2.34.1



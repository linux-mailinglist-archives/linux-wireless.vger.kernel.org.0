Return-Path: <linux-wireless+bounces-18496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97EFA286C6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF5188A42F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C57422A1CD;
	Wed,  5 Feb 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQWd1Se4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8B22A80C
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748389; cv=none; b=gbyZzOxrZj8gi1eNnR2Er7OCcbwMBZTBMXAbDmV8g6KaWWFdDAwg7QCPiCa7r8/02VY29j86/I2NsIL0x2rLVg+IyYUojXr49Q9uEbs+KgL72c6oiOyBJFxROK+c4hPe/a4CfkHtN+POCtCbLNKf9qMdnLtBP/nIRIBfcKJA4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748389; c=relaxed/simple;
	bh=yVpSoxuYVI0nJHIu3OuyPSs2BPcFm9ar7xAy2m9yIGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ek0RF4HW3uqxC4EIlAElm6VxTMv5C3xmZWvb3legVWaDNznoYXtUgnmq1yQMnki8c0jOShMIsoKyHinjrziK2wddqBigPoxx8NAMy66Ij/Rb/2/DSWQbTN3nZD7po5g2rSzUZuzUSYZPvg3QSr/Acx1ZPx07lHDbtRtuXfrt67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQWd1Se4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748387; x=1770284387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yVpSoxuYVI0nJHIu3OuyPSs2BPcFm9ar7xAy2m9yIGA=;
  b=lQWd1Se4PF4rLwPrbKs36H88iHAJ+NaM0n1hd3KUAsxLzkYhBS/0MKzi
   qBe9z9Q8NEomnL2B3MtP7uawDTqzE0+3PTdgAjGBN/tVgXQ6S5Oxuvm9M
   wAQofudB+4Ky+Zv3Etc0YFJ98FX3LI26OkSO/SyFDH22ZwKIk/GBXvn/1
   HOcDfqgWCp765muzVXQX+1Wx+Z6y6tsdKmHaffnoHmYOjPncoJ9b4VA3l
   5bIO9mZ32B/AcCvIcMRhA68NOJ2GgbNWgC5y0a7RXcDTw8W7XzkWDYXzp
   rSe8s4z39/vXH4AgTf9EYhuzY5Go67quPDIV3YjNPyslZ+aNsDbCpayyt
   A==;
X-CSE-ConnectionGUID: MElyqE0LRZmv5ICb6jD8aw==
X-CSE-MsgGUID: 2uyyW8PrQkSV5WSBRp2YoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225207"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225207"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:47 -0800
X-CSE-ConnectionGUID: 03yq5dsFSpuPGn6GVx2m3A==
X-CSE-MsgGUID: wirwZoVpTOiksmC4ugVu/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845271"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/17] wifi: mac80211: Refactor ieee80211_sta_wmm_params()
Date: Wed,  5 Feb 2025 11:39:12 +0200
Message-Id: <20250205110958.b1cedcf93763.I65783c102d44127035838f97fab64ec4df5c40f3@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

The function first updates the link configuration and then
calls the driver to set the link parameters. Since the call
to the driver might sleep, split the function such that
the link configuration could be done without calling the
driver. This would be useful in cases that WMM parameters
need to be configured, but the current locking doesn't allow
to call the driver.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f8d52b3b0d0e..6feb4ce2c90d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3375,10 +3375,10 @@ void ieee80211_mgd_set_link_qos_params(struct ieee80211_link_data *link)
 
 /* MLME */
 static bool
-ieee80211_sta_wmm_params(struct ieee80211_local *local,
-			 struct ieee80211_link_data *link,
-			 const u8 *wmm_param, size_t wmm_param_len,
-			 const struct ieee80211_mu_edca_param_set *mu_edca)
+_ieee80211_sta_wmm_params(struct ieee80211_local *local,
+			  struct ieee80211_link_data *link,
+			  const u8 *wmm_param, size_t wmm_param_len,
+			  const struct ieee80211_mu_edca_param_set *mu_edca)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_tx_queue_params params[IEEE80211_NUM_ACS];
@@ -3507,6 +3507,19 @@ ieee80211_sta_wmm_params(struct ieee80211_local *local,
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
 		link->tx_conf[ac] = params[ac];
 
+	return true;
+}
+
+static bool
+ieee80211_sta_wmm_params(struct ieee80211_local *local,
+			 struct ieee80211_link_data *link,
+			 const u8 *wmm_param, size_t wmm_param_len,
+			 const struct ieee80211_mu_edca_param_set *mu_edca)
+{
+	if (!_ieee80211_sta_wmm_params(local, link, wmm_param, wmm_param_len,
+				       mu_edca))
+		return false;
+
 	ieee80211_mgd_set_link_qos_params(link);
 
 	/* enable WMM or activate new settings */
-- 
2.34.1



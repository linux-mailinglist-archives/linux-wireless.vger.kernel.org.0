Return-Path: <linux-wireless+bounces-18441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51709A278C9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD14B165922
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076E7216607;
	Tue,  4 Feb 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9PteTcP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF72165E7
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690997; cv=none; b=fDWjVk+zwpF3uTWQXFjvseNzRMecPQC8aez6hRfu1/nxA6i5hWbT02eotu/OkTnqKsV5iAN28KdBcct9P7A+w1Ux8Yoj+lbRtvC+PYm1R7SbluUhEiZPQjwA6vy7FfCq9ViZkzSOriG0UfQxkFdftUriclEMRYmzWHHhvQU8YlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690997; c=relaxed/simple;
	bh=yVpSoxuYVI0nJHIu3OuyPSs2BPcFm9ar7xAy2m9yIGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuyCaT9vCJeuk3h7SQZlBld38jmAL9c6xF6Pgx0MnrWgbsJaqtH8/z4z6Lzg1ieBmyJa7jxA0zJOn4iiXgqxm75QkAgPD7XRSL6NZZkh8Vf6aEjjPdTW3lQn+qOM/6yrzTi1e3Hxoy9KS4OkfcUBHPvImkRLVDrEffCCyFPZicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9PteTcP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738690996; x=1770226996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yVpSoxuYVI0nJHIu3OuyPSs2BPcFm9ar7xAy2m9yIGA=;
  b=N9PteTcPJq/juog7LJ5jjxEXi6vdP38z34T3d/7FQm38GIc2iC2RZQT5
   PypZoHFnI3Cui17br6mLeFc2DgWEJzYaZOiH4RQhPrzmNweJ6qzODAZJo
   VWevYpO7N+LIBBoWY02Sn4XhUFAfEa12PQOBvLo3rOqw58X/ZEmVnU+AL
   HENur8PIAEb33YW2JHw6I2uByTVWaGvj2PzWIPzi0gJPPbLupkXLe+4aT
   ro+dYRklpBEgKFUADdvehaRXKgpyBIfKmLqosiA800vZt+fTMpYEeZ5x3
   ONjkNGQRgjRf6J8tkWwUas6h2/mpBWUCc2YGYDPL4MpZ/EUJQ4VDBGHAn
   Q==;
X-CSE-ConnectionGUID: ehw6uOoXSa+2pqRRugotyg==
X-CSE-MsgGUID: Xti/GoT6SBCBzkgmjx6hhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585334"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585334"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:37 -0800
X-CSE-ConnectionGUID: KIr/8KBHRpWcuPMEtrzU1w==
X-CSE-MsgGUID: hracIgiKR/iln8+wNVpVNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696673"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/20] wifi: mac80211: Refactor ieee80211_sta_wmm_params()
Date: Tue,  4 Feb 2025 19:41:59 +0200
Message-Id: <20250204193721.b1cedcf93763.I65783c102d44127035838f97fab64ec4df5c40f3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
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



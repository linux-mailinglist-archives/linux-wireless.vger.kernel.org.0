Return-Path: <linux-wireless+bounces-28054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A2BEE0BF
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D996189A0A8
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C0621A95D;
	Sun, 19 Oct 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/xpCVUx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A291459F6
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760862899; cv=none; b=FTHy81TnWQUMiUbwhh7L46ZOMX7EgCHAoTTX80n9Yg7oxMi/7lYegKHhe6wOQR17scAi5Hnh3ykYnuwrLxlXTZVTSwAHVVKhITn9WV8y8xA3yeqPSg7Sh4pL2/Hpj5fXnJ+SuqfWQ9k/ahG+xT/CX+euy7HO1hfr8fSw3kM0V+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760862899; c=relaxed/simple;
	bh=vTTXyvZt38btVue6QooweQvayDl6pF3rTeaQaBCCiYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SL+SIvO47g/clhFjdn8xVU+0JYpiH4fxWdFBown4TRZ2hIvjjZqFMEnnu4yCwVLf2huKnXN5CFL0ykm+C4lXAgsMCRRKc5wFGrHiltlBI0zviQLiPMiIi0xzWYCX8pPuf/j+eWY0WEVrW+JDCPh2YZqneYRU9bwY+cZkPcr7r8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/xpCVUx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760862898; x=1792398898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vTTXyvZt38btVue6QooweQvayDl6pF3rTeaQaBCCiYo=;
  b=Z/xpCVUx9rO+vtU8hmvt6iQkfVNzljsyXGEztnqiACrNULe52EyHvpaV
   2Q4KpuwxXV1mGfxk7Ihz/+FNd1LuIrCa+eAjh7Uu6K8nVPcDthDHgyV60
   rMtjTcVu1x1LCkyZ7DZrYW+yhgjBrnNfMWSVaCFurvwJy1d4uwZZZozfW
   YONMNrMGAPq9iO0kqihPlP0HP67LJVAvQLl5vz7y/ldwrVFP/TucOjYRN
   vURTNR6fWM3sB0k5vf4qh1AMi8hWmS6mSCTll6umK9zftZkvAVsO1GDaz
   grI6j3oNEgfy3a4ElDWPFXKm3WfWmVWOefyO1tEglmotyTSo6nkoXE6h5
   Q==;
X-CSE-ConnectionGUID: dZtMktXLTZKvGQHj7Qc3UQ==
X-CSE-MsgGUID: OxLgHP9GTt+uVWpGOkqMeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66884162"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="66884162"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:34:57 -0700
X-CSE-ConnectionGUID: DiKMki6aQ9mFzj6yq7isbQ==
X-CSE-MsgGUID: bQniS891Qw+VqnZuFtsMWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="188188416"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:34:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] wifi: mac80211: reset CRC valid after CSA
Date: Sun, 19 Oct 2025 11:34:48 +0300
Message-Id: <20251019113426.521ad9c6b87d.I86376900df3d3423185b75bf63358c29f33a5eb6@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

While waiting for a beacon after CSA, reset the CRC valid
so that the next beacon is handled even if it happens to
be identical the last one on the old channel. This is an
AP bug either way, but it's better to disconnect cleanly
than to have lingering CSA state.

In the iwlwifi instantiation of this problem, mac80211 is
ignoring the beacon but the firmware creates a new CSA,
and then crashes later because mac80211/driver didn't do
anything about it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3b5827ea438e..e699702fe5b1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2508,6 +2508,16 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 
 	link->u.mgd.csa.waiting_bcn = true;
 
+	/*
+	 * The next beacon really should always be different, so this should
+	 * have no effect whatsoever. However, some APs (we observed this in
+	 * an Asus AXE11000), the beacon after the CSA might be identical to
+	 * the last beacon on the old channel - in this case we'd ignore it.
+	 * Resetting the CRC will lead us to handle it better (albeit with a
+	 * disconnect, but clearly the AP is broken.)
+	 */
+	link->u.mgd.beacon_crc_valid = false;
+
 	/* apply new TPE restrictions immediately on the new channel */
 	if (link->u.mgd.csa.ap_chandef.chan->band == NL80211_BAND_6GHZ &&
 	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HE) {
-- 
2.34.1



Return-Path: <linux-wireless+bounces-28076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D8BEE12E
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3730E4E03CA
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1A21B3930;
	Sun, 19 Oct 2025 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsoV8oLb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9527280F
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863857; cv=none; b=iie+8FPJThz9f+aQOWDEgSDvWVtMFOa9VSuqSVv+DRWuvKfWVxItpWbd0NWn2vSgiQpnvyWzbq/JnLke29UekzdZGNbN6gzIwE5Jun+JkWARETlCCama6S2xOwSw+qzm8HEXwF7ioH7SY/d7AE1b5U8ylLyXpr3qTnEd9pu1Oek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863857; c=relaxed/simple;
	bh=Bix70ZJh5T4Woy2msoy3LQKb9n0ZNLI0Zk2bGACNXw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kGb6pfDOeEr0PV7OCgIzDU/VdpBPeJefURNNPn2iw3H8fdzk51Iv4iqN/qzOjquJdbwu5bteVAVPLbMM1Zn6NLkyMiaTmh5dRo6Q56p3QC0ndfbcwdeH45cls9DEgaco7svHN0Kp03mOxTfS3Cm+FcXWbGsYSZRNjbON7w3UT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsoV8oLb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863856; x=1792399856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bix70ZJh5T4Woy2msoy3LQKb9n0ZNLI0Zk2bGACNXw4=;
  b=XsoV8oLbPUxqY65P7mvG3piU+mKj7j1DUWu1wwfZ4qUCCRkAKKUIXq2l
   u5TvfTNAu2RcIt40+4EHrTOe9mUyyLCyl0Cmc1+9dpLvJ2EAl/rHSv3GF
   k8YjhzA8qKEw9L2nf9bf+WEHT8N3HmW9zeQ1omEgAitMCyrcraGhHP/vF
   ULgqOBxfKmbH8bG5S162sgq9tcAWdeLbm0tIg3ZAa9YeuFgQPPnLrfRVE
   +9zzYucNwPrnSjQEvjPOJfyoMxQv+p0pPfLmmuie87XGc4OHQIAr5/A5L
   asQbpBMAyqArehNY1SwgHfR1THS+twokev8X9J2eKZGtXcicR6rLAXEQ8
   A==;
X-CSE-ConnectionGUID: 6LJFX49IQB+zyINFwOG8Ow==
X-CSE-MsgGUID: d7rANilURoqoMnShTTRjig==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80456346"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="80456346"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:50:55 -0700
X-CSE-ConnectionGUID: 5TYPc/HwT6GujrOd2aW5mg==
X-CSE-MsgGUID: cXNRsy7vRgW4YX5fNlRsQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182642481"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:50:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next v2] wifi: mac80211: reset CRC valid after CSA
Date: Sun, 19 Oct 2025 11:50:49 +0300
Message-Id: <20251019115024.521ad9c6b87d.I86376900df3d3423185b75bf63358c29f33a5eb6@changeid>
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
v2: add the destination tee to the subject
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



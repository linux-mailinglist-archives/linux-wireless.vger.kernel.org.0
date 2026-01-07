Return-Path: <linux-wireless+bounces-30449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D888CFDE4F
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 995B13004E0E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA90329C40;
	Wed,  7 Jan 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/yNy+qv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99176329E40
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792023; cv=none; b=SB8r6B8IWXv8VXXSFy0KrYxVnnc+RB55Put2ErS7DObFx+73Iwqy/mDr3XgvUocOadsmEO1TEPkqeL62FfgjIvw4HbAKZXmSmqBcs+YUC0DpbmFW2GuKL7G+/DvtAHGkOYjn+9juEaxqhI08H7RJzmpotWuAd5DSxva7n/8AYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792023; c=relaxed/simple;
	bh=oFjjC8XoJFkHJmU+TkNWWyMmTXMSN6LEtdLbikzjFLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WldqoBrYqDxdfCjXhXRCbNs0EYRs/axQksvvySoIe80+sne9ym09O3jo5YIO2CJqiL8maJlua+kMmxpGtkX9sy9dDMAid22naa1feepy7N7s+ausLoJPY2v57NQid1MRoftwOm1pX7ZNlTp1kGBmFnK1K+uVssSqcqdAyTOsPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/yNy+qv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767792022; x=1799328022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFjjC8XoJFkHJmU+TkNWWyMmTXMSN6LEtdLbikzjFLY=;
  b=L/yNy+qvZUydkwKKxOzP7u9wyIEtXDpsBpk98vwIFxwj1RW8m/6uuL6y
   ZUY9mOCuzCMgdmzoy0CFyP5jXaNWLAHqK03KsGAaKaslPfOMGqVFJ2nlB
   crP/sMPhZRRm2Rop2+WAnQQIPmkorqUwHKZpWE2NL0Y8l69vBtlQtEouw
   Y1TUUE5eMUVxpUghtA0wyVxzVSP7FbkjQ5nY6LEb6HCW0Kgryd41zArPN
   lgsdsevr+8XQCPWdOxSR6jigX3SCAfSSd8qkTh0sTisu39vxvugLLTLvs
   ZPsCPj1XBsAfMD4dQurJVuIvnKnwuqMEirlDMObo7ouRHiyug0GqR5CAx
   A==;
X-CSE-ConnectionGUID: QGFRtgvfSiaMQxHFMetDUA==
X-CSE-MsgGUID: RcwRLK4CRaW86nj4eJAXtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86576863"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86576863"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:22 -0800
X-CSE-ConnectionGUID: 1Sp/ykymQMikJHoC9jIFQw==
X-CSE-MsgGUID: 6zBitibzTh2NFb1Cv9FYsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203185763"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:20 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 07/15] wifi: cfg80211: make sure NAN chandefs are valid
Date: Wed,  7 Jan 2026 15:19:55 +0200
Message-Id: <20260107150057.da9b8cc63460.Iacb030fc17027afb55707ca1d6dc146631d55767@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
References: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Until now there was not handling for NAN in reg_wdev_chan_valid.
Now as this wdev might use chandefs, check the validity of those.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/reg.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 73cab51f6379..029499595bdf 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2350,6 +2350,18 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	if (!wdev->netdev || !netif_running(wdev->netdev))
 		return true;
 
+	/* NAN doesn't have links, handle it separately */
+	if (iftype == NL80211_IFTYPE_NAN) {
+		for (int i = 0; i < wdev->u.nan.n_channels; i++) {
+			ret = cfg80211_reg_can_beacon(wiphy,
+						      &wdev->u.nan.chandefs[i],
+						      NL80211_IFTYPE_NAN);
+			if (!ret)
+				return false;
+		}
+		return true;
+	}
+
 	for (link = 0; link < ARRAY_SIZE(wdev->links); link++) {
 		struct ieee80211_channel *chan;
 
@@ -2399,9 +2411,6 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 				continue;
 			chandef = wdev->u.ocb.chandef;
 			break;
-		case NL80211_IFTYPE_NAN:
-			/* we have no info, but NAN is also pretty universal */
-			continue;
 		default:
 			/* others not implemented for now */
 			WARN_ON_ONCE(1);
-- 
2.34.1



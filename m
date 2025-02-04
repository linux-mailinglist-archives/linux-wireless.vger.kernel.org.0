Return-Path: <linux-wireless+bounces-18447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36462A278D6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162AC1881B94
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D238F2165F0;
	Tue,  4 Feb 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNKmt3IC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCC21639B
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691008; cv=none; b=X7DXmpWUc0gY8OHd8c7sjAg2LCnkYzEEmnEF0i2EgXcS/oFsb4cptOR8ZyfnJ2NV5ygHZWo8bm7LGsalrDbOh0V9tITjt78i56SIjx3c1mIyDXRQyIqJTiZO1AgYY/X8Sqwg02mrVAulMlt1EBQ3uWuEFyeGnmv/W1qtMTjPDkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691008; c=relaxed/simple;
	bh=e3/mHnTAuXyZN/A9ohxIHcpjB3/hv4A7Iiq91DKrGTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b7Q4aNXbGrqzWnwhy9QZUwn26vwx5x5VtfMpYFMY5tTEZT0mPvt+lJsHA33ouTnMD1X0fVE3NpdTJ/DdGEOYhcF9ZehxwrSGX1MU3iEkqtTspfRc6FEvQjkvOjdJDC8u1IH0K6hHzMGZOnUPBcfHv75aSSpITqUCSbKT7tZggLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNKmt3IC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691007; x=1770227007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3/mHnTAuXyZN/A9ohxIHcpjB3/hv4A7Iiq91DKrGTw=;
  b=mNKmt3ICFuk05vXK68iTkNWx8fsC/0oJjVPgMcnStBCKmBJi3BRL8kn2
   zGdDVx5ODqgUltDPYnXaZ6En/ICn0KlV02Uw3D9P6HzHVD/koBZ8lA1jh
   oznupTORwq5XtfY3a5qDnavDH0hd0JDnc/p4ftFBVpy2AaPktVJrLH3y9
   C+D0vEnkAX7cEV1yiHIcpjNFs4qXmkGK+k9sTZtwwUk2E0p30q+sjrbRq
   TgyBPOqgzuWLwdhD1LagY5iwanl/Co/DAW002VFUT6fbmejN29wAwFCj9
   4OY1IemqqVKDEuyXVn+/fhTgxP2mcUlDzYqOZZQCH306ZeLFhaeAzjw2c
   A==;
X-CSE-ConnectionGUID: zq63VNyHRE+jZ9/GQuhrOw==
X-CSE-MsgGUID: XMH9wEa+Ta2h+TjvF/O9pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585414"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585414"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:49 -0800
X-CSE-ConnectionGUID: roiiktjpSty82MTXMc/67g==
X-CSE-MsgGUID: jpIYCsTrRrSTetY9+pgnOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696759"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/20] wifi: mac80211_hwsim: enable strict mode
Date: Tue,  4 Feb 2025 19:42:06 +0200
Message-Id: <20250204193721.a2c633d41edf.I61ec37d20fe97699d47fce252dc4ae2e4475fc51@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Since we use hwsim for testing e.g. the hostapd implementation,
enable strict mode to catch errors that would otherwise not be
caught.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index cf6a331d4042..d0d9dab7f11f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5345,6 +5345,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
 	ieee80211_hw_set(hw, TDLS_WIDER_BW);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
+	ieee80211_hw_set(hw, STRICT);
 
 	if (param->mlo) {
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
-- 
2.34.1



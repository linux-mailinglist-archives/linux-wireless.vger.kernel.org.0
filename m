Return-Path: <linux-wireless+bounces-20039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87894A57E5F
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C441E16D8BE
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390F1A3177;
	Sat,  8 Mar 2025 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHsG2yIX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147E19597F
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468027; cv=none; b=I1VTghIgfyqfZi8BkXq3JbQlsvfepIqbcQvczXpMJ+RHPB/481vuAPIzVvn2psDULjgcRJTJxJ0vIzUYLX+D1MwzOJZQPZYC6sTk7Xm3seoJhJq6jpKiTmTEkcPXt3/KFsRa4O08zTolnV8vmwpSIgsaXJoKQf2diXNtCohVDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468027; c=relaxed/simple;
	bh=qNu7cBgx21Jtj0k1YDhalz/PZF88UWia1kyMtsuxMy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JmBbYo5TumWnZeTLLj+nxztWRgopEJQ8GEnJWvK1UYgUtYbkzf1q0MjkavBNAVbiFlApwaQwnfpWKJbd9qTQ7uvzpv/D8eyR7K63LAOSv3tB/iO5CpArg9dqfRWt68r1gcF8S3wgvOxCwl9N+CP3eHR+ZrRLu8nqXjSAqTMuA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHsG2yIX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468026; x=1773004026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qNu7cBgx21Jtj0k1YDhalz/PZF88UWia1kyMtsuxMy0=;
  b=mHsG2yIX9rAM0Li8Gaku0k6f2FmSD8cLFDBQyr5PjIGBa+s/wYxxDtHN
   gzptywmiijBnmW8/R8tQtEqjDJVviJlGl9j5BmEcREJfMUYd06GH05lXh
   O5wFc3C9E7jK5E/ULDJBeHDHN8YaOknoo5u6rhO2WALsEYdcnFkjNki+G
   7F6WA3g45maA9jpFCYC9HGXwcSNMQnF/v1ERObrVkFSZrdG0EJX1wyIRZ
   WM7MDmfhBgrp6voYo9Ma67cw3MUZQ7gc6p5B10WTNUvu90Jerr1udTpt1
   j6k5JxL01Zr5umloHoznU0TqUdAJEp7rdF+sjB/8GJzwlcb69VPubXj3S
   w==;
X-CSE-ConnectionGUID: LBCeNhc/TrebL+hcTpJfPQ==
X-CSE-MsgGUID: ptCPo7t3Ra+m2Y6R4o1QsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413104"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413104"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:10 -0800
X-CSE-ConnectionGUID: IvjnFExGTr+wsHuZSfQbBA==
X-CSE-MsgGUID: N2PEQ6+DRcizglbOOUlzzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644406"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH RESEND wireless-next 10/15] wifi: mac80211: fix warning on disconnect during failed ML reconf
Date: Sat,  8 Mar 2025 23:03:36 +0200
Message-Id: <20250308225541.699bd9cbabe5.I599d5ff69092a65e916e2acd25137ae9df8debe8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If multi-link reconfiguration fails, we can disconnect with a local link
already allocated but the BSS entry not assigned yet, which leads to a
warning in cfg80211. Add a check to avoid the warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 85ae66197674..f3bf66d4ce6a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4466,7 +4466,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 			struct ieee80211_link_data *link;
 
 			link = sdata_dereference(sdata->link[link_id], sdata);
-			if (!link)
+			if (!link || !link->conf->bss)
 				continue;
 			cfg80211_unlink_bss(local->hw.wiphy, link->conf->bss);
 			link->conf->bss = NULL;
-- 
2.34.1


